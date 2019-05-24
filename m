Return-Path: <SRS0=Z4g5=TY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5A757C282DD
	for <linux-kernel@archiver.kernel.org>; Fri, 24 May 2019 02:19:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0C3CB217D7
	for <linux-kernel@archiver.kernel.org>; Fri, 24 May 2019 02:19:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="S7KSm6iw"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387945AbfEXCTz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 23 May 2019 22:19:55 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:41182 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731745AbfEXCTy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 May 2019 22:19:54 -0400
Received: by mail-pf1-f194.google.com with SMTP id q17so4322654pfq.8
        for <linux-kernel@vger.kernel.org>; Thu, 23 May 2019 19:19:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=1r65OmAtTuTYfs4yCjT89JrdvU2o2JvcprLZLVLaQKA=;
        b=S7KSm6iwowOOw2c1qrqgNfr1w5f2iQexcfmaSBrKX2vuxyB+5PmCJX+37ASe73cNw4
         Ubgd7Ac2B5ArJbeuNYLavu8q8mq0jEBg/GWFGJs16LjNmbk6KqftPrDm9nxXdZEUxI59
         Fz0y7zv0ByWxf1CWiLfFz2C8Hqz83dPadArVy7Q9ExLgZsikqNbEu5m5W8vROIldlihv
         oYrwsaILxnTbb+k7jo8J6awc2IVucAFoIEGJGA08XXSs74EZJlIL8I1LZ6leli6w4wD8
         ubh4LVJsjdl40mOG4HlhXxp8rXtU+RzQIIKXeUngwf0Wpem+k/vQa3kWFibR134FtCi3
         yD/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=1r65OmAtTuTYfs4yCjT89JrdvU2o2JvcprLZLVLaQKA=;
        b=En4qNAKIFMeUbg2RxcRznClWzlkBrhK4ZycPMGKGJRX/q+E6M2sgWdIQVN5yaB4jct
         VsodRfb9HhcI0GsHFAsDml4gmvgxoXknZS64VOdWr3HNgHZr657NxPbBLAduB2NL6M2A
         fEliyrp4AslMipmtNehRs9k9Sb7QKbB2noOHGA62cQTLKARkEH+NNoB8bfG1Zm4gTZ0s
         Had4WqXyGeEocZNhwxGXzsP115pUenCza1DozdMw1WSWTyDevsMwP/g712CqjfLzj7tB
         Uh6PeeNWp7uhIfZjopoFVY+vFPVuLPMh2yG967p21Gskhx/H5HdZdTy2/pEOd1RMLaDP
         XTfw==
X-Gm-Message-State: APjAAAXskjO7VPcNs3G3GOSFfHRR10OKl19BPXhVgh81CXwlqvO0/NFd
        ynVperznw47/kG7HFLMvKU2oRWBFzuM=
X-Google-Smtp-Source: APXvYqyyZdbdCpm+5BbvFdQDihC5nJHyUfP+iN02RlBLMKB2ysC8SIDandY0irZVbdVgIWw/ZqyHDg==
X-Received: by 2002:a62:ac0a:: with SMTP id v10mr108775273pfe.57.1558664393807;
        Thu, 23 May 2019 19:19:53 -0700 (PDT)
Received: from zhanggen-UX430UQ ([66.42.35.75])
        by smtp.gmail.com with ESMTPSA id t7sm728742pfh.156.2019.05.23.19.19.44
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 23 May 2019 19:19:53 -0700 (PDT)
Date:   Fri, 24 May 2019 10:19:32 +0800
From:   Gen Zhang <blackgod016574@gmail.com>
To:     jslaby@suse.com
Cc:     keescook@chromium.org, khorenko@virtuozzo.com,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2] consolemap: Fix a memory leaking bug in
 con_insert_unipair()
Message-ID: <20190524021932.GA4866@zhanggen-UX430UQ>
References: <20190521092935.GA2297@zhanggen-UX430UQ>
 <201905211342.DE554F0D@keescook>
 <20190522015055.GC4093@zhanggen-UX430UQ>
 <201905221353.AD8E585E6D@keescook>
 <20190523003452.GB14060@zhanggen-UX430UQ>
 <201905230952.B47ADA17A@keescook>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <201905230952.B47ADA17A@keescook>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In function con_insert_unipair(), when allocation for p2 and p1[n]
fails, ENOMEM is returned, but previously allocated p1 is not freed, 
remains as leaking memory. Thus we should free p1 as well when this
allocation fails.

Signed-off-by: Gen Zhang <blackgod016574@gmail.com>
Reviewed-by: Kees Cook <keescook@chromium.org>
---
diff --git a/drivers/tty/vt/consolemap.c b/drivers/tty/vt/consolemap.c
index b28aa0d..79fcc96 100644
--- a/drivers/tty/vt/consolemap.c
+++ b/drivers/tty/vt/consolemap.c
@@ -489,7 +489,11 @@ con_insert_unipair(struct uni_pagedir *p, u_short unicode, u_short fontpos)
 	p2 = p1[n = (unicode >> 6) & 0x1f];
 	if (!p2) {
 		p2 = p1[n] = kmalloc_array(64, sizeof(u16), GFP_KERNEL);
-		if (!p2) return -ENOMEM;
+		if (!p2) {
+			kfree(p1);
+			p->uni_pgdir[n] = NULL;
+			return -ENOMEM;
+		}
 		memset(p2, 0xff, 64*sizeof(u16)); /* No glyphs for the characters (yet) */
 	}
 
---
