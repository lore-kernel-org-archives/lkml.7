Return-Path: <SRS0=bMiL=T7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3A804C04AB6
	for <linux-kernel@archiver.kernel.org>; Fri, 31 May 2019 13:56:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 172A1269E4
	for <linux-kernel@archiver.kernel.org>; Fri, 31 May 2019 13:56:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726682AbfEaN45 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 31 May 2019 09:56:57 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:44485 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726386AbfEaN44 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 May 2019 09:56:56 -0400
Received: by mail-pf1-f194.google.com with SMTP id x3so748899pff.11
        for <linux-kernel@vger.kernel.org>; Fri, 31 May 2019 06:56:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:openpgp:autocrypt
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=iy/V3A8KvaU1UKa5ycIHYJwzeROiBdISw8IrSWM8q2w=;
        b=U/D4L2dxhLWI81C2UwbCnXsYqdWHtEm6w9dt122X9s7HsIp/Zv8hjwbQ57E9skT5QY
         xLEu0vw3fyiEVQAaRCLcPgLFQ1VAmKjjlr8EsuYjKEjpRUS6aGza1bYOkNqyxqqNddZn
         DzfmVIVR2ZVMyRHoEGv5ei5rPJFWb3Qanxf71Rwupyh5ThwNmQt5vTA/MwPyrextDWzj
         1Mh12W72s0PejvEJsLA9zA5w/tYX2v+chwpXSrVcIAVP8NKJdxXoRQQsIo8mlC34n9bT
         RlJeHnQZcQwoB8lo5+HDeaWjWXjobA9c/+gLds157tz3cnye1jEor97Z4yPbmeyIrAzV
         VaSA==
X-Gm-Message-State: APjAAAXGCxplc4R3IzJYn5KihirEl3YzdMGKa/Qew0onJy7imUxIxC6O
        AbFHRYsHRD88Vf0geVroA9pwX8Ei
X-Google-Smtp-Source: APXvYqzzf6Hh38qYSsJo638z2Y74X3WfeF3gSE+FoKYvVIMpJatVWYyZfwpxRZc91ld01aOQ1h5GOA==
X-Received: by 2002:aa7:82cd:: with SMTP id f13mr10475954pfn.203.1559311015753;
        Fri, 31 May 2019 06:56:55 -0700 (PDT)
