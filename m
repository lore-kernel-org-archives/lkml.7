Return-Path: <SRS0=yJb2=SB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.0 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C2B05C43381
	for <linux-kernel@archiver.kernel.org>; Sat, 30 Mar 2019 14:00:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 86B18218A3
	for <linux-kernel@archiver.kernel.org>; Sat, 30 Mar 2019 14:00:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RZvBTV6l"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730864AbfC3OAp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 30 Mar 2019 10:00:45 -0400
Received: from mail-pl1-f194.google.com ([209.85.214.194]:35637 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730813AbfC3OAo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 30 Mar 2019 10:00:44 -0400
Received: by mail-pl1-f194.google.com with SMTP id p19so2345411plo.2;
        Sat, 30 Mar 2019 07:00:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=y7FJXynrvmLzvIGrXvU6Xe2QOSdrESdZWkkL9RjV1FY=;
        b=RZvBTV6lxJqOo3NgKKWCOoPbJ/f+KkrDiFE8ERA4n5/rgAXv2R0c7BGyt+1W+O5b0e
         jULA7PV/pYqGRFa6S0DuCYwW8f3tb3I73S3EcELJgO+vDL5BzMSAAjSUtBlU3YEc7I1Q
         cCa+AXgtqLNA2SQb8nMrYT/8sRhVIDdiJWikDi/kq75RSGF/N69R2XSxBRmnGozL6HIn
         ZnPtPcoP7S0fe1wpiPfa7uok3fbZumbDJpi94dSTbvwTMj0/riBKYuFQDRmZNRTgE0qG
         MiWc5hnXIkt7VxvmhtvslrEJv3SwT8TFQpoUEqB+UzLP+z4YjBg/lkLn4BPQttukSfTi
         MZhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :mime-version:content-disposition:user-agent;
        bh=y7FJXynrvmLzvIGrXvU6Xe2QOSdrESdZWkkL9RjV1FY=;
        b=k/KG/SQI1ttC2uVhobhRETVIqrYIdbsuVd/wckC7hMkwNg+u/gYfDbuI0dB4uyQ8oW
         ODubQIKG/6iMukpfq+dt/KvE7eKw6hyBBtssV5G63S5RsXeZxi+nXoEXk8RVmzb23nWH
         h5VIjg6T4FQlnQ/yVv0ro/JIYcDojG1qDXh0+zO1NUt4ZgROQLx/hc8wgFIrkmyvl0q8
         2Q53nwUl4Q4NwMnk4KOdKHTXlxTaHfVYe1boLEF2OL01oPH/tlhMGOwx9o9s55/bQA4b
         8a9ABnFnz/UKqQyGyujZIB99t2grkLoJ8y4lFTGIJRmXqfowULEolGjY1PPHOeX0LDtK
         HIOg==
X-Gm-Message-State: APjAAAWaN4fj5NqG8BdfmOs+04lhvzbQDzMTX4HLgeebWO9SrCglE7S9
        ZXUgappMGk4SJzgn/RxI0wBKke0Au6w=
X-Google-Smtp-Source: APXvYqxQzO3z/u2sRuZmsEmgI6Vyqer+p4FuUUaBchfSGSlrr9PHEyFUhoFBSOAyu5lG/n+FuZn2rQ==
X-Received: by 2002:a17:902:362:: with SMTP id 89mr52248123pld.172.1553954444228;
        Sat, 30 Mar 2019 07:00:44 -0700 (PDT)
Received: from vostro (173-228-88-115.dsl.dynamic.fusionbroadband.com. [173.228.88.115])
        by smtp.gmail.com with ESMTPSA id t129sm6888524pfb.127.2019.03.30.07.00.42
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 30 Mar 2019 07:00:43 -0700 (PDT)
Date:   Sat, 30 Mar 2019 07:00:32 -0700
From:   Nikitas Angelinas <nikitas.angelinas@gmail.com>
To:     Alexander Viro <viro@zeniv.linux.org.uk>,
        Alexey Dobriyan <adobriyan@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        syzbot+0d1fcd7268b21baced4a@syzkaller.appspotmail.com
Cc:     nikitas.angelinas@gmail.com
Subject: [PATCH] fs/binfmt_elf.c: fix GPF when dereferencing invalid
 interpreter
Message-ID: <20190330140032.GA1527@vostro>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.7.0 (2016-08-17)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Syzkaller found an issue where an invalid interpreter pointer is
dereferenced in load_elf_binary()->allow_write_access(). Fix this by
jumping to a different label in the cleanup path.

This patch applies against the latest linux-next tree. I have not tested
that the patch addresses the issue, but it should, imho.

Signed-off-by: Nikitas Angelinas <nikitas.angelinas@gmail.com>
Reported-by: syzbot+0d1fcd7268b21baced4a@syzkaller.appspotmail.com
Fixes: 44e63c4a0263 ("fs/binfmt_elf.c: free PT_INTERP filename ASAP")
---
 fs/binfmt_elf.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/binfmt_elf.c b/fs/binfmt_elf.c
index 51bc894..09e76b2 100644
--- a/fs/binfmt_elf.c
+++ b/fs/binfmt_elf.c
@@ -777,7 +777,7 @@ static int load_elf_binary(struct linux_binprm *bprm)
 			kfree(elf_interpreter);
 			retval = PTR_ERR(interpreter);
 			if (IS_ERR(interpreter))
-				goto out_free_dentry;
+				goto out_free_ph;
 
 			/*
 			 * If the binary is not readable then enforce
-- 
2.10.0

