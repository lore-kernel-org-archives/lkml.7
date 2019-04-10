Return-Path: <SRS0=SZ1Q=SM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8F2BDC10F11
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Apr 2019 20:28:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5128120830
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Apr 2019 20:28:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KlcStyX9"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726748AbfDJU2p (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 10 Apr 2019 16:28:45 -0400
Received: from mail-wm1-f67.google.com ([209.85.128.67]:39550 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726014AbfDJU2p (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Apr 2019 16:28:45 -0400
Received: by mail-wm1-f67.google.com with SMTP id n25so3992075wmk.4;
        Wed, 10 Apr 2019 13:28:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:from:cc:references:message-id:date:user-agent:mime-version
         :in-reply-to:content-language:content-transfer-encoding;
        bh=9Hmq52yvJQx/5jP7bZfxBWJsPaTflswfLZ+HbiCE+bo=;
        b=KlcStyX9ZhwXzaTle/9oXOkD4p15X6cPxyyNJJseOrvcPohh1RXGudPtm1rGPjCogu
         zWzqYzacKtruirLAbXhTfCVW89mCP8L/yX0N1j/dI0Ci1mG9+uJqHsEKTnaOfOqAC0R5
         A4D9LwQW0VwNm7UpGAAvxfvaM0OObzcbY4kMj4aX+/WNgMxuCS9JpYyslRsRL5p9pP7Q
         pdJyApxoJ42BIXqDfQQFzwBAHPLGR8TiddzJMqYACmIE3GZX8mlkvYSQwtMtSqRv5I5g
         pMCqJir3yvK7othX1F9XavQOt017LIRxrg3nkGbWkmMHHey+iCR9+A41hMwAMWdrfM/n
         ZXsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:from:cc:references:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=9Hmq52yvJQx/5jP7bZfxBWJsPaTflswfLZ+HbiCE+bo=;
        b=TCQVEqGlMvfMFWN0n+96D1NYHT9cPOPwJAe6Oao+S0jylEKt40XO+1SZVeVXV1PmUr
         420EcktZ/jt+FvbXEB75nB9eV8qToESVvcC0UF64IYZmSgLAetKMfuFZftIlaEefhCyJ
         HewrD4oZ7hafRQjTN23sgJEF4QLgneByvaNuGQVcRSsGPoTa2DRnYKwOuzBI0cAAj3jU
         aibQoLcA3A2XiaAMfbdwHngdZTEijMwK/tXdYjjLQZc15INh2dcavbF8XExlo8FFw6oX
         EwiYKAHng1aCE0XADEL2I9St6/3818C+fV+v59F9vy4Xt4VvwX1yMZ+d0wubSEqOIJs8
         4lHQ==
X-Gm-Message-State: APjAAAU+B55SvgYahlMTMNo+UolpJCiv0H8FB8THVCgColyojO2d2WK1
        lE6nxBADFO+kXbmJqOBxs1bfhIcRJ9g=
X-Google-Smtp-Source: APXvYqyu64j4LIImPjf31lAHc5AJ6q6FkKL+783ny4u/0W7ByD6fQUziQXCzEO05QNy2GbZ5X0U8Og==
X-Received: by 2002:a1c:1d49:: with SMTP id d70mr4159285wmd.36.1554928122475;
        Wed, 10 Apr 2019 13:28:42 -0700 (PDT)
Received: from [192.168.20.141] ([194.99.104.18])
        by smtp.gmail.com with ESMTPSA id g13sm2511169wmh.11.2019.04.10.13.28.40
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 10 Apr 2019 13:28:41 -0700 (PDT)
Subject: [PATCH 04/11] platform/x86: asus-wmi: Add quirk to force DSTS WMI
 method detection
From:   Yurii Pavlovskyi <yurii.pavlovskyi@gmail.com>
Cc:     Corentin Chary <corentin.chary@gmail.com>,
        Darren Hart <dvhart@infradead.org>,
        Andy Shevchenko <andy@infradead.org>,
        Daniel Drake <drake@endlessm.com>,
        acpi4asus-user@lists.sourceforge.net,
        platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org
References: <a8dd77f3-1e28-6416-5f04-aff44d5bb6d6@gmail.com>
Message-ID: <d8e0f65c-8c4e-7b60-93bd-3bf90e2da344@gmail.com>
Date:   Wed, 10 Apr 2019 22:28:39 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <a8dd77f3-1e28-6416-5f04-aff44d5bb6d6@gmail.com>
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
 drivers/platform/x86/asus-wmi.c    | 16 +++++++++++++---
 drivers/platform/x86/asus-wmi.h    |  5 +++++
 3 files changed, 23 insertions(+), 3 deletions(-)

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
index cfccfc0b8c2f..58890d87d50c 100644
--- a/drivers/platform/x86/asus-wmi.c
+++ b/drivers/platform/x86/asus-wmi.c
@@ -24,7 +24,7 @@
  *  Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307  USA
  */
 
-#define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
+#define PR KBUILD_MODNAME ": "
 
 #include <linux/kernel.h>
 #include <linux/module.h>
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
+		pr_info(PR "DSTS method forced\n");
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

