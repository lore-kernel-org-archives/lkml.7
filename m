Return-Path: <SRS0=LehB=SZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2B6B7C282DD
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Apr 2019 15:44:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EFB732175B
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Apr 2019 15:44:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="NEIbYExU"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728464AbfDWPo3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Apr 2019 11:44:29 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:42426 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728406AbfDWPo2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Apr 2019 11:44:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=WDEv88QESu3Sjr0dtUvh/asa7Lnwdk5HgQ8xFvHFf1s=; b=NEIbYExUOdJSpXZo0hWf9PcwX
        cdWgbFsV6XJ/EHnkl5wNVhMfOBhgqbgPdSVRScg53O8Vzes9HZOz/vHUQpgmInss9I4bDbNkqirZ0
        QHSGbTmREhQuNrr4WrnrO9kL2jCb15Gldw9AzKRuyIyseN2CwsInRjZb6wgz/QtW1eD1jT/TVhmA2
        SeWDL9iLfmeFAqhCU+9lb3OhO7VgTMjRnXFyCAYNYqwv4Uf6X8pwRT4X8T+5W8Qrifdi7o5wfWFhV
        51hneWv26L363YOBTiVNMxsIKVij/5698Nc11FBfFLAPWMGpRwMhMJDdX9GuufyxdewnwVDmVnNbb
        EIjplXgPA==;
Received: from willy by bombadil.infradead.org with local (Exim 4.90_1 #2 (Red Hat Linux))
        id 1hIxaJ-0001JO-98; Tue, 23 Apr 2019 15:43:51 +0000
Date:   Tue, 23 Apr 2019 08:43:51 -0700
From:   Matthew Wilcox <willy@infradead.org>
To:     Laurent Dufour <ldufour@linux.ibm.com>
Cc:     akpm@linux-foundation.org, mhocko@kernel.org, peterz@infradead.org,
        kirill@shutemov.name, ak@linux.intel.com, dave@stgolabs.net,
        jack@suse.cz, aneesh.kumar@linux.ibm.com, benh@kernel.crashing.org,
        mpe@ellerman.id.au, paulus@samba.org,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, hpa@zytor.com,
        Will Deacon <will.deacon@arm.com>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        sergey.senozhatsky.work@gmail.com,
        Andrea Arcangeli <aarcange@redhat.com>,
        Alexei Starovoitov <alexei.starovoitov@gmail.com>,
        kemi.wang@intel.com, Daniel Jordan <daniel.m.jordan@oracle.com>,
        David Rientjes <rientjes@google.com>,
        Jerome Glisse <jglisse@redhat.com>,
        Ganesh Mahendran <opensource.ganesh@gmail.com>,
        Minchan Kim <minchan@kernel.org>,
        Punit Agrawal <punitagrawal@gmail.com>,
        vinayak menon <vinayakm.list@gmail.com>,
        Yang Shi <yang.shi@linux.alibaba.com>,
        zhong jiang <zhongjiang@huawei.com>,
        Haiyan Song <haiyanx.song@intel.com>,
        Balbir Singh <bsingharora@gmail.com>, sj38.park@gmail.com,
        Michel Lespinasse <walken@google.com>,
        Mike Rapoport <rppt@linux.ibm.com>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        haren@linux.vnet.ibm.com, npiggin@gmail.com,
        paulmck@linux.vnet.ibm.com, Tim Chen <tim.c.chen@linux.intel.com>,
        linuxppc-dev@lists.ozlabs.org, x86@kernel.org
Subject: Re: [PATCH v12 07/31] mm: make pte_unmap_same compatible with SPF
Message-ID: <20190423154351.GB19031@bombadil.infradead.org>
References: <20190416134522.17540-1-ldufour@linux.ibm.com>
 <20190416134522.17540-8-ldufour@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190416134522.17540-8-ldufour@linux.ibm.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 16, 2019 at 03:44:58PM +0200, Laurent Dufour wrote:
> +static inline vm_fault_t pte_unmap_same(struct vm_fault *vmf)
>  {
> -	int same = 1;
> +	int ret = 0;

Surely 'ret' should be of type vm_fault_t?

> +			ret = VM_FAULT_RETRY;

... this should have thrown a sparse warning?

