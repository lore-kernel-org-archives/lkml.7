Return-Path: <SRS0=HQPa=VE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6549AC5B578
	for <linux-kernel@archiver.kernel.org>; Sun,  7 Jul 2019 02:42:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1E59020836
	for <linux-kernel@archiver.kernel.org>; Sun,  7 Jul 2019 02:42:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nifty.com header.i=@nifty.com header.b="Wa5JxMcv"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727188AbfGGClm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 6 Jul 2019 22:41:42 -0400
Received: from conssluserg-05.nifty.com ([210.131.2.90]:53328 "EHLO
        conssluserg-05.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726974AbfGGClm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 6 Jul 2019 22:41:42 -0400
Received: from mail-vs1-f42.google.com (mail-vs1-f42.google.com [209.85.217.42]) (authenticated)
        by conssluserg-05.nifty.com with ESMTP id x672fZY9026926;
        Sun, 7 Jul 2019 11:41:35 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-05.nifty.com x672fZY9026926
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1562467296;
        bh=I0xyGzOgFAL5V9jjmDuVTuK7LMrU6TFfqca/VNGQTuo=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=Wa5JxMcvVj6AgYUBS6WiwXAFtlJVgmEH9aDbiKUz3StwWul7EQ/BuZLEDgbmIGcal
         iXwUElIgnsU0rEcL9jzB3CmRHFrzy8+mjtZZg/2tMtUysqvuIuvQIt2kgzgDr/nMDi
         DvByIaq/7/Vj+UuAVPyiZ49Rb/PIF0UskKjJeVKcKVTXXn1KpWgs/MQybXO1Qgr/hN
         CavjsbmtKMg8jBhN8PjmSPSGASyRNTHWo3GM2pFyOig0a1LIYK7Tdb+eOz7QASqoNi
         /CGM85gPgxvf78QA/vFFFvX1GSyFA2uVFt0wdAUQvQLbDFPTSgKKFo2TGpIBr5R1Kl
         8bb9i1ZD0NjaA==
X-Nifty-SrcIP: [209.85.217.42]
Received: by mail-vs1-f42.google.com with SMTP id y16so2445612vsc.3;
        Sat, 06 Jul 2019 19:41:35 -0700 (PDT)
X-Gm-Message-State: APjAAAW8MW5qpM5uITLHNsKVMhcX8Ug8uacMCvZ9OOMgqCfdsN6wUXth
        coi34IQJrKVZlC0dTfxTmFBSjCd8pqFaRT+SjQc=
X-Google-Smtp-Source: APXvYqzL8Y6te6Nr6rulPbKuMiPZfdli6ad6JHF38Tor4/MF36N8Pk1S4QUO9lsY2p3e/XxgywjfrONLkIiaQ63ZTIQ=
X-Received: by 2002:a67:fc45:: with SMTP id p5mr6352768vsq.179.1562467294595;
 Sat, 06 Jul 2019 19:41:34 -0700 (PDT)
MIME-Version: 1.0
References: <20190605053006.14332-1-yamada.masahiro@socionext.com>
In-Reply-To: <20190605053006.14332-1-yamada.masahiro@socionext.com>
From:   Masahiro Yamada <yamada.masahiro@socionext.com>
Date:   Sun, 7 Jul 2019 11:40:58 +0900
X-Gmail-Original-Message-ID: <CAK7LNAQMuZrDTX2-zynf=8gS1UqnygnMHoAfQr4wZ8uqEzd_qQ@mail.gmail.com>
Message-ID: <CAK7LNAQMuZrDTX2-zynf=8gS1UqnygnMHoAfQr4wZ8uqEzd_qQ@mail.gmail.com>
Subject: Re: [PATCH] nilfs2: do not use unexported cpu_to_le32()/le32_to_cpu()
 in uapi header
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Greg KH <gregkh@linuxfoundation.org>,
        Joe Perches <joe@perches.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Ryusuke Konishi <konishi.ryusuke@lab.ntt.co.jp>,
        linux-nilfs@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Andrew,

Could you pick up this?

The maintainer of nilfs2 is silent, but
this is obviously build error.

Masahiro Yamada


On Wed, Jun 5, 2019 at 2:32 PM Masahiro Yamada
<yamada.masahiro@socionext.com> wrote:
>
> cpu_to_le32/le32_to_cpu is defined in include/linux/byteorder/generic.h,
> which is not exported to user-space.
>
> UAPI headers must use the ones prefixed with double-underscore.
>
> Detected by compile-testing exported headers:
>
> ./usr/include/linux/nilfs2_ondisk.h: In function =E2=80=98nilfs_checkpoin=
t_set_snapshot=E2=80=99:
> ./usr/include/linux/nilfs2_ondisk.h:536:17: error: implicit declaration o=
f function =E2=80=98cpu_to_le32=E2=80=99 [-Werror=3Dimplicit-function-decla=
ration]
>   cp->cp_flags =3D cpu_to_le32(le32_to_cpu(cp->cp_flags) |  \
>                  ^
> ./usr/include/linux/nilfs2_ondisk.h:552:1: note: in expansion of macro =
=E2=80=98NILFS_CHECKPOINT_FNS=E2=80=99
>  NILFS_CHECKPOINT_FNS(SNAPSHOT, snapshot)
>  ^~~~~~~~~~~~~~~~~~~~
> ./usr/include/linux/nilfs2_ondisk.h:536:29: error: implicit declaration o=
f function =E2=80=98le32_to_cpu=E2=80=99 [-Werror=3Dimplicit-function-decla=
ration]
>   cp->cp_flags =3D cpu_to_le32(le32_to_cpu(cp->cp_flags) |  \
>                              ^
> ./usr/include/linux/nilfs2_ondisk.h:552:1: note: in expansion of macro =
=E2=80=98NILFS_CHECKPOINT_FNS=E2=80=99
>  NILFS_CHECKPOINT_FNS(SNAPSHOT, snapshot)
>  ^~~~~~~~~~~~~~~~~~~~
> ./usr/include/linux/nilfs2_ondisk.h: In function =E2=80=98nilfs_segment_u=
sage_set_clean=E2=80=99:
> ./usr/include/linux/nilfs2_ondisk.h:622:19: error: implicit declaration o=
f function =E2=80=98cpu_to_le64=E2=80=99 [-Werror=3Dimplicit-function-decla=
ration]
>   su->su_lastmod =3D cpu_to_le64(0);
>                    ^~~~~~~~~~~
>
> Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
> ---
>
>  include/uapi/linux/nilfs2_ondisk.h | 24 ++++++++++++------------
>  1 file changed, 12 insertions(+), 12 deletions(-)
>
> diff --git a/include/uapi/linux/nilfs2_ondisk.h b/include/uapi/linux/nilf=
s2_ondisk.h
> index a7e66ab11d1d..c23f91ae5fe8 100644
> --- a/include/uapi/linux/nilfs2_ondisk.h
> +++ b/include/uapi/linux/nilfs2_ondisk.h
> @@ -29,7 +29,7 @@
>
>  #include <linux/types.h>
>  #include <linux/magic.h>
> -
> +#include <asm/byteorder.h>
>
>  #define NILFS_INODE_BMAP_SIZE  7
>
> @@ -533,19 +533,19 @@ enum {
>  static inline void                                                     \
>  nilfs_checkpoint_set_##name(struct nilfs_checkpoint *cp)               \
>  {                                                                      \
> -       cp->cp_flags =3D cpu_to_le32(le32_to_cpu(cp->cp_flags) |         =
 \
> -                                  (1UL << NILFS_CHECKPOINT_##flag));   \
> +       cp->cp_flags =3D __cpu_to_le32(__le32_to_cpu(cp->cp_flags) |     =
 \
> +                                    (1UL << NILFS_CHECKPOINT_##flag)); \
>  }                                                                      \
>  static inline void                                                     \
>  nilfs_checkpoint_clear_##name(struct nilfs_checkpoint *cp)             \
>  {                                                                      \
> -       cp->cp_flags =3D cpu_to_le32(le32_to_cpu(cp->cp_flags) &         =
 \
> +       cp->cp_flags =3D __cpu_to_le32(__le32_to_cpu(cp->cp_flags) &     =
 \
>                                    ~(1UL << NILFS_CHECKPOINT_##flag));  \
>  }                                                                      \
>  static inline int                                                      \
>  nilfs_checkpoint_##name(const struct nilfs_checkpoint *cp)             \
>  {                                                                      \
> -       return !!(le32_to_cpu(cp->cp_flags) &                           \
> +       return !!(__le32_to_cpu(cp->cp_flags) &                         \
>                   (1UL << NILFS_CHECKPOINT_##flag));                    \
>  }
>
> @@ -595,20 +595,20 @@ enum {
>  static inline void                                                     \
>  nilfs_segment_usage_set_##name(struct nilfs_segment_usage *su)         \
>  {                                                                      \
> -       su->su_flags =3D cpu_to_le32(le32_to_cpu(su->su_flags) |         =
 \
> +       su->su_flags =3D __cpu_to_le32(__le32_to_cpu(su->su_flags) |     =
 \
>                                    (1UL << NILFS_SEGMENT_USAGE_##flag));\
>  }                                                                      \
>  static inline void                                                     \
>  nilfs_segment_usage_clear_##name(struct nilfs_segment_usage *su)       \
>  {                                                                      \
>         su->su_flags =3D                                                 =
 \
> -               cpu_to_le32(le32_to_cpu(su->su_flags) &                 \
> +               __cpu_to_le32(__le32_to_cpu(su->su_flags) &             \
>                             ~(1UL << NILFS_SEGMENT_USAGE_##flag));      \
>  }                                                                      \
>  static inline int                                                      \
>  nilfs_segment_usage_##name(const struct nilfs_segment_usage *su)       \
>  {                                                                      \
> -       return !!(le32_to_cpu(su->su_flags) &                           \
> +       return !!(__le32_to_cpu(su->su_flags) &                         \
>                   (1UL << NILFS_SEGMENT_USAGE_##flag));                 \
>  }
>
> @@ -619,15 +619,15 @@ NILFS_SEGMENT_USAGE_FNS(ERROR, error)
>  static inline void
>  nilfs_segment_usage_set_clean(struct nilfs_segment_usage *su)
>  {
> -       su->su_lastmod =3D cpu_to_le64(0);
> -       su->su_nblocks =3D cpu_to_le32(0);
> -       su->su_flags =3D cpu_to_le32(0);
> +       su->su_lastmod =3D __cpu_to_le64(0);
> +       su->su_nblocks =3D __cpu_to_le32(0);
> +       su->su_flags =3D __cpu_to_le32(0);
>  }
>
>  static inline int
>  nilfs_segment_usage_clean(const struct nilfs_segment_usage *su)
>  {
> -       return !le32_to_cpu(su->su_flags);
> +       return !__le32_to_cpu(su->su_flags);
>  }
>
>  /**
> --
> 2.17.1
>


--=20
Best Regards
Masahiro Yamada
