Return-Path: <SRS0=B1dt=RW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_MUTT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 723ADC10F00
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Mar 2019 02:26:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 402AB20850
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Mar 2019 02:26:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="axQ01i8I"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727670AbfCSC0R (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Mar 2019 22:26:17 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:44624 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726884AbfCSC0R (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Mar 2019 22:26:17 -0400
Received: by mail-pf1-f196.google.com with SMTP id a3so12592386pff.11
        for <linux-kernel@vger.kernel.org>; Mon, 18 Mar 2019 19:26:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=F9hIq6OqtC1SVS2O3U7ZkPoLnNclA70DsapCWy7Q+lE=;
        b=axQ01i8IBZi45x8kocMbwsCnxyGWV2J6KPZD0Kvgs2/Yaw/Le0kbKh4v6TjS8TlLN/
         Fp1i11g2wUSy9AxXfQGRlmcKVs6D+8q5JgaGppoXZDWZ6E08ke8uQygcG2EGAEoCtGsx
         UFLiaLRZlpLGEKiubhXWZ/PmRqC3+92ojBfVO/yWdt0kFn/ZAPUhGKykq5XnL7GFNyle
         wwduJrwn8QRqkDXVKxcrG+gP4/1dGOKT1a0MvDM0uxgedBI0PBb86jSFen+JBmyPEcp5
         OtUtOsoojCEt6asjiBR1//iQ0mQm9kT1vJjSfz2yiTcGpUHiyQD6dTVTpKpFvR5WdtUP
         RHDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=F9hIq6OqtC1SVS2O3U7ZkPoLnNclA70DsapCWy7Q+lE=;
        b=B87s+VofwPsS2gNXyBRTVZIUtrvz3xiCFrCNJWM410cenHMmFuxTUCafea3Rsx88Yy
         NE3f/ntYlgoGB5GoLfo8U59/gw59755t0lFlIgxahfO42V4qMs0Ytga6bgjlm4dHPaRy
         0psPvuTNwXS7jYdRR1DbbA9j0BeOBmid/JCNVT7daX+Vq6pF1C+BKG58HBGcGU9l5/Qf
         SHkYSHwk4Ui8va+kiFTRIbPYfQtjd7GPN+dVwJyVXYVIoFqafB1SoZywaWybm59TpWyF
         ALETC0pIUMa2Rqc5td1JeVZjueHQO6LWD6U2cmQ7HDqBgvmefLWLUd7fNnWkUaIAte4t
         oGmQ==
X-Gm-Message-State: APjAAAVbMLYZpDC1M3BKyG8oV0Ck8nd5046cPzLzGSqinnjdbZMUJtFV
        3OfkyGf7TGYgc4hU5YKk+8c=
X-Google-Smtp-Source: APXvYqzT+r2qSiocZjhBB5Mm80gaR6+7Ywju7MjSzVTtt6VaSEqofhbQuEZfX4U+yLgEjsULEq7Ykw==
X-Received: by 2002:a63:f74c:: with SMTP id f12mr75210pgk.124.1552962376538;
        Mon, 18 Mar 2019 19:26:16 -0700 (PDT)
Received: from jordon-HP-15-Notebook-PC ([106.51.22.39])
        by smtp.gmail.com with ESMTPSA id u13sm18812634pfa.169.2019.03.18.19.26.15
        (version=TLS1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 18 Mar 2019 19:26:15 -0700 (PDT)
Date:   Tue, 19 Mar 2019 08:00:51 +0530
From:   Souptick Joarder <jrdr.linux@gmail.com>
To:     akpm@linux-foundation.org, willy@infradead.org, mhocko@suse.com,
        boris.ostrovsky@oracle.com, jgross@suse.com, linux@armlinux.org.uk,
        robin.murphy@arm.com
Cc:     xen-devel@lists.xenproject.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org
Subject: [RESEND PATCH v4 9/9] xen/privcmd-buf.c: Convert to use
 vm_map_pages_zero()
Message-ID: <acf678e81d554d01a9b590716ac0ccbdcdf71c25.1552921225.git.jrdr.linux@gmail.com>
References: <cover.1552921225.git.jrdr.linux@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1552921225.git.jrdr.linux@gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Convert to use vm_map_pages_zero() to map range of kernel
memory to user vma.

This driver has ignored vm_pgoff. We could later "fix" these drivers
to behave according to the normal vm_pgoff offsetting simply by
removing the _zero suffix on the function name and if that causes
regressions, it gives us an easy way to revert.

Signed-off-by: Souptick Joarder <jrdr.linux@gmail.com>
Reviewed-by: Boris Ostrovsky <boris.ostrovsky@oracle.com>
---
 drivers/xen/privcmd-buf.c | 8 ++------
 1 file changed, 2 insertions(+), 6 deletions(-)

diff --git a/drivers/xen/privcmd-buf.c b/drivers/xen/privcmd-buf.c
index de01a6d..d02dc43 100644
--- a/drivers/xen/privcmd-buf.c
+++ b/drivers/xen/privcmd-buf.c
@@ -166,12 +166,8 @@ static int privcmd_buf_mmap(struct file *file, struct vm_area_struct *vma)
 	if (vma_priv->n_pages != count)
 		ret = -ENOMEM;
 	else
-		for (i = 0; i < vma_priv->n_pages; i++) {
-			ret = vm_insert_page(vma, vma->vm_start + i * PAGE_SIZE,
-					     vma_priv->pages[i]);
-			if (ret)
-				break;
-		}
+		ret = vm_map_pages_zero(vma, vma_priv->pages,
+						vma_priv->n_pages);
 
 	if (ret)
 		privcmd_buf_vmapriv_free(vma_priv);
-- 
1.9.1

