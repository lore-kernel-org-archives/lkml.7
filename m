Return-Path: <SRS0=E2Zf=ZP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 31163C432C3
	for <linux-kernel@archiver.kernel.org>; Sat, 23 Nov 2019 02:33:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E35572071C
	for <linux-kernel@archiver.kernel.org>; Sat, 23 Nov 2019 02:33:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="UMaVsJij"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726744AbfKWCdf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Nov 2019 21:33:35 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:57076 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725962AbfKWCde (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Nov 2019 21:33:34 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=nPuduIsmzT4eyNy6AgYyeWm8a3lye8lEUGi+OFLWHQE=; b=UMaVsJijpyg+a0E75vUQkK7rg
        XWQcUQCgvHIOltFSFQ8of0MXhAXTDQ+LEgp/aZPcsKfZWDNuJMxrT+JnVRsrnGPLN4ZTHWN/1P61s
        IRlUCeGaPjd+/enFAGSylVBReBSPyMYmb2poYTrDXEoIRo9Xdjp6/XFZp9AesW02vXhaItc8wJ/9q
        YKBaQA6k8wkdU9IdCLgjSxKrEJvzglgm7vDvCvdzkjRqsqpwUrqjCh9ObctTA1RPyVJQoU/4FQVXQ
        YZUp89zmv4AAxj9Sgx/hYqgCrKN0wB34ICyv7xwzPvoRtQWW68GhucrtJL9ijKCjACkcod6bd4vhd
        ves1wV+4w==;
Received: from willy by bombadil.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1iYLEj-0004Ol-JZ; Sat, 23 Nov 2019 02:33:25 +0000
Date:   Fri, 22 Nov 2019 18:33:25 -0800
From:   Matthew Wilcox <willy@infradead.org>
To:     "zhengbin (A)" <zhengbin13@huawei.com>
Cc:     Hugh Dickins <hughd@google.com>, viro@zeniv.linux.org.uk,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        houtao1@huawei.com, yi.zhang@huawei.com,
        "J. R. Okajima" <hooanon05g@gmail.com>,
        Eric Dumazet <eric.dumazet@gmail.com>
Subject: Re: [PATCH] tmpfs: use ida to get inode number
Message-ID: <20191123023325.GY20752@bombadil.infradead.org>
References: <1574259798-144561-1-git-send-email-zhengbin13@huawei.com>
 <20191120154552.GS20752@bombadil.infradead.org>
 <1c64e7c2-6460-49cf-6db0-ec5f5f7e09c4@huawei.com>
 <alpine.LSU.2.11.1911202026040.1825@eggly.anvils>
 <d22bcbcb-d507-7c8c-e946-704ffc499fa6@huawei.com>
 <alpine.LSU.2.11.1911211125190.1697@eggly.anvils>
 <5423a199-eefb-0a02-6e86-1f6210939c11@huawei.com>
 <20191122221327.GW20752@bombadil.infradead.org>
 <77f67d7a-4a93-4319-e6af-54daffcc37e2@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <77f67d7a-4a93-4319-e6af-54daffcc37e2@huawei.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Nov 23, 2019 at 10:16:39AM +0800, zhengbin (A) wrote:
> By the way, percpu IDA is for reducing performance impact? This patch has 2.16%
> performance degradation(Use perf to get the cost of ida_alloc_range)

2.16% degradation in your tests ... I bet Eric didn't make it so complex
for only 2% performance impact.  Unfortunately, he didn't give any
numbers in his patch submission, but it's going to be a bigger problem
on multi-socket machines than on a laptop.

Eric, any memories from 2010?  Commit
f991bd2e14210fb93d722cb23e54991de20e8a3d if it helps.
