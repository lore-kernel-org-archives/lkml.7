Return-Path: <SRS0=Q+aa=S3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B9CF0C4321A
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Apr 2019 22:06:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C1F5920717
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Apr 2019 22:06:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1556230015;
	bh=pTQtAHspL95zxJddIdjsMFYFi1GDq9/62hbgXWVMqjo=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=qCTWT5EiR3FvYuU6n54wKGFJiEhS7IaoCqDdB25RaGuIZeQ/2glFdcpE2Uk04066G
	 ZAU6JfgYlkCXzkhsl2cym1OZP264YIoTJYztDeQQT2YDfJXUDRoZu2P45wEh2Xgtqa
	 sxyCQr3rT1nT68JvwWIpmIMcHG409tc0neT3GKI4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731090AbfDYWGy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Apr 2019 18:06:54 -0400
Received: from mail.kernel.org ([198.145.29.99]:57628 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725937AbfDYWGy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Apr 2019 18:06:54 -0400
Received: from akpm3.svl.corp.google.com (unknown [104.133.8.65])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 710C0206C1;
        Thu, 25 Apr 2019 22:06:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1556230013;
        bh=pTQtAHspL95zxJddIdjsMFYFi1GDq9/62hbgXWVMqjo=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=Ails9T8CojwAO9sK1f6aZbChd79rBPu0v09MKfCS9kWfNKaWDQ6o88pvABoz9fOMH
         hWb5NpD001XQfJi9etUcPuR731QdXDRgtb3iNU0xkiPRhDKhF6aHP+4OBDWLzj492G
         Yjlt0G9O9yVngR2HUsyXFyvABHSc/E82jEWNEXhc=
Date:   Thu, 25 Apr 2019 15:06:52 -0700
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Joel Savitz <jsavitz@redhat.com>
Cc:     linux-kernel@vger.kernel.org,
        Alexey Dobriyan <adobriyan@gmail.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Ram Pai <linuxram@us.ibm.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Huang Ying <ying.huang@intel.com>,
        Sandeep Patil <sspatil@android.com>,
        Rafael Aquini <aquini@redhat.com>,
        linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH] fs/proc: add VmTaskSize field to /proc/$$/status
Message-Id: <20190425150652.627fb21a40c18e1c32ed2125@linux-foundation.org>
In-Reply-To: <1556225867-458-1-git-send-email-jsavitz@redhat.com>
References: <1556225867-458-1-git-send-email-jsavitz@redhat.com>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 25 Apr 2019 16:57:47 -0400 Joel Savitz <jsavitz@redhat.com> wrote:

> Currently, there is no fast mechanism to get the virtual memory size of
> the current process from userspace. This information is available to the
> user through several means, one being a linear search of the entire address
> space. This is the method used by a component of the libhugetlb kernel
> test, and using the mechanism proposed in this patch, the time complexity
> of that test would be upgraded to constant time from linear time. This is
> especially relevant on 64-bit architechtures where a linear search of
> the address space could take an absurd amount of time. Using this
> mechanism, the modification to the test component would be portable
> across all architechtures.

Please include all details on the observed performance improvements.

>  fs/proc/task_mmu.c | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)

Please update Documentation/filesystems/proc.txt.


