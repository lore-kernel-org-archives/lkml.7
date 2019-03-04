Return-Path: <SRS0=91bA=RH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5D3F5C43381
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Mar 2019 19:39:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 32803206B6
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Mar 2019 19:39:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726318AbfCDTjj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 4 Mar 2019 14:39:39 -0500
Received: from mout.kundenserver.de ([212.227.126.130]:45461 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726249AbfCDTji (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Mar 2019 14:39:38 -0500
Received: from wuerfel.lan ([109.192.41.194]) by mrelayeu.kundenserver.de
 (mreue009 [212.227.15.129]) with ESMTPA (Nemesis) id
 1MI5YN-1gmoP211Xz-00FBn2; Mon, 04 Mar 2019 20:39:27 +0100
From:   Arnd Bergmann <arnd@arndb.de>
To:     James Smart <james.smart@broadcom.com>,
        Dick Kennedy <dick.kennedy@broadcom.com>,
        "James E.J. Bottomley" <jejb@linux.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>
Cc:     Arnd Bergmann <arnd@arndb.de>, Hannes Reinecke <hare@suse.de>,
        Colin Ian King <colin.king@canonical.com>,
        linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 2/4] scsi: lpfc: fix 32-bit format string warning
Date:   Mon,  4 Mar 2019 20:39:09 +0100
Message-Id: <20190304193917.702601-2-arnd@arndb.de>
X-Mailer: git-send-email 2.20.0
In-Reply-To: <20190304193917.702601-1-arnd@arndb.de>
References: <20190304193917.702601-1-arnd@arndb.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:+fIGMcSmqHKn1OJVorNl9fjA9KSVkCozrlL8TIyirlZAvTTYnSj
 cfEhuN3COW99I6N5vqKXi5KIfpO2EQA69ich3mmlE10eK35IiKrXLRH1rKhUj/lWELLbTYR
 QusSilWesSP3fD4Mx17r71YWl8EUoqNqffqTze8Sa4dY4HwDjdRD9nb03zEtH+sGeQTd+Sd
 xkTwx6wwSvVz1+OxM3ahg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:edIvNvmKp6E=:htxy/QU3Lu5H+T3ONDZ9HK
 q+TbU7E9zmz0/ltpDOf36LqeWjJmM0THO6N9Wxf2CHTyqCnNk229s5plNlhyHnrJCJXueC44D
 zb09c+wU/zZvNIHaTVMEbGM1swr/UgjJ4XM/7ZsJcIszl3KxarV02lwwKCC1v4KZxz04/QJpR
 MpyU9xMPJy0TX9eec3BFAFb3emk0pddcWw+SZvUbjxcY0GVtwascEtwN9TTGa6Q6+fb+4bscY
 BlgEz+NjJstt+7qZQ4qhXIDrr3iIL9y3BBL1g969nFZIAtPUoQw/dlJb/WJN3LDVFPHLwumFh
 meIKKxd90l112sVk4e+5l7pDHDLvE3vq1CWlBE1ZaoC0zcqdlZBm1FLHue4tTvZHV/2d0CjZa
 DKY8DIog1ox4wHHg4qtShueu4QTD6sW/H+WHsucokM1SKPcMJ277Fkhx6B1L8e7/cgJMXoK49
 Wz3EMt8dPacZdTEKj8UuHW9OHt3lKNhdoOPkoDDXM0NNmm9xY9dhcFmRkzBUKDNEj6ZT1rgs1
 iKSLG968fOqHqZ+oSk9ttAjy0N5op8YHSq6KtILAT/wInP4eS7PTg789LY+r2QXARtv9/VMm5
 VqD+ve9tmEtx92vFmTGh/RAzeTYwwkG8q6dWZRj49WH0LbXHz+R1L9xSjJWLD0s1lwRa2gBIZ
 8wa9943LxehbeC9Cl4E3q/aVJn9pREl+M2m0hVCD7boybp41PJ5XpU6a5aZTsXS+HeF6BN36o
 q43QO6B+SGKpjoUZyKTRkZAS1F9SCiC2QdQ++A==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 32-bit architectures, we see a warning when %ld is used to
print a size_t:

In file included from drivers/scsi/lpfc/lpfc_init.c:62:
drivers/scsi/lpfc/lpfc_init.c: In function 'lpfc_new_io_buf':
drivers/scsi/lpfc/lpfc_logmsg.h:62:45: error: format '%ld' expects argument of type 'long int', but argument 5 has type 'unsigned int' [-Werror=format=]

This is harmless, but portable code should just use %zd to
avoid the warning.

Fixes: 0794d601d174 ("scsi: lpfc: Implement common IO buffers between NVME and SCSI")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 drivers/scsi/lpfc/lpfc_init.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/scsi/lpfc/lpfc_init.c b/drivers/scsi/lpfc/lpfc_init.c
index 3b5873f6751e..6e6bd1b3237d 100644
--- a/drivers/scsi/lpfc/lpfc_init.c
+++ b/drivers/scsi/lpfc/lpfc_init.c
@@ -4090,7 +4090,7 @@ lpfc_new_io_buf(struct lpfc_hba *phba, int num_to_alloc)
 	/* Sanity check to ensure our sizing is right for both SCSI and NVME */
 	if (sizeof(struct lpfc_io_buf) > LPFC_COMMON_IO_BUF_SZ) {
 		lpfc_printf_log(phba, KERN_ERR, LOG_FCP,
-				"6426 Common buffer size %ld exceeds %d\n",
+				"6426 Common buffer size %zd exceeds %d\n",
 				sizeof(struct lpfc_io_buf),
 				LPFC_COMMON_IO_BUF_SZ);
 		return 0;
-- 
2.20.0

