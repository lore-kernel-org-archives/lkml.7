Return-Path: <SRS0=/WLL=WS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AB3D8C3A5A2
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Aug 2019 16:38:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8BFB0206B7
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Aug 2019 16:38:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390135AbfHVQiz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 22 Aug 2019 12:38:55 -0400
Received: from mx1.redhat.com ([209.132.183.28]:55970 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2390108AbfHVQiq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Aug 2019 12:38:46 -0400
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com [209.85.221.72])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 819A1C049D59
        for <linux-kernel@vger.kernel.org>; Thu, 22 Aug 2019 16:38:45 +0000 (UTC)
Received: by mail-wr1-f72.google.com with SMTP id k10so3435042wru.23
        for <linux-kernel@vger.kernel.org>; Thu, 22 Aug 2019 09:38:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
         :date:user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=p5sLbnKK73dG+WxnSvZUshy8YsfyiA1ug3q0iFIQR/I=;
        b=Jvb6yEJSRCsTDs+mYGBWbpoUYTso536imep14w0Opq96xDwhwwqbNwt2QRmUi65qz7
         I10z358LFTxXuMIilYKN5KYsZm2I8GZ9TS9eckM5YoAlhN6WLuPK5ay+dsaC5PtYd8K6
         di7lYkKOv8uGnLO0W3PmYT43KIj4p45FyCoje29KtTWaDuwIe+4iM1leawMiDfzLv5A+
         JRmKjPhFl/KKHyGma7dwcxfWy/rr+MOpqd+rFeu8EN7gvz42nGofnzZ+8AU+4xPDnfp1
         x22v7enJqW+MTjGXM20T4391RrH845cQfY6BG/91TOmcRAx3PBI+UW4bC+HPTOlTyvPc
         JIEw==
X-Gm-Message-State: APjAAAWoF6/kxyZNh+PtGVOaeHRFPtk5IJtLiprY0sWoM+C3BC/GDpzs
        /lUky2CLVEo7Jqi2Ogiekpgag0QjhtyBzzT1ayOOAWsvBtQILSzZKPcIO18btxxrBjksDi5HT4Q
        vIkt179F17eURtTjcv/1B0SWX
X-Received: by 2002:adf:f287:: with SMTP id k7mr48635363wro.183.1566491924174;
        Thu, 22 Aug 2019 09:38:44 -0700 (PDT)
X-Google-Smtp-Source: APXvYqxnHZQBEz+AELXL/+aERKQQWBN+cLv9cZ3o9ly5EUJLMLeOXkg28ajJSSLGxuDTGkPLbyHorQ==
X-Received: by 2002:adf:f287:: with SMTP id k7mr48635337wro.183.1566491923863;
        Thu, 22 Aug 2019 09:38:43 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:21b9:ff1f:a96c:9fb3? ([2001:b07:6468:f312:21b9:ff1f:a96c:9fb3])
        by smtp.gmail.com with ESMTPSA id e11sm355752wrc.4.2019.08.22.09.38.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 22 Aug 2019 09:38:43 -0700 (PDT)
Subject: Re: [PATCH RESEND v4 7/9] KVM: VMX: Handle SPP induced vmexit and
 page fault
To:     Yang Weijiang <weijiang.yang@intel.com>
Cc:     kvm@vger.kernel.org, linux-kernel@vger.kernel.org,
        sean.j.christopherson@intel.com, mst@redhat.com,
        rkrcmar@redhat.com, jmattson@google.com, yu.c.zhang@intel.com,
        alazar@bitdefender.com
References: <20190814070403.6588-1-weijiang.yang@intel.com>
 <20190814070403.6588-8-weijiang.yang@intel.com>
 <5f6ba406-17c4-a552-2352-2ff50569aac0@redhat.com>
 <fb6cd8b4-eee9-6e58-4047-550811bffd58@redhat.com>
 <20190820134435.GE4828@local-michael-cet-test.sh.intel.com>
 <20190822131745.GA20168@local-michael-cet-test>
From:   Paolo Bonzini <pbonzini@redhat.com>
Openpgp: preference=signencrypt
Message-ID: <62748fe8-0a3b-0554-452e-3bb5ebaf0466@redhat.com>
Date:   Thu, 22 Aug 2019 18:38:41 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190822131745.GA20168@local-michael-cet-test>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 22/08/19 15:17, Yang Weijiang wrote:
> On Tue, Aug 20, 2019 at 09:44:35PM +0800, Yang Weijiang wrote:
>> On Mon, Aug 19, 2019 at 05:04:23PM +0200, Paolo Bonzini wrote:
>>> fast_page_fault should never trigger an SPP userspace exit on its own,
>>> all the SPP handling should go through handle_spp.
>  Hi, Paolo,
>  According to the latest SDM(28.2.4), handle_spp only handles SPPT miss and SPPT
>  misconfig(exit_reason==66), subpage write access violation causes EPT violation,
>  so have to deal with the two cases into handlers.

Ok, so this part has to remain, though you do have to save/restore
PT_SPP_MASK according to the rest of the email.

Paolo

>>> So I think that when KVM wants to write-protect the whole page
>>> (wrprot_ad_disabled_spte) it must also clear PT_SPP_MASK; for example it
>>> could save it in bit 53 (PT64_SECOND_AVAIL_BITS_SHIFT + 1).  If the
>>> saved bit is set, fast_page_fault must then set PT_SPP_MASK instead of
>>> PT_WRITABLE_MASK.
