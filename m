Return-Path: <SRS0=S2At=YJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 03E72FA3728
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Oct 2019 17:39:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CE47D20663
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Oct 2019 17:39:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b="jSkGGBjc"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732524AbfJPRji (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 16 Oct 2019 13:39:38 -0400
Received: from mail-qt1-f193.google.com ([209.85.160.193]:33428 "EHLO
        mail-qt1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726383AbfJPRji (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Oct 2019 13:39:38 -0400
Received: by mail-qt1-f193.google.com with SMTP id r5so37382815qtd.0
        for <linux-kernel@vger.kernel.org>; Wed, 16 Oct 2019 10:39:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amarulasolutions.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=/Cx4XbFIa1sZs/uYwPjwYiglQbxuZVrvQE3ZO+WHpZ0=;
        b=jSkGGBjcRJJqTIh9MNDMGXbNJRI/LCnDRhaNwChrhsAbMBmD27FKvuIkphNz9Zi+ng
         bCqKQB7KdnAZy13xgSk+OvLy669mvex/kNk+EG1zJh5tlurc77U7xwtFOHuirYtFDY1z
         bCoUFVI7zHaBEYuFhR+BesqwbCo3dh2BnZFbU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=/Cx4XbFIa1sZs/uYwPjwYiglQbxuZVrvQE3ZO+WHpZ0=;
        b=FsZqLJwwHLpCfFKvVP2dnzJxO2piA+k/j88TAHstvZZ/bcWkxO8W8nRQOX7oKbb1X8
         TiNvcRWJ+AiVCk4hiLOgoHNz+dFhjI0edijpMcYy1ULikfy8i9TVVAkYjkHjcOkzP88v
         hgwhx9ZQhv1vBtKRlDQV43eMQC0KJqGI7DoCPd4QTTwluQRqz6Sj6iZOT3jN5wjELErv
         Sj7awZdU+9Nk3wh0Tf4jYKm+6wCrOl60CjAXQGe8oN9Cjv0wWZ8o6hL52QL9opL0Aajj
         XLW7LRlyeerfe8oPnv5K/ZvNJbIMX+ya4RE2sHWu92YJcGi0kUY+a4zP5cyphvH2M5Z3
         X0/Q==
X-Gm-Message-State: APjAAAU4ww7j6jeQjzjP4YWnh28jLHw/XGoPQfMN6xgBzuLkiPLA5Ssx
        CBwMsHioN0PES4X2w3UVfLL5Z9xW4PlKIRYyAnAvAIL6
X-Google-Smtp-Source: APXvYqwlghLwWKjPsF+lWMlnNrlMqW+5iR9QfBzroa/KEZbXO+cGpX2YYJRRQlH+ZiqpUprUp8HPYcr1Oo2PT6xdYkw=
X-Received: by 2002:a02:9a15:: with SMTP id b21mr3863352jal.103.1571245902352;
 Wed, 16 Oct 2019 10:11:42 -0700 (PDT)
MIME-Version: 1.0
References: <20190919052822.10403-1-jagan@amarulasolutions.com>
In-Reply-To: <20190919052822.10403-1-jagan@amarulasolutions.com>
From:   Jagan Teki <jagan@amarulasolutions.com>
Date:   Wed, 16 Oct 2019 22:41:31 +0530
Message-ID: <CAMty3ZAScACpT_ULQwJciLLu23eG_+JmYUCkrr-kOjJLe-E=-A@mail.gmail.com>
Subject: Re: [PATCH 0/6] arm64: dts: rockchip: ROC-PC fixes
To:     Heiko Stuebner <heiko@sntech.de>, Levin Du <djw@t-chip.com.cn>,
        Akash Gajjar <akash@openedev.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>
Cc:     Da Xue <da@lessconfused.com>,
        devicetree <devicetree@vger.kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        "open list:ARM/Rockchip SoC..." <linux-rockchip@lists.infradead.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        linux-amarula <linux-amarula@amarulasolutions.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Heiko,

On Thu, Sep 19, 2019 at 10:58 AM Jagan Teki <jagan@amarulasolutions.com> wrote:
>
> This series is trying to fix the Linux boot and other
> regulators stuff for ROC-RK3399-PC board.
>
> patch 1: attach pinctrl to pwm2 pin
>
> patch 2-4: libretech naming conventions
>
> patch 5-6: regulator renaming, input rails fixes
>
> Any inputs?
> Jagan.
>
> Jagan Teki (6):
>   arm64: dts: rockchip: Fix rk3399-roc-pc pwm2 pin
>   dt-bindings: arm: rockchip: Use libretech for roc-pc binding
>   arm64: dts: rockchip: Use libretech model, compatible for ROC-PC

These two patches are still valid right apart from renaming patch? any
comments on those?
