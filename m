Return-Path: <SRS0=S2At=YJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 10B6AECE599
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Oct 2019 23:23:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D2D4220872
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Oct 2019 23:23:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="cpwsSY3c"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404726AbfJPXXg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 16 Oct 2019 19:23:36 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:35700 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725970AbfJPXXg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Oct 2019 19:23:36 -0400
Received: by mail-pg1-f196.google.com with SMTP id p30so160545pgl.2
        for <linux-kernel@vger.kernel.org>; Wed, 16 Oct 2019 16:23:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=message-id:mime-version:content-transfer-encoding:in-reply-to
         :references:from:to:cc:subject:user-agent:date;
        bh=9c4iNU9+F4vQHS+rhuD2o7V6W1JHSYQ5AwGRnQjJVSU=;
        b=cpwsSY3cxaC+AvG5nAQgo8Lxf3AgMApPUEHILYJe/GN2QimuVwPsACi/mIlXQ9GJbF
         lhj/NWfFuUvIrFQFbIkALnnvIA7HiER7GaYJRw+uTshHR/YZ8B9Ksnj6iDowVb0b3eYI
         YUgErSTcMlz3r6Taf6lfKRgOkl7htWZ1alVD0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:mime-version
         :content-transfer-encoding:in-reply-to:references:from:to:cc:subject
         :user-agent:date;
        bh=9c4iNU9+F4vQHS+rhuD2o7V6W1JHSYQ5AwGRnQjJVSU=;
        b=LxZ7kOujK5XN6uOMTottto2R+S+JHqsJyzqiFl9RsYn3vEz4LqfPQwOtBlZF9vL/fk
         U3LuDle2ZsdUr3JB6NW2Agu0Qem6mEJkh2BROrsZkKHbfIHPkBUDK9QJ3NZSCDCQbbkq
         7B+iNSPKEq00IizZJAFoUJlnPyRr1ViVbXSI7hH1d1nK9K91/lhg6E5+lmZjztqFGafc
         vH3x2rpLJqJPJki0GeoyZdcsSLs58h43Z/bpmDzlWBa2BjsxjCKXAwL+7N/++64EmbNF
         T6wJ2kBUranfNjd7I6IHamXeNVrN4nW02tuD5dPZJFlH4q7mEPOaYGTg1Q9GzTVj3xob
         Gkdw==
X-Gm-Message-State: APjAAAWyJEJfHooz/fuuJTAx7DGihy95pv5uTbXfQnOb931Fc4h31hUz
        QeuxqZ0krqsEjJ+WEGIrx51LwA==
X-Google-Smtp-Source: APXvYqy2MyiabuqklmTwv+qDXfjWg6yfSVYMYgw5kTlmIQsp6x1u9ITQHeC8Fgp9LYNpgQtsR8bvcg==
X-Received: by 2002:a17:90a:ab0e:: with SMTP id m14mr597622pjq.78.1571268213946;
        Wed, 16 Oct 2019 16:23:33 -0700 (PDT)
Received: from chromium.org ([2620:15c:202:1:fa53:7765:582b:82b9])
        by smtp.gmail.com with ESMTPSA id 126sm132231pgg.10.2019.10.16.16.23.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Oct 2019 16:23:33 -0700 (PDT)
Message-ID: <5da7a675.1c69fb81.a888.0911@mx.google.com>
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20191016143142.28854-1-geert+renesas@glider.be>
References: <20191016143142.28854-1-geert+renesas@glider.be>
From:   Stephen Boyd <swboyd@chromium.org>
To:     Frank Rowand <frowand.list@gmail.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Rob Herring <robh+dt@kernel.org>
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Geert Uytterhoeven <geert+renesas@glider.be>
Subject: Re: [PATCH] of: unittest: Use platform_get_irq_optional() for non-existing interrupt
User-Agent: alot/0.8.1
Date:   Wed, 16 Oct 2019 16:23:32 -0700
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Geert Uytterhoeven (2019-10-16 07:31:42)
> diff --git a/drivers/of/unittest.c b/drivers/of/unittest.c
> index 9efae29722588a35..34da22f8b0660989 100644
> --- a/drivers/of/unittest.c
> +++ b/drivers/of/unittest.c
> @@ -1121,7 +1121,7 @@ static void __init of_unittest_platform_populate(vo=
id)
>                 np =3D of_find_node_by_path("/testcase-data/testcase-devi=
ce2");
>                 pdev =3D of_find_device_by_node(np);
>                 unittest(pdev, "device 2 creation failed\n");
> -               irq =3D platform_get_irq(pdev, 0);
> +               irq =3D platform_get_irq_optional(pdev, 0);
>                 unittest(irq < 0 && irq !=3D -EPROBE_DEFER,

This is a test to make sure that irq failure doesn't return probe defer.
Do we want to silence the error message that we're expecting to see?

