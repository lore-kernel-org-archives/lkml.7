Return-Path: <SRS0=HfRD=XN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8FBCDC4CEC4
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Sep 2019 13:33:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6339621927
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Sep 2019 13:33:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1568813617;
	bh=+6RskpzHubrqtYuleHKvIKl7wnFnCNCZu6nDFQfhRKk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=NUEp+jYK7a5iiCFs8Z6xbhVtCumpZhYlcr8EKCIrQvAWAg/WMMo9TS8ocyiCHvOFh
	 dDY4bF/Wv9jm1odzTzGsASM0SeaTs+m46Q+al4JKHJiMP2KmXddhQVfB4Kyf/5QznV
	 2yy5KuwvS2RIa6wiOKOW274u9pLTMDhBoHwkW+jg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728855AbfIRNdg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 18 Sep 2019 09:33:36 -0400
Received: from mail-oi1-f196.google.com ([209.85.167.196]:34345 "EHLO
        mail-oi1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726330AbfIRNdg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Sep 2019 09:33:36 -0400
Received: by mail-oi1-f196.google.com with SMTP id 83so4472264oii.1;
        Wed, 18 Sep 2019 06:33:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=IC0q0Es9HxTLSb0PNX9pAw25DkwUzoXEjlENlSs4w9s=;
        b=RO2NvdfYoCMxHn8ofhA9A9No7lG7bgZmAL/y6oozoHHfN2SNvTZUdeOzrYdMigk54c
         PhOMkiSY6ARlsOIcQ0nbsYQdd0eG0ntz9jqzs8bxIA/o8pGAPF/zRnlL5y9FKkXcsVkn
         FL2N7f8AxCg9iWFi0Ehg4xynWT8i71hxR6XjxsDs0M7GQ6+B/1LG18nbBtWN5l9ckP0T
         0E/+UmTxqwbJ/vQLhL7UkqU8VQ83yNf348eRwRqqSvvKQ3UNAXri/dAzFhp/GngKe9Mt
         iWD8iAtc8fdqDxxlWuCg4NqRNiz9+uUA0JFog6XrMWZjP7rfZ22mLqFZ/ti0Sagb6mpH
         jPaw==
X-Gm-Message-State: APjAAAXYlAT6JC8kc3AESNppV7Xd/Dpc++QzmU3kGKT6T9xZYAqPDLiH
        mAsMR+qS+WOsCHkwlsGVaw==
X-Google-Smtp-Source: APXvYqzFKo2zD3kzQfStRe6u5Z04KLvlPbxnoLNER1RO58XbbuUaDka1izzgYXa3YK3Q2YrDvoHnFg==
X-Received: by 2002:aca:f50b:: with SMTP id t11mr2237475oih.1.1568813615350;
        Wed, 18 Sep 2019 06:33:35 -0700 (PDT)
Received: from localhost (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id n9sm632424otn.4.2019.09.18.06.33.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Sep 2019 06:33:34 -0700 (PDT)
Date:   Wed, 18 Sep 2019 08:33:33 -0500
From:   Rob Herring <robh@kernel.org>
To:     Guido =?iso-8859-1?Q?G=FCnther?= <agx@sigxcpu.org>
Cc:     "To : Lucas Stach" <l.stach@pengutronix.de>,
        Russell King <linux+etnaviv@armlinux.org.uk>,
        Christian Gmeiner <christian.gmeiner@gmail.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Abel Vesa <abel.vesa@nxp.com>,
        Anson Huang <Anson.Huang@nxp.com>,
        Carlo Caione <ccaione@baylibre.com>,
        Guido =?iso-8859-1?Q?G=FCnther?= <agx@sigxcpu.org>,
        Andrey Smirnov <andrew.smirnov@gmail.com>,
        "Angus Ainslie (Purism)" <angus@akkea.ca>,
        etnaviv@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v2 2/2] dt-bindings: etnaviv: Add #cooling-cells
Message-ID: <20190918133333.GA21684@bogus>
References: <cover.1568255903.git.agx@sigxcpu.org>
 <6e9d761598b2361532146f43161fd05f3eee6545.1568255903.git.agx@sigxcpu.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <6e9d761598b2361532146f43161fd05f3eee6545.1568255903.git.agx@sigxcpu.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 11 Sep 2019 19:40:36 -0700, =?UTF-8?q?Guido=20G=C3=BCnther?= wrote:
> Add #cooling-cells for when the gpu acts as a cooling device.
> 
> Signed-off-by: Guido Günther <agx@sigxcpu.org>
> ---
>  .../devicetree/bindings/display/etnaviv/etnaviv-drm.txt          | 1 +
>  1 file changed, 1 insertion(+)
> 

Acked-by: Rob Herring <robh@kernel.org>
