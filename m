Return-Path: <SRS0=2+op=Y5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0A42DC010CF
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Nov 2019 12:37:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D151721D71
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Nov 2019 12:37:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nifty.com header.i=@nifty.com header.b="abKJuiCG"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388942AbfKEMhJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 5 Nov 2019 07:37:09 -0500
Received: from conssluserg-06.nifty.com ([210.131.2.91]:55578 "EHLO
        conssluserg-06.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388033AbfKEMhJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Nov 2019 07:37:09 -0500
Received: from mail-ua1-f45.google.com (mail-ua1-f45.google.com [209.85.222.45]) (authenticated)
        by conssluserg-06.nifty.com with ESMTP id xA5CapXV020211
        for <linux-kernel@vger.kernel.org>; Tue, 5 Nov 2019 21:36:52 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-06.nifty.com xA5CapXV020211
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1572957412;
        bh=0rmIwrv4WOccxJgb1JuQiBA2NZ0NkzzD5T4PMCgtTp4=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=abKJuiCGFJFcMlPjRkNpoftmHIm2UrRcaT4BGuXFOwXUjz1Rq2/ZlF42XmggjZmpQ
         RtLzRvZL5Ih96LYhiU4to75vJXiTa/WPUxiGh4S42JlTj8UOScAGVN+eo/6SEutp77
         yw9YEzqze8NTK6g+jGRYh1pRCWZyz9NBgR2NHcTAoHLDCpw0LlPDMu09g+R3OaHxSW
         fEJ/rslPn5kEXrTQlM8wyBH0gT20XBJeqTfA3H19kJyRSLPtiAKKYcl33rWV3duWYW
         zxXTkOdF2rDlvlL48z47J11QuFH9yNLS5iZFy36ZzmEj6VaDFHryLJDlesu88mp/Ur
         2zr5aHpi84sYw==
X-Nifty-SrcIP: [209.85.222.45]
Received: by mail-ua1-f45.google.com with SMTP id c16so6075842uan.0
        for <linux-kernel@vger.kernel.org>; Tue, 05 Nov 2019 04:36:51 -0800 (PST)
X-Gm-Message-State: APjAAAXfrx5ATPaq9vM2Ynpj5265XsOdMfRBPE1UgrkAhVZzxj0CDZx0
        PqIVWpMt1opPaf1PE7ajX5vgvZN5sOLXrbQhRDU=
X-Google-Smtp-Source: APXvYqyD0RSX7yveUb5YcOvy6h+9/k4yq8RjtNkJoC2znQwemRmReW02k9YT4FYl/n1sSvVARY5I/cUa77vDLoYS+ao=
X-Received: by 2002:a9f:2382:: with SMTP id 2mr14642498uao.95.1572957410640;
 Tue, 05 Nov 2019 04:36:50 -0800 (PST)
MIME-Version: 1.0
References: <20191105121103.31200-1-jeyu@kernel.org>
In-Reply-To: <20191105121103.31200-1-jeyu@kernel.org>
From:   Masahiro Yamada <yamada.masahiro@socionext.com>
Date:   Tue, 5 Nov 2019 21:36:14 +0900
X-Gmail-Original-Message-ID: <CAK7LNARG7kM_OUsDzqmXk4tLqFDj7VrO+XtrK1fvmQj_2SujAw@mail.gmail.com>
Message-ID: <CAK7LNARG7kM_OUsDzqmXk4tLqFDj7VrO+XtrK1fvmQj_2SujAw@mail.gmail.com>
Subject: Re: [PATCH v2] scripts/nsdeps: make sure to pass all module source
 files to spatch
To:     Jessica Yu <jeyu@kernel.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Matthias Maennich <maennich@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 5, 2019 at 9:11 PM Jessica Yu <jeyu@kernel.org> wrote:
>
> The nsdeps script passes a list of the module source files to
> generate_deps_for_ns() as a space delimited string named $mod_source_files,
> which then passes it to spatch. But since $mod_source_files is not encased
> in quotes, each source file in that string is treated as a separate shell
> function argument (as $2, $3, $4, etc.).  However, the spatch invocation
> only refers to $2, so only the first file out of $mod_source_files is
> processed by spatch.
>
> This causes problems (namely, the MODULE_IMPORT_NS() statement doesn't
> get inserted) when a module is composed of many source files and the
> "main" module file containing the MODULE_LICENSE() statement is not the
> first file listed in $mod_source_files. Fix this by encasing
> $mod_source_files in quotes so that the entirety of the string is
> treated as a single argument and can be referred to as $2.
>
> In addition, put quotes in the variable assignment of mod_source_files
> to prevent any shell interpretation and field splitting.
>
> Signed-off-by: Jessica Yu <jeyu@kernel.org>
> ---

Reviewed-by: Masahiro Yamada <yamada.masahiro@socionext.com>






>
> v2: put quotes around mod_source_files variable assignment as suggested by Masahiro.
>
>  scripts/nsdeps | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
>
> diff --git a/scripts/nsdeps b/scripts/nsdeps
> index dda6fbac016e..04cea0921673 100644
> --- a/scripts/nsdeps
> +++ b/scripts/nsdeps
> @@ -31,12 +31,12 @@ generate_deps() {
>         local mod_file=`echo $@ | sed -e 's/\.ko/\.mod/'`
>         local ns_deps_file=`echo $@ | sed -e 's/\.ko/\.ns_deps/'`
>         if [ ! -f "$ns_deps_file" ]; then return; fi
> -       local mod_source_files=`cat $mod_file | sed -n 1p                      \
> +       local mod_source_files="`cat $mod_file | sed -n 1p                      \
>                                               | sed -e 's/\.o/\.c/g'           \
> -                                             | sed "s|[^ ]* *|${srctree}/&|g"`
> +                                             | sed "s|[^ ]* *|${srctree}/&|g"`"
>         for ns in `cat $ns_deps_file`; do
>                 echo "Adding namespace $ns to module $mod_name (if needed)."
> -               generate_deps_for_ns $ns $mod_source_files
> +               generate_deps_for_ns $ns "$mod_source_files"
>                 # sort the imports
>                 for source_file in $mod_source_files; do
>                         sed '/MODULE_IMPORT_NS/Q' $source_file > ${source_file}.tmp
> --
> 2.16.4
>


-- 
Best Regards
Masahiro Yamada
