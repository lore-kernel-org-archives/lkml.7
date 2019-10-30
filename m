Return-Path: <SRS0=iR9I=YX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9EC1FCA9EC5
	for <linux-kernel@archiver.kernel.org>; Wed, 30 Oct 2019 16:17:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6B735205C9
	for <linux-kernel@archiver.kernel.org>; Wed, 30 Oct 2019 16:17:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1572452256;
	bh=hPxURatBxOMiOCta6yGik10T9f5u9kgS0G/+XRzfLhU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=f2fhDFrUaz3dyXegy6RG10UInmg8dVMqlHi/iOkk8BCLP2Ia5n+cH4Xb7/pyKMyrl
	 NhtOgVXV2tt9cTffu+IDOM+OFeRYjaD1D6OYQ4dU9bUVOXIss7WW7NHl3MhTqkUYTs
	 MG08t/K6LVIEsSo3NIKiSZjVOqanEBBun3GOdtqY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727394AbfJ3QRf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 30 Oct 2019 12:17:35 -0400
Received: from mail.kernel.org ([198.145.29.99]:39938 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727330AbfJ3QRe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Oct 2019 12:17:34 -0400
Received: from linux-8ccs (unknown [92.117.144.115])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 29B4D205C9;
        Wed, 30 Oct 2019 16:17:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1572452253;
        bh=hPxURatBxOMiOCta6yGik10T9f5u9kgS0G/+XRzfLhU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=OOTtj8+FKdg3u6hrgqQmpNIxWoPuPHziziIwXT6SO1EGDdRFVhdLIoalKu0UshqdN
         gZzc6LVtBNiDfznUvUeJ30SjMBeCBvKNurUZYQTBB0Sr2ZgtA6S64tAWz/+KH3jBnS
         I5J8zHAgbNs4hjcFYwVdDmyfATyai6w4WyZECt1U=
Date:   Wed, 30 Oct 2019 17:17:28 +0100
From:   Jessica Yu <jeyu@kernel.org>
To:     Masahiro Yamada <yamada.masahiro@socionext.com>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Matthias Maennich <maennich@google.com>
Subject: Re: [PATCH 4/4] scripts/nsdeps: make sure to pass all module source
 files to spatch
Message-ID: <20191030161726.GA13413@linux-8ccs>
References: <20191028151427.31612-1-jeyu@kernel.org>
 <20191028151427.31612-4-jeyu@kernel.org>
 <CAK7LNAQ8WDQ3PX8iwQNj5eNQADFMnKNVo3+uC8dt3rCPWK8a-w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <CAK7LNAQ8WDQ3PX8iwQNj5eNQADFMnKNVo3+uC8dt3rCPWK8a-w@mail.gmail.com>
X-OS:   Linux linux-8ccs 4.12.14-lp150.12.28-default x86_64
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

+++ Masahiro Yamada [29/10/19 21:57 +0900]:
>On Tue, Oct 29, 2019 at 12:14 AM Jessica Yu <jeyu@kernel.org> wrote:
>>
>> The nsdeps script passes a list of the module source files to
>> generate_deps_for_ns() as a space delimited string named $mod_source_files,
>> which then passes it to spatch. But since $mod_source_files is not encased
>> in quotes, each source file in that string is treated as a separate shell
>> function argument (as $2, $3, $4, etc.).  However, the spatch invocation
>> only refers to $2, so only the first file out of $mod_source_files is
>> processed by spatch.
>>
>> This causes problems (namely, the MODULE_IMPORT_NS() statement doesn't
>> get inserted) when a module is composed of many source files and the
>> "main" module file containing the MODULE_LICENSE() statement is not the
>> first file listed in $mod_source_files. Fix this by encasing
>> $mod_source_files in quotes so that the entirety of the string is
>> treated as a single argument and can be referred to as $2.
>>
>> Signed-off-by: Jessica Yu <jeyu@kernel.org>
>> ---
>>  scripts/nsdeps | 2 +-
>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/scripts/nsdeps b/scripts/nsdeps
>> index 9ddcd5cb96b1..5055b059a81b 100644
>> --- a/scripts/nsdeps
>> +++ b/scripts/nsdeps
>> @@ -36,7 +36,7 @@ generate_deps() {
>>                                               | sed -E "s%(^|\s)([^/][^ ]*)%\1$srctree/\2%g"`
>>         for ns in `cat $ns_deps_file`; do
>>                 echo "Adding namespace $ns to module $mod_name (if needed)."
>> -               generate_deps_for_ns $ns $mod_source_files
>> +               generate_deps_for_ns $ns "$mod_source_files"
>>                 # sort the imports
>>                 for source_file in $mod_source_files; do
>>                         sed '/MODULE_IMPORT_NS/Q' $source_file > ${source_file}.tmp
>
>I think this change is correct, but
>did you succeed in nsdeps for composite modules
>with this patch only?
>
>I think the following is needed too:
>
>
>diff --git a/scripts/nsdeps b/scripts/nsdeps
>index dda6fbac016e..5a23ea616446 100644
>--- a/scripts/nsdeps
>+++ b/scripts/nsdeps
>@@ -31,9 +31,9 @@ generate_deps() {
>        local mod_file=`echo $@ | sed -e 's/\.ko/\.mod/'`
>        local ns_deps_file=`echo $@ | sed -e 's/\.ko/\.ns_deps/'`
>        if [ ! -f "$ns_deps_file" ]; then return; fi
>-       local mod_source_files=`cat $mod_file | sed -n 1p                      \
>+       local mod_source_files="`cat $mod_file | sed -n 1p
>         \
>                                              | sed -e 's/\.o/\.c/g'           \
>-                                             | sed "s|[^ ]* *|${srctree}/&|g"`
>+                                             | sed "s|[^ ]* *|${srctree}/&|g"`"
>        for ns in `cat $ns_deps_file`; do
>                echo "Adding namespace $ns to module $mod_name (if needed)."
>                generate_deps_for_ns $ns $mod_source_files
>
>
>Without this, a module that consists of two files
>will be expanded to:
>
>local mod_source_files=source1.c source2.c

Yes, I was able to have nsdeps work for composite modules with just my
patch. Without this patch applied, the script produces the following
expansion of the generate_deps_for_ns call, (I just added a test
namespace MODULE):

Adding namespace MODULE to module fs/nfs/nfs.ko.
+ generate_deps_for_ns MODULE /tmp/ppyu/linux/fs/nfs/client.c /tmp/ppyu/linux/fs/nfs/dir.c /tmp/ppyu/linux/fs/nfs/file.c /tmp/ppyu/linux/fs/nfs/getroot.c /tmp/ppyu/linux/fs/nfs/inode.c /tmp/ppyu/linux/fs/nfs/super.c /tmp/ppyu/linux/fs/nfs/io.c /tmp/ppyu/linux/fs/nfs/direct.c /tmp/ppyu/linux/fs/nfs/pagelist.c /tmp/ppyu/linux/fs/nfs/read.c /tmp/ppyu/linux/fs/nfs/symlink.c /tmp/ppyu/linux/fs/nfs/unlink.c /tmp/ppyu/linux/fs/nfs/write.c /tmp/ppyu/linux/fs/nfs/namespace.c /tmp/ppyu/linux/fs/nfs/mount_clnt.c /tmp/ppyu/linux/fs/nfs/nfstrace.c /tmp/ppyu/linux/fs/nfs/export.c /tmp/ppyu/linux/fs/nfs/sysfs.c /tmp/ppyu/linux/fs/nfs/sysctl.c /tmp/ppyu/linux/fs/nfs/fscache.c /tmp/ppyu/linux/fs/nfs/fscache-index.c
+ /usr/bin/spatch --very-quiet --in-place --sp-file /tmp/ppyu/linux/scripts/coccinelle/misc/add_namespace.cocci -D ns=MODULE /tmp/ppyu/linux/fs/nfs/client.c

So only the first file got included in the spatch invocation. But the
spatch call gets fixed with all the files when quotes are added in the
call to generate_deps_for_ns.

But we need to include your change anyway, to make the script more
robust. It would probably prevent more shell script related bugs in
the future (Like [1]). I can respin this patch only while the other
ones are superceded by your patchset.

[1] https://unix.stackexchange.com/a/131767
