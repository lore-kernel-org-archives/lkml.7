Return-Path: <SRS0=Tfva=ZZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CCBD7C43215
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Dec 2019 14:47:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A504F20661
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Dec 2019 14:47:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1575384475;
	bh=qoEpR+iz5sa+F9skDmBKFFgJNfBR3Zy5GUGd1/9m/gQ=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=1Me7R70bnnhiovjVSwmULM9u+FvDETug/ZJdtM4usJx9ec2XarNJunBcbdZQ5rWJX
	 doh2x4j0vd/HYkAQIDbfBdQowSy4RbVvRSJKE72dQq+yOItJeb9fkqdY1be9xWyRYA
	 xl9U/sdNmAsY7lGl2hfhjUOiOMsGuG57CbBHMZpU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726598AbfLCOry (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 3 Dec 2019 09:47:54 -0500
Received: from mail.kernel.org ([198.145.29.99]:58556 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725848AbfLCOry (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Dec 2019 09:47:54 -0500
Received: from mail-qv1-f53.google.com (mail-qv1-f53.google.com [209.85.219.53])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C7EB82070A;
        Tue,  3 Dec 2019 14:47:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1575384472;
        bh=qoEpR+iz5sa+F9skDmBKFFgJNfBR3Zy5GUGd1/9m/gQ=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=Yk3+kwHbCw67Q8MsoMwGkrd5CTloi+Cgz+s8OJTz8fohj85dg//2UtKabMoqyzHSX
         lRhvnd9AvR6nddhBsnDYT7SIiQlgDLIm3XBrklMlrRWwZ4TrrHg7DMh4T8RTSMgsBR
         S3dUK+58xtFa6ZyeTbtri6zHy807ej67tLHjKfjM=
Received: by mail-qv1-f53.google.com with SMTP id p2so1582533qvo.10;
        Tue, 03 Dec 2019 06:47:52 -0800 (PST)
X-Gm-Message-State: APjAAAVVMbqNxprwq8bxRB66/KcOtXd3wZiKNDQZcnnhcDV2FC+UhJl2
        /12UYRb9djvrXDEEz4KCeDn2Kzdh2TW/f7l/DA==
X-Google-Smtp-Source: APXvYqxrMnC94tLm+z/m6J/edWdsA+e9+yTSEaG1G1r+Sc9Beij7suS2pnqDw5WIbatRieWqQvxMMTtm91WsEIvREJ0=
X-Received: by 2002:ad4:450a:: with SMTP id k10mr5131884qvu.136.1575384471940;
 Tue, 03 Dec 2019 06:47:51 -0800 (PST)
MIME-Version: 1.0
References: <cover.08e3a6c95159f017b753d0f240086d1a7923758b.1575369656.git-series.andrew@aj.id.au>
In-Reply-To: <cover.08e3a6c95159f017b753d0f240086d1a7923758b.1575369656.git-series.andrew@aj.id.au>
From:   Rob Herring <robh+dt@kernel.org>
Date:   Tue, 3 Dec 2019 08:47:40 -0600
X-Gmail-Original-Message-ID: <CAL_JsqLMs1MsNXMFTCVdrkNNx5ktg0_Q=zf6xgiTkeys-T+CNg@mail.gmail.com>
Message-ID: <CAL_JsqLMs1MsNXMFTCVdrkNNx5ktg0_Q=zf6xgiTkeys-T+CNg@mail.gmail.com>
Subject: Re: [PATCH 00/14] ARM: dts: aspeed: Cleanup dtc warnings
To:     Andrew Jeffery <andrew@aj.id.au>
Cc:     linux-aspeed@lists.ozlabs.org, Joel Stanley <joel@jms.id.au>,
        Mark Rutland <mark.rutland@arm.com>,
        devicetree@vger.kernel.org,
        "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        a.filippov@yadro.com, anoo@us.ibm.com,
        Ken Chen <chen.kenyy@inventec.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Stefan M Schaeckeler <sschaeck@cisco.com>, taoren@fb.com,
        Patrick Venture <venture@google.com>,
        John Wang <wangzqbj@inspur.com>, Xo Wang <xow@google.com>,
        =?UTF-8?B?QnJpYW5DLlcg5qWK5ZiJ5YGJIFRBTyBZYW5n?= 
        <yang.brianc.w@inventec.com>, yao.yuan@linaro.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 3, 2019 at 6:02 AM Andrew Jeffery <andrew@aj.id.au> wrote:
>
> Hello,
>
> This series is based on an RFC-ish series I sent quite some time ago to which I
> have only just been able to circle back. The previous discussion can be found
> here:
>
> https://lore.kernel.org/lkml/20190726053959.2003-1-andrew@aj.id.au/
>
> I've split, shuffled and rebased the series a little, with at least one extra
> cleanup for the g6 dtsi. This series is just the devicetree changes, the IPMI
> KCS changes will be posted separately shortly.
>
> Combined with the KCS changes we achieve similar stats to the RFC series,
> reducing 264 warnings to 6.
>
> I've added each patches' tags from last time, but please glance over them
> again.
>
> Cheers,
>
> Andrew
>
> Andrew Jeffery (14):
>   dt-bindings: pinctrl: aspeed: Add reg property as a hint
>   dt-bindings: misc: Document reg for aspeed,p2a-ctrl nodes
>   ARM: dts: aspeed-g5: Move EDAC node to APB
>   ARM: dts: aspeed-g5: Use recommended generic node name for SDMC
>   ARM: dts: aspeed-g5: Fix aspeed,external-nodes description
>   ARM: dts: vesnin: Add unit address for memory node
>   ARM: dts: fp5280g2: Cleanup gpio-keys-polled properties
>   ARM: dts: swift: Cleanup gpio-keys-polled properties
>   ARM: dts: witherspoon: Cleanup gpio-keys-polled properties
>   ARM: dts: aspeed: Cleanup lpc-ctrl and snoop regs
>   ARM: dts: aspeed: Add reg hints to syscon children
>   ARM: dts: aspeed-g5: Sort LPC child nodes by unit address
>   ARM: dts: aspeed-g6: Cleanup watchdog unit address
>   ARM: dts: ibm-power9-dual: Add a unit address for OCC nodes
>
>  Documentation/devicetree/bindings/misc/aspeed-p2a-ctrl.txt            |  1 +
>  Documentation/devicetree/bindings/pinctrl/aspeed,ast2400-pinctrl.yaml |  3 +++
>  Documentation/devicetree/bindings/pinctrl/aspeed,ast2500-pinctrl.yaml |  3 +++
>  arch/arm/boot/dts/aspeed-bmc-arm-centriq2400-rep.dts                  |  4 ----
>  arch/arm/boot/dts/aspeed-bmc-arm-stardragon4800-rep2.dts              |  4 ----
>  arch/arm/boot/dts/aspeed-bmc-inspur-fp5280g2.dts                      | 11 +++++++----
>  arch/arm/boot/dts/aspeed-bmc-intel-s2600wf.dts                        |  4 ----
>  arch/arm/boot/dts/aspeed-bmc-opp-lanyang.dts                          |  4 ----
>  arch/arm/boot/dts/aspeed-bmc-opp-romulus.dts                          |  4 ----
>  arch/arm/boot/dts/aspeed-bmc-opp-swift.dts                            |  6 ------
>  arch/arm/boot/dts/aspeed-bmc-opp-vesnin.dts                           |  2 +-
>  arch/arm/boot/dts/aspeed-bmc-opp-witherspoon.dts                      |  6 ------
>  arch/arm/boot/dts/aspeed-bmc-opp-zaius.dts                            |  2 --
>  arch/arm/boot/dts/aspeed-g4.dtsi                                      | 21 ++++++++++++---------
>  arch/arm/boot/dts/aspeed-g5.dtsi                                      | 49 ++++++++++++++++++++++++++-----------------------
>  arch/arm/boot/dts/aspeed-g6.dtsi                                      |  2 +-
>  arch/arm/boot/dts/ibm-power9-dual.dtsi                                |  4 ++--
>  17 files changed, 56 insertions(+), 74 deletions(-)

Other than patch 5, for the series:

Reviewed-by: Rob Herring <robh@kernel.org>
