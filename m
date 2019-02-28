Return-Path: <SRS0=g5d9=RD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 33398C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Feb 2019 18:35:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EDE04218AE
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Feb 2019 18:35:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1551378949;
	bh=CYMuqIs10Bp6U+BRTIMumppusThXa3xpvEIv+xKhE70=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=mt5VsD2qxEMDIlrBjKyEBYPZrYmdduG6WbglevgqX6CVOb4rnTzV52nBncpYGpbGb
	 1Gad6Fpa9/dnCpvRSsaAGBPKGU4oEiW8F2B/sSQLgPG1tI5Y2raZjjYbk9ibv6rbhI
	 2OhhTQ1sWwyCpfepGTCgCwYH/H2JKEJvbcmnvLVg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387930AbfB1Sfr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Feb 2019 13:35:47 -0500
Received: from mail-oi1-f194.google.com ([209.85.167.194]:33974 "EHLO
        mail-oi1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726093AbfB1Sfq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Feb 2019 13:35:46 -0500
Received: by mail-oi1-f194.google.com with SMTP id g16so17349195oib.1;
        Thu, 28 Feb 2019 10:35:45 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=PkBCcqIYGqPk5IqksiUv8C0l/gLNJICCqdyoCtuZ0Pk=;
        b=VaXiSIyUeXNtZUakbz0Li/SJOqiDemxMvfbPEiJJF6pbDOM5r45t73E6mKeYYiC6IS
         5lBfU18Hyr+isdGO+wqkII4HWGYv0xwHGmzOTpdX3RmfXDW3tUxUr1/A+MaUTHp3bBSW
         Z6cvMpUWesck4xkqPJP5qOGYeiCYCY8lvVQWwY5BCGaRbm56sftPIZ/8SVd9oQfcSMVC
         0RHZ8Y/r7EHt6vMA27K9iQ4Twy8QACFb3u1Stf0dfTGzx3/FJlrFR8O9osxNZ+uN6UXd
         +k8aMhKtyROgbKhpcjqOoREvROSdRay6clOTlcBZ18ipd3xzNbK0oNzCUHq1zDQCmrvX
         eydA==
X-Gm-Message-State: AHQUAuZyFoiX7ov/JdaePgW0yjf+1W2Ulq89Ou+nXcDAUxLxkU6DvH8N
        +ssdtGCE/QrgphVXmDbOkA==
X-Google-Smtp-Source: AHgI3Ibbr6SzY1ytZxdivQDv02Bm9gC+ommpwuoaRNmbHFiQkTd6GKKg+Dy2EpqPJC5GQAJTzNgA2A==
X-Received: by 2002:aca:6046:: with SMTP id u67mr724492oib.84.1551378945571;
        Thu, 28 Feb 2019 10:35:45 -0800 (PST)
Received: from localhost (ip-184-203-129-180.hstntx.spcsdns.net. [184.203.129.180])
        by smtp.gmail.com with ESMTPSA id l134sm8581711oih.43.2019.02.28.10.35.44
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 28 Feb 2019 10:35:45 -0800 (PST)
Date:   Thu, 28 Feb 2019 12:35:43 -0600
From:   Rob Herring <robh@kernel.org>
To:     sean.wang@mediatek.com
Cc:     robh+dt@kernel.org, mark.rutland@arm.com, marcel@holtmann.org,
        johan.hedberg@gmail.com, devicetree@vger.kernel.org,
        linux-bluetooth@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org,
        Sean Wang <sean.wang@mediatek.com>
Subject: Re: [PATCH 1/6] dt-bindings: net: bluetooth: add support for
 MediaTek MT7663U and MT7668U UART devices
Message-ID: <20190228183543.GA4454@bogus>
References: <cover.1550184473.git.sean.wang@mediatek.com>
 <c31b9ed0f2c711f53ad88c96f2d0a1bd22d9de58.1550184473.git.sean.wang@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c31b9ed0f2c711f53ad88c96f2d0a1bd22d9de58.1550184473.git.sean.wang@mediatek.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 15 Feb 2019 07:19:33 +0800, <sean.wang@mediatek.com> wrote:
> From: Sean Wang <sean.wang@mediatek.com>
> 
> Update binding document with adding support of MT7663U and MT7668U UART
> devices to mediatek-bluetooth.
> 
> Signed-off-by: Sean Wang <sean.wang@mediatek.com>
> ---
>  .../bindings/net/mediatek-bluetooth.txt       | 64 +++++++++++++++++++
>  1 file changed, 64 insertions(+)
> 

Reviewed-by: Rob Herring <robh@kernel.org>
