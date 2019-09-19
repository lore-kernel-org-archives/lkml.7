Return-Path: <SRS0=X8En=XO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 14D83C3A5A6
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Sep 2019 09:58:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A51CC207FC
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Sep 2019 09:58:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="TkzK1Zap"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389039AbfISJ66 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 19 Sep 2019 05:58:58 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:54084 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388956AbfISJ65 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Sep 2019 05:58:57 -0400
Received: by mail-wm1-f68.google.com with SMTP id i16so3680532wmd.3
        for <linux-kernel@vger.kernel.org>; Thu, 19 Sep 2019 02:58:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=bPSaATQZ9B9id9IxoV0ABTnYae6x+cIN84+Yw8w1wdM=;
        b=TkzK1ZapJYwNzuPciw07rOAc0VMRvHyA7gfNpi6tourX9IjveBaCyYy5WD/JCioXBS
         E5E98AzSGjHoQorIKjK4KZXdNDdIc8ca6puJynHoxHKDA7ARuxa4pGEkN4aTKcfghzW4
         N7UrjPbEvgZlcllzhV4KSRsTlKWn7vmobH+2NLWPjqKmkSvthtO/wJNq/TFEm27Q8eVu
         Pf7xOuf9O3STWy8N98CBiygWlVOeNoIepPM6bPKwOeZVoEmt+UQeGdKU/in+B9jgMPWJ
         G3PuN4YPUdEe3Y/TByvpgbpF12fXBa7Ec81342/9YdAoIE3m5zrfUIdTGJ799S1uMKtr
         Am+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=bPSaATQZ9B9id9IxoV0ABTnYae6x+cIN84+Yw8w1wdM=;
        b=gbEvyetrea35NwyirNzkqdOIZEXz0VnTEJskN/5A137wjNL+MBQJdzIISKnOu4PtHV
         ad1vLcZ7VG3JWMrQhfGLGLFn/6LAUbvXYX6QShBJZlTKTStGLIpE6Ez3ZUpSa+AC6dlp
         VWgdp57XyIV1C79RKx+VGFFtBLbvwgx1XvrwYDC81fFoTA3SyoBk+eNZ2OMe3R6NnDc9
         RltnWXMKtXAAGj0g9RVfMsUx3RkjJjS+EiGRQ+SHIZtFtPuzzOUGzYbkKJmmUS4ur3SS
         3rcBdpAihNLfPl1851+0nyKtu2Y3n8fGDbbBn/NTWDTiD4aUXcdt7BDuWHBBVDbR4WLr
         wQXA==
X-Gm-Message-State: APjAAAV2b8xocLG0bRKIrzKyPN17i6ryRoraeSoW2fRLjcnKAD/3T8ZS
        sqA/jpc7pMHNCe92VB3tkHJBboRptOZXWS+kVm3H6w==
X-Google-Smtp-Source: APXvYqzpxFpqchmOADWd2ksUM9GQP3aipqqDW9ze0bYZ+/2bSXbm6Kx28kFlyNPtom2dEJ0lV/Y0b9bMJOemdvBEkiY=
X-Received: by 2002:a7b:cf37:: with SMTP id m23mr2102535wmg.53.1568887133866;
 Thu, 19 Sep 2019 02:58:53 -0700 (PDT)
MIME-Version: 1.0
References: <git-mailbomb-linux-master-724ecd3c0eb7040d423b22332a60d097e2666820@kernel.org>
 <CAMuHMdW-n73yuP3V6CCmc8igHcP25KsgZj9eMBCJRowXV5AWVg@mail.gmail.com>
In-Reply-To: <CAMuHMdW-n73yuP3V6CCmc8igHcP25KsgZj9eMBCJRowXV5AWVg@mail.gmail.com>
From:   Ard Biesheuvel <ard.biesheuvel@linaro.org>
Date:   Thu, 19 Sep 2019 12:58:26 +0300
Message-ID: <CAKv+Gu_DFnuRAg7uo8JR2SX2YH-YAW2EnkSn=c9rxCV5pXFkbw@mail.gmail.com>
Subject: Re: crypto: aes - rename local routines to prevent future clashes
To:     Geert Uytterhoeven <geert@linux-m68k.org>
Cc:     Linux Crypto Mailing List <linux-crypto@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 19 Sep 2019 at 12:43, Geert Uytterhoeven <geert@linux-m68k.org> wrote:
>
> Hi Ard,
>

