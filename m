Return-Path: <SRS0=WmnE=2X=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A7D67C3276D
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Jan 2020 22:40:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6AB4920863
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Jan 2020 22:40:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1578004829;
	bh=1no84OwhjmvmHKpesHvV6bG38grz6JAXz/O5PiNgOFY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=BO/5GpY51Xo5fthjUxuKR6vE6jpb8iNy+VQCBjFWbLtmmgk4hMFmTpt6SOKJpSEm/
	 HaMHWJQDzddBpBrXaPgdWcGjiainLonrrA+7AhC01cmgimK5Gj++Icdc6T6h3MMwQC
	 jpJ5VodfuHlioD/whbYI05mcrcHZEKDfuCKCgR/M=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731191AbgABWiQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 2 Jan 2020 17:38:16 -0500
Received: from mail.kernel.org ([198.145.29.99]:51700 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731263AbgABWiJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Jan 2020 17:38:09 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4911E20863;
        Thu,  2 Jan 2020 22:38:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1578004688;
        bh=1no84OwhjmvmHKpesHvV6bG38grz6JAXz/O5PiNgOFY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=pCZL7gwCWAUHHv5QxJK9O3RKHGzxrUT3F10PUnp4li1IRPkLN41/A6cgbzTQPXwEZ
         dYGtGhPBgGYL9J/UAS/X3bUtcC/1alJx28/zIJp5FTprfPOIQCHnJIC7n69T91ddRY
         +qY5lAJbD0Y/If89UTSM89Z6I6RSku1g53lnefxo=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Hans de Goede <hdegoede@redhat.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH 4.4 084/137] platform/x86: hp-wmi: Make buffer for HPWMI_FEATURE2_QUERY 128 bytes
Date:   Thu,  2 Jan 2020 23:07:37 +0100
Message-Id: <20200102220557.990485445@linuxfoundation.org>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200102220546.618583146@linuxfoundation.org>
References: <20200102220546.618583146@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Hans de Goede <hdegoede@redhat.com>

commit 133b2acee3871ae6bf123b8fe34be14464aa3d2c upstream.

At least on the HP Envy x360 15-cp0xxx model the WMI interface
for HPWMI_FEATURE2_QUERY requires an outsize of at least 128 bytes,
otherwise it fails with an error code 5 (HPWMI_RET_INVALID_PARAMETERS):

Dec 06 00:59:38 kernel: hp_wmi: query 0xd returned error 0x5

We do not care about the contents of the buffer, we just want to know
if the HPWMI_FEATURE2_QUERY command is supported.

This commits bumps the buffer size, fixing the error.

Fixes: 8a1513b4932 ("hp-wmi: limit hotkey enable")
Cc: stable@vger.kernel.org
BugLink: https://bugzilla.redhat.com/show_bug.cgi?id=1520703
Signed-off-by: Hans de Goede <hdegoede@redhat.com>
Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/platform/x86/hp-wmi.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/drivers/platform/x86/hp-wmi.c
+++ b/drivers/platform/x86/hp-wmi.c
@@ -309,7 +309,7 @@ static int __init hp_wmi_bios_2008_later
 
 static int __init hp_wmi_bios_2009_later(void)
 {
-	int state = 0;
+	u8 state[128];
 	int ret = hp_wmi_perform_query(HPWMI_FEATURE2_QUERY, 0, &state,
 				       sizeof(state), sizeof(state));
 	if (!ret)


