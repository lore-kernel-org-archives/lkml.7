Return-Path: <SRS0=GkzU=Y7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 34354C5DF61
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Nov 2019 11:12:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0450A2087E
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Nov 2019 11:12:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388347AbfKGLMK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 Nov 2019 06:12:10 -0500
Received: from mx1.redhat.com ([209.132.183.28]:33310 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388225AbfKGLMJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Nov 2019 06:12:09 -0500
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com [209.85.128.70])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 06FF77C0B8
        for <linux-kernel@vger.kernel.org>; Thu,  7 Nov 2019 11:12:09 +0000 (UTC)
Received: by mail-wm1-f70.google.com with SMTP id 199so888982wmb.0
        for <linux-kernel@vger.kernel.org>; Thu, 07 Nov 2019 03:12:08 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
         :date:user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=wb7dO8DsKF7yscVCT8cl3F3QgHxyR2FGMLetiHh29tE=;
        b=ZWigWptvMnIxcdKST+Tp0QCBDE5YVV7zZYdjz51VUXK5yDodXSx01mhWDs1Ck5R6e2
         gJ0O8ANZJxTAO01GwYTp3MVtcNpoxAxgblF00H9DtCR2uKeooMEpWbyrm04auKdV9bA7
         hPaJ5UpbUx6hzH9CHPBDK0AimXvnW6vnFIYxEQ6w7451NWxrvJiQzGkWD2r1f4eMJFLd
         a469ENf2djJZrz5MCXOMqkCTvcD8A4idbpuseD5zXHp+B+g+eBBIVq3cDzEBSqQHHMMm
         4UaeSR0XYkJIlln9t1SFZze28C3gv7eFe3GoItftnSqTX1EGzq4B6b8n6MC3NbBZL0FR
         90rA==
X-Gm-Message-State: APjAAAVZ372Ck0zP305CA2ZygWzIrECS5J5lh3YX7rdc3YLyRSeJC4q6
        SXf9a960zgrZfdEsR5CAwMKg2ujJnarNvZVcAepcwDZcJM/nx+Ot4hGjGOikh5WsP2pi0Ag9Cgc
        bMmExZ0PoAEXT/LSJflhDog+T
X-Received: by 2002:adf:ea42:: with SMTP id j2mr2286529wrn.384.1573125127617;
        Thu, 07 Nov 2019 03:12:07 -0800 (PST)
X-Google-Smtp-Source: APXvYqzsSQDxaFh5QeJ49rl6vQ2cGJ313lfE7wHNWd3mB8/6HiMhtvtIu+qvazulIg9vS3Pv7aJksw==
X-Received: by 2002:adf:ea42:: with SMTP id j2mr2286502wrn.384.1573125127327;
        Thu, 07 Nov 2019 03:12:07 -0800 (PST)
Received: from [10.201.49.199] (nat-pool-mxp-u.redhat.com. [149.6.153.187])
        by smtp.gmail.com with ESMTPSA id w19sm1678225wmk.36.2019.11.07.03.12.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 07 Nov 2019 03:12:06 -0800 (PST)
Subject: Re: [PATCH 1/2] KVM: MMU: Do not treat ZONE_DEVICE pages as being
 reserved
To:     Dan Williams <dan.j.williams@intel.com>,
        Sean Christopherson <sean.j.christopherson@intel.com>
Cc:     =?UTF-8?B?UmFkaW0gS3LEjW3DocWZ?= <rkrcmar@redhat.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Joerg Roedel <joro@8bytes.org>, KVM list <kvm@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Adam Borowski <kilobyte@angband.pl>,
        David Hildenbrand <david@redhat.com>
References: <20191106170727.14457-1-sean.j.christopherson@intel.com>
 <20191106170727.14457-2-sean.j.christopherson@intel.com>
 <CAPcyv4gJk2cXLdT2dZwCH2AssMVNxUfdx-bYYwJwy1LwFxOs0w@mail.gmail.com>
 <1cf71906-ba99-e637-650f-fc08ac4f3d5f@redhat.com>
 <CAPcyv4hMOxPDKAZtTvWKEMPBwE_kPrKPB_JxE2YfV5EKkKj_dQ@mail.gmail.com>
 <20191106233913.GC21617@linux.intel.com>
 <CAPcyv4jysxEu54XK2kUYnvTqUL7zf2fJvv7jWRR=P4Shy+3bOQ@mail.gmail.com>
 <CAPcyv4i3M18V9Gmx3x7Ad12VjXbq94NsaUG9o71j59mG9-6H9Q@mail.gmail.com>
From:   Paolo Bonzini <pbonzini@redhat.com>
Openpgp: preference=signencrypt
Message-ID: <0db7c328-1543-55db-bc02-c589deb3db22@redhat.com>
Date:   Thu, 7 Nov 2019 12:12:03 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <CAPcyv4i3M18V9Gmx3x7Ad12VjXbq94NsaUG9o71j59mG9-6H9Q@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 07/11/19 06:48, Dan Williams wrote:
>> How do mmu notifiers get held off by page references and does that
>> machinery work with ZONE_DEVICE? Why is this not a concern for the
>> VM_IO and VM_PFNMAP case?
> Put another way, I see no protection against truncate/invalidate
> afforded by a page pin. If you need guarantees that the page remains
> valid in the VMA until KVM can install a mmu notifier that needs to
> happen under the mmap_sem as far as I can see. Otherwise gup just
> weakly asserts "this pinned page was valid in this vma at one point in
> time".

The MMU notifier is installed before gup, so any invalidation will be
preceded by a call to the MMU notifier.  In turn,
invalidate_range_start/end is called with mmap_sem held so there should
be no race.

However, as Sean mentioned, early put_page of ZONE_DEVICE pages would be
racy, because we need to keep the reference between the gup and the last
time we use the corresponding struct page.

Based on this, I think Sean's patches should work fine, and I prefer
them over David's approach.  Either way, adding some documentation is in
order.

Paolo
