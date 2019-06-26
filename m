Return-Path: <SRS0=hRvo=UZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1596DC48BD6
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Jun 2019 12:10:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E609F20B1F
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Jun 2019 12:10:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727323AbfFZMK4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Jun 2019 08:10:56 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:42761 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726131AbfFZMKz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Jun 2019 08:10:55 -0400
Received: by mail-wr1-f66.google.com with SMTP id x17so2439985wrl.9
        for <linux-kernel@vger.kernel.org>; Wed, 26 Jun 2019 05:10:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=9Fy5r+CcybLkgqizhpcEMO9CkuvE4eogqAqSodMLv4o=;
        b=LYFfMZSaXsY/Xy927iXBntsOZxsEOafMjmiW8zFtdBhoY+IwbqD1SUvsxcds+YqnTI
         CioY0/pHg0Lsmq6/K2gcqVYOXi2G/qVAFFRN/ZmO3KC4LcxlOVWazE6tlaY/TML9O2F7
         rgL4cU0xL9x4WVfZMYFX5hd1eBpuTHiHZljnax1aPbTa+b3T2VGvKQ3mXE6U9mvTp6mf
         hlMcrdKCyeeq5Yf8s2cH5tcvUcCxNqkFXcMFd2WPgSXCYEd8vSHhT248OovFRNUKgmXB
         pEb/HHIOOL9lyvYZEsA1VrfVm/GbG1MN2yWODbxsH12HLZdZGx7Y2xeRVn0ylhuM0UIx
         Qd7Q==
X-Gm-Message-State: APjAAAXJtC3yaazJ51arXvz3lhCaM90AalbDjt9xXsfg0Kj81WXT7lTb
        PIyje1Re0QTVgK0tN/3CrSOdwthHaOOxDQ==
X-Google-Smtp-Source: APXvYqywxu4LW+QmiWawPPqTqo8BLDzTZPpf2KNEYpQW4BuKrzXDIchGU7Ft4v4pYOKdBagHiAj/5g==
X-Received: by 2002:adf:dfc5:: with SMTP id q5mr3653535wrn.142.1561551052960;
        Wed, 26 Jun 2019 05:10:52 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:e88d:856c:e081:f67d? ([2001:b07:6468:f312:e88d:856c:e081:f67d])
        by smtp.gmail.com with ESMTPSA id o2sm15884318wrq.56.2019.06.26.05.10.52
        (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
        Wed, 26 Jun 2019 05:10:52 -0700 (PDT)
Subject: Re: [PATCH] x86/kvm/nVMCS: fix VMCLEAR when Enlightened VMCS is in
 use
To:     Vitaly Kuznetsov <vkuznets@redhat.com>,
        Liran Alon <liran.alon@oracle.com>
Cc:     kvm@vger.kernel.org, linux-kernel@vger.kernel.org,
        =?UTF-8?B?UmFkaW0gS3LEjW3DocWZ?= <rkrcmar@redhat.com>
References: <20190624133028.3710-1-vkuznets@redhat.com>
 <CEFF2A14-611A-417C-BC0A-8814862F26C6@oracle.com>
 <87r27jdq68.fsf@vitty.brq.redhat.com>
From:   Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <9d54ff67-cf30-5e56-954d-6d7a4a8e87f7@redhat.com>
Date:   Wed, 26 Jun 2019 14:10:51 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <87r27jdq68.fsf@vitty.brq.redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 24/06/19 16:16, Vitaly Kuznetsov wrote:
>>> 	gpa_t vmptr;
>>> +	u64 evmptr;
>> I prefer to rename evmptr to evmcs_ptr. I think it’s more readable and sufficiently short.
>>
> Sure.
> 

Let's make it evmcs_gpa instead.  "*_ptr" or "p_*" should be for host
pointers.

Paolo
