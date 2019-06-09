Return-Path: <SRS0=y5Xy=UI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,T_DKIMWL_WL_HIGH,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6C05DC28EBD
	for <linux-kernel@archiver.kernel.org>; Sun,  9 Jun 2019 17:04:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 41377206DF
	for <linux-kernel@archiver.kernel.org>; Sun,  9 Jun 2019 17:04:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1560099851;
	bh=znFL7krxnAtQKb0YeVjDyTYArkXpnF0QQBKi7kjZNRk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=YxLrHAnNln3Ehy1wqkbl/NGBx/lKhD2rwyQE02JkEfD1/+/RO7pen/sHUoQw+znoz
	 8r7RwnpUcR6d/YxI7i82jrGSGJYfVZsr81/jLjA5GUhlye0r5+aCnxH2BBmqVGm06B
	 82jgbJhGlrxQ/hxZ08Y5I/H/RrnjzH9w8YE4R4lY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388055AbfFIREK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 9 Jun 2019 13:04:10 -0400
Received: from mail.kernel.org ([198.145.29.99]:42776 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388543AbfFIREI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 9 Jun 2019 13:04:08 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 82586204EC;
        Sun,  9 Jun 2019 17:04:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1560099848;
        bh=znFL7krxnAtQKb0YeVjDyTYArkXpnF0QQBKi7kjZNRk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Zw2NI/67hrGJJvndtvNUh5P4C6SVUVAaT0lIK5p2kwqiySmKGuZ0Rm/z97ZVH3tzN
         F182KET8whs8RW71iggA1949IViP4cdsxZjx0rzJuzSBHx1Wx+3QcI16lEo2QFUku8
         jhhLFwq96lHcnSG7XuLrLn7X2XuG8KIa5gvTZsVw=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>,
        Nathan Chancellor <natechancellor@gmail.com>,
        Sebastian Ott <sebott@linux.ibm.com>,
        Martin Schwidefsky <schwidefsky@de.ibm.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.4 143/241] s390: cio: fix cio_irb declaration
Date:   Sun,  9 Jun 2019 18:41:25 +0200
Message-Id: <20190609164151.911104770@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190609164147.729157653@linuxfoundation.org>
References: <20190609164147.729157653@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

[ Upstream commit e91012ee855ad9f5ef2ab106a3de51db93fe4d0c ]

clang points out that the declaration of cio_irb does not match the
definition exactly, it is missing the alignment attribute:

../drivers/s390/cio/cio.c:50:1: warning: section does not match previous declaration [-Wsection]
DEFINE_PER_CPU_ALIGNED(struct irb, cio_irb);
^
../include/linux/percpu-defs.h:150:2: note: expanded from macro 'DEFINE_PER_CPU_ALIGNED'
        DEFINE_PER_CPU_SECTION(type, name, PER_CPU_ALIGNED_SECTION)     \
        ^
../include/linux/percpu-defs.h:93:9: note: expanded from macro 'DEFINE_PER_CPU_SECTION'
        extern __PCPU_ATTRS(sec) __typeof__(type) name;                 \
               ^
../include/linux/percpu-defs.h:49:26: note: expanded from macro '__PCPU_ATTRS'
        __percpu __attribute__((section(PER_CPU_BASE_SECTION sec)))     \
                                ^
../drivers/s390/cio/cio.h:118:1: note: previous attribute is here
DECLARE_PER_CPU(struct irb, cio_irb);
^
../include/linux/percpu-defs.h:111:2: note: expanded from macro 'DECLARE_PER_CPU'
        DECLARE_PER_CPU_SECTION(type, name, "")
        ^
../include/linux/percpu-defs.h:87:9: note: expanded from macro 'DECLARE_PER_CPU_SECTION'
        extern __PCPU_ATTRS(sec) __typeof__(type) name
               ^
../include/linux/percpu-defs.h:49:26: note: expanded from macro '__PCPU_ATTRS'
        __percpu __attribute__((section(PER_CPU_BASE_SECTION sec)))     \
                                ^
Use DECLARE_PER_CPU_ALIGNED() here, to make the two match.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
Reviewed-by: Nathan Chancellor <natechancellor@gmail.com>
Signed-off-by: Sebastian Ott <sebott@linux.ibm.com>
Signed-off-by: Martin Schwidefsky <schwidefsky@de.ibm.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/s390/cio/cio.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/s390/cio/cio.h b/drivers/s390/cio/cio.h
index a01376ae17493..fdb87520543fe 100644
--- a/drivers/s390/cio/cio.h
+++ b/drivers/s390/cio/cio.h
@@ -102,7 +102,7 @@ struct subchannel {
 	struct schib_config config;
 } __attribute__ ((aligned(8)));
 
-DECLARE_PER_CPU(struct irb, cio_irb);
+DECLARE_PER_CPU_ALIGNED(struct irb, cio_irb);
 
 #define to_subchannel(n) container_of(n, struct subchannel, dev)
 
-- 
2.20.1



