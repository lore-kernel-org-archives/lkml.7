Return-Path: <SRS0=sYEh=YW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 495A9CA9EAE
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Oct 2019 12:58:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1BCF9208E3
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Oct 2019 12:58:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nifty.com header.i=@nifty.com header.b="tSBY/GyL"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388189AbfJ2M6Z (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 29 Oct 2019 08:58:25 -0400
Received: from conssluserg-05.nifty.com ([210.131.2.90]:22235 "EHLO
        conssluserg-05.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729253AbfJ2M6Y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Oct 2019 08:58:24 -0400
Received: from mail-ua1-f47.google.com (mail-ua1-f47.google.com [209.85.222.47]) (authenticated)
        by conssluserg-05.nifty.com with ESMTP id x9TCw2dG012049
        for <linux-kernel@vger.kernel.org>; Tue, 29 Oct 2019 21:58:03 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-05.nifty.com x9TCw2dG012049
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1572353883;
        bh=HrCvaHFmrS5y9/Pm9TPIG1FtoBKHhaBS1kbDIT2tZyI=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=tSBY/GyL/fSzY3Hx62G6OjoSOpXFt0JDgXeC769iaR33H+gHK3UnYHOjjIZKTBLy/
         dl9Iw/NRcQJL71Umqo3RLESx7n2reS4bOoz9fdhfCU8wUfN7E8m/8wb1oBZ/rT3uOB
         K3mFlKqek2FUF7/6dKaGnXWzocXpQijJZGE3fW71OChCORQXIxbMu8KLS9GW/MhYce
         Qxaw5Eu4GNqv0y63HxQM4jCBgttsYkd5f1yrCimpO0B770kwPkOF6f6z+rr6b375Po
         WMGSoMoZFGUr4Lrju5jdr4u5k6n2nFes7ywauKVttGdkQA9ICsF/uLxk/tzZAGqqk1
         ZSkYJF964g5aA==
X-Nifty-SrcIP: [209.85.222.47]
Received: by mail-ua1-f47.google.com with SMTP id d19so1584790uaq.11
        for <linux-kernel@vger.kernel.org>; Tue, 29 Oct 2019 05:58:03 -0700 (PDT)
X-Gm-Message-State: APjAAAV36Dr8ufFdK89KDp5Ie7foXnpeN48lhzgUNugT3VF4LCwEb3PV
        qYPYup69B1kXKPA5Y5FdcBcaW3xT8H3BDki5NmY=
X-Google-Smtp-Source: APXvYqzuglrrCHYurEqlfVJ/a7pyeI8BXx7S+bDeGmsw3bm6TIECc8I/QoPuskL80QIWZmBbr7lFtBPqcJlJ/18J73s=
X-Received: by 2002:ab0:658d:: with SMTP id v13mr4905800uam.40.1572353882089;
 Tue, 29 Oct 2019 05:58:02 -0700 (PDT)
MIME-Version: 1.0
References: <20191028151427.31612-1-jeyu@kernel.org> <20191028151427.31612-4-jeyu@kernel.org>
In-Reply-To: <20191028151427.31612-4-jeyu@kernel.org>
From:   Masahiro Yamada <yamada.masahiro@socionext.com>
Date:   Tue, 29 Oct 2019 21:57:26 +0900
X-Gmail-Original-Message-ID: <CAK7LNAQ8WDQ3PX8iwQNj5eNQADFMnKNVo3+uC8dt3rCPWK8a-w@mail.gmail.com>
Message-ID: <CAK7LNAQ8WDQ3PX8iwQNj5eNQADFMnKNVo3+uC8dt3rCPWK8a-w@mail.gmail.com>
Subject: Re: [PATCH 4/4] scripts/nsdeps: make sure to pass all module source
 files to spatch
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
> Signed-off-by: Jessica Yu <jeyu@kernel.org>
> ---
>  scripts/nsdeps | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/scripts/nsdeps b/scripts/nsdeps
> index 9ddcd5cb96b1..5055b059a81b 100644
> --- a/scripts/nsdeps
> +++ b/scripts/nsdeps
> @@ -36,7 +36,7 @@ generate_deps() {
>                                               | sed -E "s%(^|\s)([^/][^ ]*)%\1$srctree/\2%g"`
>         for ns in `cat $ns_deps_file`; do
>                 echo "Adding namespace $ns to module $mod_name (if needed)."
> -               generate_deps_for_ns $ns $mod_source_files
> +               generate_deps_for_ns $ns "$mod_source_files"
>                 # sort the imports
>                 for source_file in $mod_source_files; do
>                         sed '/MODULE_IMPORT_NS/Q' $source_file > ${source_file}.tmp

I think this change is correct, but
did you succeed in nsdeps for composite modules
with this patch only?

I think the following is needed too:


diff --git a/scripts/nsdeps b/scripts/nsdeps
index dda6fbac016e..5a23ea616446 100644
--- a/scripts/nsdeps
+++ b/scripts/nsdeps
@@ -31,9 +31,9 @@ generate_deps() {
        local mod_file=`echo $@ | sed -e 's/\.ko/\.mod/'`
        local ns_deps_file=`echo $@ | sed -e 's/\.ko/\.ns_deps/'`
        if [ ! -f "$ns_deps_file" ]; then return; fi
-       local mod_source_files=`cat $mod_file | sed -n 1p                      \
+       local mod_source_files="`cat $mod_file | sed -n 1p
         \
                                              | sed -e 's/\.o/\.c/g'           \
-                                             | sed "s|[^ ]* *|${srctree}/&|g"`
+                                             | sed "s|[^ ]* *|${srctree}/&|g"`"
        for ns in `cat $ns_deps_file`; do
                echo "Adding namespace $ns to module $mod_name (if needed)."
                generate_deps_for_ns $ns $mod_source_files


Without this, a module that consists of two files
will be expanded to:

local mod_source_files=source1.c source2.c



-- 
Best Regards
Masahiro Yamada
