Return-Path: <SRS0=EIds=SH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7133CC10F00
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Apr 2019 14:12:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 401592184B
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Apr 2019 14:12:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731175AbfDEOMU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 5 Apr 2019 10:12:20 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:54368 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726594AbfDEOMU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Apr 2019 10:12:20 -0400
Received: from 1.general.cking.uk.vpn ([10.172.193.212] helo=localhost)
        by youngberry.canonical.com with esmtpsa (TLS1.0:RSA_AES_256_CBC_SHA1:32)
        (Exim 4.76)
        (envelope-from <colin.king@canonical.com>)
        id 1hCPZn-0002VU-RL; Fri, 05 Apr 2019 14:12:15 +0000
From:   Colin King <colin.king@canonical.com>
To:     "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Len Brown <lenb@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Keith Busch <keith.busch@intel.com>, linux-acpi@vger.kernel.org
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH][next] acpi/hmat: fix uninitialized pointer dereference on pointer 'target'
Date:   Fri,  5 Apr 2019 15:12:15 +0100
Message-Id: <20190405141215.2079-1-colin.king@canonical.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Colin Ian King <colin.king@canonical.com>

The pointer 'target' is not initialized and is only assigned when the
ACPI_HMAT_MEMORY_PD_VALID bit in p->flags is set.  There is a later null
check on target that leads to an uninitialized pointer read and
dereference when assigning target->processor_pxm when target contains a
non-null garbage value.  Fix this by initializing targer to null.

Fixes: 665ac7e92757 ("acpi/hmat: Register processor domain to its memory")
Addresses-Coverity: ("Uninitialized pointer read")
Signed-off-by: Colin Ian King <colin.king@canonical.com>
---
 drivers/acpi/hmat/hmat.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/acpi/hmat/hmat.c b/drivers/acpi/hmat/hmat.c
index b7824a0309f7..b275016ff648 100644
--- a/drivers/acpi/hmat/hmat.c
+++ b/drivers/acpi/hmat/hmat.c
@@ -366,7 +366,7 @@ static int __init hmat_parse_proximity_domain(union acpi_subtable_headers *heade
 					      const unsigned long end)
 {
 	struct acpi_hmat_proximity_domain *p = (void *)header;
-	struct memory_target *target;
+	struct memory_target *target = NULL;
 
 	if (p->header.length != sizeof(*p)) {
 		pr_notice("HMAT: Unexpected address range header length: %d\n",
-- 
2.20.1

