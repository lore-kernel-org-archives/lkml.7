Return-Path: <SRS0=GgR0=RR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1F1A5C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Mar 2019 20:42:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D751020854
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Mar 2019 20:42:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="i6am6VUD"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727824AbfCNUmO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Mar 2019 16:42:14 -0400
Received: from mail-wr1-f52.google.com ([209.85.221.52]:45290 "EHLO
        mail-wr1-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726890AbfCNUmO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Mar 2019 16:42:14 -0400
Received: by mail-wr1-f52.google.com with SMTP id h99so7299622wrh.12
        for <linux-kernel@vger.kernel.org>; Thu, 14 Mar 2019 13:42:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=QnkdKQwRviIshHDWLn9wvvEmyvkc5bmh4dD4qHp2Tyk=;
        b=i6am6VUD8QZRq8wIVX3bFlui2xPRJZ1/nisrGgWwzc5Kksmxla6qZPz+hl9E+i/+n8
         97I1Lyd8Am86t0vhyNixjqu8fFbE67WcTuBUCIPBK7butnvrRWaWhgTNkbz73uYwcbg4
         /bodL8CkeAc1uPG7oDBaMVdTChchAFdT6XbtZ0mTFqMWiTsVLvIaUopXcmnmNaWw+s9v
         laDyc5hmNWxDIzrNibdDWAVV4NTp80Zl52v528eysDOxlZAEWyX44M3Cq6GwRt6/b1dK
         9SZhZWjDq77vEdZ1cjvVK428+XfW/U69hHwW4dILGMEXAj9qFRorHufuVXAZLOipn+83
         c17A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=QnkdKQwRviIshHDWLn9wvvEmyvkc5bmh4dD4qHp2Tyk=;
        b=ptIQQJIRSI42vTIGHoy+OeKlEpDiyZ9VA0f2IyM0Ju1nqjV/YoBP3m5ehMaUvt4AZZ
         66YsGGTAFhZ9VwIkhoBjgHEibgcU/9kBpRzkf21tktBJGeTmT2tfeJp9wgqRDZIhoDUs
         SDWq8Tjbt8nag5fBjLEO2UuwsXKT2PDabqlu+i/IuSDsNsJPB05/FiasGuRrBzRm/tuS
         C8OaU5Pe2iEzLnlmKswtsAVjCvV+f0uKqindi/ibFmNQCnblvDWkSbx38x2jxb6WN6wU
         jPZZ+GCe0IqdGtNBg+BGjpNlRCdCfq1pJLGTWTmIyLoj1LokmtTtIxFdno15vB9dOqnW
         lDZw==
X-Gm-Message-State: APjAAAVWtsvQIM2PKBeijs2+2kiTDJzrPG3UVXBq4BZlm7rO412IHEI9
        ZDj5zfZyVMS1S9+iVRg8obQYmqI=
X-Google-Smtp-Source: APXvYqzJ9hgykj60sfMAn9lxj06vISTSEU0uR7AjD+C+L8QPTjnpdO/wjWMe5sRVvTMdSGuSMRrZZQ==
X-Received: by 2002:a5d:558c:: with SMTP id i12mr32324041wrv.19.1552596132169;
        Thu, 14 Mar 2019 13:42:12 -0700 (PDT)
Received: from avx2 ([46.53.246.8])
        by smtp.gmail.com with ESMTPSA id h17sm16087259wrq.93.2019.03.14.13.42.10
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 14 Mar 2019 13:42:11 -0700 (PDT)
Date:   Thu, 14 Mar 2019 23:42:08 +0300
From:   Alexey Dobriyan <adobriyan@gmail.com>
To:     akpm@linux-foundation.org
Cc:     linux-kernel@vger.kernel.org, penguin-kernel@I-love.SAKURA.ne.jp
Subject: [PATCH 1/2] elf: simpler check for -EEXIST
Message-ID: <20190314204208.GA18143@avx2>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

	PTR_ERR((void *)map_addr) == -EEXIST

is a very complicated way of doing the obvious.

Signed-off-by: Alexey Dobriyan <adobriyan@gmail.com>
---

 fs/binfmt_elf.c |    3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

--- a/fs/binfmt_elf.c
+++ b/fs/binfmt_elf.c
@@ -375,8 +375,7 @@ static unsigned long elf_map(struct file *filep, unsigned long addr,
 	} else
 		map_addr = vm_mmap(filep, addr, size, prot, type, off);
 
-	if ((type & MAP_FIXED_NOREPLACE) &&
-	    PTR_ERR((void *)map_addr) == -EEXIST)
+	if ((type & MAP_FIXED_NOREPLACE) && map_addr == -EEXIST)
 		pr_info("%d (%s): Uhuuh, elf segment at %px requested but the memory is mapped already\n",
 			task_pid_nr(current), current->comm, (void *)addr);
 
