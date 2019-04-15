Return-Path: <SRS0=rNeM=SR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7EB72C282DA
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Apr 2019 19:17:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 41C032073F
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Apr 2019 19:17:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1555355858;
	bh=jnhI1SW6PzPLfF/eg+DULhf40qnrEEGcKswVWrHmru8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=bGrUIWsbg/SJt0Yc4gc3NClnPnxUVhQJr9kru0/bJFb0lUge+yiGKHIH2HjGXZ+lA
	 3x4K2M9JX0uXNPKPunAoKRAF3gyA68TFaKuBWK2p+aX0JQVu8EIkiyPlb7WjtSBnTx
	 Zt5NuNTqjIBACc7r6SrQLi3UcXEZBa8+U7CEwNaM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731355AbfDOTMM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 15 Apr 2019 15:12:12 -0400
Received: from mail.kernel.org ([198.145.29.99]:49368 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730897AbfDOTMJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Apr 2019 15:12:09 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id CC7CB218D3;
        Mon, 15 Apr 2019 19:12:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1555355528;
        bh=jnhI1SW6PzPLfF/eg+DULhf40qnrEEGcKswVWrHmru8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ymJ3/2BvzSew2M8tbg8x0yqGa0gmwb96DEzozwueJ136UWWdbMQhHz2qalaMjrTP6
         6K4qDPETNLwotEHYIisqyxc2O3zV7rPkaJ9Bs7q9Lf3Qq1xWRjyEf/m8R9mTX/iZ4K
         iGnfugEa2rR4vG4RaMmYwNgK4NtfM3A8fg/OTjFs=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Cfir Cohen <cfir@google.com>,
        David Rientjes <rientjes@google.com>,
        Paolo Bonzini <pbonzini@redhat.com>
Subject: [PATCH 5.0 069/117] kvm: svm: fix potential get_num_contig_pages overflow
Date:   Mon, 15 Apr 2019 21:00:39 +0200
Message-Id: <20190415183748.476525476@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190415183744.887851196@linuxfoundation.org>
References: <20190415183744.887851196@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: David Rientjes <rientjes@google.com>

commit ede885ecb2cdf8a8dd5367702e3d964ec846a2d5 upstream.

get_num_contig_pages() could potentially overflow int so make its type
consistent with its usage.

Reported-by: Cfir Cohen <cfir@google.com>
Cc: stable@vger.kernel.org
Signed-off-by: David Rientjes <rientjes@google.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 arch/x86/kvm/svm.c |   10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

--- a/arch/x86/kvm/svm.c
+++ b/arch/x86/kvm/svm.c
@@ -6422,11 +6422,11 @@ e_free:
 	return ret;
 }
 
-static int get_num_contig_pages(int idx, struct page **inpages,
-				unsigned long npages)
+static unsigned long get_num_contig_pages(unsigned long idx,
+				struct page **inpages, unsigned long npages)
 {
 	unsigned long paddr, next_paddr;
-	int i = idx + 1, pages = 1;
+	unsigned long i = idx + 1, pages = 1;
 
 	/* find the number of contiguous pages starting from idx */
 	paddr = __sme_page_pa(inpages[idx]);
@@ -6445,12 +6445,12 @@ static int get_num_contig_pages(int idx,
 
 static int sev_launch_update_data(struct kvm *kvm, struct kvm_sev_cmd *argp)
 {
-	unsigned long vaddr, vaddr_end, next_vaddr, npages, size;
+	unsigned long vaddr, vaddr_end, next_vaddr, npages, pages, size, i;
 	struct kvm_sev_info *sev = &to_kvm_svm(kvm)->sev_info;
 	struct kvm_sev_launch_update_data params;
 	struct sev_data_launch_update_data *data;
 	struct page **inpages;
-	int i, ret, pages;
+	int ret;
 
 	if (!sev_guest(kvm))
 		return -ENOTTY;


