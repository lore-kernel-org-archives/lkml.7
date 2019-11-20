Return-Path: <SRS0=PPSE=ZM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 43E9BC432C0
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Nov 2019 20:16:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1271E20872
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Nov 2019 20:16:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="XEy7WaGq"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726836AbfKTUQi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Nov 2019 15:16:38 -0500
Received: from mail-lj1-f195.google.com ([209.85.208.195]:39234 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726510AbfKTUQh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Nov 2019 15:16:37 -0500
Received: by mail-lj1-f195.google.com with SMTP id p18so564742ljc.6
        for <linux-kernel@vger.kernel.org>; Wed, 20 Nov 2019 12:16:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=As7pKQ0itiBPr+JVzJNRbGflXyWEUqoGImZXztf0jEU=;
        b=XEy7WaGq7tnXJWeHZWtz0DwTyLPI5ZIDiFBhpBU/p+enAkw3f0UID6GJcKUKKhDXwB
         3zAy7hyjoieIeZcKpDx5M3kdNUoMZqzFs5gZNm984sQbeIYqSq7ZFmRck6P7s4qJdPIS
         nydKNUoBsu2hVpIyERlo9YIrafC2SWqeJ9p0rTQXTSwsYU1flWI/42RRYkdlpdArN0Ab
         4lwJX/mndLLYBbj3ixlqdttpycoL7TjF1Ybm1R4TIC41cf0FFFHeBY84qDEZDHRTGW6k
         FglI8GhQAHWQFfVHDlFVgZyzB0zeTIwYjGzscfkYOoeEOlupu3J52a6Ah6QWfY/vJ25e
         A8ug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=As7pKQ0itiBPr+JVzJNRbGflXyWEUqoGImZXztf0jEU=;
        b=hHRDLFmhigM/EYYl+qkl3M9wJ4ETdt6gmTcjH+L8irWvwkGy/Z9nWjs8/NUoDboLby
         jUNbexXcO1dfGfmzEMCo+Rww1UUWw7RPizFBSyd4TLiwU2N2nu6yJL3Y4wYIliPzIl6u
         qJYVND0CQ4mv3R1sLZ/1lY71dwLhZIAaiZ9OjAkI8FtjM5v1AHRD7hAYVEM5lSlbmpuh
         Seh/VsfVK2w7XYxTn1STcojkShgmgr4Ueo2P4aBUxghHN7K+dzhK0OKKmlWc+0rK7Tgy
         fFygkkiD0hJS3Td53Z5viUvs/WoYB3fF7EnPL/sN/G/EkhYtO+Ur6qjb2l0cZaDT7YwF
         laeg==
X-Gm-Message-State: APjAAAWbi6rLyz1GDRvFUJ9rDx66G/BMLQHyWOh4kBM7nCTiYQcfJZTA
        BU4PwV6Bu5DN3Fjxj5kKWojQgikGvoTPjRoqjYbn5Q==
X-Google-Smtp-Source: APXvYqx+bECbdnOoxTCki5xJSDVYs7EMIZ2Q1kvVZaDKVhZI1elr6NsjrHwr5uD2qsoUC1YJ0MgiOfh8fbu78lxOV2k=
X-Received: by 2002:a2e:8597:: with SMTP id b23mr4421824lji.218.1574280992576;
 Wed, 20 Nov 2019 12:16:32 -0800 (PST)
MIME-Version: 1.0
References: <20191117221053.278415-1-stephan@gerhold.net>
In-Reply-To: <20191117221053.278415-1-stephan@gerhold.net>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Wed, 20 Nov 2019 21:16:20 +0100
Message-ID: <CACRpkdYoq0E3HEmo4QBOWaAkQN8Ti=cm2OL+gjBORynsJ7D8jw@mail.gmail.com>
Subject: Re: [PATCH 1/2] dt-bindings: mfd: ab8500: Document AB8505 bindings
To:     Stephan Gerhold <stephan@gerhold.net>
Cc:     Lee Jones <lee.jones@linaro.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Nov 17, 2019 at 11:14 PM Stephan Gerhold <stephan@gerhold.net> wrote:

> AB8505 can now be configured from the device tree.
> The configuration is almost identical to AB8500, so just add a note
> for the nodes/compatibles that differ between the two revisions.
>
> Cc: Linus Walleij <linus.walleij@linaro.org>
> Signed-off-by: Stephan Gerhold <stephan@gerhold.net>

Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij
