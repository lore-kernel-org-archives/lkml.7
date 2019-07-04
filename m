Return-Path: <SRS0=IBEs=VB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AF403C0650E
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Jul 2019 07:05:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7A0AB2133F
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Jul 2019 07:05:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="qwDSVwsE"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727351AbfGDHFR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 4 Jul 2019 03:05:17 -0400
Received: from mail-lf1-f65.google.com ([209.85.167.65]:44230 "EHLO
        mail-lf1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726964AbfGDHFQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Jul 2019 03:05:16 -0400
Received: by mail-lf1-f65.google.com with SMTP id r15so3468486lfm.11
        for <linux-kernel@vger.kernel.org>; Thu, 04 Jul 2019 00:05:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=2/jhMVFWL9zAP6DASgDxWvKe4pRoCVY+Bzzlbxt4Sws=;
        b=qwDSVwsECgzZhe2WwlG1p8BOPlPHnzsNTaQt1KS8uYPGmdPXJqoI8dUKZa4N9BH/bQ
         O7QOMjn0trVW6NJLJAgx1IQA8mYmF2lT6hZqFMtVdWO5d7EKSxWkwVQeA51/LKFBQFeR
         JfWOVSjVV3Af/VORKOstlu0LPLSn+zx1e+VbFF6GbnJnmvY/KumjMcv+KeAbxHIJFwHg
         47dCJgb1rCk/k6pxP9MR2KHQI7uoBai+qnkxbSrfGXVxvqclUX3PzMMxApCEHCY2xU6N
         vWNlOxTyomJ9DxPxQU4YiQJgFKC/tJkybV4VdVUcFXD85U/wq+refUau9H/AEzpPCUtB
         39AA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=2/jhMVFWL9zAP6DASgDxWvKe4pRoCVY+Bzzlbxt4Sws=;
        b=njtJVYEN9Lk73Gsnlx9acsp6ZOkaibWd12ZCUtGefCdAM2yDq1enVSsV2EN6v7824v
         7JsPntH00BXSI3gD/XjnF1c/n3Q9RQ6E+Y+bdI3d6KYx308DC2IQKsq9RvXH4C+p18gL
         tqOkSvHN493vB9oI01wKZsVpSqwlDtmW4pP2VPcrd5TEChZXhAj/CIg9qZqMp2CkiqJA
         DqNPp0TSgVE1b8Pd2+tu6lXmkC62jubfRYJzgKfi4uDqnAtjgWNnQXHK0D3W8vdC+osk
         s+mGfX7BhKSHFthcm2JgKrMFEm9TxXW4kQJfVrGqSsOFWT73XXV4RzJpLZPkWQ8ZNOwd
         lwNw==
X-Gm-Message-State: APjAAAXq29xSFynPXJbM+b6HfmuS8xB/c32hVVNaQoonWScaoqeLu513
        mBG1P7+0dOq17GZqSk7hJEgwC39/uwP2y8kQU5g1Dw==
X-Google-Smtp-Source: APXvYqxQCD23eaeoAJhpEZfOc2Of9fwPsf/stmR5iwxoFFdrgqdv4D53+o/uLeap0VPJozhN950Mm7ck5RTeeImezjQ=
X-Received: by 2002:ac2:5c42:: with SMTP id s2mr4161503lfp.61.1562223914898;
 Thu, 04 Jul 2019 00:05:14 -0700 (PDT)
MIME-Version: 1.0
References: <20190703171924.31801-1-paweldembicki@gmail.com> <20190703171924.31801-2-paweldembicki@gmail.com>
In-Reply-To: <20190703171924.31801-2-paweldembicki@gmail.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Thu, 4 Jul 2019 09:05:03 +0200
Message-ID: <CACRpkdb5LonYLpbOHj=Oo8Z7XjVUWoO0CuhOokxfSoY_fRinPw@mail.gmail.com>
Subject: Re: [PATCH v2 1/4] net: dsa: Change DT bindings for Vitesse VSC73xx switches
To:     Pawel Dembicki <paweldembicki@gmail.com>
Cc:     Andrew Lunn <andrew@lunn.ch>,
        Vivien Didelot <vivien.didelot@gmail.com>,
        Florian Fainelli <f.fainelli@gmail.com>,
        "David S. Miller" <davem@davemloft.net>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        netdev <netdev@vger.kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 3, 2019 at 7:21 PM Pawel Dembicki <paweldembicki@gmail.com> wrote:

> This commit introduce how to use vsc73xx platform driver.
>
> Signed-off-by: Pawel Dembicki <paweldembicki@gmail.com>

Nice!

> +If Platform driver is used, the device tree node is an platform device so it
> +must reside inside a platform bus device tree node.

I would write something like "when connected to a memory bus, and
used in memory-mapped I/O mode, a platform device is used to represent
the vsc73xx" so it is clear what is going on.

Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij
