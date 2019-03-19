Return-Path: <SRS0=B1dt=RW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 76112C43381
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Mar 2019 22:20:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3E57E2175B
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Mar 2019 22:20:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="XfpYf4gL"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727518AbfCSWUE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Mar 2019 18:20:04 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:41838 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727421AbfCSWT6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Mar 2019 18:19:58 -0400
Received: by mail-pf1-f196.google.com with SMTP id d25so362946pfn.8
        for <linux-kernel@vger.kernel.org>; Tue, 19 Mar 2019 15:19:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:user-agent:mime-version;
        bh=59RGI7G7pmr5cNfnWSfGjhKSPq5Y0VsvQ6GYsDbuqfs=;
        b=XfpYf4gL1c44dexWEA7/hn7uwvJMen3gV457ORsj+K56A2l9K4zVq4d0xAt/eV5fYQ
         FFdfSejAoM/wUrBF0katomC+jxmtew9xvorimKgXDejrEiSiepz/JtHerg1LrEPRXy4E
         7VBIREzygXHHEPHy6zske8Spvrk74fwKoySsY0vNLW4CVvJSH/KXkSwfdPD7kinZQwvU
         md4DMtxPynIkLB5XqaaMmNfWNvtzUy0u2tzr+8YYEPVljgDTX48TmK8eRv3RPpbCghVp
         cdCq+FgXDMTifYwo6k5tpotrI0haDb9mUKhNUr02JfD9Hjb9RYMT47nb8X5PJKbqnB+4
         za4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:user-agent
         :mime-version;
        bh=59RGI7G7pmr5cNfnWSfGjhKSPq5Y0VsvQ6GYsDbuqfs=;
        b=WrKDjvOaUtSpAeA2iDfNdm6iAo5rGWGyD75Eo8MYTTR6lI5CDpXlbQ25xS2+YPN7sq
         O2nrtCiyNjytWUhv4YSxmx8ioxwypWf+WXLpLTEvgZ7hExixaWou5eN2ToeO7UxfhVcQ
         LQJhhpgG1xDuKHP+oe/uW3ee7FfYaAJiKzafb1AGo/cZNUDxaUUk09AT2tI9TZp4uIqZ
         zSH2josaP4WBX0BHat6Mj6ApZibHxGsLdCfrLjU2HtyHTgond8vSR5KJqF8K5Xzf3pB3
         tBqUmSe5HTyUIe+f6WrT2EDf0OQbMGmM5uVrJ7LVWvI4eiEKOTKudluywc1sILQip0E9
         DiMw==
X-Gm-Message-State: APjAAAUd5n/kg90G9V1uBvSGd5xKV249f/WRzUnq3lQmiDpkDCyV0pQM
        3xrYLOGPdTdHWg7MRKUkKZFcZQ==
X-Google-Smtp-Source: APXvYqxU8lzqwVXJMTs59fVnzSRbf+8jxap77aX/EoV/+K6jh4ghRHHZhbPshUAGv7LFYZRYATv3gw==
X-Received: by 2002:a17:902:14b:: with SMTP id 69mr4383333plb.216.1553033997376;
        Tue, 19 Mar 2019 15:19:57 -0700 (PDT)
Received: from [2620:15c:17:3:3a5:23a7:5e32:4598] ([2620:15c:17:3:3a5:23a7:5e32:4598])
        by smtp.gmail.com with ESMTPSA id j1sm15846pgp.84.2019.03.19.15.19.56
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 19 Mar 2019 15:19:56 -0700 (PDT)
Date:   Tue, 19 Mar 2019 15:19:56 -0700 (PDT)
From:   David Rientjes <rientjes@google.com>
X-X-Sender: rientjes@chino.kir.corp.google.com
To:     Paolo Bonzini <pbonzini@redhat.com>,
        =?UTF-8?Q?Radim_Kr=C4=8Dm=C3=A1=C5=99?= <rkrcmar@redhat.com>,
        Joerg Roedel <joro@8bytes.org>
cc:     Cfir Cohen <cfir@google.com>,
        Brijesh Singh <brijesh.singh@amd.com>,
        Tom Lendacky <thomas.lendacky@amd.com>, x86@kernel.org,
        kvm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [patch] kvm: svm: fix potential get_num_contig_pages overflow
Message-ID: <alpine.DEB.2.21.1903191517380.256304@chino.kir.corp.google.com>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

get_num_contig_pages() could potentially overflow int so make its type 
consistent with its usage.

Reported-by: Cfir Cohen <cfir@google.com>
Signed-off-by: David Rientjes <rientjes@google.com>
---
 arch/x86/kvm/svm.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/arch/x86/kvm/svm.c b/arch/x86/kvm/svm.c
--- a/arch/x86/kvm/svm.c
+++ b/arch/x86/kvm/svm.c
@@ -6422,11 +6422,11 @@ static int sev_launch_start(struct kvm *kvm, struct kvm_sev_cmd *argp)
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
@@ -6445,12 +6445,12 @@ static int get_num_contig_pages(int idx, struct page **inpages,
 
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
