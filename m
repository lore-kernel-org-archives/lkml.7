Return-Path: <SRS0=LniW=ZY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9541FC43215
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Dec 2019 09:31:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6C6212070B
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Dec 2019 09:31:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="br29y0ks"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726678AbfLBJbS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 2 Dec 2019 04:31:18 -0500
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:24447 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726254AbfLBJbR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Dec 2019 04:31:17 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1575279076;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=o/hoD+0u+dDjYhVpXJbZdoLaLC87tWFi3qSZzrNOkxw=;
        b=br29y0ks35M+nen2B6oFbnEmB/QZsGzHxU4EgtvQGSz/xHxT4FIT/MR2xUKw6wtFJbah3+
        4Hb/YRD5YpLE1c1fQYyqFGqg8ZmGXqrfSLe/ZVb6Hsw5Ph1J0o+corXU3Mxo6KjEY0WrBJ
        k3QrIljZBZTgyn9N/BV4ogroFmTd+HQ=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-270-a-1foCCaPrOoLCrngrrJ-Q-1; Mon, 02 Dec 2019 04:31:14 -0500
Received: by mail-wr1-f70.google.com with SMTP id 92so20201832wro.14
        for <linux-kernel@vger.kernel.org>; Mon, 02 Dec 2019 01:31:14 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=o/hoD+0u+dDjYhVpXJbZdoLaLC87tWFi3qSZzrNOkxw=;
        b=fDCkjXCBj4rJ/cDotdiPBm6M8fMOU7/uVlr7Svx0kY0ZMZ6Ww4HrRSp+5fFKb1cccr
         EqsUqYfmPypD5IonLv8LAYPVF1dNv9vDPy2PAtnSmA5YTTyeDmC6S56qGq2Zob8yQTGD
         Q/R7rVpV8t34mFc+z6XN+bqepB8Q9nPmjrgr5gPaAmzuApjqhTPCQaEqSOPOOnPu4GMR
         JObllr5qMYxUHoXnXkmqPMKORP4C9bRwA8jahj/a/sjURvffdgkKPCth28ae9iK3I/IV
         bCQZm/yEeObqCOYf20IBVGdRufRUhxElv7ChHp6PVEc/JtRUXWuk55pMc3i1et/ZpnzK
         r7QA==
X-Gm-Message-State: APjAAAVNF5M2ivp3asd2lCCbU+zZF+zvgi+SmKxxz4M2RrMVDNQADbpD
        xLMhiEZppevVI9BPdvruntGnXhvAHYyrIbwL5pqjGea9nWpvuETx5uHG6orhwDvMKjA3IcYoIAB
        ZTMxveegVvzZxiMH/El+AbZ6Y
X-Received: by 2002:a5d:4386:: with SMTP id i6mr16291129wrq.63.1575279073717;
        Mon, 02 Dec 2019 01:31:13 -0800 (PST)
X-Google-Smtp-Source: APXvYqw5myrgbwNLl5pT3XXiiksqesBdjxCxjdGPzI1YpHFrNJuwwlDLnrK8Sv65GeOFtay6Kohtvg==
X-Received: by 2002:a5d:4386:: with SMTP id i6mr16291105wrq.63.1575279073477;
        Mon, 02 Dec 2019 01:31:13 -0800 (PST)
Received: from ?IPv6:2001:b07:6468:f312:8dc6:5dd5:2c0a:6a9a? ([2001:b07:6468:f312:8dc6:5dd5:2c0a:6a9a])
        by smtp.gmail.com with ESMTPSA id b63sm22032882wmb.40.2019.12.02.01.31.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 02 Dec 2019 01:31:12 -0800 (PST)
Subject: Re: vfio_pin_map_dma cause synchronize_sched wait too long
To:     "Longpeng (Mike)" <longpeng2@huawei.com>,
        Alex Williamson <alex.williamson@redhat.com>
Cc:     qemu-devel@nongnu.org, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        "Longpeng(Mike)" <longpeng.mike@gmail.com>,
        Gonglei <arei.gonglei@huawei.com>,
        Huangzhichao <huangzhichao@huawei.com>
References: <2e53a9f0-3225-d416-98ff-55bd337330bc@huawei.com>
From:   Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <34c53520-4144-fe71-528a-8df53e7f4dd1@redhat.com>
Date:   Mon, 2 Dec 2019 10:31:11 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
MIME-Version: 1.0
In-Reply-To: <2e53a9f0-3225-d416-98ff-55bd337330bc@huawei.com>
Content-Language: en-US
X-MC-Unique: a-1foCCaPrOoLCrngrrJ-Q-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=gbk
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 02/12/19 10:10, Longpeng (Mike) wrote:
> 
> Suppose there're two VMs: VM1 is bind to node-0 and calling vfio_pin_map_dma(),
> VM2 is a migrate incoming VM which bind to node-1. We found the vm_start( QEMU
> function) of VM2 will take too long occasionally, the reason is as follow.

Which part of vfio_pin_map_dma is running?  There is already a
cond_resched in vfio_iommu_map.  Perhaps you could add one to
vfio_pin_pages_remote and/or use vfio_pgsize_bitmap to cap the number of
pages that it returns.

Paolo

