Return-Path: <SRS0=GkzU=Y7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E44F5C5DF61
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Nov 2019 17:54:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B36EE2166E
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Nov 2019 17:54:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="TzkUMsHf"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389747AbfKGRyw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 Nov 2019 12:54:52 -0500
Received: from mail-pl1-f193.google.com ([209.85.214.193]:35384 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730884AbfKGRyw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Nov 2019 12:54:52 -0500
Received: by mail-pl1-f193.google.com with SMTP id s10so2025031plp.2
        for <linux-kernel@vger.kernel.org>; Thu, 07 Nov 2019 09:54:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=message-id:mime-version:content-transfer-encoding:in-reply-to
         :references:subject:from:to:cc:user-agent:date;
        bh=6n3o5+JOCVKLO8hHkLjsEkjuqiaK3IiXNN/Cf3cZ2IY=;
        b=TzkUMsHfydzu4SypLTCWeCrneyVNJ1wxVaQV/RBifHHe/SItQXYDGGwDWl5WNCyQeh
         4tW5bUU5CG8Q6AEnVd6HtB5QOLZZDIJYeoL1loQGUm7g2gst9EY0bzBhEtUDjS1wVK91
         lW8Fi21Xi15D3bfct2FgSsEDnxmp9osL2x4BY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:mime-version
         :content-transfer-encoding:in-reply-to:references:subject:from:to:cc
         :user-agent:date;
        bh=6n3o5+JOCVKLO8hHkLjsEkjuqiaK3IiXNN/Cf3cZ2IY=;
        b=Or40ybRNmAiSDpcDcODmVbv2+qLF/rEySlO5wlEEhv4KUotdOTUtMCrV33MIHgwtDN
         1E+FpfEsBO4cYZYl8BdFB6rjbIcnfq9/4KjRjlJzxbPBxiHOGBj6o9OmpzKtwXPN2y7h
         UAn2Nf5FaRhNs1ZfS2wkmutEAOB5wy9Fa6pH2T4cvSTHBHVi2q43v7M2tXamLKv3k8nw
         P8yGDfpddMkkCjPwnlfvj8ADZdx8mSkJKhWqnZsXi9jTD8q5BsgKLLi4RyPPhamxlY/2
         KyJk5fZug4K5YXl04YT/vfcuzXEnHc6KBy5Yyld/mawLOhE+7PJjmPDY9wU3aj/jerMh
         DA3Q==
X-Gm-Message-State: APjAAAVbmrALvav3dC9qytBGr9RWU+R3kQ1Uz0w5nNifnQGTvHD2RlgE
        d7GnlMtIiecKiDEHeH/fNDpYMQ==
X-Google-Smtp-Source: APXvYqzTXBrRZGyIzbAN9SNYwElgXMzMY1DfyZuzzmgKZjy60pLIhia1ZoLOO63kaie+gIKLbD+MzQ==
X-Received: by 2002:a17:90a:d152:: with SMTP id t18mr6795829pjw.119.1573149291566;
        Thu, 07 Nov 2019 09:54:51 -0800 (PST)
Received: from chromium.org ([2620:15c:202:1:fa53:7765:582b:82b9])
        by smtp.gmail.com with ESMTPSA id n21sm1295810pjq.13.2019.11.07.09.54.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Nov 2019 09:54:50 -0800 (PST)
Message-ID: <5dc45a6a.1c69fb81.bbfed.2d61@mx.google.com>
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20191106065017.22144-11-rnayak@codeaurora.org>
References: <20191106065017.22144-1-rnayak@codeaurora.org> <20191106065017.22144-11-rnayak@codeaurora.org>
Subject: Re: [PATCH v4 10/14] arm64: dts: qcom: sc7180: Add SPMI PMIC arbiter device
From:   Stephen Boyd <swboyd@chromium.org>
To:     Rajendra Nayak <rnayak@codeaurora.org>, agross@kernel.org,
        bjorn.andersson@linaro.org, robh+dt@kernel.org
Cc:     linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, mka@chromium.org,
        Kiran Gunda <kgunda@codeaurora.org>,
        Rajendra Nayak <rnayak@codeaurora.org>
User-Agent: alot/0.8.1
Date:   Thu, 07 Nov 2019 09:54:50 -0800
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Rajendra Nayak (2019-11-05 22:50:13)
> From: Kiran Gunda <kgunda@codeaurora.org>
>=20
> Add SPMI PMIC arbiter device to communicate with PMICs
> attached to SPMI bus.
>=20
> Signed-off-by: Kiran Gunda <kgunda@codeaurora.org>
> Signed-off-by: Rajendra Nayak <rnayak@codeaurora.org>
> ---

Reviewed-by: Stephen Boyd <swboyd@chromium.org>

