Return-Path: <SRS0=LehB=SZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7DFA4C10F14
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Apr 2019 14:09:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4B42620645
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Apr 2019 14:09:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727874AbfDWOJq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Apr 2019 10:09:46 -0400
Received: from mail-pg1-f176.google.com ([209.85.215.176]:35690 "EHLO
        mail-pg1-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726659AbfDWOJq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Apr 2019 10:09:46 -0400
Received: by mail-pg1-f176.google.com with SMTP id g8so7688254pgf.2;
        Tue, 23 Apr 2019 07:09:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:openpgp:autocrypt
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=I3pchUjGmM6sDkLfkWSo0YhPzLUWVAw1zXokrtkmcNM=;
        b=imTC4dkltRVfXg1CyGt6pZnvyr7eH7fs3h+fub54EUk9CiL7qyuTSqQwE1YjH70fqh
         gEeELnTDDsrLAMV7RutQq+kbi9wvOB9BZiR4GbZ5nSKSTXIIkx31pgZeHy4El3rjMeTO
         E7Ke4QCHWKTFjkJz2VVGE682CYsKqvSP523a488OH+T8bsSMM/h1DiE1Em8nNsI71B1B
         R8ROo/v7hRxih585mX6Yk06WHaYbrsyFJVCkGWbpgp1I9+Eg2S9AP9wWV+NYJx77uAMa
         2HeRmsbWkTS/gI4mpvuI897njUvq/nvkRVIvJ2Cx5toWFzA1ma7qYyKEDqwYSZ4zmLhQ
         LRYw==
X-Gm-Message-State: APjAAAWEb0Mb7ChACWX8dNy/vlCT8v6RChiqcVQgoHlIWiLIphAI+Cfn
        +0SdLAbe/ViUKEUtZl0/mYfBq36m
X-Google-Smtp-Source: APXvYqy/lkRrNpmJrpoYgdK6XnLo134MvNem080wRLc6uvljUbFYP0Soen+8dqGQrJCRIdt6OgUUPg==
X-Received: by 2002:aa7:820c:: with SMTP id k12mr27039023pfi.177.1556028584870;
        Tue, 23 Apr 2019 07:09:44 -0700 (PDT)
Received: from asus.site ([2601:647:4000:5dd1:a41e:80b4:deb3:fb66])
        by smtp.gmail.com with ESMTPSA id j14sm20863344pfa.57.2019.04.23.07.09.43
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 23 Apr 2019 07:09:43 -0700 (PDT)
Subject: Re: next-20190408..0418: Suspend/resume problems on Thinkpad X60
To:     Pavel Machek <pavel@ucw.cz>,
        kernel list <linux-kernel@vger.kernel.org>, rjw@rjwysocki.net,
        linux-pm@vger.kernel.org, sfr@canb.auug.org.au,
        linux-next@vger.kernel.org, hdegoede@redhat.com, axboe@kernel.dk,
        linux-ide@vger.kernel.org
References: <20190408173928.GB13260@amd> <20190412102812.GA24977@amd>
 <20190423102239.GA15531@amd>
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
Message-ID: <fed0549d-a789-294c-d899-304911106113@acm.org>
Date:   Tue, 23 Apr 2019 07:09:42 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190423102239.GA15531@amd>
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 4/23/19 3:22 AM, Pavel Machek wrote:
>>> It boots ok (unlike mainline -- I'm debugging that), and I can suspend
>>> and resume... but then cursor in X is moving and I can talk to
>>> applications cached in memory, but any access to disk hangs.
>>
>> Mainline problem was identified.
>>
>> But resume is still broken. I took advantage of fact that I can still
>> do cached commands, and got complete dmesg. I'm attaching it.
> 
> Still broken in 0418. Ideas would be welcome at this point.

Have you already tried the debugging steps explained in
Documentation/power to obtain more information about the nature of the
suspend/resume problem?

Bart.
