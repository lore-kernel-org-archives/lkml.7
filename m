Return-Path: <SRS0=2dYc=UG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 84F12C2BCA1
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Jun 2019 22:36:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 54B642067C
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Jun 2019 22:36:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="AvjWrnMH"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730979AbfFGWg4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Jun 2019 18:36:56 -0400
Received: from mail-lj1-f194.google.com ([209.85.208.194]:33327 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729127AbfFGWgz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Jun 2019 18:36:55 -0400
Received: by mail-lj1-f194.google.com with SMTP id v29so3076542ljv.0
        for <linux-kernel@vger.kernel.org>; Fri, 07 Jun 2019 15:36:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=l+khBBUKO+T+6jEQl6jfi10f9lijFzuP3gRY4E2wVHM=;
        b=AvjWrnMHNwzgXunPuuhGp1BzA/hhHPX5wMDEvokLp+7/tnogePsuerY59PSipnUHsA
         5ix3VSCMCQAiPpSPnahNx+f0CUMuml3C5wmFTtDhfE0cahBce/nO0504D3KASjiaUvwk
         pNB7COX8E8N9gfZPF7gXkgy5HbrBfLMt6lANA9MiDGT0Vb6CytYqyL2sKmVvM4NaFDQ2
         GqElsGwImBz/7MZjNz0xf0gjFV6wO/RrXZKsnksTj/+pUsYvm1FpUkqMXlbksFoE5mgH
         BsQlcb9HQRAdYY4aQiaHLzyFyiIP5ks0Gi650xCSnxOGbogyASxhDSPEPk1uTFHnnJDv
         g2Pg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=l+khBBUKO+T+6jEQl6jfi10f9lijFzuP3gRY4E2wVHM=;
        b=YnWFckvK2EZphCPIdUPLwMRzom+Hq9eceuhyfGIXUnj/wuj4Qr+7RySk7ngcUVZ3ME
         1mi58nm6uvzrcmnx96jkoOktLcSu0ir7JX3cJ2zSluTJb3bLVD1BfJ+sKLY/f2yrkrtu
         q/ZFDVoBGpWOCw8hsIt/YNNfr+Dw+umhVSCpluYK0VmuxiwbffmXMdrCJh1involxz/b
         LKi0QULttzu9+LNrvwR/eVIrhfi5ln+HV+D9P0jHJJWDZldR4rWXWZstoyzWgEt1nGJi
         amdTAbl4rdTSykDXmvvcqsfinFUmmcmEITSPivxBUH/ddmXa7BRzh5IwWm+Xf0Q7EziY
         4iHw==
X-Gm-Message-State: APjAAAWJPZ/YcNaPdl2K7ZIXcyBQkUg77Jd9mY4VrO4qcp87t89FPiNK
        vDdmtm1aFLgtPnvn/1uRwFNpAfrHtV6jqfgjb2Ylfg==
X-Google-Smtp-Source: APXvYqyBNawXjCYzHANN7vW1O9qXAC2FYF/LQpC3GE4QTC5eMwPWCe5HT2/ZqSKUoUxw2kv5mtc2gDbH6E86Q5fMtAo=
X-Received: by 2002:a2e:8902:: with SMTP id d2mr29323284lji.94.1559947013914;
 Fri, 07 Jun 2019 15:36:53 -0700 (PDT)
MIME-Version: 1.0
References: <20190605080259.2462-1-j-keerthy@ti.com> <20190605080259.2462-4-j-keerthy@ti.com>
In-Reply-To: <20190605080259.2462-4-j-keerthy@ti.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Sat, 8 Jun 2019 00:36:46 +0200
Message-ID: <CACRpkdbn6gyLeGA_QyNbvp7VFqJM3iKhCevx5zotsAVkL8SoZw@mail.gmail.com>
Subject: Re: [PATCH v2 3/3] gpio: Davinci: Add K3 dependencies
To:     Keerthy <j-keerthy@ti.com>
Cc:     Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        Lokesh Vutla <lokeshvutla@ti.com>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        Tero Kristo <t-kristo@ti.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 5, 2019 at 10:02 AM Keerthy <j-keerthy@ti.com> wrote:

> Add K3 dependencies to enable the driver on K3 platforms.
>
> Signed-off-by: Keerthy <j-keerthy@ti.com>

Patch applied.

Yours,
Linus Walleij
