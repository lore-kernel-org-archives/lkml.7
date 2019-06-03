Return-Path: <SRS0=cV2B=UC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 34D4AC04AB6
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Jun 2019 09:03:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 08A2027DD5
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Jun 2019 09:03:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="QdL2vqG+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727122AbfFCJDL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Jun 2019 05:03:11 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:38493 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726902AbfFCJDL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Jun 2019 05:03:11 -0400
Received: by mail-wr1-f65.google.com with SMTP id d18so11153496wrs.5
        for <linux-kernel@vger.kernel.org>; Mon, 03 Jun 2019 02:03:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=axSkmR4/Wmhd1GVR+mG5T3r4ivwoxDL81oDdaQFl5E8=;
        b=QdL2vqG+S5MqpQeBh4plB+1IVk7Xk3sr+fQQIhcv1OMnz0WncZc+jCab8dnn2qc2Wo
         G/vDVBkFzxjiX8rg5EC6g2Ez7FIdYktE2SbC6I4poAZE1Vj8yVwxBmTYP+nAvEPfayOO
         f+mNlv9G5fgP/VF7WsU1L9p0W2EhrcwW4kaRobljvbCTqRS9404Fn12Y9V7rupVM3jBb
         gRjdCrwe04T0Rrp+1wki4RTE+UDN36YYQxZNvlZiWhyG+5MhTIbxQqybqa0JwF8ZyU2o
         eAGPCQZDb7wZ7tYD7P9DPeTtJ0sQ3Aq5ivf6w1V5likg8SU9hizveJjB7lZaDp/COIxP
         JXdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=axSkmR4/Wmhd1GVR+mG5T3r4ivwoxDL81oDdaQFl5E8=;
        b=GMgp7p404EuQLobi3rgrHa4xH8pmEufX71nTGMJM7aH1Ifj8HeZbRe5JfGX3gxEVRd
         04DkJqOMDrSq48wpyQfYw1ANylZqBc9OPTD03nxdldF2vWXiIZgRnkL/qVunSadOZu8l
         2lpHBlhprFoeXrep5zIwFSTpeG96sNCMs/ut70RtVetDwcUxIc8T7x6r6AAvbIuRd3//
         uBKMt2jVx6oEKhGg3y03e07bumv5KwaoisHUPffI+3KynF7CN7G32VFKl9WDX6UwJ/VI
         1l5gNH6ngTS82wnGrKb+iXbJT4PqaXdEHKMYJbrpgPd91r9V24Sg/vSGWD9eFr42/wow
         xR6w==
X-Gm-Message-State: APjAAAUqc7iXKpll1woXWh6hmArtlnNrz45qFkhCGcuZxjKpqFEBXfuF
        EX4P2ChMPEhnozJ6C0xNb30/CBDdhVs=
X-Google-Smtp-Source: APXvYqxAFgAGgOSEI8r8mePcq1atG3EcjGeizbjbvD0TfUwUAfZ7nS3C2kTq9eJdbcf/MS2IzVlcQQ==
X-Received: by 2002:adf:a749:: with SMTP id e9mr15762108wrd.64.1559552589525;
        Mon, 03 Jun 2019 02:03:09 -0700 (PDT)
Received: from dell ([2.27.167.43])
        by smtp.gmail.com with ESMTPSA id l15sm8588945wrb.42.2019.06.03.02.03.08
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 03 Jun 2019 02:03:08 -0700 (PDT)
Date:   Mon, 3 Jun 2019 10:03:06 +0100
From:   Lee Jones <lee.jones@linaro.org>
To:     Keerthy <j-keerthy@ti.com>
Cc:     robh+dt@kernel.org, broonie@kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-omap@vger.kernel.org, t-kristo@ti.com
Subject: Re: [PATCH 1/3] dt-bindings: mfd: lp87565: Add lp87561 configuration
Message-ID: <20190603090306.GH4797@dell>
References: <20190515100848.19560-1-j-keerthy@ti.com>
 <20190515100848.19560-2-j-keerthy@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20190515100848.19560-2-j-keerthy@ti.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 15 May 2019, Keerthy wrote:

> lp87561 is a single output 4-phase regulator configuration.
> Add support for the same.
> 
> Data Sheet: https://www.ti.com/lit/ds/symlink/lp87561-q1.pdf
> 
> Signed-off-by: Keerthy <j-keerthy@ti.com>
> ---
>  .../devicetree/bindings/mfd/lp87565.txt       | 36 +++++++++++++++++++
>  1 file changed, 36 insertions(+)

Applied, thanks.

-- 
Lee Jones [李琼斯]
Linaro Services Technical Lead
Linaro.org │ Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
