Return-Path: <SRS0=S2At=YJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BEFAAECE59E
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Oct 2019 04:57:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9129521835
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Oct 2019 04:57:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="NoX42E5t"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390842AbfJPE5d (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 16 Oct 2019 00:57:33 -0400
Received: from mail-pg1-f195.google.com ([209.85.215.195]:39309 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389406AbfJPE5d (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Oct 2019 00:57:33 -0400
Received: by mail-pg1-f195.google.com with SMTP id p12so4183553pgn.6
        for <linux-kernel@vger.kernel.org>; Tue, 15 Oct 2019 21:57:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=message-id:mime-version:content-transfer-encoding:in-reply-to
         :references:from:to:cc:subject:user-agent:date;
        bh=FkcYsvQW9DCuO8FIIta+BX8R8j3WmMX3n+DnEou1u9g=;
        b=NoX42E5tQHVBX2OTb84UT4yoQagDGL6lXFej+SixelM0Ct41ZVJI1RMIC/j+1lUZNa
         lnxJvH2oF61wdUQigS9UL5pQrhOOINYGTmxZzVz9TYtn4wiFPvzBmWfkitgiOMtFwrd7
         z5NVofZHgl4NFe3uoZOyIcfHbz8IO2dAjIT6E=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:mime-version
         :content-transfer-encoding:in-reply-to:references:from:to:cc:subject
         :user-agent:date;
        bh=FkcYsvQW9DCuO8FIIta+BX8R8j3WmMX3n+DnEou1u9g=;
        b=rFNQzpisvywbPa4j6qjSiVYFSqb3+HJxlBH7FSRRfB/d7czeaPedPCXpUtoFij1G+V
         BhSeLA4Qnj/JXkf8RHVe88Q7BGuasJ3b6pG2iZb8hwCZmp8686R5+coqeDJyzGBA8zpM
         qYB5TBvdV1bInCzu9xaBhlkP/z5tYRrhTalshSKB1XnE+0h26z40Ahi69Du5lAnGBgvq
         V4BBWvDH4uikAGO6CEBDe8O9ow03o2mKcgJj65PgAe6JjAzozkyobKiu8NDqvolF09Fx
         vFUGBH06/9/cAzJHBJ1bFcC57tX6wpSeIy0ryEdLmATp6vv6shZipKNfniZcrc9kYo5E
         K81g==
X-Gm-Message-State: APjAAAWOGJceT5ffwvwuQTxvT+jqnTzSgq/FyYK6JiTydD+Zk/kP3YUi
        UIgc9AxyiCwcjufVDeHIvlcagw==
X-Google-Smtp-Source: APXvYqxpDxQimqJ2TytuIDDL1ryHC0bnU/A4itgozpPrv7HJksahoeyOtkc6JvrgH5YBZC/kupezMA==
X-Received: by 2002:a63:6a03:: with SMTP id f3mr1856640pgc.167.1571201852446;
        Tue, 15 Oct 2019 21:57:32 -0700 (PDT)
Received: from chromium.org ([2620:15c:202:1:fa53:7765:582b:82b9])
        by smtp.gmail.com with ESMTPSA id k23sm25002741pgi.49.2019.10.15.21.57.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Oct 2019 21:57:31 -0700 (PDT)
Message-ID: <5da6a33b.1c69fb81.64cc.6834@mx.google.com>
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <1b53ef537203e629328285b4597a09e4a586d688.1571181041.git.amit.kucheria@linaro.org>
References: <cover.1571181041.git.amit.kucheria@linaro.org> <1b53ef537203e629328285b4597a09e4a586d688.1571181041.git.amit.kucheria@linaro.org>
From:   Stephen Boyd <swboyd@chromium.org>
To:     Amit Kucheria <amit.kucheria@linaro.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Eduardo Valentin <edubezval@gmail.com>,
        Zhang Rui <rui.zhang@intel.com>, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     linux-pm@vger.kernel.org
Subject: Re: [PATCH] of-thermal: Disable polling when interrupt property is found in DT
User-Agent: alot/0.8.1
Date:   Tue, 15 Oct 2019 21:57:30 -0700
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Amit Kucheria (2019-10-15 16:13:16)
> Currently, in order to enable interrupt-only mode, one must set
> polling-delay-passive and polling-delay properties in the DT to 0,
> otherwise the thermal framework will continue to setup a periodic timers
> to monitor the thermal zones.
>=20
> Change the behaviour, so that on DT-based systems, we no longer have to
> set the properties to zero if we find an 'interrupt' property in the
> sensor.
>=20
> Following data shows the number of times
> thermal_zone_device_set_polling() is invoked with and without this
> patch. So the patch achieves the same behaviour as setting the delay
> properties to 0.
>=20
> Current behaviour (without setting delay properties to 0):
>   FUNC                              COUNT
>   thermal_zone_device_update          302
>   thermal_zone_device_set_pollin     7911

thermal_zone_device_set_polling?

>=20
> Current behaviour (with delay properties set to 0):
>   FUNC                              COUNT
>   thermal_zone_device_update            3
>   thermal_zone_device_set_pollin        6
>=20
> With this patch (without setting delay properties to 0):
>   FUNC                              COUNT
>   thermal_zone_device_update            3
>   thermal_zone_device_set_pollin        6
>=20
> Suggested-by: Stephen Boyd <swboyd@chromium.org>
> Signed-off-by: Amit Kucheria <amit.kucheria@linaro.org>
> ---

Reviewed-by: Stephen Boyd <swboyd@chromium.org>

