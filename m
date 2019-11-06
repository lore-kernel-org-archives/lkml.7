Return-Path: <SRS0=fWiu=Y6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A33A5C5DF65
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Nov 2019 19:10:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7545E2075C
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Nov 2019 19:10:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="I1Z9vGAw"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732056AbfKFTK4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 6 Nov 2019 14:10:56 -0500
Received: from mail-pg1-f193.google.com ([209.85.215.193]:40778 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731826AbfKFTKz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Nov 2019 14:10:55 -0500
Received: by mail-pg1-f193.google.com with SMTP id 15so17784630pgt.7
        for <linux-kernel@vger.kernel.org>; Wed, 06 Nov 2019 11:10:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=message-id:mime-version:content-transfer-encoding:in-reply-to
         :references:subject:from:to:cc:user-agent:date;
        bh=bvzyaeqQgm+ODV2zn40NLUNXtHBkt8JdlUL5UNv0l4w=;
        b=I1Z9vGAwk25jlQ11dQZp3amW+1dHSKt8UAg1cVjghjAnP4X5P59EHC1lm3jAKHU/p/
         V6achbPb6JpUnOhCVoWt+ITiJ1+2q/5WeovtoXNJQpBXFXEqRfhyawEotr9dlCcEACJV
         VUW313cPgbNYZhABbSZ7DgkvoyCQgvDLA3prs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:mime-version
         :content-transfer-encoding:in-reply-to:references:subject:from:to:cc
         :user-agent:date;
        bh=bvzyaeqQgm+ODV2zn40NLUNXtHBkt8JdlUL5UNv0l4w=;
        b=da7bFcPunFFaRi/kxda5gNJ5Li2aDGOEoQot8hb+AVCp5myhuYbC5XeP8U7YWVXyN2
         HL6dnNq99BUnJ/Zlm0+l5Axq7lb0IcsxcCV8TsELcryrSdzMznTsHNFNCEXEC2oockyP
         tKf2/lpTjeBchUso+9iDGvA6jRIJCHqsPorIu7FzBvSUGsglXr7sXFB1RSfMvuG52c3c
         Mj4K8F29x/MEMYn1qaUYXdcsHDo84IusdnPwGt939lDl2I6LtFWx46ixCXEPZ/1GPeiC
         oIoDBIz/+gPo7h/cnZ5ck7VnVAVEI8RaZnI6yK2C6bHxgIdnZLQo/uiBT84YtJqsSjtn
         KDYQ==
X-Gm-Message-State: APjAAAVzhVrFucYoHhkkz0koBAtiBNgCnYvK3eoRGxCf8faPQYOSIEQE
        d9F5cLzR5j4vV86OkNmUIWSnpg==
X-Google-Smtp-Source: APXvYqySU0SqbmsExE8w0VMB5UDSw5bGW97FD8SWOT1NMVBReEti1N8fzmDu5SWW9saMQ0Muy549Qg==
X-Received: by 2002:a63:1743:: with SMTP id 3mr4910114pgx.161.1573067455077;
        Wed, 06 Nov 2019 11:10:55 -0800 (PST)
Received: from chromium.org ([2620:15c:202:1:fa53:7765:582b:82b9])
        by smtp.gmail.com with ESMTPSA id q13sm3841834pjq.0.2019.11.06.11.10.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Nov 2019 11:10:54 -0800 (PST)
Message-ID: <5dc31abe.1c69fb81.1da16.a8b4@mx.google.com>
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20191106065017.22144-8-rnayak@codeaurora.org>
References: <20191106065017.22144-1-rnayak@codeaurora.org> <20191106065017.22144-8-rnayak@codeaurora.org>
Subject: Re: [PATCH v4 07/14] drivers: irqchip: qcom-pdc: Move to an SoC independent compatible
From:   Stephen Boyd <swboyd@chromium.org>
To:     Rajendra Nayak <rnayak@codeaurora.org>, agross@kernel.org,
        bjorn.andersson@linaro.org, robh+dt@kernel.org
Cc:     linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, mka@chromium.org,
        Rajendra Nayak <rnayak@codeaurora.org>,
        Lina Iyer <ilina@codeaurora.org>, Marc Zyngier <maz@kernel.org>
User-Agent: alot/0.8.1
Date:   Wed, 06 Nov 2019 11:10:53 -0800
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Rajendra Nayak (2019-11-05 22:50:10)
> Remove the sdm845 SoC specific compatible to make the driver
> easily reusable across other SoC's with the same IP block.
> This will reduce further churn adding any SoC specific
> compatibles unless really needed.
>=20
> Signed-off-by: Rajendra Nayak <rnayak@codeaurora.org>
> Cc: Lina Iyer <ilina@codeaurora.org>
> Cc: Marc Zyngier <maz@kernel.org>
> ---

Reviewed-by: Stephen Boyd <swboyd@chromium.org>

