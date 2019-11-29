Return-Path: <SRS0=nTU8=ZV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 75B65C432C3
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Nov 2019 15:16:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 53C7421736
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Nov 2019 15:16:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727113AbfK2PQq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 29 Nov 2019 10:16:46 -0500
Received: from szxga05-in.huawei.com ([45.249.212.191]:6731 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726893AbfK2PQq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Nov 2019 10:16:46 -0500
Received: from DGGEMS407-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id B472BE844DF322A3F3BB;
        Fri, 29 Nov 2019 23:16:42 +0800 (CST)
Received: from [127.0.0.1] (10.133.217.137) by DGGEMS407-HUB.china.huawei.com
 (10.3.19.207) with Microsoft SMTP Server id 14.3.439.0; Fri, 29 Nov 2019
 23:16:39 +0800
Subject: Re: [PATCH next 0/3] debugfs: introduce
 debugfs_create_single/seq[,_data]
To:     Greg KH <gregkh@linuxfoundation.org>
CC:     <linux-kernel@vger.kernel.org>
References: <20191129092752.169902-1-wangkefeng.wang@huawei.com>
 <20191129142110.GA3708031@kroah.com>
From:   Kefeng Wang <wangkefeng.wang@huawei.com>
Message-ID: <cc0e5624-273f-a990-87ee-4a9c3d8db4da@huawei.com>
Date:   Fri, 29 Nov 2019 23:16:38 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <20191129142110.GA3708031@kroah.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.133.217.137]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2019/11/29 22:21, Greg KH wrote:
> On Fri, Nov 29, 2019 at 05:27:49PM +0800, Kefeng Wang wrote:
>> Like proc_create_single/seq[,_data] in procfs, we could provide similar debugfs
>> helper to reduce losts of boilerplate code.
>>
>> debugfs_create_single[,_data]
>>   creates a file in debugfs with the extra data and a seq_file show callback.
>> debugfs_create_seq[,_data]
>>   creates a file in debugfs with the extra data and a seq_operations.
>>
>> There is a object dynamically allocated in the helper, which is used to store
>> extra data, we need free it when remove the debugfs file.
>>
>> If the change is acceptable, we could change the caller one by one.
> 
> I would like to see a user of this and how you would convert it, in
> order to see if this is worth it or not.

I have some diff patches, the conversion is in progress. current statistics
are as follows,

1) debugfs: switch to debugfs_create_seq[,_data]
19 files changed, 85 insertions(+), 620 deletions(-)
2) debugfs: switch to debugfs_create_single[,_data]
70 files changed, 249 insertions(+), 1482 deletions(-)

Here are some examples,
1) debugfs_create_seq
diff --git a/mm/vmstat.c b/mm/vmstat.c
index 78d53378db99..62c26772f24c 100644
--- a/mm/vmstat.c
+++ b/mm/vmstat.c
@@ -2057,18 +2057,6 @@ static const struct seq_operations unusable_op = {
 	.show	= unusable_show,
 };

-static int unusable_open(struct inode *inode, struct file *file)
-{
-	return seq_open(file, &unusable_op);
-}
-
-static const struct file_operations unusable_file_ops = {
-	.open		= unusable_open,
-	.read		= seq_read,
-	.llseek		= seq_lseek,
-	.release	= seq_release,
-};
-
 static void extfrag_show_print(struct seq_file *m,
 					pg_data_t *pgdat, struct zone *zone)
 {
@@ -2109,29 +2097,17 @@ static const struct seq_operations extfrag_op = {
 	.show	= extfrag_show,
 };

-static int extfrag_open(struct inode *inode, struct file *file)
-{
-	return seq_open(file, &extfrag_op);
-}
-
-static const struct file_operations extfrag_file_ops = {
-	.open		= extfrag_open,
-	.read		= seq_read,
-	.llseek		= seq_lseek,
-	.release	= seq_release,
-};
-
 static int __init extfrag_debug_init(void)
 {
 	struct dentry *extfrag_debug_root;

 	extfrag_debug_root = debugfs_create_dir("extfrag", NULL);

-	debugfs_create_file("unusable_index", 0444, extfrag_debug_root, NULL,
-			    &unusable_file_ops);
+	debugfs_create_seq("unusable_index", 0444, extfrag_debug_root,
+			   &unusable_op);

-	debugfs_create_file("extfrag_index", 0444, extfrag_debug_root, NULL,
-			    &extfrag_file_ops);
+	debugfs_create_seq("extfrag_index", 0444, extfrag_debug_root,
+			   &extfrag_op);

 	return 0;
 }

2) debugfs_create_single_data()
diff --git a/net/hsr/hsr_debugfs.c b/net/hsr/hsr_debugfs.c
index 94447974a3c0..8bdd70af02c9 100644
--- a/net/hsr/hsr_debugfs.c
+++ b/net/hsr/hsr_debugfs.c
@@ -52,25 +52,6 @@ hsr_node_table_show(struct seq_file *sfp, void *data)
 	return 0;
 }

-/* hsr_node_table_open - Open the node_table file
- *
- * Description:
- * This routine opens a debugfs file node_table of specific hsr device
- */
-static int
-hsr_node_table_open(struct inode *inode, struct file *filp)
-{
-	return single_open(filp, hsr_node_table_show, inode->i_private);
-}
-
-static const struct file_operations hsr_fops = {
-	.owner	= THIS_MODULE,
-	.open	= hsr_node_table_open,
-	.read	= seq_read,
-	.llseek = seq_lseek,
-	.release = single_release,
-};
-
 /* hsr_debugfs_init - create hsr node_table file for dumping
  * the node table
  *
@@ -91,9 +72,9 @@ int hsr_debugfs_init(struct hsr_priv *priv, struct net_device *hsr_dev)

 	priv->node_tbl_root = de;

-	de = debugfs_create_file("node_table", S_IFREG | 0444,
-				 priv->node_tbl_root, priv,
-				 &hsr_fops);
+	de = debugfs_create_single_data("node_table", S_IFREG | 0444,
+					priv->node_tbl_root, priv,
+					hsr_node_table_show);
 	if (!de) {
 		pr_err("Cannot create hsr node_table directory\n");
 		return rc;
-- 
2.20.1


> 
> When you redo this series, can you add that to the end of it?
> 
> thanks,
> 
> greg k-h
> 
> .
> 

