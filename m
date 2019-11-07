Return-Path: <SRS0=GkzU=Y7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5CDC6FC6194
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Nov 2019 00:25:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 23F2A206DF
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Nov 2019 00:25:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1573086322;
	bh=xhNvDEryn0+Nc32LvcJ1Woz2dRdItsFdczm9qImxRiY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=D9DeHQv8wEIkOrPGrltTyuRAueaqGMLvU7hve2mW1nUaOI/OZiagXBAryMa4sx/yR
	 HUk82BRYJl5fgqRmdKXkO1YDry68ThzRL7X6RzQ2xXF27ILan1frN5uqY7lc34aiOq
	 famjtGhYD98I/h7r7kP/xaEa//yTowbcAR/LZ6EA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727973AbfKGAZV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 6 Nov 2019 19:25:21 -0500
Received: from mail-ot1-f66.google.com ([209.85.210.66]:35871 "EHLO
        mail-ot1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725989AbfKGAZU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Nov 2019 19:25:20 -0500
Received: by mail-ot1-f66.google.com with SMTP id f10so471305oto.3;
        Wed, 06 Nov 2019 16:25:20 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=ZzUL/AyiBPqE7zvVbE2IsIX3VerKJnUCOltXfkVkFZY=;
        b=dX86UKYMpfY58LIBEor0FLDCHcTaXD2pV09/g5pViB9UzIb/e7e1ND6/ynuCxo4LVn
         K5KLhPhDwTmfGwmNhhJ/o6XnUx2l4nXmSfEiC7xmC89sFLbOfsgCuKPwpsr4yAPHuoH3
         rkTgTlN3GD1LPFODFnFkGrgXhh7c5V/Hvi3sS/LFJjRTGYgw4T5xbc3a5dSpXY+JNQKq
         pwoj7BNlC07CIYK2/kUD0FYvZaW4ZaLI1SPMjhVXWaZlgEOWxP8Yu2RxeR1AsanT55YE
         M0bdcAPwkEN7RH2ZRKlPtbSsSeji/GXZu2GNzvf1WQLEWOIb799gOhp/DTSdSRsZxc+E
         MgkQ==
X-Gm-Message-State: APjAAAXgyXKBVTetpfHUbyd3zHVCNtQN5kPZKgLCDgT9Qrc/yId4pToL
        xsN1ASRvBY200taoCGnRbQ==
X-Google-Smtp-Source: APXvYqySec/Ph58g0+X2o6i2pUtu7IO0vPN9Wq5qgoeq4sY3tbPZ/3k/MyDq8RuZ4cKgUSWTuIBluQ==
X-Received: by 2002:a05:6830:15ca:: with SMTP id j10mr430974otr.276.1573086319746;
        Wed, 06 Nov 2019 16:25:19 -0800 (PST)
Received: from localhost (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id w26sm191235otm.28.2019.11.06.16.25.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Nov 2019 16:25:19 -0800 (PST)
Date:   Wed, 6 Nov 2019 18:25:18 -0600
From:   Rob Herring <robh@kernel.org>
To:     Elaine Zhang <zhangqing@rock-chips.com>
Cc:     heiko@sntech.de, mark.rutland@arm.com, devicetree@vger.kernel.org,
        amit.kucheria@verdurent.com,
        Elaine Zhang <zhangqing@rock-chips.com>,
        huangtao@rock-chips.com, linux-pm@vger.kernel.org,
        xxx@rock-chips.com, daniel.lezcano@linaro.org,
        linux-kernel@vger.kernel.org, xf@rock-chips.com,
        edubezval@gmail.com, linux-rockchip@lists.infradead.org,
        robh+dt@kernel.org, andy.yan@rock-chips.com, rui.zhang@intel.com,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v1 1/3] dt-bindings: rockchip-thermal: Support the RK3308
 SoC  compatible
Message-ID: <20191107002518.GA20339@bogus>
References: <1572923846-23310-1-git-send-email-zhangqing@rock-chips.com>
 <1572923846-23310-2-git-send-email-zhangqing@rock-chips.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1572923846-23310-2-git-send-email-zhangqing@rock-chips.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue,  5 Nov 2019 11:17:24 +0800, Elaine Zhang wrote:
> Add a new compatible for thermal founding on RK3308 SoCs.
> 
> Signed-off-by: Elaine Zhang <zhangqing@rock-chips.com>
> ---
>  Documentation/devicetree/bindings/thermal/rockchip-thermal.txt | 1 +
>  1 file changed, 1 insertion(+)
> 

Acked-by: Rob Herring <robh@kernel.org>
