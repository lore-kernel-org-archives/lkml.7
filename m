Return-Path: <SRS0=B1dt=RW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AC3CAC43381
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Mar 2019 09:11:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 79AA120828
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Mar 2019 09:11:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="2HDQVaSp"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727330AbfCSJLY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Mar 2019 05:11:24 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:35472 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726647AbfCSJLY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Mar 2019 05:11:24 -0400
Received: by mail-wm1-f65.google.com with SMTP id f8so938490wmh.0
        for <linux-kernel@vger.kernel.org>; Tue, 19 Mar 2019 02:11:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=message-id:subject:from:to:cc:date:in-reply-to:references
         :user-agent:mime-version:content-transfer-encoding;
        bh=OBhyq4n5SGWqCjrfChQye9qgetfLwZTxQxDkttOwm/Y=;
        b=2HDQVaSphB4nvyB/uQwhD9tnS7lpasSGWli592aXD4STjpWdylTeG1uPju1aZWUzNK
         liGTrB0DuRL6CP/F4Zp7w2Qw5L7UeajEJQHcjNqvAu9ZPiYNVRxOro2t/m0OcH6HJ7JX
         9+7lkQENacwneEr/25PR7/oqAtkKekGTQeVZf/H4M4bjBhWDPemZa8B7Q1qeAKTGc48q
         9lYBrpWGWGmG1RBcGZoxZkgcpkYyZ9Dvno/u8ThczTq0Xzc0m1TZQvMXlN3SPL0XnjCe
         hnfibX5oLAFcgbijQD96PWt8hlSKVwZQeBRmGNplkhZgZXZT0psmJU01x2klpV/0fcg+
         4s6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:user-agent:mime-version:content-transfer-encoding;
        bh=OBhyq4n5SGWqCjrfChQye9qgetfLwZTxQxDkttOwm/Y=;
        b=ASH1OWKC7Epm2ekfMoeQAi7WXsvnyHjdUDgi2I+arTEXh6th4JtrgLGMDNqawaS2kU
         ei6JgPwR5xGGFel3Ssew6DB5FWNPAxLRPl992YuRm52jR8KULur95Fa3VoQ8xZ6aXeOo
         0suNDbvMc7eJ+FURJqhz/OdywK6Z83enxP2d1TgwbEleJc5WlATZS68GiFjiIiyPhP9E
         2LB7904K2gnSEkTPOKeI9iAKhPkiD92laPzN42NFx/JA0va/H2zlS3YiBuBevf4bgUBk
         JSmbZm82tPtfFWxcmAQlxjwhgKHHCdGmV9/Riq2ibGybrFUPzeYW4OEWMS7HQ3ACuHRY
         mvLw==
X-Gm-Message-State: APjAAAXzHGjdfvYCSJ8IblU4GNM0CXkQNhLvxYCc9Kl5X6RJRFMhcMtf
        GZuKzf5ZsmgCIg4NMnUpraBupg==
X-Google-Smtp-Source: APXvYqyi7fJAhGJdYC/s+9y4g4QBbh9uvb+AjHuL2QeXxI2vyzaZk3IBRQ+iqJNss5t6tLR9LCZjiQ==
X-Received: by 2002:a1c:7a03:: with SMTP id v3mr2564249wmc.59.1552986682564;
        Tue, 19 Mar 2019 02:11:22 -0700 (PDT)
Received: from boomer.baylibre.com ([2a01:e34:eeb6:4690:106b:bae3:31ed:7561])
        by smtp.gmail.com with ESMTPSA id r15sm9084274wrt.37.2019.03.19.02.11.21
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Tue, 19 Mar 2019 02:11:21 -0700 (PDT)
Message-ID: <3bebbae829d0a0e1e3ad26572e91ed141dbe5f20.camel@baylibre.com>
Subject: Re: [PATCH] clk: meson-g12a: fix VPU clock parents
From:   Jerome Brunet <jbrunet@baylibre.com>
To:     Neil Armstrong <narmstrong@baylibre.com>
Cc:     linux-clk@vger.kernel.org, linux-amlogic@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Date:   Tue, 19 Mar 2019 10:11:20 +0100
In-Reply-To: <20190313135503.3198-1-narmstrong@baylibre.com>
References: <20190313135503.3198-1-narmstrong@baylibre.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.30.5 (3.30.5-1.fc29) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2019-03-13 at 14:55 +0100, Neil Armstrong wrote:
> First two VPU clock parents are wrong, fix it here.
> 
> Fixes: 085a4ea93d54 ("clk: meson: g12a: add peripheral clock controller")
> Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>
> ---
>  drivers/clk/meson/g12a.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Acked-by: Jerome Brunet <jbrunet@baylibre.com>

