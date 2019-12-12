Return-Path: <SRS0=kgnc=2C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1,USER_IN_DEF_DKIM_WL autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 434E2C43603
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Dec 2019 17:03:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 19F55214AF
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Dec 2019 17:03:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="uJQ81efn"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730033AbfLLRDl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 12 Dec 2019 12:03:41 -0500
Received: from mail-qv1-f65.google.com ([209.85.219.65]:39993 "EHLO
        mail-qv1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729260AbfLLRDk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Dec 2019 12:03:40 -0500
Received: by mail-qv1-f65.google.com with SMTP id k10so1227681qve.7
        for <linux-kernel@vger.kernel.org>; Thu, 12 Dec 2019 09:03:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=BFu2QWawMDo8B85b8x7NXC6lIZ2Hbdt7KAZDH/cd0Mw=;
        b=uJQ81efnMOHOq6dmsBK8drxQnWrVDOdv8wGOOqXsdXxN7MhmstzRl6qMKoIgIuASAY
         lEMPd/dfy/crfpO/6N/VYadcmKGFrnXX4+mmXiFkiUzG5PU/Xej146ZJHj/dEykZgxvy
         O+736S4rCVpZL8qO9PDMpS7ySgMAdKBw9pj7/tzKtk7CI7RTtduMaLcqZk07DY8+moZF
         bhUxoQO5G3JypRZzuwZiBUVL1eXd8sas3jVkAS5Wsw+g0QVTow0WeUF7SMo0GvEb1yGN
         kTpPj0oqoIC97Z/MBaZkh6bNy1JKFpcUqpZ4ZUFKziv0r5L1pZe+Jr9MM94NAGfLXcIO
         wA3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=BFu2QWawMDo8B85b8x7NXC6lIZ2Hbdt7KAZDH/cd0Mw=;
        b=KEsneptvEHPfd5BggOqDSTidifbxi16v4Ut1CzPHcbXkIxdNP9Tf3moo0xcNlVWXaT
         2tuRfCCOQDWUzeWbNMPF1T7MPccbUi7gD/OU9HXnIH+nKyg4GPZa+p0f6QIT9XbinzfU
         9l5OhoaAb/lWimyRK+k3eXy0Tvs8ZdMCvdvcU6GD75V9T8HeAxo0lCmi16uznfyokX//
         BF7LALkl+1XG0r+mOkJE+/aZZg3/RHCi9cVysVYvibdVdXZLGK/NEEwp5w8mxJdJUBaX
         +siRG5Us8dAe7N/3hcFxtgbw9WtV22NXCuWBsPFdr03MiV7V164zxFF81j0CIOBJ3U9/
         v+aQ==
X-Gm-Message-State: APjAAAUjkT/NM7oiAdWnr2WBk9RRgqveMNNAP9t38sI3AZwIjA6/xXxT
        4qsY5wt53OzKiePUOjqML5/TTw==
X-Google-Smtp-Source: APXvYqyixXbMscj+Nh5/8lf0UVe2+f6RVkD6z054yrZ1R+8RY56Ujz8IweJ8MUL8w3BnzkuS2BNpnA==
X-Received: by 2002:ad4:580b:: with SMTP id dd11mr9025509qvb.242.1576170219393;
        Thu, 12 Dec 2019 09:03:39 -0800 (PST)
Received: from ?IPv6:2620:0:1004:a:6e2b:60f7:b51b:3b04? ([2620:0:1004:a:6e2b:60f7:b51b:3b04])
        by smtp.gmail.com with ESMTPSA id b7sm1906173qkh.106.2019.12.12.09.03.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 12 Dec 2019 09:03:38 -0800 (PST)
Subject: Re: [PATCH v4 2/2] kvm: Use huge pages for DAX-backed files
To:     Liran Alon <liran.alon@oracle.com>
Cc:     Paolo Bonzini <pbonzini@redhat.com>,
        Dan Williams <dan.j.williams@intel.com>,
        David Hildenbrand <david@redhat.com>,
        Dave Jiang <dave.jiang@intel.com>,
        Alexander Duyck <alexander.h.duyck@linux.intel.com>,
        linux-nvdimm@lists.01.org, x86@kernel.org, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org, jason.zeng@intel.com
References: <20191211213207.215936-1-brho@google.com>
 <20191211213207.215936-3-brho@google.com>
 <376DB19A-4EF1-42BF-A73C-741558E397D4@oracle.com>
From:   Barret Rhoden <brho@google.com>
Message-ID: <ce8fa354-4530-2a01-6ccc-3cffd0692547@google.com>
Date:   Thu, 12 Dec 2019 12:03:38 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <376DB19A-4EF1-42BF-A73C-741558E397D4@oracle.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/12/19 7:33 AM, Liran Alon wrote:
>> +	/*
>> +	 * Our caller grabbed the KVM mmu_lock with a successful
>> +	 * mmu_notifier_retry, so we're safe to walk the page table.
>> +	 */
>> +	switch (dev_pagemap_mapping_shift(hva, current->mm)) {
> Doesn’t dev_pagemap_mapping_shift() get “struct page” as first parameter?
> Was this changed by a commit I missed?

I changed this in Patch 1.  The place I call it in KVM has the address 
and mm available, which is the only think dev_pagemap_mapping_shift() 
really needs.  (The first thing it did was convert page to address).

I'll add some more text to patch 1's commit message about that.

Thanks,

Barret


