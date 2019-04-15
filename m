Return-Path: <SRS0=rNeM=SR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C5AD8C10F0E
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Apr 2019 19:17:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 93F862073F
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Apr 2019 19:17:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1555355871;
	bh=2+KnyX2t/iFfamUdZsdmEI/4ufLoDglksusPnBnZhJg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=Lik0e7uQ5Qv6PC8b6OkdldWYzh0pqh1i+PYZDvpnD+Di93w9FQPEMi/WkugxwucxT
	 ZV07qiG0t87L7tMkp9gqoUP2RB4pklfJaZckrw9HQdhabzfESc6JT8yQzTVY8yiRLf
	 poiSj8atKWg1Q/tkPvEvv1IIq1xxML5SJH2oUY4E=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731718AbfDOTRu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 15 Apr 2019 15:17:50 -0400
Received: from mail.kernel.org ([198.145.29.99]:49148 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731318AbfDOTL6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Apr 2019 15:11:58 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2652321908;
        Mon, 15 Apr 2019 19:11:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1555355517;
        bh=2+KnyX2t/iFfamUdZsdmEI/4ufLoDglksusPnBnZhJg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=TVBlA+4iFQAEicuw79qfw5sjm/XjLE96bzLP1k6xAI4ZDOTbuKliCmqY+p4NleHzu
         vGs7RlxguWAxougscjSkBltk/phLlcv6OkavWjTJXyNMS570ap0Rd2UMSfhVdPQVVI
         e4aVJQ8XO3oZ4pacic6vtYkaKQoIn10ElZe2XI8w=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Furquan Shaikh <furquan@google.com>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>
Subject: [PATCH 5.0 051/117] ACPICA: Clear status of GPEs before enabling them
Date:   Mon, 15 Apr 2019 21:00:21 +0200
Message-Id: <20190415183747.563797571@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190415183744.887851196@linuxfoundation.org>
References: <20190415183744.887851196@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Furquan Shaikh <furquan@google.com>

commit c8b1917c8987a6fa3695d479b4d60fbbbc3e537b upstream.

Commit 18996f2db918 ("ACPICA: Events: Stop unconditionally clearing
ACPI IRQs during suspend/resume") was added to stop clearing event
status bits unconditionally in the system-wide suspend and resume
paths. This was done because of an issue with a laptop lid appaering
to be closed even when it was used to wake up the system from suspend
(see https://bugzilla.kernel.org/show_bug.cgi?id=196249), which
happened because event status bits were cleared unconditionally on
system resume. Though this change fixed the issue in the resume path,
it introduced regressions in a few suspend paths.

First regression was reported and fixed in the S5 entry path by commit
fa85015c0d95 ("ACPICA: Clear status of all events when entering S5").
Next regression was reported and fixed for all legacy sleep paths by
commit f317c7dc12b7 ("ACPICA: Clear status of all events when entering
sleep states").  However, there still is a suspend-to-idle regression,
since suspend-to-idle does not follow the legacy sleep paths.

In the suspend-to-idle case, wakeup is enabled as part of device
suspend.  If the status bits of wakeup GPEs are set when they are
enabled, it causes a premature system wakeup to occur.

To address that problem, partially revert commit 18996f2db918 to
restore GPE status bits clearing before the GPE is enabled in
acpi_ev_enable_gpe().

Fixes: 18996f2db918 ("ACPICA: Events: Stop unconditionally clearing ACPI IRQs during suspend/resume")
Signed-off-by: Furquan Shaikh <furquan@google.com>
Cc: 4.17+ <stable@vger.kernel.org> # 4.17+
[ rjw: Subject & changelog ]
Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/acpi/acpica/evgpe.c |    6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

--- a/drivers/acpi/acpica/evgpe.c
+++ b/drivers/acpi/acpica/evgpe.c
@@ -81,8 +81,12 @@ acpi_status acpi_ev_enable_gpe(struct ac
 
 	ACPI_FUNCTION_TRACE(ev_enable_gpe);
 
-	/* Enable the requested GPE */
+	/* Clear the GPE status */
+	status = acpi_hw_clear_gpe(gpe_event_info);
+	if (ACPI_FAILURE(status))
+		return_ACPI_STATUS(status);
 
+	/* Enable the requested GPE */
 	status = acpi_hw_low_set_gpe(gpe_event_info, ACPI_GPE_ENABLE);
 	return_ACPI_STATUS(status);
 }


