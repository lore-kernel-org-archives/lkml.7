Return-Path: <SRS0=/BZh=RY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 35E52C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Mar 2019 22:01:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 01BF821917
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Mar 2019 22:01:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1553205673;
	bh=RqktEUR9yOk0zLZRmahdS+ZsEoiSeEPg4KuUwJHc2WY=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=1OCKbJ+VCoPPvpzENPDor89kuZTFdG/k1ee/tpFhaWN9Pk5vf5IUSb/els8UrqtdH
	 GBSLDVP5PkUiOEPdJVSMK9sI4hSLTEBGaGoj85jnz7ygYeUk36ALvQD01UO8NZWwb/
	 xQMzbQHNXUCeIyuzIzyr1jtexqQH/i9pAAvVkCCw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727526AbfCUWBL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Mar 2019 18:01:11 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:54010 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727210AbfCUWBJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Mar 2019 18:01:09 -0400
Received: from localhost.localdomain (c-73-223-200-170.hsd1.ca.comcast.net [73.223.200.170])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 9F11EEF1;
        Thu, 21 Mar 2019 22:01:07 +0000 (UTC)
Date:   Thu, 21 Mar 2019 15:01:06 -0700
From:   Andrew Morton <akpm@linux-foundation.org>
To:     "Uladzislau Rezki (Sony)" <urezki@gmail.com>
Cc:     Michal Hocko <mhocko@suse.com>,
        Matthew Wilcox <willy@infradead.org>, linux-mm@kvack.org,
        LKML <linux-kernel@vger.kernel.org>,
        Thomas Garnier <thgarnie@google.com>,
        Oleksiy Avramchenko <oleksiy.avramchenko@sonymobile.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Joel Fernandes <joelaf@google.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@elte.hu>, Tejun Heo <tj@kernel.org>
Subject: Re: [RFC PATCH v2 0/1] improve vmap allocation
Message-Id: <20190321150106.198f70e1e949e2cb8cc06f1c@linux-foundation.org>
In-Reply-To: <20190321190327.11813-1-urezki@gmail.com>
References: <20190321190327.11813-1-urezki@gmail.com>
X-Mailer: Sylpheed 3.5.1 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 21 Mar 2019 20:03:26 +0100 "Uladzislau Rezki (Sony)" <urezki@gmail.com> wrote:

> Hello.
> 
> This is the v2 of the https://lkml.org/lkml/2018/10/19/786 rework. Instead of
> referring you to that link, i will go through it again describing the improved
> allocation method and provide changes between v1 and v2 in the end.
> 
> ...
>

> Performance analysis
> --------------------

Impressive numbers.  But this is presumably a worst-case microbenchmark.

Are you able to describe the benefits which are observed in some
real-world workload which someone cares about?

It's a lot of new code. I t looks decent and I'll toss it in there for
further testing.  Hopefully someone will be able to find the time for a
detailed review.

Trivial point: the code uses "inline" a lot.  Nowadays gcc cheerfully
ignores that and does its own thing.  You might want to look at the
effects of simply deleting all that.  Is the generated code better or
worse or the same?  If something really needs to be inlined then use
__always_inline, preferably with a comment explaining why it is there.

