Return-Path: <SRS0=91bA=RH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D696EC43381
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Mar 2019 19:39:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A96F4206B6
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Mar 2019 19:39:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726334AbfCDTjz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 4 Mar 2019 14:39:55 -0500
Received: from mout.kundenserver.de ([212.227.126.131]:36607 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726054AbfCDTjy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Mar 2019 14:39:54 -0500
Received: from wuerfel.lan ([109.192.41.194]) by mrelayeu.kundenserver.de
 (mreue009 [212.227.15.129]) with ESMTPA (Nemesis) id
 1MrQN5-1hM99S1SQ3-00oWXc; Mon, 04 Mar 2019 20:39:37 +0100
From:   Arnd Bergmann <arnd@arndb.de>
To:     qla2xxx-upstream@qlogic.com,
        "James E.J. Bottomley" <jejb@linux.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Himanshu Madhani <himanshu.madhani@cavium.com>,
        Quinn Tran <qtran@marvell.com>, linux-scsi@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 3/4] scsi: qla2xxx: avoid printf format warning
Date:   Mon,  4 Mar 2019 20:39:10 +0100
Message-Id: <20190304193917.702601-3-arnd@arndb.de>
X-Mailer: git-send-email 2.20.0
In-Reply-To: <20190304193917.702601-1-arnd@arndb.de>
References: <20190304193917.702601-1-arnd@arndb.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:lCcda1YpPw9M+ZtzSbGvp7ECbDox9Y2czsNlWu8nPeD1QnKypkn
 3RCtpNbxrvn/CRomx0tdkFzOCd6j0rBeGqgzlISGvYplxOECqu/jeFo/EhBtEqvyMTsWfF+
 G0OECMhPbnHGqZ3qQ9cffrFZcsU3iqbsQYO2qQgTXB0fZkDWarVMJLVUkyGxsMV8dWc2BTD
 uTsOH5LrhJcDaeu5qBlNw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:qV24WC/GyAE=:fa5fNZ/WYTRMsV3nDc72BR
 oI3/uB0ISYdDKUwzki/EiHmxi9d32AZ9fxOWsK3VHmH8sl7AF0c34eEknDWWfzNt3Z4vg4nkC
 QVzXZmDD1FI2S49mgtyQxtfsgUpFoGlqVDbt3jwaTAf0YdYEjSBGaOrM1n1Mhsr7ffMVgFBHf
 OIr81U4zq3jfyJCjcDMRrep6vxUflMiAKvG5VixCWSQ4puXPURxGDt853YiV+d3wqJtMrkuHg
 x4cEqXMAGKOminLVsYrHSH7QHH5WWNEXBEJ8TE01O5r0GtgAGz2Xmp6nVEOn1oogyMqmhN1za
 aWmCaX0bXjrgi2CHY+BDJ13VdQ5Wl4MkYg9o+DbyhQqNDY+4SLdhc20uZMz0ySziKIYYgHORt
 xVEoV5yBWoMOUP6DiKPppcG6/vYPDLrNhu25C9Fs6OMmy4uO630at5eU5gJT8GFGHE3T8Pk2D
 xpPzhO8AZ8fY2WK/1UZ0h48pPN8vaL6axHFBaT77VnHHJzyL34K/CUfRkxXSybk941KX/gXH/
 TGZjGz5gaTYWdcj1V+mPeZ4UWsmSGvEdKClyhb7QSVxcqizoVSY4CCmKSh5etZKSkC/HhtR7a
 SijgBEv0muTE7/QioemOxg//yLCf6lGtoRYTQH/gjnk0FsEJ3XScevfqvl3NNAJJHrKgoO2i4
 P7YOLcPNa2cW+TVQRYocztT6y5gHKWg0ztD3TSXR5Hm+GVlGK16WZen/qS3c1FBOJNHSMGgj3
 wGYFinwrQ5jOAsANzTskJ7YaqUtRacsPiVO5gQ==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Depending on the target architecture and configuration, both phys_addr_t
and dma_addr_t may be smaller than 'long long', so we get a warning when
printing either of them using the %llx format string:

drivers/scsi/qla2xxx/qla_iocb.c: In function 'qla24xx_walk_and_build_prot_sglist':
drivers/scsi/qla2xxx/qla_iocb.c:1140:46: error: format '%llx' expects argument of type 'long long unsigned int', but argument 6 has type 'dma_addr_t' {aka 'unsigned int'} [-Werror=format=]
         "%s: page boundary crossing (phys=%llx len=%x)\n",
                                           ~~~^
                                           %x
         __func__, sle_phys, sg->length);
                   ~~~~~~~~
drivers/scsi/qla2xxx/qla_iocb.c:1180:29: error: format '%llx' expects argument of type 'long long unsigned int', but argument 7 has type 'dma_addr_t' {aka 'unsigned int'} [-Werror=format=]
        "%s: sg[%x] (phys=%llx sglen=%x) ldma_sg_len: %x dif_bundl_len: %x ldma_needed: %x\n",
                          ~~~^

There are special %pad and %pap format strings in Linux that we could use here,
but since the driver already does 64-bit arithmetic on the values, using a
plain 'u64' seems more consistent here.

Note: A possible related issue may be that the driver possibly checks the
wrong kind of overflow: when an IOMMU is in use, buffers that cross a 32-bit
boundary in physical addresses would still be mapped into dma addresses
within the low 4GB space, so I suspect that we actually want to check
sg_dma_address() instead of sg_phys() here.

Fixes: 50b812755e97 ("scsi: qla2xxx: Fix DMA error when the DIF sg buffer crosses 4GB boundary")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 drivers/scsi/qla2xxx/qla_iocb.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/scsi/qla2xxx/qla_iocb.c b/drivers/scsi/qla2xxx/qla_iocb.c
index 63f8e3c19841..456a41d2e2c6 100644
--- a/drivers/scsi/qla2xxx/qla_iocb.c
+++ b/drivers/scsi/qla2xxx/qla_iocb.c
@@ -1132,7 +1132,7 @@ qla24xx_walk_and_build_prot_sglist(struct qla_hw_data *ha, srb_t *sp,
 	/* if initiator doing write or target doing read */
 	if (direction_to_device) {
 		for_each_sg(sgl, sg, tot_dsds, i) {
-			dma_addr_t sle_phys = sg_phys(sg);
+			u64 sle_phys = sg_phys(sg);
 
 			/* If SGE addr + len flips bits in upper 32-bits */
 			if (MSD(sle_phys + sg->length) ^ MSD(sle_phys)) {
@@ -1178,7 +1178,7 @@ qla24xx_walk_and_build_prot_sglist(struct qla_hw_data *ha, srb_t *sp,
 
 			ql_dbg(ql_dbg_tgt + ql_dbg_verbose, vha, 0xe023,
 			    "%s: sg[%x] (phys=%llx sglen=%x) ldma_sg_len: %x dif_bundl_len: %x ldma_needed: %x\n",
-			    __func__, i, sg_phys(sg), sglen, ldma_sg_len,
+			    __func__, i, (u64)sg_phys(sg), sglen, ldma_sg_len,
 			    difctx->dif_bundl_len, ldma_needed);
 
 			while (sglen) {
-- 
2.20.0

