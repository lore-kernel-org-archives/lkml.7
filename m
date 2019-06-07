Return-Path: <SRS0=2dYc=UG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AFAA4C2BCA1
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Jun 2019 22:30:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6C3C320449
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Jun 2019 22:30:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="gw/ducDl"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731331AbfFGWal (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Jun 2019 18:30:41 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:46345 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730078AbfFGWal (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Jun 2019 18:30:41 -0400
Received: by mail-pf1-f196.google.com with SMTP id 81so1921524pfy.13
        for <linux-kernel@vger.kernel.org>; Fri, 07 Jun 2019 15:30:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:in-reply-to:references:date:message-id
         :mime-version;
        bh=XuNCqjePqDvn4lAEhRpdjQcT7X3J/79/6r+E49pUakU=;
        b=gw/ducDlQdQHPd+e6gp+F3SvSKhifcRtoemwoSufIWDlzHTVLxsWk5tHcjkWqm2SO1
         tN/RRohWoYf0MJ3QN9qsILayDbUxjOjAV3YMrwQjsRKgjeyiUQEoFOhFSArcIH3cBPZt
         yIPZU1wsKCH4uCOmfTDiErxn0oQEMRvwp7ksoCo17k+Hz8AXuXxvPyQZ92Tg3HnyoauH
         4z1tb1/YoR4PFKHxWiR/UM6lu4eW0+8z7Tomy+M1EaWfXSWlHBTMBnk6o7IwkWKvR5JF
         3F5Q2NB7eMmMh0R+Qm1ZebZ69zXf48qNpY+W8L+J5kNJRX9hfI5K9Qyb91brjKj2EAw8
         fegg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version;
        bh=XuNCqjePqDvn4lAEhRpdjQcT7X3J/79/6r+E49pUakU=;
        b=MLisZ6A5zEzXlvegwqjjtXg9GI3UB5a3ZI/RjvdUdTHh1o9u8/i8a7Tdi9ppqQowFp
         3m684kn5sWeeDQ6/bJCHwdHfmwbYMXvBfOUpDqs/VKG5lzVeDXJ6bjimeLq5KbmcicIC
         1WgDS44coMW6GdG8FK/Evy3hoJIMYyk9tgRkm0Ej67OsdSuhwU7oAPPI80qRZX6nDVns
         UohlHghmmnRaNMM2mISiBd/UECmuH6waiOWuLAI6bh+Si9q0VsRcaMIKMC89O4lUATAR
         k7xdeszJRHh8GoI3T/lsA96SVxH/4m0Oo7Aq08qjSZJvgDnI0W0QBXZ3eDYVzNQhJtob
         liAg==
X-Gm-Message-State: APjAAAUlAvyPI0uYL3/AWQ/zsMwhUpjbrd2igqvCnRAco8zvFUd326Uj
        5HfJt5ixugBnnxovfW1x/1aqPw==
X-Google-Smtp-Source: APXvYqwhZ/RJub3yjH06HYykOBY+dB3JKtBPnK4S+3FVx2KVlZSVwKWa7uqea2cume7geYK5drxJBw==
X-Received: by 2002:a62:7656:: with SMTP id r83mr37066043pfc.56.1559946640632;
        Fri, 07 Jun 2019 15:30:40 -0700 (PDT)
Received: from localhost (c-71-197-186-152.hsd1.wa.comcast.net. [71.197.186.152])
        by smtp.googlemail.com with ESMTPSA id 24sm3008135pgn.32.2019.06.07.15.30.36
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 07 Jun 2019 15:30:36 -0700 (PDT)
From:   Kevin Hilman <khilman@baylibre.com>
To:     Neil Armstrong <narmstrong@baylibre.com>
Cc:     linux-amlogic@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Neil Armstrong <narmstrong@baylibre.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Subject: Re: [PATCH v2 4/4] arm64: dts: meson-g12a-x96-max: bump bluetooth bus speed to 2Mbaud/s
In-Reply-To: <20190607143618.32213-5-narmstrong@baylibre.com>
References: <20190607143618.32213-1-narmstrong@baylibre.com> <20190607143618.32213-5-narmstrong@baylibre.com>
Date:   Fri, 07 Jun 2019 15:30:36 -0700
Message-ID: <7htvd1av03.fsf@baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Neil Armstrong <narmstrong@baylibre.com> writes:

> Setting to 2Mbaud/s is the nominal bus speed for common usages.
>
> Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>
> Acked-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>

Queued for v5.3,

Thanks,

Kevin
