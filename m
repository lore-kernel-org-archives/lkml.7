Return-Path: <SRS0=xa+R=Y4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 333EBCA9EA0
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Nov 2019 10:55:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 02880217F5
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Nov 2019 10:55:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FKC8zBUO"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728747AbfKDKzY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 4 Nov 2019 05:55:24 -0500
Received: from mail-qk1-f193.google.com ([209.85.222.193]:41622 "EHLO
        mail-qk1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727985AbfKDKzX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Nov 2019 05:55:23 -0500
Received: by mail-qk1-f193.google.com with SMTP id m125so17114047qkd.8;
        Mon, 04 Nov 2019 02:55:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to;
        bh=dWbpvuVtH4nrP6Vwnvej12G7U/i+V+/HVOtM2jawYEA=;
        b=FKC8zBUO1EclUoK9kwX4vWKSIWcUyaOW2Fuec3dw6kl4JrS3q9G2HHulUjXyws8qd6
         OljVUlW+BTI/Fw37uV5VXmfqOLxVwzkOSVN1cc4nxFyFpf9bw5ccvHLz4ZJm/DDJVisc
         2LArgdiI7GwExG+Hect8zYkhFUC4dR+Kb00EQYQLMRgZNmnbtfP2/GIfGEa3Cx2x0tVf
         KU6o37cfz0qV5Pd8Lhujv9eRBQTl3ow93inUcMA44LHk15N3Z/LWbfZytoZBV8iBI8mT
         884/E6JjvcKjOe41NOhSVncbNZT75Wud8r0algXUcnsS4ClGZrY7bW3n0I3z44a/gpbt
         9tcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to;
        bh=dWbpvuVtH4nrP6Vwnvej12G7U/i+V+/HVOtM2jawYEA=;
        b=Fku85bJXDo3mzOSgnpAjLxWAV7InhXhFpBl/QPmw1Ls6/FHfiSURtZ1vouKEcI1DSi
         KJvPI11hlJFuxyrfAUJotY3dRtgHl3r+HU4cJN7DI0S8j0uBjDapnjbHOcab5yl0kT4b
         EsglfL7ZJP30oFpME5IOJCkeQpGlEsvyCsci9wuYaZHPcToBr+xtAriSftJyl99HGnmk
         DawMPTGCbv+82HHfDAHm/rteS7LAAAIE00YdqpBBlHwtV5onU7NBVwwf0mBpiE3KFXJQ
         StGwaeqEUkoaqxzDATv8Wwwl9vunJPhS7cE88HkCu5wb3fVsHnVYI+MTdaUGkx9R2Ek3
         5yww==
X-Gm-Message-State: APjAAAWoeEUF5xJzosvC4SUtHXJNFhL7P1pV48Cnl4ElmpB71na3evu0
        wyjPmy18vfaQAMfxrsq+cn4ZDg4r1XHSsRIkGjS8FETN0pg=
X-Google-Smtp-Source: APXvYqzWmk0VCT1YbqhWYcuilzxfGX+5JeiCIzuYpImMwtHLaCSUAnC0Vabqb+mCiT1W6HP083K9iThrkLVuLvub50M=
X-Received: by 2002:ae9:c302:: with SMTP id n2mr464880qkg.69.1572864922536;
 Mon, 04 Nov 2019 02:55:22 -0800 (PST)
MIME-Version: 1.0
References: <CAPW-Pu0KuxqbKSQ2JQaxh5AHbdZdNQZJfOgxoe_XZSxow+9e3A@mail.gmail.com>
In-Reply-To: <CAPW-Pu0KuxqbKSQ2JQaxh5AHbdZdNQZJfOgxoe_XZSxow+9e3A@mail.gmail.com>
From:   Leon Maxx <leonmaxx@gmail.com>
Date:   Mon, 4 Nov 2019 12:55:11 +0200
Message-ID: <CAPW-Pu2g3yiD8H5yUhAsCCN0vMzojoQ6QOn+4iOKCzHizE4T4A@mail.gmail.com>
Subject: [RFC PATCH 2/3] platform/x86: asus_wmi: Support fan boost mode on FX505DY/FX705DY
To:     linux-kernel@vger.kernel.org, platform-driver-x86@vger.kernel.org,
        acpi4asus-user@lists.sourceforge.net, andy@infradead.org,
        dvhart@infradead.org, corentin.chary@gmail.com,
        Daniel Drake <drake@endlessm.com>, yurii.pavlovskyi@gmail.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On ASUS FX505DY/FX705DY laptops fan boost mode is same as in other
TUF laptop models but have different ACPI device ID and different key
code.

Signed-off-by: Leonid Maksymchuk <leonmaxx@gmail.com>
---
 drivers/platform/x86/asus-wmi.c            | 42 ++++++++++++++++++++----------
 include/linux/platform_data/x86/asus-wmi.h |  1 +
 2 files changed, 29 insertions(+), 14 deletions(-)

diff --git a/drivers/platform/x86/asus-wmi.c b/drivers/platform/x86/asus-wmi.c
index 723aa4d..f4e5840 100644
--- a/drivers/platform/x86/asus-wmi.c
+++ b/drivers/platform/x86/asus-wmi.c
@@ -61,6 +61,7 @@
 #define NOTIFY_KBD_BRTDWN 0xc5
 #define NOTIFY_KBD_BRTTOGGLE 0xc7
 #define NOTIFY_KBD_FBM 0x99
+#define NOTIFY_KBD_FBM_2 0xae

 #define ASUS_WMI_FNLOCK_BIOS_DISABLED BIT(0)

@@ -194,7 +195,7 @@ struct asus_wmi {
  int fan_pwm_mode;
  int agfn_pwm;

- bool fan_boost_mode_available;
+ int fan_boost_mode_available;
  u8 fan_boost_mode_mask;
  u8 fan_boost_mode;

@@ -1616,24 +1617,33 @@ static int fan_boost_mode_check_present(struct
asus_wmi *asus)
  u32 result;
  int err;

- asus->fan_boost_mode_available = false;
+ asus->fan_boost_mode_available = 0;

  err = asus_wmi_get_devstate(asus, ASUS_WMI_DEVID_FAN_BOOST_MODE,
      &result);
- if (err) {
- if (err == -ENODEV)
- return 0;
- else
- return err;
+
+ if (err == 0 &&
+ (result & ASUS_WMI_DSTS_PRESENCE_BIT) &&
+ (result & ASUS_FAN_BOOST_MODES_MASK)) {
+ asus->fan_boost_mode_available = 1;
+ asus->fan_boost_mode_mask = result & ASUS_FAN_BOOST_MODES_MASK;
+ return 0;
  }

- if ((result & ASUS_WMI_DSTS_PRESENCE_BIT) &&
+ err = asus_wmi_get_devstate(asus, ASUS_WMI_DEVID_FAN_BOOST_MODE_2,
+     &result);
+
+ if (err == 0 &&
+ (result & ASUS_WMI_DSTS_PRESENCE_BIT) &&
  (result & ASUS_FAN_BOOST_MODES_MASK)) {
- asus->fan_boost_mode_available = true;
+ asus->fan_boost_mode_available = 2;
  asus->fan_boost_mode_mask = result & ASUS_FAN_BOOST_MODES_MASK;
  }

- return 0;
+ if (err == -ENODEV)
+ return 0;
+
+ return err;
 }

 static int fan_boost_mode_write(struct asus_wmi *asus)
@@ -1641,12 +1651,15 @@ static int fan_boost_mode_write(struct asus_wmi *asus)
  int err;
  u8 value;
  u32 retval;
+ u32 dev_id = asus->fan_boost_mode_available == 1 ?
+ ASUS_WMI_DEVID_FAN_BOOST_MODE :
+ ASUS_WMI_DEVID_FAN_BOOST_MODE_2;

  value = asus->fan_boost_mode;

  pr_info("Set fan boost mode: %u\n", value);
- err = asus_wmi_set_devstate(ASUS_WMI_DEVID_FAN_BOOST_MODE, value,
-     &retval);
+ err = asus_wmi_set_devstate(dev_id, value, &retval);
+
  if (err) {
  pr_warn("Failed to set fan boost mode: %d\n", err);
  return err;
@@ -2000,7 +2013,8 @@ static void asus_wmi_handle_event_code(int code,
struct asus_wmi *asus)
  return;
  }

- if (asus->fan_boost_mode_available && code == NOTIFY_KBD_FBM) {
+ if (asus->fan_boost_mode_available &&
+ (code == NOTIFY_KBD_FBM || code == NOTIFY_KBD_FBM_2) {
  fan_boost_mode_switch_next(asus);
  return;
  }
@@ -2177,7 +2191,7 @@ static umode_t asus_sysfs_is_visible(struct kobject *kobj,
  else if (attr == &dev_attr_als_enable.attr)
  devid = ASUS_WMI_DEVID_ALS_ENABLE;
  else if (attr == &dev_attr_fan_boost_mode.attr)
- ok = asus->fan_boost_mode_available;
+ ok = asus->fan_boost_mode_available != 0;

  if (devid != -1)
  ok = !(asus_wmi_get_devstate_simple(asus, devid) < 0);
diff --git a/include/linux/platform_data/x86/asus-wmi.h
b/include/linux/platform_data/x86/asus-wmi.h
index 60249e2..714782b 100644
--- a/include/linux/platform_data/x86/asus-wmi.h
+++ b/include/linux/platform_data/x86/asus-wmi.h
@@ -58,6 +58,7 @@
 #define ASUS_WMI_DEVID_LIGHT_SENSOR 0x00050022 /* ?? */
 #define ASUS_WMI_DEVID_LIGHTBAR 0x00050025
 #define ASUS_WMI_DEVID_FAN_BOOST_MODE 0x00110018
+#define ASUS_WMI_DEVID_FAN_BOOST_MODE_2 0x00120075

 /* Misc */
 #define ASUS_WMI_DEVID_CAMERA 0x00060013
-- 
1.8.3.1
