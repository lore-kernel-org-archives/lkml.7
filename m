Return-Path: <SRS0=BPXs=SN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9101EC10F13
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Apr 2019 05:42:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4E8802083E
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Apr 2019 05:42:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kzU9K5P8"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726702AbfDKFm6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 11 Apr 2019 01:42:58 -0400
Received: from mail-wm1-f66.google.com ([209.85.128.66]:35470 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726230AbfDKFm5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Apr 2019 01:42:57 -0400
Received: by mail-wm1-f66.google.com with SMTP id y197so4967968wmd.0;
        Wed, 10 Apr 2019 22:42:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:from:cc:references:message-id:date:user-agent:mime-version
         :in-reply-to:content-language:content-transfer-encoding;
        bh=1xNhLvjddpC+m7l+jNGd7GnlNGMx67U/dMdy5froaEA=;
        b=kzU9K5P8taYCpYxLxtMUyp6cC5Gs40YYpxf5auzfgHdU+WTPoHl3+5HXb75eaY3z0s
         Sgxl2LExrpX4DfC2BS5VjTDjIIYDSgNd/ocYuN7fNiotNoI7+kW9eji8CmL3b7sHayyT
         T35kroYudI5psfsgs4TTq68c4td9uHGCymHyZYxBaEQ8FEFksb8LXgyXfJwt7CEcQ5n2
         a1K4AwGKfVlZoZ/9RqkGv/T8SkUxOy3ZH87q9CzkoHUiXcyWZ9KvRiLKQx0Qi8wp76+O
         ZwqPvi6wjF7o3JrcWP5QT8hTWEkDnkD+CUjF4hIvS4gxIgFd3JZkHd6ff3byFo/mVbvX
         Jkzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:from:cc:references:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=1xNhLvjddpC+m7l+jNGd7GnlNGMx67U/dMdy5froaEA=;
        b=UV941jspSoBxFz3NtkCsDpl5h4batYTF0s1VlRDmbgCBa/aw5EO/LhEomn9GNNKnfO
         HDPYBUUHBss65gZDCP/GQwuzRoLiqUxDoW5/i/eDBijFrsfJtkBxCohvoBl1wLW8TEvU
         KKAcKZKyCaOMl++VxOPtXc/NIthaBEcxKia31l12eUk425KFDTwfWuNvdXrikyVc9oXa
         V59jlkMSvYZAoDQNIJuwRizRHEO6JOhpo/d9smU4VJ0Z/8zuIdfTinOsoyfBA6fZ6sLn
         lHyfn3ihA1rhkiGFIdW/cHc/xXxu5ijfKCLDdLxTZIMYYwU1pU/QEy4ktmG8SmiMzLdh
         4IEQ==
X-Gm-Message-State: APjAAAUhBAePpGJRv9ZNyJigVFimbNHfTasWmz79PqnnMbDuJO37CDfP
        oPLagY9Y0/w1a8Im9bLiRuhGf7K5SM8=
X-Google-Smtp-Source: APXvYqyn+ez4rd2vVXshZqZ0xgV1NdjSniYmvcm3v8OuA/4dJV8A8jCCyfTXHxUwD8QgeR6dqlvvuA==
X-Received: by 2002:a1c:d1c5:: with SMTP id i188mr4970189wmg.8.1554961374962;
        Wed, 10 Apr 2019 22:42:54 -0700 (PDT)
Received: from [192.168.20.141] ([194.99.104.18])
        by smtp.gmail.com with ESMTPSA id i18sm34636208wrm.7.2019.04.10.22.42.53
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 10 Apr 2019 22:42:54 -0700 (PDT)
Subject: [PATCH v2 04/11] platform/x86: asus-wmi: Add quirk to force DSTS WMI
 method detection
From:   Yurii Pavlovskyi <yurii.pavlovskyi@gmail.com>
Cc:     Corentin Chary <corentin.chary@gmail.com>,
        Darren Hart <dvhart@infradead.org>,
        Andy Shevchenko <andy@infradead.org>,
        Daniel Drake <drake@endlessm.com>,
        acpi4asus-user@lists.sourceforge.net,
        platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org
References: <a8dd77f3-1e28-6416-5f04-aff44d5bb6d6@gmail.com>
 <d8e0f65c-8c4e-7b60-93bd-3bf90e2da344@gmail.com>
Message-ID: <78af5288-78f6-cf51-6bc8-b24a4467927f@gmail.com>
Date:   Thu, 11 Apr 2019 07:42:52 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <d8e0f65c-8c4e-7b60-93bd-3bf90e2da344@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The DSTS method detection fails, as nothing is returned if method is not
defined in WMNB. As a result the control of keyboard backlight is not
functional for TUF Gaming series laptops (at the time the only
functionality of the driver on this model implemented with WMI methods).

Patch was tested on a newer TUF Gaming FX505GM and older K54C model.

FX505GM:
Method (WMNB, 3, Serialized)
{ ...
    If ((Local0 == 0x53545344))
    {
        ...
        Return (Zero)
    }
    ...
    // No return
}

K54C:
Method (WMNB, 3, Serialized)
{ ...
    If ((Local0 == 0x53545344))
    {
        ...
        Return (0x02)
    }
    ...
    Return (0xFFFFFFFE)
}

The non-existing method ASUS_WMI_METHODID_DSTS=0x53544344 (actually it is
DCTS in little endian ASCII) is selected in asus->dsts.

One way to fix this would be to call both for every known device ID until
some answers - this would increase module load time.

Another option is to check some device that is known to exist on every
model - none known at the time.

Last option, which is implemented, is to check for presence of the
ASUS7000 device in ACPI tree (it is a dummy device), which is the
condition used for loading the vendor driver for this model. This might
not fix every affected model ever produced, but it likely does not
introduce any regressions. The patch introduces a quirk that is enabled
when ASUS7000 is found.

Scope (_SB)
{
    Device (ATK)
    {
        Name (_HID, "ASUS7000")  // _HID: Hardware ID
    }
}

Signed-off-by: Yurii Pavlovskyi <yurii.pavlovskyi@gmail.com>
---
 drivers/platform/x86/asus-nb-wmi.c |  5 +++++
 drivers/platform/x86/asus-wmi.c    | 14 ++++++++++++--
 drivers/platform/x86/asus-wmi.h    |  5 +++++
 3 files changed, 22 insertions(+), 2 deletions(-)

diff --git a/drivers/platform/x86/asus-nb-wmi.c b/drivers/platform/x86/asus-nb-wmi.c
index b6f2ff95c3ed..cc5f0765a8d9 100644
--- a/drivers/platform/x86/asus-nb-wmi.c
+++ b/drivers/platform/x86/asus-nb-wmi.c
@@ -28,6 +28,7 @@
 #include <linux/fb.h>
 #include <linux/dmi.h>
 #include <linux/i8042.h>
+#include <linux/acpi.h>
 
 #include "asus-wmi.h"
 
@@ -434,6 +435,10 @@ static void asus_nb_wmi_quirks(struct asus_wmi_driver *driver)
 		}
 		pr_info("Using i8042 filter function for receiving events\n");
 	}
