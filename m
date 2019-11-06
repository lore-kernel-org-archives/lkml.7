Return-Path: <SRS0=fWiu=Y6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E2D15C5DF63
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Nov 2019 19:11:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AFFF721848
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Nov 2019 19:11:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="eZKYMJZE"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732120AbfKFTLS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 6 Nov 2019 14:11:18 -0500
Received: from mail-pg1-f193.google.com ([209.85.215.193]:40812 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728580AbfKFTLS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Nov 2019 14:11:18 -0500
Received: by mail-pg1-f193.google.com with SMTP id 15so17785279pgt.7
        for <linux-kernel@vger.kernel.org>; Wed, 06 Nov 2019 11:11:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=message-id:mime-version:content-transfer-encoding:in-reply-to
         :references:subject:from:to:cc:user-agent:date;
        bh=OY7gYgd4FJIkTEZvHN5NIFLp9ZtxgEWcRq8vKLuNkWk=;
        b=eZKYMJZEiWsrur04nmp7VZR3e1RCS4GAobfM3f+fvB/0jOdeMyvy6E0CNoiiG58tmP
         HF+qx4/SsMBzIpYVrT5lktFKK73yQsJZ59QUCf4A9aesilgrJWeWFSepb5iecF7/6HVp
         McKkOqPs9GfnRlwLHmQFzVq+rgHR6xd7KNhJA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:mime-version
         :content-transfer-encoding:in-reply-to:references:subject:from:to:cc
         :user-agent:date;
        bh=OY7gYgd4FJIkTEZvHN5NIFLp9ZtxgEWcRq8vKLuNkWk=;
        b=gM8OqlVc/vHu5h4UKNScqdvyk+AVMX5YOHjbgW5bW+jeBpe1CALP0JpRfi0VH1Jjb0
         MB5whxWPHZvSnhMWDlh3vWfGwno9mbenvqxJdKPcXf0Zwe6ZDPR02PHDzzbXysTBu8dv
         oT3MvGgoJuoSR/q3WTMZm7LzvIpWJqK28WnNieeMdlsFQn8qJu58kQnhyI1GmMI90xNh
         HRf0o6KO8t/9BsQJJi/MOXjYijbVDHsdRjbw5fN9G51yfZTosKsCojAymimAs5FcrVAH
         BJbj5xtHetb6CrqekYroD0YA/Ts2P2o6hF7szk5xrndgIyMKlKssSCon2MMGaiFHRNww
         Vtxg==
X-Gm-Message-State: APjAAAW3xNIyCcNbQr+ah5HYtbg+12AoFEgx0W/fkfl0StGxIEsZLSs9
        AQmlWyxpSjJ3odzTI5wbBJDCvA==
X-Google-Smtp-Source: APXvYqyI9rQeSviss4gD6JhTRezTghk0Fxp7c2WSM+6a22e7Ntor3/PHJM3cg/rIyepQ2iDqA3GZRQ==
X-Received: by 2002:a63:ec4f:: with SMTP id r15mr4643147pgj.17.1573067477046;
        Wed, 06 Nov 2019 11:11:17 -0800 (PST)
Received: from chromium.org ([2620:15c:202:1:fa53:7765:582b:82b9])
        by smtp.gmail.com with ESMTPSA id x9sm3943428pje.27.2019.11.06.11.11.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Nov 2019 11:11:16 -0800 (PST)
Message-ID: <5dc31ad4.1c69fb81.195ac.b1d8@mx.google.com>
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20191106065017.22144-9-rnayak@codeaurora.org>
References: <20191106065017.22144-1-rnayak@codeaurora.org> <20191106065017.22144-9-rnayak@codeaurora.org>
Subject: Re: [PATCH v4 08/14] dt-bindings: qcom,pdc: Add compatible for sc7180
From:   Stephen Boyd <swboyd@chromium.org>
To:     Rajendra Nayak <rnayak@codeaurora.org>, agross@kernel.org,
        bjorn.andersson@linaro.org, robh+dt@kernel.org
Cc:     linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, mka@chromium.org,
        Rajendra Nayak <rnayak@codeaurora.org>,
        Lina Iyer <ilina@codeaurora.org>, Marc Zyngier <maz@kernel.org>
User-Agent: alot/0.8.1
Date:   Wed, 06 Nov 2019 11:11:15 -0800
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Rajendra Nayak (2019-11-05 22:50:11)
> Add the compatible string for sc7180 SoC from Qualcomm.
>=20
> Signed-off-by: Rajendra Nayak <rnayak@codeaurora.org>
> Cc: Lina Iyer <ilina@codeaurora.org>
> Cc: Marc Zyngier <maz@kernel.org>
> ---

Reviewed-by: Stephen Boyd <swboyd@chromium.org>

