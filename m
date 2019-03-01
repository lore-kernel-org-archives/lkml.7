Return-Path: <SRS0=6SCO=RE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8478EC43381
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Mar 2019 01:32:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 49FAF2085A
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Mar 2019 01:32:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VIJYAh6v"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733261AbfCABch (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Feb 2019 20:32:37 -0500
Received: from mail-pf1-f193.google.com ([209.85.210.193]:44898 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725896AbfCABch (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Feb 2019 20:32:37 -0500
Received: by mail-pf1-f193.google.com with SMTP id a3so10584331pff.11;
        Thu, 28 Feb 2019 17:32:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=fGlbx7N309avKzRv2g+xVb30ZDH61OHN1bu7L6jNwgc=;
        b=VIJYAh6vqvGiZWCCtT0j1nCFHYDgyKBj3dKE70yevnhP7pn2EocdyBz8vsO+RA/Dfk
         1h1k5WjtK7QMPZWbE/2p0xqx0iVHWj4WS4vWIb95GkmPkfxh4hfit/pnPh062YdAElFn
         n/eCAZG3TlbwzcfXKLC0K4rT8eLzWwVI5fFWOy1bCjpzSxgmKOV7mji5cSgPdN41ykfq
         HMKuxqsP89NudZ5RMDZ+Zvj0uYHHgcPq8hdr/6PINmk5wTfnbrJr8Y89ONg1PZQlSx5m
         mkTh9fm6/Jv2i4k8hU6mBeKipLZacyC4Ms1KLUVmWPvBc5Es7ArY+ZoKm2cr3WlUYwgS
         uDlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=fGlbx7N309avKzRv2g+xVb30ZDH61OHN1bu7L6jNwgc=;
        b=KRdWH0WvZR5MyOUQs230xTgIV60wWLa2BAk7ETfUDBbG78BamNIl/cGhJsWQn7rgcB
         7BAnzxuQPHwT0udOqtzt2guGHpmvous9qSjshSblBVJvsfh1jB+mMjnIXOcLLAwmVeT9
         5e0GKNf8uEZsAHsn+0CZuwx/859L51FtlOow5vxFb3jFdiwJ8QiO1U8Oy5OY361t8W8S
         rOiIjij3l6Psbehp4nFILstvxQBfe1Z/M2xT9RGe3H9w+Xtq/j/ArcUkYTLIAtjLzxYj
         w6F4NPkD/l9eMRzW2hm+1GmGuzcS8BWtQN/4aeBm/5n7GkOcs5sDv8mOBMEXHy09OBQr
         P4kA==
X-Gm-Message-State: APjAAAW5VRH9l+pbpFhpTgllKDT/QIF53FOn6JSvRD/srqv6+is2fCuX
        k3CjcHoAC1HdvXZKKKYICaA=
X-Google-Smtp-Source: APXvYqy8oMTWsVtTWakF5RV27sjB/MB/z3wvgr2AiJQ+9eE8DPR8LVpNBbkWO7HOWFzPgq18DRKfCA==
X-Received: by 2002:a65:6642:: with SMTP id z2mr2265262pgv.196.1551403956073;
        Thu, 28 Feb 2019 17:32:36 -0800 (PST)
Received: from ?IPv6:2001:df0:0:200c:b825:86af:2827:e844? ([2001:df0:0:200c:b825:86af:2827:e844])
        by smtp.gmail.com with ESMTPSA id m68sm53067576pfj.89.2019.02.28.17.32.32
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 28 Feb 2019 17:32:35 -0800 (PST)
Subject: Re: [PATCH v2] scsi: NCR5380: Mark expected switch fall-through
To:     Finn Thain <fthain@telegraphics.com.au>,
        "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Cc:     "James E.J. Bottomley" <jejb@linux.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org,
        Kees Cook <keescook@chromium.org>
References: <20190228202759.GA5883@embeddedor>
 <alpine.LNX.2.21.1903011143550.8@nippy.intranet>
From:   Michael Schmitz <schmitzmic@gmail.com>
Message-ID: <193a8c9d-2af4-150a-c9fc-3113bcc27e4d@gmail.com>
Date:   Fri, 1 Mar 2019 14:32:30 +1300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <alpine.LNX.2.21.1903011143550.8@nippy.intranet>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Finn's version looks fine to me.

Cheers,

     Michael

On 1/03/19 2:16 PM, Finn Thain wrote:
> On Thu, 28 Feb 2019, Gustavo A. R. Silva wrote:
>
>> In preparation to enabling -Wimplicit-fallthrough, mark switch
>> cases where we are expecting to fall through.
>>
> This switch case is already marked. So I think the patch description
> should state that this patch is actually a workaround for a gcc deficiency
> which prevents it from locating the marker.
>
>> This patch fixes the following warning:
>>
>> In file included from drivers/scsi/dmx3191d.c:48:
>> drivers/scsi/NCR5380.c: In function ?NCR5380_information_transfer?:
>> drivers/scsi/NCR5380.c:1933:9: warning: this statement may fall through [-Wimplicit-fallthrough=]
>>        if (!hostdata->connected)
>>           ^
>> drivers/scsi/NCR5380.c:1937:5: note: here
>>       default:
>>       ^~~~~~~
>>
>> Warning level 3 was used: -Wimplicit-fallthrough=3
>>
>> Notice that, in this particular case, the code comment is modified
>> in accordance with what GCC is expecting to find.
>>
>> This patch is part of the ongoing efforts to enable
>> -Wimplicit-fallthrough.
>>
>> Signed-off-by: Gustavo A. R. Silva <gustavo@embeddedor.com>
>> ---
>> Changes in v2:
>>   - Update commit log.
>>   - Move code comment after the default label and
>>     retain reason for fall-through in comment as
>>     requested by Michael Schmitz.
>>
>>   drivers/scsi/NCR5380.c | 9 ++++-----
>>   1 file changed, 4 insertions(+), 5 deletions(-)
>>
>> diff --git a/drivers/scsi/NCR5380.c b/drivers/scsi/NCR5380.c
>> index 01c23d27f290..985d1c053578 100644
>> --- a/drivers/scsi/NCR5380.c
>> +++ b/drivers/scsi/NCR5380.c
>> @@ -1933,13 +1933,12 @@ static void NCR5380_information_transfer(struct Scsi_Host *instance)
>>   					if (!hostdata->connected)
>>   						return;
>>   
>> -					/* Fall through to reject message */
>> -
>> +					/* Fall through - to reject message */
> This new hyphen is wrong and harms readability for humans.
>
> I did confirm that gcc can be appeased by the use of a hyphen but not by
> correct grammar such as "Fall through to reject message" or "Fall through.
> Reject message."
>
>> +				default:
>>   					/*
>> -					 * If we get something weird that we aren't expecting,
>> -					 * reject it.
>> +					 * If we get something weird that we
>> +					 * aren't expecting, reject it.
> This reformatting isn't relevant to this patch. The comments can be
> improved however (see below).
>
>>   					 */
>> -				default:
> Moving the 'default' keyword closer to the 'fall through' comment makes
> sense to me -- I could understand if gcc had simple, unambiguous rules for
> annotations.
>
> Do compilers and static analysers agree as to what a correctly annotated
> switch label should look like? If not, we would have to try to mangle code
> and comments in such a way that might satisfy all of the failings in all
> of the tools.
>
>>   					if (tmp == EXTENDED_MESSAGE)
>>   						scmd_printk(KERN_INFO, cmd,
>>   						            "rejecting unknown extended message code %02x, length %d\n",
>>
> Here's an alternative patch, which has the virtue that a simple heuristic
> will work. This patch does not require that other static analysis tools
> will follow gcc's weird rules about hyphens. (I assume they don't but I
> didn't check.)
>
> diff --git a/drivers/scsi/NCR5380.c b/drivers/scsi/NCR5380.c
> index 7fed9bb72784..fe0535affc14 100644
> --- a/drivers/scsi/NCR5380.c
> +++ b/drivers/scsi/NCR5380.c
> @@ -1932,13 +1932,13 @@ static void NCR5380_information_transfer(struct Scsi_Host *instance)
>   					if (!hostdata->connected)
>   						return;
>   
> -					/* Fall through to reject message */
> -
> +					/* Reject message */
> +					/* Fall through */
> +				default:
>   					/*
>   					 * If we get something weird that we aren't expecting,
> -					 * reject it.
> +					 * log it.
>   					 */
> -				default:
>   					if (tmp == EXTENDED_MESSAGE)
>   						scmd_printk(KERN_INFO, cmd,
>   						            "rejecting unknown extended message code %02x, length %d\n",
>
