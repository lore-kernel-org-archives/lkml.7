Return-Path: <SRS0=SjSX=S5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DC8F4C43219
	for <linux-kernel@archiver.kernel.org>; Sat, 27 Apr 2019 15:32:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B81E4206C1
	for <linux-kernel@archiver.kernel.org>; Sat, 27 Apr 2019 15:32:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728780AbfD0Pc6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 27 Apr 2019 11:32:58 -0400
Received: from shadbolt.e.decadent.org.uk ([88.96.1.126]:60634 "EHLO
        shadbolt.e.decadent.org.uk" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726596AbfD0PPL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 27 Apr 2019 11:15:11 -0400
Received: from [192.168.4.242] (helo=deadeye)
        by shadbolt.decadent.org.uk with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <ben@decadent.org.uk>)
        id 1hKP2h-0000z6-C5; Sat, 27 Apr 2019 16:15:07 +0100
Received: from ben by deadeye with local (Exim 4.92)
        (envelope-from <ben@decadent.org.uk>)
        id 1hKP2h-0004Nn-5W; Sat, 27 Apr 2019 16:15:07 +0100
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From:   Ben Hutchings <ben@decadent.org.uk>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
CC:     akpm@linux-foundation.org, Denis Kirjanov <kda@linux-powerpc.org>,
        "Hans de Goede" <hdegoede@redhat.com>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>
Date:   Sat, 27 Apr 2019 16:13:09 +0100
Message-ID: <lsq.1556377989.974856129@decadent.org.uk>
X-Mailer: LinuxStableQueue (scripts by bwh)
X-Patchwork-Hint: ignore
Subject: [PATCH 3.16 003/202] ACPI: power: Skip duplicate power resource
 references in _PRx
In-Reply-To: <lsq.1556377988.384060557@decadent.org.uk>
X-SA-Exim-Connect-IP: 192.168.4.242
X-SA-Exim-Mail-From: ben@decadent.org.uk
X-SA-Exim-Scanned: No (on shadbolt.decadent.org.uk); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

3.16.66-rc1 review patch.  If anyone has any objections, please let me know.

------------------

From: Hans de Goede <hdegoede@redhat.com>

commit 7d7b467cb95bf29597b417d4990160d4ea6d69b9 upstream.

Some ACPI tables contain duplicate power resource references like this:

        Name (_PR0, Package (0x04)  // _PR0: Power Resources for D0
        {
            P28P,
            P18P,
            P18P,
            CLK4
        })

This causes a WARN_ON in sysfs_add_link_to_group() because we end up
adding a link to the same acpi_device twice:

sysfs: cannot create duplicate filename '/devices/LNXSYSTM:00/LNXSYBUS:00/PNP0A08:00/808622C1:00/OVTI2680:00/power_resources_D0/LNXPOWER:0a'
CPU: 0 PID: 1 Comm: swapper/0 Not tainted 4.19.12-301.fc29.x86_64 #1
Hardware name: Insyde CherryTrail/Type2 - Board Product Name, BIOS jumperx.T87.KFBNEEA02 04/13/2016
Call Trace:
 dump_stack+0x5c/0x80
 sysfs_warn_dup.cold.3+0x17/0x2a
 sysfs_do_create_link_sd.isra.2+0xa9/0xb0
 sysfs_add_link_to_group+0x30/0x50
 acpi_power_expose_list+0x74/0xa0
 acpi_power_add_remove_device+0x50/0xa0
 acpi_add_single_object+0x26b/0x5f0
 acpi_bus_check_add+0xc4/0x250
 ...

To address this issue, make acpi_extract_power_resources() check for
duplicates and simply skip them when found.

Signed-off-by: Hans de Goede <hdegoede@redhat.com>
[ rjw: Subject & changelog, comments ]
Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
---
 drivers/acpi/power.c | 22 ++++++++++++++++++++++
 1 file changed, 22 insertions(+)

--- a/drivers/acpi/power.c
+++ b/drivers/acpi/power.c
@@ -132,6 +132,23 @@ void acpi_power_resources_list_free(stru
 	}
 }
 
+static bool acpi_power_resource_is_dup(union acpi_object *package,
+				       unsigned int start, unsigned int i)
+{
+	acpi_handle rhandle, dup;
+	unsigned int j;
+
+	/* The caller is expected to check the package element types */
+	rhandle = package->package.elements[i].reference.handle;
+	for (j = start; j < i; j++) {
+		dup = package->package.elements[j].reference.handle;
+		if (dup == rhandle)
+			return true;
+	}
+
+	return false;
+}
+
 int acpi_extract_power_resources(union acpi_object *package, unsigned int start,
 				 struct list_head *list)
 {
@@ -151,6 +168,11 @@ int acpi_extract_power_resources(union a
 			err = -ENODEV;
 			break;
 		}
+
+		/* Some ACPI tables contain duplicate power resource references */
+		if (acpi_power_resource_is_dup(package, start, i))
+			continue;
+
 		err = acpi_add_power_resource(rhandle);
 		if (err)
 			break;

