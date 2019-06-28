Return-Path: <SRS0=E/6H=U3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 160F9C4321A
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Jun 2019 12:32:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E12902133F
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Jun 2019 12:32:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727565AbfF1Mcr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 28 Jun 2019 08:32:47 -0400
Received: from szxga07-in.huawei.com ([45.249.212.35]:50524 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727547AbfF1Mcn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Jun 2019 08:32:43 -0400
Received: from DGGEMS405-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id B7F03154982ED060E283;
        Fri, 28 Jun 2019 20:32:40 +0800 (CST)
Received: from [127.0.0.1] (10.184.225.177) by DGGEMS405-HUB.china.huawei.com
 (10.3.19.205) with Microsoft SMTP Server id 14.3.439.0; Fri, 28 Jun 2019
 20:32:33 +0800
To:     <jeyu@kernel.org>, <rusty@rustcorp.com.au>, <kay.sievers@vrfy.org>,
        <clabbe.montjoie@gmail.com>
CC:     <linux-kernel@vger.kernel.org>,
        "wangxiaogang (F)" <wangxiaogang3@huawei.com>,
        "Zhoukang (A)" <zhoukang7@huawei.com>,
        Mingfangsen <mingfangsen@huawei.com>
From:   Zhiqiang Liu <liuzhiqiang26@huawei.com>
Subject: [PATCH] module: add usage links when calling ref_module func
Message-ID: <8d7aa8b1-73a2-db7a-82c8-06917eddf235@huawei.com>
Date:   Fri, 28 Jun 2019 20:32:18 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.0
MIME-Version: 1.0
Content-Type: text/plain; charset="gb18030"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.184.225.177]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Zhiqiang Liu <liuzhiqiang26@huawei.com>

Problem: Users can call ref_module func in their modules to construct
relationships with other modules. However, the holders
'/sys/module/<mod-name>/holders' of the target module donot include
the users` module. So lsmod command misses detailed info of 'Used by'.

When load module, the process is given as follows,
load_module()
	-> mod_sysfs_setup()
		-> add_usage_links
	-> do_init_module
		-> mod->init()

add_usage_links func creates holders of target modules linking to
this module. If ref_module is called in mod->init() func, the usage
links cannot be added.

Here, we will add usage link of a to b's holder_dir.

Fixes: 9bea7f239 ("module: fix bne2 "gave up waiting for init of module libcrc32c")
Signed-off-by: Zhiqiang Liu <liuzhiqiang26@huawei.com>
---
 kernel/module.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/kernel/module.c b/kernel/module.c
index 80c7c09584cf..11c6aff37b1f 100644
--- a/kernel/module.c
+++ b/kernel/module.c
@@ -871,6 +871,11 @@ int ref_module(struct module *a, struct module *b)
 		module_put(b);
 		return err;
 	}
+
+	err = sysfs_create_link(b->holders_dir, &a->mkobj.kobj, a->name);
+	if (err)
+		return err;
+
 	return 0;
 }
 EXPORT_SYMBOL_GPL(ref_module);
-- 
2.19.1

