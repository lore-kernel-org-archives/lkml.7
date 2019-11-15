Return-Path: <SRS0=19dG=ZH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A9257C43215
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Nov 2019 22:45:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 78F1A2072A
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Nov 2019 22:45:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="jFTdO6uQ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727324AbfKOWp3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 Nov 2019 17:45:29 -0500
Received: from mail-pg1-f195.google.com ([209.85.215.195]:33244 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727083AbfKOWp3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Nov 2019 17:45:29 -0500
Received: by mail-pg1-f195.google.com with SMTP id h27so6657133pgn.0
        for <linux-kernel@vger.kernel.org>; Fri, 15 Nov 2019 14:45:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=message-id:mime-version:content-transfer-encoding:in-reply-to
         :references:cc:to:subject:from:user-agent:date;
        bh=TIQx/W2wsyTfrLCB4wkXJI0AK0ooLAfik2qBodlMv9Q=;
        b=jFTdO6uQkNPKGB+sgB3g5p+gLJ2Z2GX0XxDXRULOaYD7dXrTMJvMy8ooEOa76ptYJy
         O+9QnZzvExaXj7XG7tmndRtrCg6eqfmp+jOQKPUgULH0iRPc2XF4VbcW+F4S3fL++ry3
         LUosm1MhLc68sRXzjbITUGgMXegakDZbtWZDo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:mime-version
         :content-transfer-encoding:in-reply-to:references:cc:to:subject:from
         :user-agent:date;
        bh=TIQx/W2wsyTfrLCB4wkXJI0AK0ooLAfik2qBodlMv9Q=;
        b=d6ykZvFoIcFamT3jQvA8pI9TyIwPnYupUSS2Q9PTai41GAWcZbOT3J1pB0gcJMmRPD
         le9iF9qOFbGLCvl+KdMKa6kCv8BNvvXQRD+/1eksCBcVYMT1Hb4J0mnydDnzIKNZrafd
         K6nCSfdbQ3jeDmMJafLH1oHk+zuLIjBerlHVlQhhZhaZdnTzuMINvbe2xZhezx7A394l
         SSMpFLlT99Nq7IRJjdXlDhUJvmk9URLeMhaWMtq0D+8cMoOOoEXmrTbI7NMDWXpq72Af
         CPBc/DxT1NduzRtKFJvyXk7INH1StbIwbbmEY2u+HW75YlXMLKPKMIH4IIoBsdWDY+0c
         4r6A==
X-Gm-Message-State: APjAAAWcVtYajQDT9xcKZDNUvQYPdidoB+YTmQVFX08EOQttyubz9LF2
        eZXI0VK5+WG7MPn9z2+GOx1QVg==
X-Google-Smtp-Source: APXvYqwIieFZ+AoiRqEA6AOmCV2fSK0ePU0g/VFuOLiyJGWLORJamjpTLg0d14VcejqPVesEBsIPqA==
X-Received: by 2002:a62:108:: with SMTP id 8mr20401575pfb.53.1573857928696;
        Fri, 15 Nov 2019 14:45:28 -0800 (PST)
Received: from chromium.org ([2620:15c:202:1:fa53:7765:582b:82b9])
        by smtp.gmail.com with ESMTPSA id r28sm12330264pfl.37.2019.11.15.14.45.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 Nov 2019 14:45:28 -0800 (PST)
Message-ID: <5dcf2a88.1c69fb81.8b56d.469f@mx.google.com>
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <1573593774-12539-6-git-send-email-eberman@codeaurora.org>
References: <1573593774-12539-1-git-send-email-eberman@codeaurora.org> <1573593774-12539-6-git-send-email-eberman@codeaurora.org>
Cc:     Elliot Berman <eberman@codeaurora.org>, tsoni@codeaurora.org,
        sidgup@codeaurora.org, psodagud@codeaurora.org,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org
To:     Elliot Berman <eberman@codeaurora.org>, agross@kernel.org,
        bjorn.andersson@linaro.org, saiprakash.ranjan@codeaurora.org
Subject: Re: [PATCH v2 05/18] firmware: qcom_scm: Remove unused qcom_scm_get_version
From:   Stephen Boyd <swboyd@chromium.org>
User-Agent: alot/0.8.1
Date:   Fri, 15 Nov 2019 14:45:27 -0800
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Elliot Berman (2019-11-12 13:22:41)
> Remove unused qcom_scm_get_version.
>=20
> Reviewed-by: Bjorn Andersson <bjorn.andersson@linaro.org>
> Reviewed-by: Vinod Koul <vkoul@kernel.org>
> Signed-off-by: Elliot Berman <eberman@codeaurora.org>
> ---

Reviewed-by: Stephen Boyd <swboyd@chromium.org>

