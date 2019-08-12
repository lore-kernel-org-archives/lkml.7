Return-Path: <SRS0=zoc3=WI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DA486C32750
	for <linux-kernel@archiver.kernel.org>; Mon, 12 Aug 2019 11:00:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AFC662085A
	for <linux-kernel@archiver.kernel.org>; Mon, 12 Aug 2019 11:00:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="un9eNtBw"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728170AbfHLLAP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 12 Aug 2019 07:00:15 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:36316 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727980AbfHLLAP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Aug 2019 07:00:15 -0400
Received: by mail-wr1-f65.google.com with SMTP id r3so10431479wrt.3
        for <linux-kernel@vger.kernel.org>; Mon, 12 Aug 2019 04:00:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=8QwbDdz8xqQedTgCl59sT1FB6qWBgfpvrd6AWSplSFM=;
        b=un9eNtBw+OwLU4ECOEq/jaCjwbqDOeyKlR1jeFZysKarWaE6LfHAgOtOToynNr73TD
         IZ8RZq2G/h9HmZnRr8fH+UdbzJ7j1OQuTnNMaM7uYcg75t14SgAdPY9xb+6btm5hMtD7
         cM1JOj4QSiFAo09HIW/yEprtgbD/yD2CipP/o9bOD1GAJ9px4//v9vxW3QEYa8TMGaqq
         gnZ5KsRxHaRN9gTZ6mYC2ocXexOr4l/Rb5JUtRUU9c+OkT1KiY0ros3uUgjcXImhsclZ
         qVIkzEq4vwaJXR3D53rcVvMFEhWfew+kbFWC33VcCJGkMJ2v7lyTkTXiBX7JRCc/YjbH
         Qehw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=8QwbDdz8xqQedTgCl59sT1FB6qWBgfpvrd6AWSplSFM=;
        b=gZdlVViD8qbeNoZRSedjzJ6IOQLLj1KZzY1S8LspbhICE3ykDgaVytDJDnQPIJVy52
         /n9RhqIDB6RBZfvI3IBTI/toZCrxNyouvLpq5Ga2rHh2hqZ+ykBqckyRKCYzvMf0Joe9
         Vx/pzF03dpKK4tXW1BlFGdSzdYLkfgdYFevzKRZ4uH21viqPvTJbaSEma3O0DANYaNFd
         LpbaSmo+T6A8vQzSuW/CohnWQzFFeG18agIl1dWp852uXGuCi0DDXuYXFcQFjR8wXhzO
         MFn24V4Q4hQm4hIrbA/xvD6LvXGcB7EDNDnSOTRQ7T/ixJUINxP8RNmJ2rPgQsxZBQpG
         q3SA==
X-Gm-Message-State: APjAAAUCbarybnkgAnUNmka2hfjrQ18MnqMJezZZ3fZ6l7958BPS4UnS
        G/Ax+h3pyxfByGKlH0ukpeigjw==
X-Google-Smtp-Source: APXvYqwghxYdeRuqVzPuYU2ropqG0cb6TCIVcqdi0Kn7ZW3EZH/gvO+aYyOhLrZXyhKsuMQmxwRNAw==
X-Received: by 2002:a5d:6406:: with SMTP id z6mr39714762wru.280.1565607612886;
        Mon, 12 Aug 2019 04:00:12 -0700 (PDT)
Received: from dell ([2.27.35.255])
        by smtp.gmail.com with ESMTPSA id k124sm20536169wmk.47.2019.08.12.04.00.11
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 12 Aug 2019 04:00:12 -0700 (PDT)
Date:   Mon, 12 Aug 2019 12:00:10 +0100
From:   Lee Jones <lee.jones@linaro.org>
To:     Hsin-Hsiung Wang <hsin-hsiung.wang@mediatek.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Eddie Huang <eddie.huang@mediatek.com>,
        Sean Wang <sean.wang@mediatek.com>,
        Alessandro Zummo <a.zummo@towertech.it>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Richard Fontana <rfontana@redhat.com>,
        Kate Stewart <kstewart@linuxfoundation.org>,
        Allison Randal <allison@lohutok.net>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-rtc@vger.kernel.org, srv_heupstream@mediatek.com
Subject: Re: [PATCH v4 03/10] mfd: mt6397: modify suspend/resume behavior
Message-ID: <20190812110010.GQ26727@dell>
References: <1564982518-32163-1-git-send-email-hsin-hsiung.wang@mediatek.com>
 <1564982518-32163-4-git-send-email-hsin-hsiung.wang@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1564982518-32163-4-git-send-email-hsin-hsiung.wang@mediatek.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 05 Aug 2019, Hsin-Hsiung Wang wrote:

> Some pmics don't need backup interrupt settings, so we change to use
> pm notifier for the pmics which are necessary to store settings.
> 
> Signed-off-by: Hsin-Hsiung Wang <hsin-hsiung.wang@mediatek.com>
> ---
>  drivers/mfd/mt6397-core.c       | 89 +++++++++++++++++------------------------
>  drivers/mfd/mt6397-irq.c        | 33 +++++++++++++++
>  include/linux/mfd/mt6397/core.h |  3 ++
>  3 files changed, 73 insertions(+), 52 deletions(-)

For my own reference:
  Acked-for-MFD-by: Lee Jones <lee.jones@linaro.org>

-- 
Lee Jones [李琼斯]
Linaro Services Technical Lead
Linaro.org │ Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
