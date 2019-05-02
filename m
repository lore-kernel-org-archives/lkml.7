Return-Path: <SRS0=c+yg=TC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	T_DKIMWL_WL_HIGH,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CFDBFC43219
	for <linux-kernel@archiver.kernel.org>; Thu,  2 May 2019 15:25:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9FA2220B7C
	for <linux-kernel@archiver.kernel.org>; Thu,  2 May 2019 15:25:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1556810736;
	bh=ycWLMFE2XQW9iKBkq/OI1zu6AiL1FtXWMJkW9Ii0U3Q=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=eaojBbCDfodyEtNnwHQwjAYCl9m+/aosB9hdUpAq4uhd6aosb9zHmtOPpe6vT3LB7
	 XFK+Go1JnIq39t/grWGSWRuFSaAHaF13y361qoRV+N8v+tEqeG9kpG2FcLfv4nnoqf
	 m9cbxP7iLmK0bSdb3dNM5/bKrJmNXyjYMiKsoH9o=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727572AbfEBPZf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 2 May 2019 11:25:35 -0400
Received: from mail.kernel.org ([198.145.29.99]:41874 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726508AbfEBPZd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 May 2019 11:25:33 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 78D4320B7C;
        Thu,  2 May 2019 15:25:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1556810733;
        bh=ycWLMFE2XQW9iKBkq/OI1zu6AiL1FtXWMJkW9Ii0U3Q=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=SNoKIjLscRNxxxyWwRhkOg55WGOJMJbjSEbOUcpiq91QJKfpKm+Igc3u8XBK/2n+9
         S2T2m++1oFaAKZJJAS6Uxlmhtb1UNhvw8pZHZf2HgsEtdcuoMWxzMR/DRr1YzAaPFd
         nDYOsqGZsiQhyWdQmUxSquzTcALJTCF3MjL4DS54=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Paulo Alcantara <paulo@paulo.ac>,
        Stephen Smalley <sds@tycho.nsa.gov>,
        Paul Moore <paul@paul-moore.com>
Subject: [PATCH 4.19 01/72] selinux: use kernel linux/socket.h for genheaders and mdp
Date:   Thu,  2 May 2019 17:20:23 +0200
Message-Id: <20190502143333.507762002@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190502143333.437607839@linuxfoundation.org>
References: <20190502143333.437607839@linuxfoundation.org>
User-Agent: quilt/0.66
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Paulo Alcantara <paulo@paulo.ac>

commit dfbd199a7cfe3e3cd8531e1353cdbd7175bfbc5e upstream.

When compiling genheaders and mdp from a newer host kernel, the
following error happens:

    In file included from scripts/selinux/genheaders/genheaders.c:18:
    ./security/selinux/include/classmap.h:238:2: error: #error New
    address family defined, please update secclass_map.  #error New
    address family defined, please update secclass_map.  ^~~~~
    make[3]: *** [scripts/Makefile.host:107:
    scripts/selinux/genheaders/genheaders] Error 1 make[2]: ***
    [scripts/Makefile.build:599: scripts/selinux/genheaders] Error 2
    make[1]: *** [scripts/Makefile.build:599: scripts/selinux] Error 2
    make[1]: *** Waiting for unfinished jobs....

Instead of relying on the host definition, include linux/socket.h in
classmap.h to have PF_MAX.

Cc: stable@vger.kernel.org
Signed-off-by: Paulo Alcantara <paulo@paulo.ac>
Acked-by: Stephen Smalley <sds@tycho.nsa.gov>
[PM: manually merge in mdp.c, subject line tweaks]
Signed-off-by: Paul Moore <paul@paul-moore.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 scripts/selinux/genheaders/genheaders.c |    1 -
 scripts/selinux/mdp/mdp.c               |    1 -
 security/selinux/include/classmap.h     |    1 +
 3 files changed, 1 insertion(+), 2 deletions(-)

--- a/scripts/selinux/genheaders/genheaders.c
+++ b/scripts/selinux/genheaders/genheaders.c
@@ -9,7 +9,6 @@
 #include <string.h>
 #include <errno.h>
 #include <ctype.h>
-#include <sys/socket.h>
 
 struct security_class_mapping {
 	const char *name;
--- a/scripts/selinux/mdp/mdp.c
+++ b/scripts/selinux/mdp/mdp.c
@@ -32,7 +32,6 @@
 #include <stdlib.h>
 #include <unistd.h>
 #include <string.h>
-#include <sys/socket.h>
 
 static void usage(char *name)
 {
--- a/security/selinux/include/classmap.h
+++ b/security/selinux/include/classmap.h
@@ -1,5 +1,6 @@
 /* SPDX-License-Identifier: GPL-2.0 */
 #include <linux/capability.h>
+#include <linux/socket.h>
 
 #define COMMON_FILE_SOCK_PERMS "ioctl", "read", "write", "create", \
     "getattr", "setattr", "lock", "relabelfrom", "relabelto", "append", "map"


