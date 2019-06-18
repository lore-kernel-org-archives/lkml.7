Return-Path: <SRS0=h0iA=UR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-19.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_IN_DEF_DKIM_WL autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1B322C31E5B
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Jun 2019 19:00:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E90EB21530
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Jun 2019 19:00:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="WAeGOWzC"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730516AbfFRTAM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Jun 2019 15:00:12 -0400
Received: from mail-pl1-f195.google.com ([209.85.214.195]:33743 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730231AbfFRTAM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Jun 2019 15:00:12 -0400
Received: by mail-pl1-f195.google.com with SMTP id c14so6108564plo.0
        for <linux-kernel@vger.kernel.org>; Tue, 18 Jun 2019 12:00:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=eT7kK3k/DGGgofaFnIiFVb/h7MwsbABIk+ml7U8rfOc=;
        b=WAeGOWzC/62xUfoOrp0D84mE+4Ea8G0metTMnVChRZviACt9qPPNHjs9o73B9l8F6c
         q6gSNwFiLPrUgA6t9NsiTiBumEFKBf7i4nt7MhMIMRf32S9puHYXkIdiEjo9G5pMDTU0
         WTJO7Ezk4+qiiuAm7pMPdk4iBrwJ9gQgv95T+2qdiZxPiI2Pv6+uJD0ge3vfqLYJkM9A
         7w13l7IwtRIMisZFZKyoM9pvHuCDu/+uaOxTNoKs+/P6itZ3Gu6/HM6f7YWKR95PtfGC
         cFDJtaqEeq4GXHpw5+YweZjxLEinwiR/k+jvTsfeCb7/w50msmE+6y8h77qr9X4Dsb9f
         ltZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=eT7kK3k/DGGgofaFnIiFVb/h7MwsbABIk+ml7U8rfOc=;
        b=Hnle9/y0FH+VQu5RAwUHBRseGnxjdGAf/9TXQuJOUgi0qA/VAPkQOkp3KCBy4q/7kh
         0YnnftZ5ABAcAn160YYGES0LLJu8rHFtWO7h/X1hHWBbSsUppE+V/4SmrzNmPjEUwz8q
         lZXJKnCcCZaANDWjZh5dR+1+jsd5C4P9OJseuHXqjwOnY/+QRASom87y2nId4rPJ7x3F
         sVrLlPKtHbR1F2dDo5B0WaS2/vpzMClQJ8B15S3VVG/C3K4fHtpV3yHXHzRWou0U4akQ
         h+rHRktG34zqZFWSpJsZYMn96/Z7sWjpFAzRdze6ORcQGZEtbuHaBAAfGNjMDBPjczIo
         ztfQ==
X-Gm-Message-State: APjAAAWuWMGlzPnKnMGLUop8Q7b4uTpPxVH2A/dhh1M1TR0NKYmT+KzO
        GOgzObdNF4xmXy6Z1q5ZTMOvxVYMr925OBNx3Q2r0A==
X-Google-Smtp-Source: APXvYqxtkgfrCMyVOFWD+nhtS1s2hx+NJljuwLvz8oM33DKsEoji2grMTvg4SptxAw7eGcQq4jI4lrottWmX2QHp9Ds=
X-Received: by 2002:a17:902:b944:: with SMTP id h4mr112133301pls.179.1560884411214;
 Tue, 18 Jun 2019 12:00:11 -0700 (PDT)
MIME-Version: 1.0
References: <20190618083900.78eb88bd@bootlin.com> <20190618160910.62922-1-nhuck@google.com>
In-Reply-To: <20190618160910.62922-1-nhuck@google.com>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Tue, 18 Jun 2019 12:00:00 -0700
Message-ID: <CAKwvOdnoMv_Fkq02=F+RM8fRi0i4ycUxPe+VLdjHcDvy2DKo-A@mail.gmail.com>
Subject: Re: [PATCH] net: mvpp2: cls: Add pmap to fs dump
To:     Nathan Huckleberry <nhuck@google.com>
Cc:     "David S. Miller" <davem@davemloft.net>,
        maxime.chevallier@bootlin.com, netdev@vger.kernel.org,
        LKML <linux-kernel@vger.kernel.org>,
        clang-built-linux <clang-built-linux@googlegroups.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 18, 2019 at 9:09 AM 'Nathan Huckleberry' via Clang Built
Linux <clang-built-linux@googlegroups.com> wrote:
>
> There was an unused variable 'mvpp2_dbgfs_prs_pmap_fops'
> Added a usage consistent with other fops to dump pmap
> to userspace.
>
> Cc: clang-built-linux@googlegroups.com
> Link: https://github.com/ClangBuiltLinux/linux/issues/529
> Signed-off-by: Nathan Huckleberry <nhuck@google.com>

Looks good to me based on Maxime's suggestion.  Thanks for seeking
clarification and following up on the feedback.
Reviewed-by: Nick Desaulniers <ndesaulniers@google.com>

Nathan, you should use Suggested-by tags (liberally, IMO) when your
patch is based on feedback from others, in this case:
Suggested-by: Maxime Chevallier <maxime.chevallier@bootlin.com>

> ---
>  drivers/net/ethernet/marvell/mvpp2/mvpp2_debugfs.c | 3 +++
>  1 file changed, 3 insertions(+)
>
> diff --git a/drivers/net/ethernet/marvell/mvpp2/mvpp2_debugfs.c b/drivers/net/ethernet/marvell/mvpp2/mvpp2_debugfs.c
> index 0ee39ea47b6b..55947bc63cfd 100644
> --- a/drivers/net/ethernet/marvell/mvpp2/mvpp2_debugfs.c
> +++ b/drivers/net/ethernet/marvell/mvpp2/mvpp2_debugfs.c
> @@ -566,6 +566,9 @@ static int mvpp2_dbgfs_prs_entry_init(struct dentry *parent,
>         debugfs_create_file("hits", 0444, prs_entry_dir, entry,
>                             &mvpp2_dbgfs_prs_hits_fops);
>
> +       ddebugfs_create_file("pmap", 0444, prs_entry_dir, entry,
> +                            &mvpp2_dbgfs_prs_pmap_fops);
> +

-- 
Thanks,
~Nick Desaulniers
