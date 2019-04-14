Return-Path: <SRS0=avfD=SQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	UNWANTED_LANGUAGE_BODY,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 29FD4C10F13
	for <linux-kernel@archiver.kernel.org>; Sun, 14 Apr 2019 12:30:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DBCD520896
	for <linux-kernel@archiver.kernel.org>; Sun, 14 Apr 2019 12:30:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Zyp3ZeQq"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726331AbfDNMaP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 14 Apr 2019 08:30:15 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:52137 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725805AbfDNMaO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 14 Apr 2019 08:30:14 -0400
Received: by mail-wm1-f65.google.com with SMTP id 4so16963514wmf.1
        for <linux-kernel@vger.kernel.org>; Sun, 14 Apr 2019 05:30:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=v/fviXkECq93LzD+u+QOiPbnLq3tfI0w/xkYwKPxDQ4=;
        b=Zyp3ZeQqnSulPfjra96Jn11tcGG0jBwzRJKNEQVQ3UQCvolcvs6I3Z1FJ5oGgsHhGU
         ZVy5MuVjdULlZqUM1PKlxK65w+O8MdANQTxzbx6C+uKy/m+90q1GKSAGSE3XYpne1lmx
         872tHBpqaG4072G56cKLH98lPscPYHze6qbO5THaeVgal7Mxz7SJNkM+ZQbBmtZFfdhp
         fyDB/wnxDJGtjBI8g1IdfqtoN8Blocc84MUSwo8RMTTaN5gmNqPceyh0O4vBw8VE74ZM
         f9b3P1Q1K+olkhA2Vu1/BF+q3pyTM74xvjm+kxGic0nGwPWETP77Q4ssXyTOH+t3QbQ7
         NyYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=v/fviXkECq93LzD+u+QOiPbnLq3tfI0w/xkYwKPxDQ4=;
        b=eV1jWfgkaMZ/6Cwl2G5sC4WQ75A7tJe28vBrOIxOIhWR5OlE0KXK0ibuzI3NCQ8k+0
         j3IqI3oWfKwNCUCp0DjaFmRxJn6yZfddVu0+nqZKTVHs+h533TPtnmd9ljxbplnBDwRw
         BmVOc4KTpTGal8tJnCr4U2Gr8XzHWeRZxk6LmaTzyuuPKU5a4Pw8fxfrdESD/pSsoqK4
         3/pzi0oGllIn2J+eVDyGZMa3LgPGCm0TsdqG4uRqSLIZs3ksTxjW1QM+Nok2lZhMBrX9
         /xpVO1voUvOXaUW08bjLRxrbNv7r08wIwzyHVwz8QPrMyLnK6qHkpH0LWg12ortjrh4I
         HoZg==
X-Gm-Message-State: APjAAAVpgwh9wAgPNYGxszsW0SSqrNTKAzcITe627/T6Qv4nAsKAPIXz
        8ksZ+vtxRN7hjN9m6NHarGmbpCo=
X-Google-Smtp-Source: APXvYqwuoigJSBTRqoCxTlSwGA9fd561REryIz+hvgTi7r87QX05yosB7RX4PGWw3+0DVtcUfywc3Q==
X-Received: by 2002:a1c:495:: with SMTP id 143mr17117603wme.78.1555245012941;
        Sun, 14 Apr 2019 05:30:12 -0700 (PDT)
Received: from avx2 ([46.53.240.140])
        by smtp.gmail.com with ESMTPSA id x84sm21074140wmg.13.2019.04.14.05.30.11
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 14 Apr 2019 05:30:11 -0700 (PDT)
Date:   Sun, 14 Apr 2019 15:30:09 +0300
From:   Alexey Dobriyan <adobriyan@gmail.com>
To:     akpm@linux-foundation.org
Cc:     linux-kernel@vger.kernel.org
Subject: [PATCH] proc: fixup proc-pid-vm test
Message-ID: <20190414123009.GA12971@avx2>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Silly sizeof(pointer) vs sizeof(uint8_t[]) bug.

Fixes: e483b0208784 ("proc: test /proc/*/maps, smaps, smaps_rollup, statm")
Signed-off-by: Alexey Dobriyan <adobriyan@gmail.com>
---

 tools/testing/selftests/proc/proc-pid-vm.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

--- a/tools/testing/selftests/proc/proc-pid-vm.c
+++ b/tools/testing/selftests/proc/proc-pid-vm.c
@@ -187,8 +187,8 @@ static int make_exe(const uint8_t *payload, size_t len)
 	ph.p_offset = 0;
 	ph.p_vaddr = VADDR;
 	ph.p_paddr = 0;
-	ph.p_filesz = sizeof(struct elf64_hdr) + sizeof(struct elf64_phdr) + sizeof(payload);
-	ph.p_memsz = sizeof(struct elf64_hdr) + sizeof(struct elf64_phdr) + sizeof(payload);
+	ph.p_filesz = sizeof(struct elf64_hdr) + sizeof(struct elf64_phdr) + len;
+	ph.p_memsz = sizeof(struct elf64_hdr) + sizeof(struct elf64_phdr) + len;
 	ph.p_align = 4096;
 
 	fd = openat(AT_FDCWD, "/tmp", O_WRONLY|O_EXCL|O_TMPFILE, 0700);
