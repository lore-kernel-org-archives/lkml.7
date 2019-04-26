Return-Path: <SRS0=fl2C=S4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2B32EC43218
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Apr 2019 05:19:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DF9832077B
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Apr 2019 05:19:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dDGVnEVV"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727100AbfDZFT1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 26 Apr 2019 01:19:27 -0400
Received: from mail-ed1-f68.google.com ([209.85.208.68]:38892 "EHLO
        mail-ed1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725877AbfDZFT1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Apr 2019 01:19:27 -0400
Received: by mail-ed1-f68.google.com with SMTP id c1so2067572edk.5
        for <linux-kernel@vger.kernel.org>; Thu, 25 Apr 2019 22:19:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=EkKGDznBbBFdZirc3jAzxYvo3XCrpzWTjeLOR2RWDaI=;
        b=dDGVnEVV15F6OJ8thkEsN9JsCEo1VAtAMLxKxQGe5+5s6CDTooHBEE75QPq/Y/9J8Z
         7wUjXyWnn5i+bvagOtqwUYB3wuI7s/RjXgyF/PrOnIXFbopBGkz3ypMwtGj3gXodq77e
         ZVkO6bOP07iU02WczIvc8Ek88kSi2nFh1hx6xtXWoO4bDZZonW5SF6Xbj4UhJFajHw0B
         KesRMb/f8JIKoQpqMPvo7SKB3fb7TMCW4lKtkhOEshIHVChfQgwHejh+KS0G1DslF87L
         WZQU8wkrrQByLeVJJf7lZoDH55l8ecrDlpL4GoY1hIsbevbbkURKubdDqCw0tSv+lvIK
         4wRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=EkKGDznBbBFdZirc3jAzxYvo3XCrpzWTjeLOR2RWDaI=;
        b=roZe3VQUivZvVlngboLRdHuJkKzZzNBxWy0oornIIsGfDJ6QZzNM9uNcnVdlKguECe
         FgK99fqJojxPg7EzpzM4no+XZ/AXhYwshSPHsQ6iM4Tsg2uEiAvoW3h8Hd64f+fTSoMu
         Wd8dCYYNMFKfE0oWTs6qw5g6ILwM6JnD2xqW4QuDliqk3L1PeOZBYW7/TWqtHiut5fCm
         j7og4egvJou3/FO9tVMf1mmBEPwf49PoDnAWIFcr9jeroN1mnYjDLnI5Glw54Fx2hS0O
         3RoPizxBJXsRf4cQYl7MnPlv/48+EFpo42QlJGn0p9PR4orLGlZouuFiJRxlUSy6Mhap
         x1Zg==
X-Gm-Message-State: APjAAAWm54uWQrhFJjcfRflNUikwlIooLz5c+0El14DE+yCSpRhdihWq
        6879CijwS1VXLABoRiQrG544g3xgfJp5yBjtKIM=
X-Google-Smtp-Source: APXvYqxA5MOoF7ycT3gfeurT4M7GtKkFTTOZe8vYmvKHKfa2/cDIQLOGVZXgWfGBxaJ11AT56XVqwW3/PkaRxPYmlfs=
X-Received: by 2002:a50:a3c2:: with SMTP id t2mr26702934edb.46.1556255965508;
 Thu, 25 Apr 2019 22:19:25 -0700 (PDT)
MIME-Version: 1.0
References: <1556248850-3748-1-git-send-email-nicoleotsuka@gmail.com>
In-Reply-To: <1556248850-3748-1-git-send-email-nicoleotsuka@gmail.com>
From:   Daniel Baluta <daniel.baluta@gmail.com>
Date:   Fri, 26 Apr 2019 08:19:14 +0300
Message-ID: <CAEnQRZCV7mnBmUFiC2pVz4ndo6a0L1eF8pAuiOO5OBTayXt=SA@mail.gmail.com>
Subject: Re: [alsa-devel] [PATCH] ASoC: fsl_sai: Add missing return 0 in remove()
To:     Nicolin Chen <nicoleotsuka@gmail.com>
Cc:     Mark Brown <broonie@kernel.org>,
        Daniel Baluta <daniel.baluta@nxp.com>, sfr@canb.auug.org.au,
        Linux-ALSA <alsa-devel@alsa-project.org>,
        Timur Tabi <timur@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        linuxppc-dev@lists.ozlabs.org, Xiubo Li <Xiubo.Lee@gmail.com>,
        Takashi Iwai <tiwai@suse.com>,
        Fabio Estevam <festevam@gmail.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 26, 2019 at 6:22 AM Nicolin Chen <nicoleotsuka@gmail.com> wrote:
>
> Build warning being reported:
>     sound/soc/fsl/fsl_sai.c: In function 'fsl_sai_remove':
>     sound/soc/fsl/fsl_sai.c:921:1: warning: no return statement in
>     function returning non-void [-Wreturn-type]
>
> So this patch just adds a "return 0" to fix it.
>
> Fixes: 812ad463e089 ("ASoC: fsl_sai: Add support for runtime pm")
> Reported-by: Stephen Rothwell <sfr@canb.auug.org.au>
> Signed-off-by: Nicolin Chen <nicoleotsuka@gmail.com>

Reviewed-by: Daniel Baluta <daniel.baluta@nxp.com>

Thanks Nicolin!

> ---
>  sound/soc/fsl/fsl_sai.c | 2 ++
>  1 file changed, 2 insertions(+)
>
> diff --git a/sound/soc/fsl/fsl_sai.c b/sound/soc/fsl/fsl_sai.c
> index 26c27dc..8593269 100644
> --- a/sound/soc/fsl/fsl_sai.c
> +++ b/sound/soc/fsl/fsl_sai.c
> @@ -918,6 +918,8 @@ static int fsl_sai_probe(struct platform_device *pdev)
>  static int fsl_sai_remove(struct platform_device *pdev)
>  {
>         pm_runtime_disable(&pdev->dev);
> +
> +       return 0;
>  }
>
>  static const struct of_device_id fsl_sai_ids[] = {
> --
> 2.7.4
>
> _______________________________________________
> Alsa-devel mailing list
> Alsa-devel@alsa-project.org
> https://mailman.alsa-project.org/mailman/listinfo/alsa-devel
