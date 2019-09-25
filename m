Return-Path: <SRS0=wETr=XU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3E557C432C2
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Sep 2019 16:32:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0814621D7B
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Sep 2019 16:32:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388921AbfIYQcn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 25 Sep 2019 12:32:43 -0400
Received: from smtprelay0118.hostedemail.com ([216.40.44.118]:56453 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S2387859AbfIYQcn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Sep 2019 12:32:43 -0400
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay02.hostedemail.com (Postfix) with ESMTP id 6901140CD;
        Wed, 25 Sep 2019 16:32:41 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-HE-Tag: slip39_1708dbe400e22
X-Filterd-Recvd-Size: 2685
Received: from XPS-9350 (bb220-255-137-117.singnet.com.sg [220.255.137.117])
        (Authenticated sender: joe@perches.com)
        by omf16.hostedemail.com (Postfix) with ESMTPA;
        Wed, 25 Sep 2019 16:32:37 +0000 (UTC)
Message-ID: <e6d097c176d4a4bb4fe5664fe4199f3025d22182.camel@perches.com>
Subject: Re: [PATCH] toplevel: Move ipc/ to kernel/ipc/: don't check the ipc
 dir
From:   Joe Perches <joe@perches.com>
To:     Yunfeng Ye <yeyunfeng@huawei.com>, apw@canonical.com,
        mingo@kernel.org, Andrew Morton <akpm@linux-foundation.org>
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Date:   Wed, 25 Sep 2019 09:32:33 -0700
In-Reply-To: <04acff22-430b-9ed7-f700-b644c0632cdd@huawei.com>
References: <04acff22-430b-9ed7-f700-b644c0632cdd@huawei.com>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.32.1-2 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2019-09-25 at 20:37 +0800, Yunfeng Ye wrote:
> After the commit 76128326f97c ("toplevel: Move ipc/ to kernel/ipc/: move
> the files"), we met some error messages:
> 
>   ./scripts/checkpatch.pl:
>   "Must be run from the top-level dir. of a kernel tree"
> 
>   ./scripts/get_maintainer.pl:
>   "The current directory does not appear to be a linux kernel source tree.
> 
> Don't check the ipc dir in checkpatch.pl and get_maintainer.pl.

Thanks.

Maybe the commit subject could use "scripts:"
or something similar and not "toplevel:".

Trivially, it one day it'd be good to use the
same routine and output message too.

> Signed-off-by: Yunfeng Ye <yeyunfeng@huawei.com>
> ---
>  scripts/checkpatch.pl     | 2 +-
>  scripts/get_maintainer.pl | 1 -
>  2 files changed, 1 insertion(+), 2 deletions(-)
> 
> diff --git a/scripts/checkpatch.pl b/scripts/checkpatch.pl
> index 93a7edf..6117d0e 100755
> --- a/scripts/checkpatch.pl
> +++ b/scripts/checkpatch.pl
> @@ -1097,7 +1097,7 @@ sub top_of_kernel_tree {
>  	my @tree_check = (
>  		"COPYING", "CREDITS", "Kbuild", "MAINTAINERS", "Makefile",
>  		"README", "Documentation", "arch", "include", "drivers",
> -		"fs", "init", "ipc", "kernel", "lib", "scripts",
> +		"fs", "init", "kernel", "lib", "scripts",
>  	);
> 
>  	foreach my $check (@tree_check) {
> diff --git a/scripts/get_maintainer.pl b/scripts/get_maintainer.pl
> index 5ef5921..2e42aeb 100755
> --- a/scripts/get_maintainer.pl
> +++ b/scripts/get_maintainer.pl
> @@ -1109,7 +1109,6 @@ sub top_of_kernel_tree {
>  	&& (-d "${lk_path}drivers")
>  	&& (-d "${lk_path}fs")
>  	&& (-d "${lk_path}init")
> -	&& (-d "${lk_path}ipc")
>  	&& (-d "${lk_path}kernel")
>  	&& (-d "${lk_path}lib")
>  	&& (-d "${lk_path}scripts")) {

