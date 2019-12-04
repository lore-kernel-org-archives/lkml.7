Return-Path: <SRS0=oopU=Z2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 30C58C43603
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Dec 2019 18:01:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 02A6D20675
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Dec 2019 18:01:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1575482469;
	bh=bcA6ctyJlHC5RPREiPx2jX8ShjRw7n83MkRwmjmHGSs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=HysqokFZVZcUB0fFIwkbgHygKWWfwoPTHh1A2ryVIne4bBaGkcmmOB2gKl+R70Sv8
	 SklGRi1QWX7f9pkfSqivYNpsPpB/grWaufh02NOiJxsK42gr1MMKXYf3fT5eU6t0Cj
	 rHJa6xdF4rUjhd6IJr4N21LRi+cNmBfySx2AkHY4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729510AbfLDSBI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 4 Dec 2019 13:01:08 -0500
Received: from mail.kernel.org ([198.145.29.99]:40870 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729494AbfLDSBF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Dec 2019 13:01:05 -0500
Received: from localhost (unknown [217.68.49.72])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7211820675;
        Wed,  4 Dec 2019 18:01:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1575482464;
        bh=bcA6ctyJlHC5RPREiPx2jX8ShjRw7n83MkRwmjmHGSs=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=YSeuxmUy604Yg1b/ClhSfVgzxlRC9XSBiRcmG47ppAoiPraunQGUTXVLdiRng7FmQ
         JPGhl6igm8iH4g8KOYNvYvdNhMQvnTAyhC30shiIMRfaQnhQ+PkZZJZuwt6q9cwlzT
         QcbE6Edl9xPtqS3Ff18MQzeEjCtGPAGu74Z4QSWs=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Hans de Goede <hdegoede@redhat.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH 4.4 92/92] platform/x86: hp-wmi: Fix ACPI errors caused by too small buffer
Date:   Wed,  4 Dec 2019 18:50:32 +0100
Message-Id: <20191204174335.665089903@linuxfoundation.org>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <20191204174327.215426506@linuxfoundation.org>
References: <20191204174327.215426506@linuxfoundation.org>
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
@@ -90,7 +90,7 @@ struct bios_args {
 	u32 command;
 	u32 commandtype;
 	u32 datasize;
-	u32 data;
+	u8 data[128];
 };
 
 struct bios_return {
@@ -199,7 +199,7 @@ static int hp_wmi_perform_query(int quer
 		.command = write ? 0x2 : 0x1,
 		.commandtype = query,
 		.datasize = insize,
-		.data = 0,
+		.data = { 0 },
 	};
 	struct acpi_buffer input = { sizeof(struct bios_args), &args };
 	struct acpi_buffer output = { ACPI_ALLOCATE_BUFFER, NULL };
@@ -207,7 +207,7 @@ static int hp_wmi_perform_query(int quer
 
 	if (WARN_ON(insize > sizeof(args.data)))
 		return -EINVAL;
-	memcpy(&args.data, buffer, insize);
+	memcpy(&args.data[0], buffer, insize);
 
 	wmi_evaluate_method(HPWMI_BIOS_GUID, 0, 0x3, &input, &output);
 


