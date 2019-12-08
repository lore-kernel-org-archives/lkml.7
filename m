Return-Path: <SRS0=RGqN=Z6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DAED4C43603
	for <linux-kernel@archiver.kernel.org>; Sun,  8 Dec 2019 17:14:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AC3B020409
	for <linux-kernel@archiver.kernel.org>; Sun,  8 Dec 2019 17:14:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Qai/udvm"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726566AbfLHROQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 8 Dec 2019 12:14:16 -0500
Received: from mail-wr1-f48.google.com ([209.85.221.48]:41677 "EHLO
        mail-wr1-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726472AbfLHROQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 8 Dec 2019 12:14:16 -0500
Received: by mail-wr1-f48.google.com with SMTP id c9so13376767wrw.8
        for <linux-kernel@vger.kernel.org>; Sun, 08 Dec 2019 09:14:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=ddevDPP88nZOueUc2DyGhMNdWqs4rNbRqoG40CMVqG0=;
        b=Qai/udvm07uHAC2Ufk+JLYlXQ4awUpyk/isTVpRTYECJcI6u4JTha+T7A5EbqrN3vW
         r2TqNiFfoxr4jaa2TkdWZ5Ikuggxe0eC+qu97XZ0eZjosyn4pvYZ++oScj+4ZFgOUhNI
         gfJDgA4560geLe6oMmMw1xAs93cVngO+uyC7hr80GlY/oBD6Xc9Sd77I7miTpog7T6RP
         SVZO2zWJCdmop9TigsRfiG8P32kMKRNr97wivuBqVNJobxpcG9YGknNkJrpQLW6qbirj
         SO8tvm0fQIdf3OjVAubP0MjDaA0VRus0rK2z0Ypt0AZsIj9uO3asEEODEgTR2CvJDVYo
         hx3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=ddevDPP88nZOueUc2DyGhMNdWqs4rNbRqoG40CMVqG0=;
        b=RGgM3uql2+JX0za8asLKino8K6IQSsWanOgAaPhztM4uvPR6skfqZ0BU53xTJiyY+A
         NBDMOT7KyFX9EEDEehO4DkhidbtMfsO4AjDZ9aY7kIxaeDt9tpZdZ5O9HVRi+HBSw3rM
         VmlGLzlpgWReFDBaZya/OYLKcv2oGq14StT7q7DhPeGXK+xsse3LtlyhPPSPSW+UmSAB
         3u8FOLyJROm/nQthANH+DqH9f7VI4xppsiwliRWEKnBDPwacai2/Ag/riAOXC1WKNtOu
         UGV/WbvR8epUkNfYYmU5E3S6YSaLWqaOrSxYkL5Ye0Md7x9Ch/6/afLYIUu8RXS8kCeC
         sn8A==
X-Gm-Message-State: APjAAAWciU5hVAkj/TbpA8LI64YkmccpqPM5cMb0JiIpj9IN0ykQxytr
        SDZ4KgGAzZ7IEpQ9yVcDljIy9cQ=
X-Google-Smtp-Source: APXvYqwBrx5k8DPOm6/k/YHSxnrqoOijbxgJXBuxvB4Tmp7u9eyxE0WsD8wQ4cSrg2O+olPyV4XiFQ==
X-Received: by 2002:adf:e74a:: with SMTP id c10mr25706890wrn.386.1575825254063;
        Sun, 08 Dec 2019 09:14:14 -0800 (PST)
Received: from avx2 ([46.53.249.42])
        by smtp.gmail.com with ESMTPSA id g9sm23429171wro.67.2019.12.08.09.14.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 08 Dec 2019 09:14:13 -0800 (PST)
Date:   Sun, 8 Dec 2019 20:14:10 +0300
From:   Alexey Dobriyan <adobriyan@gmail.com>
To:     akpm@linux-foundation.org
Cc:     linux-kernel@vger.kernel.org
Subject: [PATCH] ELF: fix ->start_code calculation
Message-ID: <20191208171410.GB19716@avx2>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Only executable segments should be accounted to ->start_code
just like they do to ->end_code (correctly).

Signed-off-by: Alexey Dobriyan <adobriyan@gmail.com>
---

 fs/binfmt_elf.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/fs/binfmt_elf.c
+++ b/fs/binfmt_elf.c
@@ -997,7 +997,7 @@ static int load_elf_binary(struct linux_binprm *bprm)
 			}
 		}
 		k = elf_ppnt->p_vaddr;
-		if (k < start_code)
+		if ((elf_ppnt->p_flags & PF_X) && k < start_code)
 			start_code = k;
 		if (start_data < k)
 			start_data = k;
