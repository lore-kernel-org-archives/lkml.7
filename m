Return-Path: <SRS0=kjqD=WY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2305BC3A5A6
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Aug 2019 00:32:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EF60320856
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Aug 2019 00:32:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="JvJAkS9O"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726527AbfH1Acl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 27 Aug 2019 20:32:41 -0400
Received: from mail-pg1-f195.google.com ([209.85.215.195]:41693 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726091AbfH1Ack (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Aug 2019 20:32:40 -0400
Received: by mail-pg1-f195.google.com with SMTP id x15so381617pgg.8
        for <linux-kernel@vger.kernel.org>; Tue, 27 Aug 2019 17:32:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=message-id:mime-version:content-transfer-encoding:in-reply-to
         :references:cc:subject:to:from:user-agent:date;
        bh=H1hpO1CVjR+1P7gJ4YBZBqtb8Z3qt/H30KSvH+SzNw8=;
        b=JvJAkS9OzGQpIeYwSbeptRg3NdQcLKcumVdpKVP9avlhSzxiXvyfFleNvF+HlQYQch
         9ypsn3wvcTj3cip/axPGNfe26mI0ydwvXzrGUMJJfVz95yGxNzbDR9WqLf8QBmp0hgsU
         W3dWOlAwZQoe1lpP7Ab7gC08AdXa4Fd6L+h7k=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:mime-version
         :content-transfer-encoding:in-reply-to:references:cc:subject:to:from
         :user-agent:date;
        bh=H1hpO1CVjR+1P7gJ4YBZBqtb8Z3qt/H30KSvH+SzNw8=;
        b=ZTieplhLhg5vjl6MtWBMjg/By3xGLq3cSgJwYS4/7YGrq56GFpUESmuwF7biiUz73j
         bpbId9IALMOMJH5V/3DzyjV0tR2ADw8uRoIOoTr6KELdNQna15fIvq8cAyLVNkCHtHN3
         nhYX7WpdPLhnrVWT/96pS/9qjGvnZSiq+syyQsPUsel2JjmewkZYShBtMSoAgYf6r1J2
         PYFS0mpwxJB3zZsDMZRSVrSFSBeujtObFztN2EU3pGI6iHlg+svtOoQAt2piiuJmcgXD
         fL+lvrDiqS2IawWfjfMDEOSI8jYFf+izUsu4VlYytc67myTPFtVJBzkmTUHFFr0PA2uu
         MnLg==
X-Gm-Message-State: APjAAAV+HDAer/8/vSqzCtGUsaxzg97lvtryk8XkJ4q7+9Mbb59hwUMW
        o2jKYyXAW8t+mpOqwAUUapL3IQ==
X-Google-Smtp-Source: APXvYqzmeI2dhLfxbIvSYUhmX5dGOTt6kvO9wOXplWe7L5GZv7fw/KRT8d6v7JboyjmHKF11/xrmfw==
X-Received: by 2002:a17:90a:e38e:: with SMTP id b14mr1441690pjz.125.1566952360100;
        Tue, 27 Aug 2019 17:32:40 -0700 (PDT)
Received: from chromium.org ([2620:15c:202:1:fa53:7765:582b:82b9])
        by smtp.gmail.com with ESMTPSA id e129sm525680pfa.92.2019.08.27.17.32.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Aug 2019 17:32:39 -0700 (PDT)
Message-ID: <5d65cba7.1c69fb81.a9cde.25a1@mx.google.com>
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <f32c05c08669a9a886935149ac40423cd7001dfb.1566907161.git.amit.kucheria@linaro.org>
References: <cover.1566907161.git.amit.kucheria@linaro.org> <f32c05c08669a9a886935149ac40423cd7001dfb.1566907161.git.amit.kucheria@linaro.org>
Cc:     devicetree@vger.kernel.org
Subject: Re: [PATCH v2 06/15] arm64: dts: msm8916: thermal: Fixup HW ids for cpu sensors
To:     Amit Kucheria <amit.kucheria@linaro.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Rob Herring <robh+dt@kernel.org>,
        Zhang Rui <rui.zhang@intel.com>, agross@kernel.org,
        bjorn.andersson@linaro.org, edubezval@gmail.com,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        marc.w.gonzalez@free.fr, masneyb@onstation.org
From:   Stephen Boyd <swboyd@chromium.org>
User-Agent: alot/0.8.1
Date:   Tue, 27 Aug 2019 17:32:38 -0700
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Amit Kucheria (2019-08-27 05:14:02)
> msm8916 uses sensors 0, 1, 2, 4 and 5. Sensor 3 is NOT used. Fixup the
> device tree so that the correct sensor ID is used and as a result we can
> actually check the temperature for the cpu2_3 sensor.
>=20
> Signed-off-by: Amit Kucheria <amit.kucheria@linaro.org>
> Reviewed-by: Daniel Lezcano <daniel.lezcano@linaro.org>
> ---

Reviewed-by: Stephen Boyd <swboyd@chromium.org>

