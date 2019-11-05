Return-Path: <SRS0=2+op=Y5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CB03EC17460
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Nov 2019 12:52:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 93B3D21882
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Nov 2019 12:52:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1572958348;
	bh=f/kG5rnnciMqGI6gfAGP7CNBERqEC/esIBGjtKbMbqk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=Khxwu2NohS3EPb+EASh5BcNKTHqnrDnL4aU7FbO40AJeqi0b+EBbSmv5Sen+JQMIl
	 P/CwfanTg1PRE1ccMXqCKUeQ5C/g1WuLX24XrjOgmf7xH9JE2Xr495agS0umlpNrq1
	 z3SGgubi2q+E01QXfAgZs/a7SeJ7lm860mLGcK5A=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388888AbfKEMw1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 5 Nov 2019 07:52:27 -0500
Received: from mail.kernel.org ([198.145.29.99]:60444 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388678AbfKEMw1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Nov 2019 07:52:27 -0500
Received: from linux-8ccs (tmo-106-21.customers.d1-online.com [80.187.106.21])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 95CDD21882;
        Tue,  5 Nov 2019 12:52:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1572958345;
        bh=f/kG5rnnciMqGI6gfAGP7CNBERqEC/esIBGjtKbMbqk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=vY+l7KCBZDsk+IsQR8h8NghkdDBK9/jsl1ZZUCPNzXY+DOoJmoOViCURJ1tm09fj3
         pw5uK0ciGAvl311nYABBao9NHYSVkR2UloYi8fETvlZpSHgOZZMYLVL6/+djhO/YT9
         te2znff2EYFchjNxWqnL93PBwNCMhNjo13w92sco=
Date:   Tue, 5 Nov 2019 13:52:16 +0100
From:   Jessica Yu <jeyu@kernel.org>
To:     Masahiro Yamada <yamada.masahiro@socionext.com>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Matthias Maennich <maennich@google.com>
Subject: Re: [PATCH 4/4] scripts/nsdeps: make sure to pass all module source
 files to spatch
Message-ID: <20191105125215.GA31800@linux-8ccs>
References: <20191028151427.31612-1-jeyu@kernel.org>
 <20191028151427.31612-4-jeyu@kernel.org>
 <CAK7LNAQ8WDQ3PX8iwQNj5eNQADFMnKNVo3+uC8dt3rCPWK8a-w@mail.gmail.com>
 <20191030161726.GA13413@linux-8ccs>
 <CAK7LNAR5vJExV9L+vO491V=ZRfJGiwDPd5rsZJe-4T5Dz1eh1A@mail.gmail.com>
 <20191031134115.GE2177@linux-8ccs>
 <CAK7LNARk=vO8cFhpJ4uFRHy5wnpiYoUDUOBemVq7NHUZmKBvSA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <CAK7LNARk=vO8cFhpJ4uFRHy5wnpiYoUDUOBemVq7NHUZmKBvSA@mail.gmail.com>
X-OS:   Linux linux-8ccs 4.12.14-lp150.12.61-default x86_64
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

+++ Masahiro Yamada [01/11/19 14:56 +0900]:
>On Thu, Oct 31, 2019 at 10:41 PM Jessica Yu <jeyu@kernel.org> wrote:
>>
>> +++ Masahiro Yamada [31/10/19 21:27 +0900]:
>> >On Thu, Oct 31, 2019 at 1:17 AM Jessica Yu <jeyu@kernel.org> wrote:
>> >>
>> >> +++ Masahiro Yamada [29/10/19 21:57 +0900]:
>> >> >On Tue, Oct 29, 2019 at 12:14 AM Jessica Yu <jeyu@kernel.org> wrote:
>> >> >>
>> >> >> The nsdeps script passes a list of the module source files to
>> >> >> generate_deps_for_ns() as a space delimited string named $mod_source_files,
>> >> >> which then passes it to spatch. But since $mod_source_files is not encased
>> >> >> in quotes, each source file in that string is treated as a separate shell
>> >> >> function argument (as $2, $3, $4, etc.).  However, the spatch invocation
>> >> >> only refers to $2, so only the first file out of $mod_source_files is
>> >> >> processed by spatch.
>> >> >>
>> >> >> This causes problems (namely, the MODULE_IMPORT_NS() statement doesn't
>> >> >> get inserted) when a module is composed of many source files and the
>> >> >> "main" module file containing the MODULE_LICENSE() statement is not the
>> >> >> first file listed in $mod_source_files. Fix this by encasing
>> >> >> $mod_source_files in quotes so that the entirety of the string is
>> >> >> treated as a single argument and can be referred to as $2.
>> >> >>
>> >> >> Signed-off-by: Jessica Yu <jeyu@kernel.org>
>> >> >> ---
>> >> >>  scripts/nsdeps | 2 +-
>> >> >>  1 file changed, 1 insertion(+), 1 deletion(-)
>> >> >>
>> >> >> diff --git a/scripts/nsdeps b/scripts/nsdeps
>> >> >> index 9ddcd5cb96b1..5055b059a81b 100644
>> >> >> --- a/scripts/nsdeps
>> >> >> +++ b/scripts/nsdeps
>> >> >> @@ -36,7 +36,7 @@ generate_deps() {
>> >> >>                                               | sed -E "s%(^|\s)([^/][^ ]*)%\1$srctree/\2%g"`
>> >> >>         for ns in `cat $ns_deps_file`; do
>> >> >>                 echo "Adding namespace $ns to module $mod_name (if needed)."
>> >> >> -               generate_deps_for_ns $ns $mod_source_files
>> >> >> +               generate_deps_for_ns $ns "$mod_source_files"
>> >> >>                 # sort the imports
>> >> >>                 for source_file in $mod_source_files; do
>> >> >>                         sed '/MODULE_IMPORT_NS/Q' $source_file > ${source_file}.tmp
>> >> >
>> >> >I think this change is correct, but
>> >> >did you succeed in nsdeps for composite modules
>> >> >with this patch only?
>> >> >
>> >> >I think the following is needed too:
>> >> >
>> >> >
>> >> >diff --git a/scripts/nsdeps b/scripts/nsdeps
>> >> >index dda6fbac016e..5a23ea616446 100644
>> >> >--- a/scripts/nsdeps
>> >> >+++ b/scripts/nsdeps
>> >> >@@ -31,9 +31,9 @@ generate_deps() {
>> >> >        local mod_file=`echo $@ | sed -e 's/\.ko/\.mod/'`
>> >> >        local ns_deps_file=`echo $@ | sed -e 's/\.ko/\.ns_deps/'`
>> >> >        if [ ! -f "$ns_deps_file" ]; then return; fi
>> >> >-       local mod_source_files=`cat $mod_file | sed -n 1p                      \
>> >> >+       local mod_source_files="`cat $mod_file | sed -n 1p
>> >> >         \
>> >> >                                              | sed -e 's/\.o/\.c/g'           \
>> >> >-                                             | sed "s|[^ ]* *|${srctree}/&|g"`
>> >> >+                                             | sed "s|[^ ]* *|${srctree}/&|g"`"
>> >> >        for ns in `cat $ns_deps_file`; do
>> >> >                echo "Adding namespace $ns to module $mod_name (if needed)."
>> >> >                generate_deps_for_ns $ns $mod_source_files
>> >> >
>> >> >
>> >> >Without this, a module that consists of two files
>> >> >will be expanded to:
>> >> >
>> >> >local mod_source_files=source1.c source2.c
>> >>
>> >> Yes, I was able to have nsdeps work for composite modules with just my
>> >> patch. Without this patch applied, the script produces the following
>> >> expansion of the generate_deps_for_ns call, (I just added a test
>> >> namespace MODULE):
>> >>
>> >> Adding namespace MODULE to module fs/nfs/nfs.ko.
>> >> + generate_deps_for_ns MODULE /tmp/ppyu/linux/fs/nfs/client.c /tmp/ppyu/linux/fs/nfs/dir.c /tmp/ppyu/linux/fs/nfs/file.c /tmp/ppyu/linux/fs/nfs/getroot.c /tmp/ppyu/linux/fs/nfs/inode.c /tmp/ppyu/linux/fs/nfs/super.c /tmp/ppyu/linux/fs/nfs/io.c /tmp/ppyu/linux/fs/nfs/direct.c /tmp/ppyu/linux/fs/nfs/pagelist.c /tmp/ppyu/linux/fs/nfs/read.c /tmp/ppyu/linux/fs/nfs/symlink.c /tmp/ppyu/linux/fs/nfs/unlink.c /tmp/ppyu/linux/fs/nfs/write.c /tmp/ppyu/linux/fs/nfs/namespace.c /tmp/ppyu/linux/fs/nfs/mount_clnt.c /tmp/ppyu/linux/fs/nfs/nfstrace.c /tmp/ppyu/linux/fs/nfs/export.c /tmp/ppyu/linux/fs/nfs/sysfs.c /tmp/ppyu/linux/fs/nfs/sysctl.c /tmp/ppyu/linux/fs/nfs/fscache.c /tmp/ppyu/linux/fs/nfs/fscache-index.c
>> >> + /usr/bin/spatch --very-quiet --in-place --sp-file /tmp/ppyu/linux/scripts/coccinelle/misc/add_namespace.cocci -D ns=MODULE /tmp/ppyu/linux/fs/nfs/client.c
>> >>
>> >> So only the first file got included in the spatch invocation. But the
>> >> spatch call gets fixed with all the files when quotes are added in the
>> >> call to generate_deps_for_ns.
>> >>
>> >> But we need to include your change anyway, to make the script more
>> >> robust.
>> >
>> >Hmm.
>> >With this patch only, I see "bad variable name" error.
>> >
>> >
>> >
>> >masahiro@grover:~/ref/linux$ make -j8  nsdeps
>> >  DESCEND  objtool
>> >  CALL    scripts/atomic/check-atomics.sh
>> >  CALL    scripts/checksyscalls.sh
>> >  CHK     include/generated/compile.h
>> >  Building modules, stage 2.
>> >  MODPOST 20 modules
>> >WARNING: module nfs uses symbol foo from namespace USB_STORAGE, but
>> >does not import it.
>> >  Building modules, stage 2.
>> >  MODPOST 20 modules
>> >./scripts/nsdeps: 34: local: ./fs/nfs/dir.c: bad variable name
>> >make: *** [Makefile;1689: nsdeps] Error 2
>>
>> Hm, I was having trouble reproducing this until I changed the shell to
>> dash, /bin/sh is a symlink to bash on my system, that might explain
>> slightly different behavior. In any case, we should add quotes in both
>> places.
>>
>> >> It would probably prevent more shell script related bugs in
>> >> the future (Like [1]). I can respin this patch only while the other
>> >> ones are superceded by your patchset.
>> >>
>> >> [1] https://unix.stackexchange.com/a/131767
>> >
>> >Anyway.
>> >
>> >Is this patch aiming for v5.4 (i.e. fixes) or v5.5-rc1 ?
>>
>> I am hoping for fixes, we should try to get all the small bugs out of
>> nsdeps by 5.4 if we can..
>>
>> >If you touch the mod_source_files line,
>> >we will have a conflict because
>> >https://patchwork.kernel.org/patch/11217839/
>> >is touching the same line.
>> >
>> >How should we organize the patch order?
>>
>> Would you like to fold these changes into your nsdeps improvements
>> patchset? Since it's a pretty trivial change.
>>
>> Thanks!
>>
>>
>
>My change set is quite big, so I
>am planning to send it for v5.5-rc1.

OK, sounds good.

>If you want to fix nsdeps for composite modules earlier,
>please apply this patch to your tree
>and send another pull request.

I plan to send this in for -rc7, since it's a minor fix.

For the conflict, if these patches are not pushed anywhere yet (at
least I did not see them on the kbuild for-next branch yet), perhaps
you could rebase on top of -rc7 and put your patchset on top?

Thanks,

Jessica
