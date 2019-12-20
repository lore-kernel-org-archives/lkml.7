Return-Path: <SRS0=w7sF=2K=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E90C1C43603
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Dec 2019 15:23:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C177C21D7E
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Dec 2019 15:23:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727569AbfLTPXf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 20 Dec 2019 10:23:35 -0500
Received: from mail-pg1-f196.google.com ([209.85.215.196]:34452 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727233AbfLTPXe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Dec 2019 10:23:34 -0500
Received: by mail-pg1-f196.google.com with SMTP id r11so5122403pgf.1
        for <linux-kernel@vger.kernel.org>; Fri, 20 Dec 2019 07:23:33 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:autocrypt
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=eCUeKDGuxrKtJoM1OKXL0Jd05SURNzg4ssm3pQXbTKw=;
        b=F6WbzF3XTmMIFKiRNKn3Cqx7LYysCoPtFiaN4TEcZx2RGNOOnu92CnS8gdMokQ9ZjL
         61Y/iyVU7DLGsUiV2Hz6wgRTAzjDyxT5UYOUiPIvNNx+mCr9TSSGHLNIiqozLwjOnkVs
         J/Ib9335XZbsb9QjTvI9StRsaTMlbWeLKNvxyGn/LCJpU1pplwJljXRaQqJbpvhVr5gk
         WUDinGwY57szoXHnPtxEFyokXy9YJOr3TN+i+tjaGtKlLuVtB1s3KKAc17J5Ia+A9Q27
         dtRTAoK/fjCL5pE35Us1OjxtB5VamcxNw9EEA97fb2LmUs34c+5YRsqS9fLoX9sY24tv
         6lFw==
X-Gm-Message-State: APjAAAVuGhHuiVDLndJUQOs4ZkskJVQPvQhseFnnPyMtsanVYn65nKS6
        FexRdxSuKuk8ZtgBWoJ8MyTLBHTv
X-Google-Smtp-Source: APXvYqwSj25wR0N3/uSvOi3zlOuUjsEzDbai8BeIhZOcTT9bMAPsPox45tfEZXz7yMsEtq2a5OMfsw==
X-Received: by 2002:aa7:83d6:: with SMTP id j22mr2462353pfn.234.1576855412956;
        Fri, 20 Dec 2019 07:23:32 -0800 (PST)
Received: from ?IPv6:2601:647:4000:1108:4dee:e16c:e52f:356? ([2601:647:4000:1108:4dee:e16c:e52f:356])
        by smtp.gmail.com with ESMTPSA id v143sm4961131pfc.71.2019.12.20.07.23.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 20 Dec 2019 07:23:32 -0800 (PST)
Subject: Re: [PATCH v2] locking/lockdep: Fix buffer overrun problem in
 stack_trace[]
To:     Waiman Long <longman@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Will Deacon <will.deacon@arm.com>
Cc:     linux-kernel@vger.kernel.org
References: <20191220135128.14876-1-longman@redhat.com>
From:   Bart Van Assche <bvanassche@acm.org>
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
Message-ID: <11cdb8cb-579c-0655-0f42-625680b8249f@acm.org>
Date:   Fri, 20 Dec 2019 07:23:30 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.3.0
MIME-Version: 1.0
In-Reply-To: <20191220135128.14876-1-longman@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2019-12-20 05:51, Waiman Long wrote:
> If the lockdep code is really running out of the stack_trace entries,
> it is likely that buffer overrun can happen and the data immediately
> after stack_trace[] will be corrupted.
> 
> If there is less than LOCK_TRACE_SIZE_IN_LONGS entries left before
> the call to save_trace(), the max_entries computation will leave it
> with a very large positive number because of its unsigned nature. The
> subsequent call to stack_trace_save() will then corrupt the data after
> stack_trace[]. Fix that by changing max_entries to a signed integer
> and check for negative value before calling stack_trace_save().

Reviewed-by: Bart Van Assche <bvanassche@acm.org>
