Return-Path: <SRS0=JAXG=U7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E132BC06510
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Jul 2019 09:51:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B768321841
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Jul 2019 09:51:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="qBSK4mPH"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727255AbfGBJv6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Jul 2019 05:51:58 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:47054 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727236AbfGBJv4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Jul 2019 05:51:56 -0400
Received: by mail-wr1-f68.google.com with SMTP id n4so16987437wrw.13
        for <linux-kernel@vger.kernel.org>; Tue, 02 Jul 2019 02:51:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:in-reply-to:references:date:message-id
         :mime-version;
        bh=q5AKb2Aq5cM23CpGFfqHRfDVm9/c55zJeMrlP2X57BQ=;
        b=qBSK4mPHwueHeFFFdMnsPrDgtnMK2xQQNILFIFKDGb5AgaTdKhFX0gEYTMeiS1C9e0
         KrPknp/kJO8pWTVTXeT+vODB4Z3ijy42pYYLFy0JwLBpizW5Z1K8vAIY6af5qUwYEQBr
         Drf/kb7mGBV+f3zKuaIEgtseCKCaaMKiI9+w6Of6tFcq1OuwoXGemJgNokc+1CBdxmuH
         4+2PMSH3e24bwhavxxTXHYHMvBMNHY0ZjQI44RRK9H+WuZ7IARVgxcs7uV3lqeiPLOOJ
         SsC37UqfBaqtk2IvxtMf2sSBPqGQXWSrFOkbBphM1aPpAI3Cn9nEiqAj87531tMI4VST
         bGog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version;
        bh=q5AKb2Aq5cM23CpGFfqHRfDVm9/c55zJeMrlP2X57BQ=;
        b=pbiBpCZ3fiuJ0tAplegLH/2xrTksxS0qx68fdZjXdvEvfXMFhDBJ+ze9RQo377MNxe
         Q1T0ayDXVcpgGBXNqAsv2KAbUpFjWtGIheBMKkWr1dDH4aP27OKPGq6Vi8r29mvoX4lF
         1JtEIlWlph3vgDPUQ9c4Q0vEPctWhFaxbXQXhn8agZioGUL9TLOyNpKkh5eYLoTpytsG
         JveeDbdh9WfIggGZHG62GAQInchRAd4LaRTWipd5OkwMFInI7ar17CzjeIx/YYuBSInF
         OrEBAmSZlp8Q2b0UMWXu88qvW5O/69GM0pIv6C5OAONkcQ2ev12+smN8sb1Q+n/4jNZd
         y4fg==
X-Gm-Message-State: APjAAAUFiQe0PBIoqE35kkteJRklbHdC/DRodKKX2CJXW3Ps+cEJjl4w
        fcpzILuKmgkNT+eBpGgOkr6XSA==
X-Google-Smtp-Source: APXvYqzI8kW9XU8FUJQ7IGAFwA6pRPzGymWZ5cX2bvdpELwcRzBOCEXK8fgrUKd0pUhUkjJf8qWPdQ==
X-Received: by 2002:adf:8028:: with SMTP id 37mr22701037wrk.106.1562061114977;
        Tue, 02 Jul 2019 02:51:54 -0700 (PDT)
Received: from localhost (lmontsouris-657-1-212-31.w90-63.abo.wanadoo.fr. [90.63.244.31])
        by smtp.gmail.com with ESMTPSA id 32sm27240587wra.35.2019.07.02.02.51.54
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Tue, 02 Jul 2019 02:51:54 -0700 (PDT)
From:   Jerome Brunet <jbrunet@baylibre.com>
To:     Neil Armstrong <narmstrong@baylibre.com>, khilman@baylibre.com
Cc:     linux-arm-kernel@lists.infradead.org,
        linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org,
        Neil Armstrong <narmstrong@baylibre.com>
Subject: Re: [RFC 01/11] soc: amlogic: meson-gx-socinfo: Add SM1 and S905X3 IDs
In-Reply-To: <20190701104705.18271-2-narmstrong@baylibre.com>
References: <20190701104705.18271-1-narmstrong@baylibre.com> <20190701104705.18271-2-narmstrong@baylibre.com>
Date:   Tue, 02 Jul 2019 11:51:53 +0200
Message-ID: <1jwoh03gsm.fsf@starbuckisacylon.baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon 01 Jul 2019 at 12:46, Neil Armstrong <narmstrong@baylibre.com> wrote:

> Add the SoC IDs for the S905X3 Amlogic SM1 SoC.
>
> Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>

Reviewed-by: Jerome Brunet <jbrunet@baylibre.com>

> ---
>  drivers/soc/amlogic/meson-gx-socinfo.c | 2 ++
>  1 file changed, 2 insertions(+)
>
> diff --git a/drivers/soc/amlogic/meson-gx-socinfo.c b/drivers/soc/amlogic/meson-gx-socinfo.c
> index bca34954518e..eb81d391b620 100644
> --- a/drivers/soc/amlogic/meson-gx-socinfo.c
> +++ b/drivers/soc/amlogic/meson-gx-socinfo.c
> @@ -39,6 +39,7 @@ static const struct meson_gx_soc_id {
>  	{ "TXHD", 0x27 },
>  	{ "G12A", 0x28 },
>  	{ "G12B", 0x29 },
> +	{ "SM1", 0x2b },
>  };
>  
>  static const struct meson_gx_package_id {
> @@ -65,6 +66,7 @@ static const struct meson_gx_package_id {
>  	{ "S905D2", 0x28, 0x10, 0xf0 },
>  	{ "S905X2", 0x28, 0x40, 0xf0 },
>  	{ "S922X", 0x29, 0x40, 0xf0 },
> +	{ "S905X3", 0x2b, 0x50, 0xf0 },
>  };
>  
>  static inline unsigned int socinfo_to_major(u32 socinfo)
> -- 
> 2.21.0
