Return-Path: <SRS0=PPSE=ZM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B71BBC43215
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Nov 2019 20:22:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8471620855
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Nov 2019 20:22:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ff5LYego"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727085AbfKTUWe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Nov 2019 15:22:34 -0500
Received: from mail-lj1-f193.google.com ([209.85.208.193]:46690 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726163AbfKTUWe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Nov 2019 15:22:34 -0500
Received: by mail-lj1-f193.google.com with SMTP id e9so529084ljp.13
        for <linux-kernel@vger.kernel.org>; Wed, 20 Nov 2019 12:22:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=WIs2wEBI7GHcKXrPIdb0P1t899q8+wkAb8c9SvukX6U=;
        b=ff5LYegovKn2N31GnRkIVaZC23z2BnCIHNQhHghOxSeUxVY2MyLfrH2ORY4uFz+zMk
         +svyf4VlzsPF9hyXo2oouXZAhq9xoAhbomPHWrAhS7XWl1pcT7qzauhCVfVIv1jF7lDx
         9kr9+eUO1ZKlwYwJB7AaVHdelTUIZs6BgeEuHXqYbE9zY7JyJgi9Xq4CVVEi5Bah4ES3
         DAtNA0TgFKne97QdHyCg1Z3fDpktmMpiQCWC+ojr8DU5ZfsLsRuFysea965v+dZRtm2W
         OdinZb/T5ygoAh1oPgW4E1vtnm56s9scRp8TQ5hgb4XHCChyV/vvNeBv+jKDjmmWEBqi
         R9ww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=WIs2wEBI7GHcKXrPIdb0P1t899q8+wkAb8c9SvukX6U=;
        b=CS2bo4f+yCdAVlcjZxsb1xkuR39kkncrcABx11t7HojOcs++UNS/neizJJlQLUqRis
         3LRNfV4/PzRlIU2N6G3E5F7toylg+YRcbM2DD42VfmkKyMMGVB2KBTx0sjldvu+g2oD4
         8GWSDSefC6/gAszaovSz7Y/VIL0XsmGU7jy/YRrtNgjDsRSBYOnSgvnd7TpLbxdkh62y
         PP9tuSoMjeKyW2JZ4tc30MGkF4JQycDJ2BFemXkiUce2VnDGUQAdMaCMkmk9GZmhfS8a
         yy+F7P7mDFpbejW19ao+9VE0pictHefta3A6dVUZ+0jK6kWz40RdH1bcDlLAkErmG08S
         jn+g==
X-Gm-Message-State: APjAAAWEL93fe2bIGJzfGfg24fgq0DpkMu5YSA20GBVZM8nLM5iTK517
        QXQILNtnqjmG8fgZmmdxEAdlRZjBQ5OCJP6Bxz15vQ==
X-Google-Smtp-Source: APXvYqy2BISaXVNMfN24w1XiqMw+nLLDE0BQUreU/J6rnVcy1Ij3PIjm9d04GqP69zz3p2BYuHH2gKiarIavmZVruo0=
X-Received: by 2002:a2e:9699:: with SMTP id q25mr4387891lji.251.1574281351953;
 Wed, 20 Nov 2019 12:22:31 -0800 (PST)
MIME-Version: 1.0
References: <20191120181857.97174-1-stephan@gerhold.net> <20191120181857.97174-4-stephan@gerhold.net>
In-Reply-To: <20191120181857.97174-4-stephan@gerhold.net>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Wed, 20 Nov 2019 21:22:19 +0100
Message-ID: <CACRpkda-rm=1hz_p2YCqBVgxsM9cmKYJVUg+T91MyBrgmtDP-w@mail.gmail.com>
Subject: Re: [PATCH v2 4/4] dt-bindings: arm: Document compatibles for Ux500 boards
To:     Stephan Gerhold <stephan@gerhold.net>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 20, 2019 at 7:20 PM Stephan Gerhold <stephan@gerhold.net> wrote:

> The device-specific compatible values used by the Ux500 boards
> were not documented so far. Add a new simple schema to document them.
>
> Signed-off-by: Stephan Gerhold <stephan@gerhold.net>

Nice, thanks!

Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

I expect Rob to merge these patches as they are bindings-only,
alternatively I can take them in the Ux500 DTS pull request
for the next kernel cycle.

Yours,
Linus Walleij
