Return-Path: <SRS0=/Haq=WD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4EE14C32751
	for <linux-kernel@archiver.kernel.org>; Wed,  7 Aug 2019 12:41:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 19F7721E6A
	for <linux-kernel@archiver.kernel.org>; Wed,  7 Aug 2019 12:41:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="qzA3Athg"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729890AbfHGMlg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 7 Aug 2019 08:41:36 -0400
Received: from mail-lj1-f195.google.com ([209.85.208.195]:44178 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727213AbfHGMlg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Aug 2019 08:41:36 -0400
Received: by mail-lj1-f195.google.com with SMTP id k18so85307400ljc.11
        for <linux-kernel@vger.kernel.org>; Wed, 07 Aug 2019 05:41:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=RLO/b475rRpz9RyUfV1VHf/BilozL3MjKM9p1Cl7sdk=;
        b=qzA3Athga7Gbe027N6GOUmETvhHSHnzhehrZqw/TiAXKjZMUn1eA4ZfaVEuTYX8nZ2
         LFh8Qb0myCULRjPKG2WEqGKb/KwBuRwmorK9JfZDbZfolYxHmzBaVB0qPrOxpAyvdlkk
         NeWkqKFAwmPOmXourJqh5hWUpW5ZBGXS6h++esPccHRF0NFpF0mMnAELWpAsKUz5Rdgz
         fSHfPVULK1dVFn/PVbw1Lx1CkPoEL2YzONu9JiXXcJa36vse6eBYVHrHaI32S6DwN2cM
         ZMHFKhe+giX/oQy2Z6lcISI123VSTCFO+VTrDsQwThwmtOJATMvCkQdWieWjVjpO+Lw3
         bOug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=RLO/b475rRpz9RyUfV1VHf/BilozL3MjKM9p1Cl7sdk=;
        b=Cp+LVQWAZkocTPvr8BAkoJ9DLYr5r/KHQsduGumy6l6G3qlxFe8uUslTPtTepTfBUZ
         U4fJXtbu5oMHz4YczHJfv0EN7lmsWthgTvddAjgkwIwL7aWSFxpM3Vq0PxlJe5nWuizF
         FREXlBrpaB7n5W/i7af1uoHSTNTxrLKhslMwty2XIV0/KZZn7gtvstHO8wCnb2ZKcMtv
         O1mPkP8rqLlAvCohA9zxiDNObp9/0Dycy9/LrXHXxyJF2iL0RlRVgKQST91A0BCkHBiB
         3fc01oXnmwA62Uw4qVrulnr+gM/PD5VcvU6EHIOogzKxu+Iq9aONUtuGyiXGTN2RMdVb
         /tLQ==
X-Gm-Message-State: APjAAAV8FTULLusHwV9/kLnW6iKHewaxAOo7nApLgHWf3tF6y95HfZNB
        wpC5SAKiUkTQRk/MAefNbMCxVFGLp/0qqPTsPZ7gZA==
X-Google-Smtp-Source: APXvYqzTtmIjIjoa6hoWwCSMOWWHdKs00GB5hdlV+2HMLSnOtbZtK0udlhDTIR3s0F1OVFax3eGxg7fIA0va2AK0cts=
X-Received: by 2002:a05:651c:28c:: with SMTP id b12mr4809273ljo.69.1565181694684;
 Wed, 07 Aug 2019 05:41:34 -0700 (PDT)
MIME-Version: 1.0
References: <20190806145716.125421-1-maz@kernel.org> <20190806145716.125421-7-maz@kernel.org>
In-Reply-To: <20190806145716.125421-7-maz@kernel.org>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Wed, 7 Aug 2019 14:41:23 +0200
Message-ID: <CACRpkdbTPetycRFCasG0CYHeiJetStcFV+qCUX2wa6c_FuBs6A@mail.gmail.com>
Subject: Re: [PATCH 6/8] gpio/ixp4xx: Register the base PA instead of its VA
 in fwnode
To:     Marc Zyngier <maz@kernel.org>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Linus Walleij <linusw@kernel.org>,
        Imre Kaloz <kaloz@openwrt.org>,
        Krzysztof Halasa <khalasa@piap.pl>,
        "K. Y. Srinivasan" <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        Sasha Levin <sashal@kernel.org>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 6, 2019 at 4:57 PM Marc Zyngier <maz@kernel.org> wrote:

> Do not expose the base VA (it appears in debugfs). Instead,
> record the PA, which at least can be used to precisely identify
> the associated irqchip and domain.
>
> Signed-off-by: Marc Zyngier <maz@kernel.org>

Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Please apply this directly to the irq subsystem tree with
the rest of the fixes.

Yours,
Linus Walleij
