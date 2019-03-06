Return-Path: <SRS0=vY9Y=RJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BF87DC43381
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Mar 2019 06:50:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8598E20652
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Mar 2019 06:50:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729077AbfCFGt7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 6 Mar 2019 01:49:59 -0500
Received: from relay1-d.mail.gandi.net ([217.70.183.193]:37925 "EHLO
        relay1-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725601AbfCFGt7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Mar 2019 01:49:59 -0500
X-Originating-IP: 79.86.19.127
Received: from [192.168.0.11] (127.19.86.79.rev.sfr.net [79.86.19.127])
        (Authenticated sender: alex@ghiti.fr)
        by relay1-d.mail.gandi.net (Postfix) with ESMTPSA id D9765240005;
        Wed,  6 Mar 2019 06:49:56 +0000 (UTC)
From:   Alex Ghiti <alex@ghiti.fr>
To:     Joe Perches <joe@perches.com>
Cc:     Andy Whitcroft <apw@canonical.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] scripts: checkpatch: Check multiple blank lines when
 deleting code
References: <20190305071251.28427-1-alex@ghiti.fr>
 <266fda3bba4d9d73dd6268d2fd332c4bfb0ab4a2.camel@perches.com>
Message-ID: <7ce1b638-7bc3-f82f-21ac-34519e698114@ghiti.fr>
Date:   Wed, 6 Mar 2019 01:49:56 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.3
MIME-Version: 1.0
In-Reply-To: <266fda3bba4d9d73dd6268d2fd332c4bfb0ab4a2.camel@perches.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 3/5/19 6:17 PM, Joe Perches wrote:
> On Tue, 2019-03-05 at 02:12 -0500, Alexandre Ghiti wrote:
>> By matching only current line starting with '+', we miss the case
>> when deleting code makes consecutive blank lines appear: this patch
>> then makes it possible to detect this case by also matching current
>> line starting with ' ', which is an already existing blank line.
> []
>> diff --git a/scripts/checkpatch.pl b/scripts/checkpatch.pl
> []
>> @@ -2081,10 +2081,15 @@ sub fix_inserted_deleted_lines {
>>   		}
>>   
>>   		while (defined($inserted) && ${$inserted}{'LINENR'} == $old_linenr) {
>> +			my $len = 1;
>>   			push(@lines, ${$inserted}{'LINE'});
>> +			# Do not increment the length when inserting a deletion line.
>> +			if (${$inserted}{'LINE'} =~ /^\-/) {
>> +				$len = 0;
>> +			}
>>   			$inserted = @{$insertedRef}[$next_insert++];
>>   			$new_linenr++;
>> -			fixup_current_range(\$lines[$range_last_linenr], $delta_offset++, 1);
>> +			fixup_current_range(\$lines[$range_last_linenr], $delta_offset++, $len);
> I think this is confusing and unnecessary.
> Using --fix can not delete context lines from a patch.

Ok, I was expecting your comment on that, I agree with you.
So I'll get rid of the possibility to fix the deletion case, this will
only be a warning.

>>   		}
>>   
>>   		if ($save_line) {
>> @@ -3298,12 +3303,18 @@ sub process {
>>   
>>   # check for multiple consecutive blank lines
>>   		if ($prevline =~ /^[\+ ]\s*$/ &&
>> -		    $line =~ /^\+\s*$/ &&
>> +		    $line =~ /^[\+ ]\s*$/ &&
>>   		    $last_blank_line != ($linenr - 1)) {
>>   			if (CHK("LINE_SPACING",
>>   				"Please don't use multiple blank lines\n" . $hereprev) &&
>>   			    $fix) {
> It's simpler to add a check that $line starts /^\+/ before $fix
>
> Maybe it'd be better to have a separate test for this to make
> the output message clearer too.
>
> Something like
> 	"Avoid deleting lines that create consecutive blank lines"

Ok,

Thanks for your comments,

>>   				fix_delete_line($fixlinenr, $rawline);
>> +				if ($line =~ /^ \s*$/) {
>> +					# If the line is not an inserted blank line, the multiple
>> +					# consecutive blank lines are caused by deletion: fix this
>> +					# by replacing the blank line with a deletion line.
>> +					fix_insert_line($fixlinenr, "\-");
>> +				}
>>   			}
>>   
>>   			$last_blank_line = $linenr;
