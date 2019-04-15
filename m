Return-Path: <SRS0=rNeM=SR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 36CDCC10F12
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Apr 2019 19:08:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0543D218DA
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Apr 2019 19:08:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1555355292;
	bh=wDA8BgB69QwKmaNCBCab98qk8oeUOMkBgfigSCTDWFw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=wABiZWS3PKSzafvfNxu2BwWg+BQtcs4gqlHzVfpFrpAYeO40Raod3AorEKuN4Eods
	 6NrL9xNH6ONT4sVxMScXWEalCF472ul06QY0Tw4neSEPbVGF3k5zyZoMPC8gc3klIb
	 gOnfEkK2Sp9ijAp/LzmpzJNvoeFXF2nOnOVyP7Po=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730400AbfDOTIK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 15 Apr 2019 15:08:10 -0400
Received: from mail.kernel.org ([198.145.29.99]:43450 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728831AbfDOTIJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Apr 2019 15:08:09 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B3573218D3;
        Mon, 15 Apr 2019 19:08:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1555355289;
        bh=wDA8BgB69QwKmaNCBCab98qk8oeUOMkBgfigSCTDWFw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=S8qvIykxFKyrf7kmi+W+85lXsM2F6I3z6Swp6GCvaLcfGrev00rEZ02YP1ErIaGNm
         sueJYGC4QRUevTUbarnbBTBjTNXcAo4TR4DvXaDBx+9KNDCAd7DIEx0agl+1dLACA5
         LUJARmVfq2o4fVHCOiOlK+xDJtnQRDgeWWSsgRyg=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Cfir Cohen <cfir@google.com>,
        David Rientjes <rientjes@google.com>,
        Paolo Bonzini <pbonzini@redhat.com>
Subject: [PATCH 4.19 062/101] kvm: svm: fix potential get_num_contig_pages overflow
Date:   Mon, 15 Apr 2019 20:59:00 +0200
Message-Id: <20190415183743.780156661@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190415183740.341577907@linuxfoundation.org>
References: <20190415183740.341577907@linuxfoundation.org>
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
@@ -6398,11 +6398,11 @@ e_free:
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
@@ -6421,12 +6421,12 @@ static int get_num_contig_pages(int idx,
 
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


