Return-Path: <SRS0=yQuH=Z3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CB3BDC43603
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Dec 2019 08:44:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 970EB224F8
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Dec 2019 08:44:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="U2VSti3x"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728921AbfLEIoB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 5 Dec 2019 03:44:01 -0500
Received: from mail-wm1-f68.google.com ([209.85.128.68]:51186 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726059AbfLEIoA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Dec 2019 03:44:00 -0500
Received: by mail-wm1-f68.google.com with SMTP id p9so2688661wmg.0
        for <linux-kernel@vger.kernel.org>; Thu, 05 Dec 2019 00:43:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=lU1EvzM/eLD0n0vZaZM7AMkwMVY8sZSz0h3WsdV8t0E=;
        b=U2VSti3xVYS3TZPRfEbXKHUduQrzXSc5f+w1SuhjId7MWQwy7oOm4AD/MgMfRrvBTD
         8BVTycGLuJp8sE6OQ+FG0TCjsXTjRI964j4m5fup+dxVQ1Mlsa/+9p6kWM4HQEUnLUPB
         jDoOpTvvmLrggMmDLQIrbrpt5LlAn6GbQjyJzvu+gdCJX+gp30vQL38CMQoJbw+vSUBh
         vzqWSDfZ60M9svZzy8bab7AWE7X0RDQRXDUrvfoAx35v2NKnCNG3v2WH50/J0oJuj6Vy
         N0t0vFI5R42CNnD2QpW2oIE8fwT3iMnetrtWzEp9GEPetG4/UuqNqfJVlZQZR3k3ONod
         jj8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=lU1EvzM/eLD0n0vZaZM7AMkwMVY8sZSz0h3WsdV8t0E=;
        b=hyV8wOfOCk6mocJT0YaKtG9rLPAMRxuv4uzK8QnRNqnZxi73kOVoinuLT/mV6RgcAA
         fRZ7b37qV3n/Q9c/keES17hX388y9jdnZvXgU0JpD7ZxV8KXqMBfx63gsSpQLLDx1NlP
         IYAMjbPiogw1iOD4EJpqkoeHPB2393FH6JJ19+K78DmKAbJTfRI+JSM2RoxTZWpsfawi
         mDzcw8cPvJYWLJdUfIz2N+sLVLiM+NLxn4//FMXi1Id5OBAZZ8BAVL9iMHZ7g3R3gZyh
         Yv7i9pibCsbVEldSoSrzPfFaty0HKSqIRqie9DUD2i8bWCTz2J8FnznhXpSo/DPj2O5d
         WxoQ==
X-Gm-Message-State: APjAAAVWnyW60CqTwRedrE0ryLPgG3TrpNnp97R8olcGW0JJ4jVOcL1M
        1gMLOqWZCjnOxcqem5/TSu9ZkwYRqyUiYiLFUZI=
X-Google-Smtp-Source: APXvYqzHaKRUEfbiAOswMp49ewBcixg21LL6YP05PzNudQhdouGxpQM6W2U/QiJNtYTg+vZqQcCAgBCV7oa+geJPtRg=
X-Received: by 2002:a1c:4944:: with SMTP id w65mr3776661wma.39.1575535439089;
 Thu, 05 Dec 2019 00:43:59 -0800 (PST)
MIME-Version: 1.0
References: <20191128223802.18228-1-michael@walle.cc>
In-Reply-To: <20191128223802.18228-1-michael@walle.cc>
From:   Daniel Baluta <daniel.baluta@gmail.com>
Date:   Thu, 5 Dec 2019 10:43:46 +0200
Message-ID: <CAEnQRZCnQAUVowOJw5aPe9rYWU5DKR4bFbmQLYV2BzYqOhRJmQ@mail.gmail.com>
Subject: Re: [PATCH] ASoC: fsl_sai: add IRQF_SHARED
To:     Michael Walle <michael@walle.cc>
Cc:     Linux-ALSA <alsa-devel@alsa-project.org>,
        linuxppc-dev@lists.ozlabs.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Timur Tabi <timur@kernel.org>,
        Nicolin Chen <nicoleotsuka@gmail.com>,
        Xiubo Li <Xiubo.Lee@gmail.com>,
        Fabio Estevam <festevam@gmail.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 29, 2019 at 12:40 AM Michael Walle <michael@walle.cc> wrote:
>
> The LS1028A SoC uses the same interrupt line for adjacent SAIs. Use
> IRQF_SHARED to be able to use these SAIs simultaneously.

Hi Michael,

Thanks for the patch. We have a similar change inside our internal tree
(it is on my long TODO list to upstream :D).

We add the shared flag conditionally on a dts property.

Do you think it is a good idea to always add shared flag? I'm thinking
on SAI IP integrations where the interrupt is edge triggered.

AFAIK edge triggered interrupts do not get along very well
with sharing an interrupt line.
