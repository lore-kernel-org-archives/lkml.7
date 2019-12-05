Return-Path: <SRS0=yQuH=Z3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 29E65C43603
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Dec 2019 16:45:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ED5CF22525
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Dec 2019 16:45:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="A18pMSgT"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729788AbfLEQpf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 5 Dec 2019 11:45:35 -0500
Received: from mail-qk1-f193.google.com ([209.85.222.193]:39452 "EHLO
        mail-qk1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726028AbfLEQpe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Dec 2019 11:45:34 -0500
Received: by mail-qk1-f193.google.com with SMTP id d124so3889476qke.6
        for <linux-kernel@vger.kernel.org>; Thu, 05 Dec 2019 08:45:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=VBet/bIZobzEfIAUk75Ti4RAy8XooAiOYVqu+hnKHI4=;
        b=A18pMSgTuR1kAVWLezvNQ+EC+Hs0uA80wcQbNijo7N4Ix/7a1tU7cm7N2rQTw4+UIh
         4iu9LwCetkxoehhPs7t16hTAq9W521UwYRXB7Oghj57ECN6X9Vm4oW/V/63y5P7TFOca
         cdCKN1/ogTkKEMpDrbuQ1kfOdnt/uuSZ8+H6wxmmDpUO4ZHIpj7/dB3e7eA5Er0Rw9i/
         Kri3ArIiSLagbh3J+2/x26uyTcnlse9wn8f2gKYoWac2Geb3AZL7OqZQIag7zXzGzLaH
         jBZY5/CBTf3qF62jLSljdr+O2kMFLf/+AQ4JBm8+zGkBKIQOYwgN538tjP+91dB3/rdY
         nHBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=VBet/bIZobzEfIAUk75Ti4RAy8XooAiOYVqu+hnKHI4=;
        b=I3+MNKmvrWaH993mGVqN+2MAsqq2ZjOjuwMCM5rIA31oHU2ej366p23viYh8lrORRH
         xwuNwBxThr94umEhQS0jg8db1XwRTHRJzLLPPkYI+Wv3ZU5/VnW4wWB93LHa2Fsx9k8J
         CCQvkOPWxTudSfDKuuv3X9upeNfqQM0u64qj1NpJm58pjzhqmbwen/k1BTLj4aScrHEp
         /eUZRyTfNA5neAJJFgy5AqkwI6Nxr58sUux5JfgTPsF3c0ALVpZiKFT0if1hZymHB7Kw
         oWvs6bN7GWR9H2SQeI95tFafPQnBof8Nb1/4MODnc+eM5h9/Shp3ihJAp/eJqxEZ8Eam
         LrXA==
X-Gm-Message-State: APjAAAWcUCD6XO2ROFENkMhWfh2xH4MhNRHwvCsYssbyEStZkuU4+CEm
        oUmXdaimV7boDGSJpWd/4Z9YfGKCTPzTAfrRVpebVw==
X-Google-Smtp-Source: APXvYqwerl8XImN73VXaOFe2fMFNwgUDm+1VNfq91ocV1c1p8hyv/IzbQRvKMuNsJzHUygG2fax8WM/w50U/rYGR52g=
X-Received: by 2002:a37:4782:: with SMTP id u124mr9350911qka.8.1575564333504;
 Thu, 05 Dec 2019 08:45:33 -0800 (PST)
MIME-Version: 1.0
References: <0000000000006dff110598d25a9b@google.com> <000000000000bcf3bc0598f5090d@google.com>
 <CAKMK7uF4AR_tRxt5wBKxzz6gTPJmub3A=xyuh1HjgvfYy7RCBg@mail.gmail.com>
In-Reply-To: <CAKMK7uF4AR_tRxt5wBKxzz6gTPJmub3A=xyuh1HjgvfYy7RCBg@mail.gmail.com>
From:   Dmitry Vyukov <dvyukov@google.com>
Date:   Thu, 5 Dec 2019 17:45:22 +0100
Message-ID: <CACT4Y+ZjQSvpZAnLkp6w8erqtraZGkXB2O84BFmcRN_Rm6fs3Q@mail.gmail.com>
Subject: Re: INFO: task hung in fb_open
To:     Daniel Vetter <daniel.vetter@ffwll.ch>
Cc:     syzbot <syzbot+a4ae1442ccc637162dc1@syzkaller.appspotmail.com>,
        Dave Airlie <airlied@linux.ie>,
        Ayan Kumar Halder <ayan.halder@arm.com>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        Gerd Hoffmann <kraxel@redhat.com>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Linux Fbdev development list <linux-fbdev@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        Peter Rosin <peda@axentia.se>, Sam Ravnborg <sam@ravnborg.org>,
        syzkaller-bugs <syzkaller-bugs@googlegroups.com>,
        "Syrjala, Ville" <ville.syrjala@linux.intel.com>,
        Chen-Yu Tsai <wens@csie.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 5, 2019 at 3:05 PM Daniel Vetter <daniel.vetter@ffwll.ch> wrote:
>
> On Thu, Dec 5, 2019 at 2:38 PM syzbot
> <syzbot+a4ae1442ccc637162dc1@syzkaller.appspotmail.com> wrote:
> >
> > syzbot has bisected this bug to:
> >
> > commit 979c11ef39cee79d6f556091a357890962be2580
> > Author: Ayan Kumar Halder <ayan.halder@arm.com>
> > Date:   Tue Jul 17 17:13:46 2018 +0000
> >
> >      drm/sun4i: Substitute sun4i_backend_format_is_yuv() with format->is_yuv
>
> Pretty sure your GCD machine is not using the sun4i driver. It's also
> very far away from the code that's blowing up. bisect gone wrong?
> -Daniel

Yes, this driver is not even enabled in the config.
I see 2 issues with kernel in the bisect log:
1. Unrelated machine hangs get in the way of bisection process (or
that "no output" another manifestation of this bug?).
2. Somehow this change to not compiled file changed vmlinux thus
detection of unrelated changes failed. Non-deterministic kernel builds
issue is tracked here:
https://github.com/google/syzkaller/issues/1271#issuecomment-559093018
but so far I don't have any glues/ideas.


> > bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=15d2f97ee00000
> > start commit:   596cf45c Merge branch 'akpm' (patches from Andrew)
> > git tree:       upstream
> > console output: https://syzkaller.appspot.com/x/log.txt?x=13d2f97ee00000
> > kernel config:  https://syzkaller.appspot.com/x/.config?x=7d8ab2e0e09c2a82
> > dashboard link: https://syzkaller.appspot.com/bug?extid=a4ae1442ccc637162dc1
> > syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=14273edae00000
> > C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=15e7677ae00000
> >
> > Reported-by: syzbot+a4ae1442ccc637162dc1@syzkaller.appspotmail.com
> > Fixes: 979c11ef39ce ("drm/sun4i: Substitute sun4i_backend_format_is_yuv()
> > with format->is_yuv")
> >
> > For information about bisection process see: https://goo.gl/tpsmEJ#bisection
>
>
>
> --
> Daniel Vetter
> Software Engineer, Intel Corporation
> +41 (0) 79 365 57 48 - http://blog.ffwll.ch
>
> --
> You received this message because you are subscribed to the Google Groups "syzkaller-bugs" group.
> To unsubscribe from this group and stop receiving emails from it, send an email to syzkaller-bugs+unsubscribe@googlegroups.com.
> To view this discussion on the web visit https://groups.google.com/d/msgid/syzkaller-bugs/CAKMK7uF4AR_tRxt5wBKxzz6gTPJmub3A%3Dxyuh1HjgvfYy7RCBg%40mail.gmail.com.
