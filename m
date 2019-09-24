Return-Path: <SRS0=YpA9=XT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C6B5AC432C1
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Sep 2019 19:07:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9F44220872
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Sep 2019 19:07:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="K5arkwd0"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2441849AbfIXTHO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 24 Sep 2019 15:07:14 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:40770 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2441838AbfIXTHN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Sep 2019 15:07:13 -0400
Received: by mail-pf1-f193.google.com with SMTP id x127so1906341pfb.7
        for <linux-kernel@vger.kernel.org>; Tue, 24 Sep 2019 12:07:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:in-reply-to:references:date:message-id
         :mime-version;
        bh=yI20ESmRvXoTToo4YVcfDDcoV5v1nx5lGqojRvE9ORU=;
        b=K5arkwd0xs/VZSeWRsCAty8Qdy+IfBSQVFuXEZtmFnYrzoETMTK82c6fpPi5CwVNCC
         zKBzT0L0TTIpKrFGeMOZdnnxEGbaOhQl447I+dxIgiQc8TcKpMwNAEBCdloo9xFGtlqX
         d2qJdIb1sbkbFC37RWo1+KUfENx+7I1FtNHT4oKWRMD2Z2eDIwJafed6Jr1qEAxuzl+M
         XPgfBcttmwwtb/nCd8oo2lg0lXppANM9jj/GoBHDjN0Hjkh8z8XVkYz5vOE8p4VCy4F4
         El4+gcVAIq2WgrF7m/hBYywl6Y1G6jQ1UJqqgaL7CW5Qc3jxCkcprFQHzooJmMKcoE1M
         XOJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version;
        bh=yI20ESmRvXoTToo4YVcfDDcoV5v1nx5lGqojRvE9ORU=;
        b=civPuOVxP0OwhCFbE8bN81Yy8Z/yOeCmPccG5oUKNDaP+BGkmVccA4uHWLN8OEHkep
         5rjjUCRiEgsNrkwLiLD9ZkNYf9P1+rfqZ6fZGixYl5nBMbidy9tgT7jPMPYuu/YGR2o1
         czLGXjKxMPpCzJzX9zts5X+bWyIOq2q1FL+faFkXnkdWCEPM9c/okduT74vfCbl/yJR+
         MnkJ4lFDejPrb/VUCA+XMcab+Sw7BhJHw4fU53qkMXzTbth7XATzsqMAxHXHaT3A7b15
         /wTQ9/Yl9yG/eirSsuiEJF4pRzKibPb6lZR2y5O2tdRnL5cIYMueaT9QPYlEjEvLSyGA
         v3uw==
X-Gm-Message-State: APjAAAUJEE8zkTXKKzI6ZyIjHxrZQJTEONh3+giK0mdhZXCYhgL/l9MW
        OrgOMfCOOPYaSo5DUrGDtunH4g==
X-Google-Smtp-Source: APXvYqyDTGMQ/4hG0V6O79fuxEj2FmTcML6QD0E5bVYhERVC6KkggIhTEB4+w8bmJrnSN+ivxyXPFA==
X-Received: by 2002:a63:68c4:: with SMTP id d187mr4531647pgc.196.1569352032584;
        Tue, 24 Sep 2019 12:07:12 -0700 (PDT)
Received: from localhost (c-71-197-186-152.hsd1.wa.comcast.net. [71.197.186.152])
        by smtp.gmail.com with ESMTPSA id u10sm2835484pfh.61.2019.09.24.12.07.11
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 24 Sep 2019 12:07:11 -0700 (PDT)
From:   Kevin Hilman <khilman@baylibre.com>
To:     Jianxin Pan <jianxin.pan@amlogic.com>,
        linux-amlogic@lists.infradead.org
Cc:     Jianxin Pan <jianxin.pan@amlogic.com>,
        Rob Herring <robh+dt@kernel.org>,
        Carlo Caione <carlo@caione.org>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, "Jian Hu" <jian.hu@amlogic.com>,
        Hanjie Lin <hanjie.lin@amlogic.com>,
        Xingyu Chen <xingyu.chen@amlogic.com>,
        Victor Wan <victor.wan@amlogic.com>,
        Qiufang Dai <qiufang.dai@amlogic.com>,
        Tao Zeng <tao.zeng@amlogic.com>
Subject: Re: [PATCH v4 0/4] arm64: Add basic support for Amlogic A1 SoC Family
In-Reply-To: <1568276370-54181-1-git-send-email-jianxin.pan@amlogic.com>
References: <1568276370-54181-1-git-send-email-jianxin.pan@amlogic.com>
Date:   Tue, 24 Sep 2019 12:07:11 -0700
Message-ID: <7hzhit5x9c.fsf@baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Jianxin Pan <jianxin.pan@amlogic.com> writes:

> A1 is an application processor designed for smart audio and IoT applications,
> with Dual core ARM Cortex-A35 CPU. Unlike the previous GXL and G12 series,
> there is no Cortex-M3 AO CPU in it.
>
> This serial add basic support for the Amlogic A1 based Amlogic AD401 board:
> which describe components as follows: Reserve Memory, CPU, GIC, IRQ,
> Timer, UART. It's capable of booting up into the serial console.
>
> The pclk for uart_AO_B need to be fixed once A1 clock driver is merged.
> In this version, it rely on bootloader to enable the pclk gate

Queued for v5.5,

Thanks for the new SoC support,

Kevin
