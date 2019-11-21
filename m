Return-Path: <SRS0=lLEG=ZN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 541EFC432C0
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Nov 2019 23:41:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1EFB2206B6
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Nov 2019 23:41:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="ATla5Mm3"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726573AbfKUXlR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Nov 2019 18:41:17 -0500
Received: from mail-io1-f65.google.com ([209.85.166.65]:42020 "EHLO
        mail-io1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725956AbfKUXlQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Nov 2019 18:41:16 -0500
Received: by mail-io1-f65.google.com with SMTP id k13so5646227ioa.9
        for <linux-kernel@vger.kernel.org>; Thu, 21 Nov 2019 15:41:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:in-reply-to:references:date:message-id
         :mime-version;
        bh=uACTtkuIJfMaBrmrOMjqpsbLeXCbKKhLGPjsdUGUn50=;
        b=ATla5Mm3z+aOSJ66NK85YT1q/SnFkBStQC85FhCDpIB9Top6rOmlTlPOyJIUuzjr8o
         6K53jRv0jQY8JJhsE0zzzA3Yh+g1U0ynGzpnNk1J27pNFx2cTJQHqhQ6DinQWKVvs//i
         TT3JD5gxhoEf2clL7ZIpum5r2Xn6IsRfa655X3Ck7rrsV7EoAQPCPLOfT9yxDHi7aKIJ
         cYk3nZtXTb/oqDHDTvx3xNCdHMeLaDHiv9QyqUZksP55YyxUgywibz2EbJg3yFvmS00f
         /I8+3l8qmalkpGCA5v+iJU9PPKR8BbRV3aApbaSwxSTHOjmrPeQIE/FDuE87o6HA9Yzj
         xKtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version;
        bh=uACTtkuIJfMaBrmrOMjqpsbLeXCbKKhLGPjsdUGUn50=;
        b=U9boSdcROsvEn5Zbz2byEiZwmrPoAf09yLV54egU/klL3GRNMji2KAlPIz+Q8A3I4w
         mMvrLWIEU5lwX1BOmdFL79aoPWdCVTChzWvuff+wngFSelujwqUlhAy0oo/CSq0Lff/0
         Gbl3fjXFJkbt+3iJVeQLvIhT6bv9ctiaIJ22HO2gYmw2FtQynAMvdmFNzdvDDTMna2AR
         Usjj6OBwf/a6Csju7mXf5aCsxPXL/1LkRTTQqsMLW7yoKKLkT0yhOd0turutR2A3Y/dS
         HwqdodxsHtwZVvNQD2Tmf7ioJyhmnWKDx5ITfPzxsnEdvF6GDcyBYY5VG0CENgKufwwC
         Ao/Q==
X-Gm-Message-State: APjAAAXTkL4NkXVcOOXqTMYSCWFyreBtfviTU/daQq9D7wD9GIy6btrR
        fqrgo92gNq2LY1ZNoeRNPo33Rw==
X-Google-Smtp-Source: APXvYqxM0XCrMtbJZmjbWGBiasGzyQbYZ89bcym0RaLoJmTu15rbGtwOEw3ToJQeqvDJifnXmvORMg==
X-Received: by 2002:a6b:e518:: with SMTP id y24mr9835193ioc.244.1574379674403;
        Thu, 21 Nov 2019 15:41:14 -0800 (PST)
Received: from localhost (c-71-197-186-152.hsd1.wa.comcast.net. [71.197.186.152])
        by smtp.gmail.com with ESMTPSA id j23sm4544131pfe.95.2019.11.21.15.41.13
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 21 Nov 2019 15:41:13 -0800 (PST)
From:   Kevin Hilman <khilman@baylibre.com>
To:     Krzysztof Kozlowski <krzk@kernel.org>, linux-kernel@vger.kernel.org
Cc:     Krzysztof Kozlowski <krzk@kernel.org>,
        Kevin Hilman <khilman@kernel.org>, Nishanth Menon <nm@ti.com>,
        linux-pm@vger.kernel.org
Subject: Re: [PATCH] power: avs: Fix Kconfig indentation
In-Reply-To: <20191120134004.14167-1-krzk@kernel.org>
References: <20191120134004.14167-1-krzk@kernel.org>
Date:   Thu, 21 Nov 2019 15:41:13 -0800
Message-ID: <7ho8x4n6g6.fsf@baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Krzysztof Kozlowski <krzk@kernel.org> writes:

> Adjust indentation from spaces to tab (+optional two spaces) as in
> coding style with command like:
> 	$ sed -e 's/^        /\t/' -i */Kconfig
>
> Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>

Acked-by: Kevin Hilman <khilman@baylibre.com>

Rafael, feel free to apply directly.

Kevin
