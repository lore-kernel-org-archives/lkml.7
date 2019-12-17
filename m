Return-Path: <SRS0=vnTL=2H=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 11E21C43603
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Dec 2019 22:07:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D9EF820716
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Dec 2019 22:07:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="R2eamx0z"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726530AbfLQWH0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 17 Dec 2019 17:07:26 -0500
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:40676 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726383AbfLQWH0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Dec 2019 17:07:26 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1576620445;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=slGVCNmnwx0F1K+nCa+cID8Tdy/RHxQkOhSUfY0VX6I=;
        b=R2eamx0ztp8pz7IPcz9RmblZYl6+eN8LvL9kfot+w3570WPr4w4p1VcpFN/uWO4ZXZIT1I
        RAWckMLh+jg+57peVgro9o/XAfelXW3hp+rPTXw2CXJe4chfg+fLYM1QCPSVHRQeluSf9e
        HD/eJuxrtwsEcgtygWfDxFr7w7H8Ht8=
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com
 [209.85.160.199]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-335-0dEMDjcPP_qFX6XZKfsajQ-1; Tue, 17 Dec 2019 17:07:21 -0500
X-MC-Unique: 0dEMDjcPP_qFX6XZKfsajQ-1
Received: by mail-qt1-f199.google.com with SMTP id m8so115598qta.20
        for <linux-kernel@vger.kernel.org>; Tue, 17 Dec 2019 14:07:21 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=slGVCNmnwx0F1K+nCa+cID8Tdy/RHxQkOhSUfY0VX6I=;
        b=sBmvMcq6+XPaIJzIzwYlVibVC2iI3B94NKE2O8x3CQAexxc/Ev5AtIwzm3cEGVTm1R
         ESaMlyA1re8G8D0jiPROY6qcK3yOW/9PDqDdWXRtdzJlbiu8VIkYSzXRcx73sH+b7u+P
         0PfzITNW+GrzOjX01fPKJcHJIN4I1S5pfDnzLQcCmah+nROx28IpMYjMSMi2mEZFCyRs
         lU6V4BxGd8Bo9n6RQllNhhJPlUve9o5ckWGZ6Li7M5gXIBKLRo24K2cRzCH7cQVsFz5U
         0mOPXBOaQT2Vui+tUeK/H0MIdfG0sb0tLHcE9YIj5mnS8MjiXgDoq6mXXlr90bvclzwC
         EmQA==
X-Gm-Message-State: APjAAAXxPPQFXHyy6SEw2ECKd+WUo5RiLVOABb/Q5LCaeDWkSXV7vtdM
        ZqsHz5SfXQB4lOc0CvlQ8GaRSkoUoNsxiKPvqrKM9NNm9a6IarDSmqbaHns8SRYRekTyao/Xdm9
        0FJJbujBS29CM0LL0HDcGiSlT
X-Received: by 2002:a0c:f68f:: with SMTP id p15mr6885115qvn.79.1576620441552;
        Tue, 17 Dec 2019 14:07:21 -0800 (PST)
X-Google-Smtp-Source: APXvYqyYYchEVtwDwgk4Pr56pOeSJtWkuin1D2pVTuKZ433b4vaBfoHv6+mbPiSSnU54NveRu8NnwQ==
X-Received: by 2002:a0c:f68f:: with SMTP id p15mr6885088qvn.79.1576620441243;
        Tue, 17 Dec 2019 14:07:21 -0800 (PST)
Received: from xz-x1 ([104.156.64.74])
        by smtp.gmail.com with ESMTPSA id o9sm7592950qko.16.2019.12.17.14.07.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Dec 2019 14:07:20 -0800 (PST)
Date:   Tue, 17 Dec 2019 17:07:18 -0500
From:   Peter Xu <peterx@redhat.com>
To:     Sean Christopherson <sean.j.christopherson@intel.com>
Cc:     James Hogan <jhogan@kernel.org>,
        Paul Mackerras <paulus@ozlabs.org>,
        Christian Borntraeger <borntraeger@de.ibm.com>,
        Janosch Frank <frankja@linux.ibm.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Marc Zyngier <maz@kernel.org>,
        linux-arm-kernel@lists.infradead.org,
        Wanpeng Li <wanpengli@tencent.com>,
        Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <f4bug@amsat.org>,
        kvm@vger.kernel.org, David Hildenbrand <david@redhat.com>,
        Joerg Roedel <joro@8bytes.org>,
        Cornelia Huck <cohuck@redhat.com>, linux-mips@vger.kernel.org,
        linux-kernel@vger.kernel.org, kvm-ppc@vger.kernel.org,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        kvmarm@lists.cs.columbia.edu, Jim Mattson <jmattson@google.com>
Subject: Re: [PATCH v4 05/19] KVM: x86: Allocate memslot resources during
 prepare_memory_region()
Message-ID: <20191217220718.GJ7258@xz-x1>
References: <20191217204041.10815-1-sean.j.christopherson@intel.com>
 <20191217204041.10815-6-sean.j.christopherson@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20191217204041.10815-6-sean.j.christopherson@intel.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 17, 2019 at 12:40:27PM -0800, Sean Christopherson wrote:
> Allocate the various metadata structures associated with a new memslot
> during kvm_arch_prepare_memory_region(), which paves the way for
> removing kvm_arch_create_memslot() altogether.  Moving x86's memory
> allocation only changes the order of kernel memory allocations between
> x86 and common KVM code.
> 
> No functional change intended.

(I still think it's a functional change, though...)

> 
> Signed-off-by: Sean Christopherson <sean.j.christopherson@intel.com>

Reviewed-by: Peter Xu <peterx@redhat.com>

-- 
Peter Xu

