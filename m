Return-Path: <SRS0=rNeM=SR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2C716C10F0E
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Apr 2019 19:09:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E37B921900
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Apr 2019 19:09:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1555355361;
	bh=PuDEf0BYHuTBz0oNon366ti76fjZS6muLMNojq9iwOs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=Lw6QfskqnwKClTCIMfG+TkSmqpCMHlbmVoBaMZ5dtSnvQclBYSot7oTzawWzWqF/M
	 bxn4HwRl1uBlRZkWOF+j+60jr+M8yJaXUdpaFrWMkkC6LKS5LUEtVnrdNXj/4dfUK6
	 9kGM1Kq9TfEPMGigi9LG+Z53ZPqXS7KAySFifo10=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730699AbfDOTJU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 15 Apr 2019 15:09:20 -0400
Received: from mail.kernel.org ([198.145.29.99]:44982 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729440AbfDOTJQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Apr 2019 15:09:16 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8D4A621904;
        Mon, 15 Apr 2019 19:09:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1555355355;
        bh=PuDEf0BYHuTBz0oNon366ti76fjZS6muLMNojq9iwOs=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=D3dKq1Be0zyfAO7slVItK8EvIYlH/59YpK27NraemZ2+qQviTf78pm8ZZql22oAX6
         QNMUuyjDC0AGgkuUTa6k8gXcTPKWn0xrfLsHOcDr6/IkOK5Ms+FWXlJ0vmCQp/dIbg
         bI9itPQwzbjmizHmt8z7Q5F6WHTSDyBOQTHOyvZo=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Jean-Marc Lenoir <archlinux@jihemel.com>,
        Erik Schmauss <erik.schmauss@intel.com>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>
Subject: [PATCH 4.19 099/101] ACPICA: AML interpreter: add region addresses in global list during initialization
Date:   Mon, 15 Apr 2019 20:59:37 +0200
Message-Id: <20190415183745.605732928@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190415183740.341577907@linuxfoundation.org>
References: <20190415183740.341577907@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Erik Schmauss <erik.schmauss@intel.com>

commit 4abb951b73ff0a8a979113ef185651aa3c8da19b upstream.

The table load process omitted adding the operation region address
range to the global list. This omission is problematic because the OS
queries the global list to check for address range conflicts before
deciding which drivers to load. This commit may result in warning
messages that look like the following:

[    7.871761] ACPI Warning: system_IO range 0x00000428-0x0000042F conflicts with op_region 0x00000400-0x0000047F (\PMIO) (20180531/utaddress-213)
[    7.871769] ACPI: If an ACPI driver is available for this device, you should use it instead of the native driver

However, these messages do not signify regressions. It is a result of
properly adding address ranges within the global address list.

Link: https://bugzilla.kernel.org/show_bug.cgi?id=200011
Tested-by: Jean-Marc Lenoir <archlinux@jihemel.com>
Signed-off-by: Erik Schmauss <erik.schmauss@intel.com>
Cc: All applicable <stable@vger.kernel.org>
Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/acpi/acpica/dsopcode.c |    4 ++++
 1 file changed, 4 insertions(+)

--- a/drivers/acpi/acpica/dsopcode.c
+++ b/drivers/acpi/acpica/dsopcode.c
@@ -523,6 +523,10 @@ acpi_ds_eval_table_region_operands(struc
 			  ACPI_FORMAT_UINT64(obj_desc->region.address),
 			  obj_desc->region.length));
 
+	status = acpi_ut_add_address_range(obj_desc->region.space_id,
+					   obj_desc->region.address,
+					   obj_desc->region.length, node);
+
 	/* Now the address and length are valid for this opregion */
 
 	obj_desc->region.flags |= AOPOBJ_DATA_VALID;


