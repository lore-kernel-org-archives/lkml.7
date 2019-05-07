Return-Path: <SRS0=RyeP=TH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CCC69C04A6B
	for <linux-kernel@archiver.kernel.org>; Tue,  7 May 2019 01:12:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9C0242054F
	for <linux-kernel@archiver.kernel.org>; Tue,  7 May 2019 01:12:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="1/vz+TzW"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726582AbfEGBMo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 May 2019 21:12:44 -0400
Received: from merlin.infradead.org ([205.233.59.134]:60574 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726073AbfEGBMo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 May 2019 21:12:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=Content-Transfer-Encoding:Content-Type:
        MIME-Version:Date:Message-ID:Subject:From:Cc:To:Sender:Reply-To:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
        List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=EVC3BpEjyh8qUjLJcfezk7LUY08zh9RWK3mttq4RcxA=; b=1/vz+TzWsUviNjHbGiK5R/OJC3
        t2u1uREHk8sbnZwmcMyunzIuLraV/+5eEAQBlm6kWWpgcW6wJOAAvzEjFgCa5FnUyHNvztwiEBHi0
        U17zGdqMAdbcpwLLSBtlZdYd4HPm7nyqbGSv8BkK8FzW4StOu6zXm84+7+MG6oR0JqbXGZYzwIIh5
        1rml0rXYIMio25eJ8bLNkVj+IcdEOthWQwE7P7GAdTrSJXKvsGmEyL9EU5VilbZmOOjywZesO98Vb
        ti3PceiBRBgIrB8/a+KCW1t+WpxlWKa6p/BbA561te1MU/NHYybmCLG15LDdQcWf33dTGgOMiPF9/
        J22v42ow==;
Received: from static-50-53-52-16.bvtn.or.frontiernet.net ([50.53.52.16] helo=dragon.dunlab)
        by merlin.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1hNoep-0002A9-14; Tue, 07 May 2019 01:12:35 +0000
To:     LKML <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>,
        Jiri Kosina <jikos@kernel.org>,
        Benjamin Tissoires <benjamin.tissoires@redhat.com>,
        kbuild test robot <lkp@intel.com>
From:   Randy Dunlap <rdunlap@infradead.org>
Subject: [PATCH -next] hid: fix hid-logitech-dj build error
Message-ID: <e2154a13-0ec5-d39c-52cf-db98867b0496@infradead.org>
Date:   Mon, 6 May 2019 18:12:33 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Randy Dunlap <rdunlap@infradead.org>

Fix build error in hid-logitech-dj by making it depend on
USB_HID, like several other HID drivers do.

Fixes this build error:

ERROR: "usb_hid_driver" [drivers/hid/hid-logitech-dj.ko] undefined!

Reported-by: kbuild test robot <lkp@intel.com>
Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
Cc: Jiri Kosina <jikos@kernel.org>
Cc: Benjamin Tissoires <benjamin.tissoires@redhat.com>
Cc: linux-input@vger.kernel.org
Cc: Andrew Morton <akpm@linux-foundation.org>
---
 drivers/hid/Kconfig |    1 +
 1 file changed, 1 insertion(+)

--- mmotm-2019-0425-1630.orig/drivers/hid/Kconfig
+++ mmotm-2019-0425-1630/drivers/hid/Kconfig
@@ -522,6 +522,7 @@ config HID_LOGITECH
 config HID_LOGITECH_DJ
 	tristate "Logitech Unifying receivers full support"
 	depends on HIDRAW
+	depends on USB_HID
 	depends on HID_LOGITECH
 	select HID_LOGITECH_HIDPP
 	---help---


