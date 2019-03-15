Return-Path: <SRS0=8sqo=RS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AE389C43381
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Mar 2019 23:23:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6C73E2184C
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Mar 2019 23:23:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="bFgIz75b"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727509AbfCOXXl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 Mar 2019 19:23:41 -0400
Received: from mail-ua1-f66.google.com ([209.85.222.66]:39162 "EHLO
        mail-ua1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727188AbfCOXXl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Mar 2019 19:23:41 -0400
Received: by mail-ua1-f66.google.com with SMTP id m11so710128uad.6
        for <linux-kernel@vger.kernel.org>; Fri, 15 Mar 2019 16:23:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=t925Fe6p1JfFbcxLsJ4YZ5IC7rsRB1Ds+u1RXMtkZNc=;
        b=bFgIz75bFsS9uxq0DaaO3U/4bcdw3JwTfNAyXBO8uCMpG1MLZ/P/4/pHi6PhY6js0O
         VG2pKp6tX6JHmYZwHpXSkoc+aTD1Ms00LWvv5wStFueoVU6E+prpcm5EB7g4I6vZH1DP
         Lk9dKdEEO/RGVvZTfozYvPdmGLkT84qljPXKk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=t925Fe6p1JfFbcxLsJ4YZ5IC7rsRB1Ds+u1RXMtkZNc=;
        b=hXza0fQ0rzR+FSs+aWXAqxbQ2xlC2ajiHXLj3QhbwX70O/6tHWgbEvCugPLEzNqCnn
         ChQLuAHInNowhtNgQVwbQO3Ybo5DuNpyD+oGOYdb33UDesIu8VMMWGtX/yDKbSa71qtP
         v2SHtAiSDZT7zrzBg3d4c16KGFpR9uKelBsNt1vsPvKV9X4VJdwq7cAUaJNIF4/eibGF
         v4/9vMYtJ3DZAeycrmU5LradeBt3oblHu7gm/eM/laW1W1liVcT1DVIo9AGCUwIMBzID
         MhRxutf+YcpX2OCann3WnrhAvLwdK+TSY5u/uBOrRSt2jw3rG5EVAxhtrz24VhadO++8
         yxaA==
X-Gm-Message-State: APjAAAUwsXcMxAuBJgfOUMyCZAvmNuq7zhZ5U0zqWF8Bhu4XnYJH1ONf
        yXwSDrplZbQSAkn2Qaq6deFZjCxGNsI=
X-Google-Smtp-Source: APXvYqy6JI+PFA6xUtf7j6ehAAW2VEzNU6+9eWFZVt5FM2xTB8v8/sEbPlGhXESJPsLlV0KL1jlP6w==
X-Received: by 2002:ab0:4e17:: with SMTP id g23mr1089791uah.95.1552692219721;
        Fri, 15 Mar 2019 16:23:39 -0700 (PDT)
Received: from mail-vs1-f50.google.com (mail-vs1-f50.google.com. [209.85.217.50])
        by smtp.gmail.com with ESMTPSA id j92sm154532uad.6.2019.03.15.16.23.38
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 15 Mar 2019 16:23:38 -0700 (PDT)
Received: by mail-vs1-f50.google.com with SMTP id w14so6371917vso.6
        for <linux-kernel@vger.kernel.org>; Fri, 15 Mar 2019 16:23:38 -0700 (PDT)
X-Received: by 2002:a67:b60c:: with SMTP id d12mr2247764vsm.149.1552692218037;
 Fri, 15 Mar 2019 16:23:38 -0700 (PDT)
MIME-Version: 1.0
References: <1461951139-6109-1-git-send-email-dianders@chromium.org>
 <yw1x5zsx5wc7.fsf@mansr.com> <CAJ+vNU1PxK-B63Dc3AgzYb9POyxxoF-xPOWBEpxJ+3eVNK8xqw@mail.gmail.com>
 <d5310138-7fdd-973d-5210-3fc91c4686ee@denx.de>
In-Reply-To: <d5310138-7fdd-973d-5210-3fc91c4686ee@denx.de>
From:   Doug Anderson <dianders@chromium.org>
Date:   Fri, 15 Mar 2019 16:23:26 -0700
X-Gmail-Original-Message-ID: <CAD=FV=XLuPWKjQBMLApRQxk0K30p_TPcztB7g_1DB7iRA9BGRQ@mail.gmail.com>
Message-ID: <CAD=FV=XLuPWKjQBMLApRQxk0K30p_TPcztB7g_1DB7iRA9BGRQ@mail.gmail.com>
Subject: Re: [PATCH v2 0/4] Patches to allow consistent mmc / mmcblk numbering
 w/ device tree
To:     Marek Vasut <marex@denx.de>
Cc:     Tim Harvey <tharvey@gateworks.com>,
        =?UTF-8?B?TcOlbnMgUnVsbGfDpXJk?= <mans@mansr.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Jaehoon Chung <jh80.chung@samsung.com>,
        Shawn Lin <shawn.lin@rock-chips.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Stefan Agner <stefan@agner.ch>,
        Linux MMC List <linux-mmc@vger.kernel.org>,
        Brian Norris <computersforpeace@gmail.com>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Heiko Stuebner <heiko@sntech.de>,
        Jisheng Zhang <jszhang@marvell.com>,
        "open list:ARM/Rockchip SoC..." <linux-rockchip@lists.infradead.org>,
        devicetree-spec@vger.kernel.org,
        Mark Rutland <mark.rutland@arm.com>,
        open list <linux-kernel@vger.kernel.org>,
        Venu Byravarasu <vbyravarasu@nvidia.com>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Russell King - ARM Linux <linux@arm.linux.org.uk>,
        Jon Hunter <jonathanh@nvidia.com>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        devicetree@vger.kernel.org, Pawel Moll <pawel.moll@arm.com>,
        Ian Campbell <ijc+devicetree@hellion.org.uk>,
        Grant Grundler <grundler@chromium.org>,
        Kumar Gala <galak@codeaurora.org>,
        "Luca Porzio (lporzio)" <lporzio@micron.com>,
        Rob Herring <robh+dt@kernel.org>,
        =?UTF-8?B?Q2hhb3RpYW4gSmluZyAo5LqV5pyd5aSpKQ==?= 
        <chaotian.jing@mediatek.com>,
        Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>,
        Sudeep Holla <sudeep.holla@arm.com>,
        zhonghui.fu@linux.intel.com, kirill.shutemov@linux.intel.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Fri, Mar 15, 2019 at 4:00 PM Marek Vasut <marex@denx.de> wrote:
>
> > Completely agree here - we need a dt solution that allows us to
> > specify ordering.
>
> Nope, ordering would be a policy and does not describe hardware, thus it
> shouldn't be in the DT. Use UUID or PARTUUID, they apply both to raw FS
> (fsuuid) and to partitions (part uuid). Linux kernel can mount FS using
> PARTUUID, to support UUID you need initramfs.

Two thoughts about that:

1. Some amount of policy is allowed in device tree.  At some point in
time there was a big discussion about the need for a separate "config
tree" that was totally parallel to the device tree so we could put
policy stuff in that.  Nobody wanted that and (as I recall) it was
agreed that in some cases policy could go there if that policy
expressed policy that was the generic intent of how the board ought to
be run.  I believe this is how things like the assigned-clocks is
justified.

2. In some cases this number does describe the hardware.  You look at
the hardware reference manual and see that there are 3 MMC
controllers: 0, 1, and 2.  In such cases it seems like it's an OK
description of the hardware to encode this info into the DTS.

...from what I recall, one big objection is for SoCs that didn't just
have numbers for their controllers.  AKA I think some SoCs might call
their controllers the "eMMC" controller, the "SD" controller, and the
"SDIO" controller.  They may be nearly the same hardware, but perhaps
the SoC allows for a GPIO interrupt on the SDIO controller and perhaps
the eMMC controller exposes the strobe line or has an 8-bit wide
datapath.  In this case making up numbers does become a bit more
arbitrary and folks didn't like it.

IIRC there was general consensus that it'd be OK to somehow specify a
string (AKA non-numeric) name for different SD controllers.  I don't
have pointers to that conversation offhand and it's possible I
imagined it.


-Doug
