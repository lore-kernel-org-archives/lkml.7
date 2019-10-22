Return-Path: <SRS0=qxzQ=YP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B510ECA9EA0
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Oct 2019 13:42:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 91A0020700
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Oct 2019 13:42:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388844AbfJVNmk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 22 Oct 2019 09:42:40 -0400
Received: from mx1.redhat.com ([209.132.183.28]:54710 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731218AbfJVNmk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Oct 2019 09:42:40 -0400
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com [209.85.221.70])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id DEC4485365
        for <linux-kernel@vger.kernel.org>; Tue, 22 Oct 2019 13:42:39 +0000 (UTC)
Received: by mail-wr1-f70.google.com with SMTP id 7so9253585wrl.2
        for <linux-kernel@vger.kernel.org>; Tue, 22 Oct 2019 06:42:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
         :date:user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=05dJAtGauU0iv5NowbhOU9V3c7+LulyhjnirlWXm1KU=;
        b=Mnu1s5hcpytI19+FEAgdWNeJ5lats6GO174GgfiHj7dq1DYbk6Ny/0q0KBN9vgRKbd
         lRkT4j58PAji1mJAIFRwakBMuiZU+45RiSAO5kvC7YJcuW5qDbmCok2vNkx8/M7U6o4J
         xTF5giqmqnnaZOz5mbL0hYKaDj5TBU9p9gnsEwrvOOyW0WOhOQXgD8TQY6wLmecH34QQ
         Ksrf4MwR3XDuOXwaINzgBs/n7tsz3SwvpBocId1ZTxFpyDuS2PgrpeVGMRwbPrbPNbrV
         JwX3SbLdSOQQmiMN+p139DwIXDFOHcjoQJ8pkTKE10le40nhg6r5qqaRPd17GzZM9l2v
         cdkA==
X-Gm-Message-State: APjAAAW295ODZpWsLFvXbzftd+FbtasX7uCZ4qcS+63bh/DsympBIF5r
        OjfxzlkRUpUcH6F42+izPIUooFkJf/sM++dF8JVfrwN9dFXSEgY7HEUOhLp+bgqvFoPAqg0c3VA
        o+dKXG6J6vq1lne5x2TelWfqC
X-Received: by 2002:a05:600c:1107:: with SMTP id b7mr3339166wma.151.1571751758408;
        Tue, 22 Oct 2019 06:42:38 -0700 (PDT)
X-Google-Smtp-Source: APXvYqzMh5FUqHuanmjm92TrlNFZyUpguRk5xXpG2bL4t+/5nKpwjNbkxF5tNwPtsN6voB8mSIllyw==
X-Received: by 2002:a05:600c:1107:: with SMTP id b7mr3339133wma.151.1571751758104;
        Tue, 22 Oct 2019 06:42:38 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:c0e4:dcf4:b543:ce19? ([2001:b07:6468:f312:c0e4:dcf4:b543:ce19])
        by smtp.gmail.com with ESMTPSA id p20sm14205910wmc.23.2019.10.22.06.42.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 22 Oct 2019 06:42:37 -0700 (PDT)
Subject: Re: [PATCH v3 0/4] Minor cleanup and refactor about vmcs
To:     Xiaoyao Li <xiaoyao.li@intel.com>,
        =?UTF-8?B?UmFkaW0gS3LEjW3DocWZ?= <rkrcmar@redhat.com>,
        Sean Christopherson <sean.j.christopherson@intel.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Jim Mattson <jmattson@google.com>,
        Joerg Roedel <joro@8bytes.org>
Cc:     Krish Sadhukhan <krish.sadhukhan@oracle.com>, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20191020091101.125516-1-xiaoyao.li@intel.com>
From:   Paolo Bonzini <pbonzini@redhat.com>
Openpgp: preference=signencrypt
Message-ID: <1dcf5ad8-bca9-c797-e0f8-3fd25c8ea5ca@redhat.com>
Date:   Tue, 22 Oct 2019 15:42:36 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20191020091101.125516-1-xiaoyao.li@intel.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 20/10/19 11:10, Xiaoyao Li wrote:
> There is no functional changs, just some cleanup and renaming to increase
> readability.
> 
> Patch 1 is newly added from v2.
> Patcd 2 and 3 is seperated from Patch 4.
> 
> Xiaoyao Li (4):
>   KVM: VMX: Write VPID to vmcs when creating vcpu
>   KVM: VMX: Remove vmx->hv_deadline_tsc initialization from
>     vmx_vcpu_setup()
>   KVM: VMX: Initialize vmx->guest_msrs[] right after allocation
>   KVM: VMX: Rename {vmx,nested_vmx}_vcpu_setup()
> 
>  arch/x86/kvm/vmx/nested.c |  2 +-
>  arch/x86/kvm/vmx/nested.h |  2 +-
>  arch/x86/kvm/vmx/vmx.c    | 50 +++++++++++++++++++--------------------
>  3 files changed, 26 insertions(+), 28 deletions(-)
> 

Queued, thanks.

Paolo
