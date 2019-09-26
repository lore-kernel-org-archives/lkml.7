Return-Path: <SRS0=EKka=XV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A0A7FC432C2
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Sep 2019 01:19:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7B57E21655
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Sep 2019 01:19:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732382AbfIZBTM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 25 Sep 2019 21:19:12 -0400
Received: from szxga06-in.huawei.com ([45.249.212.32]:35294 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729235AbfIZBTM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Sep 2019 21:19:12 -0400
Received: from DGGEMS411-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id C03CDD88E5095866CD56;
        Thu, 26 Sep 2019 09:19:10 +0800 (CST)
Received: from [127.0.0.1] (10.177.251.225) by DGGEMS411-HUB.china.huawei.com
 (10.3.19.211) with Microsoft SMTP Server id 14.3.439.0; Thu, 26 Sep 2019
 09:19:06 +0800
Subject: Re: [PATCH] toplevel: Move ipc/ to kernel/ipc/: don't check the ipc
 dir
To:     Joe Perches <joe@perches.com>, <apw@canonical.com>,
        <mingo@kernel.org>, Andrew Morton <akpm@linux-foundation.org>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <04acff22-430b-9ed7-f700-b644c0632cdd@huawei.com>
 <e6d097c176d4a4bb4fe5664fe4199f3025d22182.camel@perches.com>
From:   Yunfeng Ye <yeyunfeng@huawei.com>
Message-ID: <d2a9a602-8f7f-f4fd-e390-45ec381ebb1d@huawei.com>
Date:   Thu, 26 Sep 2019 09:18:57 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <e6d097c176d4a4bb4fe5664fe4199f3025d22182.camel@perches.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.177.251.225]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2019/9/26 0:32, Joe Perches wrote:
> On Wed, 2019-09-25 at 20:37 +0800, Yunfeng Ye wrote:
>> After the commit 76128326f97c ("toplevel: Move ipc/ to kernel/ipc/: move
>> the files"), we met some error messages:
>>
>>   ./scripts/checkpatch.pl:
>>   "Must be run from the top-level dir. of a kernel tree"
>>
>>   ./scripts/get_maintainer.pl:
>>   "The current directory does not appear to be a linux kernel source tree.
>>
>> Don't check the ipc dir in checkpatch.pl and get_maintainer.pl.
> 
> Thanks.
> 
> Maybe the commit subject could use "scripts:"
> or something similar and not "toplevel:".
>The purpose of subject "toplevel" is to maintain consistency with previous
modification patches. ok, I will modify it, thanks.

> Trivially, it one day it'd be good to use the
> same routine and output message too.
> 
>> Signed-off-by: Yunfeng Ye <yeyunfeng@huawei.com>
>> ---
>>  scripts/checkpatch.pl     | 2 +-
>>  scripts/get_maintainer.pl | 1 -
>>  2 files changed, 1 insertion(+), 2 deletions(-)
>>
>> diff --git a/scripts/checkpatch.pl b/scripts/checkpatch.pl
>> index 93a7edf..6117d0e 100755
>> --- a/scripts/checkpatch.pl
>> +++ b/scripts/checkpatch.pl
>> @@ -1097,7 +1097,7 @@ sub top_of_kernel_tree {
>>  	my @tree_check = (
>>  		"COPYING", "CREDITS", "Kbuild", "MAINTAINERS", "Makefile",
>>  		"README", "Documentation", "arch", "include", "drivers",
>> -		"fs", "init", "ipc", "kernel", "lib", "scripts",
>> +		"fs", "init", "kernel", "lib", "scripts",
>>  	);
>>
>>  	foreach my $check (@tree_check) {
>> diff --git a/scripts/get_maintainer.pl b/scripts/get_maintainer.pl
>> index 5ef5921..2e42aeb 100755
>> --- a/scripts/get_maintainer.pl
>> +++ b/scripts/get_maintainer.pl
>> @@ -1109,7 +1109,6 @@ sub top_of_kernel_tree {
>>  	&& (-d "${lk_path}drivers")
>>  	&& (-d "${lk_path}fs")
>>  	&& (-d "${lk_path}init")
>> -	&& (-d "${lk_path}ipc")
>>  	&& (-d "${lk_path}kernel")
>>  	&& (-d "${lk_path}lib")
>>  	&& (-d "${lk_path}scripts")) {
> 
> 
> .
> 

