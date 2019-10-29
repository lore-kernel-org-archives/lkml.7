Return-Path: <SRS0=sYEh=YW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EC7FFCA9EAE
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Oct 2019 09:00:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BFAE420830
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Oct 2019 09:00:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nifty.com header.i=@nifty.com header.b="TEd1HyK7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730382AbfJ2JAj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 29 Oct 2019 05:00:39 -0400
Received: from conssluserg-04.nifty.com ([210.131.2.83]:46954 "EHLO
        conssluserg-04.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730295AbfJ2JAj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Oct 2019 05:00:39 -0400
Received: from mail-vs1-f47.google.com (mail-vs1-f47.google.com [209.85.217.47]) (authenticated)
        by conssluserg-04.nifty.com with ESMTP id x9T90I6e018762
        for <linux-kernel@vger.kernel.org>; Tue, 29 Oct 2019 18:00:18 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-04.nifty.com x9T90I6e018762
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1572339619;
        bh=+/K1RqI9siavtLEr0TWeAkjkdDG3eqQS0XFehoqiblU=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=TEd1HyK7gcvoQcmz0wBWMxh+fgtGxNDT8l07Tg2aFlAdy8W3SFiRtiM2yzWumfu6N
         995bqtnTiMj/ntRL5SOg48q9kO3S4Jwnx0vAv9oqnYp7HfYriLOPJD6TtO0yd7grsV
         Ai8c3SC+obHSUIGCJENxaDy4sd+VmGFuuXmZgOmx4ntzqXzK5Q8FzjVFy+JBpv53Tk
         APGTv5RxKNFsUdpb2GKgXJLS+vb3Ytky7DxfoVzGK4lnJPvfnPPcTM3O2Ivp7ggGiG
         IKUyhVc3x59ZCR38NGKu2DliCDKvECvP0KvLM4NoeCZyz4cBbcovaPExtdZkQ38//m
         P5avVDBlTozZA==
X-Nifty-SrcIP: [209.85.217.47]
Received: by mail-vs1-f47.google.com with SMTP id a143so7413497vsd.9
        for <linux-kernel@vger.kernel.org>; Tue, 29 Oct 2019 02:00:18 -0700 (PDT)
X-Gm-Message-State: APjAAAUjvghShOoRIS6epPpjomp0rxL0aVsnksigxfZXd1GqhXoL1wwy
        nn3B9V+jQryyIpQBzDkjmBGwsKHKWjMgpctC+Eo=
X-Google-Smtp-Source: APXvYqzhvtvBCXQIcBWCxJb+kqUPJe+M7p1Da6cIs08X3V2Vr+cxGgkF9coIk7hDa3e7JazwEk1PRbBb4Kwka9qXmWc=
X-Received: by 2002:a67:d091:: with SMTP id s17mr1021583vsi.215.1572339617763;
 Tue, 29 Oct 2019 02:00:17 -0700 (PDT)
MIME-Version: 1.0
References: <20191028151427.31612-1-jeyu@kernel.org> <20191028151427.31612-2-jeyu@kernel.org>
In-Reply-To: <20191028151427.31612-2-jeyu@kernel.org>
From:   Masahiro Yamada <yamada.masahiro@socionext.com>
Date:   Tue, 29 Oct 2019 17:59:41 +0900
X-Gmail-Original-Message-ID: <CAK7LNAQkqWjhseHzW56GOvCaYS7D_kPrN8nsWGEL2+HYw3G-0A@mail.gmail.com>
Message-ID: <CAK7LNAQkqWjhseHzW56GOvCaYS7D_kPrN8nsWGEL2+HYw3G-0A@mail.gmail.com>
Subject: Re: [PATCH 2/4] scripts/nsdeps: don't prepend $srctree if *.mod
 already contains full paths
To:     Jessica Yu <jeyu@kernel.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Matthias Maennich <maennich@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 29, 2019 at 12:14 AM Jessica Yu <jeyu@kernel.org> wrote:
>
> When building in-tree modules, the *.mod file contains relative paths.
> When building external modules, the resulting *.mod file contains absolute
> paths.

Not necessarily true.
Kbuild does not impose any restriction about absolute/relative path.
M= can be a relative path.


> Allow for the nsdeps script to account for both types of paths and
> only prepend $srctree in the case of relative paths.  Otherwise, the script
> will append $srctree to the path regardless and it will error out with file
> not found errors if the path was already absolute to begin with.
>
> Signed-off-by: Jessica Yu <jeyu@kernel.org>
> ---
>
> The sed regex is getting more ugly. It's not my strong point :/ If anyone
> has a better regex to prepend $srctree for every relative path encountered
> while ignoring absolute paths, I'm all ears.


It is not the problem of sed regex ugliness.


You can prefix $srctree/
unlesss building external modules.


if [ "$KBUILD_EXTMOD" ]; then
      src_prefix=
else
      src_prefix=$srctree/
fi


Then,

sed "s|[^ ]* *|${src_prefix}&|g"`


Caution: not tested at all





>  scripts/nsdeps | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/scripts/nsdeps b/scripts/nsdeps
> index 54d2ab8f9e5c..9ddcd5cb96b1 100644
> --- a/scripts/nsdeps
> +++ b/scripts/nsdeps
> @@ -33,7 +33,7 @@ generate_deps() {
>         if [ ! -f "$ns_deps_file" ]; then return; fi
>         local mod_source_files=`cat $mod_file | sed -n 1p                      \
>                                               | sed -e 's/\.o/\.c/g'           \
> -                                             | sed "s|[^ ]* *|${srctree}/&|g"`
> +                                             | sed -E "s%(^|\s)([^/][^ ]*)%\1$srctree/\2%g"`
>         for ns in `cat $ns_deps_file`; do
>                 echo "Adding namespace $ns to module $mod_name (if needed)."
>                 generate_deps_for_ns $ns $mod_source_files
> --
> 2.16.4
>


--
Best Regards
Masahiro Yamada
