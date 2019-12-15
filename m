Return-Path: <SRS0=qvRn=2F=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 20D33C43603
	for <linux-kernel@archiver.kernel.org>; Sun, 15 Dec 2019 12:44:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D2142206D8
	for <linux-kernel@archiver.kernel.org>; Sun, 15 Dec 2019 12:44:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Wz4/M2YJ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726192AbfLOMoB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 15 Dec 2019 07:44:01 -0500
Received: from mail-wr1-f41.google.com ([209.85.221.41]:43024 "EHLO
        mail-wr1-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726101AbfLOMoB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 15 Dec 2019 07:44:01 -0500
Received: by mail-wr1-f41.google.com with SMTP id d16so3857127wre.10
        for <linux-kernel@vger.kernel.org>; Sun, 15 Dec 2019 04:44:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=p7hVdXnSKeOOfrLxwI2s0NxIC4n1/uQ0c98XN8Ll0EI=;
        b=Wz4/M2YJMdYRXndLhSOIVQrDcJoeYOSgPViSsEjU2IAPDpupVkO5Y9YDBJaHgwJbDR
         inwGKcmM8QK336xp48zujm5JFm+6GuyFtSGLHHztAjOLzwKPB86eJ/JK0yNHu+jHWNEF
         SrRTSP4oHUM5B0Mn0fcQfjznSG3XFtk+RRY0oF6pMXi+q9JVoEmkzi34IUyDA1HpC0yH
         SRU4EiuG6uFubWqfhJshe/EcuNXUFM2deRlF1x1lKCvxDADhuRukjhcOoAVjWBgjY5zI
         xUAbiAwZ1FQnpZlUPltt8h61BHUyFQhzcwFiGWC5AKO8OzFQfWGQLRNlSOhoyqiUp4GK
         97YA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=p7hVdXnSKeOOfrLxwI2s0NxIC4n1/uQ0c98XN8Ll0EI=;
        b=TWoHP4Y7R9Cx0bfzp+kb40PTnd8FV99U06qzxqL2uQdldx8m3Mi3ZcPnXnArzGDXnF
         PV0XMPxIE7FMMQrooW5doLz0cVgTi2ZUQhL0YlprTjS9A8onZSTHYEdR/132Cj9Ln75y
         CkVSbQFM0i70aNSImYkMvNozqrAMkDeqenWiUw3Uo/wQ9EYbZtPKC3F4SyCBHl4VObZ1
         9LrLxYSXK6xGsH/iUg50lBFEWZZtNxXsasEJ5lN7LpHcYtnwsep/jVqqYC8FQsErMVYy
         pQ/4dX1/C989P25DwOTynxvOtkH9jX8cu2EoL212+Gnts3YksW0GOmmDMqzHmxBKa5t8
         hsAQ==
X-Gm-Message-State: APjAAAXGU02LVmnItsnvtrEI7ah9NI0pM1dJc46XrHJsyC8Zt3P4x/vz
        0d+us519jc6G3DalQMU/yGpIzuE=
X-Google-Smtp-Source: APXvYqztcp1Myvf+2h10Oj/yQEfsV1y7IpCtLZie29CgZnGy8MwehtSIafKF5E0aUKWpe+hOIfj2/A==
X-Received: by 2002:a5d:530d:: with SMTP id e13mr24550642wrv.125.1576413839333;
        Sun, 15 Dec 2019 04:43:59 -0800 (PST)
Received: from avx2 ([46.53.248.136])
        by smtp.gmail.com with ESMTPSA id w13sm17693787wru.38.2019.12.15.04.43.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 15 Dec 2019 04:43:58 -0800 (PST)
Date:   Sun, 15 Dec 2019 15:43:55 +0300
From:   Alexey Dobriyan <adobriyan@gmail.com>
To:     akpm@linux-foundation.org
Cc:     linux-kernel@vger.kernel.org
Subject: [PATCH -mm 1/2] ELF: make BAD_ADDR() unlikely
Message-ID: <20191215124355.GA21124@avx2>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If some mapping goes past TASK_SIZE it will be rejected by kernel
which means no such userspace binaries exist.

Mark every such check as unlikely.

Signed-off-by: Alexey Dobriyan <adobriyan@gmail.com>
---

 fs/binfmt_elf.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/fs/binfmt_elf.c
+++ b/fs/binfmt_elf.c
@@ -97,7 +97,7 @@ static struct linux_binfmt elf_format = {
 	.min_coredump	= ELF_EXEC_PAGESIZE,
 };
 
-#define BAD_ADDR(x) ((unsigned long)(x) >= TASK_SIZE)
+#define BAD_ADDR(x) (unlikely((unsigned long)(x) >= TASK_SIZE))
 
 static int set_brk(unsigned long start, unsigned long end, int prot)
 {
