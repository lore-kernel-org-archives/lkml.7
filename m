Return-Path: <SRS0=J4ZE=RP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 54934C43381
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Mar 2019 14:25:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 271812075C
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Mar 2019 14:25:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726744AbfCLOZB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Mar 2019 10:25:01 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:38680 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726325AbfCLOZB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Mar 2019 10:25:01 -0400
Received: by mail-pg1-f196.google.com with SMTP id m2so1960669pgl.5
        for <linux-kernel@vger.kernel.org>; Tue, 12 Mar 2019 07:25:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=JVtjTgwXpS+F36W6pTKl2sgAGbR0g7swMsIvnMxPdXI=;
        b=FrqKcK5UQbRetI4kfOSDeNCZFax6XfnJnYwVrmb25lLyvFTwqCaUgBkw5amzH+qGnn
         r5ngABdKM3VoPka6wfXgupi3u/kyZ3Fv48H0X/djPVdXouHc0yM+d7j4x9U+trs+K94m
         CdlSBZ2Kt8JmpPYpoLHeHuX+y+u8xwmcoMCD36s6wqKKUPcu7HTxr36/S0PGyc0Onubj
         yUmDvciWY/kF/gSp9LMVeS3r+Mc8bwiEq7o7Nxu7C+ho7fCiWHCpsKM88MhfUszahQiR
         aeylr+yV11XFJYapO3g0IbC3BL3QK3PfFQdYSRnc3VEtMVx9i+MkM0xVYIMl41TmvxSu
         VhdQ==
X-Gm-Message-State: APjAAAXGTNJOnusa+/bPNz+2URaFXaxFZ2VXQ7WfG5ezw+X4pgsqHTC4
        8eeJ7nNykv9GusyqhIFbY0xT0A==
X-Google-Smtp-Source: APXvYqy/lZGxY05IxZmj/bjio5X3k/2VTVwc6tTbffOlATD8kE0l5KCBmKSisZ7AgbuRRARTZhJkfA==
X-Received: by 2002:aa7:8c97:: with SMTP id p23mr39726199pfd.229.1552400699994;
        Tue, 12 Mar 2019 07:24:59 -0700 (PDT)
Received: from localhost.localdomain ([106.215.118.61])
        by smtp.gmail.com with ESMTPSA id z15sm16451189pgc.25.2019.03.12.07.24.52
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 12 Mar 2019 07:24:58 -0700 (PDT)
Subject: Re: [PATCH v2 0/2] Append new variables to vmcoreinfo (PTRS_PER_PGD
 for arm64 and MAX_PHYSMEM_BITS for all archs)
To:     Dave Young <dyoung@redhat.com>
Cc:     linux-kernel@vger.kernel.org, Mark Rutland <mark.rutland@arm.com>,
        Kazuhito Hagio <k-hagio@ab.jp.nec.com>,
        Michael Ellerman <mpe@ellerman.id.au>, x86@kernel.org,
        Will Deacon <will.deacon@arm.com>,
        linuxppc-dev@lists.ozlabs.org, kexec@lists.infradead.org,
        James Morse <james.morse@arm.com>,
        linux-arm-kernel@lists.infradead.org,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Boris Petkov <bp@alien8.de>,
        Thomas Gleixner <tglx@linutronix.de>, bhupesh.linux@gmail.com,
        Dave Anderson <anderson@redhat.com>,
        Ingo Molnar <mingo@kernel.org>,
        Paul Mackerras <paulus@samba.org>
References: <1552212242-9479-1-git-send-email-bhsharma@redhat.com>
 <20190311090553.GA12130@dhcp-128-65.nay.redhat.com>
From:   Bhupesh Sharma <bhsharma@redhat.com>
Message-ID: <409a4754-0d01-6eab-2524-94d88bbc609b@redhat.com>
Date:   Tue, 12 Mar 2019 19:54:49 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.2.1
MIME-Version: 1.0
In-Reply-To: <20190311090553.GA12130@dhcp-128-65.nay.redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Dave,

On 03/11/2019 02:35 PM, Dave Young wrote:
> Hi Bhupesh,
> On 03/10/19 at 03:34pm, Bhupesh Sharma wrote:
>> Changes since v1:
>> ----------------
>> - v1 was sent out as a single patch which can be seen here:
>>    http://lists.infradead.org/pipermail/kexec/2019-February/022411.html
>>
>> - v2 breaks the single patch into two independent patches:
>>    [PATCH 1/2] appends 'PTRS_PER_PGD' to vmcoreinfo for arm64 arch, whereas
>>    [PATCH 2/2] appends 'MAX_PHYSMEM_BITS' to vmcoreinfo in core kernel code (all archs)
>>
>> This patchset primarily fixes the regression reported in user-space
>> utilities like 'makedumpfile' and 'crash-utility' on arm64 architecture
>> with the availability of 52-bit address space feature in underlying
>> kernel. These regressions have been reported both on CPUs which don't
>> support ARMv8.2 extensions (i.e. LVA, LPA) and are running newer kernels
>> and also on prototype platforms (like ARMv8 FVP simulator model) which
>> support ARMv8.2 extensions and are running newer kernels.
>>
>> The reason for these regressions is that right now user-space tools
>> have no direct access to these values (since these are not exported
>> from the kernel) and hence need to rely on a best-guess method of
>> determining value of 'PTRS_PER_PGD' and 'MAX_PHYSMEM_BITS' supported
>> by underlying kernel.
>>
>> Exporting these values via vmcoreinfo will help user-land in such cases.
>> In addition, as per suggestion from makedumpfile maintainer (Kazu)
>> during v1 review, it makes more sense to append 'MAX_PHYSMEM_BITS' to
>> vmcoreinfo in the core code itself rather than in arm64 arch-specific
>> code, so that the user-space code for other archs can also benefit from
>> this addition to the vmcoreinfo and use it as a standard way of
>> determining 'SECTIONS_SHIFT' value in user-land.
>>
>> Cc: Mark Rutland <mark.rutland@arm.com>
>> Cc: James Morse <james.morse@arm.com>
>> Cc: Will Deacon <will.deacon@arm.com>
>> Cc: Boris Petkov <bp@alien8.de>
>> Cc: Ingo Molnar <mingo@kernel.org>
>> Cc: Thomas Gleixner <tglx@linutronix.de>
>> Cc: Michael Ellerman <mpe@ellerman.id.au>
>> Cc: Paul Mackerras <paulus@samba.org>
>> Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>
>> Cc: Dave Anderson <anderson@redhat.com>
>> Cc: Kazuhito Hagio <k-hagio@ab.jp.nec.com>
>> Cc: x86@kernel.org
>> Cc: linuxppc-dev@lists.ozlabs.org
>> Cc: linux-arm-kernel@lists.infradead.org
>> Cc: linux-kernel@vger.kernel.org
>> Cc: kexec@lists.infradead.org
>>
>> Bhupesh Sharma (2):
>>    arm64, vmcoreinfo : Append 'PTRS_PER_PGD' to vmcoreinfo
>>    crash_core, vmcoreinfo: Append 'MAX_PHYSMEM_BITS' to vmcoreinfo
>>
>>   arch/arm64/kernel/crash_core.c | 1 +
>>   kernel/crash_core.c            | 1 +
>>   2 files changed, 2 insertions(+)
>>
> 
> Lianbo's document patch has been merged, would you mind to add vmcoreinfo doc
> patch as well in your series?

Thanks for the inputs. Will add it to the v3.
Let's wait for other comments/reviews, before I spin a version 3.

Regards,
Bhupesh

