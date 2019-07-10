Return-Path: <SRS0=5O2B=VH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_2 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4A096C74A2B
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Jul 2019 15:59:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1B9DE2064A
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Jul 2019 15:59:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728358AbfGJP7u convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 10 Jul 2019 11:59:50 -0400
Received: from mail.kernel.org ([198.145.29.99]:39328 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727966AbfGJP7u (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Jul 2019 11:59:50 -0400
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E141D2087F;
        Wed, 10 Jul 2019 15:59:48 +0000 (UTC)
Date:   Wed, 10 Jul 2019 11:59:47 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Ville =?UTF-8?B?U3lyasOkbMOk?= <ville.syrjala@linux.intel.com>
Cc:     Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        intel-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: Need to remove char pointers from trace events
Message-ID: <20190710115947.1de86184@gandalf.local.home>
In-Reply-To: <20190710154524.GG5942@intel.com>
References: <20190710112549.0366bb03@gandalf.local.home>
        <20190710154524.GG5942@intel.com>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 10 Jul 2019 18:45:24 +0300
Ville Syrjälä <ville.syrjala@linux.intel.com> wrote:

> > 	    TP_printk("pipe %c, plane %s, frame=%u, scanline=%u",
> > 		      pipe_name(__entry->pipe), __entry->name,
> > 		      __entry->frame, __entry->scanline)
> > 
> > 
> > The issue here is that you record a pointer address to "plane->name"
> > and then sometime in the distant future access that same address.
> > There's usually no guarantee that the contents at that address will
> > exist when the buffer is read.  
> 
> The only way those can disappear is if the device goes away. But I have
> no problem going with your patch. Want to provide a proper commit message
> for it?

Sure, but does that mean the trace data will go away with the device?
If not, then you still have the issue.

Also note that perf and trace-cmd will not know how to read that data
either, so adding it to the ring buffer gives them access.

I'll send a patch next, thanks!

-- Steve

> 
> > 
> > The proper way to record strings, is to record the string into the ring
> > buffer itself, and not rely on it existing hours or days later.
> > 
