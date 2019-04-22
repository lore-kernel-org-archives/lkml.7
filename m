Return-Path: <SRS0=BnvS=SY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A1275C10F14
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Apr 2019 03:18:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6F16D20859
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Apr 2019 03:18:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="rfDV5WGC"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726759AbfDVDSC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 21 Apr 2019 23:18:02 -0400
Received: from mail-it1-f194.google.com ([209.85.166.194]:50263 "EHLO
        mail-it1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726108AbfDVDSB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 21 Apr 2019 23:18:01 -0400
Received: by mail-it1-f194.google.com with SMTP id q14so8495620itk.0;
        Sun, 21 Apr 2019 20:18:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=fUN9eWXIXlkwhQ0u74rg/ZgA9U61dG+XrWi7avTbJk4=;
        b=rfDV5WGCN5sm5pQmR00SkK+v/W0TUFAeCJOPeaQSa0oghWF/yRoSGGB64QdEAt7U8J
         0fcu+9CqlCiOzHswGVcz/xamlmSnxRK3h3qQaCBL7xUV7VdkVRYfOB7rbHXskU1QP2Ty
         3pNHjJq2V4KCbNLj6gJzRMH30Y7WkGZf88ZA5Uf/1PLpBGP0n/hoUrIiZOksAfrwUou/
         LhFBI06OE20eqzOruGS5USpi9k5z8XLi48hV6614dYjFPumgVmJtcoOdtS3YR/yYvfTz
         Oy2VwMyNNYY1VErcq/WnnP77CZnsJ2XfE4fBHkZCXdx8HQAzmH6hnBlpZw0G8SiXJX3y
         mlcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=fUN9eWXIXlkwhQ0u74rg/ZgA9U61dG+XrWi7avTbJk4=;
        b=dd+o4N7ElJDX+ao8hB2Mh1nAIfdDV9kjMtAIEKNDNW91GoWY+FKsQU8DRLk00rsVT+
         fAjkqiOTYD3haFNRqH+QZoXuXByyCAHlapAIMFi/sMMQAP2X/O9dRtJir2Pz1m6Q+TcK
         xfvm6AcvLxIg0kXiXhA7o6r20omnW2Exz2+FVBEOdiIZZVK0ZAOjcmKxVAq4N5hbRZcN
         Dx5jiywpyT3rcw8h+JJSchi1q00DjgPtPLWmIIx4rMUm8vCs8rUigUbgn4h1E8mjByET
         6ClU24YCEvmPt7ffDb3JE7IRsb+fXdkkrtKRX6GOClfb2eYhHjJgrOipTWGj0C8QgJRJ
         tqfQ==
X-Gm-Message-State: APjAAAXfRMrsV5XVptatQFeQ37mJAsMPfz0fOpHG/HRin8/2FFjYSjbD
        AsQ7AmM/GM+674ggNya89PL6ERG02PxicAVZyxE=
X-Google-Smtp-Source: APXvYqw1qEi5yxBSZ8k2593WAqhR4GIonzAgDw5ZsA5danhrCIIR+IFzq8xhTONooAXaPGwT1+23uDuWONDnr2x7XFQ=
X-Received: by 2002:a24:58d:: with SMTP id 135mr11521636itl.3.1555903080585;
 Sun, 21 Apr 2019 20:18:00 -0700 (PDT)
MIME-Version: 1.0
References: <20190422022307.19616-1-crag0715@gmail.com> <20190421.194453.2169045719820345607.davem@davemloft.net>
In-Reply-To: <20190421.194453.2169045719820345607.davem@davemloft.net>
From:   Crag Wang <crag0715@gmail.com>
Date:   Mon, 22 Apr 2019 11:17:49 +0800
Message-ID: <CAP-8N0jiguFSdyeop3rxMoNdYJemCRSdohyOR4z8B3HDmdUmng@mail.gmail.com>
Subject: Re: [PATCH v2 1/1] r8152: sync sa_family with the media type of
 network device
To:     David Miller <davem@davemloft.net>, netdev@vger.kernel.org
Cc:     linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        hayeswang@realtek.com,
        Mario Limonciello <mario_limonciello@dell.com>,
        crag.wang@dell.com, sjg@chromium.org, seanpaul@chromium.org,
        grundler@chromium.org, david.chen7@dell.com, f.fainelli@gmail.com,
        jslaby@suse.cz, gustavo@embeddedor.com,
        charles.hyde@dell.corp-partner.google.com, bigeasy@linutronix.de,
        zhongjiang@huawei.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 22, 2019 at 10:44 AM David Miller <davem@davemloft.net> wrote:
>
>
> Networking driver patches not sent to netdev@vger.kernel.org are very unlikely
> to be integrated.
>
> Thank you.

Adding netdev@vger.kernel.org to this email, sorry about missing the
recipient in the first place.

Thanks,
Crag
