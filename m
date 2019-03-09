Return-Path: <SRS0=x0+x=RM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 97BC9C43381
	for <linux-kernel@archiver.kernel.org>; Sat,  9 Mar 2019 11:58:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 57D5A207E0
	for <linux-kernel@archiver.kernel.org>; Sat,  9 Mar 2019 11:58:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=arista.com header.i=@arista.com header.b="LI/tzB8Q"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726425AbfCIL6e (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 9 Mar 2019 06:58:34 -0500
Received: from mail-pg1-f193.google.com ([209.85.215.193]:37564 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726149AbfCIL6e (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 9 Mar 2019 06:58:34 -0500
Received: by mail-pg1-f193.google.com with SMTP id q206so281388pgq.4
        for <linux-kernel@vger.kernel.org>; Sat, 09 Mar 2019 03:58:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=arista.com; s=googlenew;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=MJYs8vdlU6mHCQvMnerk2SFu391jt9PTuFpBk4+0bAs=;
        b=LI/tzB8QO6frlax2ZEcCnbKPySE3vtfuY6YThw6r208fgH0zcDb6cx3sZEENNe5pIg
         mXYKHc4b7DYbSWhqqG3D7Ffz3rN8Pu8qqfGzezYEKw++Rjm7W/k91W4/eyojGxWtcjCd
         kh73YkJ29gMpFLkmsV9qLOIiNdzFbdZ3ZW2lmGRDREOwW35op35ciPxN2c58HxhBQ2g1
         44h/rT1mwCWX8XnLa5Phz96qjGxIL2dSb/g498z5JggwGNCGrnZGwQv81aZha6BI269a
         hto1+qUYpt8lpRe5L8RMTuLZAXQRiAsGYwnekCibB+a5hD4eHEwlxeZgR7y4cAMVOgcj
         hj7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=MJYs8vdlU6mHCQvMnerk2SFu391jt9PTuFpBk4+0bAs=;
        b=VPCkRFWo2DaiblMzkBWXUWEfXVC7dqAVM4K5R5tyotMszsLS5CjqFYxA6Sge+Ec4Uj
         P5PtfoJAcYq1zS8ai00gHRvS9HGEqyZMMpgXJDQed0oQIR5fRXr4s3pXWYWG/fOiatKV
         JQkCYL0H5a7B8G1zrDocNtSkEt4kfU/UydgK5+uyHT4A9aper2HqKpFssORBigthPPlv
         gbTJSNMBHrrhHbksdu+jSTwyeWLmAPDrHl2v5N32hJKZsdjQ1uZHGu6Z7QFWFAEDv6eS
         UClOn3C4cd357RqPIDuqQHOSloEvEpOI324OtZ2DkCkCTOnCMl6h2OwvIqGj5BVwiMhs
         dVdQ==
X-Gm-Message-State: APjAAAWQr4aYb0vcirLuZEHTDtn4RvMyIXVaSRrQUww2mFgcQfkmRTbr
        TRh0B+UbAQppd6Cn3HUan9qhMw==
X-Google-Smtp-Source: APXvYqwAqQr8rpZduGzSaTKZHWh0qfMy6l8//0Pm4wgcd9vsOzhiFuAQJjm3cTFiT6HC0odupcZw9Q==
X-Received: by 2002:a17:902:a702:: with SMTP id w2mr24097313plq.341.1552132713755;
        Sat, 09 Mar 2019 03:58:33 -0800 (PST)
Received: from ?IPv6:2a02:8084:2842:c580:551e:cd48:ead0:f847? ([2a02:8084:2842:c580:551e:cd48:ead0:f847])
        by smtp.gmail.com with ESMTPSA id v5sm760974pfn.81.2019.03.09.03.58.31
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 09 Mar 2019 03:58:33 -0800 (PST)
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 12.2 \(3445.102.3\))
Subject: Re: [PATCH 3/4] iommu/vt-d: Allow IOMMU_DOMAIN_DMA and
 IOMMU_DOMAIN_IDENTITY to be allocated
From:   James Sewart <jamessewart@arista.com>
In-Reply-To: <171d70d2-5988-9f25-7e2c-cddb217f63ad@arista.com>
Date:   Sat, 9 Mar 2019 11:57:27 +0000
Cc:     iommu@lists.linux-foundation.org, Tom Murphy <tmurphy@arista.com>,
        Jacob Pan <jacob.jun.pan@linux.intel.com>,
        linux-kernel@vger.kernel.org, Lu Baolu <baolu.lu@linux.intel.com>
Content-Transfer-Encoding: 7bit
Message-Id: <718BFBD9-F03B-4887-84FB-A21B97DAC9E4@arista.com>
References: <0F0C82BE-86E5-4BAC-938C-6F7629E18D27@arista.com>
 <2C75F46E-78FE-45E9-9E7D-280B3138EA13@arista.com>
 <F83456DB-81DD-4E9B-9204-12ED9972D2FA@arista.com>
 <171d70d2-5988-9f25-7e2c-cddb217f63ad@arista.com>
To:     Dmitry Safonov <dima@arista.com>
X-Mailer: Apple Mail (2.3445.102.3)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hey Dmitry,

> On 8 Mar 2019, at 01:20, Dmitry Safonov <dima@arista.com> wrote:
> 
> On 3/4/19 3:46 PM, James Sewart wrote:
>> +static inline int domain_is_initialised(struct dmar_domain *domain)
>> +{
>> +	return domain->flags & DOMAIN_FLAG_INITIALISED;
>> +}
> 
> Maybe check it in intel_iommu_domain_free(), eh?

Good shout, freeing a non attached IOMMU_DOMAIN_DMA domain is now 
different to an attached one.

> 
> Thanks,
>          Dmitry


Cheers,
James.
