Return-Path: <SRS0=DLm5=TA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EF2A7C43219
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Apr 2019 22:30:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AB4D420854
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Apr 2019 22:30:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="I59v1fqN"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726952AbfD3W37 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 30 Apr 2019 18:29:59 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:43373 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726086AbfD3W37 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Apr 2019 18:29:59 -0400
Received: by mail-pf1-f194.google.com with SMTP id e67so7752202pfe.10;
        Tue, 30 Apr 2019 15:29:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=RWhp0FHOhSIZ52Lj1JqUDIK41CK6Xd/J1k6VyS9fX9E=;
        b=I59v1fqNOO2ZNjkce+qHVG+3glQnqe/tQZT/YM+ybHPvOzVNLWV054ma7juH4Ncq+J
         ooaSRg/bYYolvRnhBH8yN71XFrZV9OxHdHJNZ6W8Ss2Ve25vZ7E1zPoRss3jRGX0m9CR
         0nKs4LxM4sUmcPz8h7er5gT8gdzf29laO5LkmDubo/GWHqhjsGdxJtTUFPAdXzzSA2BW
         UDB6e4RvOpV3CXTHX1y3iZFsG2OEJSBsbwIEfYdCtAqHlCQp8hVX/aoZqtaxTIE7v7Qj
         2g5CQMbXTYRjverF/4WJFfhIuMzS2T+i2uxJXH9Cq1kL30Lp6+JxpueZZ1uX+O7f7gKj
         tRVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=RWhp0FHOhSIZ52Lj1JqUDIK41CK6Xd/J1k6VyS9fX9E=;
        b=ugvaF04MGAPISULEcYaLlzxUIUAkA5opy/NCvG9844OF6JXQQuWvyXtf2hJvWevUqy
         EtBB6O4EajUxWy8ffeSjQnjofrnpQCN2loM+NruGlI00WJfIXGMApqOY1zu8FlAY8hJK
         GFLqJ9UE/VKsHMZ7EX1VOxHkOPTZhOBLj9Zgt0IGRlLcJx+xOjo5KVcHan6Fk3UTgqeC
         u3z9hdbESqp+5qnY16NayuhGq25+ammQcDu0zUfcv46zYdqI+9me6DCci2juGOmEl5Uo
         vBz1Q2wN086K73C3g9EZDxdCvtWheT3pEyIdJEk3pW5D+NEFclx3Se/fPpwzOQyrnvqx
         ZmKQ==
X-Gm-Message-State: APjAAAV48J5t8lfYfITgqqg0pZ0rsq3XXTW5QySd2wgVZ0SZjZLKY/7m
        IWdI2PCP8pObnezhtEMW3wYYWeCx
X-Google-Smtp-Source: APXvYqwlrUXXs5Euau1Ca0qUD49V1KBOQtHyorG0mB7Hs/AskRHJCLlgVnAyjrSOgtD6mfIh0FXQMA==
X-Received: by 2002:a63:de0a:: with SMTP id f10mr59664430pgg.418.1556663397942;
        Tue, 30 Apr 2019 15:29:57 -0700 (PDT)
Received: from ip-172-31-29-54.us-west-2.compute.internal (ec2-34-219-153-187.us-west-2.compute.amazonaws.com. [34.219.153.187])
        by smtp.gmail.com with ESMTPSA id h127sm58256445pgc.31.2019.04.30.15.29.56
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 30 Apr 2019 15:29:56 -0700 (PDT)
Date:   Tue, 30 Apr 2019 22:29:55 +0000
From:   Alakesh Haloi <alakesh.haloi@gmail.com>
To:     linux-kernel@vger.kernel.org, linux-hwmon@vger.kernel.org,
        Guenter Roeck <linux@roeck-us.net>,
        Jean Delvare <jdelvare@suse.com>
Subject: [PATCH] hwmon: Convert to hwmon_device_register_with_info()
Message-ID: <20190430222955.GA97523@ip-172-31-29-54.us-west-2.compute.internal>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Booting linux on bare metal instance type causes this warning:

hwmon_device_register() is deprecated. Please convert the driver
to use hwmon_device_register_with_info().

This patch fixes this call to deprecated function in acpi_power_meter.c

Signed-off-by: Alakesh Haloi <alakesh.haloi@gmail.com>
Cc: stable@vger.kernel.org
---
 drivers/hwmon/acpi_power_meter.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/hwmon/acpi_power_meter.c b/drivers/hwmon/acpi_power_meter.c
index e98591fa2528..d1b8029d0147 100644
--- a/drivers/hwmon/acpi_power_meter.c
+++ b/drivers/hwmon/acpi_power_meter.c
@@ -898,7 +898,9 @@ static int acpi_power_meter_add(struct acpi_device *device)
 	if (res)
 		goto exit_free;
 
-	resource->hwmon_dev = hwmon_device_register(&device->dev);
+	resource->hwmon_dev = hwmon_device_register_with_info(&device->dev,
+				ACPI_POWER_METER_NAME,
+				&device->driver_data, NULL, NULL);
 	if (IS_ERR(resource->hwmon_dev)) {
 		res = PTR_ERR(resource->hwmon_dev);
 		goto exit_remove;
-- 
2.17.2

