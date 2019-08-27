Return-Path: <SRS0=qJmF=WX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0DFFDC3A5A3
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Aug 2019 20:40:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B50532077B
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Aug 2019 20:40:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="thwZre+v"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730518AbfH0Uk2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 27 Aug 2019 16:40:28 -0400
Received: from mail-vk1-f202.google.com ([209.85.221.202]:45267 "EHLO
        mail-vk1-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726584AbfH0Uk2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Aug 2019 16:40:28 -0400
Received: by mail-vk1-f202.google.com with SMTP id c65so223547vkg.12
        for <linux-kernel@vger.kernel.org>; Tue, 27 Aug 2019 13:40:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=J7Ohnds+A9ovXQdZzadUakafh+P4fUUaEWG9NoT89Rg=;
        b=thwZre+vfdeUyR0h7L2yCKuWA2znWIDH+Bw7v7hNIdznHaTRSi2dsWr3wHsdxO5p2G
         4gap3akaSI0XfBlo7jufAwxKZ3gFY2xTQhQtb2CtE3fSc4QSPbWt1num9gjZ2SJN9rwk
         zgs7mEYf1ClluXfrZ+VWcTZvq+mWam6tr+IG43JjpG4tILrmVPlYYsE0Z23N1CRi2r1T
         pbZ/Q/odS6M9ZxhTIXoh6xKlSJyoNhrnudn7/X0TKXw+A0wazeC0JR/4VrTlrriCrZA1
         Vd2mTJjsENlTw4i9LHws9DWjxcQe9KdUbgidIcVOsTZWkhX74cfLGNcDbbXeEjlfha9D
         dd1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=J7Ohnds+A9ovXQdZzadUakafh+P4fUUaEWG9NoT89Rg=;
        b=NTR1L0m3zjJn6iqxeawFxc42fxLlfSahJLpyiM77BPLTW9fUdITRQpQVkLih3szRVy
         Veg8VtEmQGVs0rdRV6QpRgbi54ovY+zQ59Lbr2TksqEg1v94UF+qwAHCbTB6MSkJyc25
         +1Z3nk3fk8RAwS7Y4cK7vM/E6lUZy9nprl87yeGXYIWLl6CHtmTp669Nv/LKVoZ/0+gc
         h0A6y3Yknsm5oynWZtIUgy5i9uacAFMcENB9LlMYkNnHt3c6QGpYkDVLWcav2xEY49P8
         bE5003k3rNNzhXc1MsBVy0sRJhbHogYatVK6+tPMzoebjbfvBCMVK8FF0DghDk8rUPFM
         h+iw==
X-Gm-Message-State: APjAAAVED0ET97wwox/hrq0ZoRjuKzqlqD1JbeiyeeECr+d2lrxFuFT/
        DhURFWSKOTpKrwRxrk+6vZxY6+e1D3IMmGvaY/g=
X-Google-Smtp-Source: APXvYqy/PLRZlpLAsk27WTRD4dZL1O5ZR6iz8NhWZpTEB8c+hA0EfY3oBXryLtS+NehDuiSYW1CfI1zpr2wNRYeSkkc=
X-Received: by 2002:a1f:fc0a:: with SMTP id a10mr437887vki.21.1566938426805;
 Tue, 27 Aug 2019 13:40:26 -0700 (PDT)
Date:   Tue, 27 Aug 2019 13:39:54 -0700
In-Reply-To: <20190827204007.201890-1-ndesaulniers@google.com>
Message-Id: <20190827204007.201890-2-ndesaulniers@google.com>
Mime-Version: 1.0
References: <20190827204007.201890-1-ndesaulniers@google.com>
X-Mailer: git-send-email 2.23.0.187.g17f5b7556c-goog
Subject: [PATCH v2 01/14] s390/boot: perfer __section from compiler_attributes.h
From:   Nick Desaulniers <ndesaulniers@google.com>
To:     miguel.ojeda.sandonis@gmail.com
Cc:     sedat.dilek@gmail.com, will@kernel.org, jpoimboe@redhat.com,
        naveen.n.rao@linux.vnet.ibm.com, davem@davemloft.net,
        paul.burton@mips.com, clang-built-linux@googlegroups.com,
        linux-kernel@vger.kernel.org,
        Nick Desaulniers <ndesaulniers@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

GCC unescapes escaped string section names while Clang does not. Because
__section uses the `#` stringification operator for the section name, it
doesn't need to be escaped.

This antipattern was found with:
$ grep -e __section\(\" -e __section__\(\" -r

Reported-by: Sedat Dilek <sedat.dilek@gmail.com>
Suggested-by: Josh Poimboeuf <jpoimboe@redhat.com>
Signed-off-by: Nick Desaulniers <ndesaulniers@google.com>
---
 arch/s390/boot/startup.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/s390/boot/startup.c b/arch/s390/boot/startup.c
index 7b0d05414618..26493c4ff04b 100644
--- a/arch/s390/boot/startup.c
+++ b/arch/s390/boot/startup.c
@@ -46,7 +46,7 @@ struct diag_ops __bootdata_preserved(diag_dma_ops) = {
 	.diag0c = _diag0c_dma,
 	.diag308_reset = _diag308_reset_dma
 };
-static struct diag210 _diag210_tmp_dma __section(".dma.data");
+static struct diag210 _diag210_tmp_dma __section(.dma.data);
 struct diag210 *__bootdata_preserved(__diag210_tmp_dma) = &_diag210_tmp_dma;
 void _swsusp_reset_dma(void);
 unsigned long __bootdata_preserved(__swsusp_reset_dma) = __pa(_swsusp_reset_dma);
-- 
2.23.0.187.g17f5b7556c-goog

