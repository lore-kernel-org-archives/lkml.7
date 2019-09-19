Return-Path: <SRS0=X8En=XO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 020CEC4CEC4
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Sep 2019 00:53:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C8451218AF
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Sep 2019 00:53:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="I6EwWMae"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387603AbfISAx2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 18 Sep 2019 20:53:28 -0400
Received: from mail-pl1-f178.google.com ([209.85.214.178]:33759 "EHLO
        mail-pl1-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387547AbfISAx1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Sep 2019 20:53:27 -0400
Received: by mail-pl1-f178.google.com with SMTP id t11so782468plo.0
        for <linux-kernel@vger.kernel.org>; Wed, 18 Sep 2019 17:53:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=message-id:mime-version:content-transfer-encoding:in-reply-to
         :references:cc:to:from:subject:user-agent:date;
        bh=ex9rUQL+OJKYYhbhN5KToiVk5tqfEncnCZ8PLvYAyAI=;
        b=I6EwWMaeMxFk/HXli6epcKdtu117wdLEGInSTM3MEx7jZ6dJlhg6TYmHn1OlIrmLnX
         9oZU2+9V4nFkpeziVNZHFtY8oWsbjRmV2KuIz3W9EWl9W+EvhGv1fs780DWXH/I0cr2x
         ziG68200CsfjNI8oWzbp/YNKJbwf+92TYpFLw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:mime-version
         :content-transfer-encoding:in-reply-to:references:cc:to:from:subject
         :user-agent:date;
        bh=ex9rUQL+OJKYYhbhN5KToiVk5tqfEncnCZ8PLvYAyAI=;
        b=C+DCO1wNXeJhq7HlxWE94p5BjV/IpHWHmlVY3qi8KcLvhfOFUS9P1f+vv16PVMmmOH
         2oajTnL328hIknA3MkprJ36pJhZamxPU2+0X2mDKofIoFjGt6mHicpM8XgP94a6iOyTb
         0euvpHTRpMaY/cOy6dr5SZUmdPt2NgM/MppJxrclUvmuHc2eJ9RAbjekvvc4ENmEw5pj
         1WROtKd4tEJwyr69VEmYNvX2PcBvjMh1F3voQRgO5y1Zm4eMji9nhMudyKSi35ScD0c4
         CaoZ3VJX5OsaXLFWsNlDDWfdlZIRgX5Uhu2jzB2btPyE/3CtapZ3YOA8TkZAMsFyyEKL
         xLmQ==
X-Gm-Message-State: APjAAAX9jTOSBFtlyXE/KU2ibIY3kbT/2DoxX8jmg+kz2qmMGrdMglIs
        S4+FfWpx+zbvl69vafVjWq3axw==
X-Google-Smtp-Source: APXvYqxem6DCTC1eMDn7xjXLkC5brOjq3FB50tq/9uO3+hR3/3TGD9xLISDWzo39z92diQKZvV74dQ==
X-Received: by 2002:a17:902:bc46:: with SMTP id t6mr7191923plz.307.1568854406970;
        Wed, 18 Sep 2019 17:53:26 -0700 (PDT)
Received: from chromium.org ([2620:15c:202:1:fa53:7765:582b:82b9])
        by smtp.gmail.com with ESMTPSA id q2sm10846812pfg.144.2019.09.18.17.53.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Sep 2019 17:53:26 -0700 (PDT)
Message-ID: <5d82d186.1c69fb81.23c8c.8bf8@mx.google.com>
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <01e14fb78bb1e13c235645281b462a548a1de304.1568712606.git.saiprakash.ranjan@codeaurora.org>
References: <cover.1568712606.git.saiprakash.ranjan@codeaurora.org> <01e14fb78bb1e13c235645281b462a548a1de304.1568712606.git.saiprakash.ranjan@codeaurora.org>
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
Subject: Re: [PATCHv6 2/3] firmware/qcom_scm: Add scm call to handle smmu errata
User-Agent: alot/0.8.1
Date:   Wed, 18 Sep 2019 17:53:25 -0700
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Sai Prakash Ranjan (2019-09-17 02:45:03)
> From: Vivek Gautam <vivek.gautam@codeaurora.org>
>=20
> Qcom's smmu-500 needs to toggle wait-for-safe sequence to
> handle TLB invalidation sync's.
> Few firmwares allow doing that through SCM interface.
> Add API to toggle wait for safe from firmware through a
> SCM call.
>=20
> Signed-off-by: Vivek Gautam <vivek.gautam@codeaurora.org>
> Reviewed-by: Bjorn Andersson <bjorn.andersson@linaro.org>
> Signed-off-by: Sai Prakash Ranjan <saiprakash.ranjan@codeaurora.org>
> ---

Reviewed-by: Stephen Boyd <swboyd@chromium.org>

