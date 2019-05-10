Return-Path: <SRS0=sufd=TK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2CA75C04AB2
	for <linux-kernel@archiver.kernel.org>; Fri, 10 May 2019 16:52:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EFF242070D
	for <linux-kernel@archiver.kernel.org>; Fri, 10 May 2019 16:52:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="Kyl9xljP"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727980AbfEJQw0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 10 May 2019 12:52:26 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:38792 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727921AbfEJQwZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 May 2019 12:52:25 -0400
Received: by mail-wr1-f65.google.com with SMTP id v11so8680398wru.5
        for <linux-kernel@vger.kernel.org>; Fri, 10 May 2019 09:52:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=message-id:subject:from:to:cc:date:in-reply-to:references
         :user-agent:mime-version:content-transfer-encoding;
        bh=EdL93aDu1wQiagw0qz1g/jZBUerOff0Armk0aWzS8+Q=;
        b=Kyl9xljPXbBEnCFdzxUX38r1C1khREMVKXPgKj9QMql8+2KkAoEjx/zyXaqcrG/DiM
         mH4uVvZaJMEV4T3CBBBYbCpkwvsuhkpv3InVevpsNReKKXW5M22y1Jm9l9tZy8Xb7E2Y
         IbahXe5USV23dRsJAHnEO+cLRrYLz3aibVUqCqpfjJE/5XQ3yMuMaoAqQPagFEWUZgVc
         PmfXmZKQg0vzkh3cp/lUOuxZ36zV6TI/gZeVJruvDVrSZkgklAh9bejS/9+j6OuB/Sgb
         SGJefUbJ+kCtHUxtXxEDswab3rIzIx3AWRUrm6gquSn22FcoH6i49VD3pdfkjTvGpP03
         Sddg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:user-agent:mime-version:content-transfer-encoding;
        bh=EdL93aDu1wQiagw0qz1g/jZBUerOff0Armk0aWzS8+Q=;
        b=GCQTYn51FxKzGNC+3Ag/au/3vJGkrtcttlnVEijjsPdgGq5SxwGo6kDdiLghduCrB8
         ivIH/cFJHEJK7t0u3GsIaf+e9yDeNWSZaANGL2QHGdvnPfyGPVs/iGJchcsnbW7HIFGE
         lgyrrO1r5j7qhTqQZLeoMERlsbY8pHwAEQmjLteh3yQ7hulco08GK3inhOwXyDFB/PkS
         nAXZZSy51wIPBYWc/nDlQYHE235M9iU/WxHoNZXRWbNgfxO4zzloX7E//sGfmHRtTu7g
         qX4FQh2Z32mpOlLyiCDL0MM+sfhYuNhKkjXUdmsi++J584Xg8PAszw3fcmx0PMVuiMWd
         rISA==
X-Gm-Message-State: APjAAAU7VAYM5Eb8awCEU3fYy90mhNfCrvqH/14+V7JcI/Hmn2S8mUWc
        HhYpQDFOHikCIHD3Jlgl0VB0PQ==
X-Google-Smtp-Source: APXvYqz0lyOYwhb3SFsb+q9KO7qmePMS9hVr+rx5egvauVDdXB2VOaJIZl+JrgtFCwdwT8ul++b0AA==
X-Received: by 2002:adf:ee8d:: with SMTP id b13mr201821wro.219.1557507143391;
        Fri, 10 May 2019 09:52:23 -0700 (PDT)
Received: from boomer.baylibre.com (lmontsouris-657-1-212-31.w90-63.abo.wanadoo.fr. [90.63.244.31])
        by smtp.gmail.com with ESMTPSA id m8sm10365591wrg.18.2019.05.10.09.52.22
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Fri, 10 May 2019 09:52:22 -0700 (PDT)
Message-ID: <7b8ddc8de64b6d8947ac869ccd09ebb7e995130a.camel@baylibre.com>
Subject: Re: [PATCH 0/5] arm64: dts: meson: g12a: add network support
From:   Jerome Brunet <jbrunet@baylibre.com>
To:     Kevin Hilman <khilman@baylibre.com>
Cc:     linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org
Date:   Fri, 10 May 2019 18:52:21 +0200
In-Reply-To: <20190510164940.13496-1-jbrunet@baylibre.com>
References: <20190510164940.13496-1-jbrunet@baylibre.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.30.5 (3.30.5-1.fc29) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2019-05-10 at 18:49 +0200, Jerome Brunet wrote:
> Add network support for the g12a

I forgot to mention that series applies on top of the node
re-order series [0]

[0]: https://lkml.kernel.org/r/20190510155327.5759-1-jbrunet@baylibre.com

> 
> Jerome Brunet (5):
>   arm64: dts: meson: g12a: add ethernet mac controller
>   arm64: dts: meson: g12a: add ethernet pinctrl definitions
>   arm64: dts: meson: g12a: add mdio multiplexer
>   arm64: dts: meson: u200: add internal network
>   arm64: dts: meson: sei510: add network support
> 
>  .../boot/dts/amlogic/meson-g12a-sei510.dts    |  7 ++
>  .../boot/dts/amlogic/meson-g12a-u200.dts      |  7 ++
>  arch/arm64/boot/dts/amlogic/meson-g12a.dtsi   | 90 +++++++++++++++++++
>  3 files changed, 104 insertions(+)
> 


