Return-Path: <SRS0=OfNL=RF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1F551C43381
	for <linux-kernel@archiver.kernel.org>; Sat,  2 Mar 2019 18:46:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DC61220830
	for <linux-kernel@archiver.kernel.org>; Sat,  2 Mar 2019 18:46:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="CUzTz9l1"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727065AbfCBSq2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 2 Mar 2019 13:46:28 -0500
Received: from merlin.infradead.org ([205.233.59.134]:36240 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726742AbfCBSq2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 2 Mar 2019 13:46:28 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=tx4ASGBAzLGHsjmHKiJQSkY9E3fWxtKwk1dKqdKBjR8=; b=CUzTz9l1sHNMNJg65FqQcW45S
        jQAFFCxjQF9ThgJz3A2Qvr2QT45McJuM8YIR0vQeFzNmS/wR11nfAumCVEAHUM4t3OsmTzkCqHF/P
        gtGPY1sPXpEnJQsu4XUwGvBLkiIQv1FN/rnY92a+uZywkBZ+82w0O+PE5gRmwxKLrIYMJP06yJGia
        +4CiKQjyBin8njbFCmMveZcadT33ew7N3UPuy7P0Qwd7SZJERQIo4DdMli0v+Jy+rEv0yrX4DkVOW
        E61kXZopbu9X7CIGf/f0f6RsC9sXhFhwVCjLMC5lIrITnNhlX0nwtgN5Fyvi2kUd52lbXvuSAzp/b
        njtINShxQ==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=worktop.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1h09do-0001Yd-RN; Sat, 02 Mar 2019 18:45:45 +0000
Received: by worktop.programming.kicks-ass.net (Postfix, from userid 1000)
        id 5ED0E984351; Sat,  2 Mar 2019 19:45:44 +0100 (CET)
Date:   Sat, 2 Mar 2019 19:45:44 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Jan Stancek <jstancek@redhat.com>
Cc:     linux-mm@kvack.org, akpm@linux-foundation.org, willy@infradead.org,
        riel@surriel.com, mhocko@suse.com, ying.huang@intel.com,
        jrdr.linux@gmail.com, jglisse@redhat.com,
        aneesh.kumar@linux.ibm.com, david@redhat.com, aarcange@redhat.com,
        raquini@redhat.com, rientjes@google.com, kirill@shutemov.name,
        mgorman@techsingularity.net, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] mm/memory.c: do_fault: avoid usage of stale
 vm_area_struct
Message-ID: <20190302184544.GM14054@worktop.programming.kicks-ass.net>
References: <20190302171043.GP11592@bombadil.infradead.org>
 <a5234d11b8cc158352a2f97fc33aa9ad90bb287b.1551550112.git.jstancek@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a5234d11b8cc158352a2f97fc33aa9ad90bb287b.1551550112.git.jstancek@redhat.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Mar 02, 2019 at 07:19:39PM +0100, Jan Stancek wrote:
>  static vm_fault_t do_fault(struct vm_fault *vmf)
>  {
>  	struct vm_area_struct *vma = vmf->vma;
> +	struct mm_struct *vm_mm = READ_ONCE(vma->vm_mm);

Would this not need a corresponding WRITE_ONCE() in vma_init() ?
