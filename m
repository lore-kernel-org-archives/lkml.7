Return-Path: <SRS0=GgR0=RR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D66D3C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Mar 2019 20:45:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A3BA521872
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Mar 2019 20:45:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kMuPuzbG"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727959AbfCNUpx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Mar 2019 16:45:53 -0400
Received: from mail-wm1-f52.google.com ([209.85.128.52]:53854 "EHLO
        mail-wm1-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727494AbfCNUpw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Mar 2019 16:45:52 -0400
Received: by mail-wm1-f52.google.com with SMTP id e74so4437015wmg.3
        for <linux-kernel@vger.kernel.org>; Thu, 14 Mar 2019 13:45:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=18Zn7FATzzrN0f70nlwzd80DQ59DCYV5RfN6/I7SSGA=;
        b=kMuPuzbG/jYoCYd7ik1c3VKwHM0zzUAk5RAoht28Pr8xwquXVyMSS2KCNMf3cnNJ76
         vZ2+4RPHfOhV9PHgbYg14Te7NhZ42r51cNNwXhuW0pXHNnO393p//3yCEuvo+gEmnPG/
         R7jK2ylg6HO4CriXPTHZ2B0ndfjsEeN/APuX4r7Q4qC99IJtQYW3bmunIPDr1NfhiNQM
         riQ9mA7pMAAYByQYDD66KCveyxuQb6bgtQ7U/mbeAkBba6Db/4Z6jOwpD3mEAQFuR/Bp
         mZ2D6+9Pj9x6Cx7fXR+/jis2LMNY6gebCnGb2Hf31eaVeX9YtBVca4EXLcYPn47VfQpC
         Q5ZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=18Zn7FATzzrN0f70nlwzd80DQ59DCYV5RfN6/I7SSGA=;
        b=LZ9niRu8QXqwu4azfbCzE5WLe602pkNFR3VMsiSdNMd5wSA21mLY2RK1P8eKLG1n7u
         RHb/nVCFgte+6QgBDG2YC3gVI4odkUpw9n/DopnglkWHEhv8JuOb/Ak0ctSRTLguF6Dc
         3vpO0s2y0Zm2TvClCQUfqQFRDG9+m63+ov6ZHCdN47Ca71d7arslH3nkw193fjxTd52A
         dcoHhypMF6S7hZHCB5poTm0pkoDwxzIlUmMhmlhxp6EjmSfss6FxdxEbWDZCyVImwpLV
         SoU58m8rLo4bAim7FNqOBP+Jk0RbYZY7AtomTpoPh+SlkV5StgfKZBPNERq3G1U05No7
         GOVQ==
X-Gm-Message-State: APjAAAUsJkMtOHrAwe2HanIx5ke08XDiyHtl8JbPrk8U9JBI0CSO4Cn8
        A/siTc/QzCs/mlRNEh+G9CslCaU=
X-Google-Smtp-Source: APXvYqxwljF9QLADLdmGopMwC8HYofez2qPQLPj/XFP543bO3OVV6EXhKOWhBwOgRgMGt0EQWU6T2Q==
X-Received: by 2002:a1c:9d94:: with SMTP id g142mr231999wme.125.1552596351100;
        Thu, 14 Mar 2019 13:45:51 -0700 (PDT)
Received: from avx2 ([46.53.246.8])
        by smtp.gmail.com with ESMTPSA id o8sm213279wma.1.2019.03.14.13.45.50
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 14 Mar 2019 13:45:50 -0700 (PDT)
Date:   Thu, 14 Mar 2019 23:45:48 +0300
From:   Alexey Dobriyan <adobriyan@gmail.com>
To:     akpm@linux-foundation.org
Cc:     linux-kernel@vger.kernel.org, mhocko@suse.com
Subject: [PATCH 2/2] elf: print userspace address with %lx
Message-ID: <20190314204548.GB18143@avx2>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use %lx, save a cast.

"addr" is userspace address so using (and mangling) pointer was never
necessary.

Signed-off-by: Alexey Dobriyan <adobriyan@gmail.com>
---

 fs/binfmt_elf.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

--- a/fs/binfmt_elf.c
+++ b/fs/binfmt_elf.c
@@ -376,8 +376,8 @@ static unsigned long elf_map(struct file *filep, unsigned long addr,
 		map_addr = vm_mmap(filep, addr, size, prot, type, off);
 
 	if ((type & MAP_FIXED_NOREPLACE) && map_addr == -EEXIST)
-		pr_info("%d (%s): Uhuuh, elf segment at %px requested but the memory is mapped already\n",
-			task_pid_nr(current), current->comm, (void *)addr);
+		pr_info("%d (%s): Uhuuh, elf segment at %lx requested but the memory is mapped already\n",
+			task_pid_nr(current), current->comm, addr);
 
 	return(map_addr);
 }
