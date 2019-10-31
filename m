Return-Path: <SRS0=21RF=YY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9CF04CA9EC3
	for <linux-kernel@archiver.kernel.org>; Thu, 31 Oct 2019 12:28:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 680152087F
	for <linux-kernel@archiver.kernel.org>; Thu, 31 Oct 2019 12:28:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nifty.com header.i=@nifty.com header.b="2gRlBXP3"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726722AbfJaM17 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 31 Oct 2019 08:27:59 -0400
Received: from conssluserg-02.nifty.com ([210.131.2.81]:46000 "EHLO
        conssluserg-02.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726462AbfJaM17 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Oct 2019 08:27:59 -0400
Received: from mail-vs1-f54.google.com (mail-vs1-f54.google.com [209.85.217.54]) (authenticated)
        by conssluserg-02.nifty.com with ESMTP id x9VCRk1R019613
        for <linux-kernel@vger.kernel.org>; Thu, 31 Oct 2019 21:27:47 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-02.nifty.com x9VCRk1R019613
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1572524867;
        bh=5AXIdd7UsfrTbzkht+brzkU23R3pC3abzYYe6g7Phy8=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=2gRlBXP3mUuBGWdSj3R6uy4uuLJwDUUejn1OReylY6lwD0VoqDjv55+nBYJvW5uei
         H0wabh1zSlNZwwfnGnVvS3Jgsj/N12U1QyD2DLtzMxkTye6MqlHdLm9kAAiC+Bn+1s
         VL5u/1YD1JugZux31wNR2W6F+EcbpP6tgDLMnwTYC3xTSZXs2dcgIpzgy52BTAnrcH
         qeaTZLkb+SowBelOrD9V6as/Sf2gIXNRZLK54+B3n3MltMscFCwn03w62/gX9jPSST
         A0nNh4+5epIOUKEiTTgP0sdUUXM8jjzfANXfGhVgphobZI8xdJmsTLHOzQLr01v78s
         V17xgNgdLv7+Q==
X-Nifty-SrcIP: [209.85.217.54]
Received: by mail-vs1-f54.google.com with SMTP id w25so3951694vso.4
        for <linux-kernel@vger.kernel.org>; Thu, 31 Oct 2019 05:27:47 -0700 (PDT)
X-Gm-Message-State: APjAAAVSruTLfq5XkzTtxQa4wl5bo0g31zTlW27gmkuIhAolmyMjbFMv
        RBqjZ+pD14QYGZ+HgdkhHrr7HLFf7S7HpPzD/kM=
X-Google-Smtp-Source: APXvYqyV7wuBrm0wsnqDPwu6LqfSd7yeDvlOl7R7GKBUBURL+ZR95hqppNgFVokciiWHhcelEJPL+bGYtdKHejgebrQ=
X-Received: by 2002:a67:e290:: with SMTP id g16mr2518522vsf.54.1572524866065;
 Thu, 31 Oct 2019 05:27:46 -0700 (PDT)
MIME-Version: 1.0
References: <20191028151427.31612-1-jeyu@kernel.org> <20191028151427.31612-4-jeyu@kernel.org>
 <CAK7LNAQ8WDQ3PX8iwQNj5eNQADFMnKNVo3+uC8dt3rCPWK8a-w@mail.gmail.com> <20191030161726.GA13413@linux-8ccs>
In-Reply-To: <20191030161726.GA13413@linux-8ccs>
From:   Masahiro Yamada <yamada.masahiro@socionext.com>
Date:   Thu, 31 Oct 2019 21:27:10 +0900
X-Gmail-Original-Message-ID: <CAK7LNAR5vJExV9L+vO491V=ZRfJGiwDPd5rsZJe-4T5Dz1eh1A@mail.gmail.com>
Message-ID: <CAK7LNAR5vJExV9L+vO491V=ZRfJGiwDPd5rsZJe-4T5Dz1eh1A@mail.gmail.com>
Subject: Re: [PATCH 4/4] scripts/nsdeps: make sure to pass all module source
 files to spatch
To:     Jessica Yu <jeyu@kernel.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Matthias Maennich <maennich@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 31, 2019 at 1:17 AM Jessica Yu <jeyu@kernel.org> wrote:
>
> +++ Masahiro Yamada [29/10/19 21:57 +0900]:
> >On Tue, Oct 29, 2019 at 12:14 AM Jessica Yu <jeyu@kernel.org> wrote:
> >>
> >> The nsdeps script passes a list of the module source files to
> >> generate_deps_for_ns() as a space delimited string named $mod_source_f=
iles,
> >> which then passes it to spatch. But since $mod_source_files is not enc=
ased
> >> in quotes, each source file in that string is treated as a separate sh=
ell
> >> function argument (as $2, $3, $4, etc.).  However, the spatch invocati=
on
> >> only refers to $2, so only the first file out of $mod_source_files is
> >> processed by spatch.
> >>
> >> This causes problems (namely, the MODULE_IMPORT_NS() statement doesn't
> >> get inserted) when a module is composed of many source files and the
> >> "main" module file containing the MODULE_LICENSE() statement is not th=
e
> >> first file listed in $mod_source_files. Fix this by encasing
> >> $mod_source_files in quotes so that the entirety of the string is
> >> treated as a single argument and can be referred to as $2.
> >>
> >> Signed-off-by: Jessica Yu <jeyu@kernel.org>
> >> ---
> >>  scripts/nsdeps | 2 +-
> >>  1 file changed, 1 insertion(+), 1 deletion(-)
> >>
> >> diff --git a/scripts/nsdeps b/scripts/nsdeps
> >> index 9ddcd5cb96b1..5055b059a81b 100644
> >> --- a/scripts/nsdeps
> >> +++ b/scripts/nsdeps
> >> @@ -36,7 +36,7 @@ generate_deps() {
> >>                                               | sed -E "s%(^|\s)([^/][=
^ ]*)%\1$srctree/\2%g"`
> >>         for ns in `cat $ns_deps_file`; do
> >>                 echo "Adding namespace $ns to module $mod_name (if nee=
ded)."
> >> -               generate_deps_for_ns $ns $mod_source_files
> >> +               generate_deps_for_ns $ns "$mod_source_files"
> >>                 # sort the imports
> >>                 for source_file in $mod_source_files; do
> >>                         sed '/MODULE_IMPORT_NS/Q' $source_file > ${sou=
rce_file}.tmp
> >
> >I think this change is correct, but
> >did you succeed in nsdeps for composite modules
> >with this patch only?
> >
> >I think the following is needed too:
> >
> >
> >diff --git a/scripts/nsdeps b/scripts/nsdeps
> >index dda6fbac016e..5a23ea616446 100644
> >--- a/scripts/nsdeps
> >+++ b/scripts/nsdeps
> >@@ -31,9 +31,9 @@ generate_deps() {
> >        local mod_file=3D`echo $@ | sed -e 's/\.ko/\.mod/'`
> >        local ns_deps_file=3D`echo $@ | sed -e 's/\.ko/\.ns_deps/'`
> >        if [ ! -f "$ns_deps_file" ]; then return; fi
> >-       local mod_source_files=3D`cat $mod_file | sed -n 1p             =
         \
> >+       local mod_source_files=3D"`cat $mod_file | sed -n 1p
> >         \
> >                                              | sed -e 's/\.o/\.c/g'    =
       \
> >-                                             | sed "s|[^ ]* *|${srctree=
}/&|g"`
> >+                                             | sed "s|[^ ]* *|${srctree=
}/&|g"`"
> >        for ns in `cat $ns_deps_file`; do
> >                echo "Adding namespace $ns to module $mod_name (if neede=
d)."
> >                generate_deps_for_ns $ns $mod_source_files
> >
> >
> >Without this, a module that consists of two files
> >will be expanded to:
> >
> >local mod_source_files=3Dsource1.c source2.c
>
> Yes, I was able to have nsdeps work for composite modules with just my
> patch. Without this patch applied, the script produces the following
> expansion of the generate_deps_for_ns call, (I just added a test
> namespace MODULE):
>
> Adding namespace MODULE to module fs/nfs/nfs.ko.
> + generate_deps_for_ns MODULE /tmp/ppyu/linux/fs/nfs/client.c /tmp/ppyu/l=
inux/fs/nfs/dir.c /tmp/ppyu/linux/fs/nfs/file.c /tmp/ppyu/linux/fs/nfs/getr=
oot.c /tmp/ppyu/linux/fs/nfs/inode.c /tmp/ppyu/linux/fs/nfs/super.c /tmp/pp=
yu/linux/fs/nfs/io.c /tmp/ppyu/linux/fs/nfs/direct.c /tmp/ppyu/linux/fs/nfs=
/pagelist.c /tmp/ppyu/linux/fs/nfs/read.c /tmp/ppyu/linux/fs/nfs/symlink.c =
/tmp/ppyu/linux/fs/nfs/unlink.c /tmp/ppyu/linux/fs/nfs/write.c /tmp/ppyu/li=
nux/fs/nfs/namespace.c /tmp/ppyu/linux/fs/nfs/mount_clnt.c /tmp/ppyu/linux/=
fs/nfs/nfstrace.c /tmp/ppyu/linux/fs/nfs/export.c /tmp/ppyu/linux/fs/nfs/sy=
sfs.c /tmp/ppyu/linux/fs/nfs/sysctl.c /tmp/ppyu/linux/fs/nfs/fscache.c /tmp=
/ppyu/linux/fs/nfs/fscache-index.c
> + /usr/bin/spatch --very-quiet --in-place --sp-file /tmp/ppyu/linux/scrip=
ts/coccinelle/misc/add_namespace.cocci -D ns=3DMODULE /tmp/ppyu/linux/fs/nf=
s/client.c
>
> So only the first file got included in the spatch invocation. But the
> spatch call gets fixed with all the files when quotes are added in the
> call to generate_deps_for_ns.
>
> But we need to include your change anyway, to make the script more
> robust.

Hmm.
With this patch only, I see "bad variable name" error.



masahiro@grover:~/ref/linux$ make -j8  nsdeps
  DESCEND  objtool
  CALL    scripts/atomic/check-atomics.sh
  CALL    scripts/checksyscalls.sh
  CHK     include/generated/compile.h
  Building modules, stage 2.
  MODPOST 20 modules
WARNING: module nfs uses symbol foo from namespace USB_STORAGE, but
does not import it.
  Building modules, stage 2.
  MODPOST 20 modules
./scripts/nsdeps: 34: local: ./fs/nfs/dir.c: bad variable name
make: *** [Makefile;1689: nsdeps] Error 2




> It would probably prevent more shell script related bugs in
> the future (Like [1]). I can respin this patch only while the other
> ones are superceded by your patchset.
>
> [1] https://unix.stackexchange.com/a/131767

Anyway.

Is this patch aiming for v5.4 (i.e. fixes) or v5.5-rc1 ?

If you touch the mod_source_files line,
we will have a conflict because
https://patchwork.kernel.org/patch/11217839/
is touching the same line.

How should we organize the patch order?

--
Best Regards
Masahiro Yamada
