Return-Path: <SRS0=tMFY=W7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0AEA4C3A59E
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Sep 2019 23:22:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CB0CD21726
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Sep 2019 23:22:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="A19kppI0"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730329AbfIDXWA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 4 Sep 2019 19:22:00 -0400
Received: from mail-pl1-f180.google.com ([209.85.214.180]:43770 "EHLO
        mail-pl1-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728941AbfIDXV7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Sep 2019 19:21:59 -0400
Received: by mail-pl1-f180.google.com with SMTP id 4so313099pld.10
        for <linux-kernel@vger.kernel.org>; Wed, 04 Sep 2019 16:21:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=message-id:mime-version:content-transfer-encoding:in-reply-to
         :references:cc:subject:to:from:user-agent:date;
        bh=qMQxm/VRDxP6FZWufG32f5QY5xEFJc2+2imqmF95LA8=;
        b=A19kppI0UbAoVodw+dajW3BnRlspaPQe0dq2835ayW+34cIzwjJYGFM2OrMhC+BZQ8
         ef2IGsUsJXGtanLcTAIivF5OgSmYNQ77EOdzlVawj6BnQn8P64g9aPryd+bQHxDiSXib
         eWs8Ca3xov4mE2S2UvNSQ3ZCXTcl7CTzChe8c=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:mime-version
         :content-transfer-encoding:in-reply-to:references:cc:subject:to:from
         :user-agent:date;
        bh=qMQxm/VRDxP6FZWufG32f5QY5xEFJc2+2imqmF95LA8=;
        b=hdTgpxMqYVgXkIDfOZmnfPqIbY+yfRd+Bhqt//RBiWBY+kKdscWnZjAwIj0rfiLHRg
         RtopynyIy2JX6wojL0XVtm+p0jPCmOd0qP/O3p7K6xY5Zvk9ftFYlNKxMMxWtZJWQoXN
         bvU5L95KL0EQO4CZlML/+Hwxa5Vf5m3T214xFEnY9RuqDDzhmTbJbiozKLhMmtcJJ1Go
         F7Bcjt5MXbT9prqJ/DQP4yMRX4YvyL9y517EFyWBMZ4seWpoanIlFwv30v4i8Q3PkxgJ
         VHzvFteVacjPFU1+7hve+xgO7cvtNQPZ+AUYnHPIn8EXwlJZzaGASTFPceK1Q13lhjKA
         iagA==
X-Gm-Message-State: APjAAAWZJ34v6cJQolJQo+EcXimEg5kv9FU2Zv09vBstWeUD8NrbPVxU
        FMp0g/33Y45S4fHsRzINIH8jPw==
X-Google-Smtp-Source: APXvYqwxSW1ALdQsQHJPdma+QWYRXG++FjslgBIyc2YnBGqRZIthwIfwVzJXxaUxjvuT2gSlp8UYtQ==
X-Received: by 2002:a17:902:7449:: with SMTP id e9mr292175plt.242.1567639319209;
        Wed, 04 Sep 2019 16:21:59 -0700 (PDT)
Received: from chromium.org ([2620:15c:202:1:fa53:7765:582b:82b9])
        by smtp.gmail.com with ESMTPSA id j128sm162678pfg.51.2019.09.04.16.21.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Sep 2019 16:21:58 -0700 (PDT)
Message-ID: <5d704716.1c69fb81.a404c.0c38@mx.google.com>
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20190904100835.6099-3-vkoul@kernel.org>
References: <20190904100835.6099-1-vkoul@kernel.org> <20190904100835.6099-3-vkoul@kernel.org>
Cc:     linux-arm-msm@vger.kernel.org,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        Vinod Koul <vkoul@kernel.org>
Subject: Re: [PATCH 2/3] dt-bindings: phy-qcom-qmp: Add sm8150 UFS phy compatible string
To:     Kishon Vijay Abraham I <kishon@ti.com>,
        Vinod Koul <vkoul@kernel.org>
From:   Stephen Boyd <swboyd@chromium.org>
User-Agent: alot/0.8.1
Date:   Wed, 04 Sep 2019 16:21:57 -0700
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Vinod Koul (2019-09-04 03:08:34)
> Document "qcom,sdm845-qmp-ufs-phy" compatible string for QMP UFS PHY
> found on SM8150.
>=20
> Signed-off-by: Vinod Koul <vkoul@kernel.org>
> ---

Reviewed-by: Stephen Boyd <swboyd@chromium.org>

