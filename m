Return-Path: <SRS0=rNeM=SR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,URIBL_SBL,
	URIBL_SBL_A,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9E77CC10F0E
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Apr 2019 19:12:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 70722218D3
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Apr 2019 19:12:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1555355526;
	bh=u/leh00119uEi4uCKhs5AiFBit2GgYy7Wfe/3rlZmZE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=hYZ3KTQ56CKdbjrc/J53Kye16dJG75ChnrXTLs4I3zQDLAskaTC4Ky5xELgTJQNw0
	 o7IQXU8OuVqgip0lMK1ftBMW0ibfufze5tp58n6xi8BAuicbEur75oBrxO754KU5bz
	 tSrFQ5pGgOBCIde6jbAm25qI3D96Nzxi38CevT9M=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731334AbfDOTME (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 15 Apr 2019 15:12:04 -0400
Received: from mail.kernel.org ([198.145.29.99]:49182 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731330AbfDOTMB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Apr 2019 15:12:01 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id BF1FF20880;
        Mon, 15 Apr 2019 19:11:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1555355520;
        bh=u/leh00119uEi4uCKhs5AiFBit2GgYy7Wfe/3rlZmZE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=dCUHhnW6zFKtWbyDR++x8Y8/JNmSYxd/b75OTSA+CHcMVqlxVe/+LX6zNZDBezeV4
         hsoSw5j+WOPtpZx1mPTHLCg6R++1tmfsK7VXjEbk90GpdQjqyZFf1TyMA3eT57lA7V
         3sTq7ZA3Txy+OmZ6lCH94GHIlsGTz+7PujHW6l4E=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Michael J Gruber <mjg@fedoraproject.org>,
        Erik Schmauss <erik.schmauss@intel.com>,
        Bob Moore <robert.moore@intel.com>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>
Subject: [PATCH 5.0 052/117] ACPICA: Namespace: remove address node from global list after method termination
Date:   Mon, 15 Apr 2019 21:00:22 +0200
Message-Id: <20190415183747.608079879@linuxfoundation.org>
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

From: Erik Schmauss <erik.schmauss@intel.com>

commit c5781ffbbd4f742a58263458145fe7f0ac01d9e0 upstream.

ACPICA commit b233720031a480abd438f2e9c643080929d144c3

ASL operation_regions declare a range of addresses that it uses. In a
perfect world, the range of addresses should be used exclusively by
the AML interpreter. The OS can use this information to decide which
drivers to load so that the AML interpreter and device drivers use
different regions of memory.

During table load, the address information is added to a global
address range list. Each node in this list contains an address range
as well as a namespace node of the operation_region. This list is
deleted at ACPI shutdown.

Unfortunately, ASL operation_regions can be declared inside of control
methods. Although this is not recommended, modern firmware contains
such code. New module level code changes unintentionally removed the
functionality of adding and removing nodes to the global address
range list.

A few months ago, support for adding addresses has been re-
implemented. However, the removal of the address range list was
missed and resulted in some systems to crash due to the address list
containing bogus namespace nodes from operation_regions declared in
control methods. In order to fix the crash, this change removes
dynamic operation_regions after control method termination.

Link: https://github.com/acpica/acpica/commit/b2337200
Link: https://bugzilla.kernel.org/show_bug.cgi?id=202475
Fixes: 4abb951b73ff ("ACPICA: AML interpreter: add region addresses in global list during initialization")
Reported-by: Michael J Gruber <mjg@fedoraproject.org>
Signed-off-by: Erik Schmauss <erik.schmauss@intel.com>
Signed-off-by: Bob Moore <robert.moore@intel.com>
Cc: 4.20+ <stable@vger.kernel.org> # 4.20+
Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/acpi/acpica/nsobject.c |    4 ++++
 1 file changed, 4 insertions(+)

--- a/drivers/acpi/acpica/nsobject.c
+++ b/drivers/acpi/acpica/nsobject.c
@@ -186,6 +186,10 @@ void acpi_ns_detach_object(struct acpi_n
 		}
 	}
 
+	if (obj_desc->common.type == ACPI_TYPE_REGION) {
+		acpi_ut_remove_address_range(obj_desc->region.space_id, node);
+	}
+
 	/* Clear the Node entry in all cases */
 
 	node->object = NULL;


