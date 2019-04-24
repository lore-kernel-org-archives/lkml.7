Return-Path: <SRS0=L2S5=S2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E6AE3C282CE
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 21:21:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B437321773
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 21:21:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1556140868;
	bh=ivz8lvS509wCHo1WOlK23hnuop0lUHJEMH9lK6CfNjk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=lXTjUU1EFs+t+jVUq0t72slMfvrt2STfpwOBI016T0F/rXrUaJoWmfmhN5oRxxwJX
	 YFp3M0fS1QAWatCJ2mVVyyeewqNul0kl3txnNgypSiTwEJ2gKHNWRsnAgstg0lP7Ee
	 JNBu/TKOqhcefGidIWp2CPawzv8ofo4FK+vHSG4M=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730477AbfDXVVI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Apr 2019 17:21:08 -0400
Received: from mail-ot1-f67.google.com ([209.85.210.67]:41749 "EHLO
        mail-ot1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725978AbfDXVVH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Apr 2019 17:21:07 -0400
Received: by mail-ot1-f67.google.com with SMTP id g8so3527280otk.8;
        Wed, 24 Apr 2019 14:21:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=8GEwHhPdr4BmkYMX0IcNOw8jqgjiBEfOIkhM4OTQtSU=;
        b=Z7VM4zCR4mL/tBX3G7VjYrQBWWqrqHy0cJ/IhFTzLo8srsqWAhX4bQ1MB6H6dB4Y7P
         zKOF6RxhksxDx6DtiCPQo5UVa1FOsNBTDY6i+zCTI64PH8FVD/SH3D+MjjPC48Db0aBD
         KQUXsdEWkQtZYi9g4RUMwdjecN+vcsqEaH9RykErtwUOiDzCCjStbCjsHb5kbVSBIprm
         VpJY6d4WZOGP7huBGG05dodKl/E84qsSf+htGJwh8N8hdiTIpSFFUuSksgbyTYj25bSi
         Ub3Jxb/u3eTnbCBw2fS5+/xARaL068uRpnhnvCJNtC5eo4/ftqPyutVR++bRGdGMMMmt
         tuog==
X-Gm-Message-State: APjAAAX5FuIOdRFaQ17tCOi2zxjz7KOnxkVTiaHniU9+rAUQYbivHAFa
        c5D1V7BM130UcRzToYEV+tZ/uWw=
X-Google-Smtp-Source: APXvYqy9htzf6G9m11pkfngkpBJWUE3ttoxeV6z6fbslZgILQezri7rnVJa/KyYyj5MYqLv2K4/l3A==
X-Received: by 2002:a9d:12a2:: with SMTP id g31mr22483082otg.174.1556140866414;
        Wed, 24 Apr 2019 14:21:06 -0700 (PDT)
Received: from localhost (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id q23sm9209947oic.45.2019.04.24.14.21.05
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 24 Apr 2019 14:21:05 -0700 (PDT)
Date:   Wed, 24 Apr 2019 16:21:04 -0500
From:   Rob Herring <robh@kernel.org>
To:     Anson Huang <anson.huang@nxp.com>
Cc:     "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        "festevam@gmail.com" <festevam@gmail.com>,
        "catalin.marinas@arm.com" <catalin.marinas@arm.com>,
        "will.deacon@arm.com" <will.deacon@arm.com>,
        "rui.zhang@intel.com" <rui.zhang@intel.com>,
        "edubezval@gmail.com" <edubezval@gmail.com>,
        "daniel.lezcano@linaro.org" <daniel.lezcano@linaro.org>,
        Aisheng Dong <aisheng.dong@nxp.com>,
        "ulf.hansson@linaro.org" <ulf.hansson@linaro.org>,
        Daniel Baluta <daniel.baluta@nxp.com>,
        Peng Fan <peng.fan@nxp.com>,
        "heiko@sntech.de" <heiko@sntech.de>,
        "horms+renesas@verge.net.au" <horms+renesas@verge.net.au>,
        "agross@kernel.org" <agross@kernel.org>,
        "olof@lixom.net" <olof@lixom.net>,
        "bjorn.andersson@linaro.org" <bjorn.andersson@linaro.org>,
        "jagan@amarulasolutions.com" <jagan@amarulasolutions.com>,
        "enric.balletbo@collabora.com" <enric.balletbo@collabora.com>,
        "marc.w.gonzalez@free.fr" <marc.w.gonzalez@free.fr>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
        dl-linux-imx <linux-imx@nxp.com>
Subject: Re: [PATCH V12 5/5] arm64: dts: imx: add i.MX8QXP thermal support
Message-ID: <20190424212104.GA26974@bogus>
References: <1555384609-7030-1-git-send-email-Anson.Huang@nxp.com>
 <1555384609-7030-5-git-send-email-Anson.Huang@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1555384609-7030-5-git-send-email-Anson.Huang@nxp.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 16 Apr 2019 03:22:41 +0000, Anson Huang wrote:
> Add i.MX8QXP CPU thermal zone support.
> 
> Signed-off-by: Anson Huang <Anson.Huang@nxp.com>
> ---
> Changes since V11:
> 	- add cooling device for all secondary CPUs.
> ---
>  arch/arm64/boot/dts/freescale/imx8qxp.dtsi | 37 ++++++++++++++++++++++++++++++
>  1 file changed, 37 insertions(+)
> 

Reviewed-by: Rob Herring <robh@kernel.org>
