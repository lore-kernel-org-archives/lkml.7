Return-Path: <SRS0=TpO6=UA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BA72DC28CC1
	for <linux-kernel@archiver.kernel.org>; Sat,  1 Jun 2019 14:25:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8EB44276F0
	for <linux-kernel@archiver.kernel.org>; Sat,  1 Jun 2019 14:25:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726683AbfFAOZM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 1 Jun 2019 10:25:12 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:36565 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726135AbfFAOZM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 1 Jun 2019 10:25:12 -0400
Received: by mail-pg1-f196.google.com with SMTP id a3so5690307pgb.3
        for <linux-kernel@vger.kernel.org>; Sat, 01 Jun 2019 07:25:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:openpgp:autocrypt
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=HvC78NkwKAnouXD2QP3OXjUjoi2sSorItA4cTC6qb6Q=;
        b=r0Bk3YmOmOryvuT+Ba0LECgX+/Pyu3blfy96417lIiTAkmXqX8YwYzeYQNsZGL6fTe
         QLeiMimuL2JKrzbhnSpECd4m5FGAaUk2eBOFxNvRO5ALHAJHLM45TLNC/13LlhK7bybl
         9ayS+Adu5TNP+gTlXyAnIrrMD0/TpxejngmneTYed/aYbfFnq7Pne+ZZmJTMI13iI5Ps
         JnHiIJ8fjb4vDP6oV+/tj32DKU2WEmPYtjCEF6OSTuDbX1ZI630ueMPasL3U9H9Mv75W
         lGiFgSf5OHvYHCDiO1Eu+QISA/3HC0kvmtKq9+4wPFvW7z3EFaV0GCTv7Ykd2RkCLlQX
         suhA==
X-Gm-Message-State: APjAAAV2qL/E5d8itEfcbevfGo6UntK/r6a8Z5zgQ7zQBXqrBdy0Vx3e
        b1Rb2zPW5u1p5pIbn05/ubY=
X-Google-Smtp-Source: APXvYqy3VkKSK3ESp/3IWbxiS8lWAyYZWMIB/IWSixN5gnVxJ0mfUeFU7W8bBf/kkZBOWc5X95UuJg==
X-Received: by 2002:aa7:9a8c:: with SMTP id w12mr17401556pfi.187.1559399111471;
        Sat, 01 Jun 2019 07:25:11 -0700 (PDT)
Received: from asus.site ([2601:647:4000:5dd1:a41e:80b4:deb3:fb66])
        by smtp.gmail.com with ESMTPSA id i17sm9431294pfo.103.2019.06.01.07.25.10
        (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
        Sat, 01 Jun 2019 07:25:10 -0700 (PDT)
Subject: Re: [PATCH 4.19 130/276] block: fix use-after-free on gendisk
To:     Pavel Machek <pavel@ucw.cz>
Cc:     linux-kernel@vger.kernel.org, Al Viro <viro@zeniv.linux.org.uk>,
        Keith Busch <keith.busch@intel.com>, Jan Kara <jack@suse.cz>,
        Yufen Yu <yuyufen@huawei.com>, Jens Axboe <axboe@kernel.dk>,
        Sasha Levin <sashal@kernel.org>
References: <20190530030523.133519668@linuxfoundation.org>
 <20190530030533.910471797@linuxfoundation.org> <20190601072756.GA2215@amd>
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
Message-ID: <41301531-6619-8230-b016-ef32dd3e07e9@acm.org>
Date:   Sat, 1 Jun 2019 07:25:09 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190601072756.GA2215@amd>
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 6/1/19 12:27 AM, Pavel Machek wrote:
> Hi!
> 
>> +++ b/block/genhd.c
>> @@ -518,6 +518,18 @@ void blk_free_devt(dev_t devt)
>>  	}
>>  }
>>  
>> +/**
>> + *	We invalidate devt by assigning NULL pointer for devt in idr.
>> + */
>> +void blk_invalidate_devt(dev_t devt)
>> +{
>> +	if (MAJOR(devt) == BLOCK_EXT_MAJOR) {
>> +		spin_lock_bh(&ext_devt_lock);
>> +		idr_replace(&ext_devt_idr, NULL, blk_mangle_minor(MINOR(devt)));
>> +		spin_unlock_bh(&ext_devt_lock);
>> +	}
>> +}
>> +
> 
> AFAICT /** means linuxdoc, but the comment does not have required
> format. Probably should be just /*.

Agreed. A fix has been queued in Jens' tree. See also commit
33c826ef19df ("block: Convert blk_invalidate_devt() header into a
non-kernel-doc header").

Bart.
