Return-Path: <SRS0=2dYc=UG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0240CC2BCA1
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Jun 2019 22:36:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C08622067C
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Jun 2019 22:36:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="GS9SPtDE"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730299AbfFGWg0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Jun 2019 18:36:26 -0400
Received: from mail-lj1-f196.google.com ([209.85.208.196]:36654 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729127AbfFGWgZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Jun 2019 18:36:25 -0400
Received: by mail-lj1-f196.google.com with SMTP id i21so3056496ljj.3
        for <linux-kernel@vger.kernel.org>; Fri, 07 Jun 2019 15:36:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=vgBCp4ESqu/SkK4WjZN/J9BX9JZ55PQyf6iWcQn1pSk=;
        b=GS9SPtDECv/U0yV2YQbOLqw+5LBwG6yGmq3y+24ZDxq1wYtCWbp6684rpb1naONMmZ
         H9Bme1mZGkHanhmEaavYoAodEAPDLAnvUYMB5nInTAqA5E/2gDq3mA2k74+HR9wcX30i
         6wfA6NiuKxVyjmKm2ZWmIzwgna/YJnHd//h99lqBWIBuAt+FD3ZkiKB/tC00uLBSXx7z
         XRVvgFqXW4RTAHMogLX8jJM2+cgfIVy8aGmj2tVQuI8FFNx4Ic1Ip2McUg0Ehv8oo/x8
         La7tM2qf2pNahrmrJ8sz8SNCNwVOJZwbAoR6bjHucQnPWDpaOX1PnsOXGFGDcwLn3gpX
         3gNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=vgBCp4ESqu/SkK4WjZN/J9BX9JZ55PQyf6iWcQn1pSk=;
        b=sfve8+Z6VvTpHkHQlrgg+tB72qg+iRrm6edxNR3pf/g6dd9SQ9SBp1g7KiWOALLM//
         9WBTjBV2CMHqqwGKp5n1fVI7ItK2bYTmXZ5lJuNlz63FwYfHVGS6ZyC1EfrrLqRxjZd+
         9XDX0599Of9jcBF00V/Ss/wwvv+zVSd0Ak9wFRoQs0LlpZIf/fcldVzpWwzhsryY3YKH
         Pt9FCjvFKk5XGa/eOnZlqtprLb73gwU/igFR1ln5O8lQBDCR3g4i2tXSQ9HgJcnQim1Q
         SMe0vXtT6nFx/VYn/2VGz+HjY/PbK6eyv8kMZmRSy3rSyw2dih4vSYTyt1Tc6VZ9CLhU
         B90w==
X-Gm-Message-State: APjAAAXAYVKnZ5Xvu+/rg3AhneAncIIKAZ44Cr3Z5z5THm/3s7NK+b5v
        I7t5KF45t5txCVNvEGY8IIgtFpJ2spGewkMAg66YvA==
X-Google-Smtp-Source: APXvYqxgE0ibblyo7qO/QgVZ5DieoVrgk3BnSd4jKinDWpu5Epy+KJ3s0E61Ts+2sw5YmkRrl6ga0cYi6auCd3LdIeM=
X-Received: by 2002:a2e:5dc4:: with SMTP id v65mr20396375lje.138.1559946983640;
 Fri, 07 Jun 2019 15:36:23 -0700 (PDT)
MIME-Version: 1.0
References: <20190605080259.2462-1-j-keerthy@ti.com> <20190605080259.2462-3-j-keerthy@ti.com>
In-Reply-To: <20190605080259.2462-3-j-keerthy@ti.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Sat, 8 Jun 2019 00:36:16 +0200
Message-ID: <CACRpkdbo3ceokuyE5UKiH3qH2JCeu7yNAVGa1ZH=sZ5T32BHUw@mail.gmail.com>
Subject: Re: [PATCH v2 2/3] gpio: davinci: Add new compatible for K3 AM654 SoCs
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

> Add new compatible for K3 AM654 SoCs.
>
> Signed-off-by: Keerthy <j-keerthy@ti.com>

Patch applied.

Yours,
Linus Walleij
