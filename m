Return-Path: <SRS0=TLrx=2G=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BC3C3C43603
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Dec 2019 19:36:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 88ED82082E
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Dec 2019 19:36:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="oN62Nud0"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727482AbfLPTgF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 16 Dec 2019 14:36:05 -0500
Received: from mail-pj1-f66.google.com ([209.85.216.66]:45802 "EHLO
        mail-pj1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727453AbfLPTgE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Dec 2019 14:36:04 -0500
Received: by mail-pj1-f66.google.com with SMTP id r11so3429994pjp.12
        for <linux-kernel@vger.kernel.org>; Mon, 16 Dec 2019 11:36:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=message-id:mime-version:content-transfer-encoding:in-reply-to
         :references:subject:to:from:cc:user-agent:date;
        bh=5tZt6zZ1S+fVatR78M8B2+XrluLkJCGawdF/aH5D3dQ=;
        b=oN62Nud0FYaBL8CqZaYUiBC5XOS4rWL5oonbdEYsU8eQ+ZGcuCgjcE9v4/7Qz0wu59
         wKgD8Wj+JKQfNUNviBHq9U6I8ZMFtpRMg/u9mPXTfWFLYN/6fR41kqy447Im38AbbCI2
         s4ZPUmBDonYOo0h2c23bsZ2PB3sxgsl/+ulwo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:mime-version
         :content-transfer-encoding:in-reply-to:references:subject:to:from:cc
         :user-agent:date;
        bh=5tZt6zZ1S+fVatR78M8B2+XrluLkJCGawdF/aH5D3dQ=;
        b=EHghOQifu7Qas3WrShVjy8hsylAc9SZ+6e81hBPOaW/A6JNyxhv+X4EmQQc02h0kDA
         ZdZyoTWusC8TQMiWXZy22WQr7+SRCJMvEpu4sF4XEUOfFQ8FKvDc9Y3tHITm/jQKYKmn
         YcgW2QLPtpLVcmKiFPciaQAt7OWsZIAcRBUvyxdHUxFF9KAuUwPqHJlum5XUjlSYMt/A
         EJ/l5INd3gtc7Dqd/DGwIMLcDIGc5pHYFG2kKXxFzyjmWJKWhCMOrEV8bsqb/d80+RY9
         fE0Pg0ChFcMtNOnXz/o7aFaZCXVlIJ5ibrInwDk4lO5Y9JpPP05EFoki2L58+CK7uXIi
         Mu+w==
X-Gm-Message-State: APjAAAX2Wl1JWuWBwIyiFoN7MPV64KdqQiBDeu9eMzclG/avAtHYKMO4
        7hxJkmzY1dyTDN+BiD5B1lCrRg==
X-Google-Smtp-Source: APXvYqzgLVp5SCoceOc5nLMs72Cez/6LNuWcnU638uhaNvnqczKBacjWrTm0MGwLpqBCR+EHdcKNvQ==
X-Received: by 2002:a17:902:8ec2:: with SMTP id x2mr17690413plo.290.1576524964286;
        Mon, 16 Dec 2019 11:36:04 -0800 (PST)
Received: from chromium.org ([2620:15c:202:1:fa53:7765:582b:82b9])
        by smtp.gmail.com with ESMTPSA id ce22sm275996pjb.17.2019.12.16.11.36.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Dec 2019 11:36:03 -0800 (PST)
Message-ID: <5df7dca3.1c69fb81.e53a7.1650@mx.google.com>
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20191216115531.17573-3-sibis@codeaurora.org>
References: <20191216115531.17573-1-sibis@codeaurora.org> <20191216115531.17573-3-sibis@codeaurora.org>
Subject: Re: [PATCH 2/2] arm64: dts: qcom: sc7180: Add rpmh power-domain node
To:     Sibi Sankar <sibis@codeaurora.org>, bjorn.andersson@linaro.org,
        rnayak@codeaurora.org, robh+dt@kernel.org
From:   Stephen Boyd <swboyd@chromium.org>
Cc:     agross@kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        mark.rutland@arm.com, dianders@chromium.org,
        Sibi Sankar <sibis@codeaurora.org>
User-Agent: alot/0.8.1
Date:   Mon, 16 Dec 2019 11:36:02 -0800
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Sibi Sankar (2019-12-16 03:55:31)
> Add the DT node for the rpmhpd power controller on SC7180 SoCs.
>=20
> Signed-off-by: Sibi Sankar <sibis@codeaurora.org>
> ---

Reviewed-by: Stephen Boyd <swboyd@chromium.org>

