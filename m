Return-Path: <SRS0=i7el=ZO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0E5CEC432C0
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Nov 2019 11:14:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D66F92070E
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Nov 2019 11:14:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1574421278;
	bh=h/qoJpUfQOrBJEA7qGpILdqu+csxqNFYDokiCl2xkys=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=wlL9Xii08AeypNQviCjq0zoD4AQ8gk/suZo9+nOoKk+FoM8n4zg8JAvBOuhMMK8ei
	 t90Y4q+8ftQvKTNY7DLfH9iscuOMK2ZM628OCfHbUF424Uiq95gWdlG7YXtJQMqy9e
	 wjrUxaC+rdh7kQY47Rjo8U5wl8PmqZu0j92+RSPw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730611AbfKVLOi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Nov 2019 06:14:38 -0500
Received: from mail.kernel.org ([198.145.29.99]:38108 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728271AbfKVKxb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Nov 2019 05:53:31 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id CDDF320656;
        Fri, 22 Nov 2019 10:53:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1574420009;
        bh=h/qoJpUfQOrBJEA7qGpILdqu+csxqNFYDokiCl2xkys=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Q7l5Mty4bqUGq495AB4vAik+k2QUXgOSLa5qEzb3IC9BkeiDF+hD5aoqkeGE7e2/l
         j/3y0XlEpHNBGpGZvo6mYzkdBUTVPufzOLS7fYRkAfwXcv21B7Iglqi17dfFCMhaby
         nvMNAnvOswg/ia+blOOH8rk+OsRM6X/J2WSAtb8Y=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        =?UTF-8?q?Ronald=20Tschal=C3=83=C2=A4r?= <ronald@innovation.ch>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.14 085/122] ACPI / SBS: Fix rare oops when removing modules
Date:   Fri, 22 Nov 2019 11:28:58 +0100
Message-Id: <20191122100824.823949891@linuxfoundation.org>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <20191122100722.177052205@linuxfoundation.org>
References: <20191122100722.177052205@linuxfoundation.org>
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
index 191e86c62037a..9da7e7d874bd8 100644
--- a/drivers/acpi/osl.c
+++ b/drivers/acpi/osl.c
@@ -1116,6 +1116,7 @@ void acpi_os_wait_events_complete(void)
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