Hello Geert,

> On Wed, Sep 18, 2019 at 9:59 PM Linux Kernel Mailing List
> <linux-kernel@vger.kernel.org> wrote:
> > Commit:     724ecd3c0eb7040d423b22332a60d097e2666820
> > Parent:     20bb4ef038a97b8bb5c07d2a1125019a93f618b3
> > Refname:    refs/heads/master
> > Web:        https://git.kernel.org/torvalds/c/724ecd3c0eb7040d423b22332a60d097e2666820
> > Author:     Ard Biesheuvel <ard.biesheuvel@linaro.org>
> > AuthorDate: Tue Jul 2 21:41:20 2019 +0200
> > Committer:  Herbert Xu <herbert@gondor.apana.org.au>
> > CommitDate: Fri Jul 26 14:52:03 2019 +1000
> >
> >     crypto: aes - rename local routines to prevent future clashes
> >
> >     Rename some local AES encrypt/decrypt routines so they don't clash with
> >     the names we are about to introduce for the routines exposed by the
> >     generic AES library.
> >
> >     Signed-off-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
> >     Signed-off-by: Herbert Xu <herbert@gondor.apana.org.au>
>
> > --- a/crypto/aes_generic.c
> > +++ b/crypto/aes_generic.c
> > @@ -1332,7 +1332,7 @@ EXPORT_SYMBOL_GPL(crypto_aes_set_key);
> >         f_rl(bo, bi, 3, k);     \
> >  } while (0)
> >
> > -static void aes_encrypt(struct crypto_tfm *tfm, u8 *out, const u8 *in)
> > +static void crypto_aes_encrypt(struct crypto_tfm *tfm, u8 *out, const u8 *in)
> >  {
> >         const struct crypto_aes_ctx *ctx = crypto_tfm_ctx(tfm);
>
> Looking ay the bloat-o-meter output:
>
> crypto_aes_encrypt                             -    3158   +3158
> crypto_aes_decrypt                             -    3154   +3154
> aes_decrypt                                 3154    1276   -1878
> aes_encrypt                                 3158    1270   -1888
>
> Can't this just call aes_encrypt() now?
> CONFIG_CRYPTO_AES already selects CRYPTO_LIB_AES?
> Or does the latter has less features (it's smaller, too)?
>

The latter is smaller but slower, especially for decryption. I am not
sure whether the output accounts for this, but the actual space saving
is in the lookup tables, not in the code itself (16k vs 512 bytes)

Also, we removed the x86 ASM implementations of scalar AES, since the
compiler actually produces faster code, but this also uses the
'bloated' version above.

To make matters more interesting, the fact that the tables are much
smaller means that the new code is assumed to be much less susceptible
to known timing-related vulnerabilities in table based AES.

So to summarize, platforms that don't have special instructions or
SIMD based AES implementations will need the original aes-generic
driver, or we will cause significant performance regression,
especially when decrypting. The library interface is more intended as
a) a base layer for other AES implementations, and b) a reasonable
option for non-performance critical code.



> >         u32 b0[4], b1[4];
> > @@ -1402,7 +1402,7 @@ static void aes_encrypt(struct crypto_tfm *tfm, u8 *out, const u8 *in)
> >         i_rl(bo, bi, 3, k);     \
> >  } while (0)
> >
> > -static void aes_decrypt(struct crypto_tfm *tfm, u8 *out, const u8 *in)
> > +static void crypto_aes_decrypt(struct crypto_tfm *tfm, u8 *out, const u8 *in)
> >  {
> >         const struct crypto_aes_ctx *ctx = crypto_tfm_ctx(tfm);
>
> aes_decrypt()?
>
> >         u32 b0[4], b1[4];
>
> Gr{oetje,eeting}s,
>
>                         Geert
>
> --
> Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org
>
> In personal conversations with technical people, I call myself a hacker. But
> when I'm talking to journalists I just say "programmer" or something like that.
>                                 -- Linus Torvalds
