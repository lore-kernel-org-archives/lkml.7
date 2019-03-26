Return-Path: <SRS0=4nbc=R5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2C52CC43381
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Mar 2019 16:18:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E51F02070D
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Mar 2019 16:18:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="hL8o98JR"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732086AbfCZQS3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Mar 2019 12:18:29 -0400
Received: from mail-lf1-f68.google.com ([209.85.167.68]:33617 "EHLO
        mail-lf1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729693AbfCZQS3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Mar 2019 12:18:29 -0400
Received: by mail-lf1-f68.google.com with SMTP id v14so9237390lfi.0
        for <linux-kernel@vger.kernel.org>; Tue, 26 Mar 2019 09:18:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=4U0UqMC8ZbLgJkEEZCUWyASWNaMbSZxjOz8QMfToaVc=;
        b=hL8o98JRudBETHHKZcfTOoVKf827FE0JhT9/Zb5dNAZNUB4V0j913E7Eiu38RjYPLE
         qI8Axp9/zuvAFJ318OMpQluQelUyvIlEN8VtS9G6oBrBmUOGi2PGzOc/uLIFE7tSn0sz
         HPNLzk13IO7ElJJ2KaZ7LQOKEM5e/zUo7hdcc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=4U0UqMC8ZbLgJkEEZCUWyASWNaMbSZxjOz8QMfToaVc=;
        b=LDKrvYV1QvfmMzWADDxiKmy6cTbprO6W50O7Ta1vq1Sq5RmnIB6uovL1oLTgf2OLtU
         +tSMb/jmLr7BoAadrEavggoMUybL7/i4UJVflKjaZUrb9nkeHgnDkmU0XneZfHIYZRgU
         D33qGbNWksUDt2N7FkfVG94pJhQyC009XvAPm6nU/tWOlbXfsLE3uJsI6FSat6BTCxTE
         TMISDD6H4yOVR1OtFszbmgfCK1tXpOcAJiuEqSz+j51+2BfS91cTR3mfUr/BFDuxnM3c
         sJzwD1EJKJXz+gSulzt02B8n7LSE9eOIhYiITyOsqbDhoU5ZUBwefp6l1m7FvYfn7Nti
         msGA==
X-Gm-Message-State: APjAAAXl+FMKnVOvqby1Zxpod5POii8zR+F7CH2BVc8cs+5bi3FeakKQ
        zbNe0/dt8oWvg8nW+HnqVIqN2wxboZQ=
X-Google-Smtp-Source: APXvYqwtmBkztu5yAYS/InmgCy6KcKVAF2BdtAmkEXaJ+ap9E2tM/+0/YGJYG2KjYOGxkAmBAd4j3Q==
X-Received: by 2002:ac2:48b7:: with SMTP id u23mr11931415lfg.115.1553617106628;
        Tue, 26 Mar 2019 09:18:26 -0700 (PDT)
Received: from mail-lf1-f46.google.com (mail-lf1-f46.google.com. [209.85.167.46])
        by smtp.gmail.com with ESMTPSA id z8sm1235267ljc.50.2019.03.26.09.18.26
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 26 Mar 2019 09:18:26 -0700 (PDT)
Received: by mail-lf1-f46.google.com with SMTP id d18so9137103lfn.3
        for <linux-kernel@vger.kernel.org>; Tue, 26 Mar 2019 09:18:26 -0700 (PDT)
X-Received: by 2002:ac2:4563:: with SMTP id k3mr15678774lfm.101.1553617105865;
 Tue, 26 Mar 2019 09:18:25 -0700 (PDT)
MIME-Version: 1.0
References: <20190321171800.104681-1-evgreen@chromium.org> <d90e86b9-a330-677c-a70a-d66139473f48@ti.com>
In-Reply-To: <d90e86b9-a330-677c-a70a-d66139473f48@ti.com>
From:   Evan Green <evgreen@chromium.org>
Date:   Tue, 26 Mar 2019 09:17:48 -0700
X-Gmail-Original-Message-ID: <CAE=gft5c3pS2ksH_oW_+F52gr4r0KnkoUHJXZ7u9vChSAZEovg@mail.gmail.com>
Message-ID: <CAE=gft5c3pS2ksH_oW_+F52gr4r0KnkoUHJXZ7u9vChSAZEovg@mail.gmail.com>
Subject: Re: [PATCH v5 0/8] phy: qcom-ufs: Enable regulators to be off in suspend
To:     Kishon Vijay Abraham I <kishon@ti.com>,
        Andy Gross <andy.gross@linaro.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>
Cc:     Stephen Boyd <swboyd@chromium.org>,
        Marc Gonzalez <marc.w.gonzalez@free.fr>,
        Can Guo <cang@codeaurora.org>,
        Vivek Gautam <vivek.gautam@codeaurora.org>,
        Douglas Anderson <dianders@chromium.org>,
        Asutosh Das <asutoshd@codeaurora.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        Pedro Sousa <pedrom.sousa@synopsys.com>,
        liwei <liwei213@huawei.com>, SCSI <linux-scsi@vger.kernel.org>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        Bart Van Assche <Bart.VanAssche@wdc.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Subhash Jadavani <subhashj@codeaurora.org>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        Alim Akhtar <alim.akhtar@samsung.com>,
        Rob Herring <robh+dt@kernel.org>,
        Avri Altman <avri.altman@wdc.com>,
        Mark Rutland <mark.rutland@arm.com>,
        "James E.J. Bottomley" <jejb@linux.ibm.com>,
        Janek Kotas <jank@cadence.com>,
        David Brown <david.brown@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 26, 2019 at 12:49 AM Kishon Vijay Abraham I <kishon@ti.com> wrote:
>
> Hi,
>
> On 21/03/19 10:47 PM, Evan Green wrote:
> > The goal with this series is to enable shutting off regulators that power
> > UFS during system suspend.
> >
> > In "the good life" version of this, we'd just disable the regulators
> > in phy_poweroff() and be done with it. Unfortunately, that's not symmetric,
> > as regulators are not enabled during phy_poweron(). Ok, so you might think
> > we could just move the regulator enable and anything else that needs to
> > come along into phy_poweron(), so that we can then undo it all in
> > phy_poweroff(). That's where things get tricky.
> >
> > The qcom-qmp-phy overloaded the phy_init() and phy_poweron() callbacks,
> > basically to mean "init phase 1" and "init phase 2". There are two phases
> > because they have this phy_reset bit outside of the phy (in the UFS
> > controller registers), and they need to make sure this bit is toggled at
> > specific points in the phy init sequence. So there's this implicit
> > sequence in the init dance between ufs-qcom.c and phy-qcom-qmp.c:
> > 1) ufs-qcom asserts the PHY reset bit.
> > 2) phy-qcom-qmp phy_init() does most of its initialization, but exits early.
> > 3) ufs-qcom deasserts the PHY reset bit.
> > 4) phy-qcom-qmp phy_poweron() finishes its initialization.
> >
> > This init dance is very difficult to follow in the code (since it's split
> > between two drivers and not spelled out well), and arguably represents a
> > deficiency in the hardware description of these devices.
> >
> > In this series I'm proposing tweaking the bindings for the Qualcomm
> > UFS controller and PHY. In it we expose a reset controller from the
> > UFS controller, that is then picked up and used from the PHY code.
> > With this, the phy code can be reorganized to complete its initialization
> > in a single function, removing the implicit two-phase overloading.
> >
> > Then I can move most of the phy initialization, including enabling
> > the regulators, into phy_poweron(). Now, when phy_poweroff() is called,
> > the phy actually powers off. This finally disables the regulators
> > and allows me to save power in system suspend.
> >
> > Because the UFS PHY reset bit is now toggled in the PHY, rather
> > than in ufs-qcom, this also percolated to all other PHYs using
> > ufs-qcom, which from what I can see is just 8996.
> >
> > I removed the calls to phy_poweroff() during clock gating. This
> > was originally dialing down a clock or two, while leaving the phy powered.
> > I've now changed the semantics of phy_poweroff() to, well, actually power off.
> > This works great for userlands that have set UFS's spm_lvl to 5 (off) like
> > I have, but maybe changes power consumption for devices that have spm_lvl
> > set to 3. I could try to use phy_init() and phy_poweron() as the two
> > different possible transitions (fully off, and clocks off respectively),
> > but I'm not sure if it actually matters, and I like the idea that
> > phy_poweroff() really does power the thing off.
> >
> > Also, I don't have an 8996 device to test. If someone is able to test this
> > out and perhaps point out any (hopefully obvious) bugs in the 8996 portion,
> > I'd be grateful.
> >
> > This patch is based atop phy-next.
>
> Merged the series except the dts patches.

Yay, thanks Kishon.

Andy, Bjorn, are you able to take the DT patches?
-Evan
