Return-Path: <SRS0=f7FU=UJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,UNWANTED_LANGUAGE_BODY,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 29505C4321A
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Jun 2019 19:32:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F28E220673
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Jun 2019 19:32:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cAzOmJB9"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389216AbfFJTcb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Jun 2019 15:32:31 -0400
Received: from mail-pf1-f195.google.com ([209.85.210.195]:44402 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389059AbfFJTca (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Jun 2019 15:32:30 -0400
Received: by mail-pf1-f195.google.com with SMTP id t16so5859097pfe.11
        for <linux-kernel@vger.kernel.org>; Mon, 10 Jun 2019 12:32:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=aAdZfkRsepXkLBtL2EkYJbysj1OiQXKTY9HeG7MCMjE=;
        b=cAzOmJB9/fRUopA112QybtsEeYwcpHMfEjutiSVnO/UPIDKyDoVvGevNrtu6ZUHxKN
         e904cjTUoPyYy8Rr8oGYiT384RPnZqGD6cZtpaCPdRiUGnsLqrCgdQyAyvC92IjSQpG4
         x0rlEiCsAxWb9VvTmoMBmo8wZt9UGU20+sCEsKzDqXm84RKLe7r2Gh1mrR6mCRyV6U65
         1VGtvPS7kppyoh7CjobHTpX5u8GzM30i2dZM9V4KTQ7A6eTpK0OfB7KNIbh5YMQ6nagN
         o9TLmpgBnucLMT/nv3SGl+5xK0oCFvfLuBK6YNLEofl4D1Dh4USvhxz1frcVGPd+LXXA
         DOIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=aAdZfkRsepXkLBtL2EkYJbysj1OiQXKTY9HeG7MCMjE=;
        b=GrSJQNyNyOUkqClPqJX/QmU3Sw6sPxVzEg9J2svcu8GcKOUbWuiFdtp9kCLNNCGTv+
         xvwNtK9CQnGbY8zerWlE37DPS9Afqx+1HPK/gFW1CyuB2aqFCGePZfinYAGnDah+zHS3
         DHTwjchKS/GP5IrUNJSXBSG7/6r0j1fjzEtDjQ1w6VWxCbL04wh/ZzH/n18kLlILjgOw
         nNqIbSmfqVZbsMbGAiN0wi5Z0MrlM1JEiGgkY86PccGsLDnP8IvQcP1HZL8bXm3mNlV9
         UEqaUMLjb7t8qJiwr4jxJmOYrPn3Z15WdioNoc65/PDytEH1ZKTqhvYQzYsxUOEI8kpe
         +OFw==
X-Gm-Message-State: APjAAAUkzVzEuKG1gzFDsYW55/uD4Nf6QDFDBzhkNQCYZTIbDYkaw2YR
        TolSJchbHGcdJinYoycIAJE=
X-Google-Smtp-Source: APXvYqwTq7bRYSVQdbUyg7+5Vob4kEHOz2fLz80BFTz8PVPUSJg5hIsenI5+e2F3tRWu86SyfATwJg==
X-Received: by 2002:a62:ed1a:: with SMTP id u26mr49860477pfh.229.1560195149868;
        Mon, 10 Jun 2019 12:32:29 -0700 (PDT)
Received: from hari-Inspiron-1545 ([183.83.89.153])
        by smtp.gmail.com with ESMTPSA id g15sm22599077pfm.119.2019.06.10.12.32.27
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 10 Jun 2019 12:32:29 -0700 (PDT)
Date:   Tue, 11 Jun 2019 01:02:24 +0530
From:   Hariprasad Kelam <hariprasad.kelam@gmail.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Guilherme Tadashi Maeoka <gui.maeoka@gmail.com>,
        Jann Horn <jannh@google.com>,
        Hariprasad Kelam <hariprasad.kelam@gmail.com>,
        devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org
Subject: [PATCH] staging: rtl8723bs: fix spaces required around unary operator
Message-ID: <20190610193223.GA16856@hari-Inspiron-1545>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

this patch fixes below issues reported by checkpatch

ERROR: spaces required around that '=' (ctx:WxV)
ERROR: spaces required around that '=' (ctx:WxV)
ERROR: spaces required around that '<' (ctx:VxV)

Signed-off-by: Hariprasad Kelam <hariprasad.kelam@gmail.com>
---
 drivers/staging/rtl8723bs/os_dep/osdep_service.c | 36 ++++++++++++------------
 1 file changed, 18 insertions(+), 18 deletions(-)

diff --git a/drivers/staging/rtl8723bs/os_dep/osdep_service.c b/drivers/staging/rtl8723bs/os_dep/osdep_service.c
index a5a5a5c..1d2c581 100644
--- a/drivers/staging/rtl8723bs/os_dep/osdep_service.c
+++ b/drivers/staging/rtl8723bs/os_dep/osdep_service.c
@@ -77,13 +77,13 @@ static int openFile(struct file **fpp, char *path, int flag, int mode)
 {
 	struct file *fp;
 
-	fp =filp_open(path, flag, mode);
+	fp = filp_open(path, flag, mode);
 	if (IS_ERR(fp)) {
 		*fpp = NULL;
 		return PTR_ERR(fp);
 	}
 	else {
-		*fpp =fp;
+		*fpp = fp;
 		return 0;
 	}
 }
@@ -106,10 +106,10 @@ static int readFile(struct file *fp, char *buf, int len)
 	if (!fp->f_op || !fp->f_op->read)
 		return -EPERM;
 
-	while (sum<len) {
+	while (sum < len) {
 		rlen = kernel_read(fp, buf + sum, len - sum, &fp->f_pos);
-		if (rlen>0)
-			sum+=rlen;
+		if (rlen > 0)
+			sum += rlen;
 		else if (0 != rlen)
 			return rlen;
 		else
@@ -131,7 +131,7 @@ static int isFileReadable(char *path)
 	int ret = 0;
 	char buf;
 
-	fp =filp_open(path, O_RDONLY, 0);
+	fp = filp_open(path, O_RDONLY, 0);
 	if (IS_ERR(fp))
 		return PTR_ERR(fp);
 
@@ -151,7 +151,7 @@ static int isFileReadable(char *path)
 */
 static int retriveFromFile(char *path, u8 *buf, u32 sz)
 {
-	int ret =-1;
+	int ret = -1;
 	struct file *fp;
 
 	if (path && buf) {
@@ -160,7 +160,7 @@ static int retriveFromFile(char *path, u8 *buf, u32 sz)
 		if (ret == 0) {
 			DBG_871X("%s openFile path:%s fp =%p\n", __func__, path , fp);
 
-			ret =readFile(fp, buf, sz);
+			ret = readFile(fp, buf, sz);
 			closeFile(fp);
 
 			DBG_871X("%s readFile, ret:%d\n", __func__, ret);
@@ -197,8 +197,8 @@ int rtw_is_file_readable(char *path)
 */
 int rtw_retrive_from_file(char *path, u8 *buf, u32 sz)
 {
-	int ret =retriveFromFile(path, buf, sz);
-	return ret>= 0?ret:0;
+	int ret = retriveFromFile(path, buf, sz);
+	return ret >= 0 ? ret : 0;
 }
 
 struct net_device *rtw_alloc_etherdev_with_old_priv(int sizeof_priv, void *old_priv)
@@ -211,8 +211,8 @@ struct net_device *rtw_alloc_etherdev_with_old_priv(int sizeof_priv, void *old_p
 		goto RETURN;
 
 	pnpi = netdev_priv(pnetdev);
-	pnpi->priv =old_priv;
-	pnpi->sizeof_priv =sizeof_priv;
+	pnpi->priv = old_priv;
+	pnpi->sizeof_priv = sizeof_priv;
 
 RETURN:
 	return pnetdev;
@@ -236,7 +236,7 @@ struct net_device *rtw_alloc_etherdev(int sizeof_priv)
 		goto RETURN;
 	}
 
-	pnpi->sizeof_priv =sizeof_priv;
+	pnpi->sizeof_priv = sizeof_priv;
 RETURN:
 	return pnetdev;
 }
@@ -284,7 +284,7 @@ int rtw_change_ifname(struct adapter *padapter, const char *ifname)
 	else
 		unregister_netdevice(cur_pnetdev);
 
-	rereg_priv->old_pnetdev =cur_pnetdev;
+	rereg_priv->old_pnetdev = cur_pnetdev;
 
 	pnetdev = rtw_init_netdev(padapter);
 	if (!pnetdev)  {
@@ -379,7 +379,7 @@ void rtw_buf_update(u8 **buf, u32 *buf_len, u8 *src, u32 src_len)
  */
 inline bool rtw_cbuf_full(struct rtw_cbuf *cbuf)
 {
-	return (cbuf->write == cbuf->read-1)? true : false;
+	return (cbuf->write == cbuf->read - 1) ? true : false;
 }
 
 /**
@@ -390,7 +390,7 @@ inline bool rtw_cbuf_full(struct rtw_cbuf *cbuf)
  */
 inline bool rtw_cbuf_empty(struct rtw_cbuf *cbuf)
 {
-	return (cbuf->write == cbuf->read)? true : false;
+	return (cbuf->write == cbuf->read) ? true : false;
 }
 
 /**
@@ -408,7 +408,7 @@ bool rtw_cbuf_push(struct rtw_cbuf *cbuf, void *buf)
 
 	DBG_871X("%s on %u\n", __func__, cbuf->write);
 	cbuf->bufs[cbuf->write] = buf;
-	cbuf->write = (cbuf->write+1)%cbuf->size;
+	cbuf->write = (cbuf->write + 1) % cbuf->size;
 
 	return _SUCCESS;
 }
@@ -428,7 +428,7 @@ void *rtw_cbuf_pop(struct rtw_cbuf *cbuf)
 
         DBG_871X("%s on %u\n", __func__, cbuf->read);
 	buf = cbuf->bufs[cbuf->read];
-	cbuf->read = (cbuf->read+1)%cbuf->size;
+	cbuf->read = (cbuf->read + 1) % cbuf->size;
 
 	return buf;
 }
-- 
2.7.4

