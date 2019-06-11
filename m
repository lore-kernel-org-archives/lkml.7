Return-Path: <SRS0=TvG7=UK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2F680C4321A
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Jun 2019 03:01:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DF9C620820
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Jun 2019 03:01:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OD3PRm6Y"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390922AbfFKDAj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Jun 2019 23:00:39 -0400
Received: from mail-pl1-f195.google.com ([209.85.214.195]:37981 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390717AbfFKDAi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Jun 2019 23:00:38 -0400
Received: by mail-pl1-f195.google.com with SMTP id f97so4435128plb.5
        for <linux-kernel@vger.kernel.org>; Mon, 10 Jun 2019 20:00:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=ouy9EuLfvfLxerqmfmzyViveD/DuvjNYljoQC00wHrM=;
        b=OD3PRm6YfoYvQMyBsgze784qL4eM8F81xSCLXGDKuqXYmG9CI8R/t+DbXu9uhn+M+j
         sMkXqcgxuEtU/GgLiYqDnafMam5pUvbRG262j2g18HdNeyP5Io9aj2p35GRsCatuDwlo
         UyvhnxYYi9Ik+vt1Q4N2jvlwnTnu6VoDE/7HS6iixjeM6b2sS0ZtSzQyE7OYYrmf0YS2
         SxdtsiuvQFF5WTJ3ASbJsOPnXRuhQYY6j70WPaaXTXlk8Oa4WIIklSo1/NfokvMJnnT6
         7hiry4IwJgOk8Bb3A57L0dQkoOmefNZMxLOllziYbGv0NUnUbvRQl8w/jdWWt0B8GTYh
         fE5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=ouy9EuLfvfLxerqmfmzyViveD/DuvjNYljoQC00wHrM=;
        b=iFDCjHEGKju8GEZsxlObNCIeeKuAkRa+F+H40ZHFFhyemZUUYgPyiNkc0VZv2FiE0s
         NgjZrJnShasA4qdY5dpyaQ0mDgOa9ufboWnbKIzI4IOH2ybLkKMA9DSiw1ELJTRUyxKg
         ik8VcFVV2tbRLcPe0Erl/x+56rvXp+2lDHPe9qwLfxc/V/nY6gB8zM3AtWHmKfjeFFkw
         qZeYqVqXOzItcdamrvMEnbb6vkRhXClHP9Rj+qUrLDHjvhw7Y5KcL68raFW+MuwfHqcy
         ZdmXCf+I+QO/iY39vPCb2qhWojYUcaCNdo3pxg6B/+eEfaeMyYO5JcZhq4WjPHhbS1YA
         7dSg==
X-Gm-Message-State: APjAAAUAgaHodIuz8iv7mx6UssxMe41RnKNRDIfTL8mzjMMaBMmcZpCF
        W5qQfrAQeMMX5VUt2hhyffw=
X-Google-Smtp-Source: APXvYqzZODPLbDZ28YxI5+MYcO7zs2SV1rlUywwbGikuQrkJ76en3RQ9F1SyrgrJuqVJ6vM6cRJaDw==
X-Received: by 2002:a17:902:6b44:: with SMTP id g4mr58311493plt.35.1560222037807;
        Mon, 10 Jun 2019 20:00:37 -0700 (PDT)
Received: from hari-Inspiron-1545 ([183.83.89.153])
        by smtp.gmail.com with ESMTPSA id k16sm11827807pfa.87.2019.06.10.20.00.36
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 10 Jun 2019 20:00:37 -0700 (PDT)
Date:   Tue, 11 Jun 2019 08:30:33 +0530
From:   Hariprasad Kelam <hariprasad.kelam@gmail.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Hariprasad Kelam <hariprasad.kelam@gmail.com>,
        devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org
Subject: [PATCH 2/2] rtl8723bs: os_dep: fix spaces preferred around unary
 operator
Message-ID: <20190611030033.GA26062@hari-Inspiron-1545>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

CHECK: spaces preferred around that '|' (ctx:VxV)
CHECK: spaces preferred around that '|' (ctx:VxV)
CHECK: spaces preferred around that '+' (ctx:VxV)

Signed-off-by: Hariprasad Kelam <hariprasad.kelam@gmail.com>
---
 drivers/staging/rtl8723bs/os_dep/rtw_proc.c | 24 ++++++++++++------------
 1 file changed, 12 insertions(+), 12 deletions(-)

diff --git a/drivers/staging/rtl8723bs/os_dep/rtw_proc.c b/drivers/staging/rtl8723bs/os_dep/rtw_proc.c
index d6862e8..16ada19 100644
--- a/drivers/staging/rtl8723bs/os_dep/rtw_proc.c
+++ b/drivers/staging/rtl8723bs/os_dep/rtw_proc.c
@@ -21,7 +21,7 @@ inline struct proc_dir_entry *rtw_proc_create_dir(const char *name, struct proc_
 {
 	struct proc_dir_entry *entry;
 
-	entry = proc_mkdir_data(name, S_IRUGO|S_IXUGO, parent, data);
+	entry = proc_mkdir_data(name, S_IRUGO | S_IXUGO, parent, data);
 
 	return entry;
 }
@@ -31,7 +31,7 @@ inline struct proc_dir_entry *rtw_proc_create_entry(const char *name, struct pro
 {
 	struct proc_dir_entry *entry;
 
-	entry = proc_create_data(name,  S_IFREG|S_IRUGO, parent, fops, data);
+	entry = proc_create_data(name,  S_IFREG | S_IRUGO, parent, fops, data);
 
 	return entry;
 }
@@ -90,7 +90,7 @@ static int rtw_drv_proc_open(struct inode *inode, struct file *file)
 {
 	/* struct net_device *dev = proc_get_parent_data(inode); */
 	ssize_t index = (ssize_t)PDE_DATA(inode);
-	const struct rtw_proc_hdl *hdl = drv_proc_hdls+index;
+	const struct rtw_proc_hdl *hdl = drv_proc_hdls + index;
 
 	return single_open(file, hdl->show, NULL);
 }
@@ -98,7 +98,7 @@ static int rtw_drv_proc_open(struct inode *inode, struct file *file)
 static ssize_t rtw_drv_proc_write(struct file *file, const char __user *buffer, size_t count, loff_t *pos)
 {
 	ssize_t index = (ssize_t)PDE_DATA(file_inode(file));
-	const struct rtw_proc_hdl *hdl = drv_proc_hdls+index;
+	const struct rtw_proc_hdl *hdl = drv_proc_hdls + index;
 	ssize_t (*write)(struct file *, const char __user *, size_t, loff_t *, void *) = hdl->write;
 
 	if (write)
@@ -207,7 +207,7 @@ static int proc_get_linked_info_dump(struct seq_file *m, void *v)
 	struct adapter *padapter = (struct adapter *)rtw_netdev_priv(dev);
 
 	if (padapter)
-		DBG_871X_SEL_NL(m, "linked_info_dump :%s\n", (padapter->bLinkInfoDump)?"enable":"disable");
+		DBG_871X_SEL_NL(m, "linked_info_dump :%s\n", (padapter->bLinkInfoDump) ? "enable" : "disable");
 
 	return 0;
 }
@@ -245,7 +245,7 @@ static int proc_get_rx_info(struct seq_file *m, void *v)
 	struct debug_priv *pdbgpriv = &psdpriv->drv_dbg;
 
 	/* Counts of packets whose seq_num is less than preorder_ctrl->indicate_seq, Ex delay, retransmission, redundant packets and so on */
-	DBG_871X_SEL_NL(m,"Counts of Packets Whose Seq_Num Less Than Reorder Control Seq_Num: %llu\n", (unsigned long long)pdbgpriv->dbg_rx_ampdu_drop_count);
+	DBG_871X_SEL_NL(m, "Counts of Packets Whose Seq_Num Less Than Reorder Control Seq_Num: %llu\n", (unsigned long long)pdbgpriv->dbg_rx_ampdu_drop_count);
 	/* How many times the Rx Reorder Timer is triggered. */
 	DBG_871X_SEL_NL(m,"Rx Reorder Time-out Trigger Counts: %llu\n", (unsigned long long)pdbgpriv->dbg_rx_ampdu_forced_indicate_count);
 	/* Total counts of packets loss */
@@ -341,8 +341,8 @@ static int proc_get_cam_cache(struct seq_file *m, void *v)
 				, dvobj->cam_cache[i].ctrl
 				, MAC_ARG(dvobj->cam_cache[i].mac)
 				, KEY_ARG(dvobj->cam_cache[i].key)
-				, (dvobj->cam_cache[i].ctrl)&0x03
-				, security_type_str(((dvobj->cam_cache[i].ctrl)>>2)&0x07)
+				, (dvobj->cam_cache[i].ctrl) & 0x03
+				, security_type_str(((dvobj->cam_cache[i].ctrl) >> 2) & 0x07)
 				/*  ((dvobj->cam_cache[i].ctrl)>>5)&0x01 */
 				/*  ((dvobj->cam_cache[i].ctrl)>>6)&0x01 */
 				/*  ((dvobj->cam_cache[i].ctrl)>>8)&0x7f */
@@ -421,7 +421,7 @@ static const int adapter_proc_hdls_num = sizeof(adapter_proc_hdls) / sizeof(stru
 static int rtw_adapter_proc_open(struct inode *inode, struct file *file)
 {
 	ssize_t index = (ssize_t)PDE_DATA(inode);
-	const struct rtw_proc_hdl *hdl = adapter_proc_hdls+index;
+	const struct rtw_proc_hdl *hdl = adapter_proc_hdls + index;
 
 	return single_open(file, hdl->show, proc_get_parent_data(inode));
 }
@@ -429,7 +429,7 @@ static int rtw_adapter_proc_open(struct inode *inode, struct file *file)
 static ssize_t rtw_adapter_proc_write(struct file *file, const char __user *buffer, size_t count, loff_t *pos)
 {
 	ssize_t index = (ssize_t)PDE_DATA(file_inode(file));
-	const struct rtw_proc_hdl *hdl = adapter_proc_hdls+index;
+	const struct rtw_proc_hdl *hdl = adapter_proc_hdls + index;
 	ssize_t (*write)(struct file *, const char __user *, size_t, loff_t *, void *) = hdl->write;
 
 	if (write)
@@ -604,7 +604,7 @@ static const int odm_proc_hdls_num = sizeof(odm_proc_hdls) / sizeof(struct rtw_p
 static int rtw_odm_proc_open(struct inode *inode, struct file *file)
 {
 	ssize_t index = (ssize_t)PDE_DATA(inode);
-	const struct rtw_proc_hdl *hdl = odm_proc_hdls+index;
+	const struct rtw_proc_hdl *hdl = odm_proc_hdls + index;
 
 	return single_open(file, hdl->show, proc_get_parent_data(inode));
 }
@@ -612,7 +612,7 @@ static int rtw_odm_proc_open(struct inode *inode, struct file *file)
 static ssize_t rtw_odm_proc_write(struct file *file, const char __user *buffer, size_t count, loff_t *pos)
 {
 	ssize_t index = (ssize_t)PDE_DATA(file_inode(file));
-	const struct rtw_proc_hdl *hdl = odm_proc_hdls+index;
+	const struct rtw_proc_hdl *hdl = odm_proc_hdls + index;
 	ssize_t (*write)(struct file *, const char __user *, size_t, loff_t *, void *) = hdl->write;
 
 	if (write)
-- 
2.7.4

