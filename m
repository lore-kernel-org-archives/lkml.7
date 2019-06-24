Return-Path: <SRS0=hO5d=UX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 73204C4646B
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Jun 2019 22:13:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4827420663
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Jun 2019 22:13:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Mdb29tXw"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726951AbfFXWNY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Jun 2019 18:13:24 -0400
Received: from mail-lj1-f195.google.com ([209.85.208.195]:37602 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726402AbfFXWNY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Jun 2019 18:13:24 -0400
Received: by mail-lj1-f195.google.com with SMTP id 131so14159943ljf.4
        for <linux-kernel@vger.kernel.org>; Mon, 24 Jun 2019 15:13:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=E6ucUb/4G6TX7U6IlvaXO7Noph77Huv96zwgj/iVbk4=;
        b=Mdb29tXw/X8t1nTGw1Tb/az/GIy3MBpx/mG9kBd3XormoeMtZIiNk11sY5SclYB087
         C4XYpgkY6bBM5A1LgC+8ChSE8+hNnU/P6pDAwmHzzKztl4+9pGlxydZkItv+oZMfKfUh
         eJoCleDb/9fpZjoJJW99YaiZgFBCS5YnLl40mGgfl3C4X9D6QqPNnu7BJnshXGGDg+vm
         R9XtYGNyVdy5alZNZIwaHwAsmqrVCzdLhDdeMEh2Ulfg3Jz1LQqx08VSyPa0eGTuvAF1
         oBpQjRHm08vzaaolL5N3HfBcXBSaJidGyvBdAS7/ByxXCq4MsuGqdIGvpYxc4v4J+wRy
         o7Uw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=E6ucUb/4G6TX7U6IlvaXO7Noph77Huv96zwgj/iVbk4=;
        b=Ez1dIGqRX+uBqWKS6m46kfE43MgXyx9N5jw1Pfo3veJ4ETYQOUDpSvsfKllHCdIcAP
         mYfQlnTXaD4BguApyFWL4K9pXf96eZAeNYN0uTk2e3808oNaGN/1Et4nwF5j4lxqTF99
         ndJc7jzOpGCOEGJgyBdvMQNuE8bi/nwxu9eqrs/3aQxIniJLia/CNm5yYPCvkxBbTEhP
         khWHcnE4uURdUVxuXudDNvVtERrjr7Uw2jmhlS37LRvF8F1AZGlaWP+pNvd9ICqZ90ha
         x0lx4WN5uTtWzBAOPAtn5NyZAT1c1dNpWl9A6LDbiqFibZKkMnGi5If32Hez1iJh5VrV
         pI4w==
X-Gm-Message-State: APjAAAWOne5Jh8xZ+Iu7VcfoJzd8ofhdTstkh8MNDgdkTa0j6ALmKAgR
        l4AXkh/rRzlm/Ht/LarmKehq0kXsH4S2HSZuSaRnsw==
X-Google-Smtp-Source: APXvYqzuILOmlRlfzB4LigJuOFz6xkIbsL4hLOVKc/1qZByIgUnbCmOIDWO1UqiLgRGGrL9IShuXg3gaJHpmgCB46gU=
X-Received: by 2002:a2e:8195:: with SMTP id e21mr59447382ljg.62.1561414402129;
 Mon, 24 Jun 2019 15:13:22 -0700 (PDT)
MIME-Version: 1.0
References: <20190624215649.8939-1-robh@kernel.org> <20190624215649.8939-11-robh@kernel.org>
In-Reply-To: <20190624215649.8939-11-robh@kernel.org>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Tue, 25 Jun 2019 00:13:10 +0200
Message-ID: <CACRpkdYKE=zLJhmTeTWYGRCQNt3K8+rNNqsp5UDa2d31GG6Y2g@mail.gmail.com>
Subject: Re: [PATCH v2 10/15] dt-bindings: display: Convert tpo,tpg110 panel
 to DT schema
To:     Rob Herring <robh@kernel.org>
Cc:     "open list:DRM PANEL DRIVERS" <dri-devel@lists.freedesktop.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        Sam Ravnborg <sam@ravnborg.org>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 24, 2019 at 11:59 PM Rob Herring <robh@kernel.org> wrote:

> Convert the tpo,tpg110 panel binding to DT schema.
>
> Cc: Linus Walleij <linus.walleij@linaro.org>
> Cc: Thierry Reding <thierry.reding@gmail.com>
> Cc: Sam Ravnborg <sam@ravnborg.org>
> Cc: Maxime Ripard <maxime.ripard@bootlin.com>
> Cc: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
> Cc: dri-devel@lists.freedesktop.org
> Signed-off-by: Rob Herring <robh@kernel.org>

Awesome, fixed up the MAINATINERS entry and applied and
pushed for DRM next with my Reviewed-by.

Yours,
Linus Walleij
