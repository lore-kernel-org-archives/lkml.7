Return-Path: <SRS0=GkzU=Y7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BD730C5DF60
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Nov 2019 17:53:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8C1172166E
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Nov 2019 17:53:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="Ptd1ZEtc"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389871AbfKGRxk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 Nov 2019 12:53:40 -0500
Received: from mail-pl1-f195.google.com ([209.85.214.195]:44624 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389629AbfKGRxj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Nov 2019 12:53:39 -0500
Received: by mail-pl1-f195.google.com with SMTP id az9so1161654plb.11
        for <linux-kernel@vger.kernel.org>; Thu, 07 Nov 2019 09:53:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=message-id:mime-version:content-transfer-encoding:in-reply-to
         :references:subject:from:to:cc:user-agent:date;
        bh=0atOPD8MTEMaediJdWbaCxGcPPr5BBNLK/+zoqMN/a0=;
        b=Ptd1ZEtcLLPyidqEOZdEfKkqBqf/Wkh+Rt0Y/4ca6Cy3/tVXGJke1Bdww8VWSObKRE
         GOwQdTYNpVyAbmKk+yqdvaBKL7BQRtX6eGJfcKs36s2Yf14Fdt0wUV9K+UgiFvvoc/7o
         kLhZTKSM3ogAr+kSDjCD1L8ygh14xvufw4Cyg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:mime-version
         :content-transfer-encoding:in-reply-to:references:subject:from:to:cc
         :user-agent:date;
        bh=0atOPD8MTEMaediJdWbaCxGcPPr5BBNLK/+zoqMN/a0=;
        b=G9zmMrpK659+ElanLrzmeLq3RFeO44OjkSboJSiQYNawOhOLfPiYJn5wJyYL55R/rN
         Cv80c73uwd6vwEEewqf/E7Kb0fnI2Yhe93yNsmC76CLr+BEATt6LwRIF99ct8ozDOw0U
         yDR1drWC65EsKrfaHuOaaTYNwU2ZIK394+QJXUctxCt05Notf1NTMLLFh2kjqoCoTvJx
         nAvgdLbAPheKfc8/503C7yWkKfDrfIZAGX4XI5SCWyCtyzCDBzqYsvvWo1hlQu8g8ks4
         lZarb3eaNiG0RH1NjS/ZxuIThgZocxg9JEX9xaRcVHgQPY6O4h3XUWlp7v8sGy/AIvjd
         xYag==
X-Gm-Message-State: APjAAAVCtSm7RMkAeHRFOOcMKmgXZrtwQU7ST/ygFUtYUnmQs6PgbXy0
        cmNIZPThG4yqt68j4Z7jbPQYWQ==
X-Google-Smtp-Source: APXvYqz037BoF1XoSKyDn8Z9BdUfd/7F3E4zYn2tn2U4IcFxjzleZUeKGjpL8sfVUA6Fry3Ud++xKg==
X-Received: by 2002:a17:90a:348c:: with SMTP id p12mr6700892pjb.105.1573149218553;
        Thu, 07 Nov 2019 09:53:38 -0800 (PST)
Received: from chromium.org ([2620:15c:202:1:fa53:7765:582b:82b9])
        by smtp.gmail.com with ESMTPSA id 82sm3737569pfa.115.2019.11.07.09.53.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Nov 2019 09:53:38 -0800 (PST)
Message-ID: <5dc45a22.1c69fb81.bfe45.9863@mx.google.com>
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20191106065017.22144-7-rnayak@codeaurora.org>
References: <20191106065017.22144-1-rnayak@codeaurora.org> <20191106065017.22144-7-rnayak@codeaurora.org>
Subject: Re: [PATCH v4 06/14] arm64: dts: qcom: sc7180: Add rpmh-rsc node
From:   Stephen Boyd <swboyd@chromium.org>
To:     Rajendra Nayak <rnayak@codeaurora.org>, agross@kernel.org,
        bjorn.andersson@linaro.org, robh+dt@kernel.org
Cc:     linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, mka@chromium.org,
        Maulik Shah <mkshah@codeaurora.org>,
        Rajendra Nayak <rnayak@codeaurora.org>
User-Agent: alot/0.8.1
Date:   Thu, 07 Nov 2019 09:53:37 -0800
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Rajendra Nayak (2019-11-05 22:50:09)
> From: Maulik Shah <mkshah@codeaurora.org>
>=20
> Add device bindings for the application processor's rsc. The rsc
> contains the TCS that are used for communicating with the hardened
> resource accelerators on Qualcomm Technologies, Inc. (QTI) SoCs.
>=20
> Signed-off-by: Maulik Shah <mkshah@codeaurora.org>
> Signed-off-by: Rajendra Nayak <rnayak@codeaurora.org>
> ---

Reviewed-by: Stephen Boyd <swboyd@chromium.org>

