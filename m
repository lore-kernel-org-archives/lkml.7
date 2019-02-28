Return-Path: <SRS0=g5d9=RD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DB303C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Feb 2019 19:23:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B0EBF218CD
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Feb 2019 19:23:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="TFqLL+Hu"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387504AbfB1TXh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Feb 2019 14:23:37 -0500
Received: from mail-pf1-f196.google.com ([209.85.210.196]:42328 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1733094AbfB1TXg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Feb 2019 14:23:36 -0500
Received: by mail-pf1-f196.google.com with SMTP id n74so10179718pfi.9
        for <linux-kernel@vger.kernel.org>; Thu, 28 Feb 2019 11:23:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:content-transfer-encoding:in-reply-to:to:subject
         :message-id:references:from:cc:user-agent:date;
        bh=UxJdd19ZaRxHNXdKbyGZspiexEULqHCJZsYHzOGhYuw=;
        b=TFqLL+Humf2r7i8PXkaMN79OauoXx9jLbsmG5VWL1KH7BY6hbRMSuja4kGKFb1FUyS
         pqGDQ5hEgC2fAVIFP3BtzJGDMlqqCQHq0Z/F7iZK0U/1l4sr+N9UGpGV9LLK3Nztv7ne
         rdLvKEi8aIS33F2dj5nQ2Q0e7R7n/l2Sbcyfc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:content-transfer-encoding
         :in-reply-to:to:subject:message-id:references:from:cc:user-agent
         :date;
        bh=UxJdd19ZaRxHNXdKbyGZspiexEULqHCJZsYHzOGhYuw=;
        b=dZAzmMJkuGrOBmVp0kP1fXFvyBjG7ud4uRUrIsBPXeVejL1CUoQKZbRDEPk6pJTO+p
         nerZmsXvtuqXJ2k1U5UznlwcNLIMFiHN3r9QOYuxEhcgZ8R0mOlqEgTfCD+DuwVLavBo
         TWm3amOHJmllIVzz3Ww3Mmm8gPdvRQYdQ41/cXgGMhAQI2uiML7p+MtKiDM4rfc1uLXz
         bU3WwQeVhg6h7pe9CHDPuV+5TsV/tTepg8N8WMwELCJk8ehO2+pK/IVMKVbfhLlOqt5b
         cQcNjPsM9w3zxNTxvSlJT4o4IbYkiAxnNxpAHL5F8Q0Ic1tsSjrCMcKnfHGTlUeb86uc
         n5zw==
X-Gm-Message-State: APjAAAUQogJiBtTi5Bn65NzvjpyMISVpFoIK/n3l8hYOQbesVYbWbm6V
        ampT2hP9UjgrizFodA6GkopkmA==
X-Google-Smtp-Source: APXvYqy3576hAig119UCQsquWx0dB7PRHmT5nZAjrsO3ASQ67n2MVRT+g2iIgNHXc0LmI417P2aO/A==
X-Received: by 2002:a62:e11a:: with SMTP id q26mr1167170pfh.187.1551381816279;
        Thu, 28 Feb 2019 11:23:36 -0800 (PST)
Received: from localhost ([2620:15c:202:1:fa53:7765:582b:82b9])
        by smtp.gmail.com with ESMTPSA id x2sm32481695pfx.78.2019.02.28.11.23.35
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 28 Feb 2019 11:23:35 -0800 (PST)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20190225065044.11023-3-vaishali.thakkar@linaro.org>
To:     Vaishali Thakkar <vaishali.thakkar@linaro.org>,
        andy.gross@linaro.org
Subject: Re: [PATCH v4 2/5] base: soc: Export soc_device_register/unregister APIs
Message-ID: <155138181486.16805.5450392002425706490@swboyd.mtv.corp.google.com>
References: <20190225065044.11023-1-vaishali.thakkar@linaro.org> <20190225065044.11023-3-vaishali.thakkar@linaro.org>
From:   Stephen Boyd <swboyd@chromium.org>
Cc:     david.brown@linaro.org, gregkh@linuxfoundation.org,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        rafael@kernel.org, bjorn.andersson@linaro.org, vkoul@kernel.org,
        Vaishali Thakkar <vaishali.thakkar@linaro.org>
User-Agent: alot/0.8
Date:   Thu, 28 Feb 2019 11:23:34 -0800
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Vaishali Thakkar (2019-02-24 22:50:41)
> From: Vinod Koul <vkoul@kernel.org>
>=20
> Qcom Socinfo driver can be built as a module, so
> export these two APIs.
>=20
> Signed-off-by: Vinod Koul <vkoul@kernel.org>
> Signed-off-by: Vaishali Thakkar <vaishali.thakkar@linaro.org>
> Reviewed-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> ---

Reviewed-by: Stephen Boyd <swboyd@chromium.org>

