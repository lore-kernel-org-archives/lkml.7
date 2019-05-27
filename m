Return-Path: <SRS0=8QAT=T3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1CE45C04AB3
	for <linux-kernel@archiver.kernel.org>; Mon, 27 May 2019 15:08:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EBE94217F4
	for <linux-kernel@archiver.kernel.org>; Mon, 27 May 2019 15:08:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726642AbfE0PIl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 27 May 2019 11:08:41 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:35320 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726302AbfE0PIk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 May 2019 11:08:40 -0400
Received: by mail-pf1-f196.google.com with SMTP id d126so7538731pfd.2;
        Mon, 27 May 2019 08:08:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:openpgp:autocrypt
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=N5ugnJVE0UakFyPbz7RPAOQQz30k1byDY4tWG4dOtTw=;
        b=P3uezW5F212oVNFRbu0xvrHVbp1YFIcBPjqo6Ufx04Wu9MlZL0XmQJEg+sG8+6Eh3A
         Dn3VsfTEusrrshZjKWZAuUw4leLeKkr9pHZ2lF2P9r8tskPCQYuSHNfmeDxW4FJCqVKd
         8PKVPuTO2yMNzLAKYrOt/6Ws/OOwci4ly/xoxoe3DsxtDJKxUPP/7P7/nTEmBukFqF0U
         LgJZ9b1isc1Q6FbNX58rHncT8vWvQsKnbE6lUmWmY/iw+sGfUgH9/cudq8snuDX4+/9z
         aAB5Ne/JTCk2uew2iDxjNm0sNzu0fjqWay1FlSTBZ+ytKaJrUUIGDTeB5l9HjAUxvIpc
         REeQ==
X-Gm-Message-State: APjAAAUGRKZNbUUtmaJx1W3id5es/ZkVfbd4SgTJpl3MQImfBm0sxdyu
        GEnIuMqK1yKHNs8E5x/NAYBDBx8q
X-Google-Smtp-Source: APXvYqyon1PsbSfC0O/aacJKaERgNXOiWja/Q1famQ++moq6UMxWutRJG7sL+dZLvV6I6K3logLfDw==
X-Received: by 2002:a17:90a:a0a:: with SMTP id o10mr31395019pjo.105.1558969719896;
        Mon, 27 May 2019 08:08:39 -0700 (PDT)
Received: from asus.site ([2601:647:4000:5dd1:a41e:80b4:deb3:fb66])
        by smtp.gmail.com with ESMTPSA id d10sm3970235pgh.43.2019.05.27.08.08.38
        (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
        Mon, 27 May 2019 08:08:38 -0700 (PDT)
Subject: Re: [PATCH] scsi: scsi_dh_alua: Fix possible null-ptr-deref
To:     YueHaibing <yuehaibing@huawei.com>, jejb@linux.ibm.com,
        martin.petersen@oracle.com, axboe@kernel.dk, hare@suse.de
Cc:     linux-kernel@vger.kernel.org, linux-scsi@vger.kernel.org
References: <20190527142209.21768-1-yuehaibing@huawei.com>
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
Message-ID: <dea3ea6b-66e7-a325-539f-63695cd87e51@acm.org>
Date:   Mon, 27 May 2019 08:08:37 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190527142209.21768-1-yuehaibing@huawei.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 5/27/19 7:22 AM, YueHaibing wrote:
> If alloc_workqueue fails in alua_init, it should return
> -ENOMEM, otherwise it will trigger null-ptr-deref while
> unloading module which calls destroy_workqueue dereference
> wq->lock like this:
> 
> BUG: KASAN: null-ptr-deref in __lock_acquire+0x6b4/0x1ee0
> Read of size 8 at addr 0000000000000080 by task syz-executor.0/7045
> 
> CPU: 0 PID: 7045 Comm: syz-executor.0 Tainted: G         C        5.1.0+ #28
> Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.10.2-1ubuntu1
> Call Trace:
>  dump_stack+0xa9/0x10e
>  __kasan_report+0x171/0x18d
>  ? __lock_acquire+0x6b4/0x1ee0
>  kasan_report+0xe/0x20
>  __lock_acquire+0x6b4/0x1ee0
>  lock_acquire+0xb4/0x1b0
>  __mutex_lock+0xd8/0xb90
>  drain_workqueue+0x25/0x290
>  destroy_workqueue+0x1f/0x3f0
>  __x64_sys_delete_module+0x244/0x330
>  do_syscall_64+0x72/0x2a0
>  entry_SYSCALL_64_after_hwframe+0x49/0xbe
> 
> Reported-by: Hulk Robot <hulkci@huawei.com>
> Fixes: 03197b61c5ec ("scsi_dh_alua: Use workqueue for RTPG")
> Signed-off-by: YueHaibing <yuehaibing@huawei.com>
> ---
>  drivers/scsi/device_handler/scsi_dh_alua.c | 6 ++----
>  1 file changed, 2 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/scsi/device_handler/scsi_dh_alua.c b/drivers/scsi/device_handler/scsi_dh_alua.c
> index d7ac498ba35a..2a9dcb8973b7 100644
> --- a/drivers/scsi/device_handler/scsi_dh_alua.c
> +++ b/drivers/scsi/device_handler/scsi_dh_alua.c
> @@ -1174,10 +1174,8 @@ static int __init alua_init(void)
>  	int r;
>  
>  	kaluad_wq = alloc_workqueue("kaluad", WQ_MEM_RECLAIM, 0);
> -	if (!kaluad_wq) {
> -		/* Temporary failure, bypass */
> -		return SCSI_DH_DEV_TEMP_BUSY;
> -	}
> +	if (!kaluad_wq)
> +		return -ENOMEM;
>  
>  	r = scsi_register_device_handler(&alua_dh);
>  	if (r != 0) {
> 

Reviewed-by: Bart Van Assche <bvanassche@acm.org>
