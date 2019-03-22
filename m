Return-Path: <SRS0=oArh=RZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6829CC43381
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 12:55:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3932E21873
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 12:55:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1553259312;
	bh=WBkDBOCVLqq3GY+EgHglCS3NsB/c1zQWhD+8/2qHQLI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=tVY/lk7s6O7ftTUyj9o9sIRaxmctWolvnsRu10K4is0l+YEDWgYSBfpvWL4DzLnFP
	 3DzP2b/1j4eo3yt6KVGH/Z01o16CYZ8qJfDPEMrCs3P7y4usw/jIgoXRXxWcyj+rWY
	 BHwFGTbcZbrG8hGiFSch1UicT69wpxJ/XsKjvbs8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732610AbfCVLuR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Mar 2019 07:50:17 -0400
Received: from mail.kernel.org ([198.145.29.99]:54034 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731980AbfCVLuQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Mar 2019 07:50:16 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7EAE52082C;
        Fri, 22 Mar 2019 11:50:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1553255415;
        bh=WBkDBOCVLqq3GY+EgHglCS3NsB/c1zQWhD+8/2qHQLI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=fNmUQusn+GqRPbeEE4ICjDFXRO8Ovlvz19TkDgkdLqaC4ir0ecweJoXYpcjhrscEd
         qTtRnfP+KStjt3cgKsOrC/BTCyiuOnp4a1WrbkrgekmXuLU4BdIUA0Tp2LKjOOj6fV
         80neUBZxKi10M/48vdZq4Peg4gtO3mUNfUvfhVjA=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Ferry Toth <fntoth@gmail.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>
Subject: [PATCH 4.14 084/183] ACPI / device_sysfs: Avoid OF modalias creation for removed device
Date:   Fri, 22 Mar 2019 12:15:12 +0100
Message-Id: <20190322111247.827910562@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190322111241.819468003@linuxfoundation.org>
References: <20190322111241.819468003@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

commit f16eb8a4b096514ac06fb25bf599dcc792899b3d upstream.

If SSDT overlay is loaded via ConfigFS and then unloaded the device,
we would like to have OF modalias for, already gone. Thus, acpi_get_name()
returns no allocated buffer for such case and kernel crashes afterwards:

 ACPI: Host-directed Dynamic ACPI Table Unload
 ads7950 spi-PRP0001:00: Dropping the link to regulator.0
 BUG: unable to handle kernel NULL pointer dereference at 0000000000000000
 #PF error: [normal kernel read fault]
 PGD 80000000070d6067 P4D 80000000070d6067 PUD 70d0067 PMD 0
 Oops: 0000 [#1] SMP PTI
 CPU: 0 PID: 40 Comm: kworker/u4:2 Not tainted 5.0.0+ #96
 Hardware name: Intel Corporation Merrifield/BODEGA BAY, BIOS 542 2015.01.21:18.19.48
 Workqueue: kacpi_hotplug acpi_device_del_work_fn
 RIP: 0010:create_of_modalias.isra.1+0x4c/0x150
 Code: 00 00 48 89 44 24 18 31 c0 48 8d 54 24 08 48 c7 44 24 10 00 00 00 00 48 c7 44 24 08 ff ff ff ff e8 7a b0 03 00 48 8b 4c 24 10 <0f> b6 01 84 c0 74 27 48 c7 c7 00 09 f4 a5 0f b6 f0 8d 50 20 f6 04
 RSP: 0000:ffffa51040297c10 EFLAGS: 00010246
 RAX: 0000000000001001 RBX: 0000000000000785 RCX: 0000000000000000
 RDX: 0000000000001001 RSI: 0000000000000286 RDI: ffffa2163dc042e0
 RBP: ffffa216062b1196 R08: 0000000000001001 R09: ffffa21639873000
 R10: ffffffffa606761d R11: 0000000000000001 R12: ffffa21639873218
 R13: ffffa2163deb5060 R14: ffffa216063d1010 R15: 0000000000000000
 FS:  0000000000000000(0000) GS:ffffa2163e000000(0000) knlGS:0000000000000000
 CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
 CR2: 0000000000000000 CR3: 0000000007114000 CR4: 00000000001006f0
 Call Trace:
  __acpi_device_uevent_modalias+0xb0/0x100
  spi_uevent+0xd/0x40

 ...

In order to fix above let create_of_modalias() check the status returned
by acpi_get_name() and bail out in case of failure.

Fixes: 8765c5ba1949 ("ACPI / scan: Rework modalias creation when "compatible" is present")
Link: https://bugzilla.kernel.org/show_bug.cgi?id=201381
Reported-by: Ferry Toth <fntoth@gmail.com>
Tested-by: Ferry Toth<fntoth@gmail.com>
Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Reviewed-by: Mika Westerberg <mika.westerberg@linux.intel.com>
Cc: 4.1+ <stable@vger.kernel.org> # 4.1+
Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/acpi/device_sysfs.c |    6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

--- a/drivers/acpi/device_sysfs.c
+++ b/drivers/acpi/device_sysfs.c
@@ -202,11 +202,15 @@ static int create_of_modalias(struct acp
 {
 	struct acpi_buffer buf = { ACPI_ALLOCATE_BUFFER };
 	const union acpi_object *of_compatible, *obj;
+	acpi_status status;
 	int len, count;
 	int i, nval;
 	char *c;
 
-	acpi_get_name(acpi_dev->handle, ACPI_SINGLE_NAME, &buf);
+	status = acpi_get_name(acpi_dev->handle, ACPI_SINGLE_NAME, &buf);
+	if (ACPI_FAILURE(status))
+		return -ENODEV;
+
 	/* DT strings are all in lower case */
 	for (c = buf.pointer; *c != '\0'; c++)
 		*c = tolower(*c);


