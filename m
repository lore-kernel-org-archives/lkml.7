Return-Path: <SRS0=eolO=2I=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 602F3C2D0CD
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Dec 2019 14:46:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2D16E2176D
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Dec 2019 14:46:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1576680377;
	bh=ayaA8HGCeiW2cK6V3/U9NmS2ohMPmh3bkXazDi9E3ys=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=LApMQaiRtWCDzNXe4ZeRvhNpZ7trl5h0SEGv6pKDC/591e0+/GdQNR8GRJWZyTYDf
	 EHtm4cwYNDZf+OOkXPFaZ7GiBijQCtWh4OQDs2kLNoLdcg/w6nahdJCVBmigB/Yocu
	 lLXWidmWn6IUKv2ii0w6Po50aXncSUJAyZskMmWg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727329AbfLROqQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 18 Dec 2019 09:46:16 -0500
Received: from mail-ot1-f65.google.com ([209.85.210.65]:45777 "EHLO
        mail-ot1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727035AbfLROqP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Dec 2019 09:46:15 -0500
Received: by mail-ot1-f65.google.com with SMTP id 59so2757131otp.12;
        Wed, 18 Dec 2019 06:46:15 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=QMvYKTmBgMqaSDLYShyOWbrarWmJ7ZY2YWdxagGyLkY=;
        b=g1F/n0cU2rQPlszD5gWjgp0Vpu03bhy57HoFzvzKsVkfwPDQCTIIc1Q9KHhr1O4k6J
         EjhOndviYkLFBCpd2gYDXfcTxV0/HJqFkvig92AgDcD/MygvS4xQZzY4JWJNd4kLUA48
         GetXGvrCLlhRxCY0b30utlGfTXwmWbJoyYMpn1Rsd5vH2w8lG8rChPWH4ak053aLC9zv
         i9MNeFF/UTkkGT+matfI/rOcbDjHYJ+v9FIQiRq2EJs3NSUDQSwDHwtzeJxT/d7iSTMb
         bVhydpwWzy5fXyUnZWUkO4xKG+9WpKwNpzIpN+DVDH98qRyO9NkUsIzplFCsYy2lmaE+
         U+og==
X-Gm-Message-State: APjAAAVq/zIQPTibVDJWQUtzfFs79n6DAOjYV73rVpTWFM4MxU+vIsZG
        M3bBCjuTQ19wOb8aMUdw5A==
X-Google-Smtp-Source: APXvYqxKvHmRqZoC9So6WrfXEAYiPNvU0kBk09BT9Kn7huJ3PuV2RIiAZAFcHgfrk8UC/CAvPENwGQ==
X-Received: by 2002:a9d:5885:: with SMTP id x5mr2943074otg.132.1576680375036;
        Wed, 18 Dec 2019 06:46:15 -0800 (PST)
Received: from localhost (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id j202sm851434oih.8.2019.12.18.06.46.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Dec 2019 06:46:14 -0800 (PST)
Date:   Wed, 18 Dec 2019 08:46:13 -0600
From:   Rob Herring <robh@kernel.org>
To:     "Ramuthevar,Vadivel MuruganX" 
        <vadivel.muruganx.ramuthevar@linux.intel.com>
Cc:     linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        kishon@ti.com, andriy.shevchenko@intel.com,
        cheol.yong.kim@intel.com, qi-ming.wu@intel.com,
        peter.harliman.liem@intel.com,
        Ramuthevar Vadivel Murugan 
        <vadivel.muruganx.ramuthevar@linux.intel.com>
Subject: Re: [PATCH v10 1/2] dt-bindings: phy: intel-emmc-phy: Add YAML
 schema for LGM eMMC PHY
Message-ID: <20191218144613.GA31670@bogus>
References: <20191217015658.23017-1-vadivel.muruganx.ramuthevar@linux.intel.com>
 <20191217015658.23017-2-vadivel.muruganx.ramuthevar@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191217015658.23017-2-vadivel.muruganx.ramuthevar@linux.intel.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 17 Dec 2019 09:56:57 +0800, "Ramuthevar,Vadivel MuruganX"          wrote:
> From: Ramuthevar Vadivel Murugan <vadivel.muruganx.ramuthevar@linux.intel.com>
> 
> Add a YAML schema to use the host controller driver with the
> eMMC PHY on Intel's Lightning Mountain SoC.
> 
> Signed-off-by: Ramuthevar Vadivel Murugan <vadivel.muruganx.ramuthevar@linux.intel.com>
> ---
>  .../bindings/phy/intel,lgm-emmc-phy.yaml           | 56 ++++++++++++++++++++++
>  1 file changed, 56 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/phy/intel,lgm-emmc-phy.yaml
> 

Reviewed-by: Rob Herring <robh@kernel.org>
