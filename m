Return-Path: <SRS0=zoc3=WI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 040AEC31E40
	for <linux-kernel@archiver.kernel.org>; Mon, 12 Aug 2019 20:31:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C179C2070C
	for <linux-kernel@archiver.kernel.org>; Mon, 12 Aug 2019 20:31:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="HRfyeWCY"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726550AbfHLUbg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 12 Aug 2019 16:31:36 -0400
Received: from mail-pl1-f194.google.com ([209.85.214.194]:33329 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726144AbfHLUbg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Aug 2019 16:31:36 -0400
Received: by mail-pl1-f194.google.com with SMTP id c14so48225502plo.0
        for <linux-kernel@vger.kernel.org>; Mon, 12 Aug 2019 13:31:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=TULEXdnebLFGQxGl0Bkqqte0RggVS3a0jpX94lToKnc=;
        b=HRfyeWCYo/AQoYDEpj80Bxf4ka2eLP1Oc8behxJisu1q6cEMUZJjpXD1kiH43rFWZE
         wRjppXQNOGAd98tXpT8OQJVlNd4jfS5sYhF2Sk0V7s4biOUsYQiGYslhhn6s2V6T6e9X
         gG6wD9IaHokL9hVNLw891F8hu51Q20/djctx6mCGyTXWMKsjsnBMn9LgLFq1uyhWmWmu
         eQHsTxJNvpTn8EK7h4izgcTarWveD3pGYP4nqVfMbwGeu21LN/MPL90slrGniDx4FK52
         iVLcVdTg6cJXCh6nMxpU/0taq9EdNdRJqEueB8otKjGhQnLHtrEW0ShMdd6zZxZQUqDN
         e7yQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=TULEXdnebLFGQxGl0Bkqqte0RggVS3a0jpX94lToKnc=;
        b=nA/M0L6jQp+XmN5KFr4gFgE1oAa+NBPPVp9b+IhpkNHqASrUyITvDCaYbi2VV1cK3w
         4LoAcuIMdRrYfbRkbVroadqGDQx6KGNcMPglHLIs/y/725xMqCOaXa/EekwegexH/9VF
         ZINMUbFDeUwXEXkz1ivmk6G0AOpgqTTC6ybcoXXaHkErQOttagvZH5tdAfZBDN7eA+y/
         hmZTig/j0eJBmXa4VmRDOHP9RP2FmF3i1ntZekBw4M1erZ1xhK9kcJO1SG+2ExMfWO07
         jSPLgKYFVJi3FoVUUmSjGTjsKugyAMCTB43vjvG66ZsQ6H4lYbDYiHIGEIH1Mj/pPmXA
         UJzA==
X-Gm-Message-State: APjAAAUFQtxmBXOxGxDF2PL/JRbyRIHhaP657s8NDdWl6tgAYy6AvCtA
        KXARcl39hxLEFbdl2ui07RYayxEGL03yjlB5tQOE+Q==
X-Google-Smtp-Source: APXvYqyUQQzkxmD77NS7xNXbZvsJ1GRU4wFcCmSHzMMlkzMG+r+Idp0wGi60HF7mI8rFuhiNdtoQQTj5lBqsZaRx9LM=
X-Received: by 2002:a17:902:3363:: with SMTP id a90mr32911658plc.119.1565641895081;
 Mon, 12 Aug 2019 13:31:35 -0700 (PDT)
MIME-Version: 1.0
References: <60cac6896503a0c47d849507cf5666add7d1c57f.camel@perches.com>
In-Reply-To: <60cac6896503a0c47d849507cf5666add7d1c57f.camel@perches.com>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Mon, 12 Aug 2019 13:31:23 -0700
Message-ID: <CAKwvOdkqTUWgCr+t6Ktf4U1Xy50FmurER6btCR8u=X93uLayhA@mail.gmail.com>
Subject: Re: [PATCH] checkpatch: Prefer __section over __attribute__((section(...)))
To:     Joe Perches <joe@perches.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 12, 2019 at 1:07 PM Joe Perches <joe@perches.com> wrote:
>
> Add another test for __attribute__((section("foo"))) uses
> that should be __section(foo)
>
> Suggested-by: Nick Desaulniers <ndesaulniers@google.com>
> Signed-off-by: Joe Perches <joe@perches.com>
> Tested-by: Nick Desaulniers <ndesaulniers@google.com> # post PEBKAC <smile>

lol please don't commit that (PEBKAC)

> ---
>  scripts/checkpatch.pl | 12 ++++++++++++
>  1 file changed, 12 insertions(+)
>
> diff --git a/scripts/checkpatch.pl b/scripts/checkpatch.pl
> index 1cdacb4fd207..d4153b81b1eb 100755
> --- a/scripts/checkpatch.pl
> +++ b/scripts/checkpatch.pl
> @@ -5901,6 +5901,18 @@ sub process {
>                              "__aligned(size) is preferred over __attribute__((aligned(size)))\n" . $herecurr);
>                 }
>
> +# Check for __attribute__ section, prefer __section
> +               if ($realfile !~ m@\binclude/uapi/@ &&
> +                   $line =~ /\b__attribute__\s*\(\s*\(.*_*section_*\s*\(\s*("[^"]*")/) {
> +                       my $old = substr($rawline, $-[1], $+[1] - $-[1]);
> +                       my $new = substr($old, 1, -1);
> +                       if (WARN("PREFER_SECTION",
> +                                "__section($new) is preferred over __attribute__((section($old)))\n" . $herecurr) &&
> +                           $fix) {
> +                               $fixed[$fixlinenr] =~ s/\b__attribute__\s*\(\s*\(\s*_*section_*\s*\(\s*\Q$old\E\s*\)\s*\)/__section($new)/;
> +                       }
> +               }
> +
>  # Check for __attribute__ format(printf, prefer __printf
>                 if ($realfile !~ m@\binclude/uapi/@ &&
>                     $line =~ /\b__attribute__\s*\(\s*\(\s*format\s*\(\s*printf/) {
>
>


-- 
Thanks,
~Nick Desaulniers
