Return-Path: <SRS0=RWM+=ZG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9FA0EC432C3
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Nov 2019 17:45:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6507D206DC
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Nov 2019 17:45:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nifty.com header.i=@nifty.com header.b="ESvySBPf"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726852AbfKNRpz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Nov 2019 12:45:55 -0500
Received: from conssluserg-05.nifty.com ([210.131.2.90]:33649 "EHLO
        conssluserg-05.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726443AbfKNRpz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Nov 2019 12:45:55 -0500
Received: from mail-ua1-f46.google.com (mail-ua1-f46.google.com [209.85.222.46]) (authenticated)
        by conssluserg-05.nifty.com with ESMTP id xAEHjeI1025064;
        Fri, 15 Nov 2019 02:45:40 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-05.nifty.com xAEHjeI1025064
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1573753541;
        bh=BcA9yFsMlJst8ZzmTrIRKKCI279WdiORVkP8tMP3V6o=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=ESvySBPfR6cYtXxIYJZgL9uqvX/ZsiPk08ydHM1nywiRoM0BezB08/Ijq+smlfbzn
         gtl9NMA7v6e6XK0CxuZe3fbKyDgCOJmo9Slv5p9fa0xyyE6Cf7y5Vx+8cv4e0SST8b
         8x5xSeygLug4wH/gx1tmVqenFMDmfj5/2EtsKCcs6VYWEOzzr8VwJ2lD29y/69ayUb
         x8fYqv7D4N8vcq6LX2YOWWniTuRC5zJn1teGWibT6gjyps7SdUJ1eHRaG4P8IReklT
         Ao7BpXpel4rrIJwxCyTJcA224yXJCSHo4QSJx7/PWqt6sPgC4XGF9mGDhw7bapogZi
         qzBTHU9XLmEng==
X-Nifty-SrcIP: [209.85.222.46]
Received: by mail-ua1-f46.google.com with SMTP id o9so2143769uat.8;
        Thu, 14 Nov 2019 09:45:40 -0800 (PST)
X-Gm-Message-State: APjAAAVNPl/2VLXcaElEMqnF4Ay/dmcKB2Bloxb5K5BkWyCybVSel/03
        IbhnqV4XC4owEfwlHzIGhhP8xPpxAtW08gl1aAM=
X-Google-Smtp-Source: APXvYqz8qtbhXy/nBCYLntGkHkL+w04hSKO8KAfP1ir3qs/vxIyl2qy+kjSDCLPa14saT0vxv+DdmTv/qq/iq9ULPYI=
X-Received: by 2002:a9f:3015:: with SMTP id h21mr6570412uab.95.1573753539427;
 Thu, 14 Nov 2019 09:45:39 -0800 (PST)
MIME-Version: 1.0
References: <20191114174226.7201-1-yamada.masahiro@socionext.com>
In-Reply-To: <20191114174226.7201-1-yamada.masahiro@socionext.com>
From:   Masahiro Yamada <yamada.masahiro@socionext.com>
Date:   Fri, 15 Nov 2019 02:45:03 +0900
X-Gmail-Original-Message-ID: <CAK7LNASYU4K87fR-v5xmhWGww_+3xRZ7otBGooXyshjXqfrv=w@mail.gmail.com>
Message-ID: <CAK7LNASYU4K87fR-v5xmhWGww_+3xRZ7otBGooXyshjXqfrv=w@mail.gmail.com>
Subject: Re: [PATCH 1/6] modpost: add a helper to get data pointed by a symbol
To:     Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>
Cc:     Michal Marek <michal.lkml@markovi.net>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Matthias Maennich <maennich@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

(+CC: Matthias, who might be interested)

On Fri, Nov 15, 2019 at 2:42 AM Masahiro Yamada
<yamada.masahiro@socionext.com> wrote:
>
> When CONFIG_MODULE_REL_CRCS is enabled, the value of __crc_* is not
> an absolute value, but the address to the CRC data embedded in the
> .rodata section.
>
> Getting the data pointed by the symbol value is somewhat complex.
> Split it out into a new helper, sym_get_data().
>
> I will reuse it to refactor namespace_from_kstrtabns() in the next
> commit.
>
> Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
> ---
>
>  scripts/mod/modpost.c | 17 +++++++++++++----
>  1 file changed, 13 insertions(+), 4 deletions(-)
>
> diff --git a/scripts/mod/modpost.c b/scripts/mod/modpost.c
> index 46d7f695fe7f..cd885573daaf 100644
> --- a/scripts/mod/modpost.c
> +++ b/scripts/mod/modpost.c
> @@ -308,6 +308,18 @@ static const char *sec_name(struct elf_info *elf, int secindex)
>         return sech_name(elf, &elf->sechdrs[secindex]);
>  }
>
> +static void *sym_get_data(const struct elf_info *info, const Elf_Sym *sym)
> +{
> +       Elf_Shdr *sechdr = &info->sechdrs[sym->st_shndx];
> +       unsigned long offset;
> +
> +       offset = sym->st_value;
> +       if (info->hdr->e_type != ET_REL)
> +               offset -= sechdr->sh_addr;
> +
> +       return (void *)info->hdr + sechdr->sh_offset + offset;
> +}
> +
>  #define strstarts(str, prefix) (strncmp(str, prefix, strlen(prefix)) == 0)
>
>  static enum export export_from_secname(struct elf_info *elf, unsigned int sec)
> @@ -697,10 +709,7 @@ static void handle_modversions(struct module *mod, struct elf_info *info,
>                         unsigned int *crcp;
>
>                         /* symbol points to the CRC in the ELF object */
> -                       crcp = (void *)info->hdr + sym->st_value +
> -                              info->sechdrs[sym->st_shndx].sh_offset -
> -                              (info->hdr->e_type != ET_REL ?
> -                               info->sechdrs[sym->st_shndx].sh_addr : 0);
> +                       crcp = sym_get_data(info, sym);
>                         crc = TO_NATIVE(*crcp);
>                 }
>                 sym_update_crc(symname + strlen("__crc_"), mod, crc,
> --
> 2.17.1
>


-- 
Best Regards
Masahiro Yamada
