Return-Path: <SRS0=vU+5=XP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 897AEC49ED7
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Sep 2019 09:36:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 57015207FC
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Sep 2019 09:36:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1568972162;
	bh=QX1X4YX4/Vp+dV8LPaetmKVvcHUG5G4O1YluAd/eVx4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=Sx+JmKLYjCKGzx7eUTSkIg/O/cQ+Ytj5MrFzeukf2D+w3AcCbIZIFtNPaGcHkrqr7
	 oMoGzOTcSo30ljVeDlls3/qIYMuWxVZ76rFNmNctIdBfloaacLlKrfX/4VaAd/3Gos
	 6/U1xipEVSp+p+AwZvdSdLotUvtx/EKvT+c6c61Y=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2408464AbfITJgB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 20 Sep 2019 05:36:01 -0400
Received: from mail-lj1-f194.google.com ([209.85.208.194]:45964 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2405989AbfITJgB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Sep 2019 05:36:01 -0400
Received: by mail-lj1-f194.google.com with SMTP id q64so6374723ljb.12;
        Fri, 20 Sep 2019 02:35:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=f++tt9AEak4ryHyla1VUZBcvqIIpAYie6ToiqQj2rhI=;
        b=NmMFDZVW7dxATF6wDoGTws1qgHH3IiGZea2NY2AfJgRUlmH9xF5OHO0TPY4Bze6XJs
         guo8WbFEHzMePVvOdtbsMXtwJlMitT33dKDtUlDTvgrKKHhmZhdx1e16MWtCDNaQovO+
         wxXg2xBx0d8+S1EWxxK/nl4HMmZC/aXxJKAtuRPAmgyFz+IjQUXbUuzMXLPwMNHUOfLo
         +6adYMoDGxkMe2FduDgvegwirMSMPrHgwuICFwoM++TLrHBTcaIUZF2myrPmbsEq65A+
         GU08YODa/c/RCPORW3MG9O2V3m26B/scA3tN2yZvjCphLd0AYHqWXiVWN7hPMlVVNRQD
         jrRg==
X-Gm-Message-State: APjAAAV0eLIlHE2W9OpiD0uQb/rDxT2EDAZqidTWGElpIzRX1PTxDVN7
        UxPt1K/txluPbPh2QsE2lxA=
X-Google-Smtp-Source: APXvYqw2V+eNv9qC04jKLl4ertFGoOFfyP/MSNU/tAS4zqRrYUAemKy51MfMQLrCcm9GUyfZtM0ewA==
X-Received: by 2002:a2e:9dc9:: with SMTP id x9mr8500901ljj.147.1568972158714;
        Fri, 20 Sep 2019 02:35:58 -0700 (PDT)
Received: from xi.terra (c-51f1e055.07-184-6d6c6d4.bbcust.telenor.se. [85.224.241.81])
        by smtp.gmail.com with ESMTPSA id h12sm301888ljg.24.2019.09.20.02.35.57
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 20 Sep 2019 02:35:57 -0700 (PDT)
Received: from johan by xi.terra with local (Exim 4.92.2)
        (envelope-from <johan@kernel.org>)
        id 1iBFKX-0001cf-Op; Fri, 20 Sep 2019 11:35:58 +0200
Date:   Fri, 20 Sep 2019 11:35:57 +0200
From:   Johan Hovold <johan@kernel.org>
To:     Dmitry Vyukov <dvyukov@google.com>
Cc:     Johan Hovold <johan@kernel.org>,
        syzbot <syzbot+0243cb250a51eeefb8cc@syzkaller.appspotmail.com>,
        Andrey Konovalov <andreyknvl@google.com>,
        dmg@turingmachine.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        LKML <linux-kernel@vger.kernel.org>,
        USB list <linux-usb@vger.kernel.org>,
        syzkaller-bugs <syzkaller-bugs@googlegroups.com>
Subject: Re: KASAN: use-after-free Read in adu_disconnect
Message-ID: <20190920093557.GO30545@localhost>
References: <000000000000d12d24058f5d6b65@google.com>
 <000000000000a12822058fb4f408@google.com>
 <20190920090803.GM30545@localhost>
 <CACT4Y+Yg5wTsMUGRmTwexKUMzi1ZxrH3k3yaMaJvLaEp7qnjSw@mail.gmail.com>
 <20190920092153.GN30545@localhost>
 <CACT4Y+aLCfq_eJ0w9EnWN-kiTR7qxgtq+8osCqdNw7L4NYCASg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CACT4Y+aLCfq_eJ0w9EnWN-kiTR7qxgtq+8osCqdNw7L4NYCASg@mail.gmail.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 20, 2019 at 11:28:22AM +0200, Dmitry Vyukov wrote:
> On Fri, Sep 20, 2019 at 11:21 AM Johan Hovold <johan@kernel.org> wrote:
> >
> > On Fri, Sep 20, 2019 at 11:13:14AM +0200, Dmitry Vyukov wrote:
> > > On Fri, Sep 20, 2019 at 11:08 AM Johan Hovold <johan@kernel.org> wrote:
> > > >
> > > > On Fri, Aug 09, 2019 at 01:24:04PM -0700, syzbot wrote:
> > > > > syzbot has found a reproducer for the following crash on:
> > > > >
> > > > > HEAD commit:    e96407b4 usb-fuzzer: main usb gadget fuzzer driver
> > > > > git tree:       https://github.com/google/kasan.git usb-fuzzer
> > > > > console output: https://syzkaller.appspot.com/x/log.txt?x=13871a4a600000
> > > > > kernel config:  https://syzkaller.appspot.com/x/.config?x=cfa2c18fb6a8068e
> > > > > dashboard link: https://syzkaller.appspot.com/bug?extid=0243cb250a51eeefb8cc
> > > > > compiler:       gcc (GCC) 9.0.0 20181231 (experimental)
> > > > > syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=11c4c8e2600000
> > > > > C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=11d80d2c600000
> > > > >
> > > > > IMPORTANT: if you fix the bug, please add the following tag to the commit:
> > > > > Reported-by: syzbot+0243cb250a51eeefb8cc@syzkaller.appspotmail.com
> > > > >
> > > > > usb 1-1: USB disconnect, device number 4
> > > > > ==================================================================
> > > > > BUG: KASAN: use-after-free in atomic64_read
> > > > > include/asm-generic/atomic-instrumented.h:836 [inline]
> > > > > BUG: KASAN: use-after-free in atomic_long_read
> > > > > include/asm-generic/atomic-long.h:28 [inline]
> > > > > BUG: KASAN: use-after-free in __mutex_unlock_slowpath+0x96/0x670
> > > > > kernel/locking/mutex.c:1211
> > > > > Read of size 8 at addr ffff8881d1d0aa00 by task kworker/0:1/12
> > > >
> > > > Let's resend and retest with commit id from latest report to make sure
> > > > the patch was actually applied during the last run:
> > >
> > > The reply contains:
> > > patch:          https://syzkaller.appspot.com/x/patch.diff?x=1440268d600000
> > > that's what's being parsed and applied during testing.
> >
> > Thanks for confirming, but I can't seem to find that link in the report
> > from syzbot:
> >
> >         https://lkml.kernel.org/r/000000000000b05ce40592f8521a@google.com
> >
> > Is it supposed to be there?
> 
> I meant the previous one:
> https://lore.kernel.org/linux-usb/000000000000d290e00592e5c17d@google.com/
> 
> The one that you pointed to indeed does not have a patch (was tested
> without any patches). But you did not include any in the request, so
> this WAI.

Ok, that was what I thought. I first tried retriggering the test by
responding to the mail with the patch and a new test directive, but when
that test failed, I figured the patch had not been applied and that I
had to include it directly in the mail when retesting.

Apparently misremembered someone from google responding to a patch with
a test directive, but perhaps they also included the patch in that mail.

Johan
