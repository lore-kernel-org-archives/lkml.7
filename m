Return-Path: <SRS0=UImc=ZL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 34DCBC43215
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Nov 2019 18:51:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 046B22231E
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Nov 2019 18:51:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="iKD8b6/7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727587AbfKSSvc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Nov 2019 13:51:32 -0500
Received: from mail-pl1-f193.google.com ([209.85.214.193]:42803 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726994AbfKSSvb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Nov 2019 13:51:31 -0500
Received: by mail-pl1-f193.google.com with SMTP id j12so12233641plt.9
        for <linux-kernel@vger.kernel.org>; Tue, 19 Nov 2019 10:51:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=message-id:mime-version:content-transfer-encoding:in-reply-to
         :references:subject:from:cc:to:user-agent:date;
        bh=Y59PNIpnHrsDkHCPkT6UbcjTdgNITS13uFDLYBQ2JE4=;
        b=iKD8b6/7oWUjDcvOSG3a6DGaFMAZfmb4y1+vVYLqzj/jlM9ss82Nb0xtTEalph0SFj
         C5gBrbpHaWYCNAJDu1It+Ln+ESH/IOt7nB7UYxUAp7FWYPZ9CSn4KeJ7EpR5TkFvTTAj
         aOwPmL207I6B2IAURUOHpWeoF3i+yeFGqYSbI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:mime-version
         :content-transfer-encoding:in-reply-to:references:subject:from:cc:to
         :user-agent:date;
        bh=Y59PNIpnHrsDkHCPkT6UbcjTdgNITS13uFDLYBQ2JE4=;
        b=iBJvIm+iJHMauwqzJnIu/uMja36BhiAum/DpDQOk1mL6rrdM60rIhcJOoKdBmVtHBs
         9fAGoLGQLIb/hhZEoWTbzDJSWsgud+mB3jYh45aab12C3wPQrUW8vbdLitasiazPV5Av
         EBiuJbQ3OP15qmIV5eJNN5CcGY6znuvSGde4k0F8dilLtXex0lJoq29+uze1GC43GeBl
         BKOQ3euPqYUoth7cgqMR9sklGohVZmOMvFhd15Xt0ZlOM/xfXHoV4LBcc9Fan40nkH9R
         yNDYjtHuBGk1vUBVKUoH64LUhuqtrSGrKqVLGiqNWDVM775JFxIWa6PwciLgP01nVScd
         3WKw==
X-Gm-Message-State: APjAAAV/AawHF9rg8l0DRWohnOrNJPH7lHiZhb4BWTGCJRPymw4PFNzU
        ykNszIqcU0C3MAvJZS6kFoJstg==
X-Google-Smtp-Source: APXvYqx0ARyvlo81w6YDzxObSa8eyil+MOTvYMO8hEW4KrO6pxNX4Lw0nMRIjq0NAlpSEUhMTzajCQ==
X-Received: by 2002:a17:902:8d95:: with SMTP id v21mr34846748plo.96.1574189490883;
        Tue, 19 Nov 2019 10:51:30 -0800 (PST)
Received: from chromium.org ([2620:15c:202:1:fa53:7765:582b:82b9])
        by smtp.gmail.com with ESMTPSA id x186sm28268520pfx.105.2019.11.19.10.51.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Nov 2019 10:51:30 -0800 (PST)
Message-ID: <5dd439b2.1c69fb81.89655.0f0c@mx.google.com>
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <0101016e7f99ca93-ab6c1c1c-e20d-48ca-ab03-b8da0890fca8-000000@us-west-2.amazonses.com>
References: <20191118173944.27043-1-sibis@codeaurora.org> <0101016e7f99ca93-ab6c1c1c-e20d-48ca-ab03-b8da0890fca8-000000@us-west-2.amazonses.com>
Subject: Re: [PATCH 4/6] dt-bindings: power: Add rpmh power-domain bindings for sc7180
From:   Stephen Boyd <swboyd@chromium.org>
Cc:     agross@kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        mark.rutland@arm.com, dianders@chromium.org,
        Sibi Sankar <sibis@codeaurora.org>
To:     Sibi Sankar <sibis@codeaurora.org>, bjorn.andersson@linaro.org,
        rnayak@codeaurora.org, robh+dt@kernel.org, ulf.hansson@linaro.org
User-Agent: alot/0.8.1
Date:   Tue, 19 Nov 2019 10:51:29 -0800
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Sibi Sankar (2019-11-18 09:40:15)
> Add RPMH power-domain bindings for the SC7180 family of SoCs.
>=20
> Signed-off-by: Sibi Sankar <sibis@codeaurora.org>
> ---

Reviewed-by: Stephen Boyd <swboyd@chromium.org>

