Return-Path: <SRS0=5O2B=VH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AA46AC73C7C
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Jul 2019 10:26:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7AFFA20665
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Jul 2019 10:26:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="uuNcOFBP"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727331AbfGJK0n (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 10 Jul 2019 06:26:43 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:46766 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726097AbfGJK0n (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Jul 2019 06:26:43 -0400
Received: by mail-pg1-f196.google.com with SMTP id i8so1020772pgm.13
        for <linux-kernel@vger.kernel.org>; Wed, 10 Jul 2019 03:26:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=85BGws/O2/x8Hh97uEaqbM8uDSOfynBf5b84MXFpylY=;
        b=uuNcOFBPSBE6CLV/X72nYWisfAXdtWj0WQ7usY4zK84QoNKtM0+XsWbFtr1qCxbLVu
         9x40rd6bAIY+pZeQU9XUsy4V/9iXFk62WFUE6p0dEKZeMDoH3uowZHMSqQpT/G1QwWjm
         HgfUe+MgvOuzCCDqPCIumx1NuzTTO9Jb+SZ11j4AsEK49TvvQjvXLBxyMtueqPC3neI/
         0o0wUC4sRffpTJylLjKG+g1WTkP0oGwIlq89lZasHKf2K4f5cDRwRKXJdDy8wqhP+AHb
         /6j6ziNaBy/87k7GFp/TotPUTNhV8sSD7x9drY+8CnT2CK8EbRW0nhHQb4JKQswIZWfo
         UbcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=85BGws/O2/x8Hh97uEaqbM8uDSOfynBf5b84MXFpylY=;
        b=WPPPRly6PArecPXjK4f/EWAagszAdnY6MfVtGM4jsqRqjV+wqajSNVzN/xw8wH9NoO
         AEoa7BMxSXtkp29b9yvEHLQPdzK0TBVfpEbsv1a9JIEmlTHL/uQPXP7MZLwxNcZQIlb0
         hhdVFlcRf0J5YjpoUremx9AL6hCr2TjtgW3Mst/YteLsLFm2BUFNWgSFiRtv55CI+/n1
         jkRBXy5ve0EJdKJgxja74hn+oHITncyERGPVBxNeyrXw5Rq04szZn6YzUg6eDK1XNhwb
         NVM8r/N9BB5rNypHqJf0jOAwNpdtz48XAhuPQvMiACaRe1su5GQAeKHSnaMY60r3Pplm
         lL0g==
X-Gm-Message-State: APjAAAUQf7AA7vaspeclV9X6ccF/6MRb7tlHrtnzJ3IAwpga5juSCg+X
        /+4HFDMlyeash3HhWaJwtmk=
X-Google-Smtp-Source: APXvYqyFtEN7ijsGT5VEadU8zygjMAvqFqbCiuu/hEw9S4jnvRnpL5hm84ehC5SIENU1gu4GFvccIg==
X-Received: by 2002:a17:90a:9a95:: with SMTP id e21mr5971516pjp.98.1562754403043;
        Wed, 10 Jul 2019 03:26:43 -0700 (PDT)
Received: from localhost.localdomain ([103.7.29.7])
        by smtp.gmail.com with ESMTPSA id g6sm1601983pgh.64.2019.07.10.03.26.39
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 10 Jul 2019 03:26:42 -0700 (PDT)
From:   bsauce <bsauce00@gmail.com>
To:     alexander.h.duyck@intel.com
Cc:     vbabka@suse.cz, mgorman@suse.de, l.stach@pengutronix.de,
        vdavydov.dev@gmail.com, akpm@linux-foundation.org, alex@ghiti.fr,
        adobriyan@gmail.com, mike.kravetz@oracle.com, rientjes@google.com,
        rppt@linux.vnet.ibm.com, mhocko@suse.com, ksspiers@google.com,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        bsauce <bsauce00@gmail.com>
Subject: [PATCH] fs/seq_file.c: Fix a UAF vulnerability in seq_release()
Date:   Wed, 10 Jul 2019 18:26:29 +0800
Message-Id: <1562754389-29217-1-git-send-email-bsauce00@gmail.com>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In seq_release(), 'm->buf' points to a chunk. It is freed but not cleared to null right away. It can be reused by seq_read() or srm_env_proc_write().
For example, /arch/alpha/kernel/srm_env.c provide several interfaces to userspace, like 'single_release', 'seq_read' and 'srm_env_proc_write'.
Thus in userspace, one can exploit this UAF vulnerability to escape privilege.
Even if 'm->buf' is cleared by kmem_cache_free(), one can still create several threads to exploit this vulnerability.
And 'm->buf' should be cleared right after being freed.

Signed-off-by: bsauce <bsauce00@gmail.com>
---
 fs/seq_file.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/fs/seq_file.c b/fs/seq_file.c
index abe27ec..de5e266 100644
--- a/fs/seq_file.c
+++ b/fs/seq_file.c
@@ -358,6 +358,7 @@ int seq_release(struct inode *inode, struct file *file)
 {
 	struct seq_file *m = file->private_data;
 	kvfree(m->buf);
+	m->buf = NULL;
 	kmem_cache_free(seq_file_cache, m);
 	return 0;
 }
-- 
2.7.4

