Return-Path: <SRS0=xBSd=Z4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 89FF4C3F68F
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Dec 2019 21:58:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4DA6520867
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Dec 2019 21:58:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lca.pw header.i=@lca.pw header.b="SdYzh+WS"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726404AbfLFV6B (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 6 Dec 2019 16:58:01 -0500
Received: from mail-qk1-f193.google.com ([209.85.222.193]:39894 "EHLO
        mail-qk1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726352AbfLFV6A (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Dec 2019 16:58:00 -0500
Received: by mail-qk1-f193.google.com with SMTP id d124so7786421qke.6
        for <linux-kernel@vger.kernel.org>; Fri, 06 Dec 2019 13:58:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lca.pw; s=google;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=d39qGeCsB4T9yCMwOh22rEPx7j2ZU+Ojm9VxaLz0ibQ=;
        b=SdYzh+WSgVb+UAlrT82ud0JxMqc9Kvl4cFMITIP+eaCXAcdaJ4yq0fMWJk1wUaA0KC
         aFhnoG2xYpNONhb8lucwmhPkCepfnnJNWG8rRO0IDppIJNDgt62M0F7egSn/zAYZexT8
         3I3q7NnSV4x7CYCjMCFtWHAiVC/oRmDSC2wVzt/po8yJYZwUoldH3xbNxJXmxZeQ2odJ
         PpFSR9acSpVoHqlnxgF0Kwo+kDC7el18CLU3MNqJFsvpFRP/O2w8NGOXAzND5FH4fMQn
         ntJoiEwVQ1pfPUtaGEw/gnrTWKbVG/CP9vPMOUbf/z4WXywE8D+GHxoP+eTgapBxaLkr
         3c3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=d39qGeCsB4T9yCMwOh22rEPx7j2ZU+Ojm9VxaLz0ibQ=;
        b=dCYrEWUYKZCnirQ/H+ebRf/vCKnK+gMMTcDndr6Muv+QN7UuZsJC+HThQ38Tb3rO2j
         IVNhI+4TduSywsUl6qQBgIj/Yjyvh8msoQOCmiAsFCvdiaL2SvqrAamJLhJ0r9VDVDZ0
         829vCD8UAj+DRkyQHGkjz0esV4dV6ysMRuJhMDXoDxr6oOsMCj8sNDOInuUJRJSlxlPY
         ALZgtW2Fg40PtN3oV1Ow5wV2HtwYciHiWfGSxEN+60Y3IT/hc8LZSHFeWeGXg6W+2HSU
         1v5Svep88CjVwaSQfIv2YBPWItzU531ux7xFWw+DKqEGMJrTtQDl0QJxkPH8YKJaDSFG
         bPuA==
X-Gm-Message-State: APjAAAVHd40D4EJLET8I9BW5cBfQv+bTo5Tr6MfK8qRITFPCdm0lzeVi
        aVSBnD9RFT+LR5lgh1C8QlHA5w==
X-Google-Smtp-Source: APXvYqzH8Eo/GmMk2sk0tLQrh06wbKztQryZpegYYGstCKfUtNQvXS54OiLe/ItzwAMah8/sBlxczQ==
X-Received: by 2002:a05:620a:144c:: with SMTP id i12mr275001qkl.439.1575669479724;
        Fri, 06 Dec 2019 13:57:59 -0800 (PST)
Received: from [192.168.1.153] (pool-71-184-117-43.bstnma.fios.verizon.net. [71.184.117.43])
        by smtp.gmail.com with ESMTPSA id d143sm875770qke.123.2019.12.06.13.57.58
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 06 Dec 2019 13:57:58 -0800 (PST)
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 13.0 \(3601.0.10\))
Subject: Re: [Patch v3 0/3] iommu: reduce spinlock contention on fast path
From:   Qian Cai <cai@lca.pw>
In-Reply-To: <20191206213803.12580-1-xiyou.wangcong@gmail.com>
Date:   Fri, 6 Dec 2019 16:57:57 -0500
Cc:     iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 7bit
Message-Id: <1CDA04A5-9EF1-4B6F-8461-37361D6460E2@lca.pw>
References: <20191206213803.12580-1-xiyou.wangcong@gmail.com>
To:     Cong Wang <xiyou.wangcong@gmail.com>
X-Mailer: Apple Mail (2.3601.0.10)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> On Dec 6, 2019, at 4:38 PM, Cong Wang <xiyou.wangcong@gmail.com> wrote:
> 
> This patchset contains three small optimizations for the global spinlock
> contention in IOVA cache. Our memcache perf test shows this reduced its
> p999 latency down by 45% on AMD when IOMMU is enabled.

Can you at least have a changelog compared to previous versions?

> 
> Cong Wang (3):
>  iommu: avoid unnecessary magazine allocations
>  iommu: optimize iova_magazine_free_pfns()
>  iommu: avoid taking iova_rbtree_lock twice
> ---
> drivers/iommu/iova.c | 75 ++++++++++++++++++++++++++------------------
> 1 file changed, 45 insertions(+), 30 deletions(-)
> 
> -- 
> 2.21.0
> 
> _______________________________________________
> iommu mailing list
> iommu@lists.linux-foundation.org
> https://lists.linuxfoundation.org/mailman/listinfo/iommu

