Return-Path: <SRS0=OzJr=YZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2AB18CA9EC9
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Nov 2019 06:05:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DC90020656
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Nov 2019 06:05:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nifty.com header.i=@nifty.com header.b="Uxs3r9rh"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729926AbfKAF5H (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 1 Nov 2019 01:57:07 -0400
Received: from conssluserg-01.nifty.com ([210.131.2.80]:21775 "EHLO
        conssluserg-01.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725280AbfKAF5G (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Nov 2019 01:57:06 -0400
Received: from mail-vk1-f180.google.com (mail-vk1-f180.google.com [209.85.221.180]) (authenticated)
        by conssluserg-01.nifty.com with ESMTP id xA15uxcn019065
        for <linux-kernel@vger.kernel.org>; Fri, 1 Nov 2019 14:56:59 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-01.nifty.com xA15uxcn019065
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1572587820;
        bh=rXSX+Ugi2oN/TbKki1X/38m3/2cFpGgDVd3tIU9+oDY=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=Uxs3r9rhPy9PriGPUTtY2x7QaMfjUUfy/6xtkZRa4bi1TlM6s06wulP0LNnFsTlwP
         vaL3erz/XCeN7q54XfAO5P1zYXRm0U1ZPdUkAMs/S6rIil4JEQPEfZcPnmO055FSAZ
         07zolU1OM4ZNGJyodJ+IJyz0odIkaf1CTZ1sAoQ8InH+38mN7r8nF9DM/Prv7OnsUT
         Iiz4mLL5ur5+SZ4Buti8+OjMDZP2nbqMOik/hg4A8sRKTihi44/6IiAdMP242qJSUb
         foAcdoLiryPtVwU2hjHxKhIi7fYD83XM7qaxyT2OWOwX3aR1W57umm3VX0UsY3vWxw
         eYUPfQcbDPdyw==
X-Nifty-SrcIP: [209.85.221.180]
Received: by mail-vk1-f180.google.com with SMTP id r85so1955928vke.3
        for <linux-kernel@vger.kernel.org>; Thu, 31 Oct 2019 22:56:59 -0700 (PDT)
X-Gm-Message-State: APjAAAXsl4Tpjob59utrwetfB0xPSo4yo1zHleLJcexQuf/JXm7xkj8m
        nPa8M7VvLTbnguN3qGGv4tvrdc3SyCTTqO/iLCw=
X-Google-Smtp-Source: APXvYqx4pOWqjzjCtSZizue8h55fi+pMHqsqancZbixXSmlLNXsNUkhT2lTwMcwl5bMIkHtVgmkpHO4xmmsp0mefouY=
X-Received: by 2002:a1f:a349:: with SMTP id m70mr4424277vke.26.1572587818421;
 Thu, 31 Oct 2019 22:56:58 -0700 (PDT)
MIME-Version: 1.0
References: <20191028151427.31612-1-jeyu@kernel.org> <20191028151427.31612-4-jeyu@kernel.org>
 <CAK7LNAQ8WDQ3PX8iwQNj5eNQADFMnKNVo3+uC8dt3rCPWK8a-w@mail.gmail.com>
 <20191030161726.GA13413@linux-8ccs> <CAK7LNAR5vJExV9L+vO491V=ZRfJGiwDPd5rsZJe-4T5Dz1eh1A@mail.gmail.com>
 <20191031134115.GE2177@linux-8ccs>
In-Reply-To: <20191031134115.GE2177@linux-8ccs>
From:   Masahiro Yamada <yamada.masahiro@socionext.com>
Date:   Fri, 1 Nov 2019 14:56:22 +0900
X-Gmail-Original-Message-ID: <CAK7LNARk=vO8cFhpJ4uFRHy5wnpiYoUDUOBemVq7NHUZmKBvSA@mail.gmail.com>
Message-ID: <CAK7LNARk=vO8cFhpJ4uFRHy5wnpiYoUDUOBemVq7NHUZmKBvSA@mail.gmail.com>
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

On Thu, Oct 31, 2019 at 10:41 PM Jessica Yu <jeyu@kernel.org> wrote:
>
> +++ Masahiro Yamada [31/10/19 21:27 +0900]:
> >On Thu, Oct 31, 2019 at 1:17 AM Jessica Yu <jeyu@kernel.org> wrote:
> >>
> >> +++ Masahiro Yamada [29/10/19 21:57 +0900]:
> >> >On Tue, Oct 29, 2019 at 12:14 AM Jessica Yu <jeyu@kernel.org> wrote:
> >> >>
> >> >> The nsdeps script passes a list of the module source files to
> >> >> generate_deps_for_ns() as a space delimited string named $mod_sourc=
e_files,
> >> >> which then passes it to spatch. But since $mod_source_files is not =
encased
> >> >> in quotes, each source file in that string is treated as a separate=
 shell
> >> >> function argument (as $2, $3, $4, etc.).  However, the spatch invoc=
ation
> >> >> only refers to $2, so only the first file out of $mod_source_files =
is
> >> >> processed by spatch.
> >> >>
> >> >> This causes problems (namely, the MODULE_IMPORT_NS() statement does=
n't
> >> >> get inserted) when a module is composed of many source files and th=
e
> >> >> "main" module file containing the MODULE_LICENSE() statement is not=
 the
> >> >> first file listed in $mod_source_files. Fix this by encasing
> >> >> $mod_source_files in quotes so that the entirety of the string is
> >> >> treated as a single argument and can be referred to as $2.
> >> >>
> >> >> Signed-off-by: Jessica Yu <jeyu@kernel.org>
> >> >> ---
> >> >>  scripts/nsdeps | 2 +-
> >> >>  1 file changed, 1 insertion(+), 1 deletion(-)
> >> >>
> >> >> diff --git a/scripts/nsdeps b/scripts/nsdeps
> >> >> index 9ddcd5cb96b1..5055b059a81b 100644
> >> >> --- a/scripts/nsdeps
> >> >> +++ b/scripts/nsdeps
> >> >> @@ -36,7 +36,7 @@ generate_deps() {
> >> >>                                               | sed -E "s%(^|\s)([^=
/][^ ]*)%\1$srctree/\2%g"`
> >> >>         for ns in `cat $ns_deps_file`; do
> >> >>                 echo "Adding namespace $ns to module $mod_name (if =
needed)."
> >> >> -               generate_deps_for_ns $ns $mod_source_files
> >> >> +               generate_deps_for_ns $ns "$mod_source_files"
> >> >>                 # sort the imports
> >> >>                 for source_file in $mod_source_files; do
> >> >>                         sed '/MODULE_IMPORT_NS/Q' $source_file > ${=
source_file}.tmp
> >> >
> >> >I think this change is correct, but
> >> >did you succeed in nsdeps for composite modules
> >> >with this patch only?
> >> >
> >> >I think the following is needed too:
> >> >
> >> >
> >> >diff --git a/scripts/nsdeps b/scripts/nsdeps
> >> >index dda6fbac016e..5a23ea616446 100644
> >> >--- a/scripts/nsdeps
> >> >+++ b/scripts/nsdeps
> >> >@@ -31,9 +31,9 @@ generate_deps() {
> >> >        local mod_file=3D`echo $@ | sed -e 's/\.ko/\.mod/'`
> >> >        local ns_deps_file=3D`echo $@ | sed -e 's/\.ko/\.ns_deps/'`
> >> >        if [ ! -f "$ns_deps_file" ]; then return; fi
> >> >-       local mod_source_files=3D`cat $mod_file | sed -n 1p          =
            \
> >> >+       local mod_source_files=3D"`cat $mod_file | sed -n 1p
> >> >         \
> >> >                                              | sed -e 's/\.o/\.c/g' =
          \
> >> >-                                             | sed "s|[^ ]* *|${srct=
ree}/&|g"`
> >> >+                                             | sed "s|[^ ]* *|${srct=
ree}/&|g"`"
> >> >        for ns in `cat $ns_deps_file`; do
> >> >                echo "Adding namespace $ns to module $mod_name (if ne=
eded)."
> >> >                generate_deps_for_ns $ns $mod_source_files
> >> >
> >> >
> >> >Without this, a module that consists of two files
> >> >will be expanded to:
> >> >
> >> >local mod_source_files=3Dsource1.c source2.c
> >>
> >> Yes, I was able to have nsdeps work for composite modules with just my
> >> patch. Without this patch applied, the script produces the following
> >> expansion of the generate_deps_for_ns call, (I just added a test
> >> namespace MODULE):
> >>
> >> Adding namespace MODULE to module fs/nfs/nfs.ko.
> >> + generate_deps_for_ns MODULE /tmp/ppyu/linux/fs/nfs/client.c /tmp/ppy=
u/linux/fs/nfs/dir.c /tmp/ppyu/linux/fs/nfs/file.c /tmp/ppyu/linux/fs/nfs/g=
etroot.c /tmp/ppyu/linux/fs/nfs/inode.c /tmp/ppyu/linux/fs/nfs/super.c /tmp=
/ppyu/linux/fs/nfs/io.c /tmp/ppyu/linux/fs/nfs/direct.c /tmp/ppyu/linux/fs/=
nfs/pagelist.c /tmp/ppyu/linux/fs/nfs/read.c /tmp/ppyu/linux/fs/nfs/symlink=
.c /tmp/ppyu/linux/fs/nfs/unlink.c /tmp/ppyu/linux/fs/nfs/write.c /tmp/ppyu=
/linux/fs/nfs/namespace.c /tmp/ppyu/linux/fs/nfs/mount_clnt.c /tmp/ppyu/lin=
ux/fs/nfs/nfstrace.c /tmp/ppyu/linux/fs/nfs/export.c /tmp/ppyu/linux/fs/nfs=
/sysfs.c /tmp/ppyu/linux/fs/nfs/sysctl.c /tmp/ppyu/linux/fs/nfs/fscache.c /=
tmp/ppyu/linux/fs/nfs/fscache-index.c
> >> + /usr/bin/spatch --very-quiet --in-place --sp-file /tmp/ppyu/linux/sc=
ripts/coccinelle/misc/add_namespace.cocci -D ns=3DMODULE /tmp/ppyu/linux/fs=
/nfs/client.c
> >>
> >> So only the first file got included in the spatch invocation. But the
> >> spatch call gets fixed with all the files when quotes are added in the
> >> call to generate_deps_for_ns.
> >>
> >> But we need to include your change anyway, to make the script more
> >> robust.
> >
> >Hmm.
> >With this patch only, I see "bad variable name" error.
> >
> >
> >
> >masahiro@grover:~/ref/linux$ make -j8  nsdeps
> >  DESCEND  objtool
> >  CALL    scripts/atomic/check-atomics.sh
> >  CALL    scripts/checksyscalls.sh
> >  CHK     include/generated/compile.h
> >  Building modules, stage 2.
> >  MODPOST 20 modules
> >WARNING: module nfs uses symbol foo from namespace USB_STORAGE, but
> >does not import it.
> >  Building modules, stage 2.
> >  MODPOST 20 modules
> >./scripts/nsdeps: 34: local: ./fs/nfs/dir.c: bad variable name
> >make: *** [Makefile;1689: nsdeps] Error 2
>
> Hm, I was having trouble reproducing this until I changed the shell to
> dash, /bin/sh is a symlink to bash on my system, that might explain
> slightly different behavior. In any case, we should add quotes in both
> places.
>
> >> It would probably prevent more shell script related bugs in
> >> the future (Like [1]). I can respin this patch only while the other
> >> ones are superceded by your patchset.
> >>
> >> [1] https://unix.stackexchange.com/a/131767
> >
> >Anyway.
> >
> >Is this patch aiming for v5.4 (i.e. fixes) or v5.5-rc1 ?
>
> I am hoping for fixes, we should try to get all the small bugs out of
> nsdeps by 5.4 if we can..
>
> >If you touch the mod_source_files line,
> >we will have a conflict because
> >https://patchwork.kernel.org/patch/11217839/
> >is touching the same line.
> >
> >How should we organize the patch order?
>
> Would you like to fold these changes into your nsdeps improvements
> patchset? Since it's a pretty trivial change.
>
> Thanks!
>
>

My change set is quite big, so I
am planning to send it for v5.5-rc1.

If you want to fix nsdeps for composite modules earlier,
please apply this patch to your tree
and send another pull request.

--=20
Best Regards
Masahiro Yamada
