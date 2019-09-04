Return-Path: <SRS0=tMFY=W7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BC399C3A5A7
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Sep 2019 11:20:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 754032186A
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Sep 2019 11:20:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ffwll.ch header.i=@ffwll.ch header.b="MsI3qMdj"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729669AbfIDLUm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 4 Sep 2019 07:20:42 -0400
Received: from mail-ot1-f68.google.com ([209.85.210.68]:39952 "EHLO
        mail-ot1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725840AbfIDLUm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Sep 2019 07:20:42 -0400
Received: by mail-ot1-f68.google.com with SMTP id y39so10164005ota.7
        for <linux-kernel@vger.kernel.org>; Wed, 04 Sep 2019 04:20:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=FFWJamEuvSUKAx3iY+IepxMBLdh2qd8tqi8QiGH8fUY=;
        b=MsI3qMdjqX4sXfGEfl7pXNkb0+MqR2dlVWz/uUGKDKROA+1rQ/pbCsx06rAd7RLMD7
         kDOT9dh0oSytQXnEcawdaldxiKMgPVSNocTZcN1xKhJfjQFq2u+4plh30CgRpWGTMGEN
         JrxkqIK8lAh239J8K2IoKG7oHvZbEey99YtKg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=FFWJamEuvSUKAx3iY+IepxMBLdh2qd8tqi8QiGH8fUY=;
        b=ukoMp+ZchZneTplN+BmlAQkVn8nriDXyPqELCnKdE73DgUjst8iKk/E3DCnXbdeSL/
         je6L7ATRCDA0ve18O0Wu+WDyavXEEP2q1qvegJUQktuudk7SM0Y8BP2RJEpn5EajsdKk
         iRsZBef5C9kGdeSQoMWnX6R3qXmVQ4YclTwuphFzpOBNkDAb7a8XVe2rgmmgS2cP2NLF
         rqoq8+wttciw3ZUhqDWmYbYXq4n9Za3t7FKC3fUZkohvA6QpZjr15QN8YMkwp14mkFuo
         canjfZpxy5wxrOS5+PUZdQWw4SWgYPPAzWyRnDaa7A2E7wXMZqOcvYRvIYImwScJtmQL
         pFTg==
X-Gm-Message-State: APjAAAVVHSJDSMDzpW2I1si6ZnEpMCFWeRTayHFoSnNCBh3+uSH+qJvX
        Gj05CEAPzcFUMcVmQSMyouQSZ4KwOWDJL2gzF7CuOQ==
X-Google-Smtp-Source: APXvYqwVDRhU7kZmIkZ5qqDVDgi3WFH9khsOheDFHWeC0GZ33Wx8RDhjMj1WP/4E755AtDXu+hW4MzsL3zn2SguLz0I=
X-Received: by 2002:a9d:6955:: with SMTP id p21mr29133390oto.204.1567596041257;
 Wed, 04 Sep 2019 04:20:41 -0700 (PDT)
MIME-Version: 1.0
References: <64d41701-55a4-e526-17ae-8936de4bc1ef@suse.de> <20190824051605.GA63850@shbuild999.sh.intel.com>
 <1b897bfe-fd40-3ae3-d867-424d1fc08c44@suse.de> <d114b0b6-6b64-406e-6c3f-a8b8d5502413@intel.com>
 <44029e80-ba00-8246-dec0-fda122d53f5e@suse.de> <90e78ce8-d46a-5154-c324-a05aa1743c98@intel.com>
 <2e1b4d65-d477-f571-845d-fa0a670859af@suse.de> <20190904062716.GC5541@shbuild999.sh.intel.com>
 <72c33bf1-9184-e24a-c084-26d9c8b6f9b7@suse.de> <CAKMK7uGdOtyDHZMSzY8J45bX57EFKo=DWNUi+WL+GVOzoBpUhw@mail.gmail.com>
 <20190904083558.GD5541@shbuild999.sh.intel.com> <CAKMK7uGVKEN=pi4Erc_gtbL3ZFN-b6pm-nXSznjd_rH4H2yn4w@mail.gmail.com>
 <CAPM=9tzDMfRf_VKaiHmnb_KKVwqW3=y=09JO0SJrG6ySe=DbfQ@mail.gmail.com>
In-Reply-To: <CAPM=9tzDMfRf_VKaiHmnb_KKVwqW3=y=09JO0SJrG6ySe=DbfQ@mail.gmail.com>
From:   Daniel Vetter <daniel@ffwll.ch>
Date:   Wed, 4 Sep 2019 13:20:29 +0200
Message-ID: <CAKMK7uGtNu0M74+Ag5-7HJhuHDVv1HoMPz=2XjU6tCkfMScQnA@mail.gmail.com>
Subject: Re: [LKP] [drm/mgag200] 90f479ae51: vm-scalability.median -18.8% regression
To:     Dave Airlie <airlied@gmail.com>
Cc:     Feng Tang <feng.tang@intel.com>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Rong Chen <rong.a.chen@intel.com>,
        =?UTF-8?Q?Michel_D=C3=A4nzer?= <michel@daenzer.net>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        Thomas Zimmermann <tzimmermann@suse.de>, LKP <lkp@01.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 4, 2019 at 1:15 PM Dave Airlie <airlied@gmail.com> wrote:
>
> On Wed, 4 Sep 2019 at 19:17, Daniel Vetter <daniel@ffwll.ch> wrote:
> >
> > On Wed, Sep 4, 2019 at 10:35 AM Feng Tang <feng.tang@intel.com> wrote:
> > >
> > > Hi Daniel,
> > >
> > > On Wed, Sep 04, 2019 at 10:11:11AM +0200, Daniel Vetter wrote:
> > > > On Wed, Sep 4, 2019 at 8:53 AM Thomas Zimmermann <tzimmermann@suse.de> wrote:
> > > > >
> > > > > Hi
> > > > >
> > > > > Am 04.09.19 um 08:27 schrieb Feng Tang:
> > > > > >> Thank you for testing. But don't get too excited, because the patch
> > > > > >> simulates a bug that was present in the original mgag200 code. A
> > > > > >> significant number of frames are simply skipped. That is apparently the
> > > > > >> reason why it's faster.
> > > > > >
> > > > > > Thanks for the detailed info, so the original code skips time-consuming
> > > > > > work inside atomic context on purpose. Is there any space to optmise it?
> > > > > > If 2 scheduled update worker are handled at almost same time, can one be
> > > > > > skipped?
> > > > >
> > > > > To my knowledge, there's only one instance of the worker. Re-scheduling
> > > > > the worker before a previous instance started, will not create a second
> > > > > instance. The worker's instance will complete all pending updates. So in
> > > > > some way, skipping workers already happens.
> > > >
> > > > So I think that the most often fbcon update from atomic context is the
> > > > blinking cursor. If you disable that one you should be back to the old
> > > > performance level I think, since just writing to dmesg is from process
> > > > context, so shouldn't change.
> > >
> > > Hmm, then for the old driver, it should also do the most update in
> > > non-atomic context?
> > >
> > > One other thing is, I profiled that updating a 3MB shadow buffer needs
> > > 20 ms, which transfer to 150 MB/s bandwidth. Could it be related with
> > > the cache setting of DRM shadow buffer? say the orginal code use a
> > > cachable buffer?
> >
> > Hm, that would indicate the write-combining got broken somewhere. This
> > should definitely be faster. Also we shouldn't transfer the hole
> > thing, except when scrolling ...
>
> First rule of fbcon usage, you are always effectively scrolling.
>
> Also these devices might be on a PCIE 1x piece of wet string, not sure
> if the numbers reflect that.

pcie 1x 1.0 is 250MB/s, so yeah with a bit of inefficiency and
overhead not entirely out of the question that 150MB/s is actually the
hw limit. If it's really pcie 1x 1.0, no idea where to check that.
Also might be worth to double-check that the gpu pci bar is listed as
wc in debugfs/x86/pat_memtype_list.
-Daniel
-- 
Daniel Vetter
Software Engineer, Intel Corporation
+41 (0) 79 365 57 48 - http://blog.ffwll.ch
