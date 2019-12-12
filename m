Return-Path: <SRS0=kgnc=2C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E07A2C2D0C9
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Dec 2019 15:12:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A70A92067C
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Dec 2019 15:12:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="yel7ilHm"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729121AbfLLPMb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 12 Dec 2019 10:12:31 -0500
Received: from mail-io1-f68.google.com ([209.85.166.68]:38593 "EHLO
        mail-io1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728581AbfLLPMb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Dec 2019 10:12:31 -0500
Received: by mail-io1-f68.google.com with SMTP id v3so3148707ioj.5
        for <linux-kernel@vger.kernel.org>; Thu, 12 Dec 2019 07:12:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=xYajL1U4jC9ZExri89zzMJt4P1KGCBp+VKCTmb/5gEg=;
        b=yel7ilHm7D9YLCabiqexU/awxOwjIQwGurhRmekMKKUCirwy/juruq6cvGggD1GKAO
         BgFeDjrvbG/+D99lMen/iUvoq7qqEqvuPt7cVVEJtgAAGAr3ihKjSzv8EJ5EMbR3a8PA
         fYU/s648B7KEiKfRte1jl73nBCJxGA7ISEMkBQMbkvOA4h0nJk+4sPwFWEASOy5ozfZd
         uplPqjE8+JJGMjj4J7ggm5mU/tSG2meECVA1OrpwHA2gMttqddtr7BJm6QR9Q9a21bPu
         PVjTpPSGA697ks/ntLRSadMIrd+lBaQxwltVvf6h336i/BiWOdrJafIncICcS0E+cTnB
         EJ1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=xYajL1U4jC9ZExri89zzMJt4P1KGCBp+VKCTmb/5gEg=;
        b=jX+3YSi9MpQZINeHlB2EzfSyPBglGa9zZT1gSO6vGKLflL/ZYcIbH0qlIVEzJ7UV/Z
         ybbHkdbkcuZ6VJha7APxY1yRal1lgBcgTFhXd+sat+y+15pmu+aDOlCg1gqWHli1wtFL
         D0hOKDHkDI5AFkSKVX4Q2iqQtbHIExGyBbY/4QUUMa4z8FxzAdDyNF+WqPJUFaZXv7Rs
         Lf3PO942bomnTQsZBM6qZvJ62ZV59+eOkNs+OP271e4QaU4EI0YzAZ3IjXyr77HNAs6T
         qEnXwawHwuI/Vc4XQAB+VwC0jOvjzd3p0sQjWjrbCMYhA6+MyqcYNIcQPKrA8Txj5Fw0
         VynQ==
X-Gm-Message-State: APjAAAUy6LieenpQ4xgAuEnwvv8/Jh5d0D68w/11DhzGpIvbWq+MtAdQ
        l5/SclCerFezfQGJNCKDmzOhrA==
X-Google-Smtp-Source: APXvYqwQrECTsC0NoxcyQsWFywGf7uiHdeeO98ULP3wU9Ay553x/UnWcSRKbYVDtIdFccs89cjtwfQ==
X-Received: by 2002:a6b:6202:: with SMTP id f2mr3341454iog.272.1576163549769;
        Thu, 12 Dec 2019 07:12:29 -0800 (PST)
Received: from [192.168.1.159] ([65.144.74.34])
        by smtp.gmail.com with ESMTPSA id o83sm1801557ild.13.2019.12.12.07.12.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 12 Dec 2019 07:12:28 -0800 (PST)
Subject: Re: [PATCH] libata: Fix retrieving of active qcs
To:     Sascha Hauer <s.hauer@pengutronix.de>, linux-ide@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, kernel@pengutronix.de
References: <20191212141656.11439-1-s.hauer@pengutronix.de>
 <20191212142314.pcp662fb22pjidaw@pengutronix.de>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <3edd5096-e824-1e83-8c91-43d1183c73e3@kernel.dk>
Date:   Thu, 12 Dec 2019 08:12:27 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <20191212142314.pcp662fb22pjidaw@pengutronix.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/12/19 7:23 AM, Sascha Hauer wrote:
> On Thu, Dec 12, 2019 at 03:16:56PM +0100, Sascha Hauer wrote:
>> ata_qc_complete_multiple() is called with a mask of the still active
>> tags.
>>
>> mv_sata doesn't have this information directly and instead calculates
>> the still active tags from the started tags (ap->qc_active) and the
>> finished tags as (ap->qc_active ^ done_mask)
>>
>> Since 28361c40368 the hw_tag and tag are no longer the same and the
>> equation is no longer valid. In ata_exec_internal_sg() ap->qc_active is
>> initialized as 1ULL << ATA_TAG_INTERNAL, but in hardware tag 0 is
>> started and this will be in done_mask on completion. ap->qc_active ^
>> done_mask becomes 0x100000000 ^ 0x1 = 0x100000001 and thus tag 0 used as
>> the internal tag will never be reported as completed.
>>
>> This is fixed by introducing ata_qc_get_active() which returns the
>> active hardware tags and calling it where appropriate.
>>
>> This is tested on mv_sata, but sata_fsl and sata_nv suffer from the same
>> problem. There is another case in sata_nv that most likely needs fixing
>> as well, but this looks a little different, so I wasn't confident enough
>> to change that.
>>
>> Fixes: 28361c403683 ("libata: add extra internal command")
>> Signed-off-by: Sascha Hauer <s.hauer@pengutronix.de>
>> ---
>>  drivers/ata/libata-core.c | 23 +++++++++++++++++++++++
>>  drivers/ata/sata_fsl.c    |  2 +-
>>  drivers/ata/sata_mv.c     |  2 +-
>>  drivers/ata/sata_nv.c     |  2 +-
>>  include/linux/libata.h    |  1 +
>>  5 files changed, 27 insertions(+), 3 deletions(-)
>>
>> diff --git a/drivers/ata/libata-core.c b/drivers/ata/libata-core.c
>> index 28c492be0a57..d73bec933892 100644
>> --- a/drivers/ata/libata-core.c
>> +++ b/drivers/ata/libata-core.c
>> @@ -5325,6 +5325,29 @@ void ata_qc_complete(struct ata_queued_cmd *qc)
>>  	}
>>  }
>>  
>> +/**
>> + *	ata_qc_get_active - get bitmask of active qcs
>> + *	@ap: port in question
>> + *
>> + *	LOCKING:
>> + *	spin_lock_irqsave(host lock)
>> + *
>> + *	RETURNS:
>> + *	Bitmask of active qcs
>> + */
>> +u64 ata_qc_get_active(struct ata_port *ap)
>> +{
>> +	u64 qc_active = ap->qc_active;
>> +
>> +	/* ATA_TAG_INTERNAL is sent to hw as tag 0 */
>> +	if (qc_active & (1ULL << ATA_TAG_INTERNAL)) {
>> +		qc_active |= (1 << 0);
>> +		qc_active &= ~(1ULL << ATA_TAG_INTERNAL);
>> +	}
>> +
>> +	return qc_active;
>> +}
>> +
>>  /**
>>   *	ata_qc_complete_multiple - Complete multiple qcs successfully
>>   *	@ap: port in question
>> diff --git a/drivers/ata/sata_fsl.c b/drivers/ata/sata_fsl.c
>> index 8e9cb198fcd1..ca6c706e9c25 100644
>> --- a/drivers/ata/sata_fsl.c
>> +++ b/drivers/ata/sata_fsl.c
>> @@ -1278,7 +1278,7 @@ static void sata_fsl_host_intr(struct ata_port *ap)
>>  				     i, ioread32(hcr_base + CC),
>>  				     ioread32(hcr_base + CA));
>>  		}
>> -		ata_qc_complete_multiple(ap, ap->qc_active ^ done_mask);
>> +		ata_qc_complete_multiple(ap, ata_qc_get_active(ap) ^ done_mask);
>>  		return;
>>  
>>  	} else if ((ap->qc_active & (1ULL << ATA_TAG_INTERNAL))) {
>> diff --git a/drivers/ata/sata_mv.c b/drivers/ata/sata_mv.c
>> index ad385a113391..bde695a32097 100644
>> --- a/drivers/ata/sata_mv.c
>> +++ b/drivers/ata/sata_mv.c
>> @@ -2827,7 +2827,7 @@ static void mv_process_crpb_entries(struct ata_port *ap, struct mv_port_priv *pp
>>  	}
>>  
>>  	if (work_done) {
>> -		ata_qc_complete_multiple(ap, ap->qc_active ^ done_mask);
>> +		ata_qc_complete_multiple(ap, ata_qc_get_active(ap) ^ done_mask);
>>  
>>  		/* Update the software queue position index in hardware */
>>  		writelfl((pp->crpb_dma & EDMA_RSP_Q_BASE_LO_MASK) |
>> diff --git a/drivers/ata/sata_nv.c b/drivers/ata/sata_nv.c
>> index 56946012d113..7510303111fa 100644
>> --- a/drivers/ata/sata_nv.c
>> +++ b/drivers/ata/sata_nv.c
>> @@ -984,7 +984,7 @@ static irqreturn_t nv_adma_interrupt(int irq, void *dev_instance)
>>  					check_commands = 0;
>>  				check_commands &= ~(1 << pos);
>>  			}
>> -			ata_qc_complete_multiple(ap, ap->qc_active ^ done_mask);
>> +			ata_qc_complete_multiple(ap, ata_qc_get_active(ap) ^ done_mask);
>>  		}
>>  	}
>>  
>> diff --git a/include/linux/libata.h b/include/linux/libata.h
>> index 207e7ee764ce..f4c045b56e6c 100644
>> --- a/include/linux/libata.h
>> +++ b/include/linux/libata.h
>> @@ -1174,6 +1174,7 @@ extern unsigned int ata_do_dev_read_id(struct ata_device *dev,
>>  					struct ata_taskfile *tf, u16 *id);
>>  extern void ata_qc_complete(struct ata_queued_cmd *qc);
>>  extern int ata_qc_complete_multiple(struct ata_port *ap, u64 qc_active);
>> +extern u64 ata_qc_get_started(struct ata_port *ap);
> 
> s/ata_qc_get_started/ata_qc_get_active/ obviously.

Last minute edit? Please send a v2.

-- 
Jens Axboe

