Return-Path: <SRS0=kgnc=2C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CFAAFC43603
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Dec 2019 00:22:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A2C09206C3
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Dec 2019 00:22:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="KADY2omA"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727261AbfLLAW2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 11 Dec 2019 19:22:28 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:24020 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1727220AbfLLAW2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Dec 2019 19:22:28 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1576110146;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=KfDIK/cTZhxbWFyQXhJ/o6g67eom+8/Zr11enJF7XGs=;
        b=KADY2omALkR7HDMXEk33Th1jw/PLVDY3dW8cTiukWlt2mTAHRMFmMe/7z6qyzhLg7nNgB3
        ZhF4C/nfpu1TTKtB+vMg+xaGdfbck9kKJWrvxhgbeFBD8aVm7KplJzxXuoZufUdCp48/4n
        FvBiJzGOrpEImygeK/+A4VfJkJfpWmA=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-316-IvGF3dKIM32OoDGsyDaDGw-1; Wed, 11 Dec 2019 19:22:23 -0500
X-MC-Unique: IvGF3dKIM32OoDGsyDaDGw-1
Received: by mail-wm1-f70.google.com with SMTP id 7so70168wmf.9
        for <linux-kernel@vger.kernel.org>; Wed, 11 Dec 2019 16:22:22 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=KfDIK/cTZhxbWFyQXhJ/o6g67eom+8/Zr11enJF7XGs=;
        b=Fsowsx9njy1BTwQZfXO250AnvDxgbe+FrrKrcekF1IWqjfNsSE6EaTIvvWL7H3gqLJ
         mZOKvmWlFdQjBBSbSkRGpVdtHzNvrlS5NOIG9XXZWuGeZOpGVdYzpPJYSFpbD61TZLeF
         4Jf4KkHVUAFQBG2TgZzBXd0PVxPI84XGqMvwYqZPsprz96oEkb6F7QEbzDlebz1Zvocd
         uWEsIddeec67lE6HKj+e2Awh7GSwdP7TLyAzTX4a+ZK+Un9hrN2mBz/NE5JNjPMsePbv
         1Cll6XFcznROA5nC/9SALOtCCSCZrWN/v8J8yUVna4qql3JaDZaTy+qT4YwF50qaAJRv
         dGzg==
X-Gm-Message-State: APjAAAWs5geT2lXrekjC7ZVnJMQwNFNoUeovO8YkoxKbZ+l0Y87f3/Fh
        6B+Ug6Fdz81XuuDf280tKRkbkNcWE4/Bp6B175tHLS44vbYGWud6ParyOBiLqm7KuI/SGpon+GY
        lLKs9DFUTsJeHR4FeUDKgFJ66
X-Received: by 2002:a1c:7c11:: with SMTP id x17mr2826032wmc.168.1576110141845;
        Wed, 11 Dec 2019 16:22:21 -0800 (PST)
X-Google-Smtp-Source: APXvYqyHQ9pKCsQmECWYzfqmUaqKH3GIHVXeXl2UOPNAEoUlpehzQP2zvMDzXZHDtpibHFnJA7IUJQ==
X-Received: by 2002:a1c:7c11:: with SMTP id x17mr2826004wmc.168.1576110141556;
        Wed, 11 Dec 2019 16:22:21 -0800 (PST)
Received: from ?IPv6:2001:b07:6468:f312:e9bb:92e9:fcc3:7ba9? ([2001:b07:6468:f312:e9bb:92e9:fcc3:7ba9])
        by smtp.gmail.com with ESMTPSA id t12sm4018033wrs.96.2019.12.11.16.22.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 11 Dec 2019 16:22:21 -0800 (PST)
Subject: Re: [PATCH v4 0/2] kvm: Use huge pages for DAX-backed files
To:     Barret Rhoden <brho@google.com>,
        Dan Williams <dan.j.williams@intel.com>,
        David Hildenbrand <david@redhat.com>,
        Dave Jiang <dave.jiang@intel.com>,
        Alexander Duyck <alexander.h.duyck@linux.intel.com>
Cc:     linux-nvdimm@lists.01.org, x86@kernel.org, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org, jason.zeng@intel.com
References: <20191211213207.215936-1-brho@google.com>
From:   Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <473dbb9d-b2ab-31ba-48ac-3b8216be46de@redhat.com>
Date:   Thu, 12 Dec 2019 01:22:21 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
MIME-Version: 1.0
In-Reply-To: <20191211213207.215936-1-brho@google.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/12/19 22:32, Barret Rhoden wrote:
> This patchset allows KVM to map huge pages for DAX-backed files.
> 
> I held previous versions in limbo while people were sorting out whether
> or not DAX pages were going to remain PageReserved and how that relates
> to KVM.
> 
> Now that that is sorted out (DAX pages are PageReserved, but they are
> not kvm_is_reserved_pfn(), and DAX pages are considered on a
> case-by-case basis for KVM), I can repost this.
> 
> v3 -> v4:
> v3: https://lore.kernel.org/lkml/20190404202345.133553-1-brho@google.com/
> - Rebased onto linus/master
> 
> v2 -> v3:
> v2: https://lore.kernel.org/lkml/20181114215155.259978-1-brho@google.com/
> - Updated Acks/Reviewed-by
> - Rebased onto linux-next
> 
> v1 -> v2:
> https://lore.kernel.org/lkml/20181109203921.178363-1-brho@google.com/
> - Updated Acks/Reviewed-by
> - Minor touchups
> - Added patch to remove redundant PageReserved() check
> - Rebased onto linux-next
> 
> RFC/discussion thread:
> https://lore.kernel.org/lkml/20181029210716.212159-1-brho@google.com/
> 
> Barret Rhoden (2):
>   mm: make dev_pagemap_mapping_shift() externally visible
>   kvm: Use huge pages for DAX-backed files
> 
>  arch/x86/kvm/mmu/mmu.c | 36 ++++++++++++++++++++++++++++++++----
>  include/linux/mm.h     |  3 +++
>  mm/memory-failure.c    | 38 +++-----------------------------------
>  mm/util.c              | 34 ++++++++++++++++++++++++++++++++++
>  4 files changed, 72 insertions(+), 39 deletions(-)
> 

Thanks, with the Acked-by already in place for patch 1 I can pick this up.

Paolo

