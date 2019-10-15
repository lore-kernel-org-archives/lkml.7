Return-Path: <SRS0=fSNO=YI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 155B3ECE588
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Oct 2019 10:26:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DDBCA20854
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Oct 2019 10:26:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730600AbfJOK0W (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 15 Oct 2019 06:26:22 -0400
Received: from imap1.codethink.co.uk ([176.9.8.82]:41113 "EHLO
        imap1.codethink.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726508AbfJOK0W (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Oct 2019 06:26:22 -0400
Received: from [167.98.27.226] (helo=rainbowdash.codethink.co.uk)
        by imap1.codethink.co.uk with esmtpsa (Exim 4.84_2 #1 (Debian))
        id 1iKK1w-0006RM-62; Tue, 15 Oct 2019 11:26:16 +0100
Received: from ben by rainbowdash.codethink.co.uk with local (Exim 4.92.2)
        (envelope-from <ben@rainbowdash.codethink.co.uk>)
        id 1iKK1v-0002zJ-OZ; Tue, 15 Oct 2019 11:26:15 +0100
From:   Ben Dooks <ben.dooks@codethink.co.uk>
To:     linux-kernel@lists.codethink.co.uk
Cc:     Ben Dooks <ben.dooks@codethink.co.uk>,
        Dennis Zhou <dennis@kernel.org>, Tejun Heo <tj@kernel.org>,
        Christoph Lameter <cl@linux.com>, linux-kernel@vger.kernel.org
Subject: [PATCH] percpu: add __percpu to SHIFT_PERCPU_PTR
Date:   Tue, 15 Oct 2019 11:26:15 +0100
Message-Id: <20191015102615.11430-1-ben.dooks@codethink.co.uk>
X-Mailer: git-send-email 2.23.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The SHIFT_PERCPU_PTR() returns a pointer used by a number
of functions that expect the pointer to be __percpu annotated
(sparse address space 3). Adding __percpu to this makes the
following sparse warnings go away.

Note, this then creates the problem the __percup is marked
as noderef, which may need removing for some of the internal
functions, or to remove other warnings.

mm/vmstat.c:385:13: warning: incorrect type in initializer (different address spaces)
mm/vmstat.c:385:13:    expected signed char [noderef] [usertype] <asn:3> *__p
mm/vmstat.c:385:13:    got signed char *
mm/vmstat.c:385:13: warning: incorrect type in initializer (different address spaces)
mm/vmstat.c:385:13:    expected signed char [noderef] [usertype] <asn:3> *__p
mm/vmstat.c:385:13:    got signed char *
mm/vmstat.c:385:13: warning: incorrect type in initializer (different address spaces)
mm/vmstat.c:385:13:    expected signed char [noderef] [usertype] <asn:3> *__p
mm/vmstat.c:385:13:    got signed char *
mm/vmstat.c:385:13: warning: incorrect type in initializer (different address spaces)
mm/vmstat.c:385:13:    expected signed char [noderef] [usertype] <asn:3> *__p
mm/vmstat.c:385:13:    got signed char *
mm/vmstat.c:401:13: warning: incorrect type in initializer (different address spaces)
mm/vmstat.c:401:13:    expected signed char [noderef] [usertype] <asn:3> *__p
mm/vmstat.c:401:13:    got signed char *
mm/vmstat.c:401:13: warning: incorrect type in initializer (different address spaces)
mm/vmstat.c:401:13:    expected signed char [noderef] [usertype] <asn:3> *__p
mm/vmstat.c:401:13:    got signed char *
mm/vmstat.c:401:13: warning: incorrect type in initializer (different address spaces)
mm/vmstat.c:401:13:    expected signed char [noderef] [usertype] <asn:3> *__p
mm/vmstat.c:401:13:    got signed char *
mm/vmstat.c:401:13: warning: incorrect type in initializer (different address spaces)
mm/vmstat.c:401:13:    expected signed char [noderef] [usertype] <asn:3> *__p
mm/vmstat.c:401:13:    got signed char *
mm/vmstat.c:429:13: warning: incorrect type in initializer (different address spaces)
mm/vmstat.c:429:13:    expected signed char [noderef] [usertype] <asn:3> *__p
mm/vmstat.c:429:13:    got signed char *
mm/vmstat.c:429:13: warning: incorrect type in initializer (different address spaces)
mm/vmstat.c:429:13:    expected signed char [noderef] [usertype] <asn:3> *__p
mm/vmstat.c:429:13:    got signed char *
mm/vmstat.c:429:13: warning: incorrect type in initializer (different address spaces)
mm/vmstat.c:429:13:    expected signed char [noderef] [usertype] <asn:3> *__p
mm/vmstat.c:429:13:    got signed char *
mm/vmstat.c:429:13: warning: incorrect type in initializer (different address spaces)
mm/vmstat.c:429:13:    expected signed char [noderef] [usertype] <asn:3> *__p
mm/vmstat.c:429:13:    got signed char *
mm/vmstat.c:445:13: warning: incorrect type in initializer (different address spaces)
mm/vmstat.c:445:13:    expected signed char [noderef] [usertype] <asn:3> *__p
mm/vmstat.c:445:13:    got signed char *
mm/vmstat.c:445:13: warning: incorrect type in initializer (different address spaces)
mm/vmstat.c:445:13:    expected signed char [noderef] [usertype] <asn:3> *__p
mm/vmstat.c:445:13:    got signed char *
mm/vmstat.c:445:13: warning: incorrect type in initializer (different address spaces)
mm/vmstat.c:445:13:    expected signed char [noderef] [usertype] <asn:3> *__p
mm/vmstat.c:445:13:    got signed char *
mm/vmstat.c:445:13: warning: incorrect type in initializer (different address spaces)
mm/vmstat.c:445:13:    expected signed char [noderef] [usertype] <asn:3> *__p
mm/vmstat.c:445:13:    got signed char *
mm/vmstat.c:763:29: warning: incorrect type in initializer (different address spaces)
mm/vmstat.c:763:29:    expected signed char [noderef] <asn:3> *__p
mm/vmstat.c:763:29:    got signed char *
mm/vmstat.c:763:29: warning: incorrect type in initializer (different address spaces)
mm/vmstat.c:763:29:    expected signed char [noderef] <asn:3> *__p
mm/vmstat.c:763:29:    got signed char *
mm/vmstat.c:763:29: warning: incorrect type in initializer (different address spaces)
mm/vmstat.c:763:29:    expected signed char [noderef] <asn:3> *__p
mm/vmstat.c:763:29:    got signed char *
mm/vmstat.c:763:29: warning: incorrect type in initializer (different address spaces)
mm/vmstat.c:763:29:    expected signed char [noderef] <asn:3> *__p
mm/vmstat.c:763:29:    got signed char *
mm/vmstat.c:825:29: warning: incorrect type in initializer (different address spaces)
mm/vmstat.c:825:29:    expected signed char [noderef] <asn:3> *__p
mm/vmstat.c:825:29:    got signed char *
mm/vmstat.c:825:29: warning: incorrect type in initializer (different address spaces)
mm/vmstat.c:825:29:    expected signed char [noderef] <asn:3> *__p
mm/vmstat.c:825:29:    got signed char *
mm/vmstat.c:825:29: warning: incorrect type in initializer (different address spaces)
mm/vmstat.c:825:29:    expected signed char [noderef] <asn:3> *__p
mm/vmstat.c:825:29:    got signed char *
mm/vmstat.c:825:29: warning: incorrect type in initializer (different address spaces)
mm/vmstat.c:825:29:    expected signed char [noderef] <asn:3> *__p
mm/vmstat.c:825:29:    got signed char *

Signed-off-by: Ben Dooks <ben.dooks@codethink.co.uk>
---
Cc: Dennis Zhou <dennis@kernel.org>
Cc: Tejun Heo <tj@kernel.org>
Cc: Christoph Lameter <cl@linux.com>
Cc: linux-kernel@vger.kernel.org
---
 include/linux/percpu-defs.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/linux/percpu-defs.h b/include/linux/percpu-defs.h
index a6fabd865211..a49b6c702598 100644
--- a/include/linux/percpu-defs.h
+++ b/include/linux/percpu-defs.h
@@ -229,7 +229,7 @@ do {									\
  * pointer value.  The weird cast keeps both GCC and sparse happy.
  */
 #define SHIFT_PERCPU_PTR(__p, __offset)					\
-	RELOC_HIDE((typeof(*(__p)) __kernel __force *)(__p), (__offset))
+	RELOC_HIDE((typeof(*(__p)) __kernel __percpu __force *)(__p), (__offset))
 
 #define per_cpu_ptr(ptr, cpu)						\
 ({									\
-- 
2.23.0

