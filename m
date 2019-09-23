Return-Path: <SRS0=bmbz=XS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 76E7DC04EBF
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Sep 2019 13:24:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 54434205F4
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Sep 2019 13:24:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2407666AbfIWNYO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 23 Sep 2019 09:24:14 -0400
Received: from mx1.redhat.com ([209.132.183.28]:57638 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2407081AbfIWNYO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Sep 2019 09:24:14 -0400
Received: from mail-pf1-f198.google.com (mail-pf1-f198.google.com [209.85.210.198])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id B2A8F81DEC
        for <linux-kernel@vger.kernel.org>; Mon, 23 Sep 2019 13:24:13 +0000 (UTC)
Received: by mail-pf1-f198.google.com with SMTP id s139so10046104pfc.21
        for <linux-kernel@vger.kernel.org>; Mon, 23 Sep 2019 06:24:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:reply-to:subject:to:cc:references:from
         :organization:message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=3PwMn2YEjlUJRkfotbTy+c3Hn5hUOXwAI3NJinXbsks=;
        b=HDHXJVcN64XssKQy+Zgkubi/Q8DA/FSBKqCSIXI3BnbBspOBfkSmETgTrJv4wWZPPy
         PqLUcW2GVbxHqHjXJdsNE86FxJ1bLcVpyKrx6lDmgvhQW3Yxg/Z+OCMMK4NbnKjC4WtG
         bP6ll7KuP09MaErrSX9wkbxq/rwhw3eqcCX+9hGfpSL1L1eBwvZnXesLsZ4b6x+K9HKz
         n+sf9/KvEFpuB/KLNuKymTOt9W7bHvqPRknW5vgXF2xTVCRq/2HyA+hewdrKYGHJ5JTG
         1J1XDvjLJNn4uFfIb3pgljoxsMi6B+M+DvAjLYgAWfSnOLKBCcUYylxsFVf3PEuqUVzu
         bG8w==
X-Gm-Message-State: APjAAAUddgZj39nzPydQxEaXvXx4plRBN8q8xqLJqwQg8Yd2UtJzNRAr
        peY5aV8ne3p3Wi+pnWj8oz9rMytqOhOEZCHHRh5NOpVQn//SJMnYAExPHnn9qDvH59LY+Gr6MZv
        DpzlojDWYH/ZWpzlOW2+Lkq16
X-Received: by 2002:aa7:9aaa:: with SMTP id x10mr32448750pfi.173.1569245052735;
        Mon, 23 Sep 2019 06:24:12 -0700 (PDT)
X-Google-Smtp-Source: APXvYqy8ly0CDUEalS2u9sGaTJiVzvhnyzUXej5FU8McrQPI5IULCpDndZo5HMmjYfGs1EFg/la17w==
X-Received: by 2002:aa7:9aaa:: with SMTP id x10mr32448727pfi.173.1569245052477;
        Mon, 23 Sep 2019 06:24:12 -0700 (PDT)
Received: from [10.76.0.39] ([125.16.200.50])
        by smtp.gmail.com with ESMTPSA id g202sm15824616pfb.155.2019.09.23.06.24.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 23 Sep 2019 06:24:11 -0700 (PDT)
Reply-To: mgandhi@redhat.com
Subject: Re: [PATCH] scsi: core: Log SCSI command age with errors
To:     Laurence Oberman <loberman@redhat.com>,
        linux-kernel@vger.kernel.org, linux-scsi@vger.kernel.org
Cc:     jejb@linux.ibm.com, martin.petersen@oracle.com
References: <20190923060122.GA9603@machine1>
 <8e9c537b7eaabd611968d22ec31f7cfb90e72efe.camel@redhat.com>
From:   "Milan P. Gandhi" <mgandhi@redhat.com>
Organization: Red Hat
Message-ID: <a1fadc48-b6b2-784a-d1ff-3d4dbe6df7eb@redhat.com>
Date:   Mon, 23 Sep 2019 18:54:08 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <8e9c537b7eaabd611968d22ec31f7cfb90e72efe.camel@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/23/19 6:32 PM, Laurence Oberman wrote:
> On Mon, 2019-09-23 at 11:31 +0530, Milan P. Gandhi wrote:
>> Couple of users had requested to print the SCSI command age along 
>> with command failure errors. This is a small change, but allows 
>> users to get more important information about the command that was 
>> failed, it would help the users in debugging the command failures:
>>
>> Signed-off-by: Milan P. Gandhi <mgandhi@redhat.com>
>> ---
>> diff --git a/drivers/scsi/scsi_logging.c
>> b/drivers/scsi/scsi_logging.c
>> index ecc5918e372a..ca2182bc53c6 100644
>> --- a/drivers/scsi/scsi_logging.c
>> +++ b/drivers/scsi/scsi_logging.c
>> @@ -437,6 +437,7 @@ void scsi_print_result(const struct scsi_cmnd
>> *cmd, const char *msg,
>>  	const char *mlret_string = scsi_mlreturn_string(disposition);
>>  	const char *hb_string = scsi_hostbyte_string(cmd->result);
>>  	const char *db_string = scsi_driverbyte_string(cmd->result);
>> +	unsigned long cmd_age = (jiffies - cmd->jiffies_at_alloc) / HZ;
>>  
>>  	logbuf = scsi_log_reserve_buffer(&logbuf_len);
>>  	if (!logbuf)
>> @@ -478,10 +479,15 @@ void scsi_print_result(const struct scsi_cmnd
>> *cmd, const char *msg,
>>  
>>  	if (db_string)
>>  		off += scnprintf(logbuf + off, logbuf_len - off,
>> -				 "driverbyte=%s", db_string);
>> +				 "driverbyte=%s ", db_string);
>>  	else
>>  		off += scnprintf(logbuf + off, logbuf_len - off,
>> -				 "driverbyte=0x%02x", driver_byte(cmd-
>>> result));
>> +				 "driverbyte=0x%02x ",
>> +				 driver_byte(cmd->result));
>> +
>> +	off += scnprintf(logbuf + off, logbuf_len - off,
>> +			 "cmd-age=%lus", cmd_age);
>> +
>>  out_printk:
>>  	dev_printk(KERN_INFO, &cmd->device->sdev_gendev, "%s", logbuf);
>>  	scsi_log_release_buffer(logbuf);
>>
> 
> This looks to be a useful debug addition to me, and the code looks
> correct.
> I believe this has also been tested by Milan in our lab.
> 
> Reviewed-by: Laurence Oberman <loberman@redhat.com> 
> 
Yes, the patch was tested locally using scsi_debug as well as in real 
storage issues caused by bad disks in customer environment.

Thanks,
Milan.
