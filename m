Return-Path: <SRS0=+RQC=WP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1F258C3A5A2
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Aug 2019 17:58:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ED75622CF4
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Aug 2019 17:58:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="WRSqAnMY"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728249AbfHSR6X (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 19 Aug 2019 13:58:23 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:42702 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727808AbfHSR6W (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Aug 2019 13:58:22 -0400
Received: by mail-pf1-f194.google.com with SMTP id i30so1596344pfk.9
        for <linux-kernel@vger.kernel.org>; Mon, 19 Aug 2019 10:58:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=message-id:mime-version:content-transfer-encoding:in-reply-to
         :references:subject:from:cc:to:user-agent:date;
        bh=HoVmSkEe13oQswbHPUJHfU6oOJm3g2HoCRDfFS6v2nE=;
        b=WRSqAnMYQuRmKa8OeeXjBJh7hCRuFuvWgw3KW8lNHU+42UKEiLm3GJsfYWFUWUKytk
         YajmqMxJ6pqgduqWCTAMQtoStuBtKaMGVWmRpWGO6r7aZAk5ohA6+8OzL1TmME5HbInZ
         Jne+raVcvh/vvA+rp+fFzaTSjISdN3IqM9Dsc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:mime-version
         :content-transfer-encoding:in-reply-to:references:subject:from:cc:to
         :user-agent:date;
        bh=HoVmSkEe13oQswbHPUJHfU6oOJm3g2HoCRDfFS6v2nE=;
        b=VhtajeaPC4XVlZKRzVvBk+FD+FDmdEXoux2lpid2Wp0yaaeSwGs/XdOOrARavfU2Tv
         8wcsMTT5lN8WNuimW42ypXKQGjrHimSQbmQCtORJZgPy6TnfMEzVqjUvN3IRcl+MXlCb
         KX51C5HXoN4sOLotv0qtDrICJbgSfL40NGqCmP38fecz6N4R1qufp9PoQscW3YYRlrQ3
         EXmYeilD2mg+C/J62tyj37VnMlrUAbPkjZE6bJ84QbRTxiFG+HN7KLnA/iJiM6tJiAIY
         osG1drBVYWnA1QjLgmRcT0Be5KASNdIShzCaIx1c9WXYRZBfENUaJWcgv6DTZKg+EEho
         o/8g==
X-Gm-Message-State: APjAAAW5FOKsVg4rqbj/s6XuxKO2JA3O7NWCo5Oy3ikJZ8T7aUYZgqyT
        cEgB0j33fW99lstX4KLOaQwQRA==
X-Google-Smtp-Source: APXvYqwjJi4PF0tOiJFK9Fzga9qOPXzicdB09KvGaSWb7z0d1TsMp2llrCLtwaNJ06hA69FTJDdx7A==
X-Received: by 2002:a63:5a0a:: with SMTP id o10mr21379964pgb.282.1566237501974;
        Mon, 19 Aug 2019 10:58:21 -0700 (PDT)
Received: from chromium.org ([2620:15c:202:1:fa53:7765:582b:82b9])
        by smtp.gmail.com with ESMTPSA id h70sm14930028pgc.36.2019.08.19.10.58.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Aug 2019 10:58:21 -0700 (PDT)
Message-ID: <5d5ae33d.1c69fb81.49902.678d@mx.google.com>
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20190819101238.17335-1-niklas.cassel@linaro.org>
References: <20190725104144.22924-10-niklas.cassel@linaro.org> <20190819101238.17335-1-niklas.cassel@linaro.org>
Subject: Re: [PATCH v3 09/14] dt-bindings: opp: Add qcom-opp bindings with properties needed for CPR
From:   Stephen Boyd <swboyd@chromium.org>
Cc:     linux-arm-msm@vger.kernel.org, jorge.ramirez-ortiz@linaro.org,
        bjorn.andersson@linaro.org, ulf.hansson@linaro.org,
        Niklas Cassel <niklas.cassel@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
To:     Andy Gross <agross@kernel.org>,
        Niklas Cassel <niklas.cassel@linaro.org>,
        Nishanth Menon <nm@ti.com>, Viresh Kumar <vireshk@kernel.org>
User-Agent: alot/0.8.1
Date:   Mon, 19 Aug 2019 10:58:20 -0700
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Niklas Cassel (2019-08-19 03:12:38)
> Add qcom-opp bindings with properties needed for Core Power Reduction
> (CPR).
>=20
> CPR is included in a great variety of Qualcomm SoCs, e.g. msm8916 and
> msm8996. CPR was first introduced in msm8974.
>=20
> Co-developed-by: Jorge Ramirez-Ortiz <jorge.ramirez-ortiz@linaro.org>
> Signed-off-by: Jorge Ramirez-Ortiz <jorge.ramirez-ortiz@linaro.org>
> Signed-off-by: Niklas Cassel <niklas.cassel@linaro.org>
> ---

Reviewed-by: Stephen Boyd <swboyd@chromium.org>

