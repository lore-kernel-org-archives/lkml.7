Return-Path: <SRS0=6OEZ=YL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5544CCA9EA0
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Oct 2019 14:27:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2AEE221897
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Oct 2019 14:27:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ALh2c30X"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2634149AbfJRO1O (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 18 Oct 2019 10:27:14 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:45614 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2410093AbfJRO1N (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Oct 2019 10:27:13 -0400
Received: by mail-wr1-f67.google.com with SMTP id q13so1522876wrs.12
        for <linux-kernel@vger.kernel.org>; Fri, 18 Oct 2019 07:27:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=1W5NI/wv1uPqOZl4UwHadNRRgfUhjmgG5NHjOvMoS64=;
        b=ALh2c30X4Vy89Rep15JhELt8CpN+ivoCxgZZorJ0bloN63sDj1wflBC3UfDfwERp51
         6oSjksZRYJo4gS2vARfUDA6eBYbm0o7z1ECAOmqc5C5jLXrrUSRvDP8atK8HIutnfTRj
         bD+SxdLGw4MHW36Myucc/U6ExcaPyP5lJVvCN3+LdMZ2g/VQnfhXMd5ZoNH65lOfmY/e
         tTAb4w/VK+0ntMJ+f4avjj31tXG+07vcWbLQZjDX+jfH0ari9fTr5C3HjQo7dZI2vNRc
         SaJHwrNXeuIEhjnhNuuRIfBLa6/wP3rim0FQx8blkqcLzMKyl8/+C/JISOEKvQa6SbL/
         Fomg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=1W5NI/wv1uPqOZl4UwHadNRRgfUhjmgG5NHjOvMoS64=;
        b=U23aKj5hryOB46YYwYJQ6gI/VQMBJfFCktUPzGFI4zH9rnMBImWKnrLFenqkUL9swW
         I6s1BjuDERD8iyrLhPoULMX1p6sNA9CZjap/Ac0mkzQkt3cMjeLb1E7+aO9uCPNH6feo
         KW020puVPVcVasBnxn8dFYs+kQ82ry4UsPWqcD8vFKx0xXmt1ocgOl9IsgkrZzqjXq4s
         tTP5imf+/8Q2gjbvlOCOvNszL70KA8s0sBArbjtKTmfD9NSU5CsyZVjZFyGx4cjBuhg6
         0ea4qu9Rfu4BpobFGcGqGYRRjVsFlxpt+T1hcGBVaW6l6mrVl9FqWuk+S0NqlL0RtpQb
         IETQ==
X-Gm-Message-State: APjAAAUPW3T/KzaJPVFw5kq/Sk4rbYXG6gVUwaHa8b3IabuEjTlCsTV5
        BOpwmjvuJC+r7qwZW5/EKyM=
X-Google-Smtp-Source: APXvYqztG/tu/QTZRUELhNY+BYjRGGN2sstwFPq8dG4aJfCpBXDO6ta8sLKNIC3KwS68zAw9YFRFcg==
X-Received: by 2002:adf:8295:: with SMTP id 21mr7847660wrc.14.1571408831199;
        Fri, 18 Oct 2019 07:27:11 -0700 (PDT)
Received: from debian.office.codethink.co.uk. ([78.40.148.180])
        by smtp.gmail.com with ESMTPSA id f18sm5817010wrv.38.2019.10.18.07.27.10
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 18 Oct 2019 07:27:10 -0700 (PDT)
From:   Sudip Mukherjee <sudipm.mukherjee@gmail.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jslaby@suse.com>
Cc:     linux-kernel@vger.kernel.org,
        Sudip Mukherjee <sudipm.mukherjee@gmail.com>
Subject: [PATCH] tty: rocket: reduce stack usage
Date:   Fri, 18 Oct 2019 15:26:55 +0100
Message-Id: <20191018142655.2609-1-sudipm.mukherjee@gmail.com>
X-Mailer: git-send-email 2.11.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The build of xtensa allmodconfig gives warning of:
In function 'get_ports.isra.0':
warning: the frame size of 1040 bytes is larger than 1024 bytes

Allocate memory for 'struct rocket_ports' dynamically to reduce the
stack usage, as an added benifit we can remove the memset by using
kzalloc while allocating memory.

Signed-off-by: Sudip Mukherjee <sudipm.mukherjee@gmail.com>
---
 drivers/tty/rocket.c | 29 ++++++++++++++++-------------
 1 file changed, 16 insertions(+), 13 deletions(-)

diff --git a/drivers/tty/rocket.c b/drivers/tty/rocket.c
index 5ba6816ebf81..cc1424b9a1e5 100644
--- a/drivers/tty/rocket.c
+++ b/drivers/tty/rocket.c
@@ -1222,22 +1222,25 @@ static int set_config(struct tty_struct *tty, struct r_port *info,
  */
 static int get_ports(struct r_port *info, struct rocket_ports __user *retports)
 {
-	struct rocket_ports tmp;
-	int board;
+	struct rocket_ports *tmp;
+	int board, ret = 0;
 
-	memset(&tmp, 0, sizeof (tmp));
-	tmp.tty_major = rocket_driver->major;
+	tmp = kzalloc(sizeof(*tmp), GFP_KERNEL);
+	tmp->tty_major = rocket_driver->major;
 
 	for (board = 0; board < 4; board++) {
-		tmp.rocketModel[board].model = rocketModel[board].model;
-		strcpy(tmp.rocketModel[board].modelString, rocketModel[board].modelString);
-		tmp.rocketModel[board].numPorts = rocketModel[board].numPorts;
-		tmp.rocketModel[board].loadrm2 = rocketModel[board].loadrm2;
-		tmp.rocketModel[board].startingPortNumber = rocketModel[board].startingPortNumber;
-	}
-	if (copy_to_user(retports, &tmp, sizeof (*retports)))
-		return -EFAULT;
-	return 0;
+		tmp->rocketModel[board].model = rocketModel[board].model;
+		strcpy(tmp->rocketModel[board].modelString,
+		       rocketModel[board].modelString);
+		tmp->rocketModel[board].numPorts = rocketModel[board].numPorts;
+		tmp->rocketModel[board].loadrm2 = rocketModel[board].loadrm2;
+		tmp->rocketModel[board].startingPortNumber =
+			rocketModel[board].startingPortNumber;
+	}
+	if (copy_to_user(retports, tmp, sizeof(*retports)))
+		ret = -EFAULT;
+	kfree(tmp);
+	return ret;
 }
 
 static int reset_rm2(struct r_port *info, void __user *arg)
-- 
2.11.0

