Return-Path: <SRS0=v0Gj=WB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B5EBAC0650F
	for <linux-kernel@archiver.kernel.org>; Mon,  5 Aug 2019 21:16:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 867AD20665
	for <linux-kernel@archiver.kernel.org>; Mon,  5 Aug 2019 21:16:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="I5W//gcU"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730842AbfHEVQv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 5 Aug 2019 17:16:51 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:44112 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729383AbfHEVQv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Aug 2019 17:16:51 -0400
Received: by mail-pf1-f193.google.com with SMTP id t16so40236345pfe.11
        for <linux-kernel@vger.kernel.org>; Mon, 05 Aug 2019 14:16:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:in-reply-to:references:date:message-id
         :mime-version;
        bh=Hjv4j/Vj9Xr1+lu3Alv0JlnmOoEgFtBXSbU9UmsCNGo=;
        b=I5W//gcUzJjBl1Uh/hM6NCnd/3gkKL5WdQwBH2HCxYB93LCDcBaq6915n5HTBbwLzl
         BIwoT8Pr5Uc8vdAH+4NtY+xzjflTxDsc2Td574oTXofj1JvaQmLEV3LCVj5RSE8Pzlhc
         EcpADse3wb4aKlMimttC306Fchd3kK4tcvLifCfNb4+V/xpmHsh/VVOEdc/YH4ZepUtg
         +kfLFW4L5jADtwfGi9mrxLK7YHVLoP1/UAxkigc8MCywrRI9cv+geqfpQ3Sv/tfe1osq
         5ee0Z3BBLVSAUIW8YD/aW9IuwcTu1hWuL1be/vg+stx4M2Bg4fkd1qcrayV/mYtR6MeR
         dlng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version;
        bh=Hjv4j/Vj9Xr1+lu3Alv0JlnmOoEgFtBXSbU9UmsCNGo=;
        b=ZObl9oNchaAz5J17daNeH5w5hD+6Ud6sijloTjMMc+ttws//N41xJFXEX5OJzCnRTy
         95ACV5Tv9r/1gxT1xcrEQRtGFoLOV4GPbEx97qh+8NGgCHuHUAdhkuEH65WG+/1VtPO/
         9Ck771zmXZWesQoNAuYG21IW4WSi+ZCaa92C/I2ymwU4sE+Fwcon2K2Zs6R5/kDRdl2H
         x21P2QAdebJmWjBnBp76xDExZTehmnl5vG6Ep3TayTypiDG3DkmxqD/23qCvVOJQO/XN
         E+p/OCKWftPRVxJZ/F+zXCSj7Bl3G2+4UPBbaJNMNy47apsZ3Df1npo/EOHs2jb1qzwI
         R/LA==
X-Gm-Message-State: APjAAAWEMkI+DNRjxzYi79pcHJLuRhS6xbSv2pt1lsOLGkDW9LQse5Oy
        0eOynt2fp+oUx/du09zZV/918g==
X-Google-Smtp-Source: APXvYqxahduyCEutbqa0LcJHp5B6a1S9MrYHMRKY6K3RuFuNrWxNYoi+A5H3XEU1nhAc3ORA/+GmRQ==
X-Received: by 2002:a63:5402:: with SMTP id i2mr111205104pgb.414.1565039810266;
        Mon, 05 Aug 2019 14:16:50 -0700 (PDT)
Received: from localhost ([2601:602:9200:a1a5:7483:80d6:7f67:2672])
        by smtp.googlemail.com with ESMTPSA id h12sm21316957pje.12.2019.08.05.14.16.49
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 05 Aug 2019 14:16:49 -0700 (PDT)
From:   Kevin Hilman <khilman@baylibre.com>
To:     Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        linux-amlogic@lists.infradead.org
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Subject: Re: [PATCH v2 0/4] ARM: dts: meson8b: add VDDEE / mali-supply
In-Reply-To: <20190727121257.18017-1-martin.blumenstingl@googlemail.com>
References: <20190727121257.18017-1-martin.blumenstingl@googlemail.com>
Date:   Mon, 05 Aug 2019 14:16:48 -0700
Message-ID: <7ho913gvnj.fsf@baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Martin Blumenstingl <martin.blumenstingl@googlemail.com> writes:

> EC-100 and Odroid-C1 use a "copy" of the VCCK regulator as "VDDEE"
> regulator. VDDEE supplies the Mali GPU and various other bits within
> the SoC.
>
> The VDDEE regulator is not exclusive to the Mali GPU so it must not
> change it's voltage. The GPU OPP table has a fixed voltage for all
> frequencies of 1.10V. This matches with what u-boot sets on my EC-100
> and Odroid-C1.

Series queued for v5.4,

Thanks,

Kevin
