Return-Path: <SRS0=J4ZE=RP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E7FB3C43381
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Mar 2019 20:28:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 99A132087C
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Mar 2019 20:28:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="CBsovrUr"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726782AbfCLU2o (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Mar 2019 16:28:44 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:35678 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726191AbfCLU2n (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Mar 2019 16:28:43 -0400
Received: by mail-pf1-f196.google.com with SMTP id j5so2659451pfa.2
        for <linux-kernel@vger.kernel.org>; Tue, 12 Mar 2019 13:28:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:in-reply-to:references:date:message-id
         :mime-version;
        bh=LSAL76ZaBISCmftacvftLCPdC0tuQThkmwcBczJW1Rg=;
        b=CBsovrUr5CkyQCnm9kWg+yPSbXQiHTmNnbMI89eHxW3PnJ5YA3lGozCwvqE16v7gOr
         n/1O+Al5PYLywIOtGl4oaDYqttC/E9cS69Ly+LUKQ7FZ9O5N0yEuUvbOnVMf/+fH3q8v
         /EfqVRFQILkyjYlntdBbXXHkKH3E5rU6ae5zOsy6l+E9Q3bTvGAy2ugqT+515eOfGi1t
         JOnMX21kUDH//SgsKpOwywp8njLu88nIdCGwlwsGG+wPWCPDvvOuv1tg62dKo4DdL+MS
         trqFggP+zTe72KX9AS7Q/dRqD2C+mcxU+jtCSggZ78Aege4D5kNYsCdmUCqgqpejnpa9
         t1tQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version;
        bh=LSAL76ZaBISCmftacvftLCPdC0tuQThkmwcBczJW1Rg=;
        b=dR2bFrFMdoyqwKUr/Ki2ytoRde4MOtrBaC2zxU1KCx5fktsQHxcYOGpyztp7/cLnyC
         ttKWCEomsEVi5Ut6r95ezfG7i/2C04+FPNV8kZ33GHTDLrByEguibsnM6Mxa8pa4wpdw
         4pFM4O4brKh4gOsrUzFv1DNnCoHvkfQz4Ut6ts+9izCBNCP7r5VO2GB0zdnSlFiscciv
         2gVTOfw/E0OhFSYoUOPmaMRwoBbNDi/f66Q9SIdsFTAVZM8qKn5jv/h5yQYP02pqvyYT
         BaM9apuVMMYsqKOlpCsUav7mld8OWpjGEyfS6ZXcekrgPwBk5deLJe/ADhnacQ5nfykb
         rxeg==
X-Gm-Message-State: APjAAAWP08oBTBGHNyAxNXKtWQo11tIa/MDymxGTnFn3e4PJrPYRYVfA
        Xduxa2d/33NyOsFIWVPZF1/kyQ==
X-Google-Smtp-Source: APXvYqzZED7QLtXOpujudJakoPtjS2S6V/2RlKyZGx5+WxIxPG09Wckf3mLR5T0+PD9nMmfAG8DnWw==
X-Received: by 2002:a65:614a:: with SMTP id o10mr36701640pgv.51.1552422523088;
        Tue, 12 Mar 2019 13:28:43 -0700 (PDT)
Received: from localhost ([2601:602:9200:a1a5:1daf:3f96:9f7f:33ba])
        by smtp.googlemail.com with ESMTPSA id w17sm13308688pfn.63.2019.03.12.13.28.42
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 12 Mar 2019 13:28:42 -0700 (PDT)
From:   Kevin Hilman <khilman@baylibre.com>
To:     Julia Lawall <Julia.Lawall@lip6.fr>
Cc:     kernel-janitors@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 09/12] meson-gx-socinfo: add missing of_node_put after of_device_is_available
In-Reply-To: <1550928043-14889-10-git-send-email-Julia.Lawall@lip6.fr>
References: <1550928043-14889-1-git-send-email-Julia.Lawall@lip6.fr> <1550928043-14889-10-git-send-email-Julia.Lawall@lip6.fr>
Date:   Tue, 12 Mar 2019 13:28:41 -0700
Message-ID: <7hh8c7u9ae.fsf@baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Julia Lawall <Julia.Lawall@lip6.fr> writes:

> Add an of_node_put when a tested device node is not available.

[...] 
]

> Fixes: a9daaba2965e8 ("soc: Add Amlogic SoC Information driver")
> Signed-off-by: Julia Lawall <Julia.Lawall@lip6.fr>

Patch applied,

Thanks,

Kevin
