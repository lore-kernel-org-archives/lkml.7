Return-Path: <SRS0=kgnc=2C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1,USER_IN_DEF_DKIM_WL autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 98348C43603
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Dec 2019 16:31:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 63A1C2073B
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Dec 2019 16:31:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="oa9rL5G/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729939AbfLLQbx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 12 Dec 2019 11:31:53 -0500
Received: from mail-qt1-f194.google.com ([209.85.160.194]:36466 "EHLO
        mail-qt1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729857AbfLLQbx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Dec 2019 11:31:53 -0500
Received: by mail-qt1-f194.google.com with SMTP id h12so248187qto.3
        for <linux-kernel@vger.kernel.org>; Thu, 12 Dec 2019 08:31:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=5nxGnUdtw58bWHogUzbvsjBU/PDGHKaobG6uElnGLno=;
        b=oa9rL5G/dbfnIV/LzrzoNnyRhtYmlptMoi+t69zugwSNSWgp9blS+XEl+9/0hsU8g4
         wEvlkxhrXfv//LqB2RXF1LitoGfhsbCkWj/Z5CkEmM96cg+UQbdGImwjCbcHoIJMMNj+
         sljAkxcEM8qhYEWlMb93V1Xx85g7RTRnV35Wu3xroUX1iVIdvJLWKvrBy79W0q0hUiVi
         X3/dugi+HFn6kRO6XlCj5Wu2KE6/5NrV285cbLrOGt6N6OYzb6ULcMDIc/F6pZ2s7ZbE
         VSVXgaZMKyImgmEl28wIXQzlvsJ5qIjNjk1tyKd4jJLcuPBrdarAFLv/PrC8tUBEusL0
         wt2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=5nxGnUdtw58bWHogUzbvsjBU/PDGHKaobG6uElnGLno=;
        b=leGPUeJFxlhlt5R3+DOsH3w/6asCcKpi8u9kYnyL1sVr7X/v/r3pjyw1AIU3pHlV5I
         SRX2zfh/5Py6kbSz4neDAc6tJzDQYCkFXndiGxTV4OZqjegOtxuZaBt7ZyechzkiUJiV
         SquEiu2Omqs7R/4H4qzqHFmtYSO+QT3Gy4iQ8bg3J066fh4j1ArFr7iLznCkW5yQLz75
         3lYNm3ZmlBV1Y/k+SWCdI2T1xruKrqRLr8ciXZS+A7E/Ru/M2bSpCxTeURpLZvEWG01+
         4ckLqvwFFIvxibGlnlDcUIQ250rBLUDNe/XTcq5nzMTnvl5ay2t9Y90c6ao2YEV2H9If
         2JFA==
X-Gm-Message-State: APjAAAUBu3NORN0/SOWrvbRAYyE1T1Ln+035Ti/K63wwbxaaXnj2d3X2
        NMm6tCmABprV/B82rd978lsy5Q==
X-Google-Smtp-Source: APXvYqyfo7q7u1Qo2RWrsYPgxg4cCPsnEGuVFjYRp2T2M/zKAnej0anX24hFu358xW7EyeiV/RdLyw==
X-Received: by 2002:ac8:3177:: with SMTP id h52mr8535747qtb.264.1576168311701;
        Thu, 12 Dec 2019 08:31:51 -0800 (PST)
Received: from ?IPv6:2620:0:1004:a:6e2b:60f7:b51b:3b04? ([2620:0:1004:a:6e2b:60f7:b51b:3b04])
        by smtp.gmail.com with ESMTPSA id t38sm2355441qta.78.2019.12.12.08.31.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 12 Dec 2019 08:31:51 -0800 (PST)
Subject: Re: [PATCH v4 2/2] kvm: Use huge pages for DAX-backed files
To:     David Hildenbrand <david@redhat.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Dave Jiang <dave.jiang@intel.com>,
        Alexander Duyck <alexander.h.duyck@linux.intel.com>
Cc:     linux-nvdimm@lists.01.org, x86@kernel.org, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org, jason.zeng@intel.com
References: <20191211213207.215936-1-brho@google.com>
 <20191211213207.215936-3-brho@google.com>
 <eb9ef218-1bbc-83e6-ec84-c6aae245e62b@redhat.com>
From:   Barret Rhoden <brho@google.com>
Message-ID: <c203f44c-d5b0-429d-0c13-5723c09ec243@google.com>
Date:   Thu, 12 Dec 2019 11:31:50 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <eb9ef218-1bbc-83e6-ec84-c6aae245e62b@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/12/19 7:22 AM, David Hildenbrand wrote:
>> +	/*
>> +	 * Our caller grabbed the KVM mmu_lock with a successful
>> +	 * mmu_notifier_retry, so we're safe to walk the page table.
>> +	 */
>> +	switch (dev_pagemap_mapping_shift(hva, current->mm)) {
>> +	case PMD_SHIFT:
>> +	case PUD_SIZE:
> 
> Shouldn't this be PUD_SHIFT?
> 
> But I agree with Paolo, that this is simply
> 
> return dev_pagemap_mapping_shift(hva, current->mm) > PAGE_SHIFT;

Yes, good call.  I'll fix that in the next version.

