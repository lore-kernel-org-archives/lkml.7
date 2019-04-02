Return-Path: <SRS0=bo2+=SE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 78DD6C10F0B
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Apr 2019 19:26:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 447E120857
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Apr 2019 19:26:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1554233205;
	bh=r3X5FTDxb4GyNp3973uKtlsfjvGrHNyxS5BiOhIUKhc=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=pvcXGJzeIJ5ULWzStRoFHDkEH0L2dA1rsMiD+qZ6mLWEegG06v6sNVr/x4HJok/2d
	 ze0mvf+KOnNf8oIPsX/1qPMv1sCVmaThWrPal3CEzoKt13J+l/efmWqC3bBVaEoaVk
	 4Na3/yY4UleXR+faY3z7ckZMejFqGtmCdR33iUs8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730927AbfDBT0o (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Apr 2019 15:26:44 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:42220 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726732AbfDBT0n (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Apr 2019 15:26:43 -0400
Received: from akpm3.svl.corp.google.com (unknown [104.133.8.65])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 1689CEA2;
        Tue,  2 Apr 2019 19:26:42 +0000 (UTC)
Date:   Tue, 2 Apr 2019 12:26:41 -0700
From:   Andrew Morton <akpm@linux-foundation.org>
To:     "Uladzislau Rezki (Sony)" <urezki@gmail.com>
Cc:     Roman Gushchin <guro@fb.com>, Michal Hocko <mhocko@suse.com>,
        Matthew Wilcox <willy@infradead.org>, linux-mm@kvack.org,
        LKML <linux-kernel@vger.kernel.org>,
        Thomas Garnier <thgarnie@google.com>,
        Oleksiy Avramchenko <oleksiy.avramchenko@sonymobile.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Joel Fernandes <joelaf@google.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@elte.hu>, Tejun Heo <tj@kernel.org>,
        <rong.a.chen@intel.com>
Subject: Re: [RESEND PATCH 0/3] improve vmap allocation
Message-Id: <20190402122641.d4c8b7cbc6409ad14c13f3aa@linux-foundation.org>
In-Reply-To: <20190402162531.10888-1-urezki@gmail.com>
References: <20190402162531.10888-1-urezki@gmail.com>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue,  2 Apr 2019 18:25:28 +0200 "Uladzislau Rezki (Sony)" <urezki@gmail.com> wrote:

> Changes in v3
> -------------
> - simplify the __get_va_next_sibling() and __find_va_links() functions;
> - remove "unlikely". Place the WARN_ON_ONCE directly to the "if" condition;
> - replace inline to __always_inline;
> - move the debug code to separate patches;

Does v3 address the report from kernel test robot
<rong.a.chen@intel.com>, Subject "[mm/vmalloc.c] 7ae76449bd:
kernel_BUG_at_lib/list_debug.c".

For some reason I cannot find that email in my linux-kernel folder and
nor does google find it and
http://lkml.kernel.org/r/20190401132655.GD9217@shao2-debian doesn't
work.  Message-ID 20190401132655.GD9217@shao2-debian doesn't seem to
have got through the list server.  Ditto linux-mm.

