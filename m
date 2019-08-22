Return-Path: <SRS0=/WLL=WS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 50ED5C3A5A1
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Aug 2019 20:03:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1CC5D205ED
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Aug 2019 20:03:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="L+J0jw74"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392436AbfHVUDO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 22 Aug 2019 16:03:14 -0400
Received: from mail-lf1-f65.google.com ([209.85.167.65]:36264 "EHLO
        mail-lf1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389415AbfHVUDN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Aug 2019 16:03:13 -0400
Received: by mail-lf1-f65.google.com with SMTP id j17so5434924lfp.3
        for <linux-kernel@vger.kernel.org>; Thu, 22 Aug 2019 13:03:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=8BL6cXi6kmquC//tEDRxbHmDzYl3D4X2KwrWFAtyUbo=;
        b=L+J0jw74rzPlJ5rUcp3hfdUw72E0cFHz4B0Zt4j+ug0Lzq4mee1klH7LUfCS34fGcJ
         4kbhybS3AaCCfkRLdSvd227te6vWk+BvFnsq7irW+bxuHY9dviaPhzUh22XtWCOI8F+f
         +JVotM2uMONkC/ItZ2oBRxM0rT1VyDUWLff+g7QAcFd1ujFOogO/f14Cic/SYtZfSOZQ
         6yo7I0mHZnv+FhroC3/xU3RoyQXnCFZd5D6CSL1LmuNKhCH3Ray7pXZ2Nk+r3sHiILVr
         33X1ae9pS55Jk8JV3YllIyvkXcn319M5aR7zHjAYuHLJHNUku3h53U1UsOmKfmNhtR2v
         nSfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=8BL6cXi6kmquC//tEDRxbHmDzYl3D4X2KwrWFAtyUbo=;
        b=exrz2KcndbLsymilrXsfMvi/qMW4nCCto3L5XBbk14EKslpCu4i+KnP9NDkYwXAArc
         uTF4ukgmY7ONy4xV6Xp3Ka8DatOpDAkzjEr4ocBMMYB9zSdIk6snApxiSCJFFzdcJ+ai
         flI7paDlhDGarBPnRsFBogd2hOhGJ8OWWAVdF2g/5JitApC88hhM6nnZvaUQXUs3gxBv
         bt3Jz//MF8grT+ImE5aY0nXAj7+lZZrgLKSx4CggDkeQK9qidTI7vDNXV3wxduG06S5z
         L1Iwu4BcaH7sIlNXvpRYwOc4o0ie5VJN0Ix3yqPf0g29g8vnUUWX0uxb40QwhAiWlJHD
         23mg==
X-Gm-Message-State: APjAAAUcaBo4WyDNJl485eKr3oZbmX+hu7DCh9HjITfAkhGHC/5BOuZS
        Anm8alZMNQog8YqOxYeX67b6HPQobHDV3issin0=
X-Google-Smtp-Source: APXvYqyC3WDdSPVZ6qNtk720WzSxZ4/fd0UnMq/iblygQ0tHGlxaCJ/2waC/QgLudzBysoCELVdNSGdMiH3o+xywLf0=
X-Received: by 2002:ac2:4c12:: with SMTP id t18mr514885lfq.134.1566504190777;
 Thu, 22 Aug 2019 13:03:10 -0700 (PDT)
MIME-Version: 1.0
References: <20190729095155.GP22106@shao2-debian> <1c0bf22b-2c69-6b45-f700-ed832a3a5c17@suse.de>
 <14fdaaed-51c8-b270-b46b-cba7b5c4ba52@suse.de> <20190805070200.GA91650@shbuild999.sh.intel.com>
 <c0c3f387-dc93-3146-788c-23258b28a015@intel.com> <045a23ab-78f7-f363-4a2e-bf24a7a2f79e@suse.de>
 <37ae41e4-455d-c18d-5c93-7df854abfef9@intel.com> <370747ca-4dc9-917b-096c-891dcc2aedf0@suse.de>
 <c6e220fe-230c-265c-f2fc-b0948d1cb898@intel.com> <20190812072545.GA63191@shbuild999.sh.intel.com>
 <20190813093616.GA65475@shbuild999.sh.intel.com> <64d41701-55a4-e526-17ae-8936de4bc1ef@suse.de>
In-Reply-To: <64d41701-55a4-e526-17ae-8936de4bc1ef@suse.de>
From:   Dave Airlie <airlied@gmail.com>
Date:   Fri, 23 Aug 2019 06:02:58 +1000
Message-ID: <CAPM=9twNdYZCbyByLqZPpcK+ifoeL0weXppqzLyZEOn7GPAV_Q@mail.gmail.com>
Subject: Re: [LKP] [drm/mgag200] 90f479ae51: vm-scalability.median -18.8% regression
To:     Thomas Zimmermann <tzimmermann@suse.de>
Cc:     Feng Tang <feng.tang@intel.com>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Rong Chen <rong.a.chen@intel.com>,
        =?UTF-8?Q?Michel_D=C3=A4nzer?= <michel@daenzer.net>,
        LKML <linux-kernel@vger.kernel.org>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        ying.huang@intel.com, LKP <lkp@01.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 23 Aug 2019 at 03:25, Thomas Zimmermann <tzimmermann@suse.de> wrote:
>
> Hi
>
> I was traveling and could reply earlier. Sorry for taking so long.
>
> Am 13.08.19 um 11:36 schrieb Feng Tang:
> > Hi Thomas,
> >
> > On Mon, Aug 12, 2019 at 03:25:45PM +0800, Feng Tang wrote:
> >> Hi Thomas,
> >>
> >> On Fri, Aug 09, 2019 at 04:12:29PM +0800, Rong Chen wrote:
> >>> Hi,
> >>>
> >>>>> Actually we run the benchmark as a background process, do we need to
> >>>>> disable the cursor and test again?
> >>>> There's a worker thread that updates the display from the shadow buffer.
> >>>> The blinking cursor periodically triggers the worker thread, but the
> >>>> actual update is just the size of one character.
> >>>>
> >>>> The point of the test without output is to see if the regression comes
> >>> >from the buffer update (i.e., the memcpy from shadow buffer to VRAM), or
> >>> >from the worker thread. If the regression goes away after disabling the
> >>>> blinking cursor, then the worker thread is the problem. If it already
> >>>> goes away if there's simply no output from the test, the screen update
> >>>> is the problem. On my machine I have to disable the blinking cursor, so
> >>>> I think the worker causes the performance drop.
> >>>
> >>> We disabled redirecting stdout/stderr to /dev/kmsg,  and the regression is
> >>> gone.
> >>>
> >>> commit:
> >>>   f1f8555dfb9 drm/bochs: Use shadow buffer for bochs framebuffer console
> >>>   90f479ae51a drm/mgag200: Replace struct mga_fbdev with generic framebuffer
> >>> emulation
> >>>
> >>> f1f8555dfb9a70a2  90f479ae51afa45efab97afdde testcase/testparams/testbox
> >>> ----------------  -------------------------- ---------------------------
> >>>          %stddev      change         %stddev
> >>>              \          |                \
> >>>      43785                       44481
> >>> vm-scalability/300s-8T-anon-cow-seq-hugetlb/lkp-knm01
> >>>      43785                       44481        GEO-MEAN vm-scalability.median
> >>
> >> Till now, from Rong's tests:
> >> 1. Disabling cursor blinking doesn't cure the regression.
> >> 2. Disabling printint test results to console can workaround the
> >> regression.
> >>
> >> Also if we set the perfer_shadown to 0, the regression is also
> >> gone.
> >
> > We also did some further break down for the time consumed by the
> > new code.
> >
> > The drm_fb_helper_dirty_work() calls sequentially
> > 1. drm_client_buffer_vmap       (290 us)
> > 2. drm_fb_helper_dirty_blit_real  (19240 us)
> > 3. helper->fb->funcs->dirty()    ---> NULL for mgag200 driver
> > 4. drm_client_buffer_vunmap       (215 us)
> >
>
> It's somewhat different to what I observed, but maybe I just couldn't
> reproduce the problem correctly.
>
> > The average run time is listed after the function names.
> >
> > From it, we can see drm_fb_helper_dirty_blit_real() takes too long
> > time (about 20ms for each run). I guess this is the root cause
> > of this regression, as the original code doesn't use this dirty worker.
>
> True, the original code uses a temporary buffer, but updates the display
> immediately.
>
> My guess is that this could be a caching problem. The worker runs on a
> different CPU, which doesn't have the shadow buffer in cache.
>
> > As said in last email, setting the prefer_shadow to 0 can avoid
> > the regrssion. Could it be an option?
>
> Unfortunately not. Without the shadow buffer, the console's display
> buffer permanently resides in video memory. It consumes significant
> amount of that memory (say 8 MiB out of 16 MiB). That doesn't leave
> enough room for anything else.
>
> The best option is to not print to the console.

Wait a second, I thought the driver did an eviction on modeset of the
scanned out object, this was a deliberate design decision made when
writing those drivers, has this been removed in favour of gem and
generic code paths?

Dave.
