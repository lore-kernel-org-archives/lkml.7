Return-Path: <SRS0=wETr=XU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 00151C432C2
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Sep 2019 15:27:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C7F50205F4
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Sep 2019 15:27:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FGVJ2tpP"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2439062AbfIYP1y (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 25 Sep 2019 11:27:54 -0400
Received: from mail-io1-f65.google.com ([209.85.166.65]:46755 "EHLO
        mail-io1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727561AbfIYP1x (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Sep 2019 11:27:53 -0400
Received: by mail-io1-f65.google.com with SMTP id c6so14843315ioo.13
        for <linux-kernel@vger.kernel.org>; Wed, 25 Sep 2019 08:27:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=2+zHjBJOK/Ikhp7L/0qx76YfF7Qn9O6VldPJapiJGlI=;
        b=FGVJ2tpPz/6hyiob5/CLxDUtNIS1KBhHsg6QTIgJ9RdZMdsF7QtzqIj2dUsEmzw8Xp
         IXB1WrZXpLkCp6jffgW+LDiOymFzysyoTGw2XuDsibzHOCWeFS4yPhcwqhWMqH6eHuEB
         p799Kbz/UvkUS8MMgYgd3ac6+cXMSSWCmnhpCgFTS8aoH7YihDLoxFc8ZlLz9ISByN68
         pT+m6U7GChTAranD/5OAOhmtM8Ycq5wfQT5Kf7MZ0tyKugnkC/VmZD4YNvMfDs8bxrnX
         TOjcLrG2OgNQpS83nZgTI6xG+PmdBe8KJhupOKlV4Ko83qLnEOiCvJRE72+y/x/73hAi
         BP5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=2+zHjBJOK/Ikhp7L/0qx76YfF7Qn9O6VldPJapiJGlI=;
        b=NJNS86fNscGZmht92p1SUGO8IE4G8kPyTjGE9V3dzwIbavtSKUL32A6AN3meYtfaeL
         6dxHGTzG+lnpu5YkpTszIEcDi/4bvAMwCHA7zKj9D7TwoJHk1lyeEwFu55vkBCtUKutj
         qIRLhjWJ4VjM7Zy6EjnK1gBHtPKTS9btdM6jDTxsFOEsHlchLQBuSoFzDkPF4kKOXch8
         7ISQDWRAi5VZTEqjii5lbhyC/9wXD2tBQ1tbmudbvdJY+LnbhJS1zE3RGgwd0QydeLJq
         gOKdxq1rRD4r8yFePOtMgp+mqd/79rsPrhN9tz96sNmlwfcFjJHfu1IFonIVle7k8lH8
         tHrw==
X-Gm-Message-State: APjAAAXNNNNgx0zKvqf45PsGjLjNCxlNLggmWExmu6NpWEHicDa+ePMq
        xWIfsiAF4UyyUBez+OKIFeM=
X-Google-Smtp-Source: APXvYqzp3ccougPfL2l0BTcmUQrF3WVO+YxQ1XS6EjNndJp1/fLSWNtvaA9dSrXYvvcWcOYQShRiRQ==
X-Received: by 2002:a92:3dd0:: with SMTP id k77mr897317ilf.154.1569425271293;
        Wed, 25 Sep 2019 08:27:51 -0700 (PDT)
Received: from cs-dulles.cs.umn.edu (cs-dulles.cs.umn.edu. [128.101.35.54])
        by smtp.googlemail.com with ESMTPSA id f5sm4881239ioh.87.2019.09.25.08.27.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Sep 2019 08:27:50 -0700 (PDT)
From:   Navid Emamdoost <navid.emamdoost@gmail.com>
Cc:     emamd001@umn.edu, kjlu@umn.edu, smccaman@umn.edu,
        Navid Emamdoost <navid.emamdoost@gmail.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org
Subject: [PATCH] misc: fastrpc: prevent memory leak in fastrpc_dma_buf_attach
Date:   Wed, 25 Sep 2019 10:27:41 -0500
Message-Id: <20190925152742.16258-1-navid.emamdoost@gmail.com>
X-Mailer: git-send-email 2.17.1
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In fastrpc_dma_buf_attach if dma_get_sgtable fails the allocated memory
for a should be released.

Signed-off-by: Navid Emamdoost <navid.emamdoost@gmail.com>
---
 drivers/misc/fastrpc.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/misc/fastrpc.c b/drivers/misc/fastrpc.c
index 47ae84afac2e..1b1a794d639d 100644
--- a/drivers/misc/fastrpc.c
+++ b/drivers/misc/fastrpc.c
@@ -527,6 +527,7 @@ static int fastrpc_dma_buf_attach(struct dma_buf *dmabuf,
 			      FASTRPC_PHYS(buffer->phys), buffer->size);
 	if (ret < 0) {
 		dev_err(buffer->dev, "failed to get scatterlist from DMA API\n");
+		kfree(a);
 		return -EINVAL;
 	}
 
-- 
2.17.1

