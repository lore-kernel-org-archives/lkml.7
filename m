Return-Path: <SRS0=PjNn=RI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A171AC43381
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Mar 2019 21:48:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0F77F20652
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Mar 2019 21:48:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="djKJH7fR"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727665AbfCEVsL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 5 Mar 2019 16:48:11 -0500
Received: from mail-pf1-f196.google.com ([209.85.210.196]:41580 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726762AbfCEVsL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Mar 2019 16:48:11 -0500
Received: by mail-pf1-f196.google.com with SMTP id d25so6710073pfn.8
        for <linux-kernel@vger.kernel.org>; Tue, 05 Mar 2019 13:48:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=aQsxaISu/W3opupnzBaegT3WfDuFtqbsF6km0GsJEGU=;
        b=djKJH7fREduXmgSGVzfISuJ4YdAxlSZ9B/FkKMNZVG1AXettOC+1evKpnqlFF2gBCA
         wjDp1t9xa55oJBzix2xK4APKLRX/PnRCwSgID4efqPu6DhKsgoQM6CF4Iw1JX3FHPGo1
         Hij4UmrfdCBpJCSBARplhIbofY0A45+McXkI39twfo+Ru2V1B5j+FAgydgu3Ab59IyZY
         LYKSJO8X8/Gx4ByL+TKoW+JY4wBi0syTDQYJunGuZry/kHxUNZpMwuZl1hA/aeigUwEL
         O0lU4YkwhS4KY/Y7rUzd2BMI0EIAKG9O+gaiU7yThsVjvgHpNqDxIbWevwdelSiruTTV
         noRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=aQsxaISu/W3opupnzBaegT3WfDuFtqbsF6km0GsJEGU=;
        b=NwGGbx8EbVMvhZV6NNLoaU3IGHtCYRv4O+J4HpGfo1xiBlPM9ITJDiJU/9A+cu9z/W
         vlX2YNL2z4toagWdjH2zD+zOflCV8hlRi+p7bVsSRHx8Wb+1ZnlOjeptKmWAA8Bi+DkT
         clvI9KVdwvAVt8qzs1sTmJfL7XB++cm1z6YX9LMZiFYSBvkUTDBEbhefTuesgtuewUfZ
         OdGbOHIv94BxU+KpJ0PSd21q4qskliNkWAwiGZ1vj8N2fswSu6eepm4V2fgPoA0jWf42
         91Io9AXn5jRK5PArZOn23yZ28q/TxJoP8SlkawH6FcTnqbIvAzwsKgTXBisVWa1Y7TR9
         fCLA==
X-Gm-Message-State: APjAAAUumzn2RYaM3Yt482D9gdGGi8czPC3e4OrxxBiTFNkiccseeZYe
        bCXQeUZWbTcbNuRsrNCa3MH6yajNjQCpApZPY3wHLg==
X-Google-Smtp-Source: APXvYqyN6SUybp/uOKKrzd5nr+1q0kNAXA+C/rwkYQjBk50VWrfmlP1YixE5R4GALDvwUJM5UcczhpzI3EsIolxOCbA=
X-Received: by 2002:a62:398d:: with SMTP id u13mr3909771pfj.32.1551822490098;
 Tue, 05 Mar 2019 13:48:10 -0800 (PST)
MIME-Version: 1.0
References: <20190305103014.25847-1-kieran.bingham@ideasonboard.com>
In-Reply-To: <20190305103014.25847-1-kieran.bingham@ideasonboard.com>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Tue, 5 Mar 2019 13:47:58 -0800
Message-ID: <CAKwvOdnOuXhkwizSnp6qOwJkisHKEBs=2xSvHaus3Yhdx2xE-w@mail.gmail.com>
Subject: Re: [PATCH v3] scripts/gdb: replace flags (MS_xyz -> SB_xyz)
To:     stable@vger.kernel.org, Greg KH <gregkh@linuxfoundation.org>,
        Sasha Levin <sashal@kernel.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Jan Kiszka <jan.kiszka@siemens.com>,
        Jackie Liu <liuyun01@kylinos.cn>,
        Kieran Bingham <kbingham@kernel.org>,
        Felipe Balbi <felipe.balbi@linux.intel.com>,
        Dan Robertson <danlrobertson89@gmail.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Kieran Bingham <kieran.bingham@ideasonboard.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 5, 2019 at 2:30 AM Kieran Bingham
<kieran.bingham@ideasonboard.com> wrote:
>
> From: Jackie Liu <liuyun01@kylinos.cn>
>
> Since commit 1751e8a6cb93 ("Rename superblock flags (MS_xyz -> SB_xyz)"),
> scripts/gdb should be updated to replace MS_xyz with SB_xyz.
>
> This change didn't directly affect the running operation of scripts/gdb until
> commit e262e32d6bde "vfs: Suppress MS_* flag defs within the kernel unless

Note to stable, e262e32d6bde landed in v5.0-rc1 (which was just
released), so we'll want this picked back to 5.0 stable once this
patch hits mainline (akpm just picked it up).

Just following up to say that without this, debugging a kernel a
kernel via GDB+QEMU is broken in the 5.0 release.
-- 
Thanks,
~Nick Desaulniers
