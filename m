Return-Path: <SRS0=OfNL=RF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4875EC43381
	for <linux-kernel@archiver.kernel.org>; Sat,  2 Mar 2019 08:10:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 137FF20838
	for <linux-kernel@archiver.kernel.org>; Sat,  2 Mar 2019 08:10:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726319AbfCBIKB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 2 Mar 2019 03:10:01 -0500
Received: from relay8-d.mail.gandi.net ([217.70.183.201]:60973 "EHLO
        relay8-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725900AbfCBIKA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 2 Mar 2019 03:10:00 -0500
X-Originating-IP: 77.136.197.76
Received: from [192.168.43.237] (76.197.136.77.rev.sfr.net [77.136.197.76])
        (Authenticated sender: alex@ghiti.fr)
        by relay8-d.mail.gandi.net (Postfix) with ESMTPSA id 7051F1BF206;
        Sat,  2 Mar 2019 08:09:57 +0000 (UTC)
From:   Alex Ghiti <alex@ghiti.fr>
To:     Joe Perches <joe@perches.com>
Cc:     Andy Whitcroft <apw@canonical.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] scripts: checkpatch: Check multiple blank lines when
 deleting code
References: <20190228181531.18530-1-alex@ghiti.fr>
 <29a040d31a84dd24618096e2776a66c23880f2d7.camel@perches.com>
Message-ID: <f738d4c2-35ce-5e96-f6a3-8db5e39a178b@ghiti.fr>
Date:   Sat, 2 Mar 2019 03:09:56 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <29a040d31a84dd24618096e2776a66c23880f2d7.camel@perches.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 3/1/19 2:31 PM, Joe Perches wrote:
> On Thu, 2019-02-28 at 13:15 -0500, Alexandre Ghiti wrote:
>> By matching only current line starting with '+', we miss the case
>> when deleting code makes consecutive blank lines appear: this patch
>> then makes it possible to detect this case by also matching current
>> line starting with ' ', which is an already existing blank line.
>>
>> On the following example, checkpatch --subjective now complains about
>> multiple blank lines:
>>
>>   static long hugepage_subpool_get_pages(struct hugepage_subpool *spool,
>>   {
>>   	long ret = delta;
>>
>> -	if (!spool)
>> -		return ret;
>>
>>   	spin_lock(&spool->lock);
>>
>> Signed-off-by: Alexandre Ghiti <alex@ghiti.fr>
>> ---
>>   scripts/checkpatch.pl | 2 +-
>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/scripts/checkpatch.pl b/scripts/checkpatch.pl
> []

I do not understand what you mean here, can you clarify for v2 please ?

Thanks !

>> @@ -3298,7 +3298,7 @@ sub process {
>>   
>>   # check for multiple consecutive blank lines
>>   		if ($prevline =~ /^[\+ ]\s*$/ &&
>> -		    $line =~ /^\+\s*$/ &&
>> +		    $line =~ /^[\+ ]\s*$/ &&
>>   		    $last_blank_line != ($linenr - 1)) {
>>   			if (CHK("LINE_SPACING",
>>   				"Please don't use multiple blank lines\n" . $hereprev) &&
> I believe this screws up the --fix option just below this
> if the line does not start with +
>
>

Totally, you're right, thanks.

>
>
