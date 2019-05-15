Return-Path: <SRS0=FrXW=TP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1CFAEC04AB4
	for <linux-kernel@archiver.kernel.org>; Wed, 15 May 2019 00:01:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E67532082E
	for <linux-kernel@archiver.kernel.org>; Wed, 15 May 2019 00:01:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="tX7XsRCa"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726581AbfEOABk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 May 2019 20:01:40 -0400
Received: from mail-pg1-f195.google.com ([209.85.215.195]:42344 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726265AbfEOABj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 May 2019 20:01:39 -0400
Received: by mail-pg1-f195.google.com with SMTP id 145so356355pgg.9
        for <linux-kernel@vger.kernel.org>; Tue, 14 May 2019 17:01:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:in-reply-to:references:date:message-id
         :mime-version;
        bh=Fl4BRNGtm92dLl/qzsGLS8SvffFbPXXhiHpwATSSiyU=;
        b=tX7XsRCaevKkmFvq8xy+sLXC6agZnWKTOukEF5WmKqJWO7syyKlQ2wsBCfil36LpLc
         mGlid7DLUx1dXCo0KeqHIx2sUi4nerLRHCzysY+ERtFErlU4bgmKwSpt/kEySf9ShL99
         Nc1Wp8TqRW/KaqEa81fDD/8gvS/tDUs/3ZYzDJmihvXXvXBvle3OYpXPWYJXo/JUYG06
         CxmiHlVfWhvL9JU7Cbk4RjA7TQt6iOY0+pKbm5iXrCqvis9BcB18g49DkbteGGEx0pOM
         ILitRlt7sHfp1a3edNzxFH+/qX+a8srD/b5530Ze8vMyEgOu4CRVYuJiqaNMeCH9g1vi
         weIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version;
        bh=Fl4BRNGtm92dLl/qzsGLS8SvffFbPXXhiHpwATSSiyU=;
        b=UnFnExa4EtL0PjB73z0fPMh7U1kYBpCHHglxCn9yu4ktDtdNbKR874XGYmIi0KguL6
         kCQiZsSStR+gNUDZSiHZCADBOUJRyywyuee2wLkgNEhC0BGggoRKJopYO7uphN1mTre9
         Q09dz7xB82fNhE5v+9mdeZ5gQ8n3p3JtC8ogAYABgsmvk8zIGuJkN2pPH1Vc44uFmr+U
         gZm5xh60qr/xAlDCTnTeSK70/nlZyaGk9aiwaGPmBVL6tzxIkcL8Wpc+bhcA9Geay18C
         wwnOXMtyiXnaq24XrjZjASQ+H0GGyd/9YtBvHPRbqGew6f+bIsiAwx4sr+xUYZgxsGfE
         j30Q==
X-Gm-Message-State: APjAAAW88eO8FJPgwdJ+auG7GOHx0tPQEu0cUmIxYARtL6MfhY7hPTaF
        l11sriqg74D+krVykzSAWJY4kQ==
X-Google-Smtp-Source: APXvYqwHZa5sICwqraZ9H1QVEAfGb9MwKOmlBlqopDcas/BnamGKzAjjpLLEttGsYJaVEihf/p/OVQ==
X-Received: by 2002:a63:5211:: with SMTP id g17mr11987172pgb.405.1557878498529;
        Tue, 14 May 2019 17:01:38 -0700 (PDT)
Received: from localhost ([2601:602:9200:a1a5:fd66:a9bc:7c2c:636a])
        by smtp.googlemail.com with ESMTPSA id a80sm331973pfj.105.2019.05.14.17.01.37
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 14 May 2019 17:01:37 -0700 (PDT)
From:   Kevin Hilman <khilman@baylibre.com>
To:     Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        linux-amlogic@lists.infradead.org
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Subject: Re: [PATCH 1/1] ARM: dts: meson8b: fix the operating voltage of the Mali GPU
In-Reply-To: <20190512193936.26557-2-martin.blumenstingl@googlemail.com>
References: <20190512193936.26557-1-martin.blumenstingl@googlemail.com> <20190512193936.26557-2-martin.blumenstingl@googlemail.com>
Date:   Tue, 14 May 2019 17:01:37 -0700
Message-ID: <7hwoisd1r2.fsf@baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Martin Blumenstingl <martin.blumenstingl@googlemail.com> writes:

> Amlogic's vendor kernel defines an OPP for the GPU on Meson8b boards
> with a voltage of 1.15V. It turns out that the vendor kernel relies on
> the bootloader to set up the voltage. The bootloader however sets a
> fixed voltage of 1.10V.
>
> Amlogic's patched u-boot sources (uboot-2015-01-15-23a3562521) confirm
> this:
> $ grep -oiE "VDD(EE|AO)_VOLTAGE[ ]+[0-9]+" board/amlogic/configs/m8b_*
>   board/amlogic/configs/m8b_m100_v1.h:VDDAO_VOLTAGE            1100
>   board/amlogic/configs/m8b_m101_v1.h:VDDAO_VOLTAGE            1100
>   board/amlogic/configs/m8b_m102_v1.h:VDDAO_VOLTAGE            1100
>   board/amlogic/configs/m8b_m200_v1.h:VDDAO_VOLTAGE            1100
>   board/amlogic/configs/m8b_m201_v1.h:VDDEE_VOLTAGE            1100
>   board/amlogic/configs/m8b_m201_v1.h:VDDEE_VOLTAGE            1100
>   board/amlogic/configs/m8b_m202_v1.h:VDDEE_VOLTAGE            1100
>
> Another hint at this is the VDDEE voltage on the EC-100 and Odroid-C1
> boards. The VDDEE regulator supplies the Mali GPU. It's basically a copy
> of the VCCK (CPU supply) which means it's limited to 0.86V to 1.14V.
>
> Update the operating voltage of the Mali GPU on Meson8b to 1.10V so it
> matches with what the vendor u-boot sets.
>
> Fixes: c3ea80b6138cae ("ARM: dts: meson8b: add the Mali-450 MP2 GPU")
> Signed-off-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>

Queued as a fix for v5.2-rc (branch: v5.2/fixes)

Kevin
