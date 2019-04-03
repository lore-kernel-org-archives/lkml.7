Return-Path: <SRS0=7x1k=SF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7B5FFC4360F
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Apr 2019 05:26:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4641D2075E
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Apr 2019 05:26:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728672AbfDCF0l (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 3 Apr 2019 01:26:41 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:49052 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726330AbfDCF0k (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Apr 2019 01:26:40 -0400
Received: from mail-wm1-f70.google.com ([209.85.128.70])
        by youngberry.canonical.com with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
        (Exim 4.76)
        (envelope-from <andrea.righi@canonical.com>)
        id 1hBYQ2-0003xV-H4
        for linux-kernel@vger.kernel.org; Wed, 03 Apr 2019 05:26:38 +0000
Received: by mail-wm1-f70.google.com with SMTP id 7so3587134wmj.9
        for <linux-kernel@vger.kernel.org>; Tue, 02 Apr 2019 22:26:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=ECodeZO9T5iZTHTW0pQrH8foCwy+FC2Ouv0VI/SA1Ss=;
        b=N0Fn0ewRqr0MeEOEudqI/SrCV1LN4b8qVCK2OfRrNoY9ecMB0N7VJo04TlF3pdjSRR
         bsW3f30cXfXgoMDhX1Sht5/lKTwTwWXW6rXRB7VQIygz/aETlydRfEMUW0Jwk34oXh2t
         0rRlWStFGV4XvdLw/rqKd/UoehznjgxRgejWlcjrycJbxNOSzEm4GvNDha4TF6S0NMPk
         pucVI/PQWjDL1khbOMY1cs+X9+LDjBgfLgG4TTLJRUYMjQVNtd3Qe61TKOKIqK0OTPxu
         TuE82jHMn82mRj2byf6gWy3awDIaZ5Sjhov4o+iVxKUCHMSEh+aOfeMgpH9DQbroSRyI
         NU1Q==
X-Gm-Message-State: APjAAAVNOFj7lYkpobr0ql9zQWR0IsxPbRLIaecaQzqsnroDiK0MZnML
        fwFHBrMpQEEjOVyTr6DK9n6KEtVSQzaAaZQp60UZ9WXhqXEbG7cIzjgfmraozBv8Vz+l351G5yX
        SNiMAogiPhD0Y3CSbPXWyYSuQTjzvOwDZ/CvZfKNscA==
X-Received: by 2002:adf:ffc2:: with SMTP id x2mr35849748wrs.86.1554269198285;
        Tue, 02 Apr 2019 22:26:38 -0700 (PDT)
X-Google-Smtp-Source: APXvYqz6wn4GAs3/mxi7+HnSA463u1EJIYzbDZCtS52uQteIk76aOQLqlNSa8Cx4aYgCamrCNj4FSA==
X-Received: by 2002:adf:ffc2:: with SMTP id x2mr35849738wrs.86.1554269198113;
        Tue, 02 Apr 2019 22:26:38 -0700 (PDT)
Received: from localhost (host141-127-dynamic.17-87-r.retail.telecomitalia.it. [87.17.127.141])
        by smtp.gmail.com with ESMTPSA id z18sm24988643wrr.90.2019.04.02.22.26.36
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 02 Apr 2019 22:26:37 -0700 (PDT)
Date:   Wed, 3 Apr 2019 07:26:36 +0200
From:   Andrea Righi <andrea.righi@canonical.com>
To:     Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        Juergen Gross <jgross@suse.com>
Cc:     Stefano Stabellini <sstabellini@kernel.org>,
        xen-devel@lists.xenproject.org, linux-kernel@vger.kernel.org
Subject: [PATCH] xen: use struct_size() helper in kzalloc()
Message-ID: <20190403052636.GC21532@xps-13>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

struct privcmd_buf_vma_private has a zero-sized array at the end
(pages), use the new struct_size() helper to determine the proper
allocation size and avoid potential type mistakes.

Signed-off-by: Andrea Righi <andrea.righi@canonical.com>
---
 drivers/xen/privcmd-buf.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/xen/privcmd-buf.c b/drivers/xen/privcmd-buf.c
index de01a6d0059d..a1c61e351d3f 100644
--- a/drivers/xen/privcmd-buf.c
+++ b/drivers/xen/privcmd-buf.c
@@ -140,8 +140,7 @@ static int privcmd_buf_mmap(struct file *file, struct vm_area_struct *vma)
 	if (!(vma->vm_flags & VM_SHARED))
 		return -EINVAL;
 
-	vma_priv = kzalloc(sizeof(*vma_priv) + count * sizeof(void *),
-			   GFP_KERNEL);
+	vma_priv = kzalloc(struct_size(vma_priv, pages, count), GFP_KERNEL);
 	if (!vma_priv)
 		return -ENOMEM;
 
-- 
2.19.1