Received: from asus.site ([2601:647:4000:5dd1:a41e:80b4:deb3:fb66])
        by smtp.gmail.com with ESMTPSA id g22sm6190588pfo.28.2019.05.31.06.56.54
        (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
        Fri, 31 May 2019 06:56:54 -0700 (PDT)
Subject: Re: [PATCH 4.19 075/276] scsi: qla2xxx: Fix a qla24xx_enable_msix()
 error path
To:     Pavel Machek <pavel@ucw.cz>
Cc:     linux-kernel@vger.kernel.org,
        Himanshu Madhani <hmadhani@marvell.com>,
        Giridhar Malavali <gmalavali@marvell.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        Sasha Levin <sashal@kernel.org>
References: <20190530030523.133519668@linuxfoundation.org>
 <20190530030531.119463640@linuxfoundation.org> <20190531085905.GB19447@amd>
From:   Bart Van Assche <bvanassche@acm.org>
Openpgp: preference=signencrypt
Autocrypt: addr=bvanassche@acm.org; prefer-encrypt=mutual; keydata=
 mQENBFSOu4oBCADcRWxVUvkkvRmmwTwIjIJvZOu6wNm+dz5AF4z0FHW2KNZL3oheO3P8UZWr
 LQOrCfRcK8e/sIs2Y2D3Lg/SL7qqbMehGEYcJptu6mKkywBfoYbtBkVoJ/jQsi2H0vBiiCOy
 fmxMHIPcYxaJdXxrOG2UO4B60Y/BzE6OrPDT44w4cZA9DH5xialliWU447Bts8TJNa3lZKS1
 AvW1ZklbvJfAJJAwzDih35LxU2fcWbmhPa7EO2DCv/LM1B10GBB/oQB5kvlq4aA2PSIWkqz4
 3SI5kCPSsygD6wKnbRsvNn2mIACva6VHdm62A7xel5dJRfpQjXj2snd1F/YNoNc66UUTABEB
 AAG0JEJhcnQgVmFuIEFzc2NoZSA8YnZhbmFzc2NoZUBhY20ub3JnPokBOQQTAQIAIwUCVI67
 igIbAwcLCQgHAwIBBhUIAgkKCwQWAgMBAh4BAheAAAoJEHFcPTXFzhAJ8QkH/1AdXblKL65M
 Y1Zk1bYKnkAb4a98LxCPm/pJBilvci6boefwlBDZ2NZuuYWYgyrehMB5H+q+Kq4P0IBbTqTa
 jTPAANn62A6jwJ0FnCn6YaM9TZQjM1F7LoDX3v+oAkaoXuq0dQ4hnxQNu792bi6QyVdZUvKc
 macVFVgfK9n04mL7RzjO3f+X4midKt/s+G+IPr4DGlrq+WH27eDbpUR3aYRk8EgbgGKvQFdD
 CEBFJi+5ZKOArmJVBSk21RHDpqyz6Vit3rjep7c1SN8s7NhVi9cjkKmMDM7KYhXkWc10lKx2
 RTkFI30rkDm4U+JpdAd2+tP3tjGf9AyGGinpzE2XY1K5AQ0EVI67igEIAKiSyd0nECrgz+H5
 PcFDGYQpGDMTl8MOPCKw/F3diXPuj2eql4xSbAdbUCJzk2ETif5s3twT2ER8cUTEVOaCEUY3
 eOiaFgQ+nGLx4BXqqGewikPJCe+UBjFnH1m2/IFn4T9jPZkV8xlkKmDUqMK5EV9n3eQLkn5g
 lco+FepTtmbkSCCjd91EfThVbNYpVQ5ZjdBCXN66CKyJDMJ85HVr5rmXG/nqriTh6cv1l1Js
 T7AFvvPjUPknS6d+BETMhTkbGzoyS+sywEsQAgA+BMCxBH4LvUmHYhpS+W6CiZ3ZMxjO8Hgc
 ++w1mLeRUvda3i4/U8wDT3SWuHcB3DWlcppECLkAEQEAAYkBHwQYAQIACQUCVI67igIbDAAK
 CRBxXD01xc4QCZ4dB/0QrnEasxjM0PGeXK5hcZMT9Eo998alUfn5XU0RQDYdwp6/kMEXMdmT
 oH0F0xB3SQ8WVSXA9rrc4EBvZruWQ+5/zjVrhhfUAx12CzL4oQ9Ro2k45daYaonKTANYG22y
 //x8dLe2Fv1By4SKGhmzwH87uXxbTJAUxiWIi1np0z3/RDnoVyfmfbbL1DY7zf2hYXLLzsJR
 mSsED/1nlJ9Oq5fALdNEPgDyPUerqHxcmIub+pF0AzJoYHK5punqpqfGmqPbjxrJLPJfHVKy
 goMj5DlBMoYqEgpbwdUYkH6QdizJJCur4icy8GUNbisFYABeoJ91pnD4IGei3MTdvINSZI5e
Message-ID: <5fd4ac34-ee7b-cfe9-1287-0a255a0dcc53@acm.org>
Date:   Fri, 31 May 2019 06:56:53 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190531085905.GB19447@amd>
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 5/31/19 1:59 AM, Pavel Machek wrote:
> 
> On Wed 2019-05-29 20:03:53, Greg Kroah-Hartman wrote:
>> [ Upstream commit 24afabdbd0b3553963a2bbf465895492b14d1107 ]
>>
>> Make sure that the allocated interrupts are freed if allocating memory for
>> the msix_entries array fails.
>>
>> Cc: Himanshu Madhani <hmadhani@marvell.com>
>> Cc: Giridhar Malavali <gmalavali@marvell.com>
>> Signed-off-by: Bart Van Assche <bvanassche@acm.org>
>> Acked-by: Himanshu Madhani <hmadhani@marvell.com>
>> Signed-off-by: Martin K. Petersen <martin.petersen@oracle.com>
>> Signed-off-by: Sasha Levin <sashal@kernel.org>
> 
>> --- a/drivers/scsi/qla2xxx/qla_isr.c
>> +++ b/drivers/scsi/qla2xxx/qla_isr.c
>> @@ -3449,7 +3449,7 @@ qla24xx_enable_msix(struct qla_hw_data *ha, struct rsp_que *rsp)
>>  		ql_log(ql_log_fatal, vha, 0x00c8,
>>  		    "Failed to allocate memory for ha->msix_entries.\n");
>>  		ret = -ENOMEM;
>> -		goto msix_out;
>> +		goto free_irqs;
> 
> Could we just do > +     pci_free_irq_vectors(ha->pdev); return
> -ENOMEM; here? Going through two gotos just does not feel right.
> 
> And yes, I'd replace msix_out with direct returns, too. gotos have
> value when there's cleanup to be done, but we are not doing any here.

That would have been an appropriate comment for the original patch. This
e-mail thread is about backporting an upstream commit to the stable
tree. If you want to change this code you need to send a patch to the
linux-scsi mailing list.

Bart.
