Return-Path: <SRS0=X8En=XO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B8EB4C4CEC9
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Sep 2019 00:50:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8627A218AF
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Sep 2019 00:50:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="dsvU98HY"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387438AbfISAuK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 18 Sep 2019 20:50:10 -0400
Received: from mail-pg1-f195.google.com ([209.85.215.195]:40401 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730302AbfISAuK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Sep 2019 20:50:10 -0400
Received: by mail-pg1-f195.google.com with SMTP id w10so832061pgj.7
        for <linux-kernel@vger.kernel.org>; Wed, 18 Sep 2019 17:50:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=message-id:mime-version:content-transfer-encoding:in-reply-to
         :references:cc:to:from:subject:user-agent:date;
        bh=szuMCQn4rttr5Elca80oSLyqr8pMoCySJeOydbql8kI=;
        b=dsvU98HYe8f100cpwvVJP1d+QcBb4ryTBqN+tS63dnQ1/1mYOoJ6yKvM1fPJh88Dex
         wo8LxZ6m00muwQXYfkNdonytuwDzOKosfum4GptdYiB3AnKRoMzlbGlRBE1LOKdYYxhP
         mz3HfCUIosQA6JLRHOfkf6HzfPbVxXBatTlWM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:mime-version
         :content-transfer-encoding:in-reply-to:references:cc:to:from:subject
         :user-agent:date;
        bh=szuMCQn4rttr5Elca80oSLyqr8pMoCySJeOydbql8kI=;
        b=gFpvGDP6Uz2vNKe5OrVbGGWeI+71KjfsYJqxVPZWnPro4qdh4vEYdZ8ktJwhlRK6IF
         4jlZLqetE0pwpDeVHXCSvqKvn3x7FTDEtk/wwrENEz1XEYeNrbUg0z4RB8mMz4p2ZGx8
         4MVPmbJU6LUUUmdrmdvJaLDgPyOpckxgesq6bT5wURGajIyvACI4Nafq9rPF02VSOKbd
         q06XhVjkhFYE11x6cc5o0vFjnfYjrpx7Z+Nzk9p6k5zigowVhJ1n36sqXI8V36nB0ijv
         qMCaLh8UIeIarfC++AmxvgLDtHdnGdZsG0y54nOhFAL+LTfLi5l7UVP0BwxKn9ZjWmHU
         JOKw==
X-Gm-Message-State: APjAAAVmfDS7reQeANB2eqYChHA2Yf/mv4V8+qOIcpKV/iw6K+Veaevg
        qqE27/lWCz2E06BZGn/Ws3x/9g==
X-Google-Smtp-Source: APXvYqwwUE/+1mBEfp4DK/H8YE+W8UmNVfqmsjbBZwaUdEjDPGEWhaG6E7Bk1StoTVGsI6Wj88GrmA==
X-Received: by 2002:a65:57ca:: with SMTP id q10mr6781384pgr.52.1568854209372;
        Wed, 18 Sep 2019 17:50:09 -0700 (PDT)
Received: from chromium.org ([2620:15c:202:1:fa53:7765:582b:82b9])
        by smtp.gmail.com with ESMTPSA id f6sm6663996pga.50.2019.09.18.17.50.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Sep 2019 17:50:08 -0700 (PDT)
Message-ID: <5d82d0c0.1c69fb81.93841.042e@mx.google.com>
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <f30070e7acdd463dec0e1305b47cdd8f1cc7c11c.1568712606.git.saiprakash.ranjan@codeaurora.org>
References: <cover.1568712606.git.saiprakash.ranjan@codeaurora.org> <f30070e7acdd463dec0e1305b47cdd8f1cc7c11c.1568712606.git.saiprakash.ranjan@codeaurora.org>
Cc:     linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Rajendra Nayak <rnayak@codeaurora.org>,
        Sai Prakash Ranjan <saiprakash.ranjan@codeaurora.org>
To:     Andy Gross <agross@kernel.org>, Joerg Roedel <joro@8bytes.org>,
        Robin Murphy <robin.murphy@arm.com>,
        Sai Prakash Ranjan <saiprakash.ranjan@codeaurora.org>,
        Vivek Gautam <vivek.gautam@codeaurora.org>,
        Will Deacon <will@kernel.org>, bjorn.andersson@linaro.org,
        iommu@lists.linux-foundation.org
From:   Stephen Boyd <swboyd@chromium.org>
Subject: Re: [PATCHv6 1/3] firmware: qcom_scm-64: Add atomic version of qcom_scm_call
User-Agent: alot/0.8.1
Date:   Wed, 18 Sep 2019 17:50:07 -0700
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Sai Prakash Ranjan (2019-09-17 02:45:02)
> From: Vivek Gautam <vivek.gautam@codeaurora.org>
>=20
> There are scnenarios where drivers are required to make a
> scm call in atomic context, such as in one of the qcom's
> arm-smmu-500 errata [1].
>=20
> [1] ("https://source.codeaurora.org/quic/la/kernel/msm-4.9/
>       tree/drivers/iommu/arm-smmu.c?h=3Dmsm-4.9#n4842")
>=20
> Signed-off-by: Vivek Gautam <vivek.gautam@codeaurora.org>
> Reviewed-by: Bjorn Andersson <bjorn.andersson@linaro.org>
> Signed-off-by: Sai Prakash Ranjan <saiprakash.ranjan@codeaurora.org>
> ---

Reviewed-by: Stephen Boyd <swboyd@chromium.org>

