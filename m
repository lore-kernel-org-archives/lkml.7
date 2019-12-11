Return-Path: <SRS0=Yvat=2B=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1F478C2D0C6
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Dec 2019 17:00:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EA6BC214AF
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Dec 2019 17:00:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="T/zUrney"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730817AbfLKRAu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 11 Dec 2019 12:00:50 -0500
Received: from mail-pg1-f196.google.com ([209.85.215.196]:40470 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730618AbfLKRAt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Dec 2019 12:00:49 -0500
Received: by mail-pg1-f196.google.com with SMTP id k25so11037443pgt.7
        for <linux-kernel@vger.kernel.org>; Wed, 11 Dec 2019 09:00:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=message-id:mime-version:content-transfer-encoding:in-reply-to
         :references:subject:to:from:cc:user-agent:date;
        bh=Il2BH3mT14jNnyfQTVgoz95xu2C4GVoCgXMNz/s/944=;
        b=T/zUrneyCEfYv3KlpaJyBcQk3iziUqjvddwQKdXrndN/Aqrn+mCThMWm8ogoAcABZL
         7+8FehOutGXdOe1aiY9Rkr0SoYcwdjAZaUnargC1+Yre6WlVEau5OUA5DeUtFCSxK3OT
         9Vr7rTt9LvgzKm25jAq3GRi0RYCsahW//MreE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:mime-version
         :content-transfer-encoding:in-reply-to:references:subject:to:from:cc
         :user-agent:date;
        bh=Il2BH3mT14jNnyfQTVgoz95xu2C4GVoCgXMNz/s/944=;
        b=FfGXaRQB8QJyUvAvP+pXUWeZlPZYPnx12BphnJHjcCjFUFu5J10MWpMizhlSa7mJgC
         1et6Si4qpCbMeYcgukUGa7akofOrTKNKvLWZbrpFtxDth6beEoo1peeahBLoFUwAMQwo
         63FibFJmSWXUF/6TK/gtjZ/njX8BHeNXDz7P5ICc0HS9Ngg11DjUdMg2ooBxV7YPudYT
         z4Oz/4l4JHmSi3EYXS+xe9od3nAX2f9vSQDrMD1SxnjfLgVfUkG/4sg/4wlOBS/oF6qH
         XQayqayYF+wjSaisa8zyzF4B0PGkTwyzri0t1lqqgx29G3QaLkXsCEuC1b2rIG3Y7DZ/
         XfmA==
X-Gm-Message-State: APjAAAWg3OonaKheXAyckCbRIFUzC8RRLvuz5iw+8MZWP2anmragksSa
        Df5bcVXfiG3pZtXbS8tc/QIyYw==
X-Google-Smtp-Source: APXvYqyehQksX4lXTF0rK4YTJbTMk3+3BIKxNhLXjNsN84fk9gBPPcSRjxI652WP8Mh2ejJYjnzN0g==
X-Received: by 2002:a63:4d1b:: with SMTP id a27mr5085954pgb.352.1576083648875;
        Wed, 11 Dec 2019 09:00:48 -0800 (PST)
Received: from chromium.org ([2620:15c:202:1:fa53:7765:582b:82b9])
        by smtp.gmail.com with ESMTPSA id r20sm3724835pgu.89.2019.12.11.09.00.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Dec 2019 09:00:48 -0800 (PST)
Message-ID: <5df120c0.1c69fb81.ca8b2.88f5@mx.google.com>
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <0101016ef36a5d13-457e6678-2e83-494e-8494-1b0776d5b7e4-000000@us-west-2.amazonses.com>
References: <0101016ef36a5d13-457e6678-2e83-494e-8494-1b0776d5b7e4-000000@us-west-2.amazonses.com>
Subject: Re: [PATCH v2 1/2] dt-bindings: pinctrl: qcom: Add new qup functions for sc7180
To:     Rajendra Nayak <rnayak@codeaurora.org>, bjorn.andersson@linaro.org,
        linus.walleij@linaro.org
From:   Stephen Boyd <swboyd@chromium.org>
Cc:     linux-arm-msm@vger.kernel.org, linux-gpio@vger.kernel.org,
        linux-kernel@vger.kernel.org, dianders@chromium.org,
        Rajendra Nayak <rnayak@codeaurora.org>
User-Agent: alot/0.8.1
Date:   Wed, 11 Dec 2019 09:00:47 -0800
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Rajendra Nayak (2019-12-10 21:24:24)
> Add new qup functions for qup02/04/11 and qup13 wherein multiple
> functions (for i2c and uart) share the same pin. This allows users
> to identify which specific qup function for the instance one needs
> to use for the pin.
>=20
> Signed-off-by: Rajendra Nayak <rnayak@codeaurora.org>
> ---

Reviewed-by: Stephen Boyd <swboyd@chromium.org>

