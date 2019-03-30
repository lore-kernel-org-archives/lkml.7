Return-Path: <SRS0=yJb2=SB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3949AC43381
	for <linux-kernel@archiver.kernel.org>; Sat, 30 Mar 2019 11:20:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F04D0218AE
	for <linux-kernel@archiver.kernel.org>; Sat, 30 Mar 2019 11:20:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AB1nFHIk"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730496AbfC3LT1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 30 Mar 2019 07:19:27 -0400
Received: from mail-wm1-f43.google.com ([209.85.128.43]:50747 "EHLO
        mail-wm1-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730414AbfC3LT1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 30 Mar 2019 07:19:27 -0400
Received: by mail-wm1-f43.google.com with SMTP id z11so5155339wmi.0
        for <linux-kernel@vger.kernel.org>; Sat, 30 Mar 2019 04:19:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=hwKyM+Ym2jJTEHiqUGmr3jp5VdqbNDC6afbiZF668HQ=;
        b=AB1nFHIkK8TDP06EOV7d5SMKW2w5vu0lmbz32YO90CRs2ZDGDWfKnvfepsTywsiaO0
         IJ8xs9Obd1xxAVWInfDaVMFpepNCLRfYc5E8c/0II+QABrHeVbAUz0GNgT4PKE0oSJgh
         eV4K8ZrmPDgmuSr+xGRFk75A7sgvxboDds45W8WrwoGXidXuLigNh8qN3TyJiJXyfVXK
         kbBK0EDahA/qZqKhlaOFb6bWGvwllhwvIkUEXWEac/iwDEG+PKsQjM9gfOqBcA1ORL5c
         8ovMNoyQ4HSvf+c+vHWw8zT2+fuQjAoNnU9ccgWidSw/hof1Kl6wMhV4AYkpTWLEuetr
         4GGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=hwKyM+Ym2jJTEHiqUGmr3jp5VdqbNDC6afbiZF668HQ=;
        b=CwxyXJJXspSWe8NDpRXMQ+WZJWbrkOjW/jTUIi5GbXDNtm1Y7m4JYgeV+IG5EavQc2
         kas9csBegiKz1ZesxRN3xkt574wpHzqIfiZ+WiTSaaxwF18IxiCPVSipdTyJvyO4Wl0/
         eg+W7whne1sFruA52JancqdIMJ3tMjvJeF4oKFB9nL85fgqytbVJgzQcv63eBVlyvdEy
         PV51laYQ0RZ7HX0cu2xL3R6NQcby+0X9Ix0tuOlE8SHdFdkC3FB6R7fzk1qs+gs1oyA1
         PdYa9CGdTr96q0wi+7BKySJgoa/z2p8dKFYdlZ1a/e5YqZgD1wG5BOjN5qDnzAFCLsMr
         7hHw==
X-Gm-Message-State: APjAAAW8AZmJPjzN4HzUpADG0vxa2s8RXN7yDPNXQv7NIJqR4TxQpQOo
        T/eP5PLarTWYnOurQPnnLofnAOw=
X-Google-Smtp-Source: APXvYqz2RF4DWy1FMY1BCCnIc0DzFp6mE3Fm/iigyZSozdOGQddZ7uqrdWndp3/dbkOx0i4yt+WSlQ==
X-Received: by 2002:a1c:c018:: with SMTP id q24mr6370975wmf.148.1553944765657;
        Sat, 30 Mar 2019 04:19:25 -0700 (PDT)
Received: from avx2 ([46.53.240.116])
        by smtp.gmail.com with ESMTPSA id z18sm7489879wrr.90.2019.03.30.04.19.24
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 30 Mar 2019 04:19:24 -0700 (PDT)
Date:   Sat, 30 Mar 2019 14:19:22 +0300
From:   Alexey Dobriyan <adobriyan@gmail.com>
To:     akpm@linux-foundation.org
Cc:     linux-kernel@vger.kernel.org
Subject: [PATCH -mm] elf: fixup error path in PT_INTERP case
Message-ID: <20190330111922.GA15258@avx2>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix broken error path if PT_INTERP filename can't be opened for execution.

Reported-by: syzbot+0d1fcd7268b21baced4a@syzkaller.appspotmail.com
Signed-off-by: Alexey Dobriyan <adobriyan@gmail.com>
---

	fold into elf-free-pt_interp-filename-asap.patch

 fs/binfmt_elf.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

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
