Return-Path: <SRS0=vL1f=RL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7A3EBC43381
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Mar 2019 01:21:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4637E20840
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Mar 2019 01:21:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=arista.com header.i=@arista.com header.b="OvwgMWOx"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726311AbfCHBVA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 Mar 2019 20:21:00 -0500
Received: from mail-ed1-f67.google.com ([209.85.208.67]:39606 "EHLO
        mail-ed1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726242AbfCHBVA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Mar 2019 20:21:00 -0500
Received: by mail-ed1-f67.google.com with SMTP id p27so15092110edc.6
        for <linux-kernel@vger.kernel.org>; Thu, 07 Mar 2019 17:20:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=arista.com; s=googlenew;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=FpXUktmzSA7xBlWHR58DhrbhIrg36FIEtlnvxkWxp10=;
        b=OvwgMWOx/FZ4Bhivgj1Sdm/i/GXWYrl6u5IvxSxE4mMX5IyNaVskLgTvvmzGLgpysJ
         2ZO/dMgked0dqPYbIDLiJqhI/CVXrcX++XivL/pJRQl+qDwG0b+mvx9eW1jua2NzCHR+
         rQ8U5eIgySFlHfmV4nmuv50Tb1q1vSu8VMkoC/3viSlWChwrQQzsco866vpUhMGl6zYy
         FBzBmyfMFnRIJPL4E65/IHxzq5KCFI8OX5kLVjDxlCVs/Nm0p/ZrPkSMToATcMG4d+nC
         k7FvF1WvsmSCyZC+tHN8CLN9MooPd78YT4lzpuUa/RQc7euULAGdLGcCyEpfJa1sYjvE
         42Cg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=FpXUktmzSA7xBlWHR58DhrbhIrg36FIEtlnvxkWxp10=;
        b=YWFTN+eclCzqgmVC+S8iu6qDPOlyIzmbbshhAEZJwoNQOj9GXKxRvl7CIjFsJoGVQp
         57rGQT6J3VIA+4N/LUDT01KbM4Gr9iyPlSTTWHtYtnhhokkPeJEMFhYDYAZfjmic3rO1
         yzreSkQmYREKbdZb7tEVzvUVwQUGs6Co4rEhAajCWv62VykZLbFjawLS4HLUE4kcYA1g
         TZDeRhH4po2r02qGmDi9q8e+FzzXCm+EFW+FFtyyrJt7VhbRxu32vDdlxQr23XTw+LuL
         abNFAcnxRnms7ftIfRZdED/kGU/FooTzQcLa2+cLgtm4vY55IcmbV9RiYsPDZJUExyG/
         it5g==
X-Gm-Message-State: APjAAAXzZono2Me1NMhTbhlKM0/xtdG8zb8ffbeLVQuk9z+KOkb7KcQR
        MRp+wChZvX4vSMPSp2clp6P2vKiSI/ESiQ==
X-Google-Smtp-Source: APXvYqz/AbnXa6NhKeVALSEZIiWLO9qx5mqKs0aJMhj3S6fPfgcceuYU3B+muuLmfkvLUJhXgWM2/Q==
X-Received: by 2002:a17:906:678a:: with SMTP id q10mr9655708ejp.156.1552008058432;
        Thu, 07 Mar 2019 17:20:58 -0800 (PST)
Received: from [10.83.36.153] ([217.173.96.166])
        by smtp.gmail.com with ESMTPSA id x18sm1810269edd.4.2019.03.07.17.20.57
        (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
        Thu, 07 Mar 2019 17:20:57 -0800 (PST)
Subject: Re: [PATCH 3/4] iommu/vt-d: Allow IOMMU_DOMAIN_DMA and
 IOMMU_DOMAIN_IDENTITY to be allocated
To:     James Sewart <jamessewart@arista.com>,
        iommu@lists.linux-foundation.org
Cc:     Tom Murphy <tmurphy@arista.com>,
        Jacob Pan <jacob.jun.pan@linux.intel.com>,
        linux-kernel@vger.kernel.org, Lu Baolu <baolu.lu@linux.intel.com>
References: <0F0C82BE-86E5-4BAC-938C-6F7629E18D27@arista.com>
 <2C75F46E-78FE-45E9-9E7D-280B3138EA13@arista.com>
 <F83456DB-81DD-4E9B-9204-12ED9972D2FA@arista.com>
From:   Dmitry Safonov <dima@arista.com>
Message-ID: <171d70d2-5988-9f25-7e2c-cddb217f63ad@arista.com>
Date:   Fri, 8 Mar 2019 01:20:56 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.0
MIME-Version: 1.0
In-Reply-To: <F83456DB-81DD-4E9B-9204-12ED9972D2FA@arista.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 3/4/19 3:46 PM, James Sewart wrote:
> +static inline int domain_is_initialised(struct dmar_domain *domain)
> +{
> +	return domain->flags & DOMAIN_FLAG_INITIALISED;
> +}

Maybe check it in intel_iommu_domain_free(), eh?

Thanks,
          Dmitry
