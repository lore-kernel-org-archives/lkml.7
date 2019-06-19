Return-Path: <SRS0=wAGj=US=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4B975C31E49
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Jun 2019 12:51:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2C654206E0
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Jun 2019 12:51:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731829AbfFSMvB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Jun 2019 08:51:01 -0400
Received: from mout.kundenserver.de ([212.227.126.135]:57401 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727134AbfFSMvB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Jun 2019 08:51:01 -0400
Received: from threadripper.lan ([149.172.19.189]) by mrelayeu.kundenserver.de
 (mreue009 [212.227.15.129]) with ESMTPA (Nemesis) id
 1Mnq0I-1iNKvN22aA-00pLEE; Wed, 19 Jun 2019 14:50:47 +0200
From:   Arnd Bergmann <arnd@arndb.de>
To:     Corey Minyard <minyard@acm.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Arnd Bergmann <arnd@arndb.de>, Asmaa Mnebhi <Asmaa@mellanox.com>,
        vadimp@mellanox.com, Corey Minyard <cminyard@mvista.com>,
        openipmi-developer@lists.sourceforge.net,
        linux-kernel@vger.kernel.org
Subject: [PATCH] ipmi: ipmb: don't allocate i2c_client on stack
Date:   Wed, 19 Jun 2019 14:50:34 +0200
Message-Id: <20190619125045.918700-1-arnd@arndb.de>
X-Mailer: git-send-email 2.20.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:U/wB7UGi/dDxj5A2YvCRhhrBeJdf03T+zz3oLyZzEkzwOOPJNyr
 0v/6xQZAkHibPImBjjuHoTDeZpFulHUsqJiQgOL4MNe8qSODthws2+ofq7rB+lm8sDB0PfS
 4R5YdlujOpraLS4FBTREtZXKDs4DK03DJzQbiJXVz5Ufvxby2SJinlA7bdY7NGSvS2MSxmZ
 5fnZOHbf/m9HrscTRLiHA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:c9iVaAom99Y=:uVulYndpfo1TRDNFPrwY1o
 1PciT+4/gIxN7Sb23Zw5CK8zDzE6Gl6zK5t6EbhCf+uYEuw6LTDG3yoanh7PgUgYLyI+h+nzQ
 ZXPdt6m2VFRM0ekvg2J/25lnIutbI2C2sHXZRx7Hfoskb0b+xBQry016I519tETURMxOjvnYN
 ci5TRhmXl0i24UFsWntV117ryinEFeGAcTxGALcfRnEb7H2sPgbMOLv8Vnd4IMlcAPtT1s6r3
 LScY1tWILu7U+Sydmb3Jryrk4Nw/143jYf13STD2BzauCI0YDr7TB+TqcTuIpjirZDCaP9pqU
 CzyAZEroFZs8LdEhgWJtRBEKqm6ULorSRKj3vBk39pciraBk1fOzyime+SygFMhiEUbUyka8K
 t8DJb12G2H0QF0ZB4No8zvw+SzhRw9ENXMsALCIQR/ctUszE8aPkUgjVsSJHzf7mMfIolL3Zc
 oZXJcLGleB+VNJLW2BMhCR7c6a6baB6vOk4v+J12byVjBTsiX2U2FaZpbX4GYWLIsZwkOMhFE
 KORj/TcKHPV5AwnsiPCJPN7CIu4qNsGRHlMP9qnWKYKrnNUlYFl/012zhXaA2B1VkVLurOGn4
 FNlqu59H9DX3B0ht2TlZw0tPYP0VC+L3PogyMneskmezn0Y+69/vFLyGVTo68CLa1E5aOEFb1
 7TTWerVbzEWrRsWKDLCz01b4H5v04NOu1J+v5FcFcssBsZzQdSU4yDFBe2RO+AAb84Yg2KvXW
 rVIlzwAm343TserpmnsP0AJ7R8odWKP0S6IWew==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The i2c_client structure can be fairly large, which leads to
a warning about possible kernel stack overflow in some
configurations:

drivers/char/ipmi/ipmb_dev_int.c:115:16: error: stack frame size of 1032 bytes in function 'ipmb_write' [-Werror,-Wframe-larger-than=]

There is no real reason to even declare an i2c_client, as we can simply
call i2c_smbus_xfer() directly instead of the i2c_smbus_write_block_data()
wrapper.

Convert the ipmb_write() to use an open-coded i2c_smbus_write_block_data()
here, without changing the behavior.

It seems that there is another problem with this implementation;
when user space passes a length of more than I2C_SMBUS_BLOCK_MAX
bytes, all the rest is silently ignored. This should probably be
addressed in a separate patch, but I don't know what the intended
behavior is here.

Fixes: 51bd6f291583 ("Add support for IPMB driver")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 drivers/char/ipmi/ipmb_dev_int.c | 20 ++++++++++----------
 1 file changed, 10 insertions(+), 10 deletions(-)

diff --git a/drivers/char/ipmi/ipmb_dev_int.c b/drivers/char/ipmi/ipmb_dev_int.c
index 2895abf72e61..c9724f6cf32d 100644
--- a/drivers/char/ipmi/ipmb_dev_int.c
+++ b/drivers/char/ipmi/ipmb_dev_int.c
@@ -117,7 +117,7 @@ static ssize_t ipmb_write(struct file *file, const char __user *buf,
 {
 	struct ipmb_dev *ipmb_dev = to_ipmb_dev(file);
 	u8 rq_sa, netf_rq_lun, msg_len;
-	struct i2c_client rq_client;
+	union i2c_smbus_data data;
 	u8 msg[MAX_MSG_LEN];
 	ssize_t ret;
 
@@ -138,17 +138,17 @@ static ssize_t ipmb_write(struct file *file, const char __user *buf,
 
 	/*
 	 * subtract rq_sa and netf_rq_lun from the length of the msg passed to
-	 * i2c_smbus_write_block_data_local
+	 * i2c_smbus_xfer
 	 */
 	msg_len = msg[IPMB_MSG_LEN_IDX] - SMBUS_MSG_HEADER_LENGTH;
-
-	strcpy(rq_client.name, "ipmb_requester");
-	rq_client.adapter = ipmb_dev->client->adapter;
-	rq_client.flags = ipmb_dev->client->flags;
-	rq_client.addr = rq_sa;
-
-	ret = i2c_smbus_write_block_data(&rq_client, netf_rq_lun, msg_len,
-					msg + SMBUS_MSG_IDX_OFFSET);
+	if (msg_len > I2C_SMBUS_BLOCK_MAX)
+		msg_len = I2C_SMBUS_BLOCK_MAX;
+
+	data.block[0] = msg_len;
+	memcpy(&data.block[1], msg + SMBUS_MSG_IDX_OFFSET, msg_len);
+	ret = i2c_smbus_xfer(ipmb_dev->client->adapter, rq_sa, ipmb_dev->client->flags,
+			     I2C_SMBUS_WRITE, netf_rq_lun,
+			     I2C_SMBUS_BLOCK_DATA, &data);
 
 	return ret ? : count;
 }
-- 
2.20.0

