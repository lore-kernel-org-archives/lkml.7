Return-Path: <SRS0=kpxk=YC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2F5B2C47404
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Oct 2019 10:08:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0D078206C0
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Oct 2019 10:08:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730111AbfJIKIG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 9 Oct 2019 06:08:06 -0400
Received: from mx1.redhat.com ([209.132.183.28]:51318 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726765AbfJIKIG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Oct 2019 06:08:06 -0400
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com [209.85.221.72])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 4C6E487638
        for <linux-kernel@vger.kernel.org>; Wed,  9 Oct 2019 10:08:05 +0000 (UTC)
Received: by mail-wr1-f72.google.com with SMTP id n3so879344wrt.9
        for <linux-kernel@vger.kernel.org>; Wed, 09 Oct 2019 03:08:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
         :date:user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=AbYT7LMtNspgYUtLuc1v/mvn663HfzOAgV78ocp3jrQ=;
        b=meu8bdUs/j+LiRFpNIMIomtJ3pQWe8swYOYWsN5CI1ci4RwaCxI89rjcO4dQM5bCBu
         zAC4P2BoLm2r7LrNjWCQl6sWgpYgqm2KbCj5VGjkd2BuzkqXLmyGHQOK28pfdRzHSijv
         bdVTFSQOswr5CuK6a6G+4q7qMepEjp4OnXV1z7qNq+yXcONLiPE6UaKK+rmKEBmOPupO
         0WkFGIfbOQHMEYFMEKTYB2qFhqEb4OZ+teXJZneEIej3Iqtku9WUFuVzY2DTsBc4RTNJ
         4N9PiTRIbBWNCgKEYQktRDvzJ8QLQVV2PLLcuP/hyhKC/kyywTRJLzHIHjCH6JkHYLol
         xcGg==
X-Gm-Message-State: APjAAAUKkdDSd21BYT8zJj6xwWj66HIQhWwAUR/vRM8wgN2vl1BntVux
        5CygoG7YfQV+RvriF0X5+IEdJ0lhTgF542p5p1HQ9TbrFypxhtpckB91LITxrAdWRPMwZe/QUBb
        h02+zqlHI7PWq0QtgGqXeW766
X-Received: by 2002:a5d:4286:: with SMTP id k6mr2108631wrq.292.1570615683882;
        Wed, 09 Oct 2019 03:08:03 -0700 (PDT)
X-Google-Smtp-Source: APXvYqyoLTfumEmNHLXDIg4ArZfA8t/p8MmvsM2zMS3WoBposHcguoCISAv4xqoFdr7PjYFbL7oEkg==
X-Received: by 2002:a5d:4286:: with SMTP id k6mr2108601wrq.292.1570615683604;
        Wed, 09 Oct 2019 03:08:03 -0700 (PDT)
Received: from [192.168.10.150] ([93.56.166.5])
        by smtp.gmail.com with ESMTPSA id q3sm2090140wru.33.2019.10.09.03.08.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 09 Oct 2019 03:08:03 -0700 (PDT)
Subject: Re: [PATCH 0/5] SEV fixes and performance enhancements
To:     "Lendacky, Thomas" <Thomas.Lendacky@amd.com>,
        "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Cc:     =?UTF-8?B?UmFkaW0gS3LEjW3DocWZ?= <rkrcmar@redhat.com>,
        Sean Christopherson <sean.j.christopherson@intel.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Joerg Roedel <joro@8bytes.org>,
        "Singh, Brijesh" <brijesh.singh@amd.com>,
        David Rientjes <rientjes@google.com>
References: <cover.1570137447.git.thomas.lendacky@amd.com>
From:   Paolo Bonzini <pbonzini@redhat.com>
Openpgp: preference=signencrypt
Message-ID: <fdabc7b9-7136-b780-ad2b-5821b7c97269@redhat.com>
Date:   Wed, 9 Oct 2019 12:08:01 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <cover.1570137447.git.thomas.lendacky@amd.com>
Content-Type: text/plain; charset=iso-8859-2
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 03/10/19 23:17, Lendacky, Thomas wrote:
> From: Tom Lendacky <thomas.lendacky@amd.com>
> 
> This patch series provides fixes in the area of ASID assignment and VM
> deactivation.
> 
> Additionally, it provides some performance enhancements by reducing the
> number of WBINVD/DF_FLUSH invocations that are made.
> 
> Note: The third patch in the series modifies a file that is outside of
>       the arch/x86/kvm directory.
> 
> ---
> 
> Patches based on https://git.kernel.org/pub/scm/virt/kvm/kvm.git next
> and commit:
>   fd3edd4a9066 ("KVM: nVMX: cleanup and fix host 64-bit mode checks")
> 
> Tom Lendacky (5):
>   KVM: SVM: Serialize access to the SEV ASID bitmap
>   KVM: SVM: Guard against DEACTIVATE when performing WBINVD/DF_FLUSH
>   KVM: SVM: Remove unneeded WBINVD and DF_FLUSH when starting SEV guests
>   KVM: SVM: Convert DEACTIVATE mutex to read/write semaphore
>   KVM: SVM: Reduce WBINVD/DF_FLUSH invocations
> 
>  arch/x86/kvm/svm.c           | 105 +++++++++++++++++++++++++++--------
>  drivers/crypto/ccp/psp-dev.c |   9 +++
>  2 files changed, 92 insertions(+), 22 deletions(-)
> 

Queued, thanks.  I squashed 4/5 and 5/5 since there's not much that
survives of patch 4 after the next one.

Paolo
