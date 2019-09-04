Return-Path: <SRS0=tMFY=W7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 94CC6C3A5A9
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Sep 2019 08:35:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 797D721670
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Sep 2019 08:35:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728950AbfIDIff (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 4 Sep 2019 04:35:35 -0400
Received: from mga04.intel.com ([192.55.52.120]:38543 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725774AbfIDIff (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Sep 2019 04:35:35 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga104.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 04 Sep 2019 01:35:34 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.64,465,1559545200"; 
   d="scan'208";a="194654077"
Received: from shbuild999.sh.intel.com (HELO localhost) ([10.239.147.113])
  by orsmga002.jf.intel.com with ESMTP; 04 Sep 2019 01:35:32 -0700
Date:   Wed, 4 Sep 2019 16:35:58 +0800
From:   Feng Tang <feng.tang@intel.com>
To:     Daniel Vetter <daniel@ffwll.ch>
Cc:     Thomas Zimmermann <tzimmermann@suse.de>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Rong Chen <rong.a.chen@intel.com>,
        Michel =?utf-8?Q?D=C3=A4nzer?= <michel@daenzer.net>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        dri-devel <dri-devel@lists.freedesktop.org>, LKP <lkp@01.org>
Subject: Re: [LKP] [drm/mgag200] 90f479ae51: vm-scalability.median -18.8%
 regression
Message-ID: <20190904083558.GD5541@shbuild999.sh.intel.com>
References: <64d41701-55a4-e526-17ae-8936de4bc1ef@suse.de>
 <20190824051605.GA63850@shbuild999.sh.intel.com>
 <1b897bfe-fd40-3ae3-d867-424d1fc08c44@suse.de>
 <d114b0b6-6b64-406e-6c3f-a8b8d5502413@intel.com>
 <44029e80-ba00-8246-dec0-fda122d53f5e@suse.de>
 <90e78ce8-d46a-5154-c324-a05aa1743c98@intel.com>
 <2e1b4d65-d477-f571-845d-fa0a670859af@suse.de>
 <20190904062716.GC5541@shbuild999.sh.intel.com>
 <72c33bf1-9184-e24a-c084-26d9c8b6f9b7@suse.de>
 <CAKMK7uGdOtyDHZMSzY8J45bX57EFKo=DWNUi+WL+GVOzoBpUhw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAKMK7uGdOtyDHZMSzY8J45bX57EFKo=DWNUi+WL+GVOzoBpUhw@mail.gmail.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Daniel,

On Wed, Sep 04, 2019 at 10:11:11AM +0200, Daniel Vetter wrote:
> On Wed, Sep 4, 2019 at 8:53 AM Thomas Zimmermann <tzimmermann@suse.de> wrote:
> >
> > Hi
> >
> > Am 04.09.19 um 08:27 schrieb Feng Tang:
> > >> Thank you for testing. But don't get too excited, because the patch
> > >> simulates a bug that was present in the original mgag200 code. A
> > >> significant number of frames are simply skipped. That is apparently the
> > >> reason why it's faster.
> > >
> > > Thanks for the detailed info, so the original code skips time-consuming
> > > work inside atomic context on purpose. Is there any space to optmise it?
> > > If 2 scheduled update worker are handled at almost same time, can one be
> > > skipped?
> >
> > To my knowledge, there's only one instance of the worker. Re-scheduling
> > the worker before a previous instance started, will not create a second
> > instance. The worker's instance will complete all pending updates. So in
> > some way, skipping workers already happens.
> 
> So I think that the most often fbcon update from atomic context is the
> blinking cursor. If you disable that one you should be back to the old
> performance level I think, since just writing to dmesg is from process
> context, so shouldn't change.

Hmm, then for the old driver, it should also do the most update in
non-atomic context? 

One other thing is, I profiled that updating a 3MB shadow buffer needs
20 ms, which transfer to 150 MB/s bandwidth. Could it be related with
the cache setting of DRM shadow buffer? say the orginal code use a
cachable buffer?


> 
> https://unix.stackexchange.com/questions/3759/how-to-stop-cursor-from-blinking
> 
> Bunch of tricks, but tbh I haven't tested them.

Thomas has suggested to disable curson by
	echo 0 > /sys/devices/virtual/graphics/fbcon/cursor_blink

We tried that way, and no change for the performance data.

Thanks,
Feng

> 
> In any case, I still strongly advice you don't print anything to dmesg
> or fbcon while benchmarking, because dmesg/printf are anything but
> fast, especially if a gpu driver is involved. There's some efforts to
> make the dmesg/printk side less painful (untangling the console_lock
> from printk), but fundamentally printing to the gpu from the kernel
> through dmesg/fbcon won't be cheap. It's just not something we
> optimize beyond "make sure it works for emergencies".
> -Daniel
> 
> >
> > Best regards
> > Thomas
> >
> > >
> > > Thanks,
> > > Feng
> > >
> > >>
> > >> Best regards
> > >> Thomas
> > > _______________________________________________
> > > dri-devel mailing list
> > > dri-devel@lists.freedesktop.org
> > > https://lists.freedesktop.org/mailman/listinfo/dri-devel
> > >
> >
> > --
> > Thomas Zimmermann
> > Graphics Driver Developer
> > SUSE Linux GmbH, Maxfeldstrasse 5, 90409 Nuernberg, Germany
> > GF: Felix Imendörffer, Mary Higgins, Sri Rasiah
> > HRB 21284 (AG Nürnberg)
> >
> > _______________________________________________
> > dri-devel mailing list
> > dri-devel@lists.freedesktop.org
> > https://lists.freedesktop.org/mailman/listinfo/dri-devel
> 
> 
> 
> -- 
> Daniel Vetter
> Software Engineer, Intel Corporation
> +41 (0) 79 365 57 48 - http://blog.ffwll.ch
