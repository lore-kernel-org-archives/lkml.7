Return-Path: <SRS0=kgnc=2C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BDDA7C43603
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Dec 2019 00:22:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8DFF8214AF
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Dec 2019 00:22:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ept2QLrM"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727211AbfLLAWC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 11 Dec 2019 19:22:02 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:34083 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1727126AbfLLAWB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Dec 2019 19:22:01 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1576110120;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Ska3bIPmsdQtnj/4meb46bcvVz/4NO14TTW8PGBXyDI=;
        b=ept2QLrM2quCQFoRtTS5dc6YZfJe09iZpgfiMyYl4py3asp3ouNdEhlWxqkjgcHgSTytDo
        TeeVyozkjFgHR0U6O8IfvMsXrUlOEmkcm+MIGavAZAR/L9Q/XJmL9Iudt8CX/G2DGVIY7I
        lQQpaa1X6VWnvqT7yhLgQq+kNE2suwg=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-134-FNimZqfWMLe8Kz0-FAoexw-1; Wed, 11 Dec 2019 19:21:59 -0500
X-MC-Unique: FNimZqfWMLe8Kz0-FAoexw-1
Received: by mail-wm1-f70.google.com with SMTP id 7so69822wmf.9
        for <linux-kernel@vger.kernel.org>; Wed, 11 Dec 2019 16:21:59 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=Ska3bIPmsdQtnj/4meb46bcvVz/4NO14TTW8PGBXyDI=;
        b=LxYGwUtkUnvhvSfvSaTdkSLuH8V0xwNkCDU9W+eb/WlLFJTipy2Wd2dRkXs0CsMArh
         Uc4+W/FebnlU72YuxSeexRPpzura748lKPREGV67VYDI42sacuopoCB4qwEaPCH0WRlc
         7PrSVPrgZpsCKEursG7gsxbK8wSn8eAIbzPLMI0a05p9Gf974VsKK9pRgJhROPkYBQKS
         hoOTRvn/+ulLrdryEGcXqSZNHpNy67xh4iRxdzSXKa0rYpCMW+TPzJYM6Zgk25DHiwxU
         Wg6w8LaKffGqsUEoBj8q4wCdQpwp/aEyNoVI71x1Yz8Mppl5d38va7/nJ+VqntVd/lyI
         QlMA==
X-Gm-Message-State: APjAAAW6RF0kfW25rDW7zQSdibUEi2bLxzSoPGNDtiknm4PkCCpGdgHI
        2jHPKkI+P/7EAmD2r0IlBi3X1Mks7QFp2mEsoZAlDu4BBLJZ3BrZMKiKuLO9TV6NvG0jOX0zrwZ
        LNAqzGvghaMbECetzb2XbpriM
X-Received: by 2002:adf:f58a:: with SMTP id f10mr2889588wro.105.1576110118022;
        Wed, 11 Dec 2019 16:21:58 -0800 (PST)
X-Google-Smtp-Source: APXvYqxGJwEdVkyaU2oXUwh6CTh2f90dtYsbxxgMNCxSyknFWlvYkVEzD3KyBhe96t/+ML4ibwigNw==
X-Received: by 2002:adf:f58a:: with SMTP id f10mr2889571wro.105.1576110117837;
        Wed, 11 Dec 2019 16:21:57 -0800 (PST)
Received: from ?IPv6:2001:b07:6468:f312:e9bb:92e9:fcc3:7ba9? ([2001:b07:6468:f312:e9bb:92e9:fcc3:7ba9])
        by smtp.gmail.com with ESMTPSA id c9sm4002416wmc.47.2019.12.11.16.21.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 11 Dec 2019 16:21:57 -0800 (PST)
Subject: Re: [PATCH v4 2/2] kvm: Use huge pages for DAX-backed files
To:     Barret Rhoden <brho@google.com>,
        Dan Williams <dan.j.williams@intel.com>,
        David Hildenbrand <david@redhat.com>,
        Dave Jiang <dave.jiang@intel.com>,
        Alexander Duyck <alexander.h.duyck@linux.intel.com>
Cc:     linux-nvdimm@lists.01.org, x86@kernel.org, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org, jason.zeng@intel.com
References: <20191211213207.215936-1-brho@google.com>
 <20191211213207.215936-3-brho@google.com>
From:   Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <5abef720-c329-13c3-ff93-b4b58a08721c@redhat.com>
Date:   Thu, 12 Dec 2019 01:21:57 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
MIME-Version: 1.0
In-Reply-To: <20191211213207.215936-3-brho@google.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/12/19 22:32, Barret Rhoden wrote:
> +	/*
> +	 * Our caller grabbed the KVM mmu_lock with a successful
> +	 * mmu_notifier_retry, so we're safe to walk the page table.
> +	 */
> +	switch (dev_pagemap_mapping_shift(hva, current->mm)) {
> +	case PMD_SHIFT:
> +	case PUD_SIZE:
> +		return true;
> +	}
> +	return false;

Should this simply be "> PAGE_SHIFT"?

Paolo

