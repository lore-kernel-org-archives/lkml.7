Return-Path: <SRS0=QEJJ=XC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 81801C43331
	for <linux-kernel@archiver.kernel.org>; Sat,  7 Sep 2019 00:13:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5948E208C3
	for <linux-kernel@archiver.kernel.org>; Sat,  7 Sep 2019 00:13:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="Ms8Y1p4g"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2393343AbfIGANs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 6 Sep 2019 20:13:48 -0400
Received: from mail-pf1-f195.google.com ([209.85.210.195]:45933 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2392970AbfIGANr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Sep 2019 20:13:47 -0400
Received: by mail-pf1-f195.google.com with SMTP id y72so5601392pfb.12
        for <linux-kernel@vger.kernel.org>; Fri, 06 Sep 2019 17:13:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=Spvdc33clcoI+a6vwSzgftHLqivHojmlm8yoJkvlMzU=;
        b=Ms8Y1p4gyEo0DXVX5rev360ZCZyD0SDw+Y87Hf6XX4cugwvj7vCB9Lsza2DOdKD3jq
         lr7MZCM0fGBPsLl9mKd8Y2d7YH4Sikv41Zx4IQjNm6ZDogLQGveBPsRDdNEKUWD+Cerm
         TKGVUd4/6qwaZBD0+fbHXSHmir9VZX5qtAIfk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=Spvdc33clcoI+a6vwSzgftHLqivHojmlm8yoJkvlMzU=;
        b=qr0TlqgrvEiGyKlFXqAisTt9zSrumg5ff2AEoO8pQkXFaOskMtDpVuie2+USdfE92+
         koxRf6oACDr/oD+YYuR+x+uFyhyHJeJYtbf7zRwBxWLzHpZsX8sGAS/l7lNH8VeeaLNf
         mJ65bMakaCpTyCKuU45zEDFIHbGplPBRmITexISeYQj5/oBEaoJOLO4taHoRWISMLVw4
         5GXaKM4O/ELRVmadcziQ09/jnWhm7RI95CtkJYtQEPw81z7mDFF/3M98oLhnpz7f2PgV
         noYgQIP8QMOQ1AoxqMQiPwt0VPnkzyKRLYvU01C7oYxmoSsTO2p4B82GrAKXszdECrk2
         wVfg==
X-Gm-Message-State: APjAAAX4SoTZc2pAz5qBXzaTrmS096p6uc0T41o60Lq46hyHARFE8pSK
        c0V0TnMODFGm8SkCwAlB89oaoUtLC4rcsJzdu5ygr93jd/yJztpPLtK55EoSAxwRPU8MBVe2pbp
        TY3FJxM2hN+TKBTRgfjP3J4uZl4qlMPKYA0kqjluajLF69LmVXXppDcc7J/2cdkULp7h5at6y6n
        2K51c=
X-Google-Smtp-Source: APXvYqwHMYt2NA8Keg2hMSHk1i0NAI1EvBz+X7y74Qq0MJVHD+jKY8xfnoV2v5mCJiF/nyKcxcDpdg==
X-Received: by 2002:a63:595d:: with SMTP id j29mr10443950pgm.134.1567815226830;
        Fri, 06 Sep 2019 17:13:46 -0700 (PDT)
Received: from [10.69.45.46] ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id i9sm17103419pgo.46.2019.09.06.17.13.45
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 06 Sep 2019 17:13:46 -0700 (PDT)
Subject: Re: [GIT PULL] SCSI fixes for 5.3-rc7
To:     Linus Torvalds <torvalds@linux-foundation.org>,
        James Bottomley <James.Bottomley@hansenpartnership.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        linux-scsi <linux-scsi@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
References: <1567802352.26275.3.camel@HansenPartnership.com>
 <CAHk-=wiqV2T03rOx=8DTttZkL-N8b-anRkvT2F_w7hOGfjH92Q@mail.gmail.com>
From:   James Smart <james.smart@broadcom.com>
Message-ID: <63ffa77c-8a60-05ae-4694-e0b7b0e679a1@broadcom.com>
Date:   Fri, 6 Sep 2019 17:13:45 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <CAHk-=wiqV2T03rOx=8DTttZkL-N8b-anRkvT2F_w7hOGfjH92Q@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/6/2019 4:18 PM, Linus Torvalds wrote:
> On Fri, Sep 6, 2019 at 1:39 PM James Bottomley
> <James.Bottomley@hansenpartnership.com> wrote:
>>
>> diff --git a/drivers/scsi/lpfc/lpfc_attr.c b/drivers/scsi/lpfc/lpfc_attr.c
>> index 8d8c495b5b60..d65558619ab0 100644
>> --- a/drivers/scsi/lpfc/lpfc_attr.c
>> +++ b/drivers/scsi/lpfc/lpfc_attr.c
>> @@ -5715,7 +5715,7 @@ LPFC_ATTR_RW(nvme_embed_cmd, 1, 0, 2,
>>    *      0    = Set nr_hw_queues by the number of CPUs or HW queues.
>>    *      1,128 = Manually specify the maximum nr_hw_queue value to be set,
>>    *
>> - * Value range is [0,128]. Default value is 8.
>> + * Value range is [0,256]. Default value is 8.
>>    */
> Shouldn't that "1,128 = Manually specify.." line also have been updated?
>
> Not that I really care, and I'll pul this, but..
>
>                        Linus

Yes - thanks

-- james

