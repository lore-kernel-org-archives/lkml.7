Return-Path: <SRS0=TxL2=YH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 79558C4CECE
	for <linux-kernel@archiver.kernel.org>; Mon, 14 Oct 2019 11:49:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4DF2C207FF
	for <linux-kernel@archiver.kernel.org>; Mon, 14 Oct 2019 11:49:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bE9Eovnm"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731526AbfJNLtz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 14 Oct 2019 07:49:55 -0400
Received: from mail-lj1-f195.google.com ([209.85.208.195]:36273 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730369AbfJNLty (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Oct 2019 07:49:54 -0400
Received: by mail-lj1-f195.google.com with SMTP id v24so16331184ljj.3
        for <linux-kernel@vger.kernel.org>; Mon, 14 Oct 2019 04:49:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=IyjO7e3laflS/HiaQVGN9zQLqjDYASAnzIoylBXLla0=;
        b=bE9Eovnmob/gQtTAdbam+0ozMYerl+G5fFrF//o7FpRO2ZBT6cieTe0+0LxRfUskbN
         zQSSiyzCeGzJsmoSmtB55DV2a8Vw/zurJqJK2B05u584M/QM2tfigu2PJgAo5eU0ZOoS
         xu9wN1yHMk8w1bkWDf8IpGrH8qKhfh280tJckFKgvrUwkxthULUdF2dxXk2yrOa9CW3N
         zURCh183wEZuHiiYBTYmWLxan9UtlW2HvetsLzU/c6RMKzkO+rDlQwhQ/pcexp6c5HQn
         P54ZPr8Oxg/7ldvOh9YhtzjPHoL876JYJKQO0yQ3iHiMB4fDQJVbZ6g+979JdZC9TyXQ
         4csw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=IyjO7e3laflS/HiaQVGN9zQLqjDYASAnzIoylBXLla0=;
        b=ANTmHAwP7ZSA7Wag+XPYPTnwPI/MM/HdGmXMdzjpMKu95dUfGq5nQYeNoTJeKGxyjZ
         YseBZkLWIg6PSGBpB/T39PHtvR5hIpJyokovFKi2F/qWIQ7ftVs0s/KKQhfcwsrTnCRW
         u3utREOKcYQTtl7ANff3MfSBW4DrMH8ggxC4pQSPk7yiqWkDBwkvCGIeENafLIORIqmP
         e4a9P4sDgIySSNl4JVyY9yCms8Z09Qt+NkAz0HssPZjrxycEzooY0QkZqjciV4q1MJ2x
         Xs4uCPLJn/H5+9H5+LYgWb+NvoyLu9rpQbCOpzMGuFGkOiV/xGTV3xtW+rWuz2Zinezu
         lKTg==
X-Gm-Message-State: APjAAAVuFR9FfTiEPFmCIH5qHHDpW3OVwjHbuiQMcmoFPf4D2Wfw0QWV
        mEtc0Z3U8o4xhesf2eniRWrpe6/2h7VIpunq73E=
X-Google-Smtp-Source: APXvYqxfndyKvV40Hy1LIzfbYH2bwyOljP/9Nv/iuUzhwJx0Z608hejivMWORMGhD0FZmbpcFyD9y8exCkOLIkRAtmQ=
X-Received: by 2002:a2e:9205:: with SMTP id k5mr18476480ljg.172.1571053793046;
 Mon, 14 Oct 2019 04:49:53 -0700 (PDT)
MIME-Version: 1.0
References: <20191010230414.647c29f34665ca26103879c4@gmail.com> <20191014103341.GA36860@jagdpanzerIV>
In-Reply-To: <20191014103341.GA36860@jagdpanzerIV>
From:   Vitaly Wool <vitalywool@gmail.com>
Date:   Mon, 14 Oct 2019 13:49:41 +0200
Message-ID: <CAMJBoFMO3jkdXMFvYAfqZ1_hnPufTRHGwpcFYqBBM2BD8dhwMQ@mail.gmail.com>
Subject: Re: [PATCH 0/3] Allow ZRAM to use any zpool-compatible backend
To:     Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>
Cc:     Linux-MM <linux-mm@kvack.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Dan Streetman <ddstreet@ieee.org>,
        Minchan Kim <minchan@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        Shakeel Butt <shakeelb@google.com>,
        Henry Burns <henrywolfeburns@gmail.com>,
        "Theodore Ts'o" <tytso@thunk.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Sergey,

On Mon, Oct 14, 2019 at 12:35 PM Sergey Senozhatsky
<sergey.senozhatsky.work@gmail.com> wrote:
>
> Hi,
>
> On (10/10/19 23:04), Vitaly Wool wrote:
> [..]
> > The coming patchset is a new take on the old issue: ZRAM can
> > currently be used only with zsmalloc even though this may not
> > be the optimal combination for some configurations. The previous
> > (unsuccessful) attempt dates back to 2015 [1] and is notable for
> > the heated discussions it has caused.
>
> Oh, right, I do recall it.
>
> > The patchset in [1] had basically the only goal of enabling
> > ZRAM/zbud combo which had a very narrow use case. Things have
> > changed substantially since then, and now, with z3fold used
> > widely as a zswap backend, I, as the z3fold maintainer, am
> > getting requests to re-interate on making it possible to use
> > ZRAM with any zpool-compatible backend, first of all z3fold.
>
> A quick question, what are the technical reasons to prefer
> allocator X over zsmalloc? Some data would help, I guess.

For z3fold, the data can be found here:
https://elinux.org/images/d/d3/Z3fold.pdf.

For zbud (which is also of interest), imagine a low-end platform with
a simplistic HW compressor that doesn't give really high ratio. We
still want to be able to use ZRAM (not necessarily as a swap
partition, but rather for /home and /var) but we absolutely don't need
zsmalloc's complexity. zbud is a perfect match here (provided that it
can cope with PAGE_SIZE pages, yes, but it's a small patch to make
that work) since it's unlikely that we squeeze more than 2 compressed
pages per page with that HW compressor anyway.

> > The preliminary results for this work have been delivered at
> > Linux Plumbers this year [2]. The talk at LPC, though having
> > attracted limited interest, ended in a consensus to continue
> > the work and pursue the goal of decoupling ZRAM from zsmalloc.
>
> [..]
>
> > [1] https://lkml.org/lkml/2015/9/14/356
>
> I need to re-read it, thanks for the link. IIRC, but maybe
> I'm wrong, one of the things Minchan was not happy with was
> increased maintenance cost. So, perhaps, this also should
> be discuss/addressed (and maybe even in the first place).

I have hard time seeing how maintenance cost is increased here :)

~Vitaly
