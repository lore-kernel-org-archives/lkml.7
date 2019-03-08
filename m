Return-Path: <SRS0=vL1f=RL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F27F9C43381
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Mar 2019 16:16:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BF39D20657
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Mar 2019 16:16:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WpWy2UR4"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726545AbfCHQQB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 Mar 2019 11:16:01 -0500
Received: from mail-oi1-f194.google.com ([209.85.167.194]:43655 "EHLO
        mail-oi1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726275AbfCHQQA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Mar 2019 11:16:00 -0500
Received: by mail-oi1-f194.google.com with SMTP id i8so16264716oib.10
        for <linux-kernel@vger.kernel.org>; Fri, 08 Mar 2019 08:16:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=p9phEvB0DMgLtUOyraVJIIi4zEnL4/7qOkhyfeNgeSY=;
        b=WpWy2UR4YYQvUr2ZO+Uey4SM87AeRmXIj+8nGLiFJaSmq/Hwa7X78YEVXm/XZgoyDn
         beWZXrn19JPJAbcMv3zY027glUzWqWIAvOU6T7WexIczEIWoc8wN7QxQiOPlXjrUru2/
         69fqjq+rxBvSwIm4v7NbmpnmnaaPc8XptUw8ofyXvrJwZCE6rkkmaOugSi4xqAyrajGq
         KPczGNA5/Kl4mtHV07H5+d/sMZixeatMib+aSQpOWbqM6dNG3jI9xd6T4OwnWL4GOm+I
         RABGhfd9SCH6N5ZJh3QKuPY1n+sIpchmVlLYVS8Pr30AyKsUTPXnvAukxzphZYdR/2/s
         JfVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=p9phEvB0DMgLtUOyraVJIIi4zEnL4/7qOkhyfeNgeSY=;
        b=nZc2WIu1+4skLVr3IO0oDTcKQVWY5z+/nX+QOJ6M7G2WsgiT0pBUSwT3q4FLets3cO
         0Oke2Y4XuNcKf8NjKDf7R1C25wwDoOgLEIYF+4xVFoq/tatm8l8NL3oyq1IiJUOvfWSw
         SjZlB6cEnw33i8VXsrN5+P1YIb/AEh6O+xG42irnQKfoP03P1vDbDJRlpDGtUBKlWHDG
         dAoO2p75zVwgbqhJQFabD4wWHCSLYCGhO6+BiI3WPf3WED1Tup0AgFRr4MsOWmEKikYD
         hyhk9RmGGgYDBPfTANIZMTPwKTU4t5PUsGg2DVUcP5BWK/oY6j6jDMAcIz7rKLmAifWh
         T8bQ==
X-Gm-Message-State: APjAAAUbBwMqusyKR0CXsmPWyFQQLwSvC403OeQ8A/oHxqnY06jbDLHb
        TwevEPUE5+HR4R4gunOrm6NpE6xlNS6/RZH5io8=
X-Google-Smtp-Source: APXvYqxcBIfqIvD8GFazh84Wi4PKHVrttaT+z+ib/F7AUWDhzgP92WT8Gf66oMf4c+phKyF4eDS7w4hOH8yS39SSCIs=
X-Received: by 2002:aca:4a95:: with SMTP id x143mr8863272oia.18.1552061759927;
 Fri, 08 Mar 2019 08:15:59 -0800 (PST)
MIME-Version: 1.0
References: <20190308160933.29899-1-daniel.baluta@nxp.com>
In-Reply-To: <20190308160933.29899-1-daniel.baluta@nxp.com>
From:   Fabio Estevam <festevam@gmail.com>
Date:   Fri, 8 Mar 2019 13:16:04 -0300
Message-ID: <CAOMZO5CLjZ7W0Z4ZHbx1YXMxjH5RzjEQPxPtP4Sd+ANF_eyG+g@mail.gmail.com>
Subject: Re: [PATCH] ASoC: fsl: sai: Reduce underrun when stream starts
To:     Daniel Baluta <daniel.baluta@nxp.com>
Cc:     "broonie@kernel.org" <broonie@kernel.org>,
        "tiwai@suse.com" <tiwai@suse.com>,
        "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "Xiubo.Lee@gmail.com" <Xiubo.Lee@gmail.com>,
        "nicoleotsuka@gmail.com" <nicoleotsuka@gmail.com>,
        dl-linux-imx <linux-imx@nxp.com>,
        "S.j. Wang" <shengjiu.wang@nxp.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Daniel,

On Fri, Mar 8, 2019 at 1:09 PM Daniel Baluta <daniel.baluta@nxp.com> wrote:
>
> From: Shengjiu Wang <shengjiu.wang@nxp.com>
>
> Write initial words into SAI FIFO to reduce the underrun
> error.

Please provide a better explanation.

Why does performing these writes help?

Also, the commit message says "reduce", so it seems this is a
workaround instead of a proper fix?
