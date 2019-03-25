Return-Path: <SRS0=yZjE=R4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C4BCAC43381
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Mar 2019 07:07:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 962932085A
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Mar 2019 07:07:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729800AbfCYHH4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Mar 2019 03:07:56 -0400
Received: from relay5-d.mail.gandi.net ([217.70.183.197]:58053 "EHLO
        relay5-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729230AbfCYHH4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Mar 2019 03:07:56 -0400
X-Originating-IP: 79.86.19.127
Received: from [192.168.0.11] (127.19.86.79.rev.sfr.net [79.86.19.127])
        (Authenticated sender: alex@ghiti.fr)
        by relay5-d.mail.gandi.net (Postfix) with ESMTPSA id 0DADF1C0009;
        Mon, 25 Mar 2019 07:07:52 +0000 (UTC)
From:   Alex Ghiti <alex@ghiti.fr>
To:     Andy Whitcroft <apw@canonical.com>, Joe Perches <joe@perches.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3] scripts: checkpatch: Check multiple blank lines when
 deleting code
References: <20190306195324.11634-1-alex@ghiti.fr>
 <f2f39283-677f-e617-5edb-f55624ac21e2@ghiti.fr>
Message-ID: <43f07161-8405-c934-ee84-3eb1f99c0b9b@ghiti.fr>
Date:   Mon, 25 Mar 2019 03:07:52 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <f2f39283-677f-e617-5edb-f55624ac21e2@ghiti.fr>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 3/17/19 11:49 AM, Alex Ghiti wrote:
> On 3/6/19 2:53 PM, Alexandre Ghiti wrote:
>> By matching only current line starting with '+', we miss the case
>> when deleting code makes consecutive blank lines appear: this patch
>> then makes it possible to detect this case by also matching current
>> line starting with ' ', which is an already existing blank line.
>>
>> Signed-off-by: Alexandre Ghiti <alex@ghiti.fr>
>> ---
>>
>> Changes in v3 as suggested by Joe Perches:
>>     - Do not try to fix this case
>>     - Make this test separate from the insertion one so that warning
>>       is more explicit
>>
>> Changes in v2:
>>     - Fix the --fix option
>>
>>   scripts/checkpatch.pl | 12 +++++++++++-
>>   1 file changed, 11 insertions(+), 1 deletion(-)
>>
>> diff --git a/scripts/checkpatch.pl b/scripts/checkpatch.pl
>> index b737ca9d7204..c0728cff292f 100755
>> --- a/scripts/checkpatch.pl
>> +++ b/scripts/checkpatch.pl
>> @@ -3296,7 +3296,7 @@ sub process {
>>               }
>>           }
>>   -# check for multiple consecutive blank lines
>> +# check for multiple consecutive blank lines caused by blank line 
>> insertion
>>           if ($prevline =~ /^[\+ ]\s*$/ &&
>>               $line =~ /^\+\s*$/ &&
>>               $last_blank_line != ($linenr - 1)) {
>> @@ -3309,6 +3309,16 @@ sub process {
>>               $last_blank_line = $linenr;
>>           }
>>   +# check for multiple consecutive blank lines caused by code deletion
>> +        if ($prevline =~ /^[\+ ]\s*$/ &&
>> +            $line =~ /^ \s*$/ &&
>> +            $last_blank_line != ($linenr - 1)) {
>> +            CHK("LINE_SPACING",
>> +                "Avoid deleting lines that create consecutive blank 
>> lines\n" . $hereprev);
>> +
>> +            $last_blank_line = $linenr;
>> +        }
>> +
>>   # check for missing blank lines after declarations
>>           if ($sline =~ /^\+\s+\S/ &&            #Not at char 1
>>               # actual declarations
>
>
> Hi Joe,
>
> Can I do something more this patch ?
>
> Thanks,
>
> Alex
>

Hi,

Sorry for insisting, but do you consider this patch for inclusion ?

Thanks,

Alex
