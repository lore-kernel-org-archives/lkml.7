Return-Path: <SRS0=eu/B=UE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DBE5AC28CC6
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Jun 2019 20:43:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BE4E72067C
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Jun 2019 20:43:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726849AbfFEUnZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Jun 2019 16:43:25 -0400
Received: from gateway36.websitewelcome.com ([192.185.184.18]:11927 "EHLO
        gateway36.websitewelcome.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726723AbfFEUnT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Jun 2019 16:43:19 -0400
X-Greylist: delayed 1372 seconds by postgrey-1.27 at vger.kernel.org; Wed, 05 Jun 2019 16:43:19 EDT
Received: from cm12.websitewelcome.com (cm12.websitewelcome.com [100.42.49.8])
        by gateway36.websitewelcome.com (Postfix) with ESMTP id 1B6BE400F3A02
        for <linux-kernel@vger.kernel.org>; Wed,  5 Jun 2019 14:41:20 -0500 (CDT)
Received: from gator4166.hostgator.com ([108.167.133.22])
        by cmsmtp with SMTP
        id YcOYhYv8biQerYcOYh83JT; Wed, 05 Jun 2019 15:20:26 -0500
X-Authority-Reason: nr=8
Received: from [189.250.127.120] (port=33986 helo=embeddedor)
        by gator4166.hostgator.com with esmtpa (Exim 4.91)
        (envelope-from <gustavo@embeddedor.com>)
        id 1hYcOW-003sAf-OK; Wed, 05 Jun 2019 15:20:25 -0500
Date:   Wed, 5 Jun 2019 15:20:24 -0500
From:   "Gustavo A. R. Silva" <gustavo@embeddedor.com>
To:     Robert Moore <robert.moore@intel.com>,
        Erik Schmauss <erik.schmauss@intel.com>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        Len Brown <lenb@kernel.org>
Cc:     linux-acpi@vger.kernel.org, devel@acpica.org,
        linux-kernel@vger.kernel.org,
        "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Subject: [PATCH] ACPICA: utids: Use struct_size() helper
Message-ID: <20190605202024.GA20848@embeddedor>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.9.4 (2018-02-28)
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - gator4166.hostgator.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - embeddedor.com
X-BWhitelist: no
X-Source-IP: 189.250.127.120
X-Source-L: No
X-Exim-ID: 1hYcOW-003sAf-OK
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: (embeddedor) [189.250.127.120]:33986
X-Source-Auth: gustavo@embeddedor.com
X-Email-Count: 11
X-Source-Cap: Z3V6aWRpbmU7Z3V6aWRpbmU7Z2F0b3I0MTY2Lmhvc3RnYXRvci5jb20=
X-Local-Domain: yes
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

One of the more common cases of allocation size calculations is finding
the size of a structure that has a zero-sized array at the end, along
with memory for some number of elements for that array. For example:

struct acpi_pnp_device_id_list {
	...
        struct acpi_pnp_device_id ids[1];       /* ID array */
};

Make use of the struct_size() helper instead of an open-coded version
in order to avoid any potential type mistakes.

So, replace the following form:

sizeof(struct acpi_pnp_device_id_list) + ((count - 1) * sizeof(struct acpi_pnp_device_id))

with:

struct_size(cid_list, ids, count - 1)

Signed-off-by: Gustavo A. R. Silva <gustavo@embeddedor.com>
---
Notice that checkpatch reports the following warning:

WARNING: line over 80 characters
#54: FILE: drivers/acpi/acpica/utids.c:265:
+	cid_list_size = struct_size(cid_list, ids, count - 1) + string_area_size;

The line above is 81-character long. So, I think we should be fine
with that, instead of split it into two lines.

Thanks

 Gustavo

 drivers/acpi/acpica/utids.c | 7 ++-----
 1 file changed, 2 insertions(+), 5 deletions(-)

diff --git a/drivers/acpi/acpica/utids.c b/drivers/acpi/acpica/utids.c
index e805abdd95b8..737aa6a8f362 100644
--- a/drivers/acpi/acpica/utids.c
+++ b/drivers/acpi/acpica/utids.c
@@ -202,7 +202,7 @@ acpi_ut_execute_CID(struct acpi_namespace_node *device_node,
 	char *next_id_string;
 	u32 string_area_size;
 	u32 length;
-	u32 cid_list_size;
+	size_t cid_list_size;
 	acpi_status status;
 	u32 count;
 	u32 i;
@@ -262,10 +262,7 @@ acpi_ut_execute_CID(struct acpi_namespace_node *device_node,
 	 * 2) Size of the CID PNP_DEVICE_ID array +
 	 * 3) Size of the actual CID strings
 	 */
-	cid_list_size = sizeof(struct acpi_pnp_device_id_list) +
-	    ((count - 1) * sizeof(struct acpi_pnp_device_id)) +
-	    string_area_size;
-
+	cid_list_size = struct_size(cid_list, ids, count - 1) + string_area_size;
 	cid_list = ACPI_ALLOCATE_ZEROED(cid_list_size);
 	if (!cid_list) {
 		status = AE_NO_MEMORY;
-- 
2.21.0

