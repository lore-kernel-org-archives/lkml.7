Return-Path: <SRS0=gj9M=VG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 47F68C73C46
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Jul 2019 16:16:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1F876216E3
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Jul 2019 16:16:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="latPdWXA"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726721AbfGIQQe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 9 Jul 2019 12:16:34 -0400
Received: from mail-pl1-f196.google.com ([209.85.214.196]:38173 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725816AbfGIQQd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Jul 2019 12:16:33 -0400
Received: by mail-pl1-f196.google.com with SMTP id az7so2880425plb.5;
        Tue, 09 Jul 2019 09:16:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=+4V6pf5exFhyJYMgAtLay4UVo3H3rvR9SlpwNT68E70=;
        b=latPdWXAcf1AMijWLbaZYHoXz7H6essf53tAyKt8xO0br3UxRVyCzxNBtRGmDY2Geq
         vUKcjLuEzO15A5HoSy9z65mGkt3de2CuTvxk5H2f6eoQe1q5ojeghKiuYeb5BqjVUAg5
         2cOTNDmK9G6GbLlp5zPbvE1epvg5Avse2YL948NRdRo28x+O8djDu7cuI8txIGkHtLsT
         BarVLu4La5LlphqxsE7wrL3TEgGCO0cSxr86VFB+bPq3rAEN434vmKtXOYM4cY1KOKg8
         YYbB5TM0cnHc/zcIibBIUYTIWu/tcRQjHLdjXQLaQ3xuyOVHedNMVnNquNO2hm/DGBy2
         wakA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=+4V6pf5exFhyJYMgAtLay4UVo3H3rvR9SlpwNT68E70=;
        b=mCtigvecKhE7asTFcO8H2bx+NagOoeu/Z0tmUnGEobkI/W7IfWx/0qkvvaogfaxDPu
         X9UkQsnlHJbNk1xKKDKgLKEqawZ6p6BiO9Qqq7I11eipPy/bwBoZYIebBJ38Tz8C9UMV
         K8FvLWPRstOx8+7/H9g95LdjNO41/yBAu0rA/M+UtLGBxWmDH0qFb7MBUybv1Xjson6a
         v+prAM5fts4KGMjP7L51wolO7os6wxapZr6ptnCXypLlz8e43zqv8Zg7hi2Rt3/MMTkW
         v072OMJEImdducIFNUulQFfB9bMqfuYlo1AY7g6fUPnG+NPvl2615b2XJKNYk/nEzR1y
         htMg==
X-Gm-Message-State: APjAAAVG9JqQMI5sbpi8U9cy7UqVmNSiTRw9ZwMabfXAbe/fmpMW5hA3
        0F2i7e5kP8s58rMpzVoCOiQ=
X-Google-Smtp-Source: APXvYqyOOcWNGHCvM/PWWcpYNxR5BJCWc1Mr/h0wH9+t5YYla3kqBZbZQBrwjLOs1Xqbb3lncndkpQ==
X-Received: by 2002:a17:902:20c8:: with SMTP id v8mr33433506plg.284.1562688992236;
        Tue, 09 Jul 2019 09:16:32 -0700 (PDT)
Received: from fainelli-desktop.igp.broadcom.net ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id k36sm1386783pgl.42.2019.07.09.09.16.30
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Tue, 09 Jul 2019 09:16:31 -0700 (PDT)
From:   Florian Fainelli <f.fainelli@gmail.com>
To:     bcm-kernel-feedback-list@broadcom.com,
        Arnd Bergmann <arnd@arndb.de>,
        Hauke Mehrtens <hauke@hauke-m.de>,
        =?iso-8859-2?q?Rafa=B3_Mi=B3ecki?= <zajec5@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>
Cc:     Vivek Unune <npcomplete13@gmail.com>,
        Alexandre TORGUE <alexandre.torgue@st.com>,
        Neil Armstrong <narmstrong@baylibre.com>,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ARM: bcm47094: add missing #cells for mdio-bus-mux
Date:   Tue,  9 Jul 2019 09:16:30 -0700
Message-Id: <20190709161630.7963-1-f.fainelli@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190703132255.852025-1-arnd@arndb.de>
References: <20190703132255.852025-1-arnd@arndb.de>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed,  3 Jul 2019 15:22:45 +0200, Arnd Bergmann <arnd@arndb.de> wrote:
> The mdio-bus-mux has no #address-cells/#size-cells property,
> which causes a few dtc warnings:
> 
> arch/arm/boot/dts/bcm47094-linksys-panamera.dts:129.4-18: Warning (reg_format): /mdio-bus-mux/mdio@200:reg: property has invalid length (4 bytes) (#address-cells == 2, #size-cells == 1)
> arch/arm/boot/dts/bcm47094-linksys-panamera.dtb: Warning (pci_device_bus_num): Failed prerequisite 'reg_format'
> arch/arm/boot/dts/bcm47094-linksys-panamera.dtb: Warning (i2c_bus_reg): Failed prerequisite 'reg_format'
> arch/arm/boot/dts/bcm47094-linksys-panamera.dtb: Warning (spi_bus_reg): Failed prerequisite 'reg_format'
> arch/arm/boot/dts/bcm47094-linksys-panamera.dts:128.22-132.5: Warning (avoid_default_addr_size): /mdio-bus-mux/mdio@200: Relying on default #address-cells value
> arch/arm/boot/dts/bcm47094-linksys-panamera.dts:128.22-132.5: Warning (avoid_default_addr_size): /mdio-bus-mux/mdio@200: Relying on default #size-cells value
> 
> Add the normal cell numbers.
> 
> Fixes: 2bebdfcdcd0f ("ARM: dts: BCM5301X: Add support for Linksys EA9500")
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> ---

Applied to devicetree/fixes, thanks!
--
Florian
