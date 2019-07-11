Return-Path: <SRS0=G0tX=VI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CFDCDC74A4B
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Jul 2019 09:18:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A0B0E21019
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Jul 2019 09:18:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PwBMIS9h"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728177AbfGKJSW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 11 Jul 2019 05:18:22 -0400
Received: from mail-wm1-f66.google.com ([209.85.128.66]:34972 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727595AbfGKJSV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Jul 2019 05:18:21 -0400
Received: by mail-wm1-f66.google.com with SMTP id l2so4949509wmg.0;
        Thu, 11 Jul 2019 02:18:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=3fOgz1HmCtagvlUL/uPREEe2zIZr6sKtMCeCzceJUyw=;
        b=PwBMIS9hm+yEYCvBflAbbJcinxzbpqVbzcZ5Q24LtfSmLm1mbaf/pN9oIgcCL4yvuc
         hdlyoTfLfi9kzgFCH8gntOGEZi8zpPHmMhmTgYhin8sdCblY8+F5kv87728lP8zFiV0s
         hafGrAtLAmkIdGxeFnTKr5dXFvTZ5rDAEGV2056ILBfC8ijYzQPTbXtxetRIian3zoN1
         AbG2a6/lZBXHS4zYNUJs9eJa2yQwe8sLksce06FBRsfUDz70hTIbKPM/oywlistKCe3T
         ivkWSDP2dHw/uyZAe5DU/M1KDFUCL0ZAXnpIULeB/iGw/Z9NHLsunlc5+tQoFeXtEA7M
         T7pQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=3fOgz1HmCtagvlUL/uPREEe2zIZr6sKtMCeCzceJUyw=;
        b=idTJjdksuTpyA4ZSUkwiI1JVgpNZAluh9xhH1377Zn3CUZ9T3+AajMc3WgGzIKAwnY
         rtTXB7uv8xSVdXZ+LSIlrlbJRFGoU62IywfGFdUV2feDnp5TEu4xPT7sgd3+mRgd2wcR
         o4P9PNpZOfBg7EvKe+KATJmaPcnebIpl0yVFntf7xk+SYGzUhCVpDKKzVGyGCWxnKiZI
         XIBjKxy3ybLNnoP0h7tZpqlHDo3GvFS5qGqXvtF7aLvmlg7ICJJqbAgYwHTmMCDQZiGw
         ePRC0MqOwkVAE5PvI6Wrm2dVRvWSQN+UwWbZGcFjkpyd+WjNTQIYl9JdEBLb/42HXCa+
         s13Q==
X-Gm-Message-State: APjAAAWozHW8uCxb9U9+PpBPAOxPD9bIZkdbLub7PC4nlA3MlKAw/mB3
        L2zeEfYL0tZk+ZMPEaqQbpU=
X-Google-Smtp-Source: APXvYqxPFuR4M5BCR8Sb+ubGATW/uN4m71lAA+qeXPQ1bZfFhMczU5S7jaBPszXh+H2hg8yJaV1Wyw==
X-Received: by 2002:a1c:3:: with SMTP id 3mr3153271wma.6.1562836699392;
        Thu, 11 Jul 2019 02:18:19 -0700 (PDT)
Received: from localhost ([193.47.161.132])
        by smtp.gmail.com with ESMTPSA id n14sm7481561wra.75.2019.07.11.02.18.17
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 11 Jul 2019 02:18:18 -0700 (PDT)
Date:   Thu, 11 Jul 2019 10:57:25 +0200
From:   Oliver Graute <oliver.graute@gmail.com>
To:     Abel Vesa <abel.vesa@nxp.com>
Cc:     "sboyd@kernel.org" <sboyd@kernel.org>,
        "mturquette@baylibre.com" <mturquette@baylibre.com>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        dl-linux-imx <linux-imx@nxp.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Aisheng Dong <aisheng.dong@nxp.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>
Subject: Re: [PATCHv2] clk: add imx8 clk defines
Message-ID: <20190711085725.GA1385@optiplex>
References: <20190619074000.30852-1-oliver.graute@gmail.com>
 <20190711082039.zze4t22rvlgdxzow@fsr-ub1664-175>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190711082039.zze4t22rvlgdxzow@fsr-ub1664-175>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/07/19, Abel Vesa wrote:
> On 19-06-19 09:39:52, Oliver Graute wrote:
> > From: Oliver Graute <oliver.graute@kococonnector.com>
> > 
> > added header defines for imx8qm clock
> > 
> > Signed-off-by: Oliver Graute <oliver.graute@kococonnector.com>
> 
> Again, this seems to be taken from some vendor tree, so please keep the
> original author.

yes the header defines is from NXP vendor tree. One of orginal authors is

Author: Anson Huang <Anson.Huang@nxp.com>
Date:   Thu Jan 19 03:53:31 2017 +0800
    MLK-13911-3 ARM64: dts: imx8qm: add dtsi
    Add i.MX8QM dtsi support.
    https://github.com/ADVANTECH-Corp/linux-imx6.git

Whats is the right way to attribute him?

Best regards,
Oliver
