Return-Path: <SRS0=2uMJ=VL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DBD49C73C66
	for <linux-kernel@archiver.kernel.org>; Sun, 14 Jul 2019 15:06:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A8CFC20820
	for <linux-kernel@archiver.kernel.org>; Sun, 14 Jul 2019 15:06:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jTWAvb0f"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728521AbfGNPF7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 14 Jul 2019 11:05:59 -0400
Received: from mail-qt1-f194.google.com ([209.85.160.194]:36795 "EHLO
        mail-qt1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728146AbfGNPF7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 14 Jul 2019 11:05:59 -0400
Received: by mail-qt1-f194.google.com with SMTP id z4so13164743qtc.3
        for <linux-kernel@vger.kernel.org>; Sun, 14 Jul 2019 08:05:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=GY7ijCnNWcBvJMmPhDv2XxWebBv+To4DFqmhVG/7aUM=;
        b=jTWAvb0fl37zIZkVPv1RAR37KIV/mp/d6+o0pxsEi87doRmhLwRcCsDVYBrxcHIpGo
         fNg19AmqP4Qr53oDVXkbQw5aTUfzm+2y+YGfGD2WIAIsOuex6Kxa7aGAkCLqP2wv/d1i
         DcYGC9dhxirto1kBpmhE2jbBfYqayG5RgdhhITSXv1EsIJ2gLy+3PDHvvxVpUWCchFp0
         Wwq2KuAdlc175fk+9yhVfnTtxiR6g1AwFbqr5gIIgFHLYmTr0i4Gg438f5wuTSCej7s+
         cj6gTyotLJ6kuwqdZgT0fZtH4aGAfUt59OFTirl/UMZzMBD3XZI12c38esrAdKdbiwL4
         do3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=GY7ijCnNWcBvJMmPhDv2XxWebBv+To4DFqmhVG/7aUM=;
        b=uHzrDnMPfR+Zsi1VCXjIPyWfrDWkVW2gXyc1mGPJ/pD1Si1ouB6UIxEt2QEXXAwdAa
         sXJ3C4JdqtzeGbuq/6+6ntnJLDynbv19/oHlivdqNz2TxGc6WwXENWewNQY2UL5QLwWt
         gaRmPGN+dl26FtX8BLO20Cq98VM93fAhpBFaJl+JMowsA8fWKk5YwHLp20KZiT7DTGay
         hWu5SzBOcWnd6HIoYs9Su7uCm9nmTSQ4zo8BOl1LypHM4e+bvhi9LroTlAV5J20QEuUU
         K5kfZTHjRZ26jKyyzG0jWgJ7GIkErVULni/cM2lgdw5iaNmZMregmiLyaIn7bSOjjEy8
         eeuQ==
X-Gm-Message-State: APjAAAV6Vqm39pAlTGojvpSLLnSCApDPK5Rru8r0XnzomTywitHyLeDI
        PS4QMNF02c0wy/ATwe+QBA==
X-Google-Smtp-Source: APXvYqysavumyVN2h4oAbEKhfcef9Kl5JjN5h4k30a9tgMEjAuaX67r3+aXdh2jYd7NuYskVJagNGA==
X-Received: by 2002:a05:6214:185:: with SMTP id q5mr14837425qvr.213.1563116758160;
        Sun, 14 Jul 2019 08:05:58 -0700 (PDT)
Received: from localhost.localdomain (modemcable148.230-83-70.mc.videotron.ca. [70.83.230.148])
        by smtp.googlemail.com with ESMTPSA id o18sm8973139qtb.53.2019.07.14.08.05.56
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Sun, 14 Jul 2019 08:05:57 -0700 (PDT)
From:   Keyur Patel <iamkeyur96@gmail.com>
Cc:     markus.elfring@web.de, Keyur Patel <iamkeyur96@gmail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Christian Gromm <christian.gromm@microchip.com>,
        Suresh Udipi <sudipi@jp.adit-jv.com>,
        Colin Ian King <colin.king@canonical.com>,
        devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org
Subject: [PATCH v4] staging: most: remove redundant print statement when
 kfifo_alloc fails
Date:   Sun, 14 Jul 2019 11:05:43 -0400
Message-Id: <20190714150546.31836-1-iamkeyur96@gmail.com>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20190711175055.25157-1-iamkeyur96@gmail.com>
References: <20190711175055.25157-1-iamkeyur96@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This print statement is redundant as kfifo_alloc just calls kmalloc_array=0D
without the __GFP_NOWARN flag, already does a dump_stack().=0D
=0D
Signed-off-by: Keyur Patel <iamkeyur96@gmail.com>=0D
---=0D
Changes in v3:=0D
- fix checkpatch warning=0D
=0D
 drivers/staging/most/cdev/cdev.c | 4 +---=0D
 1 file changed, 1 insertion(+), 3 deletions(-)=0D
=0D
diff --git a/drivers/staging/most/cdev/cdev.c b/drivers/staging/most/cdev/c=
dev.c=0D
index d0cc0b746107..724d098aeef0 100644=0D
--- a/drivers/staging/most/cdev/cdev.c=0D
+++ b/drivers/staging/most/cdev/cdev.c=0D
@@ -463,10 +463,8 @@ static int comp_probe(struct most_interface *iface, in=
t channel_id,=0D
 	spin_lock_init(&c->unlink);=0D
 	INIT_KFIFO(c->fifo);=0D
 	retval =3D kfifo_alloc(&c->fifo, cfg->num_buffers, GFP_KERNEL);=0D
-	if (retval) {=0D
-		pr_info("failed to alloc channel kfifo");=0D
+	if (retval)=0D
 		goto err_del_cdev_and_free_channel;=0D
-	}=0D
 	init_waitqueue_head(&c->wq);=0D
 	mutex_init(&c->io_mutex);=0D
 	spin_lock_irqsave(&ch_list_lock, cl_flags);=0D
-- =0D
2.22.0=0D
=0D
