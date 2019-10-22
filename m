Return-Path: <SRS0=qxzQ=YP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A201BCA9EA0
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Oct 2019 04:38:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 298C920700
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Oct 2019 04:38:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nifty.com header.i=@nifty.com header.b="ZVOfQ6au"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387455AbfJVEii (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 22 Oct 2019 00:38:38 -0400
Received: from conssluserg-06.nifty.com ([210.131.2.91]:22866 "EHLO
        conssluserg-06.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726024AbfJVEih (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Oct 2019 00:38:37 -0400
Received: from mail-vs1-f54.google.com (mail-vs1-f54.google.com [209.85.217.54]) (authenticated)
        by conssluserg-06.nifty.com with ESMTP id x9M4cOAq031118
        for <linux-kernel@vger.kernel.org>; Tue, 22 Oct 2019 13:38:24 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-06.nifty.com x9M4cOAq031118
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1571719105;
        bh=Y7m4kw56amPHSqMoZrVwVOiMi5wEMDjWOEjfzQz1ycM=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=ZVOfQ6aubywwI+UqbDwuRDPWsL82iI5ltIea8ODNs+f5vSc2ZYyejT+tTYlLJMmM7
         af9GWHHClDkE8nY+ij0Sn5uSAlN0YTbndUPrbgPmcDjB/98Jweo5xr530ha/6vhL7h
         vbvnpRCJpXpXdO5QpwgozR8s/3C4Fz6eaP8yNDyQuZFgTilW0Es/1fk+gjUicUtbs0
         0IH1PGymxW9EPT5Z+/IiWnTGcXRu5fkTaEpG7bT1toPXtJ00zVmG56owMxGXaNawNP
         8t74xKLtKRICggS2ZIcKK89x16JHIcyD104U7QinyvJcvLMxjMFaRJjCmKO4x+0kL0
         g6jK2m6ZT2/tw==
X-Nifty-SrcIP: [209.85.217.54]
Received: by mail-vs1-f54.google.com with SMTP id k15so1479644vsp.2
        for <linux-kernel@vger.kernel.org>; Mon, 21 Oct 2019 21:38:24 -0700 (PDT)
X-Gm-Message-State: APjAAAVV85t0PTTo0hKRr3EzooZVhvjIZszW2Qmg586T+b2qWIkl1l96
        sTUlKhB0+hdi64fHToRl9M3iUZGQ79xLyJIk6eQ=
X-Google-Smtp-Source: APXvYqxNsSxZLZUPntTADw6NzjShnO+XDxBNSTBJH+iA0GeYSr5INORgrwjUisPz1cbHvohVwLXsVpoaAB6Finzit4g=
X-Received: by 2002:a67:e354:: with SMTP id s20mr740200vsm.54.1571719103415;
 Mon, 21 Oct 2019 21:38:23 -0700 (PDT)
MIME-Version: 1.0
References: <20191021145137.31672-1-jeyu@kernel.org> <20191021160419.28270-1-jeyu@kernel.org>
In-Reply-To: <20191021160419.28270-1-jeyu@kernel.org>
From:   Masahiro Yamada <yamada.masahiro@socionext.com>
Date:   Tue, 22 Oct 2019 13:37:47 +0900
X-Gmail-Original-Message-ID: <CAK7LNASyGSVNoKDqbtJYs+s-PRz3cqfet779M+PEWoAFu4e2TA@mail.gmail.com>
Message-ID: <CAK7LNASyGSVNoKDqbtJYs+s-PRz3cqfet779M+PEWoAFu4e2TA@mail.gmail.com>
Subject: Re: [PATCH v2] scripts/nsdeps: use alternative sed delimiter
To:     Jessica Yu <jeyu@kernel.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Matthias Maennich <maennich@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 22, 2019 at 1:05 AM Jessica Yu <jeyu@kernel.org> wrote:
>
> When doing an out of tree build with O=, the nsdeps script constructs
> the absolute pathname of the module source file so that it can insert
> MODULE_IMPORT_NS statements in the right place. However, ${srctree}
> contains an unescaped path to the source tree, which, when used in a sed
> substitution, makes sed complain:
>
> ++ sed 's/[^ ]* *//home/jeyu/jeyu-linux\/&/g'
> sed: -e expression #1, char 12: unknown option to `s'
>
> The sed substitution command 's' ends prematurely with the forward
> slashes in the pathname, and sed errors out when it encounters the 'h',
> which is an invalid sed substitution option. To avoid escaping forward
> slashes in ${srctree}, we can use '|' as an alternative delimiter for
> sed to avoid this error.
>
> Signed-off-by: Jessica Yu <jeyu@kernel.org>
> ---
>
> This is an alternative to my first patch here:
>
>   http://lore.kernel.org/r/20191021145137.31672-1-jeyu@kernel.org
>
> Matthias suggested using an alternative sed delimiter instead to avoid the
> ugly/unreadable ${srctree//\//\\\/} substitution.
>
>  scripts/nsdeps | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/scripts/nsdeps b/scripts/nsdeps
> index 3754dac13b31..63da30a33422 100644
> --- a/scripts/nsdeps
> +++ b/scripts/nsdeps
> @@ -33,7 +33,7 @@ generate_deps() {
>         if [ ! -f "$ns_deps_file" ]; then return; fi
>         local mod_source_files=`cat $mod_file | sed -n 1p                      \
>                                               | sed -e 's/\.o/\.c/g'           \
> -                                             | sed "s/[^ ]* */${srctree}\/&/g"`
> +                                             | sed "s|[^ ]* *|${srctree}\/&|g"`


You no longer need to escape the '/'.

s|[^ ]* *|${srctree}/&|g

is enough.


BTW, connecting multiple sed commands with pipes
is not efficient.


sed -n 1p | sed -e 's/\.o/\.c/g'

can be replaced with

sed -n '1s/\.o/\.c/gp'



This script can be improved a whole
if somebody is interested in the refactoring.




>         for ns in `cat $ns_deps_file`; do
>                 echo "Adding namespace $ns to module $mod_name (if needed)."
>                 generate_deps_for_ns $ns $mod_source_files
> --
> 2.16.4
>


-- 
Best Regards
Masahiro Yamada
