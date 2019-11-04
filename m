Return-Path: <SRS0=xa+R=Y4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 24562CA9EA0
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Nov 2019 10:56:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EEBBF217F5
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Nov 2019 10:55:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dXKI99Yz"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727500AbfKDKz7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 4 Nov 2019 05:55:59 -0500
Received: from mail-qt1-f194.google.com ([209.85.160.194]:44784 "EHLO
        mail-qt1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728663AbfKDKz5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Nov 2019 05:55:57 -0500
Received: by mail-qt1-f194.google.com with SMTP id o11so18150681qtr.11;
        Mon, 04 Nov 2019 02:55:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to;
        bh=rvo1SHxB9nVYQAjRXc27dF5Hg8RmRrQzx7MdaM7VmNk=;
        b=dXKI99YzHJ7cWkZ1hQUuEdTfaXZk3kat6uEDvhwPD2N/VlwI2UQ3sKAOIdf9qiBcMg
         k9VB6gsJ6VAE3AytNwdOQsiWAMB5DdQLECd+WxBntCp+DgW/Cfe7y85m0/RG7DwYGym8
         r+FSwc1ame1Yi5RWV+mHOyrv0cie3RRmdR1YEoC4qOHQSdKlIhmgpPsFg8fRpC/F40Sx
         5lNnEn9I37pYzOKr+Sicerj7F2oWnK1nQLMbNNTQ7MVcz+52fb2wKt8BJ4yf7arot2GO
         Ptqombc87PyDNOZkDRGRXwh1w6CZb3yLl9MfK883ERE+aX6atclJVojBr6MgPEP18EY6
         5yUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to;
        bh=rvo1SHxB9nVYQAjRXc27dF5Hg8RmRrQzx7MdaM7VmNk=;
        b=oZAGDphXl8JdFfy82aEODNcPbcHM5YUItowCOu40czoLPcTjWcEmkEmzXxlu0tjS6X
         q3UiAgGSbUC9sraFsIbTkF9ROthclxrNCsRqnfsGJQUfJ9kX1WTYFh1NLhz5xfCcc4kY
         Z4HGFDF/j7NahSnVPHYLwsNt5yw7mJPKtAgsw0JQBRLTY9VIrei2rbvYApDj7/jBieTi
         IEqdfQjGkpBr7c48fvLr0bIHHfpT8azKJzmRaaqqXuTB68RdiCNYLY62VVDjcgTbFe8I
         Zzlwrx9tKOJxxHHSyj41QjdENlKUn2SFSBYsi9uuNiU6aSYJFnRtaDqHja59i0cCz2S5
         Nyeg==
X-Gm-Message-State: APjAAAXz40v/oHFsaeBFmaoRSKBScBujw6HKkzrnbtzfR7Qb6BhT/hxb
        L9V7Z+pexSosnTwnPB/9cTnrRAAh0MaYKWwyN+lF9Fg885I=
X-Google-Smtp-Source: APXvYqygXMl4HsPWL+b5uxs86pmRyBHmjRYiwkZDhTm8Pg+KmODCvvi3F+xSQaJ5/4Ihk1T7mz8m3DcVaUj1jA5EIX0=
X-Received: by 2002:ac8:23d3:: with SMTP id r19mr12004769qtr.297.1572864955304;
 Mon, 04 Nov 2019 02:55:55 -0800 (PST)
MIME-Version: 1.0
References: <CAPW-Pu0KuxqbKSQ2JQaxh5AHbdZdNQZJfOgxoe_XZSxow+9e3A@mail.gmail.com>
In-Reply-To: <CAPW-Pu0KuxqbKSQ2JQaxh5AHbdZdNQZJfOgxoe_XZSxow+9e3A@mail.gmail.com>
From:   Leon Maxx <leonmaxx@gmail.com>
Date:   Mon, 4 Nov 2019 12:55:44 +0200
Message-ID: <CAPW-Pu3a7UjhW3wZ7jMLMEwj5goabqgHp2Vf7tQyzT3XwZr8cg@mail.gmail.com>
Subject: [RFC PATCH 3/3] platform/x86: asus_wmi: Set default fan boost mode to normal
To:     linux-kernel@vger.kernel.org, platform-driver-x86@vger.kernel.org,
        acpi4asus-user@lists.sourceforge.net, andy@infradead.org,
        dvhart@infradead.org, corentin.chary@gmail.com,
        Daniel Drake <drake@endlessm.com>, yurii.pavlovskyi@gmail.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Set default fan boost mode to normal for multiple reasons:

1) existing code assumes that laptop started in normal mode and that is
not always true.
2) FX705DY/FX505DY starts in silent mode and under heavy CPU load it
overheats and drops CPU frequency to 399MHz [1]. Setting fan mode to
normal avoids overheating.

[1] Link: https://bugzilla.kernel.org/show_bug.cgi?id=203733

Signed-off-by: Leonid Maksymchuk <leonmaxx@gmail.com>
---
 drivers/platform/x86/asus-wmi.c | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/drivers/platform/x86/asus-wmi.c b/drivers/platform/x86/asus-wmi.c
index f4e5840..70c5fbb 100644
--- a/drivers/platform/x86/asus-wmi.c
+++ b/drivers/platform/x86/asus-wmi.c
@@ -1674,6 +1674,18 @@ static int fan_boost_mode_write(struct asus_wmi *asus)
  return 0;
 }

+static int fan_boost_mode_set_default(struct asus_wmi *asus)
+{
+ int result = 0;
+
+ if (asus->fan_boost_mode_available) {
+ asus->fan_boost_mode = ASUS_FAN_BOOST_MODE_NORMAL;
+ result = fan_boost_mode_write(asus);
+ }
+
+ return result;
+}
+
 static int fan_boost_mode_switch_next(struct asus_wmi *asus)
 {
  u8 mask = asus->fan_boost_mode_mask;
@@ -2450,6 +2462,7 @@ static int asus_wmi_add(struct platform_device *pdev)
  err = fan_boost_mode_check_present(asus);
  if (err)
  goto fail_fan_boost_mode;
+ fan_boost_mode_set_default(asus);

  err = asus_wmi_sysfs_init(asus->platform_device);
  if (err)
-- 
1.8.3.1
