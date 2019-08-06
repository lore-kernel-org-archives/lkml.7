Return-Path: <SRS0=vI2Y=WC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 43413C31E40
	for <linux-kernel@archiver.kernel.org>; Tue,  6 Aug 2019 08:08:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1725D2070C
	for <linux-kernel@archiver.kernel.org>; Tue,  6 Aug 2019 08:08:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732235AbfHFIIK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 6 Aug 2019 04:08:10 -0400
Received: from mail-ot1-f66.google.com ([209.85.210.66]:36680 "EHLO
        mail-ot1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728991AbfHFIIK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Aug 2019 04:08:10 -0400
Received: by mail-ot1-f66.google.com with SMTP id r6so90339699oti.3
        for <linux-kernel@vger.kernel.org>; Tue, 06 Aug 2019 01:08:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=v0pUxoN8ic5Jg7+9svSK19LHhymmTCOYPQ9hSacaUJA=;
        b=qe7Q3xwN3HGtpx9UnDIhDguhXMcHAFqXWQ2n5h8tjWYzxviwVlc3LFwbfXAjDT4ULy
         v7eR7GkoKyxEtTbP+1MyHrhgJzeiL13dPLupxGpZQJiPfoXBsPa7m0gLiI0gtXauV+JA
         VuUaUgWQQpI/qS+h9r80Exz3Z6do0njbu0mE9qkbML6Pzy+Xbs+8XFx9+grnBmZayB6N
         iK04ex9EfvJpqApEwnubOsdcIP/smuF03uMa0Fk01V8TQ87X4CyYMtFaOTym42o+UDo8
         MLXAMUQKN81o+MAuWN2/eG9kVFS+QCFuDLVIa9UV2mej1zlhxlUGZhyxwxIBI5EqwYCS
         2aFg==
X-Gm-Message-State: APjAAAVNjkKFxyTpJhkgXa0IF5TSKng8rcn5nETyUr9MJjNflwHuyhHv
        76MUXO/snmSQTBTGryvUZm5Rr49dc509P3GJVOs=
X-Google-Smtp-Source: APXvYqzxUg/nOeCpjOTWkG0+AuYWBObKr/vS11Eds8+B9y+eMqTtO4+We2VPHmYJxmXx5goVfuxUtG4URj9Yr5/iDTc=
X-Received: by 2002:a05:6830:210f:: with SMTP id i15mr2097796otc.250.1565078889511;
 Tue, 06 Aug 2019 01:08:09 -0700 (PDT)
MIME-Version: 1.0
References: <20190805122254.13041-1-hslester96@gmail.com>
In-Reply-To: <20190805122254.13041-1-hslester96@gmail.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Tue, 6 Aug 2019 10:07:58 +0200
Message-ID: <CAMuHMdVh=rX+MuhvqwTthcbq95bTPCz1dCFV4BixR2UA4J5+bg@mail.gmail.com>
Subject: Re: [PATCH v3 4/8] printk: Replace strncmp with str_has_prefix
To:     Chuhong Yuan <hslester96@gmail.com>
Cc:     Petr Mladek <pmladek@suse.com>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Joe Perches <joe@perches.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Chuhong,

On Mon, Aug 5, 2019 at 2:24 PM Chuhong Yuan <hslester96@gmail.com> wrote:
> strncmp(str, const, len) is error-prone because len
> is easy to have typo.
> The example is the hard-coded len has counting error
> or sizeof(const) forgets - 1.
> So we prefer using newly introduced str_has_prefix()
> to substitute such strncmp to make code better.
>
> Signed-off-by: Chuhong Yuan <hslester96@gmail.com>

Thanks for your patch!

> --- a/kernel/printk/braille.c
> +++ b/kernel/printk/braille.c
> @@ -11,11 +11,13 @@
>
>  int _braille_console_setup(char **str, char **brl_options)
>  {
> -       if (!strncmp(*str, "brl,", 4)) {
> +       size_t len;
> +
> +       if ((len = str_has_prefix(*str, "brl,"))) {

Please write this as

    len = str_has_prefix(*str, "brl,");
    if (len) {

(everywhere)

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
