Return-Path: <SRS0=i7el=ZO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3ED22C432C0
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Nov 2019 10:37:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1278020707
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Nov 2019 10:37:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1574419058;
	bh=oFxvNZ1hbHppCSTLDNl26gqmoZhX77aU+CZX6kpqLm4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=j30x073BuLpi5kFW76vOUJG5mMQ8NaaKXQse/xyhH2QuBE2XGjvg/Sw4u/+R/cZrZ
	 U5sDGA4z955qmDC4FEE3IeboMKqCfMSOZ73sUfOa4mDPuit0KvnPdV9cVwCu4sKLuo
	 HgZAitDREquHGzg4NZsm9C5zv3i4/UW3cax5CgX0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728556AbfKVKhg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Nov 2019 05:37:36 -0500
Received: from mail.kernel.org ([198.145.29.99]:39230 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728051AbfKVKhe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Nov 2019 05:37:34 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 03C0B20656;
        Fri, 22 Nov 2019 10:37:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1574419053;
        bh=oFxvNZ1hbHppCSTLDNl26gqmoZhX77aU+CZX6kpqLm4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=bqwrzfoeywLDr6vGU4HGMVXYFn1lVgxJEoy1gEoh1HgKcvOJb6Ncb/9SYVUdEbb19
         aaZO178d7XT56QZ4DxaRXkm47jpB0xgS6H3H9E1lYaMu/66vyw3QeQIsEvhWsVCcqo
         9uIXPr8YyoGmmX5FMlZJQmI5R7aW5bjfcbV2HD4E=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        =?UTF-8?q?Ronald=20Tschal=C3=83=C2=A4r?= <ronald@innovation.ch>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.4 141/159] ACPI / SBS: Fix rare oops when removing modules
Date:   Fri, 22 Nov 2019 11:28:52 +0100
Message-Id: <20191122100837.536104092@linuxfoundation.org>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <20191122100704.194776704@linuxfoundation.org>
References: <20191122100704.194776704@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Ronald Tschalär <ronald@innovation.ch>

[ Upstream commit 757c968c442397f1249bb775a7c8c03842e3e0c7 ]

There was a small race when removing the sbshc module where
smbus_alarm() had queued acpi_smbus_callback() for deferred execution
but it hadn't been run yet, so that when it did run hc had been freed
and the module unloaded, resulting in an invalid paging request.

A similar race existed when removing the sbs module with regards to
acpi_sbs_callback() (which is called from acpi_smbus_callback()).

We therefore need to ensure no callbacks are pending or executing before
the cleanups are done and the modules are removed.

Signed-off-by: Ronald TschalÃ¤r <ronald@innovation.ch>
Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/acpi/osl.c   | 1 +
 drivers/acpi/sbshc.c | 2 ++
 2 files changed, 3 insertions(+)

diff --git a/drivers/acpi/osl.c b/drivers/acpi/osl.c
index a000ecb995e66..e59f50576f2ae 100644
--- a/drivers/acpi/osl.c
+++ b/drivers/acpi/osl.c
@@ -1186,6 +1186,7 @@ void acpi_os_wait_events_complete(void)
 	flush_workqueue(kacpid_wq);
 	flush_workqueue(kacpi_notify_wq);
 }
+EXPORT_SYMBOL(acpi_os_wait_events_complete);
 
 struct acpi_hp_work {
 	struct work_struct work;
diff --git a/drivers/acpi/sbshc.c b/drivers/acpi/sbshc.c
index 7a3431018e0ab..5008ead4609a4 100644
--- a/drivers/acpi/sbshc.c
+++ b/drivers/acpi/sbshc.c
@@ -196,6 +196,7 @@ int acpi_smbus_unregister_callback(struct acpi_smb_hc *hc)
 	hc->callback = NULL;
 	hc->context = NULL;
 	mutex_unlock(&hc->lock);
+	acpi_os_wait_events_complete();
 	return 0;
 }
 
@@ -292,6 +293,7 @@ static int acpi_smbus_hc_remove(struct acpi_device *device)
 
 	hc = acpi_driver_data(device);
 	acpi_ec_remove_query_handler(hc->ec, hc->query_bit);
+	acpi_os_wait_events_complete();
 	kfree(hc);
 	device->driver_data = NULL;
 	return 0;
-- 
2.20.1



