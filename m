Return-Path: <SRS0=IBEs=VB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B79A6C0651F
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Jul 2019 14:12:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8C9FF218A0
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Jul 2019 14:12:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="j0F+4oXt"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727414AbfGDOMl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 4 Jul 2019 10:12:41 -0400
Received: from mail-vs1-f49.google.com ([209.85.217.49]:46014 "EHLO
        mail-vs1-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726875AbfGDOMk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Jul 2019 10:12:40 -0400
Received: by mail-vs1-f49.google.com with SMTP id h28so2032700vsl.12
        for <linux-kernel@vger.kernel.org>; Thu, 04 Jul 2019 07:12:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Zhr4cixuRTBTN966zcZ68eRUDO7WFunkHmiv567a75g=;
        b=j0F+4oXtCh5A/o1Dj8gJj53mDHaVaomzRArVsODj7s/CHA+uLK9BvcGF8ts15y8Vys
         CwaAT+a4QCsukfPUDxbAjIDOiltSkMglVhN4xE3VJs6GpdhtHdP5UhgHBSg65fCFyAFY
         EhV8rJeuG38LU8+dQmSGbmOVFDE4nyhrN/uHd5la2w4PxGtUP0FZnJ+HQBKe1Y1Hktsa
         MgOpmHsqhr/b3MN6jlFxQN9HHjB+zC+sO8ClCTMKw4qgYfZuE8Sz53w8jbqMb+nchXPE
         UY4DSO5UQ00R8T9ifoFKyD/lM7jX7u6IOna3TBkhbkUh6HgN6LTJdskRGz49tqi35sCP
         e3mA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Zhr4cixuRTBTN966zcZ68eRUDO7WFunkHmiv567a75g=;
        b=pUJkBN5fG/wOqPkP/dsN5Ccx83tRIFuzuFfgAP1LPxBr8rDkqyQ6qA4YzItZqFYbEU
         SpSV1VqJmIUeGz0dv/MLmnKtSm7IRPuSk/SoDJ9ezrvPuxvCPw0+MYOzV62oHeTTeVrP
         IccM7DoE0N4Eu+EYFpuesgI2wujSzyHPvIM5W8dP/GRscuPKg1MjgDtXtYJsldaqHKxO
         6Vdd2A68En5F5Sny2K0oJp+CtuJ6iFGyRn/C9i62yTFC29eL7n9u+6ufV13pndgE6eQH
         i1SJqNKFTESM1aYZEOBkhoupGPUiVW8qoNoRqisgjzPpMJAww1pwNdXW1dw/BTcBf1cA
         VJfQ==
X-Gm-Message-State: APjAAAW8LE1CmrxYqvX3fUW34hlby6VJAf59nbSj34pq3ccXIiaP8fKz
        ucNCarURxXV/O+DOBvNfbvFOeU/FNz+/hXIUUnc=
X-Google-Smtp-Source: APXvYqwysHqcSk6OBWA5nrnPWDe+dTzxKAb2FkKdc/UsIm58e3Iy55DpkUHTDKOCW1UXoMZv0n2rh9SVA9GHaV6Q0yM=
X-Received: by 2002:a67:7fd8:: with SMTP id a207mr21727445vsd.85.1562249559886;
 Thu, 04 Jul 2019 07:12:39 -0700 (PDT)
MIME-Version: 1.0
References: <20190704023557.4551-1-huangfq.daxian@gmail.com>
In-Reply-To: <20190704023557.4551-1-huangfq.daxian@gmail.com>
From:   Emil Velikov <emil.l.velikov@gmail.com>
Date:   Thu, 4 Jul 2019 15:12:47 +0100
Message-ID: <CACvgo52zd4iMR1v3AbNh8XP3jmFOueOoFvqr9ZWTX4pe_Ev5AQ@mail.gmail.com>
Subject: Re: [Patch v2 03/10] drm/omapdrm: using dev_get_drvdata directly
To:     Fuqian Huang <huangfq.daxian@gmail.com>
Cc:     David Airlie <airlied@linux.ie>,
        "Linux-Kernel@Vger. Kernel. Org" <linux-kernel@vger.kernel.org>,
        ML dri-devel <dri-devel@lists.freedesktop.org>,
        Tomi Valkeinen <tomi.valkeinen@ti.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 4 Jul 2019 at 08:26, Fuqian Huang <huangfq.daxian@gmail.com> wrote:
>
> Several drivers cast a struct device pointer to a struct
> platform_device pointer only to then call platform_get_drvdata().
> To improve readability, these constructs can be simplified
> by using dev_get_drvdata() directly.
>
> Signed-off-by: Fuqian Huang <huangfq.daxian@gmail.com>
This patch is:
Reviewed-by: Emil Velikov <emil.velikov@collabora.com>

-Emil
