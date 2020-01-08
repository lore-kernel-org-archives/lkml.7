Return-Path: <SRS0=XcGb=25=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7CC13C33CA1
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Jan 2020 16:59:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 49BA120692
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Jan 2020 16:59:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1578502796;
	bh=fml7quVSmpOHFOMfX/NoIXZg4+D06pcWxtfmE/xysNI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=rpR8E19rQoRMHZkwKW5AZLlA/XgyZMiXK9dM8nAJPBddP225+3UMD3bXI//TuWCOV
	 WF+6QevIrmxaenmRu1xcGoJT9dwCHu16Aejn3HWzs5QzkVTcRnwb3kUUeWJ2OHEoFJ
	 l91Pt3ajxeuFmt5cnvdQxDB/+KuwUo2wFewi/vXo=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729636AbgAHQ7z (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 8 Jan 2020 11:59:55 -0500
Received: from mail-ot1-f68.google.com ([209.85.210.68]:35927 "EHLO
        mail-ot1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729566AbgAHQ7z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Jan 2020 11:59:55 -0500
Received: by mail-ot1-f68.google.com with SMTP id 19so4270075otz.3
        for <linux-kernel@vger.kernel.org>; Wed, 08 Jan 2020 08:59:55 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=d2GY+NVVosTDVmvibNwMNQRy5RHqvmx65T16ZeJgxvo=;
        b=eeLyCA/0APt41H4sPXUDWD3ShD7hBoQNqC8Z1siCgCjRoQkaBSMxyi/o5ntUHSoU38
         EC+ZZKga0ovcwyJkU2zVXT1jbgvkhs2RlgbZNK8H0gPMD9UhD1UMsgio4ytjIhXalvkG
         J9ibLxbBm6HZStJBb75tDEKaIptEfEcgD1IdrxMPbvj+fdXDANgKkgDJGXDcEZnb2qjo
         j2KSpn0RgeOy5aR6QbUtShux47TDaosOachiKU/qIemJmhaWas32sGtBdEh7MGj5gwtj
         fIRMCXKhSWJYGRIEpl/uqUcaoNqOVBzVahGBHFWFtRens3sA55fG5FAO9DbSTUKd7dea
         tPdw==
X-Gm-Message-State: APjAAAVM2dZ8ALJc1DX8futgX+Q1Yfm8zO+r6WuP3iTOrYCzdayvgmDy
        nrqlMieWoRZbcbohGBOfmVFDtp4=
X-Google-Smtp-Source: APXvYqyRFXhwBF51yPSGN5A7PV1oBGjs7Bk4h+suizfhrD9vOMCaabSQqi6EshxQ0/8aenyQGGjjlw==
X-Received: by 2002:a9d:1c95:: with SMTP id l21mr4852352ota.271.1578502794329;
        Wed, 08 Jan 2020 08:59:54 -0800 (PST)
Received: from rob-hp-laptop (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id n22sm1309286otj.36.2020.01.08.08.59.51
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Jan 2020 08:59:52 -0800 (PST)
Received: from rob (uid 1000)
        (envelope-from rob@rob-hp-laptop)
        id 220333
        by rob-hp-laptop (DragonFly Mail Agent v0.11);
        Wed, 08 Jan 2020 10:59:51 -0600
Date:   Wed, 8 Jan 2020 10:59:51 -0600
From:   Rob Herring <robh@kernel.org>
To:     Artur Rojek <contact@artur-rojek.eu>
Cc:     Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Paul Cercueil <paul@crapouillou.net>,
        linux-input@vger.kernel.org, devicetree@vger.kernel.org,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
        Artur Rojek <contact@artur-rojek.eu>
Subject: Re: [PATCH 2/5] dt-bindings: iio/adc: Add touchscreen idx for JZ47xx
 SoC ADC
Message-ID: <20200108165951.GA10221@bogus>
References: <20200105001639.142061-1-contact@artur-rojek.eu>
 <20200105001639.142061-2-contact@artur-rojek.eu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200105001639.142061-2-contact@artur-rojek.eu>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun,  5 Jan 2020 01:16:36 +0100, Artur Rojek wrote:
> Introduce support for touchscreen channels found in JZ47xx SoCs.
> 
> Signed-off-by: Artur Rojek <contact@artur-rojek.eu>
> Tested-by: Paul Cercueil <paul@crapouillou.net>
> ---
>  include/dt-bindings/iio/adc/ingenic,adc.h | 2 ++
>  1 file changed, 2 insertions(+)
> 

Acked-by: Rob Herring <robh@kernel.org>
