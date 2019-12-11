Return-Path: <SRS0=Yvat=2B=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 958E4C43603
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Dec 2019 09:08:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6698A21556
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Dec 2019 09:08:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="eUU0+R8r"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728426AbfLKJIF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 11 Dec 2019 04:08:05 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:56926 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1727298AbfLKJIC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Dec 2019 04:08:02 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1576055281;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=y+7CWlGvo3J1aqX5URICLxANHtApPrtUz6Ly50hT0k8=;
        b=eUU0+R8rlkWJu6UV9lzVPzoCZe/eXLpqO0TlaFKr4wVW20lMflNVcbcrp/AsJQYx6b0FG1
        rwDmHqkWrbI1LRQJgY5RQ68DkkRx37LJu1+fBMhCFAr0TpKY2w3pZazRi4v+SRM0G9u5rz
        DlCL53n2J2Q4vxNpAiveveooJ3dyDLU=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-292-5yr6ZlW0PUa1ibMDGNfRww-1; Wed, 11 Dec 2019 04:07:57 -0500
Received: by mail-wr1-f70.google.com with SMTP id k18so3598890wrw.9
        for <linux-kernel@vger.kernel.org>; Wed, 11 Dec 2019 01:07:57 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=y+7CWlGvo3J1aqX5URICLxANHtApPrtUz6Ly50hT0k8=;
        b=qRkyKZGOwAxFKdKfYIi9MV3ZXFAQNvdIwNvb0nE3cbXI47Q0k8Dy6vdRSHB/bKid/9
         y6BTw69pgw802v45DowosLQVhUfT03YRsF2wRtXrItFKbru9wVKbNAFVwbUwdC9FbqgG
         QmBhMm55WWRnxj0okJEDgysZrvdaPUK8ittDKWKNA6FDFEFw1ZdaBVWJIi+DLrru/1Hi
         xqyb6NqmVlXtruBQeKqrSyqrBNqOwvleGwWmsw/nroBpYNq/fWfaX/MK7mry6Y1mC/5x
         NzGE0sENKqSiotJe55u2sU9jS9rVva0ZCq9OCS1ht6Tf8GRl3e/m+qVOFAK2f0IZsB6d
         L5Ew==
X-Gm-Message-State: APjAAAUK38Hrxe0kW6u0bwoVNo4v2IU6zQvVWfCTiIPyKQCuaVsZzium
        EDGFyLa/brl6wPt8qNTbxjySiVvVCzvlI7vJpCk5Gfi1cyfTqFVG/i9JRZpuSb+X3VEqvMyUhcy
        pWuwZS/HkYU74bKC/weEkvAjC
X-Received: by 2002:a5d:4fd0:: with SMTP id h16mr2392694wrw.255.1576055276749;
        Wed, 11 Dec 2019 01:07:56 -0800 (PST)
X-Google-Smtp-Source: APXvYqyk530KPtCatGmVOoZqOVtdEa4CHIdMd2QUgErjQSW25mSow9KbdltraJ00JOs309bCAh7DDw==
X-Received: by 2002:a5d:4fd0:: with SMTP id h16mr2392670wrw.255.1576055276544;
        Wed, 11 Dec 2019 01:07:56 -0800 (PST)
Received: from ?IPv6:2001:b07:6468:f312:e9bb:92e9:fcc3:7ba9? ([2001:b07:6468:f312:e9bb:92e9:fcc3:7ba9])
        by smtp.gmail.com with ESMTPSA id g2sm1496891wrw.76.2019.12.11.01.07.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 11 Dec 2019 01:07:55 -0800 (PST)
Subject: Re: [PATCH v2] KVM: x86: use CPUID to locate host page table reserved
 bits
To:     "Huang, Kai" <kai.huang@intel.com>,
        "thomas.lendacky@amd.com" <thomas.lendacky@amd.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "kvm@vger.kernel.org" <kvm@vger.kernel.org>
Cc:     "Christopherson, Sean J" <sean.j.christopherson@intel.com>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
References: <1575474037-7903-1-git-send-email-pbonzini@redhat.com>
 <8f7e3e87-15dc-2269-f5ee-c3155f91983c@amd.com>
 <7b885f53-e0d3-2036-6a06-9cdcbb738ae2@redhat.com>
 <3efabf0da4954239662e90ea08d99212a654977a.camel@intel.com>
From:   Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <62438ac9-e186-32a7-d12f-5806054d56b2@redhat.com>
Date:   Wed, 11 Dec 2019 10:07:55 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
MIME-Version: 1.0
In-Reply-To: <3efabf0da4954239662e90ea08d99212a654977a.camel@intel.com>
Content-Language: en-US
X-MC-Unique: 5yr6ZlW0PUa1ibMDGNfRww-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/12/19 01:11, Huang, Kai wrote:
>> kvm_get_shadow_phys_bits() must be conservative in that:
>>
>> 1) if a bit is reserved it _can_ return a value higher than its index
>>
>> 2) if a bit is used by the processor (for physical address or anything
>> else) it _must_ return a value higher than its index.
>>
>> In the SEV case we're not obeying (2), because the function returns 43
>> when the C bit is bit 47.  The patch fixes that.
> Could we guarantee that C-bit is always below bits reported by CPUID?

That's a question for AMD. :)  The C bit can move (and probably will,
otherwise they wouldn't have bothered adding it to CPUID) in future
generations of the processor.

Paolo

