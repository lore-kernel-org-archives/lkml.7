Return-Path: <SRS0=2+op=Y5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2C569C17460
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Nov 2019 12:57:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D21EE21882
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Nov 2019 12:57:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nifty.com header.i=@nifty.com header.b="mfLwH4CL"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388649AbfKEM5p (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 5 Nov 2019 07:57:45 -0500
Received: from conssluserg-06.nifty.com ([210.131.2.91]:37431 "EHLO
        conssluserg-06.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388008AbfKEM5o (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Nov 2019 07:57:44 -0500
Received: from mail-vs1-f41.google.com (mail-vs1-f41.google.com [209.85.217.41]) (authenticated)
        by conssluserg-06.nifty.com with ESMTP id xA5Cvep9000896
        for <linux-kernel@vger.kernel.org>; Tue, 5 Nov 2019 21:57:40 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-06.nifty.com xA5Cvep9000896
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1572958661;
        bh=kY5xpWOicnqPUSuUlkYbVydx7d7nLtZF2j+89FikbqA=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=mfLwH4CLY3KPK6DxtFxAqIfMPoh0rWWR115A1qJq/cdz/XTx1sMY9jkQdB+U34LC/
         NSy5Tqinuv78hzBxxDMMNQPmBuKj9yQd8K0Cjb/mE4bF9A8v43a9/Ymx+3VdZRMhl3
         M6+08Crc9cfAsMA+XAwOByuP4YK3KdJnqeg4pZp97yh+Hy1urYjmzWpYxBc5IbwN5H
         WnlQfo3gu9sHcTR7NTd8D1jbtOC0OIs5O6lAaUGRfoso3tG/sisG5TLG0bMLTwrOuv
         vVLZDiEatqNXPtEHj95ViUzVLKBeTHUMZk35l8TMWC3xgyPUXnDRLSWiR790uXTl4+
         LHN4Y+VzqQZsw==
X-Nifty-SrcIP: [209.85.217.41]
Received: by mail-vs1-f41.google.com with SMTP id 190so8805041vss.8
        for <linux-kernel@vger.kernel.org>; Tue, 05 Nov 2019 04:57:40 -0800 (PST)
X-Gm-Message-State: APjAAAUtVf2PrL3s6jyTZPJDw4TsUPSB5rJMLH+OvSOOtkGDbaJZcOHw
        uWskFd3gU+AKsEA68442GETHdv/CQpMVw0bMbaU=
X-Google-Smtp-Source: APXvYqzX92BZOqRkMKJilha8QhHDY7X1xtZ5cKXRcsN6WqfMeBTZZnTuCprSG1WeGilrzz8BrofjRY5sZSfuU32/mS4=
X-Received: by 2002:a67:d31b:: with SMTP id a27mr9001375vsj.215.1572958659312;
 Tue, 05 Nov 2019 04:57:39 -0800 (PST)
MIME-Version: 1.0
References: <20191028151427.31612-1-jeyu@kernel.org> <20191028151427.31612-4-jeyu@kernel.org>
 <CAK7LNAQ8WDQ3PX8iwQNj5eNQADFMnKNVo3+uC8dt3rCPWK8a-w@mail.gmail.com>
 <20191030161726.GA13413@linux-8ccs> <CAK7LNAR5vJExV9L+vO491V=ZRfJGiwDPd5rsZJe-4T5Dz1eh1A@mail.gmail.com>
 <20191031134115.GE2177@linux-8ccs> <CAK7LNARk=vO8cFhpJ4uFRHy5wnpiYoUDUOBemVq7NHUZmKBvSA@mail.gmail.com>
 <20191105125215.GA31800@linux-8ccs>
In-Reply-To: <20191105125215.GA31800@linux-8ccs>
From:   Masahiro Yamada <yamada.masahiro@socionext.com>
Date:   Tue, 5 Nov 2019 21:57:03 +0900
X-Gmail-Original-Message-ID: <CAK7LNARmjj+AQ-U+thvb0mkneSCfafPiG_-qbyyiyceQtXkZug@mail.gmail.com>
Message-ID: <CAK7LNARmjj+AQ-U+thvb0mkneSCfafPiG_-qbyyiyceQtXkZug@mail.gmail.com>
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

On Tue, Nov 5, 2019 at 9:52 PM Jessica Yu <jeyu@kernel.org> wrote:
>
> +++ Masahiro Yamada [01/11/19 14:56 +0900]:
> >On Thu, Oct 31, 2019 at 10:41 PM Jessica Yu <jeyu@kernel.org> wrote:
> >>
> >> +++ Masahiro Yamada [31/10/19 21:27 +0900]:
> >> >On Thu, Oct 31, 2019 at 1:17 AM Jessica Yu <jeyu@kernel.org> wrote:
> >> >>
> >> >> +++ Masahiro Yamada [29/10/19 21:57 +0900]:
> >> >> >On Tue, Oct 29, 2019 at 12:14 AM Jessica Yu <jeyu@kernel.org> wrot=
e:
> >> >> >>
> >> >> >> The nsdeps script passes a list of the module source files to
> >> >> >> generate_deps_for_ns() as a space delimited string named $mod_so=
urce_files,
> >> >> >> which then passes it to spatch. But since $mod_source_files is n=
ot encased
> >> >> >> in quotes, each source file in that string is treated as a separ=
ate shell
> >> >> >> function argument (as $2, $3, $4, etc.).  However, the spatch in=
vocation
> >> >> >> only refers to $2, so only the first file out of $mod_source_fil=
es is
> >> >> >> processed by spatch.
> >> >> >>
> >> >> >> This causes problems (namely, the MODULE_IMPORT_NS() statement d=
oesn't
> >> >> >> get inserted) when a module is composed of many source files and=
 the
> >> >> >> "main" module file containing the MODULE_LICENSE() statement is =
not the
> >> >> >> first file listed in $mod_source_files. Fix this by encasing
> >> >> >> $mod_source_files in quotes so that the entirety of the string i=
s
> >> >> >> treated as a single argument and can be referred to as $2.
> >> >> >>
> >> >> >> Signed-off-by: Jessica Yu <jeyu@kernel.org>
> >> >> >> ---
> >> >> >>  scripts/nsdeps | 2 +-
> >> >> >>  1 file changed, 1 insertion(+), 1 deletion(-)
> >> >> >>
> >> >> >> diff --git a/scripts/nsdeps b/scripts/nsdeps
> >> >> >> index 9ddcd5cb96b1..5055b059a81b 100644
> >> >> >> --- a/scripts/nsdeps
> >> >> >> +++ b/scripts/nsdeps
> >> >> >> @@ -36,7 +36,7 @@ generate_deps() {
> >> >> >>                                               | sed -E "s%(^|\s)=
([^/][^ ]*)%\1$srctree/\2%g"`
> >> >> >>         for ns in `cat $ns_deps_file`; do
> >> >> >>                 echo "Adding namespace $ns to module $mod_name (=
if needed)."
> >> >> >> -               generate_deps_for_ns $ns $mod_source_files
> >> >> >> +               generate_deps_for_ns $ns "$mod_source_files"
> >> >> >>                 # sort the imports
> >> >> >>                 for source_file in $mod_source_files; do
> >> >> >>                         sed '/MODULE_IMPORT_NS/Q' $source_file >=
 ${source_file}.tmp
> >> >> >
> >> >> >I think this change is correct, but
> >> >> >did you succeed in nsdeps for composite modules
> >> >> >with this patch only?
> >> >> >
> >> >> >I think the following is needed too:
> >> >> >
> >> >> >
> >> >> >diff --git a/scripts/nsdeps b/scripts/nsdeps
> >> >> >index dda6fbac016e..5a23ea616446 100644
> >> >> >--- a/scripts/nsdeps
> >> >> >+++ b/scripts/nsdeps
> >> >> >@@ -31,9 +31,9 @@ generate_deps() {
> >> >> >        local mod_file=3D`echo $@ | sed -e 's/\.ko/\.mod/'`
> >> >> >        local ns_deps_file=3D`echo $@ | sed -e 's/\.ko/\.ns_deps/'=
`
> >> >> >        if [ ! -f "$ns_deps_file" ]; then return; fi
> >> >> >-       local mod_source_files=3D`cat $mod_file | sed -n 1p       =
               \
> >> >> >+       local mod_source_files=3D"`cat $mod_file | sed -n 1p
> >> >> >         \
> >> >> >                                              | sed -e 's/\.o/\.c/=
g'           \
> >> >> >-                                             | sed "s|[^ ]* *|${s=
rctree}/&|g"`
> >> >> >+                                             | sed "s|[^ ]* *|${s=
rctree}/&|g"`"
> >> >> >        for ns in `cat $ns_deps_file`; do
> >> >> >                echo "Adding namespace $ns to module $mod_name (if=
 needed)."
> >> >> >                generate_deps_for_ns $ns $mod_source_files
> >> >> >
> >> >> >
> >> >> >Without this, a module that consists of two files
> >> >> >will be expanded to:
> >> >> >
> >> >> >local mod_source_files=3Dsource1.c source2.c
> >> >>
> >> >> Yes, I was able to have nsdeps work for composite modules with just=
 my
> >> >> patch. Without this patch applied, the script produces the followin=
g
> >> >> expansion of the generate_deps_for_ns call, (I just added a test
> >> >> namespace MODULE):
> >> >>
> >> >> Adding namespace MODULE to module fs/nfs/nfs.ko.
> >> >> + generate_deps_for_ns MODULE /tmp/ppyu/linux/fs/nfs/client.c /tmp/=
ppyu/linux/fs/nfs/dir.c /tmp/ppyu/linux/fs/nfs/file.c /tmp/ppyu/linux/fs/nf=
s/getroot.c /tmp/ppyu/linux/fs/nfs/inode.c /tmp/ppyu/linux/fs/nfs/super.c /=
tmp/ppyu/linux/fs/nfs/io.c /tmp/ppyu/linux/fs/nfs/direct.c /tmp/ppyu/linux/=
fs/nfs/pagelist.c /tmp/ppyu/linux/fs/nfs/read.c /tmp/ppyu/linux/fs/nfs/syml=
ink.c /tmp/ppyu/linux/fs/nfs/unlink.c /tmp/ppyu/linux/fs/nfs/write.c /tmp/p=
pyu/linux/fs/nfs/namespace.c /tmp/ppyu/linux/fs/nfs/mount_clnt.c /tmp/ppyu/=
linux/fs/nfs/nfstrace.c /tmp/ppyu/linux/fs/nfs/export.c /tmp/ppyu/linux/fs/=
nfs/sysfs.c /tmp/ppyu/linux/fs/nfs/sysctl.c /tmp/ppyu/linux/fs/nfs/fscache.=
c /tmp/ppyu/linux/fs/nfs/fscache-index.c
> >> >> + /usr/bin/spatch --very-quiet --in-place --sp-file /tmp/ppyu/linux=
/scripts/coccinelle/misc/add_namespace.cocci -D ns=3DMODULE /tmp/ppyu/linux=
/fs/nfs/client.c
> >> >>
> >> >> So only the first file got included in the spatch invocation. But t=
he
> >> >> spatch call gets fixed with all the files when quotes are added in =
the
> >> >> call to generate_deps_for_ns.
> >> >>
> >> >> But we need to include your change anyway, to make the script more
> >> >> robust.
> >> >
> >> >Hmm.
> >> >With this patch only, I see "bad variable name" error.
> >> >
> >> >
> >> >
> >> >masahiro@grover:~/ref/linux$ make -j8  nsdeps
> >> >  DESCEND  objtool
> >> >  CALL    scripts/atomic/check-atomics.sh
> >> >  CALL    scripts/checksyscalls.sh
> >> >  CHK     include/generated/compile.h
> >> >  Building modules, stage 2.
> >> >  MODPOST 20 modules
> >> >WARNING: module nfs uses symbol foo from namespace USB_STORAGE, but
> >> >does not import it.
> >> >  Building modules, stage 2.
> >> >  MODPOST 20 modules
> >> >./scripts/nsdeps: 34: local: ./fs/nfs/dir.c: bad variable name
> >> >make: *** [Makefile;1689: nsdeps] Error 2
> >>
> >> Hm, I was having trouble reproducing this until I changed the shell to
> >> dash, /bin/sh is a symlink to bash on my system, that might explain
> >> slightly different behavior. In any case, we should add quotes in both
> >> places.
> >>
> >> >> It would probably prevent more shell script related bugs in
> >> >> the future (Like [1]). I can respin this patch only while the other
> >> >> ones are superceded by your patchset.
> >> >>
> >> >> [1] https://unix.stackexchange.com/a/131767
> >> >
> >> >Anyway.
> >> >
> >> >Is this patch aiming for v5.4 (i.e. fixes) or v5.5-rc1 ?
> >>
> >> I am hoping for fixes, we should try to get all the small bugs out of
> >> nsdeps by 5.4 if we can..
> >>
> >> >If you touch the mod_source_files line,
> >> >we will have a conflict because
> >> >https://patchwork.kernel.org/patch/11217839/
> >> >is touching the same line.
> >> >
> >> >How should we organize the patch order?
> >>
> >> Would you like to fold these changes into your nsdeps improvements
> >> patchset? Since it's a pretty trivial change.
> >>
> >> Thanks!
> >>
> >>
> >
> >My change set is quite big, so I
> >am planning to send it for v5.5-rc1.
>
> OK, sounds good.
>
> >If you want to fix nsdeps for composite modules earlier,
> >please apply this patch to your tree
> >and send another pull request.
>
> I plan to send this in for -rc7, since it's a minor fix.

OK.

> For the conflict, if these patches are not pushed anywhere yet (at
> least I did not see them on the kbuild for-next branch yet), perhaps
> you could rebase on top of -rc7 and put your patchset on top?

No problem. I will do so.

Thanks.



--=20
Best Regards
Masahiro Yamada
