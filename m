Return-Path: <SRS0=3iFO=VV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6C534C7618F
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Jul 2019 22:33:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3E1BE21850
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Jul 2019 22:33:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nkBeIOGm"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729407AbfGXWdl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Jul 2019 18:33:41 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:34448 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728584AbfGXWdl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Jul 2019 18:33:41 -0400
Received: by mail-pg1-f196.google.com with SMTP id n9so15691070pgc.1
        for <linux-kernel@vger.kernel.org>; Wed, 24 Jul 2019 15:33:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=Y/x6T9kinMfPan8m7akcwnPUQ5JFdRG0gz/KSb0mcCI=;
        b=nkBeIOGm6q+oZWaL1ucDgpjPsDPDqfkbxl/mobplA0/OSCxx9bfOy3wgZHieGk4UuF
         V9blwGoM6eEl3/UJpefJ1Jwp/LLvbTNcNUw32bnxDFkbkKHJSO8W2bwDMh1Yv9w2ez7X
         Sdj7jZHap6xYPpj9fAHjMpeCZkImIcYI1iqdB3hBEpdadCnC9/dK26taxnQmhL2Ta3In
         ZuLf2khv7kwyCo1FmEP77XOXrr7xEAPq0Y1/ZUqy+HLPII4Q3y2YKgLHkxmL1uoiW3UB
         4hCXeOMbFEnhC52VlKcTN7hB6dpWyghayWkm0FYLQjutHOG/MXObHvrkFtKKAgcV90ap
         QKEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=Y/x6T9kinMfPan8m7akcwnPUQ5JFdRG0gz/KSb0mcCI=;
        b=DHJtm5C1NM/UNF6sYO1IGAhNasIL8Fa4DiCK4tOkbxO5sPRsHoAL7FH+xdR5P2kgpj
         133qiTxFNTMCWrg9XmLHfs6HNcW7F/4U+0WQcly7eR0ADvvA4xZ/4Rmk1W9fNcfWMECM
         /MHcMlKisJTvtk78a0NicY2jyk3bskiQ53jCdwp2W4iTPxuGEWb8ODqroAp4WkiUa27v
         s2iNBuKYNES7WyErT/FvO15fhm3bX+qIXd2RroRBneuX8JZtrrrL/ynvKEUomLLIxmwd
         xfGuS9kX0QFdFQ4bqnRdA3AI6jWObOTPTfKkzVRllThIe76J5cCyTKnL0PWnKFhhqdxk
         fKGQ==
X-Gm-Message-State: APjAAAVE189sb9rOZH2hg5fjR2611vIMlAYIImhsvpdJMsvoZz9DFXtM
        hUWKGSDYSi+m6nxP5gKSyF8=
X-Google-Smtp-Source: APXvYqz8l8S9S4kT3bBRHUZtDyZDw87gOZ6oemul7YrBcmpaj0riEqQvW2MvkMmjoQau2NA+p6bWnA==
X-Received: by 2002:a17:90a:ad89:: with SMTP id s9mr90574492pjq.41.1564007620473;
        Wed, 24 Jul 2019 15:33:40 -0700 (PDT)
Received: from Asurada-Nvidia.nvidia.com (thunderhill.nvidia.com. [216.228.112.22])
        by smtp.gmail.com with ESMTPSA id w14sm53942878pfn.47.2019.07.24.15.33.39
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 24 Jul 2019 15:33:40 -0700 (PDT)
Date:   Wed, 24 Jul 2019 15:34:22 -0700
From:   Nicolin Chen <nicoleotsuka@gmail.com>
To:     Daniel Baluta <daniel.baluta@nxp.com>
Cc:     broonie@kernel.org, festevam@gmail.com, perex@perex.cz,
        tiwai@suse.com, Xiubo.Lee@gmail.com, timur@kernel.org,
        alsa-devel@alsa-project.org, linuxppc-dev@lists.ozlabs.org,
        linux-kernel@vger.kernel.org, linux-imx@nxp.com,
        shengjiu.wang@nxp.com, angus@akkea.ca, kernel@pengutronix.de,
        l.stach@pengutronix.de, viorel.suman@nxp.com
Subject: Re: [PATCH 01/10] ASoC: fsl_sai: add of_match data
Message-ID: <20190724223422.GA6859@Asurada-Nvidia.nvidia.com>
References: <20190722124833.28757-1-daniel.baluta@nxp.com>
 <20190722124833.28757-2-daniel.baluta@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190722124833.28757-2-daniel.baluta@nxp.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 22, 2019 at 03:48:24PM +0300, Daniel Baluta wrote:
> From: Lucas Stach <l.stach@pengutronix.de>
> 
> New revisions of the SAI IP block have even more differences that need
> be taken into account by the driver. To avoid sprinking compatible
> checks all over the driver move the current differences into of_match_data.
> 
> Signed-off-by: Lucas Stach <l.stach@pengutronix.de>

Looks like Mark has applied this already? If so, should probably
drop applied ones and rebase the remaining patches for a resend.
