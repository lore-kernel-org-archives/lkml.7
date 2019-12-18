Return-Path: <SRS0=eolO=2I=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D72D8C3F68F
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Dec 2019 22:30:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AB06B227BF
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Dec 2019 22:30:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1576708237;
	bh=XjMNns/AfJ24HckxqC5o69oz0oIIXN17O0aeo+qdIJE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=ZiWbDJPmvMiTCVL8vmY8ax4qM/AJUPm0ysfplkzG6N67Jsc2y811t5iX7tmnEmT6h
	 /9SiMdX4Ex13VDYCSAGKoVgmH61uw5T8f6aKQ3O1Z8FXlmeyuX+X5fe0pJtIdAmw7u
	 +E6f1c9bYADa0XdDn/mKHQJrwMX2+l9LuSrY/lGY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726609AbfLRWah (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 18 Dec 2019 17:30:37 -0500
Received: from mail-oi1-f195.google.com ([209.85.167.195]:46515 "EHLO
        mail-oi1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726463AbfLRWag (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Dec 2019 17:30:36 -0500
Received: by mail-oi1-f195.google.com with SMTP id p67so2033819oib.13;
        Wed, 18 Dec 2019 14:30:36 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=henTx4kMwKnslxCfjb7Jc5XD6OiwjKcuIcYzzOgVmwA=;
        b=rjMqZ9JoosShjDq17xQceinYMUnG1w8mok/R0RcIBOWnY+KT9bF612WoVIdH/wqv30
         NVn3gwB1xxwROl7dlEftut7teI/iSeXG90zbtAUenHsBWpiWoAN/Gp/lbG49EL8U2y7I
         GvlUJegPGhqlMKhivNgIrv6lqsJ7LWa9WLehVyjjTFcAS3u1yt1i+kdhGq3+PDZSfanV
         AL+60p94pgF4X0tyKN8Fgma/M+VibvQsKuOOEsmM2mWDRXbTbHZsbiemZjJBB8bnqUD5
         7dr4Ei3Vsjg6lhDV2VG6QiaEgJQQomgQ1AnS0n/L/gBlYwiSXXRnQERI6FT2/ZFu2y8M
         GFqQ==
X-Gm-Message-State: APjAAAWD8uw8pskcAG1ljh2XmSicve305hY+16TwR3OL1Sb1k24mfTbO
        gcpFVHLDGaXaX8raxxj6sw==
X-Google-Smtp-Source: APXvYqxlZwKyGVa1CGInnldPg2b0i+rjBq9zRrTXBBvNP2kjFzBkxQnXqGG30D+T5zzlRjhreEKJ1g==
X-Received: by 2002:aca:72cd:: with SMTP id p196mr1498724oic.99.1576708235818;
        Wed, 18 Dec 2019 14:30:35 -0800 (PST)
Received: from localhost (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id q5sm1290507oia.21.2019.12.18.14.30.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Dec 2019 14:30:34 -0800 (PST)
Date:   Wed, 18 Dec 2019 16:30:32 -0600
From:   Rob Herring <robh@kernel.org>
To:     Olivier Moysan <olivier.moysan@st.com>
Cc:     jic23@kernel.org, robh+dt@kernel.org, olivier.moysan@st.com,
        mark.rutland@arm.com, mcoquelin.stm32@gmail.com, lars@metafoo.de,
        devicetree@vger.kernel.org, linux-iio@vger.kernel.org,
        linux-kernel@vger.kernel.org, pmeerw@pmeerw.net, knaack.h@gmx.de,
        fabrice.gasnier@st.com, linux-stm32@st-md-mailman.stormreply.com,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v2] dt-bindings: iio: adc: convert sd modulator to
 json-schema
Message-ID: <20191218223032.GA8641@bogus>
References: <20191206100058.26767-1-olivier.moysan@st.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191206100058.26767-1-olivier.moysan@st.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 6 Dec 2019 11:00:58 +0100, Olivier Moysan wrote:
> Convert the sigma delta modulator bindings
> to DT schema format using json-schema.
> 
> Signed-off-by: Olivier Moysan <olivier.moysan@st.com>
> ---
> Changes since v1:
> - add additionalProperties
> - remove unit-address in example
> ---
>  .../iio/adc/sigma-delta-modulator.txt         | 13 -------
>  .../iio/adc/sigma-delta-modulator.yaml        | 37 +++++++++++++++++++
>  2 files changed, 37 insertions(+), 13 deletions(-)
>  delete mode 100644 Documentation/devicetree/bindings/iio/adc/sigma-delta-modulator.txt
>  create mode 100644 Documentation/devicetree/bindings/iio/adc/sigma-delta-modulator.yaml
> 

Reviewed-by: Rob Herring <robh@kernel.org>
