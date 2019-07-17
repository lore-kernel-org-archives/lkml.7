Return-Path: <SRS0=Ncac=VO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D48E0C76192
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Jul 2019 16:49:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 920AF21743
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Jul 2019 16:49:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FZ2RaTg9"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729462AbfGQQtu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Jul 2019 12:49:50 -0400
Received: from mail-lf1-f68.google.com ([209.85.167.68]:44254 "EHLO
        mail-lf1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726620AbfGQQtu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Jul 2019 12:49:50 -0400
Received: by mail-lf1-f68.google.com with SMTP id r15so36518lfm.11
        for <linux-kernel@vger.kernel.org>; Wed, 17 Jul 2019 09:49:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=m6oZLtgSIS9rgNH1VmPitrjtzKoJqON6sdHU4IUhX60=;
        b=FZ2RaTg9GPLEkxN7+amRYx7I4vc95+CxEEqZB1xzW84uUWox7iWgJFlyhkC3Pd4B4G
         7LmgGsdr6Brgy3TzlD7Ixz5NKHUWu1YxpZfVqUCSYYU1dH7EqJNqEj5XtVqiQbpRoXpC
         JL7S+QIQ10aDPe+c7AZIJLTskPuTR/Th0MNNr3vld7oqZqPZ+8e9ugHBIE9lOZx/Mofg
         6hqKPir+0Y5BGWo8pEwc2rUDc7nJUkyN0Lct8A1FW8Ry5axwIA1htIc66TmHZlNXYP5s
         yYgUyD6u37rO3QQF3AFXizoy07YoS/KjHpDA3nMsgv9/gYOodQ+LNjSi/LlHJfygnYvk
         fieQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=m6oZLtgSIS9rgNH1VmPitrjtzKoJqON6sdHU4IUhX60=;
        b=gWorSS52kIxLQHNl9N5LO2aDqjMNPbAqDwr+BB9lBdj/MJsTHvMSlt9j1dNyzamqYt
         WTIShDjjkhdMr7A7PAI2l4OpmpIJBQnRVFmnh9XEnDw0OJ4FTp5UoNNt3oiGMCBAjkuG
         6yimkUGSr3RsqAaaHAaldF5HIHPtXFwUyUiaxObCSVVioe54F3zECLhNhQE1jiiGRiCq
         fwUzV8HHtXjJsgsLivoxQva3TE77byu4zVTNNOwB33SrV/PfPFDCQk5nyZ16NfbyujRo
         d/jKkoaEZIZzYddTtglvo/0kHDKRATOB3vsZCh4uYsyPiyxv33QgaFhTfWWi+IrpGIE1
         /FaQ==
X-Gm-Message-State: APjAAAVcir6ud88urvn7UJePPmLyBojCopb60voS8cjNDtc78Pu2lWR/
        vTNloCq2cf3YXjsHsJU8J13lOQF0sJ1vM9qbThI=
X-Google-Smtp-Source: APXvYqxJ4yTmF/pEXAKsdPEHMzOv76SGz9LRObCgiAXOj7ccVoWP20M9veb+o2mFCiCES+7mGZeyM7yluyfy94mq1f8=
X-Received: by 2002:a19:6e41:: with SMTP id q1mr7978304lfk.20.1563382187939;
 Wed, 17 Jul 2019 09:49:47 -0700 (PDT)
MIME-Version: 1.0
References: <20190717163014.429-1-oleksandr.suvorov@toradex.com> <20190717163014.429-6-oleksandr.suvorov@toradex.com>
In-Reply-To: <20190717163014.429-6-oleksandr.suvorov@toradex.com>
From:   Fabio Estevam <festevam@gmail.com>
Date:   Wed, 17 Jul 2019 13:49:37 -0300
Message-ID: <CAOMZO5B6M-YKB7gn0Gn7CJG+8YyvC_Xqu99wtHac_bQktm3T+g@mail.gmail.com>
Subject: Re: [PATCH v4 5/6] ASoC: sgtl5000: Fix of unmute outputs on probe
To:     Oleksandr Suvorov <oleksandr.suvorov@toradex.com>
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Igor Opaniuk <igor.opaniuk@toradex.com>,
        Marcel Ziswiler <marcel.ziswiler@toradex.com>,
        "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>,
        Jaroslav Kysela <perex@perex.cz>,
        Mark Brown <broonie@kernel.org>, Takashi Iwai <tiwai@suse.com>,
        Liam Girdwood <lgirdwood@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 17, 2019 at 1:30 PM Oleksandr Suvorov
<oleksandr.suvorov@toradex.com> wrote:
>
> To enable "zero cross detect" for ADC/HP, change
> HP_ZCD_EN/ADC_ZCD_EN bits only instead of writing the whole
> CHIP_ANA_CTRL register.
>
> Signed-off-by: Oleksandr Suvorov <oleksandr.suvorov@toradex.com>
> Reviewed-by: Marcel Ziswiler <marcel.ziswiler@toradex.com>
> Reviewed-by: Igor Opaniuk <igor.opaniuk@toradex.com>

Reviewed-by: Fabio Estevam <festevam@gmail.com>
