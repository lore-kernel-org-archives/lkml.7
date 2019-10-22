Return-Path: <SRS0=qxzQ=YP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A4AF9CA9EA0
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Oct 2019 10:01:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 772DF21872
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Oct 2019 10:01:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1571738461;
	bh=AdQe0gGo14eIDSVM0wSBk8e4bCtGfDEpUhLfTezYUjU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=u07Trreh8HXSFHNO4ik0OKGcJNi6Itv3McwBFbAqIM5xg+nAPg+HbUV4EyCDKNybK
	 rcePN+V7h9hSaIy0XLi8bzyowwVl+1dp18Q9ZEdXpZL59I/6VC237Q6e/poUy/NxzA
	 mBakeWNoqWkiZQ+7L39U+ME+RNkvZEI2lemKInKQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731709AbfJVKBA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 22 Oct 2019 06:01:00 -0400
Received: from mail.kernel.org ([198.145.29.99]:39022 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731439AbfJVKBA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Oct 2019 06:01:00 -0400
Received: from linux-8ccs (ip5f5ade81.dynamic.kabel-deutschland.de [95.90.222.129])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3AE702064B;
        Tue, 22 Oct 2019 10:00:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1571738459;
        bh=AdQe0gGo14eIDSVM0wSBk8e4bCtGfDEpUhLfTezYUjU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Ava/VTxtIzD5abhD0wTUJJaiUHfh+Qdp9L5L6+fJhn6DePfM9rVLR6oGHT5mdzbnh
         BUMcTrWFnZfbT/YIbMf3w2rOmA/V+osTSL2h47LU3g4nGdNXFmPO8mj6AJyL+rwZ3O
         fvwMz8LkkK/Jyqk+UN5xsHhvwWwF/GgTDe74fo9s=
Date:   Tue, 22 Oct 2019 12:00:49 +0200
From:   Jessica Yu <jeyu@kernel.org>
To:     Masahiro Yamada <yamada.masahiro@socionext.com>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Matthias Maennich <maennich@google.com>
Subject: Re: [PATCH v2] scripts/nsdeps: use alternative sed delimiter
Message-ID: <20191022100049.GA21299@linux-8ccs>
References: <20191021145137.31672-1-jeyu@kernel.org>
 <20191021160419.28270-1-jeyu@kernel.org>
 <CAK7LNASyGSVNoKDqbtJYs+s-PRz3cqfet779M+PEWoAFu4e2TA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <CAK7LNASyGSVNoKDqbtJYs+s-PRz3cqfet779M+PEWoAFu4e2TA@mail.gmail.com>
X-OS:   Linux linux-8ccs 4.12.14-lp150.12.28-default x86_64
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

+++ Masahiro Yamada [22/10/19 13:37 +0900]:
>On Tue, Oct 22, 2019 at 1:05 AM Jessica Yu <jeyu@kernel.org> wrote:
>>
>> When doing an out of tree build with O=, the nsdeps script constructs
>> the absolute pathname of the module source file so that it can insert
>> MODULE_IMPORT_NS statements in the right place. However, ${srctree}
>> contains an unescaped path to the source tree, which, when used in a sed
>> substitution, makes sed complain:
>>
>> ++ sed 's/[^ ]* *//home/jeyu/jeyu-linux\/&/g'
>> sed: -e expression #1, char 12: unknown option to `s'
>>
>> The sed substitution command 's' ends prematurely with the forward
>> slashes in the pathname, and sed errors out when it encounters the 'h',
>> which is an invalid sed substitution option. To avoid escaping forward
>> slashes in ${srctree}, we can use '|' as an alternative delimiter for
>> sed to avoid this error.
>>
>> Signed-off-by: Jessica Yu <jeyu@kernel.org>
>> ---
>>
>> This is an alternative to my first patch here:
>>
>>   http://lore.kernel.org/r/20191021145137.31672-1-jeyu@kernel.org
>>
>> Matthias suggested using an alternative sed delimiter instead to avoid the
>> ugly/unreadable ${srctree//\//\\\/} substitution.
>>
>>  scripts/nsdeps | 2 +-
>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/scripts/nsdeps b/scripts/nsdeps
>> index 3754dac13b31..63da30a33422 100644
>> --- a/scripts/nsdeps
>> +++ b/scripts/nsdeps
>> @@ -33,7 +33,7 @@ generate_deps() {
>>         if [ ! -f "$ns_deps_file" ]; then return; fi
>>         local mod_source_files=`cat $mod_file | sed -n 1p                      \
>>                                               | sed -e 's/\.o/\.c/g'           \
>> -                                             | sed "s/[^ ]* */${srctree}\/&/g"`
>> +                                             | sed "s|[^ ]* *|${srctree}\/&|g"`
>
>
>You no longer need to escape the '/'.
>
>s|[^ ]* *|${srctree}/&|g
>
>is enough.

Ah yeah, I missed that. Thanks for catching that!

