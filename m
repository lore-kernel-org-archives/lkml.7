Return-Path: <SRS0=Tfva=ZZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 660AFC432C0
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Dec 2019 22:39:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 351CC2080A
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Dec 2019 22:39:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1575412747;
	bh=sceLJGCo77DPR9JBaWfFyeAjcJUerBMlT9tLv1Mf0SQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=yQD0rd14tuNKHUjzNTTIQmoDgghGBEbh9+8p6NktklxkwK23+FTU/hbo3XST1hYLG
	 LMhVZNMkyTVCbb7MGmM7tVdwDEOWS/vRxsfQhmAz7cRRtWhfEyMt0lfz4JrRLd3Bwk
	 G2i3i6x6w2m9gcHuip6u5xx12+i/yhSVRPTvFAm4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728141AbfLCWjG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 3 Dec 2019 17:39:06 -0500
Received: from mail.kernel.org ([198.145.29.99]:48822 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727771AbfLCWjD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Dec 2019 17:39:03 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C2202207DD;
        Tue,  3 Dec 2019 22:39:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1575412743;
        bh=sceLJGCo77DPR9JBaWfFyeAjcJUerBMlT9tLv1Mf0SQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=d7n30CM1zWpm9aHCTPE4bbgWPrr/SLQ1QSdQPgBauYqb6UuatCQ/Bf2khwtJOyhOG
         R5O0UDjoy88iHsVHuIFXiMvLxaYtNufeRwgw43aEILyv78CnCKZzBnmhj1D0OpOpU8
         K2Zz49EEtPZ8uxQ3kjufLwlfUfencCnsPjF8VHAM=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Hans de Goede <hdegoede@redhat.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH 5.4 45/46] platform/x86: hp-wmi: Fix ACPI errors caused by too small buffer
Date:   Tue,  3 Dec 2019 23:36:05 +0100
Message-Id: <20191203212807.107230526@linuxfoundation.org>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <20191203212705.175425505@linuxfoundation.org>
References: <20191203212705.175425505@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Hans de Goede <hdegoede@redhat.com>

commit 16245db1489cd9aa579506f64afeeeb13d825a93 upstream.

The HP WMI calls may take up to 128 bytes of data as input, and
the AML methods implementing the WMI calls, declare a couple of fields for
accessing input in different sizes, specifycally the HWMC method contains:

        CreateField (Arg1, 0x80, 0x0400, D128)

Even though we do not use any of the WMI command-types which need a buffer
of this size, the APCI interpreter still tries to create it as it is
declared in generoc code at the top of the HWMC method which runs before
the code looks at which command-type is requested.

This results in many of these errors on many different HP laptop models:

[   14.459261] ACPI Error: Field [D128] at 1152 exceeds Buffer [NULL] size 160 (bits) (20170303/dsopcode-236)
[   14.459268] ACPI Error: Method parse/execution failed [\HWMC] (Node ffff8edcc61507f8), AE_AML_BUFFER_LIMIT (20170303/psparse-543)
[   14.459279] ACPI Error: Method parse/execution failed [\_SB.WMID.WMAA] (Node ffff8edcc61523c0), AE_AML_BUFFER_LIMIT (20170303/psparse-543)

This commit increases the size of the data element of the bios_args struct
to 128 bytes fixing these errors.

Cc: stable@vger.kernel.org
BugLink: https://bugzilla.kernel.org/show_bug.cgi?id=197007
BugLink: https://bugzilla.kernel.org/show_bug.cgi?id=201981
BugLink: https://bugzilla.redhat.com/show_bug.cgi?id=1520703
Signed-off-by: Hans de Goede <hdegoede@redhat.com>
Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/platform/x86/hp-wmi.c |    6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

--- a/drivers/platform/x86/hp-wmi.c
+++ b/drivers/platform/x86/hp-wmi.c
@@ -65,7 +65,7 @@ struct bios_args {
 	u32 command;
 	u32 commandtype;
 	u32 datasize;
-	u32 data;
+	u8 data[128];
 };
 
 enum hp_wmi_commandtype {
@@ -216,7 +216,7 @@ static int hp_wmi_perform_query(int quer
 		.command = command,
 		.commandtype = query,
 		.datasize = insize,
-		.data = 0,
+		.data = { 0 },
 	};
 	struct acpi_buffer input = { sizeof(struct bios_args), &args };
 	struct acpi_buffer output = { ACPI_ALLOCATE_BUFFER, NULL };
@@ -228,7 +228,7 @@ static int hp_wmi_perform_query(int quer
 
 	if (WARN_ON(insize > sizeof(args.data)))
 		return -EINVAL;
-	memcpy(&args.data, buffer, insize);
+	memcpy(&args.data[0], buffer, insize);
 
 	wmi_evaluate_method(HPWMI_BIOS_GUID, 0, mid, &input, &output);
 


