Return-Path: <SRS0=4Jrr=RX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	USER_AGENT_MUTT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C6B7CC10F05
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Mar 2019 19:58:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9D25921841
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Mar 2019 19:58:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1553111880;
	bh=Q4sQ0l50w2SEEiowJQjFlX5B++Xl81kts1qbOe4DXCQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=r7/KkicyANLXQbdWYt1fQVPMIKO3CAXqZCkdK1cLJYHoeUpmc1bOoR1TANdHQyzxs
	 QR+4h/c4DaK0LQL1xClks9129gsy9Q+qoGNi5AJWiDlNTVJ9MyyuoHWQaPhyzNCzof
	 2UCeTvSG3MLTSCB6pDHA3ffyQReqvjh3mvrxC3ak=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727144AbfCTT57 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Mar 2019 15:57:59 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:39957 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726438AbfCTT57 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Mar 2019 15:57:59 -0400
Received: by mail-wr1-f68.google.com with SMTP id t5so4151030wri.7;
        Wed, 20 Mar 2019 12:57:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=N4GWAGGgWrbBQh4IIYll/+hQfh3uWru++oOxWo6IIyY=;
        b=Evw0EYEAbh28rxOdGVwEZDic5U/Lvh8mwC+BaahfB6JzJwRQiVthcWuIxf6PBPpn8C
         T6LcNIh2WXJO789mjfSOe4ZhZRuHPzZfUput/me0sn0k8nYRVscs2O3oTncFunt3G6Kg
         6D1h+OxZt19XznN/+HDlgjcMFGtzIk8Uq4pRJKl3s7Av11n923fDtC+wBnTlt5bGXam0
         eGe1ATbuSaWTs5dTzJDTBBfsA73wh9FNZbkYDXcLf2n9vxWNS2JpsOHoJoc2dsKCxAM0
         eGL2V/ya85LbzBj9ibc/qvlSHXwZpAaospYAct2vf8KXFMcP9XQ4P5BS8OEE/RGc7QTs
         fRbA==
X-Gm-Message-State: APjAAAXc/qRSVKvxgAJfclVCdomjgjAsVFUFSI8PtV+6ymIV5f+cQeMP
        HTjD1+6h7rz2SJglH2HMPQs=
X-Google-Smtp-Source: APXvYqwW/7DsAus+RsXAoh7q3VxUzrI5Aii0V3jIbJg1qmLq00z3P4VnTURk5stEzHzLwilcN3Tubg==
X-Received: by 2002:adf:ebc3:: with SMTP id v3mr6822wrn.35.1553111877109;
        Wed, 20 Mar 2019 12:57:57 -0700 (PDT)
Received: from kozik-lap ([194.230.155.153])
        by smtp.googlemail.com with ESMTPSA id a14sm3935142wrx.96.2019.03.20.12.57.55
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 20 Mar 2019 12:57:56 -0700 (PDT)
Date:   Wed, 20 Mar 2019 20:57:53 +0100
From:   Krzysztof Kozlowski <krzk@kernel.org>
To:     Sylwester Nawrocki <s.nawrocki@samsung.com>
Cc:     alsa-devel@alsa-project.org, linux-samsung-soc@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        devicetree@vger.kernel.org, robh+dt@kernel.org, kgene@kernel.org,
        b.zolnierkie@samsung.com, m.szyprowski@samsung.com,
        stable@vger.kernel.org
Subject: Re: [PATCH RESEND] ARM: dts: exynos: Fix audio (microphone) routing
 on Odroid XU3
Message-ID: <20190320195753.GA9956@kozik-lap>
References: <20190319205522.GD16150@kozik-lap>
 <CGME20190320100002epcas2p2c85f13b20896f837aa5a48643b917680@epcas2p2.samsung.com>
 <20190320095950.23566-1-s.nawrocki@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20190320095950.23566-1-s.nawrocki@samsung.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 20, 2019 at 10:59:50AM +0100, Sylwester Nawrocki wrote:
> The name of CODEC input widget to which microphone is connected through
> the "Headphone" jack is "IN12" not "IN1". This fixes microphone support
> on Odroid XU3.
> 
> Cc: <stable@vger.kernel.org> # v4.14+
> Signed-off-by: Sylwester Nawrocki <s.nawrocki@samsung.com>
> ---
>  arch/arm/boot/dts/exynos5422-odroidxu3-audio.dtsi | 2 +-

Thanks, applied.

Best regards,
Krzysztof

