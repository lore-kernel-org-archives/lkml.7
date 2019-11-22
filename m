Return-Path: <SRS0=i7el=ZO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0739CC432C0
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Nov 2019 10:51:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D0B0920731
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Nov 2019 10:51:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1574419900;
	bh=M1E2zeGQOllJsdnBB7tV0tpZO9EA7JfKu/yCiqqWZV4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=ouXoI0HRDmjTx58Kz2QEE57HpSHWz89wQJzo3Clt2DjQUYeDgCzMmOUz5bN6RdMJT
	 6/5Q77Dx/2PVubqhmdOwWeDVBHZYVcZTpd6ZcyWW1GUNt0wE1DKZqha5mZat2HZrkU
	 fprVzo+14DLOVU7sk6Z3mKCI13Apjeo/uD5PXOqA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729643AbfKVKvj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Nov 2019 05:51:39 -0500
Received: from mail.kernel.org ([198.145.29.99]:34486 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730083AbfKVKvf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Nov 2019 05:51:35 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4F8BA2071F;
        Fri, 22 Nov 2019 10:51:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1574419894;
        bh=M1E2zeGQOllJsdnBB7tV0tpZO9EA7JfKu/yCiqqWZV4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=upQo39tLY9dlqJ3eyQqZUM4t7hSjqo4vREMtpsLDJmSC+peyYme8zCKsgA0rGuXoN
         7AygGMooOOWELH5CguGz0jRbuxXq7amJJsbKLjwsz4fLKxBrJCMxe1dypOtv5oHk3k
         Lfqg20Jq0R96us0jam3NRrck2k36ITUVDAarCJ74=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Gustavo Pimentel <gustavo.pimentel@synopsys.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.14 046/122] tools: PCI: Fix compilation warnings
Date:   Fri, 22 Nov 2019 11:28:19 +0100
Message-Id: <20191122100755.710725575@linuxfoundation.org>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <20191122100722.177052205@linuxfoundation.org>
References: <20191122100722.177052205@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Gustavo Pimentel <gustavo.pimentel@synopsys.com>

[ Upstream commit fef31ecaaf2c5c54db85b35e893bf8abec96b93f ]

Current compilation produces the following warnings:

tools/pci/pcitest.c: In function 'run_test':
tools/pci/pcitest.c:56:9: warning: unused variable 'time'
[-Wunused-variable]
  double time;
         ^~~~
tools/pci/pcitest.c:55:25: warning: unused variable 'end'
[-Wunused-variable]
  struct timespec start, end;
                         ^~~
tools/pci/pcitest.c:55:18: warning: unused variable 'start'
[-Wunused-variable]
  struct timespec start, end;
                  ^~~~~
tools/pci/pcitest.c:146:1: warning: control reaches end of non-void
function [-Wreturn-type]
 }
 ^

Fix them:
 - remove unused variables
 - change function return from int to void, since it's not used

Signed-off-by: Gustavo Pimentel <gustavo.pimentel@synopsys.com>
[lorenzo.pieralisi@arm.com: rewrote the commit log]
Signed-off-by: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Reviewed-by: Kishon Vijay Abraham I <kishon@ti.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 tools/pci/pcitest.c | 7 ++-----
 1 file changed, 2 insertions(+), 5 deletions(-)

diff --git a/tools/pci/pcitest.c b/tools/pci/pcitest.c
index 9074b477bff0f..8ca1c62bc06db 100644
--- a/tools/pci/pcitest.c
+++ b/tools/pci/pcitest.c
@@ -23,7 +23,6 @@
 #include <stdio.h>
 #include <stdlib.h>
 #include <sys/ioctl.h>
-#include <time.h>
 #include <unistd.h>
 
 #include <linux/pcitest.h>
@@ -43,17 +42,15 @@ struct pci_test {
 	unsigned long	size;
 };
 
-static int run_test(struct pci_test *test)
+static void run_test(struct pci_test *test)
 {
 	long ret;
 	int fd;
-	struct timespec start, end;
-	double time;
 
 	fd = open(test->device, O_RDWR);
 	if (fd < 0) {
 		perror("can't open PCI Endpoint Test device");
-		return fd;
+		return;
 	}
 
 	if (test->barnum >= 0 && test->barnum <= 5) {
-- 
2.20.1



