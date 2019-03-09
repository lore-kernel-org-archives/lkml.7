Return-Path: <SRS0=x0+x=RM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,UNWANTED_LANGUAGE_BODY,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 34440C43381
	for <linux-kernel@archiver.kernel.org>; Sat,  9 Mar 2019 18:31:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F1D1E207E0
	for <linux-kernel@archiver.kernel.org>; Sat,  9 Mar 2019 18:31:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BRIn4nPd"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726549AbfCISbW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 9 Mar 2019 13:31:22 -0500
Received: from mail-qt1-f196.google.com ([209.85.160.196]:35909 "EHLO
        mail-qt1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726402AbfCISbR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 9 Mar 2019 13:31:17 -0500
Received: by mail-qt1-f196.google.com with SMTP id b3so868540qtj.3
        for <linux-kernel@vger.kernel.org>; Sat, 09 Mar 2019 10:31:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=umcTZHyvVrdYmwvozYe13K9OBjdyItsqGuLlYELNGNs=;
        b=BRIn4nPdEIWRC2/WlEOhmZVD9tM+kD98a/6YmG7+uXCIPWIT1qoi3CWXvPuwblIYBg
         9uR90iAKGGB7Bhcu+rmapY+jc9BTKcWbPnehiQHDmwkm5lUfNjT096SqzDJjaQMRji9x
         ST8twl6CHWPlLYuVT1Law5AP8FKq5t3FhRy4apdcxy4bI1hn18cq/pfrOobetLYen1w+
         cPzhnO4uZPDH/dzCXevxyTgudQfJ5TdBvFVSPNSXco5yK8HoAWnWWtejlMD4yls5pxOV
         X9aIAfz1JGuYfKKOl6+TXFaM6MENaKReAS4/w6jdv23jhUTE69FEA6RSDbuNSx2DQCgK
         Dg2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=umcTZHyvVrdYmwvozYe13K9OBjdyItsqGuLlYELNGNs=;
        b=tVKYIBuWPR2ahWExrDFBD+YPsqZnT5tnAKZHC2pEDLDgzQXxZcAIaK9+w0uer4Uhau
         dqrbHb3IDGROH9gMKTGMlkahXnrYU84QRbJduBrP9ZrODSzbgP4IOqE5pnInkSpD/sjJ
         H0oPqCVNojyHDjp4aUhKeH2f+ZkwL07gZJYMMWpcXChcd4jg7R8+0wBgG71eRy5Ycwp/
         l0Og5Pww7Lvnt2TGZYw6x/3n7znMVenfoqJGHKM+RPxiXMuXozC8eljJE7vqXjCvqC/Q
         DW3hsjzehFSNT9rH7Dy3dV4P62lx0bKDGFHPcpOak/UND2h4rIugdHu5Zdg4lXUbpRUP
         zKfg==
X-Gm-Message-State: APjAAAX7CxSfss2PSEYEv+e37vrVRTdSBxXGoTod6TceBSJoZVHBAeun
        UO0qXJg4NKzK2RDigtp/Thw=
X-Google-Smtp-Source: APXvYqwqYihBqDoEjDwEGhOvG8HmfZ1KNqYOi3L/s6+G7H3HA4ObCD8tDrMnLm7khtGts3CTc3Ncvg==
X-Received: by 2002:ac8:96c:: with SMTP id z41mr19420040qth.305.1552156275461;
        Sat, 09 Mar 2019 10:31:15 -0800 (PST)
Received: from localhost.localdomain ([191.8.88.159])
        by smtp.gmail.com with ESMTPSA id f8sm558824qkl.11.2019.03.09.10.31.13
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 09 Mar 2019 10:31:15 -0800 (PST)
From:   Guilherme Tadashi Maeoka <gui.maeoka@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org,
        Guilherme Tadashi Maeoka <gui.maeoka@gmail.com>
Subject: [PATCH 2/5] Staging: rtl8723bs: os_dep: Fix space required coding style
Date:   Sat,  9 Mar 2019 15:30:44 -0300
Message-Id: <20190309183047.10781-3-gui.maeoka@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190309183047.10781-1-gui.maeoka@gmail.com>
References: <20190309183047.10781-1-gui.maeoka@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix multiple space required coding style.

Signed-off-by: Guilherme Tadashi Maeoka <gui.maeoka@gmail.com>
---
 .../staging/rtl8723bs/os_dep/osdep_service.c  | 38 +++++++++----------
 1 file changed, 19 insertions(+), 19 deletions(-)

diff --git a/drivers/staging/rtl8723bs/os_dep/osdep_service.c b/drivers/staging/rtl8723bs/os_dep/osdep_service.c
index c7fdcc6bbae3..5a58e1d40f7e 100644
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
-		rlen =fp->f_op->read(fp, (char __force __user *)buf+sum, len-sum, &fp->f_pos);
-		if (rlen>0)
-			sum+=rlen;
+	while (sum < len) {
+		rlen = fp->f_op->read(fp, (char __force __user *)buf+sum, len-sum, &fp->f_pos);
+		if (rlen > 0)
+			sum += rlen;
 		else if (0 != rlen)
 			return rlen;
 		else
@@ -132,14 +132,14 @@ static int isFileReadable(char *path)
 	mm_segment_t oldfs;
 	char buf;
 
-	fp =filp_open(path, O_RDONLY, 0);
+	fp = filp_open(path, O_RDONLY, 0);
 	if (IS_ERR(fp)) {
 		ret = PTR_ERR(fp);
 	}
 	else {
 		oldfs = get_fs(); set_fs(KERNEL_DS);
 
-		if (1!=readFile(fp, &buf, 1))
+		if (1 != readFile(fp, &buf, 1))
 			ret = -EINVAL;
 
 		set_fs(oldfs);
@@ -157,7 +157,7 @@ static int isFileReadable(char *path)
 */
 static int retriveFromFile(char *path, u8 *buf, u32 sz)
 {
-	int ret =-1;
+	int ret = -1;
 	mm_segment_t oldfs;
 	struct file *fp;
 
@@ -165,10 +165,10 @@ static int retriveFromFile(char *path, u8 *buf, u32 sz)
 		ret = openFile(&fp, path, O_RDONLY, 0);
 
 		if (ret == 0) {
-			DBG_871X("%s openFile path:%s fp =%p\n", __func__, path , fp);
+			DBG_871X("%s openFile path:%s fp =%p\n", __func__, path, fp);
 
 			oldfs = get_fs(); set_fs(KERNEL_DS);
-			ret =readFile(fp, buf, sz);
+			ret = readFile(fp, buf, sz);
 			set_fs(oldfs);
 			closeFile(fp);
 
@@ -206,8 +206,8 @@ int rtw_is_file_readable(char *path)
 */
 int rtw_retrive_from_file(char *path, u8 *buf, u32 sz)
 {
-	int ret =retriveFromFile(path, buf, sz);
-	return ret>= 0?ret:0;
+	int ret = retriveFromFile(path, buf, sz);
+	return ret >= 0 ? ret : 0;
 }
 
 struct net_device *rtw_alloc_etherdev_with_old_priv(int sizeof_priv, void *old_priv)
@@ -220,8 +220,8 @@ struct net_device *rtw_alloc_etherdev_with_old_priv(int sizeof_priv, void *old_p
 		goto RETURN;
 
 	pnpi = netdev_priv(pnetdev);
-	pnpi->priv =old_priv;
-	pnpi->sizeof_priv =sizeof_priv;
+	pnpi->priv = old_priv;
+	pnpi->sizeof_priv = sizeof_priv;
 
 RETURN:
 	return pnetdev;
@@ -245,7 +245,7 @@ struct net_device *rtw_alloc_etherdev(int sizeof_priv)
 		goto RETURN;
 	}
 
-	pnpi->sizeof_priv =sizeof_priv;
+	pnpi->sizeof_priv = sizeof_priv;
 RETURN:
 	return pnetdev;
 }
@@ -293,7 +293,7 @@ int rtw_change_ifname(struct adapter *padapter, const char *ifname)
 	else
 		unregister_netdevice(cur_pnetdev);
 
-	rereg_priv->old_pnetdev =cur_pnetdev;
+	rereg_priv->old_pnetdev = cur_pnetdev;
 
 	pnetdev = rtw_init_netdev(padapter);
 	if (!pnetdev)  {
@@ -388,7 +388,7 @@ void rtw_buf_update(u8 **buf, u32 *buf_len, u8 *src, u32 src_len)
  */
 inline bool rtw_cbuf_full(struct rtw_cbuf *cbuf)
 {
-	return (cbuf->write == cbuf->read-1)? true : false;
+	return (cbuf->write == cbuf->read-1) ? true : false;
 }
 
 /**
@@ -399,7 +399,7 @@ inline bool rtw_cbuf_full(struct rtw_cbuf *cbuf)
  */
 inline bool rtw_cbuf_empty(struct rtw_cbuf *cbuf)
 {
-	return (cbuf->write == cbuf->read)? true : false;
+	return (cbuf->write == cbuf->read) ? true : false;
 }
 
 /**
-- 
2.17.1

