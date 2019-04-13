Return-Path: <SRS0=NhyN=SP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,FROM_LOCAL_NOVOWEL,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 238D0C10F11
	for <linux-kernel@archiver.kernel.org>; Sat, 13 Apr 2019 22:48:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D3E582147A
	for <linux-kernel@archiver.kernel.org>; Sat, 13 Apr 2019 22:48:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mx1jjAid"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727197AbfDMWsn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 13 Apr 2019 18:48:43 -0400
Received: from mail-yw1-f65.google.com ([209.85.161.65]:34099 "EHLO
        mail-yw1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726964AbfDMWsn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 13 Apr 2019 18:48:43 -0400
Received: by mail-yw1-f65.google.com with SMTP id x129so4733935ywc.1
        for <linux-kernel@vger.kernel.org>; Sat, 13 Apr 2019 15:48:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=BZDsNdmPkHDVvaRgFmRCTL/n++OeFT61LUkSemDAbFw=;
        b=mx1jjAidYK5reUpiwuPDpfRfT6r/446lWBW/TbKI/ZzeMJByEdbYiAhigzjD1lVi+X
         BHYb5iDxpDUZIRcKUCI39L/rIocONszlyAVC4a3XgKvs6OScZYZqTEWansx3B8RwZ+ox
         70zaaeXldwWXfpp0tQbJwPDEsYaOeUw1vidL6V7XFHtkafcv4rzEzgno/c60Dt5tnkHA
         BUgXPm6X5TamfQ9ELL/RlA6aDUFd3yPA08sQ7G2eiB1l637cxKtqKl5/bzMX2yx9xMxr
         mpXsmCoLhvIR9cawYGfMoPO9DzqDSe7lUdYX9Xi1C1YrdPIXJPSeUwWTp2/WWLYtkslz
         hmdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=BZDsNdmPkHDVvaRgFmRCTL/n++OeFT61LUkSemDAbFw=;
        b=pzjiChwxr975YCRYuTSC4C6PwajuwToM3jYdEd7fo3rmI4gLojoyKloPDqUhYMNH+W
         XI0o1Tbsgmv2F5wzDzVy2Cj+AY/Tadr5k9ZcFForFZ1vwKnoGPiXUCvvySpl1rwenr2Y
         qpN++Sfe1dqSzxPehGFPTpjd3VjEvaK5GgydExcUEb0rozdFyp/685zttkL+6W1534i+
         Ptr22TqnGPlXbBbFw8rm7aFvS58/NnJz/MM+rv6xPGH7qSLtpka/S2iJGDTnWJmc1U9k
         gh9guCWP+64Q/pvz7asgc0AXkiMSh4NX4ggavC+NhofzHNzHAjFpmn1lAm6PT2vToyqW
         XGMQ==
X-Gm-Message-State: APjAAAXokQffRulVc5UO5VZek30xuubMbbM1nYg9eSq7+kK1AINykWly
        bGUD+3uXad2g9rPmuLzfZU74JcJCu336Qjq37cY=
X-Google-Smtp-Source: APXvYqzq7VRMxnzqhRBNEU1dX3ducvbERyH6NCbUst5sAwT93gza6vkRyXyNxr5BCU4Ejx9gOBMLgvuINIp9ZbuRFwM=
X-Received: by 2002:a0d:c1c4:: with SMTP id c187mr52132645ywd.79.1555195722290;
 Sat, 13 Apr 2019 15:48:42 -0700 (PDT)
MIME-Version: 1.0
References: <20190413224438.10802-1-okaya@kernel.org> <20190413224438.10802-5-okaya@kernel.org>
In-Reply-To: <20190413224438.10802-5-okaya@kernel.org>
From:   Max Filippov <jcmvbkbc@gmail.com>
Date:   Sat, 13 Apr 2019 15:48:31 -0700
Message-ID: <CAMo8BfKcCRnL_r3BupraZCYS2oeQ1zbCL2fGs9tdNZRbqEGNKw@mail.gmail.com>
Subject: Re: [PATCH v5 4/5] xtensa: Replace CONFIG_DEBUG_KERNEL with CONFIG_DEBUG_MISC
To:     Sinan Kaya <okaya@kernel.org>
Cc:     LKML <linux-kernel@vger.kernel.org>, josh@joshtriplett.org,
        Kees Cook <keescook@chromium.org>,
        Chris Zankel <chris@zankel.net>,
        Max Filippov <jcmvbkbc@gmail.com>,
        "open list:TENSILICA XTENSA PORT (xtensa)" 
        <linux-xtensa@linux-xtensa.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Apr 13, 2019 at 3:44 PM Sinan Kaya <okaya@kernel.org> wrote:
>
> CONFIG_DEBUG_KERNEL should not impact code generation. Use the newly
> defined CONFIG_DEBUG_MISC instead to keep the current code.
>
> Signed-off-by: Sinan Kaya <okaya@kernel.org>
> Reviewed-by: Josh Triplett <josh@joshtriplett.org>
> ---
>  arch/xtensa/include/asm/irqflags.h | 2 +-
>  arch/xtensa/kernel/smp.c           | 2 +-
>  2 files changed, 2 insertions(+), 2 deletions(-)

Acked-by: Max Filippov <jcmvbkbc@gmail.com>

-- 
Thanks.
-- Max