+
+	if (acpi_dev_found("ASUS7000")) {
+		driver->quirks->force_dsts = true;
+	}
 }
 
 static const struct key_entry asus_nb_wmi_keymap[] = {
diff --git a/drivers/platform/x86/asus-wmi.c b/drivers/platform/x86/asus-wmi.c
index cfccfc0b8c2f..80f3447734fc 100644
--- a/drivers/platform/x86/asus-wmi.c
+++ b/drivers/platform/x86/asus-wmi.c
@@ -1885,11 +1885,21 @@ static int asus_wmi_platform_init(struct asus_wmi *asus)
 	 * Note, on most Eeepc, there is no way to check if a method exist
 	 * or note, while on notebooks, they returns 0xFFFFFFFE on failure,
 	 * but once again, SPEC may probably be used for that kind of things.
+	 *
+	 * Additionally at least TUF Gaming series laptops return 0 for unknown
+	 * methods, so the detection in this way is not possible and method must
+	 * be forced. Likely the presence of ACPI device ASUS7000 indicates
+	 * this.
 	 */
-	if (!asus_wmi_evaluate_method(ASUS_WMI_METHODID_DSTS, 0, 0, NULL))
+	if (asus->driver->quirks->force_dsts) {
+		pr_info("DSTS method forced\n");
+		asus->dsts_id = ASUS_WMI_METHODID_DSTS2;
+	} else if (!asus_wmi_evaluate_method(ASUS_WMI_METHODID_DSTS,
+			0, 0, NULL)) {
 		asus->dsts_id = ASUS_WMI_METHODID_DSTS;
-	else
+	} else {
 		asus->dsts_id = ASUS_WMI_METHODID_DSTS2;
+	}
 
 	/* CWAP allow to define the behavior of the Fn+F2 key,
 	 * this method doesn't seems to be present on Eee PCs */
diff --git a/drivers/platform/x86/asus-wmi.h b/drivers/platform/x86/asus-wmi.h
index 6c1311f4b04d..94056da02fde 100644
--- a/drivers/platform/x86/asus-wmi.h
+++ b/drivers/platform/x86/asus-wmi.h
@@ -54,6 +54,11 @@ struct quirk_entry {
 	 */
 	int no_display_toggle;
 	u32 xusb2pr;
+	/**
+	 * Force DSTS instead of DSCS and skip detection. Useful if WMNB
+	 * returns nothing on unknown method call.
+	 */
+	bool force_dsts;
 
 	bool (*i8042_filter)(unsigned char data, unsigned char str,
 			     struct serio *serio);
-- 
2.17.1

