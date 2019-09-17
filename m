Return-Path: <SRS0=bFUY=XM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 67667C4CEC9
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Sep 2019 19:34:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4398420578
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Sep 2019 19:34:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727150AbfIQTeN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 17 Sep 2019 15:34:13 -0400
Received: from mx1.redhat.com ([209.132.183.28]:53791 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726583AbfIQTeN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Sep 2019 15:34:13 -0400
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com [209.85.221.70])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id B57828666C
        for <linux-kernel@vger.kernel.org>; Tue, 17 Sep 2019 19:34:12 +0000 (UTC)
Received: by mail-wr1-f70.google.com with SMTP id q10so1643249wro.22
        for <linux-kernel@vger.kernel.org>; Tue, 17 Sep 2019 12:34:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
         :date:user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=oyRZ9yRbWvPLYJ7xJ/RWX6c9dvFuQeGVTO5kSpbtosY=;
        b=reNOtJvh1KMpBYr3Zi5pLcZ8Y6Vuy/YjSWQ0joJUsUsLyWX8X6TJf6aG6i2MZLflhq
         Z2EgaaTlg0T99KVPeLNzggFkzVHK4CDyxRTHHxcdNKe5JUfyaXE6FdXzx1jqDaeB5vJ7
         tqpXb/yt9BjRY7qNtItxD5KnWYKZjWehN3RB6b2xzluLoWPJ63cULOvi7j2W05NwASls
         tWKPMRT/kwSsHWNuaRaCjPUmx8RiR3EMVnudBQVUv+wNhuTFBjY7If7ELmcgfFznifH2
         2Iu//R4+wS4SJ2fbTJcJ9sIAlvYj3lh6Tu72QyEQkFvj09dsXhk7ZsQk7bpMixbcx8fa
         ARmA==
X-Gm-Message-State: APjAAAUQucGu2Y5MmkN5XcICRrO23R9V5qBHPkUa1Srn3yJTr4SUebws
        rgDiLPV/7r69p/49qRVMSU5zDpo6Es5cxO3SiqG4is1Y9KSuyV32We3hN8D18WT901BGvxnfF3P
        oXW0utzvo68UwpAJHbST0xxsh
X-Received: by 2002:a1c:f30d:: with SMTP id q13mr4415673wmq.60.1568748851292;
        Tue, 17 Sep 2019 12:34:11 -0700 (PDT)
X-Google-Smtp-Source: APXvYqx3xHb0JukXUbTTMqcE+trhGmnmjzDMa5Z3XBlqh10WpRucLlMRP54wV5iwJ6ivbZUAj4q45A==
X-Received: by 2002:a1c:f30d:: with SMTP id q13mr4415656wmq.60.1568748850969;
        Tue, 17 Sep 2019 12:34:10 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:c111:7acd:8e1e:ee6f? ([2001:b07:6468:f312:c111:7acd:8e1e:ee6f])
        by smtp.gmail.com with ESMTPSA id a18sm6896472wrh.25.2019.09.17.12.34.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 17 Sep 2019 12:34:10 -0700 (PDT)
Subject: Re: [PATCH] kvm: x86: Use DEFINE_DEBUGFS_ATTRIBUTE for debugfs files
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Yi Wang <wang.yi59@zte.com.cn>, rkrcmar@redhat.com,
        tglx@linutronix.de, mingo@redhat.com, bp@alien8.de, hpa@zytor.com,
        x86@kernel.org, kvm@vger.kernel.org, linux-kernel@vger.kernel.org,
        xue.zhihong@zte.com.cn, up2wing@gmail.com, wang.liang82@zte.com.cn
References: <1563780839-14739-1-git-send-email-wang.yi59@zte.com.cn>
 <31eec57f-2bc8-0ea0-e5fb-6b21ce902aae@redhat.com>
 <20190917181240.GA1572563@kroah.com>
From:   Paolo Bonzini <pbonzini@redhat.com>
Openpgp: preference=signencrypt
Message-ID: <533b250a-56c4-34c9-c294-15ee19ed4e65@redhat.com>
Date:   Tue, 17 Sep 2019 21:34:08 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190917181240.GA1572563@kroah.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 17/09/19 20:12, Greg Kroah-Hartman wrote:
> On Tue, Sep 17, 2019 at 07:18:33PM +0200, Paolo Bonzini wrote:
>> On 22/07/19 09:33, Yi Wang wrote:
>>> We got these coccinelle warning:
>>> ./arch/x86/kvm/debugfs.c:23:0-23: WARNING: vcpu_timer_advance_ns_fops
>>> should be defined with DEFINE_DEBUGFS_ATTRIBUTE
>>> ./arch/x86/kvm/debugfs.c:32:0-23: WARNING: vcpu_tsc_offset_fops should
>>> be defined with DEFINE_DEBUGFS_ATTRIBUTE
>>> ./arch/x86/kvm/debugfs.c:41:0-23: WARNING: vcpu_tsc_scaling_fops should
>>> be defined with DEFINE_DEBUGFS_ATTRIBUTE
>>> ./arch/x86/kvm/debugfs.c:49:0-23: WARNING: vcpu_tsc_scaling_frac_fops
>>> should be defined with DEFINE_DEBUGFS_ATTRIBUTE
>>>
>>> Use DEFINE_DEBUGFS_ATTRIBUTE() rather than DEFINE_SIMPLE_ATTRIBUTE()
>>> to fix this.
>>>
>>> Signed-off-by: Yi Wang <wang.yi59@zte.com.cn>
>>
>> It sucks though that you have to use a function with "unsafe" in the name.
> 
> I agree, why make this change?
> 
>> Greg, is the patch doing the right thing?
> 
> I can't tell.  What coccinelle script generated this patch?

Seems to be scripts/coccinelle/api/debugfs/debugfs_simple_attr.cocci.

//# Rationale: DEFINE_SIMPLE_ATTRIBUTE + debugfs_create_file()
//# imposes some significant overhead as compared to
//# DEFINE_DEBUGFS_ATTRIBUTE + debugfs_create_file_unsafe().

Paolo

> thanks,
> 
> greg k-h
> 

