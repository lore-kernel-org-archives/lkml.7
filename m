Return-Path: <SRS0=L2S5=S2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 956ABC10F11
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 17:39:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6383C20675
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 17:39:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1556127583;
	bh=ODyhJmbxpgUJ145tAlfCi8sB6HYJBxFgx8TPVbHkWa8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=aneaHgtvKIHpvzRJNWg7wY4dFxx8g8UT9cBjHx4WqU0hqxKm6IILkyi7LlapSmBee
	 rp5S4FWGhHhlPZVVqiqDgFvH0+59TqIckZV32URR62ADouE/CVnh0oA+88/CvTVDz7
	 lDXjmAB7lWvVaC4ZnCD0xcGaQ7PndmklWckvrxJ8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392012AbfDXRhw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Apr 2019 13:37:52 -0400
Received: from mail.kernel.org ([198.145.29.99]:36826 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2392264AbfDXRhr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Apr 2019 13:37:47 -0400
Received: from localhost (62-193-50-229.as16211.net [62.193.50.229])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6D8C32054F;
        Wed, 24 Apr 2019 17:37:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1556127465;
        bh=ODyhJmbxpgUJ145tAlfCi8sB6HYJBxFgx8TPVbHkWa8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Mh65q8I0+YP0ttAmgXBM533onXP2dMwbmnVMlK8YRV4tdgjKqarjBpJECw8sqHRsN
         1YqOmeHhU+fKSE1V+8NpkaauSM9qXwDombjeMy9Yiu1aQFZn31ltEAG61N67DRSmcw
         oC+b9gPLMjCHHpZ7q4RGUWxnL98cmyDl6nrthYdQ=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Toshi Kani <toshi.kani@hpe.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.0 101/115] nfit/ars: Introduce scrub_flags
Date:   Wed, 24 Apr 2019 19:10:37 +0200
Message-Id: <20190424170930.666255693@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190424170924.797924502@linuxfoundation.org>
References: <20190424170924.797924502@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

commit e34b8252a3d2893ca55c82dbfcdaa302fa03d400 upstream.

In preparation for introducing new flags to gate whether ARS results are
stale, or poll the completion state, convert the existing flags to an
unsigned long with enumerated values. This conversion allows the flags
to be atomically updated outside of ->init_mutex.

Reviewed-by: Toshi Kani <toshi.kani@hpe.com>
Signed-off-by: Dan Williams <dan.j.williams@intel.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/acpi/nfit/core.c | 30 +++++++++++++++++-------------
 drivers/acpi/nfit/nfit.h |  8 ++++++--
 2 files changed, 23 insertions(+), 15 deletions(-)

