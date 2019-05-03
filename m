Return-Path: <SRS0=RThv=TD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,T_DKIMWL_WL_HIGH autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C1BECC43219
	for <linux-kernel@archiver.kernel.org>; Fri,  3 May 2019 15:19:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 85F992075C
	for <linux-kernel@archiver.kernel.org>; Fri,  3 May 2019 15:19:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="XUmZiwqw"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728254AbfECPTA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 3 May 2019 11:19:00 -0400
Received: from mail-vs1-f68.google.com ([209.85.217.68]:43279 "EHLO
        mail-vs1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727790AbfECPS7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 May 2019 11:18:59 -0400
Received: by mail-vs1-f68.google.com with SMTP id y196so3810373vsc.10
        for <linux-kernel@vger.kernel.org>; Fri, 03 May 2019 08:18:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=/7DMlLhZpYsWuofw8OIODIFO7gaAmV2hSfavk1PWNjw=;
        b=XUmZiwqwzLoqpAUVe8w0tkVHbFRykUE91OYgujzpgaBCx48baPDuGmg0M6jQyV4YII
         OWTb+7Zdpdig3RsJGJk/hfTgq68bJikh98t4m/Hra5MvlqkXrXqojZor8kcLrun7IcVq
         NOfXaNbyYGwDM79mwwB5iVPjXFMqHWmAq2c4c=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=/7DMlLhZpYsWuofw8OIODIFO7gaAmV2hSfavk1PWNjw=;
        b=gOc69FRrkCxJf84Tl8BVwSQ9IVCuQ74X6QCsdmDjIW/SwvaoUxmW6tXgVNWcJvhcY+
         Vwz3ABSspRog2qsCNO7xUKTZprKKL/PMwWiYyhHGl0cfZVHkKTtm26CNXuOSGff9xf07
         XxmhnC7JDBhilAuR/IfAQIan1NWcdJbnYkFpzqC68qUBnEnPJ9qpzBu54qnYt1tRGroG
         fTSdfgdWg3F/dXqIwfpufelvqhakdO/2z6knQvf/7GbXBcMFCdzunVsN1Idnm/V9gdAE
         2HiS1RF0vT5N9FAa5CjAaoO0tfTt1ZawTxhkjs4q4yTKKzFs0DFniZcLLu94Cdw1hToO
         tmhA==
X-Gm-Message-State: APjAAAXm1wNqLBKBbGfEJiY53AABucO7m3COdhy36i6cYhAX30VhT/fN
        UeZY2i/vZGEAEtplyJmnOBLqO0K5RPc=
X-Google-Smtp-Source: APXvYqyfw7C5LAAV1waqmLQprx81yvba4jp7TMU3b+wT9NUqR01YwjcJsOwhjlqqUrxd6+3VC7kjsg==
X-Received: by 2002:a67:7b56:: with SMTP id w83mr5928207vsc.79.1556896066748;
        Fri, 03 May 2019 08:07:46 -0700 (PDT)
Received: from mail-ua1-f41.google.com (mail-ua1-f41.google.com. [209.85.222.41])
        by smtp.gmail.com with ESMTPSA id l200sm1339230vkl.25.2019.05.03.08.07.44
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
        Fri, 03 May 2019 08:07:45 -0700 (PDT)
Received: by mail-ua1-f41.google.com with SMTP id z17so2128906uar.3
        for <linux-kernel@vger.kernel.org>; Fri, 03 May 2019 08:07:44 -0700 (PDT)
X-Received: by 2002:ab0:2709:: with SMTP id s9mr4499637uao.21.1556896064408;
 Fri, 03 May 2019 08:07:44 -0700 (PDT)
MIME-Version: 1.0
References: <20190418001356.124334-1-dianders@chromium.org>
 <20190418001356.124334-2-dianders@chromium.org> <CAD=FV=UGjQz9Di=NL_r_g1Hofqv-FWBywfSm9Vu6gGr22wzPrA@mail.gmail.com>
 <SN1PR12MB243136608514210F3E3E536EA7350@SN1PR12MB2431.namprd12.prod.outlook.com>
In-Reply-To: <SN1PR12MB243136608514210F3E3E536EA7350@SN1PR12MB2431.namprd12.prod.outlook.com>
From:   Doug Anderson <dianders@chromium.org>
Date:   Fri, 3 May 2019 08:07:32 -0700
X-Gmail-Original-Message-ID: <CAD=FV=V97+_cQ1aD=w_a3SifGOG3M5DPvcnvxYVUJMkX_WLTFg@mail.gmail.com>
Message-ID: <CAD=FV=V97+_cQ1aD=w_a3SifGOG3M5DPvcnvxYVUJMkX_WLTFg@mail.gmail.com>
Subject: Re: [PATCH v2 1/5] usb: dwc2: bus suspend/resume for hosts with DWC2_POWER_DOWN_PARAM_NONE
To:     Artur Petrosyan <Arthur.Petrosyan@synopsys.com>
Cc:     Minas Harutyunyan <Minas.Harutyunyan@synopsys.com>,
        Felipe Balbi <felipe.balbi@linux.intel.com>,
        =?UTF-8?Q?Heiko_St=C3=BCbner?= <heiko@sntech.de>,
        Alan Stern <stern@rowland.harvard.edu>,
        Alexandru M Stan <amstan@chromium.org>,
        "open list:ARM/Rockchip SoC..." <linux-rockchip@lists.infradead.org>,
        William Wu <william.wu@rock-chips.com>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        Stefan Wahren <stefan.wahren@i2se.com>,
        Randy Li <ayaka@soulik.info>, Chris <zyw@rock-chips.com>,
        Matthias Kaehlcke <mka@chromium.org>,
        Ryan Case <ryandcase@chromium.org>,
        Amelie Delaunay <amelie.delaunay@st.com>,
        Julius Werner <jwerner@chromium.org>,
        Elaine Zhang <zhangqing@rock-chips.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Fri, May 3, 2019 at 1:25 AM Artur Petrosyan
<Arthur.Petrosyan@synopsys.com> wrote:
>
> On 5/2/2019 03:58, Doug Anderson wrote:
> > Hi,
> >
> >
> > On Wed, Apr 17, 2019 at 5:15 PM Douglas Anderson <dianders@chromium.org=
> wrote:
> >>
> >> This is an attempt to rehash commit 0cf884e819e0 ("usb: dwc2: add bus
> >> suspend/resume for dwc2") on ToT.  That commit was reverted in commit
> >> b0bb9bb6ce01 ("Revert "usb: dwc2: add bus suspend/resume for dwc2"")
> >> because apparently it broke the Altera SOCFPGA.
> >>
> >> With all the changes that have happened to dwc2 in the meantime, it's
> >> possible that the Altera SOCFPGA will just magically work with this
> >> change now.  ...and it would be good to get bus suspend/resume
> >> implemented.
> >>
> >> This change is a forward port of one that's been living in the Chrome
> >> OS 3.14 kernel tree.
> >>
> >> Signed-off-by: Douglas Anderson <dianders@chromium.org>
> >> ---
> >> This patch was last posted at:
> >>
> >> https://urldefense.proofpoint.com/v2/url?u=3Dhttps-3A__lkml.kernel.org=
_r_1446237173-2D15263-2D1-2Dgit-2Dsend-2Demail-2Ddianders-40chromium.org&d=
=3DDwIBaQ&c=3DDPL6_X_6JkXFx7AXWqB0tg&r=3D9hPBFKCJ_nBjJhGVrrlYOeOQjP_HlVzYqr=
C_D7niMJI&m=3D7rxT8EFX9mqUDtTL4P7iuzYNsYROe9rxHGCresSKPTg&s=3DlTaNUA2XIYPat=
417fkd1A4Zpvb5eyYtTc1H_NIfW8Vw&e=3D
> >>
> >> ...and appears to have died the death of silence.  Maybe it could get
> >> some bake time in linuxnext if we can't find any proactive testing?
> >>
> >> I will also freely admit that I don't know tons about the theory
> >> behind this patch.  I'm mostly just re-hashing the original commit
> >> from Kever that was reverted since:
> >> * Turning on partial power down on rk3288 doesn't "just work".  I
> >>    don't get hotplug events.  This is despite dwc2 auto-detecting that
> >>    we are power optimized.
> >> * If we don't do something like this commit we don't get into as low
> >>    of a power mode.
> >
> > OK, I spent the day digging more into this patch to confirm that it's
> > really the right thing to do.  ...and it still seems to be.
> >
> > First off: I'm pretty sure the above sentence "If we don't do
> > something like this commit we don't get into as low of a power mode."
> > is totally wrong.  Luckily it's "after the cut" and not part of the
> > commit message.  Specifically I did a bunch of power testing and I
> > couldn't find any instance saving power after this patch.
> >
> > ...but, then I looked more carefully at all the history of this
> > commit.  I ended up at:
> >
> > https://urldefense.proofpoint.com/v2/url?u=3Dhttps-3A__chromium-2Drevie=
w.googlesource.com_c_chromiumos_third-5Fparty_kernel_-2B_306265_&d=3DDwIBaQ=
&c=3DDPL6_X_6JkXFx7AXWqB0tg&r=3D9hPBFKCJ_nBjJhGVrrlYOeOQjP_HlVzYqrC_D7niMJI=
&m=3D7rxT8EFX9mqUDtTL4P7iuzYNsYROe9rxHGCresSKPTg&s=3DLiyyIyaCPmr88nJeI7TCGt=
oJBFLRWir_reikYtAHHDw&e=3D
> Looking at this code review I see that this patch fixes whatever issues
> you have on Chrome OS 3.14. But your patch has landed on the top of
> latest Kernel version. With the latest version I think you would not
> have the regression issue.
> So you are fixing Chrome OS 3.14.

I'm confused why you ignored the rest of my email where I said I also
ported it to 4.19 (which, from a dwc2 host point of view, is pretty
much mainline) and saw that the patch was still needed.

-Doug
