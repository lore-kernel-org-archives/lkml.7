Return-Path: <SRS0=kgnc=2C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1,USER_IN_DEF_DKIM_WL autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7139AC43603
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Dec 2019 19:16:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 404CC2073B
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Dec 2019 19:16:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="KAaolzVG"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730610AbfLLTQh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 12 Dec 2019 14:16:37 -0500
Received: from mail-pl1-f193.google.com ([209.85.214.193]:34173 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730486AbfLLTQh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Dec 2019 14:16:37 -0500
Received: by mail-pl1-f193.google.com with SMTP id x17so1057565pln.1
        for <linux-kernel@vger.kernel.org>; Thu, 12 Dec 2019 11:16:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=MNaR/QuknJAHIB0pQcQsq4R3Kk/5rQ+DPsOAQIxnnSw=;
        b=KAaolzVGGhfdtct3LZlhCTEopQdtdhFue5scfWobqwTsj8pWuL8PPQeLqKwSEwDDPT
         RH6zj3ONxLD+ZNNz2rnjB8aOkq+zyRGMUKrwm47RHKOKhZLJjBMEFm+Oprp2T+rETJsj
         u3YQMbP2yvBsoYxCqcj4VtuRXuZgqZI06zy9VGC0ph50IaQHvHUlW6pvuzBQqamMWb/6
         MxKKPVfqkUfpOJKet7l4NXuP1wWltJKpviBeyXO6YQd5nklpHbB09zTViE0KGCvRYD1e
         mgR27tzL277oAJHraSihXtCCjBO3L65OKHZ0vDGDPX7aHDav/w/EBjeVOcSGNbXhWfOg
         tltA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=MNaR/QuknJAHIB0pQcQsq4R3Kk/5rQ+DPsOAQIxnnSw=;
        b=f6LXzXafM9WJUybX6BUoM5M2w3hL+Yv530W+6o7LPSdapBPY3kcc0cDRdgYSE8VUz9
         CK4rN2PO//TR5uWWv7tDdfXEa/7DG0FXpuXkY4LBvbpJny1QW4uHFEQ7uv63JF2glPbA
         lEY7udIrRDf+CzQeceSh7jASqSOp9+/f3D3Lawb4isO3GZldFEBh4NWIf102hSDRJcG/
         914NPbqruuqZbwwdsnwaRFHX+8M/LWKC9554oZ5Q6WT64IHrJywNkc9IxsWVZCNBCNX5
         TDqtiNzr1dGRPSdFzkmHMKElbT9/OFK5dcAdvv0NyguxoGb1bkDpZchrHi73WhzEl//6
         GdJg==
X-Gm-Message-State: APjAAAXxquM7vfXqLc9/PJ6xfq+xPxyLSJj+xQYj31MriConO7DzIVvx
        l9gWEdrMALda/5vqSYQbup81tg==
X-Google-Smtp-Source: APXvYqx/9O2gkZlxhLDydhoZN8PUSRgnOhN7UqLc/bxYHtv2gdkUDry2PRLvM5QCHRSKPYXaQiMGYg==
X-Received: by 2002:a17:90b:85:: with SMTP id bb5mr11377895pjb.22.1576178195916;
        Thu, 12 Dec 2019 11:16:35 -0800 (PST)
Received: from gnomeregan.cam.corp.google.com ([2620:15c:6:14:ad22:1cbb:d8fa:7d55])
        by smtp.googlemail.com with ESMTPSA id e1sm8314913pfl.98.2019.12.12.11.16.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 12 Dec 2019 11:16:35 -0800 (PST)
Subject: Re: [PATCH v4 2/2] kvm: Use huge pages for DAX-backed files
To:     Dan Williams <dan.j.williams@intel.com>
Cc:     Sean Christopherson <sean.j.christopherson@intel.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        David Hildenbrand <david@redhat.com>,
        Dave Jiang <dave.jiang@intel.com>,
        Alexander Duyck <alexander.h.duyck@linux.intel.com>,
        linux-nvdimm <linux-nvdimm@lists.01.org>,
        X86 ML <x86@kernel.org>, KVM list <kvm@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "Zeng, Jason" <jason.zeng@intel.com>
References: <20191211213207.215936-1-brho@google.com>
 <20191211213207.215936-3-brho@google.com>
 <20191212173413.GC3163@linux.intel.com>
 <CAPcyv4hkz8XCETELBaUOjHQf3=VyVB=KWeRVEPYejvdsg3_MWA@mail.gmail.com>
From:   Barret Rhoden <brho@google.com>
Message-ID: <b50720a2-5358-19ea-a45e-a0c0628c68b0@google.com>
Date:   Thu, 12 Dec 2019 14:16:33 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <CAPcyv4hkz8XCETELBaUOjHQf3=VyVB=KWeRVEPYejvdsg3_MWA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/12/19 12:37 PM, Dan Williams wrote:
> Yeah, since device-dax is the only path to support longterm page
> pinning for vfio device assignment, testing with device-dax + 1GB
> pages would be a useful sanity check.

What are the issues with fs-dax and page pinning?  Is that limitation 
something that is permanent and unfixable (by me or anyone)?

I'd like to put a lot more in a DAX/pmem region than just a guest's 
memory, and having a mountable filesystem would be extremely convenient.

Thanks,

Barret