diff --git a/drivers/acpi/nfit/core.c b/drivers/acpi/nfit/core.c
index 1a48c92eaed5..64308e669250 100644
--- a/drivers/acpi/nfit/core.c
+++ b/drivers/acpi/nfit/core.c
@@ -1319,19 +1319,23 @@ static ssize_t scrub_show(struct device *dev,
 		struct device_attribute *attr, char *buf)
 {
 	struct nvdimm_bus_descriptor *nd_desc;
+	struct acpi_nfit_desc *acpi_desc;
 	ssize_t rc = -ENXIO;
+	bool busy;
 
 	device_lock(dev);
 	nd_desc = dev_get_drvdata(dev);
-	if (nd_desc) {
-		struct acpi_nfit_desc *acpi_desc = to_acpi_desc(nd_desc);
-
-		mutex_lock(&acpi_desc->init_mutex);
-		rc = sprintf(buf, "%d%s", acpi_desc->scrub_count,
-				acpi_desc->scrub_busy
-				&& !acpi_desc->cancel ? "+\n" : "\n");
-		mutex_unlock(&acpi_desc->init_mutex);
+	if (!nd_desc) {
+		device_unlock(dev);
+		return rc;
 	}
+	acpi_desc = to_acpi_desc(nd_desc);
+
+	mutex_lock(&acpi_desc->init_mutex);
+	busy = test_bit(ARS_BUSY, &acpi_desc->scrub_flags)
+		&& !test_bit(ARS_CANCEL, &acpi_desc->scrub_flags);
+	rc = sprintf(buf, "%d%s", acpi_desc->scrub_count, busy ? "+\n" : "\n");
+	mutex_unlock(&acpi_desc->init_mutex);
 	device_unlock(dev);
 	return rc;
 }
@@ -3081,7 +3085,7 @@ static unsigned int __acpi_nfit_scrub(struct acpi_nfit_desc *acpi_desc,
 
 	lockdep_assert_held(&acpi_desc->init_mutex);
 
-	if (acpi_desc->cancel)
+	if (test_bit(ARS_CANCEL, &acpi_desc->scrub_flags))
 		return 0;
 
 	if (query_rc == -EBUSY) {
@@ -3155,7 +3159,7 @@ static void __sched_ars(struct acpi_nfit_desc *acpi_desc, unsigned int tmo)
 {
 	lockdep_assert_held(&acpi_desc->init_mutex);
 
-	acpi_desc->scrub_busy = 1;
+	set_bit(ARS_BUSY, &acpi_desc->scrub_flags);
 	/* note this should only be set from within the workqueue */
 	if (tmo)
 		acpi_desc->scrub_tmo = tmo;
@@ -3171,7 +3175,7 @@ static void notify_ars_done(struct acpi_nfit_desc *acpi_desc)
 {
 	lockdep_assert_held(&acpi_desc->init_mutex);
 
-	acpi_desc->scrub_busy = 0;
+	clear_bit(ARS_BUSY, &acpi_desc->scrub_flags);
 	acpi_desc->scrub_count++;
 	if (acpi_desc->scrub_count_state)
 		sysfs_notify_dirent(acpi_desc->scrub_count_state);
@@ -3460,7 +3464,7 @@ int acpi_nfit_ars_rescan(struct acpi_nfit_desc *acpi_desc,
 	struct nfit_spa *nfit_spa;
 
 	mutex_lock(&acpi_desc->init_mutex);
-	if (acpi_desc->cancel) {
+	if (test_bit(ARS_CANCEL, &acpi_desc->scrub_flags)) {
 		mutex_unlock(&acpi_desc->init_mutex);
 		return 0;
 	}
@@ -3539,7 +3543,7 @@ void acpi_nfit_shutdown(void *data)
 	mutex_unlock(&acpi_desc_lock);
 
 	mutex_lock(&acpi_desc->init_mutex);
-	acpi_desc->cancel = 1;
+	set_bit(ARS_CANCEL, &acpi_desc->scrub_flags);
 	cancel_delayed_work_sync(&acpi_desc->dwork);
 	mutex_unlock(&acpi_desc->init_mutex);
 
diff --git a/drivers/acpi/nfit/nfit.h b/drivers/acpi/nfit/nfit.h
index 871fb3de3b30..897ce10192a0 100644
--- a/drivers/acpi/nfit/nfit.h
+++ b/drivers/acpi/nfit/nfit.h
@@ -210,6 +210,11 @@ struct nfit_mem {
 	int family;
 };
 
+enum scrub_flags {
+	ARS_BUSY,
+	ARS_CANCEL,
+};
+
 struct acpi_nfit_desc {
 	struct nvdimm_bus_descriptor nd_desc;
 	struct acpi_table_header acpi_header;
@@ -231,8 +236,7 @@ struct acpi_nfit_desc {
 	unsigned int max_ars;
 	unsigned int scrub_count;
 	unsigned int scrub_mode;
-	unsigned int scrub_busy:1;
-	unsigned int cancel:1;
+	unsigned long scrub_flags;
 	unsigned long dimm_cmd_force_en;
 	unsigned long bus_cmd_force_en;
 	unsigned long bus_nfit_cmd_force_en;
-- 
2.19.1



