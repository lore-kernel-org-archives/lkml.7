Return-Path: <SRS0=L2S5=S2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 28CAEC282CE
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 17:32:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ECECE2077C
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 17:32:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1556127153;
	bh=wgJNo1HLswB0+jUZQAbDWhAm72emEwoJnxKZva+VcYM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=o10r2qsAlxkbaF0qgmo5HZyzHlZy3XbTr+0KodCMcomRz/Ia3wNx9SCO5RsQ6Ejop
	 jPxNw/TzPQBEMTGVip81wP2BkN3ehKD3A68JSA/d0ld6Tlx1dFfYbsBu8R1a/ZrCbZ
	 fSRl+fNpLlW+DiEltiHUi7ldonRBMB9uRVdhq570=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391353AbfDXRcc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Apr 2019 13:32:32 -0400
Received: from mail.kernel.org ([198.145.29.99]:59122 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2391338AbfDXRc2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Apr 2019 13:32:28 -0400
Received: from localhost (62-193-50-229.as16211.net [62.193.50.229])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 46EDF2054F;
        Wed, 24 Apr 2019 17:32:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1556127147;
        bh=wgJNo1HLswB0+jUZQAbDWhAm72emEwoJnxKZva+VcYM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=TjErBdDidwUNFNkG1v3F0jtJk/vXIa//lFqZkZL9Eui+/T+Z8KWtrXffe5VLVkoVY
         OVDnZo4LddMB5u+PA/GBe3p7eYpHeYwsXWVn+qSv4FPJcmkjlgZhC9zouCNO138TWy
         SwbaYCUY1YfSg5mQOnnZAU3n43WdzbXCd55NAYHk=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Erwin Tsaur <erwin.tsaur@oracle.com>,
        Toshi Kani <toshi.kani@hpe.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.19 79/96] nfit/ars: Allow root to busy-poll the ARS state machine
Date:   Wed, 24 Apr 2019 19:10:24 +0200
Message-Id: <20190424170925.157614402@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190424170919.829037226@linuxfoundation.org>
References: <20190424170919.829037226@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

commit 5479b2757f26fe9908fc341d105b2097fe820b6f upstream.

The ARS implementation implements exponential back-off on the poll
interval to prevent high-frequency access to the DIMM / platform
interface. Depending on when the ARS completes the poll interval may
exceed the completion event by minutes. Allow root to reset the timeout
each time it probes the status. A one-second timeout is still enforced,
but root can otherwise can control the poll interval.

Fixes: bc6ba8085842 ("nfit, address-range-scrub: rework and simplify ARS...")
Cc: <stable@vger.kernel.org>
Reported-by: Erwin Tsaur <erwin.tsaur@oracle.com>
Reviewed-by: Toshi Kani <toshi.kani@hpe.com>
Signed-off-by: Dan Williams <dan.j.williams@intel.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/acpi/nfit/core.c | 8 ++++++++
 drivers/acpi/nfit/nfit.h | 1 +
 2 files changed, 9 insertions(+)

diff --git a/drivers/acpi/nfit/core.c b/drivers/acpi/nfit/core.c
index 6b5a3c3b4458..4b489d14a680 100644
--- a/drivers/acpi/nfit/core.c
+++ b/drivers/acpi/nfit/core.c
@@ -1314,6 +1314,13 @@ static ssize_t scrub_show(struct device *dev,
 	busy = test_bit(ARS_BUSY, &acpi_desc->scrub_flags)
 		&& !test_bit(ARS_CANCEL, &acpi_desc->scrub_flags);
 	rc = sprintf(buf, "%d%s", acpi_desc->scrub_count, busy ? "+\n" : "\n");
+	/* Allow an admin to poll the busy state at a higher rate */
+	if (busy && capable(CAP_SYS_RAWIO) && !test_and_set_bit(ARS_POLL,
+				&acpi_desc->scrub_flags)) {
+		acpi_desc->scrub_tmo = 1;
+		mod_delayed_work(nfit_wq, &acpi_desc->dwork, HZ);
+	}
+
 	mutex_unlock(&acpi_desc->init_mutex);
 	device_unlock(dev);
 	return rc;
@@ -3075,6 +3082,7 @@ static void acpi_nfit_scrub(struct work_struct *work)
 	else
 		notify_ars_done(acpi_desc);
 	memset(acpi_desc->ars_status, 0, acpi_desc->max_ars);
+	clear_bit(ARS_POLL, &acpi_desc->scrub_flags);
 	mutex_unlock(&acpi_desc->init_mutex);
 }
 
diff --git a/drivers/acpi/nfit/nfit.h b/drivers/acpi/nfit/nfit.h
index 94710e579598..b5fd3522abc7 100644
--- a/drivers/acpi/nfit/nfit.h
+++ b/drivers/acpi/nfit/nfit.h
@@ -184,6 +184,7 @@ struct nfit_mem {
 enum scrub_flags {
 	ARS_BUSY,
 	ARS_CANCEL,
+	ARS_POLL,
 };
 
 struct acpi_nfit_desc {
-- 
2.19.1



