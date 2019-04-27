Return-Path: <SRS0=SjSX=S5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 51A11C43218
	for <linux-kernel@archiver.kernel.org>; Sat, 27 Apr 2019 06:30:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 12F012087C
	for <linux-kernel@archiver.kernel.org>; Sat, 27 Apr 2019 06:30:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nifty.com header.i=@nifty.com header.b="A4h7Igia"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726247AbfD0GaW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 27 Apr 2019 02:30:22 -0400
Received: from conssluserg-05.nifty.com ([210.131.2.90]:64303 "EHLO
        conssluserg-05.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726030AbfD0GaW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 27 Apr 2019 02:30:22 -0400
Received: from mail-vs1-f45.google.com (mail-vs1-f45.google.com [209.85.217.45]) (authenticated)
        by conssluserg-05.nifty.com with ESMTP id x3R6U6Wo000593;
        Sat, 27 Apr 2019 15:30:07 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-05.nifty.com x3R6U6Wo000593
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1556346607;
        bh=2u3EwjWwXV67Bz4LM1eTbvzs6VRx/8lQZrbrqWRWzeQ=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=A4h7Igiam7BnsZkAcw2zeoGCJPVRLE68S1zGfFDpQteSlxy/bR02EIL8KTBcrrPP6
         yIKBMoDHl2Dmdpkkhm0CAKDuEjsAdJAqV29J6lvoD0sYvl5B4vkhjTh9Q/29yzFv7T
         CvZkjEGM6F7WRS88fTHN72vTiOPvZoX3Ukv7admE4iYPUKjkr28dAhw7TX7sfXW9kh
         TZ6rASNE+XFb+UlpPwhxcTCcGR2q3tuQdU/UUBZkL9TZjUjFJxaO2rZ/9yETkNr+RA
         blXCzQqMraBj3yQMtVEA0/VS/0G2GHngqPTCA4zx8VvTR8kLRtk/EQCFroAf8NJqZa
         5VjBKlq2jopUw==
X-Nifty-SrcIP: [209.85.217.45]
Received: by mail-vs1-f45.google.com with SMTP id s11so3221808vsn.0;
        Fri, 26 Apr 2019 23:30:07 -0700 (PDT)
X-Gm-Message-State: APjAAAUdZr6FvssrmuzTtwBcYqCS8kGhmBOBtkUv/PzwofF836N8yiNJ
        AkYV54JaefYJaFeEYx45LOq8vhxhkCIV48RD99M=
X-Google-Smtp-Source: APXvYqwoLl94mqQvUuZSCflpCqRESqyi+Miwx88C+ge5cp+NL76Q+LnNKXeeTUs9qbsvoj9tL0Z+xf85lEg2Lr2FDFk=
X-Received: by 2002:a67:ea89:: with SMTP id f9mr15571145vso.179.1556346606256;
 Fri, 26 Apr 2019 23:30:06 -0700 (PDT)
MIME-Version: 1.0
References: <20190426222237.13209-1-colin.king@canonical.com>
In-Reply-To: <20190426222237.13209-1-colin.king@canonical.com>
From:   Masahiro Yamada <yamada.masahiro@socionext.com>
Date:   Sat, 27 Apr 2019 15:29:30 +0900
X-Gmail-Original-Message-ID: <CAK7LNATC5b9yx79sF55hw1X9vZTJK8H+WsLRfy81_chZYRgTYw@mail.gmail.com>
Message-ID: <CAK7LNATC5b9yx79sF55hw1X9vZTJK8H+WsLRfy81_chZYRgTYw@mail.gmail.com>
Subject: Re: [PATCH][next] unicode: fix dereference of a potentially null pointer
To:     Olaf Weber <olaf@sgi.com>,
        Gabriel Krisman Bertazi <krisman@collabora.co.uk>,
        "Theodore Ts'o" <tytso@mit.edu>
Cc:     Michal Marek <michal.lkml@markovi.net>,
        Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>,
        Colin King <colin.king@canonical.com>,
        kernel-janitors@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Forwarding because this file is not in my tree.





On Sat, Apr 27, 2019 at 7:22 AM Colin King <colin.king@canonical.com> wrote:
>
> From: Colin Ian King <colin.king@canonical.com>
>
> The pointer 'tree' is deferenced when assigning pointer 'trie', however
> trie is being null checked a few lines later, so it could potentially
> be null. Fix the potential null pointer dereference by only dereferencing
> it after it has been null checked.
>
> Addresses-Coverity: ("Dereference before null check")
> Fixes: b08fcacaaaf4 ("unicode: introduce UTF-8 character database")
> Signed-off-by: Colin Ian King <colin.king@canonical.com>
> ---
>  scripts/mkutf8data.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/scripts/mkutf8data.c b/scripts/mkutf8data.c
> index 12ce94b43be6..0563ba679bbb 100644
> --- a/scripts/mkutf8data.c
> +++ b/scripts/mkutf8data.c
> @@ -2706,7 +2706,7 @@ static utf8leaf_t *utf8hangul(const char *str, unsigned char *hangul)
>  static utf8leaf_t *utf8nlookup(struct tree *tree, unsigned char *hangul,
>                                const char *s, size_t len)
>  {
> -       utf8trie_t      *trie = utf8data + tree->index;
> +       utf8trie_t      *trie;
>         int             offlen;
>         int             offset;
>         int             mask;
> @@ -2716,6 +2716,7 @@ static utf8leaf_t *utf8nlookup(struct tree *tree, unsigned char *hangul,
>                 return NULL;
>         if (len == 0)
>                 return NULL;
> +       trie = utf8data + tree->index;
>         node = 1;
>         while (node) {
>                 offlen = (*trie & OFFLEN) >> OFFLEN_SHIFT;
> --
> 2.20.1
>


--
Best Regards
Masahiro Yamada
