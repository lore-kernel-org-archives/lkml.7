Return-Path: <SRS0=E/6H=U3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 65F1DC4321A
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Jun 2019 02:47:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 33708208CB
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Jun 2019 02:47:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gCjdgOOB"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727158AbfF1Crn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Jun 2019 22:47:43 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:43365 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726857AbfF1Crm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Jun 2019 22:47:42 -0400
Received: by mail-pg1-f196.google.com with SMTP id f25so1890075pgv.10
        for <linux-kernel@vger.kernel.org>; Thu, 27 Jun 2019 19:47:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=e0i3Rlp+FEbUJhkhWAZBPL2tU941VCIWNuEjNlTE+Qg=;
        b=gCjdgOOBpTvhJUHulQ9Wu8i/A+YsYsUq5BjUvz9WlOao8jX8QDKoHCEnlWGsldi7Nl
         mNudiXz3WUZ803+YmW2EgYWHL6MiSGcx0atP2uzxiCDYECT6p8eKu1o4vuac+8z9nVp3
         4GrLF3sAAR/5yvAlMs82jTxBi2zMgAseXfVrA96E57nAJprPWkvUnbqfErhpAyH9AG6b
         t3Hm2UvgowsMbsBeBrb07/aEY6k/bfkruH7l6htHfy22JcKgmjdE5AMBgdSS40g+Lp5M
         zL0H2z0q8RQCEFLMvfzaipH9OzmBwJPqosqZ9PnR1Arh2FgNh8uQZsgsup4CqsX7AOtu
         Beng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=e0i3Rlp+FEbUJhkhWAZBPL2tU941VCIWNuEjNlTE+Qg=;
        b=LdX3tKU9kD3F26sxzq3sz0VblFD4LTRE55mYAAGEyDLoYSilu0ISUXk5uanWivwzPK
         v7R3bZf0uqhQ0LG7GaXYKl1/Rh4NTVspNaRZWjvfgVcWKwC32MCnOPe7Zxk+PVdp4WHP
         KBIU0TubVCaAxFa02mfL7mvrrxErbS18H4RIxjWF9tYzT14kKEGSjEznmr3wjnpU6H1j
         ZdChp4tr2vmJ8Prk2jVdZDNPG4F06J0XCKIcEDKwyWoB8niyKvpW4MSRlHmbTHPKfPNm
         cQa9V+B4FQ1TmSN/cpFjQYG4N/mmFx+OFI1BWPewOCcvCGUXuUwJrbcBXI3j3+BPcCNB
         gT/A==
X-Gm-Message-State: APjAAAXVCtRCuupdB2CcSY4dmelUgR/Kck/9mEn6wddrGHWOK+Ei5fMi
        2+C8TYbteU8J3CTgt8mVUZ8=
X-Google-Smtp-Source: APXvYqzbPyWwYsHhNeg3FlZ1r9AxTg2ADMfw3rml0sxo0zpoP7ldk/yfSBD8FZkApai8FatRbxT6zQ==
X-Received: by 2002:a17:90a:1aa4:: with SMTP id p33mr10252076pjp.27.1561690062014;
        Thu, 27 Jun 2019 19:47:42 -0700 (PDT)
Received: from hfq-skylake.ipads-lab.se.sjtu.edu.cn ([202.120.40.82])
        by smtp.googlemail.com with ESMTPSA id u65sm10888346pjb.1.2019.06.27.19.47.39
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 27 Jun 2019 19:47:41 -0700 (PDT)
From:   Fuqian Huang <huangfq.daxian@gmail.com>
Cc:     Fuqian Huang <huangfq.daxian@gmail.com>,
        Alasdair Kergon <agk@redhat.com>,
        Mike Snitzer <snitzer@redhat.com>, dm-devel@redhat.com,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 10/27] md: use kzalloc instead of kmalloc and memset
Date:   Fri, 28 Jun 2019 10:47:34 +0800
Message-Id: <20190628024734.15315-1-huangfq.daxian@gmail.com>
X-Mailer: git-send-email 2.11.0
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Replace kmalloc followed by a memset with kzalloc

Signed-off-by: Fuqian Huang <huangfq.daxian@gmail.com>
---
 drivers/md/dm-integrity.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/md/dm-integrity.c b/drivers/md/dm-integrity.c
index 44e76cda087a..f5db89b28757 100644
--- a/drivers/md/dm-integrity.c
+++ b/drivers/md/dm-integrity.c
@@ -3358,7 +3358,7 @@ static int create_journal(struct dm_integrity_c *ic, char **error)
 				goto bad;
 			}
 
-			crypt_iv = kmalloc(ivsize, GFP_KERNEL);
+			crypt_iv = kzalloc(ivsize, GFP_KERNEL);
 			if (!crypt_iv) {
 				*error = "Could not allocate iv";
 				r = -ENOMEM;
@@ -3387,7 +3387,6 @@ static int create_journal(struct dm_integrity_c *ic, char **error)
 				sg_set_buf(&sg[i], va, PAGE_SIZE);
 			}
 			sg_set_buf(&sg[i], &ic->commit_ids, sizeof ic->commit_ids);
-			memset(crypt_iv, 0x00, ivsize);
 
 			skcipher_request_set_crypt(req, sg, sg,
 						   PAGE_SIZE * ic->journal_pages + sizeof ic->commit_ids, crypt_iv);
-- 
2.11.0

