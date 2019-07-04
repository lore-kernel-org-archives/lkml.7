Return-Path: <SRS0=IBEs=VB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5DF04C0650E
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Jul 2019 07:46:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 371BA2133F
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Jul 2019 07:46:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="JJTwPDrn"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727044AbfGDHq4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 4 Jul 2019 03:46:56 -0400
Received: from mail-lj1-f193.google.com ([209.85.208.193]:35913 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726844AbfGDHqz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Jul 2019 03:46:55 -0400
Received: by mail-lj1-f193.google.com with SMTP id i21so5189993ljj.3
        for <linux-kernel@vger.kernel.org>; Thu, 04 Jul 2019 00:46:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=FbowtTXJF3QFhJ+0g3CanF/mErH/8mwP+8HtXFh3lcU=;
        b=JJTwPDrnOaJhqi5LfDKpVC6A4J6s/xgYjGmVsxsNAfBJx54YwIp1Q5SEY5yhOS6m8F
         l7JwbLFP41q855m/5ZZVp45EX3qVmQfsBZfdGAp3wbCjRHhG6IEmMlCDwNnVpHCrCrcA
         MRa6MP4wchKhRQy4C1wMh8mO16q/YzH3HnzGm+0vyPLMDWsyVC4hFcxhl6koNh7W/D98
         Msw/H2o7jzcS1Uhr3wmHJMUuaiPgheSDyjPC13FX5Q/s/B3OR9V5g7QSkJxXLtnG++hv
         JVy6fZZn1uHAr6KybCjG7j0kxx0v3ECcED7PJ91Dp0NlKSmR4tuFyFGYKVm4Ark/kZ+M
         5lNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=FbowtTXJF3QFhJ+0g3CanF/mErH/8mwP+8HtXFh3lcU=;
        b=EcKlFzaV4cWHSW+Ryb0vJm/afyZ2IK6nu+YlMc0zLuLplxcBvIQHpZE9NG2bwr/Wjo
         Z4GFYxW8IEe0Ne+1Na4OVRvqKRSMp/3q6Q3U7IhQniwOb8qjLbBUIDet6j79eb4+24u0
         wXXxAAEAZMJqXMRMcPIw9YjlDbusam5x8N5gtaZe800nh2nawi6jHGsEYLK75vjINpLc
         7KOy0eFGvyaUj7uLWURgJ64Mv8usvYygoucJ+WEHMJJtp/f46KIlwDtueqOvMVcOBpPF
         GmQOyMQcOOhxKfHH2d/60FYRkeobBOw+7RtMVo7i4vZLbPn9WijV/9OiORBYQQUi1lBv
         p+hw==
X-Gm-Message-State: APjAAAXWhAhox4ZJo8HYdBck0thhycWy0kcv5rfsGFW4WGkxOZdxRB5V
        bX/yXfKuWosp2+qPVh79pC51ga4X0SN91VCZaaJNUgaP
X-Google-Smtp-Source: APXvYqzqg5P2vMEvtlnyJnlnLPgWS8atGO17WX4nId84bAvMCyKUN49Rj0v1zHwWQYFxM9dFj68ZveRig2GhLolmJSQ=
X-Received: by 2002:a2e:9048:: with SMTP id n8mr2128406ljg.37.1562226413734;
 Thu, 04 Jul 2019 00:46:53 -0700 (PDT)
MIME-Version: 1.0
References: <20190702105045.27646-1-vkoul@kernel.org> <20190702105045.27646-3-vkoul@kernel.org>
In-Reply-To: <20190702105045.27646-3-vkoul@kernel.org>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Thu, 4 Jul 2019 09:46:42 +0200
Message-ID: <CACRpkdYuhUNggeVQ-urVKkV-Pa64zy_hJEb5d3wJ2K3MvBQB8w@mail.gmail.com>
Subject: Re: [PATCH v2 2/3] dt-bindings: pinctrl: qcom: Add SM8150 pinctrl binding
To:     Vinod Koul <vkoul@kernel.org>
Cc:     MSM <linux-arm-msm@vger.kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Prasad Sodagudi <psodagud@codeaurora.org>,
        Andy Gross <agross@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "Isaac J . Manjarres" <isaacm@codeaurora.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 2, 2019 at 12:54 PM Vinod Koul <vkoul@kernel.org> wrote:

> From: Prasad Sodagudi <psodagud@codeaurora.org>
>
> Add the binding for the TLMM pinctrl block found in the SM8150 platform.
>
> Signed-off-by: Prasad Sodagudi <psodagud@codeaurora.org>
> Signed-off-by: Isaac J. Manjarres <isaacm@codeaurora.org>
> [vkoul: add missing nodes of gpio range and reserved
>         rewrote function names and order them]
> Signed-off-by: Vinod Koul <vkoul@kernel.org>

Patch applied with Bjorn's ACK.

Yours,
Linus Walleij
