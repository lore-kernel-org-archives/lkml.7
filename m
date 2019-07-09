Return-Path: <SRS0=gj9M=VG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 80B9DC606CF
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Jul 2019 02:28:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 58E86216C4
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Jul 2019 02:28:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1562639335;
	bh=g9nKDW9y7r5aGxXngURqJSOiVebXXlsfWjOCc2hRFBw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=P/DxnkmhavywufBfF48oMnFgMYqQzt39r3P5lZS3gVW4lNeSwnMN653nrGE07HGuA
	 tpwfcU1qPT27ekBS8hfLAjW81lgTJXJFIoE6E2SSn7GEZRSM77FeAHX1FS84yzg/xd
	 FFZ70qABdLv23jYS8dHlV3vH8UjL/3V+4T7I32RQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727059AbfGIC2y (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Jul 2019 22:28:54 -0400
Received: from mail-io1-f66.google.com ([209.85.166.66]:44290 "EHLO
        mail-io1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725886AbfGIC2y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Jul 2019 22:28:54 -0400
Received: by mail-io1-f66.google.com with SMTP id s7so39821409iob.11;
        Mon, 08 Jul 2019 19:28:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=3eMI25TMjMhXgi4o8mT6brExi7SJNcgzDLJEzsvQung=;
        b=cYw43l4Sqo+I97pbCsNbsuDq9D33GJE0u9GZLau3GvOaQ81vdz5rGO8TTGlz3zxaAY
         t+CODmD7tJA4AwGXIhEJo4VsuswZ4kQeDpmDT1Fr2LN1+Q6HOTSHNpyGRTuX+w7pnUua
         7ibv1/9B18F2IqPv49cobTc/vyZ/2kmv57csNeCD6k0xwLS1+iDiGewIph4w9nYXpn0L
         cDUgF2+i1QTE6O2eg+uNGJ4rpmofhZk7R1QaM7z4i5pvvSA0bR707LeVsJFHoihDfoyG
         TIFSyPA37KUC4pEGIwdqYmqc1KmAdAzFFgNiyC6+v2+ETe3qK8rQv96coGM/LndXMPxh
         WFGw==
X-Gm-Message-State: APjAAAUqaFGsXytSXCtE3xUt+oJuAAvoJp7GMbEO2ijOaRHXxdaVk5qg
        nzWQXolbpYcwapYE1LhcPg==
X-Google-Smtp-Source: APXvYqyHr4jZZoJjV8UUgOHoNnDbmjyv3LXE3PkWqpn9SPPMtZP84tRkS4C8fUpoVCpcpBMJk1LEUQ==
X-Received: by 2002:a6b:f910:: with SMTP id j16mr19739493iog.256.1562639332885;
        Mon, 08 Jul 2019 19:28:52 -0700 (PDT)
Received: from localhost ([64.188.179.252])
        by smtp.gmail.com with ESMTPSA id m4sm31701032iok.68.2019.07.08.19.28.51
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Mon, 08 Jul 2019 19:28:52 -0700 (PDT)
Date:   Mon, 8 Jul 2019 20:28:51 -0600
From:   Rob Herring <robh@kernel.org>
To:     Anson.Huang@nxp.com
Cc:     robh+dt@kernel.org, mark.rutland@arm.com, shawnguo@kernel.org,
        s.hauer@pengutronix.de, kernel@pengutronix.de, festevam@gmail.com,
        a.zummo@towertech.it, alexandre.belloni@bootlin.com,
        aisheng.dong@nxp.com, ulf.hansson@linaro.org, peng.fan@nxp.com,
        daniel.baluta@nxp.com, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-rtc@vger.kernel.org, Linux-imx@nxp.com
Subject: Re: [PATCH 1/3] dt-bindings: fsl: scu: Update RTC compatible string
Message-ID: <20190709022851.GA28421@bogus>
References: <20190611063333.48501-1-Anson.Huang@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190611063333.48501-1-Anson.Huang@nxp.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 11 Jun 2019 14:33:31 +0800, Anson.Huang@nxp.com wrote:
> From: Anson Huang <Anson.Huang@nxp.com>
> 
> Update RTC compatible string to make system controller RTC
> driver more generic for all i.MX SoCs with system controller
> inside.
> 
> Signed-off-by: Anson Huang <Anson.Huang@nxp.com>
> ---
> This patch should be based on below patch which is already picked by
> watchdog maintainer:
> https://patchwork.kernel.org/patch/10962183/
> ---
>  Documentation/devicetree/bindings/arm/freescale/fsl,scu.txt | 6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)
> 

Reviewed-by: Rob Herring <robh@kernel.org>
