Return-Path: <SRS0=FHjv=VA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 92D2EC0650E
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Jul 2019 15:21:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 675872189E
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Jul 2019 15:21:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QycFk9qE"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726986AbfGCPVh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 3 Jul 2019 11:21:37 -0400
Received: from mail-oi1-f196.google.com ([209.85.167.196]:34572 "EHLO
        mail-oi1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725847AbfGCPVg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Jul 2019 11:21:36 -0400
Received: by mail-oi1-f196.google.com with SMTP id l12so2418335oil.1
        for <linux-kernel@vger.kernel.org>; Wed, 03 Jul 2019 08:21:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=JesoS1mGInzbAYCEZ1ZFW+Rbhz8GECHGcwK/QDkb7n0=;
        b=QycFk9qEiszh6we8thUlzD6zFB8gI520mJUHuWfYDStkL+HHILFwF4PslL5KGv/tsT
         4ewlbeh2Us4mBWyJtIemdCLicH0jeVkpTFHjby+9eUQHYRPSPbYLDS6RicbekMz7TOsX
         Zbed+XA+ai3uF6vWEQtIwgIfusyhUPC1KHZ4avQp0+P5BwzUIrUt/kj5ifGQP1ERoOka
         M2rfmKEwlkfCdcQ8+7DpVaplFcPMCg4aBiC0gEd2LxkH1tan3nhIZUuPSZ3tZE9iw4lx
         t3URjW0RYdhqn/9XQHj5UI0EgTfVJfBHRZrOroutA2w0Asp6q/D16MlKZI4SHyVzR7la
         l0pg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=JesoS1mGInzbAYCEZ1ZFW+Rbhz8GECHGcwK/QDkb7n0=;
        b=SHtgGWL1TOA93ByyCZRzEm81Sh7CITzaTpL3R5RR027wGuhaVyNHx/DHzmxCGHvS6a
         UfgC6zDIyaBj1FQDEG2Dj9li1OOpNqn1og600iakSOhzXNGvY+XModNrdVnsvewggo1L
         h4o5qCdBV5jvPYS623yYM2AtQWkMAhxPS4cyQlO8L3kmq+txDjrmudfQcvUYLpHU7d50
         5SDBeE+H1vIKHTfwgR/Vys9hBUyUM2knbYAJa8JGSMffDACnSRYeLV6qyzmrT66ODKaK
         MpVMf5kuo8yckGLHYXm+4SdhgKDlUloTLUvd5IC/pFrCF3Jgfg+jo5RpiU8meeKy0WqN
         0ohA==
X-Gm-Message-State: APjAAAUjgcYwweV6NzxxOZ2VKs8+4qkmEib1Ls94xKeUfAeVtAmVLl8R
        QCqi9VFUPbe1XSOYQH2ON8LMrkej1ecaxWLYeqw=
X-Google-Smtp-Source: APXvYqzCxGJUM0HjXJfhRX2azHu+Zalhg69iyddxVBGuG7K18stSBpK/s2YaDYtwVJ+kySTqO2a7Pkh94StiDTiXDa0=
X-Received: by 2002:aca:5241:: with SMTP id g62mr7061129oib.41.1562167296244;
 Wed, 03 Jul 2019 08:21:36 -0700 (PDT)
MIME-Version: 1.0
References: <20190703131414.24947-1-huangfq.daxian@gmail.com>
In-Reply-To: <20190703131414.24947-1-huangfq.daxian@gmail.com>
From:   Emil Velikov <emil.l.velikov@gmail.com>
Date:   Wed, 3 Jul 2019 16:21:45 +0100
Message-ID: <CACvgo52wa8FzddSB09WoBCfR=Jdb-AD1G3_siB7c2nWWtmdpGg@mail.gmail.com>
Subject: Re: [PATCH 06/30] drm/amdgpu: Use kmemdup rather than duplicating its implementation
To:     Fuqian Huang <huangfq.daxian@gmail.com>
Cc:     David Zhou <David1.Zhou@amd.com>, David Airlie <airlied@linux.ie>,
        "Linux-Kernel@Vger. Kernel. Org" <linux-kernel@vger.kernel.org>,
        amd-gfx mailing list <amd-gfx@lists.freedesktop.org>,
        Leo Li <sunpeng.li@amd.com>,
        ML dri-devel <dri-devel@lists.freedesktop.org>,
        Daniel Vetter <daniel@ffwll.ch>,
        Alex Deucher <alexander.deucher@amd.com>,
        Harry Wentland <harry.wentland@amd.com>,
        =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 3 Jul 2019 at 14:15, Fuqian Huang <huangfq.daxian@gmail.com> wrote:
>
> kmemdup is introduced to duplicate a region of memory in a neat way.
> Rather than kmalloc/kzalloc + memset, which the programmer needs to
> write the size twice (sometimes lead to mistakes), kmemdup improves
> readability, leads to smaller code and also reduce the chances of mistakes.
> Suggestion to use kmemdup rather than using kmalloc/kzalloc + memset.
>
> Signed-off-by: Fuqian Huang <huangfq.daxian@gmail.com>
Fuqian please add reviewed-by and other tags when sending new revisions.

Fwiw the patch is:
Reviewed-by: Emil Velikov <emil.velikov@collabora.com>

-Emil
