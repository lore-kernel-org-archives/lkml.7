Return-Path: <SRS0=BTkm=YO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B5712CA9EAF
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Oct 2019 17:20:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 886792086D
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Oct 2019 17:20:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="XXi0FSGZ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729743AbfJURUY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 21 Oct 2019 13:20:24 -0400
Received: from mail-qt1-f194.google.com ([209.85.160.194]:40141 "EHLO
        mail-qt1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726819AbfJURUX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Oct 2019 13:20:23 -0400
Received: by mail-qt1-f194.google.com with SMTP id o49so14340036qta.7
        for <linux-kernel@vger.kernel.org>; Mon, 21 Oct 2019 10:20:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=i+Q0g4cWBSCHSC+Ozo2/kutzUkLzjJxIG298R3fZU7c=;
        b=XXi0FSGZgO+h0gcJPglCZdCdti7BxqJBrErIQES23s8EEgu+CNrK3sGDOUaOQN0aHn
         NL2x/JrK4qROiRGz9V04fD2pKog2nYUwqoj3iP+1WDutyIv8PKZoSc1/u5mNoK+tgQYn
         qjyHDczVIfJaUeErNMvYAYXAJzK9DiQe2CPIo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=i+Q0g4cWBSCHSC+Ozo2/kutzUkLzjJxIG298R3fZU7c=;
        b=KOPqbPhzV3ezf3QLU7aiQSb63la029RCJHbOIKTdlxlAYfB9GL5rDEX/3OukN0tez1
         gA9t3nPOsBzyVFhwrBuXMFAYRu6jQToQUWR90srPsCSKH8I8YlmG0x0zPixjpycJAxFW
         yibRBmCn9tSjVzuTWdCZwruUBMiJ3zd6XozPvFzpDWFlyEnq2bkUjVQyxg+2VeJPsKar
         ct3dEbBaUlV0GCoGGQiPWZW1LRPmYcO7suGDyr/AwqXs75GQOoIo0MZccf5Jqu2H3PUz
         WKO5VamFHONLE2lCYc/otwO++737zuU5m5bsn3wP83YPdqnFZIQ3uKOv//DOxUhEbhCB
         NQcw==
X-Gm-Message-State: APjAAAXnmNK2/aAp7FPr0EpHkiIasbJ2ip/KtNYj4qCyPCRU4JtltNvY
        Al6/jTpXz6Fw7o0EQpZeC5aL6WGEGeE=
X-Google-Smtp-Source: APXvYqzAXY8XGyolq7gM4yWTFp9BDeHthslPf3bqW3xUZucP97CyqMDnYbY47Fp5pe0pCjI7bBqFag==
X-Received: by 2002:ac8:549:: with SMTP id c9mr19989647qth.178.1571678421901;
        Mon, 21 Oct 2019 10:20:21 -0700 (PDT)
Received: from mail-qk1-f180.google.com (mail-qk1-f180.google.com. [209.85.222.180])
        by smtp.gmail.com with ESMTPSA id c18sm7598121qkk.17.2019.10.21.10.20.20
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 21 Oct 2019 10:20:20 -0700 (PDT)
Received: by mail-qk1-f180.google.com with SMTP id p10so13373071qkg.8
        for <linux-kernel@vger.kernel.org>; Mon, 21 Oct 2019 10:20:20 -0700 (PDT)
X-Received: by 2002:a37:9c0f:: with SMTP id f15mr23614988qke.62.1571678419798;
 Mon, 21 Oct 2019 10:20:19 -0700 (PDT)
MIME-Version: 1.0
References: <20180521164222.149896-1-briannorris@chromium.org> <20191021161113.GZ3125@piout.net>
In-Reply-To: <20191021161113.GZ3125@piout.net>
From:   Brian Norris <briannorris@chromium.org>
Date:   Mon, 21 Oct 2019 10:20:08 -0700
X-Gmail-Original-Message-ID: <CA+ASDXOXSKoRcuRWZ1FGNcioFKSiazXGxOvMv5=px_pn46vJbw@mail.gmail.com>
Message-ID: <CA+ASDXOXSKoRcuRWZ1FGNcioFKSiazXGxOvMv5=px_pn46vJbw@mail.gmail.com>
Subject: Re: [PATCH] rtc: report time-retrieval errors when updating alarm
To:     Alexandre Belloni <alexandre.belloni@bootlin.com>
Cc:     Alessandro Zummo <a.zummo@towertech.it>, linux-rtc@vger.kernel.org,
        Linux Kernel <linux-kernel@vger.kernel.org>,
        Jeffy Chen <jeffy.chen@rock-chips.com>,
        Matthias Kaehlcke <mka@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Alexandre!

On Mon, Oct 21, 2019 at 9:11 AM Alexandre Belloni
<alexandre.belloni@bootlin.com> wrote:
> On 21/05/2018 09:42:22-0700, Brian Norris wrote:
> > __rtc_read_time() can fail (e.g., if the RTC uses an unreliable medium).
> > When it does, we don't report the error, but instead calculate a
> > 1-second alarm based on the potentially-garbage 'tm' (in practice,
> > __rtc_read_time() zeroes out the time first, so it's likely to still be
> > all 0).
> >
> > Let's propagate the error instead.
> >
>
> I submitted
> https://lore.kernel.org/linux-rtc/20191021155631.3342-2-alexandre.belloni@bootlin.com/T/#u
> to solve this after looking at all the implication checking the return
> value of __rtc_read_time had.

Only about a year and a half late, nice! Fortunately we have a decent
(albeit time-consuming) process for rebasing our downstream patches in
Chrome OS kernels...

Brian
