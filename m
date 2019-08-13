Return-Path: <SRS0=Ecng=WJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 27E75C32750
	for <linux-kernel@archiver.kernel.org>; Tue, 13 Aug 2019 20:17:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EE71820651
	for <linux-kernel@archiver.kernel.org>; Tue, 13 Aug 2019 20:17:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726845AbfHMURR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 13 Aug 2019 16:17:17 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:40968 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726231AbfHMURR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Aug 2019 16:17:17 -0400
Received: by mail-wr1-f68.google.com with SMTP id j16so6678779wrr.8
        for <linux-kernel@vger.kernel.org>; Tue, 13 Aug 2019 13:17:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
         :date:user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=xLqB1iHsnjstXwaiMKShyj00W23FVz4l/tiZwn13DNg=;
        b=WuRWF6VCyQjVkq4S15eQwE1Jquq6THr1zGTLbSliu+FveT2dHAvpIDFc6+vLmIli8u
         61lbJ5slhMABsGh6MBh7iesgzpKcfSFg0OkWbGZ1gYK41iwZTozX3wttFWbjBllE2jME
         KMkbg3hxVpgNqBEJ2ywioiwMWyhCFWnl8py/Cud8oaryQn4SUeJRPMEppQk2MxLLZVCP
         J6eqqri31wjopvw+NbznVCNb30KYP3GELqu0cuv7zxJ0+ffMTjAF/zHItYFBzrrWG/ZM
         DvsivNdcANypt/FWjHY2KHkV/ZpJ49AlSE21Iwqbhz1SG+Cuzi0os9ixYcVMi8GOjED5
         v/Yw==
X-Gm-Message-State: APjAAAVnzC8CqiBUi96b/DGtFNJIzqmA6c4msqiBum7C4vtvLPZKaul8
        kQOpWPCVDFXfgWEJcqUfCpWJuRjqvgw=
X-Google-Smtp-Source: APXvYqzp0rrfeaSg7ovOyhbIMVvBcqf42VfsAkGU431CuFYIXFBgFQnuBHDzMSsNaKLpDL8fUR0Iig==
X-Received: by 2002:adf:dc51:: with SMTP id m17mr2040964wrj.256.1565727435844;
        Tue, 13 Aug 2019 13:17:15 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:5193:b12b:f4df:deb6? ([2001:b07:6468:f312:5193:b12b:f4df:deb6])
        by smtp.gmail.com with ESMTPSA id h97sm39854573wrh.74.2019.08.13.13.17.13
        (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
        Tue, 13 Aug 2019 13:17:15 -0700 (PDT)
Subject: Re: [Question-kvm] Can hva_to_pfn_fast be executed in interrupt
 context?
To:     Bharath Vedartham <linux.bhar@gmail.com>, rkrcmar@redhat.com
Cc:     kvm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, khalid.aziz@oracle.com
References: <20190813191435.GB10228@bharath12345-Inspiron-5559>
From:   Paolo Bonzini <pbonzini@redhat.com>
Openpgp: preference=signencrypt
Message-ID: <54182261-88a4-9970-1c3c-8402e130dcda@redhat.com>
Date:   Tue, 13 Aug 2019 22:17:09 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190813191435.GB10228@bharath12345-Inspiron-5559>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 13/08/19 21:14, Bharath Vedartham wrote:
> Hi all,
> 
> I was looking at the function hva_to_pfn_fast(in virt/kvm/kvm_main) which is 
> executed in an atomic context(even in non-atomic context, since
> hva_to_pfn_fast is much faster than hva_to_pfn_slow).
> 
> My question is can this be executed in an interrupt context? 

No, it cannot for the reason you mention below.

Paolo

> The motivation for this question is that in an interrupt context, we cannot
> assume "current" to be the task_struct of the process of interest.
> __get_user_pages_fast assume current->mm when walking the process page
> tables. 
> 
> So if this function hva_to_pfn_fast can be executed in an
> interrupt context, it would not be safe to retrive the pfn with
> __get_user_pages_fast. 
> 
> Thoughts on this?
> 
> Thank you
> Bharath
> 

