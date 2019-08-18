Return-Path: <SRS0=w4Fx=WO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C3B17C3A589
	for <linux-kernel@archiver.kernel.org>; Sun, 18 Aug 2019 22:20:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 911082186A
	for <linux-kernel@archiver.kernel.org>; Sun, 18 Aug 2019 22:20:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="WQo7LW0w"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726307AbfHRWUP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 18 Aug 2019 18:20:15 -0400
Received: from mail-lf1-f67.google.com ([209.85.167.67]:33802 "EHLO
        mail-lf1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726083AbfHRWUP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 18 Aug 2019 18:20:15 -0400
Received: by mail-lf1-f67.google.com with SMTP id b29so7550711lfq.1
        for <linux-kernel@vger.kernel.org>; Sun, 18 Aug 2019 15:20:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=oDJV2qKgc2rE1ZecO56MT3ujkmelBSa9vGB/ZXufqTw=;
        b=WQo7LW0wZCePzyiGp719cN5hGt2IqiOZor8+bvWmUAuHbV9PGpTkPF2bK8mSoOXKsk
         cXos23XIkSNlw0j+eYIVrAy4wm2b3mzq63weuFYrOh9fayfx7WXFe8iSR6qpRdjO706B
         rZ+5VK/R0mvml612IDYouJwZmejn8+fTgFXdMcvHDx9HRgqz5GEK4f9LALcvvM6rUbci
         M4mKmHbo8CAYGNbRwBoRtp9vQBSecxXLMFdsHbhuwir5Dk/WpwGKyZBA0s/Rdsr5+nHk
         jlS3RDdEtsGYcj1oAF3qTYjb6o7I26Q1FPM0SBih/XnZdml1vUXnn5vOE0lsOwhb0Ff8
         6Chw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=oDJV2qKgc2rE1ZecO56MT3ujkmelBSa9vGB/ZXufqTw=;
        b=B2IGRy4O9flLp+PZKbFgCEWNBUPByN2FbIAVGUURSp1RuuVGJmBklLg8tkiiPyTuU3
         QTKsYCoKGQq5+UAWL+Ro0HtvM4QlMgHYFXsebkdEnSr0RG2TEgpno8i6NC/173/4bbIF
         Es/986oEm0aoGJAQcXPz7+OHNMgWYFJrNxqmQe5W2iVeki5hnZR3avNwbAhm7RVjoZjc
         jbhvhgiO9rCEOUt93zgLKuOOl/9udCg0TAfW+lKMZ8JqArD8mN8XLStkYqZ9x30l3ZL9
         FnNgVX+GN4jAf30v/Wcls7PUXexmGvnGTGtXM2hQtHN9r+YhqLfO5MYR9EQeBMTGPYSb
         T5og==
X-Gm-Message-State: APjAAAVn/InDjVmlou10UCXx23eY77BLrzVj50y7jMzG3aFdKbVeMKBu
        c0CJCs9HpRCqMWEUb+jGUpeE8J0w9nzeTDe3uLeQaw==
X-Google-Smtp-Source: APXvYqy5zNUWEXYZ2BNwjMv+MHdjmq2+twXb9Dmljui/KTewQHGrsVYvarl4oFwHNOai9V/3ApArVT6G7+uz+EzX27Y=
X-Received: by 2002:ac2:5939:: with SMTP id v25mr10723641lfi.115.1566166813184;
 Sun, 18 Aug 2019 15:20:13 -0700 (PDT)
MIME-Version: 1.0
References: <1565984527-5272-1-git-send-email-skomatineni@nvidia.com> <1565984527-5272-2-git-send-email-skomatineni@nvidia.com>
In-Reply-To: <1565984527-5272-2-git-send-email-skomatineni@nvidia.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Mon, 19 Aug 2019 00:20:01 +0200
Message-ID: <CACRpkdbTYON9nhrP1ritBNcm49u7-c190wL5zeufvUoGQt1jOw@mail.gmail.com>
Subject: Re: [PATCH v9 01/22] pinctrl: tegra: Fix write barrier placement in pmx_writel
To:     Sowjanya Komatineni <skomatineni@nvidia.com>
Cc:     "thierry.reding@gmail.com" <thierry.reding@gmail.com>,
        Jon Hunter <jonathanh@nvidia.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Jason Cooper <jason@lakedaemon.net>,
        Marc Zyngier <marc.zyngier@arm.com>,
        Stefan Agner <stefan@agner.ch>,
        Mark Rutland <mark.rutland@arm.com>,
        Peter De Schrijver <pdeschrijver@nvidia.com>,
        Prashant Gaikwad <pgaikwad@nvidia.com>,
        Stephen Boyd <sboyd@kernel.org>,
        linux-clk <linux-clk@vger.kernel.org>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        jckuo@nvidia.com, Joseph Lo <josephl@nvidia.com>, talho@nvidia.com,
        linux-tegra@vger.kernel.org,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Mikko Perttunen <mperttunen@nvidia.com>, spatra@nvidia.com,
        Rob Herring <robh+dt@kernel.org>,
        Dmitry Osipenko <digetx@gmail.com>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        viresh kumar <viresh.kumar@linaro.org>,
        Linux PM list <linux-pm@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 16, 2019 at 9:42 PM Sowjanya Komatineni
<skomatineni@nvidia.com> wrote:
>
> pmx_writel uses writel which inserts write barrier before the
> register write.
>
> This patch has fix to replace writel with writel_relaxed followed
> by a readback and memory barrier to ensure write operation is
> completed for successful pinctrl change.
>
> Acked-by: Thierry Reding <treding@nvidia.com>
> Reviewed-by: Dmitry Osipenko <digetx@gmail.com>
> Signed-off-by: Sowjanya Komatineni <skomatineni@nvidia.com>

Took out the previous patches and applied this instead.

Yours,
Linus Walleij
