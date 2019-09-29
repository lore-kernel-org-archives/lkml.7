Return-Path: <SRS0=maO4=XY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_2 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 83876C4360C
	for <linux-kernel@archiver.kernel.org>; Sun, 29 Sep 2019 21:16:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5A06E21835
	for <linux-kernel@archiver.kernel.org>; Sun, 29 Sep 2019 21:16:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729142AbfI2VQa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 29 Sep 2019 17:16:30 -0400
Received: from mail.kernel.org ([198.145.29.99]:34032 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726390AbfI2VQa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 29 Sep 2019 17:16:30 -0400
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0D61E217F5;
        Sun, 29 Sep 2019 21:16:28 +0000 (UTC)
Date:   Sun, 29 Sep 2019 17:16:27 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Alexey Dobriyan <adobriyan@gmail.com>
Cc:     akpm@linux-foundation.org, linux-kernel@vger.kernel.org,
        jani.nikula@linux.intel.com, joonas.lahtinen@linux.intel.com,
        rodrigo.vivi@intel.com, intel-gfx@lists.freedesktop.org,
        mingo@redhat.com, linux@rasmusvillemoes.dk
Subject: Re: [PATCH] Make is_signed_type() simpler
Message-ID: <20190929171627.1b854409@gandalf.local.home>
In-Reply-To: <20190929204424.GA14565@avx2>
References: <20190929200619.GA12851@avx2>
        <20190929161531.727da348@gandalf.local.home>
        <20190929204424.GA14565@avx2>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 29 Sep 2019 23:44:24 +0300
Alexey Dobriyan <adobriyan@gmail.com> wrote:

> On Sun, Sep 29, 2019 at 04:15:31PM -0400, Steven Rostedt wrote:
> > On Sun, 29 Sep 2019 23:06:19 +0300
> > Alexey Dobriyan <adobriyan@gmail.com> wrote:
> >   
> > > * Simply compare -1 with 0,
> > > * Drop unnecessary parenthesis sets
> > > 
> > > New macro leaves pointer as "unsigned type" but gives a warning,
> > > which should be fine because asking whether a pointer is signed is
> > > strange question.
> > > 
> > > I'm not sure what's going on in the i915 driver, it is shipping kernel
> > > pointers to userspace.  
> > 
> > This tells us what the patch does, not why.  
> 
> Check the subject line.

I don't see how it's simpler.

-#define is_signed_type(type)	(((type)(-1)) < (type)1)
+#define is_signed_type(type)	((type)-1 < 0)
 

Requires more rational that "make it simpler". Rewriting futex or tty
layer code would be something I would love to see, but just replacing
"(type)1" with "0" isn't worth the churn.

-- Steve
