Return-Path: <SRS0=4nbc=R5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9B688C43381
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Mar 2019 00:55:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6BCBC2075D
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Mar 2019 00:55:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730260AbfCZAy7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Mar 2019 20:54:59 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:42431 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727099AbfCZAy7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Mar 2019 20:54:59 -0400
Received: by mail-pg1-f196.google.com with SMTP id p6so7403722pgh.9
        for <linux-kernel@vger.kernel.org>; Mon, 25 Mar 2019 17:54:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=bYSG6hUGsR8EH+eIiuJD9+PUTT4/tSHKBhZHk5Ht2hk=;
        b=iLUxORye4fHtZcsabyTnIeE5cfIBqNdX8Tm3N4Yzx/APSBNrRHekKYca0+VZ7yHveB
         nMvFxqHw8WlPr/IsT5/YunqCbwCAblpPHBZjKlnio2TZE2FY1VYzDcbOChjmgjEr5gyf
         rwnUoYy4P/3vSVVZiKMOACkeoxdVmZ7M3YXxt6XiTUnIK5d38CQxtnuvHWGfYnx7ho/C
         xrkGmF/C8vg2I/TrRdap44ExJaJkDFr6M00rCk1RN67zcjXDCFg2hY5O+V6MlIB39gbl
         RulvHBXAa8gYIJk5m2CgVG6U4Nn6ZFdw4/uc1+JOxyx9elg+P0/NjM0rtfEn64Oj49tx
         +oPQ==
X-Gm-Message-State: APjAAAWM6+BxIT/v8v1wTRt79/HDCOC6wZYzbOwnXITUVxE1QM9cyJJs
        Dzd6kfzmkzG2KFNCqcPX3ShKVG2HSq4=
X-Google-Smtp-Source: APXvYqxZMdPEv2UUqHau8gSmkvW9+wYEGrCcE7pRlJfJJb8O46ra5ZVSArLC06mv5cM3EtCPBuTB7A==
X-Received: by 2002:a63:da43:: with SMTP id l3mr26571052pgj.164.1553561698307;
        Mon, 25 Mar 2019 17:54:58 -0700 (PDT)
Received: from asus.site ([2601:647:4000:5dd1:a41e:80b4:deb3:fb66])
        by smtp.gmail.com with ESMTPSA id d11sm2840928pgq.6.2019.03.25.17.54.56
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 25 Mar 2019 17:54:57 -0700 (PDT)
Subject: Re: "cat /proc/lockdep" after "rmmod <some module>" when !debug_locks
 will crash the system
To:     shenghui <shhuiw@foxmail.com>, peterz@infradead.org,
        mingo@redhat.com, will.deacon@arm.com, linux-kernel@vger.kernel.org
References: <5c98a345.1c69fb81.21300.0be5SMTPIN_ADDED_BROKEN@mx.google.com>
 <1553533600.118779.12.camel@acm.org>
 <5c99721b.1c69fb81.5bb69.0006SMTPIN_ADDED_BROKEN@mx.google.com>
From:   Bart Van Assche <bvanassche@acm.org>
Message-ID: <ddf52cb4-2e1f-6ce1-863f-a56084127fee@acm.org>
Date:   Mon, 25 Mar 2019 17:54:56 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.2
MIME-Version: 1.0
In-Reply-To: <5c99721b.1c69fb81.5bb69.0006SMTPIN_ADDED_BROKEN@mx.google.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 3/25/19 5:27 PM, shenghui wrote:
> On 3/26/19 1:06 AM, Bart Van Assche wrote:
>> On Mon, 2019-03-25 at 17:45 +0800, shenghui wrote:
> [   47.103637] vboxdrv: loading out-of-tree module taints kernel.
> [   47.111919] vboxdrv: Found 2 processor cores
> [   47.119013] vboxdrv: fAsync=0 offMin=0x2ee offMax=0x13f7
 > [ ...........] ...
 > [   47.219043] DEBUG_LOCKS_WARN_ON(!current->hardirqs_enabled)
 > [   47.219055] WARNING: CPU: 0 PID: 844 at 
kernel/locking/lockdep.c:4142 check_flags.part.45+0x9e/0x190
> [   47.219142] Call Trace:
> [   47.219148]  lock_acquire+0x3a/0x150
> [   47.219153]  fs_reclaim_acquire.part.106+0x21/0x30
> [   47.219156]  ? fs_reclaim_acquire.part.106+0x5/0x30
> [   47.219159]  fs_reclaim_acquire+0x1d/0x20
> [   47.219163]  __kmalloc+0x4d/0x280
> [   47.219192]  ? rtR0MemAllocEx+0xaf/0x110 [vboxdrv]
> [   47.219210]  ? supdrvGipInitMeasureTscFreq+0x15c/0x460 [vboxdrv]
> [   47.219229]  rtR0MemAllocEx+0xaf/0x110 [vboxdrv]
> [   47.219247]  ? supdrvTscDeltaThreadStartMeasurement.part.5+0x80/0x80 [vboxdrv]
> [   47.219265]  VBoxHost_RTMemAllocTag+0x23/0x50 [vboxdrv]
> [   47.219284]  VBoxHost_RTMpNotificationRegister+0x97/0x170 [vboxdrv]

Hi Shenghui,

I have not found the VBoxHost_RTMpNotificationRegister function name 
anywhere in the kernel tree. I think that means that this warning is 
generated by an out-of-tree driver. Please report this issue to the 
virtualbox maintainers as a kernel v5.1 interoperability bug.

Thanks,

Bart.
