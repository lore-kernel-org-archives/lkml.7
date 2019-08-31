Return-Path: <SRS0=k4ck=W3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 30AAEC3A5A8
	for <linux-kernel@archiver.kernel.org>; Sat, 31 Aug 2019 15:08:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 052FF217D7
	for <linux-kernel@archiver.kernel.org>; Sat, 31 Aug 2019 15:08:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="sgqBhc1i"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728314AbfHaPI5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 31 Aug 2019 11:08:57 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:40692 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726705AbfHaPI4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 31 Aug 2019 11:08:56 -0400
Received: by mail-pf1-f196.google.com with SMTP id w16so6434296pfn.7;
        Sat, 31 Aug 2019 08:08:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=eky3WHoxHJCo0ovTEewNnX9X46RkqUom31Mc/9+9MuI=;
        b=sgqBhc1i0yodkIStwgmptDDOGMTibmy2Yxb9ld4upRyZkEhSSOGE27vxk8wb/nKsNl
         VCGmcDJkEclj8VfbPcMZNGzdVBkShTOViWrPGG+2uf5NpwxvPsxcGP3DdOSKfegAW+ZU
         FlPPgCQ4eqU6mc0Qk+/rM0pEnQKRgxgNTq2GF4HQM2ZERmN4JLUWSCG7rjFDCnmsJ9Pj
         80de/bllQlxvWrZU247PYTN8/YGHfaqLASBN7kGH2OfckCrEiwIVzKe6pSvmpnFJFDSM
         4GvbU6e/bQctw7i6x4koixp0/7MMEzGajkL6Mx59G4KPJrWGSmgMhhjGq2wUKmZwKj8b
         TOQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=eky3WHoxHJCo0ovTEewNnX9X46RkqUom31Mc/9+9MuI=;
        b=VxpdaEAsSZMNUBKhYTaTIvgMG29QRBK8TUfDkFYFClCzJ9U5Am3YVIEOkPeTkzWC/i
         MVMe3/w07arSewb95S9LFsR8zYZyPekftbPnhGr90ntbPHhALK/6p8Tu1Zl8uSs6hk91
         m10s2cSIORVuSm8X2KLz2True6Qp/CSpOsmp+MJm8XM4l7efJuCiZvDeDoCYWxJl3ScX
         0KrzStwdpZnxVlZCi/cj6M4LDXFuwgjXm6lbd3zV3ic2c810PVpuEGsxo23An+opuFPo
         4sYptzDgVpJvgl8gmW9Guh5OPYQagZ68Me0VKjKyb3g4372pELkmsOiHPDWJumMfaKzG
         c85A==
X-Gm-Message-State: APjAAAXAMJ7nTdS3ZjeEoRWHunOTO1Pc4q0CGLZIz5njDaS+wvZLbB9T
        JnGbc//dqou6liFcc9NvTso=
X-Google-Smtp-Source: APXvYqxO3o6pIDP/l7+Lf0cDjIgbk27UMgfqpNk6SBZq9uhRjE7aneQpTek+jsOSL4x4ralxt8B00w==
X-Received: by 2002:a62:1bc5:: with SMTP id b188mr3560024pfb.210.1567264135862;
        Sat, 31 Aug 2019 08:08:55 -0700 (PDT)
Received: from localhost ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id a23sm10295586pfo.80.2019.08.31.08.08.55
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 31 Aug 2019 08:08:55 -0700 (PDT)
Date:   Sat, 31 Aug 2019 08:08:54 -0700
From:   Guenter Roeck <linux@roeck-us.net>
To:     Jisheng Zhang <Jisheng.Zhang@synaptics.com>
Cc:     Jean Delvare <jdelvare@suse.com>, Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        "linux-hwmon@vger.kernel.org" <linux-hwmon@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 2/2] hwmon: (as370-hwmon) Add DT bindings for
 Synaptics AS370 PVT
Message-ID: <20190831150854.GA8653@roeck-us.net>
References: <20190827113214.13773d45@xhacker.debian>
 <20190827113337.384457f6@xhacker.debian>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190827113337.384457f6@xhacker.debian>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 27, 2019 at 03:44:57AM +0000, Jisheng Zhang wrote:
> Add device tree bindings for Synaptics AS370 PVT sensors.
> 
> Signed-off-by: Jisheng Zhang <Jisheng.Zhang@synaptics.com>

For my reference:

Reviewed-by: Guenter Roeck <linux@roeck-us.net>

... but we'll have to wait for DT maintainer review.

> ---
>  Documentation/devicetree/bindings/hwmon/as370.txt | 11 +++++++++++
>  1 file changed, 11 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/hwmon/as370.txt
> 
> diff --git a/Documentation/devicetree/bindings/hwmon/as370.txt b/Documentation/devicetree/bindings/hwmon/as370.txt
> new file mode 100644
> index 000000000000..d102fe765124
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/hwmon/as370.txt
> @@ -0,0 +1,11 @@
> +Bindings for Synaptics AS370 PVT sensors
> +
> +Required properties:
> +- compatible : "syna,as370-hwmon"
> +- reg        : address and length of the register set.
> +
> +Example:
> +	hwmon@ea0810 {
> +		compatible = "syna,as370-hwmon";
> +		reg = <0xea0810 0xc>;
> +	};
