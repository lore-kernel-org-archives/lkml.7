Return-Path: <SRS0=uOpN=TO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 299D2C46470
	for <linux-kernel@archiver.kernel.org>; Tue, 14 May 2019 18:05:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 00AF720850
	for <linux-kernel@archiver.kernel.org>; Tue, 14 May 2019 18:05:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="aMJHVMpr"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727610AbfENSFq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 May 2019 14:05:46 -0400
Received: from mail-ot1-f65.google.com ([209.85.210.65]:36875 "EHLO
        mail-ot1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726295AbfENSFl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 May 2019 14:05:41 -0400
Received: by mail-ot1-f65.google.com with SMTP id r10so15378968otd.4;
        Tue, 14 May 2019 11:05:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=+D/N+r1giXeXDAaGbyLrs8fCnRD/jcuGXeK2jnEOa8o=;
        b=aMJHVMprRMJ1ROstXctMEViVqeogfaxUVHPAZxxWl6nkAZSwE8NnZmadm8c8ZGWja7
         xECrK6tb7cTD66LLaTFX2RHjxtVa9Mj9TS8mew4SLaxuezYxim/hjdnSHkx5x71XITQy
         18bv3P1tzIaadPmZJLANY3dz8bzt8/JZOA1eCdOYPdFVgKoQqDn0Lslpc81WiPWs/SzD
         6FdMQ/A0D6j6NNE5sA0UdNVMd08grw8arZxoMBch/UwXWp/ge3FXxnisgSFssMjotfIz
         Dou4UzGDPQ6S14fT/mLjSXNIztmu90TpZwXEoXh+irAV/YHj1wTzrIrAaHeifKWTNEur
         rlww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=+D/N+r1giXeXDAaGbyLrs8fCnRD/jcuGXeK2jnEOa8o=;
        b=Qs6IzOwIgfURNGlbthIvJAMPm7+oGNzNkd9q1dFi/hMw3PRROPwN19b87jsf4qH1pr
         l616uX3lQbfR1ty9jeDqNnI45SVtqycmAG/FFww3oXi/0FAwplX27zWV6kz09UjkR2Pi
         EWCBSKe+3mVcE3fG/65Bm8mn9scfCfM0qJzXWYEBhgP0FaCWxSFzY1liDbZK3bfg4HRO
         es346pwLKBkVGpviz7UNP+iJUeu3lDebXC1oZCJgpOInHPAxcoJiaFrh1xkREP3fcLCa
         gp4EKRcQYETnvxNnZyKITnnc/Dy6tqsJ/PRD42kBejUI6W/NL1/TSKyC+WoIbboq1qML
         rP6Q==
X-Gm-Message-State: APjAAAXbukNnI5IB3fzMpclTRliJnXCV4z+KQwje3m2V47l72IsemQIB
        SjVihn3GjepLwmQLjYoYd5ISuEa1XOhgdPcScfw=
X-Google-Smtp-Source: APXvYqzWsq8151+UbJ2LbnrNIepcgZ940jijOe83vsRThzaVL6cIRg6qRcoRT17i6RTor2GTk3ILIIITR7bW4w5tGDE=
X-Received: by 2002:a9d:141:: with SMTP id 59mr21942610otu.158.1557857139636;
 Tue, 14 May 2019 11:05:39 -0700 (PDT)
MIME-Version: 1.0
References: <20190513130507.22533-1-jbrunet@baylibre.com>
In-Reply-To: <20190513130507.22533-1-jbrunet@baylibre.com>
From:   Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Date:   Tue, 14 May 2019 20:05:28 +0200
Message-ID: <CAFBinCC+TKf_WO_fwqEu8Gzc7r3od6xkCyN6-9hPz9-0nmEw0g@mail.gmail.com>
Subject: Re: [PATCH] arm64: dts: meson: nanopi k2: add sd DDR50
To:     Jerome Brunet <jbrunet@baylibre.com>
Cc:     Kevin Hilman <khilman@baylibre.com>, devicetree@vger.kernel.org,
        linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 13, 2019 at 3:05 PM Jerome Brunet <jbrunet@baylibre.com> wrote:
>
> Add UHS ddr50 mode to the nanopi k2
>
> Signed-off-by: Jerome Brunet <jbrunet@baylibre.com>
Acked-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>

since I'm curious: is this due to your recent meson-gx-mmc patches?
this is the first board where we enable the UHS DDR50 mode


Martin
