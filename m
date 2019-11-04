Return-Path: <SRS0=xa+R=Y4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A8763CA9EB5
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Nov 2019 18:29:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7EF3A20869
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Nov 2019 18:29:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FhP+Coa4"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729559AbfKDS3M (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 4 Nov 2019 13:29:12 -0500
Received: from mail-lj1-f193.google.com ([209.85.208.193]:45775 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727998AbfKDS3M (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Nov 2019 13:29:12 -0500
Received: by mail-lj1-f193.google.com with SMTP id n21so5143748ljg.12;
        Mon, 04 Nov 2019 10:29:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:from:to:cc:references:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=iurp4sakzOCEdz++tzDZDRAOZsuv2t30XmhXJuaXI1U=;
        b=FhP+Coa4xrCVJSA2wk7Q++T98lLzBYox7OuEhQcApIOnJrozp+CsznourVqj/8o78R
         5e/VbPwzAMaFVm9seppk9L8NuaEpUZJY4/QtAiZ3BSwuIh4t31v70qwf8BxK5xZSrmAG
         CtjYaOc/1agpSiXygv2Dkq88D1UAIZpe2mnu+2y7pWNOTJZf0LnCXjd/IRWpCX1Xr2JD
         i41vqVGZ8mBWtK0cRN0bjqlCN+FzKhe76TzrcSvGCCMLZcLU/ucPzp4tOYk4cdsQSWcj
         9VY6KEa6aA2lOD1nKBI0bHpPZSROO6a+ZIL+LMcD8qTf/gZ7hsOEGI7MmGAfkK+c7PZG
         6qXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:from:to:cc:references:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=iurp4sakzOCEdz++tzDZDRAOZsuv2t30XmhXJuaXI1U=;
        b=ZsgNSQRxDpKAIwmOCOLW98+fCp5qgUrYPFaEWIiv6oLKqgaJrbuEyVpt2Q7e8WQVv6
         D0/83GwWFrZtvMjNj+ujRwaZVgVCanU6o+7XcvQqddmUIhNJ4F3bSbUjjOIcSD9pU434
         GcctBJCWrZJm37dYsVKIsNicbM7cNue4S+pgDgQlv4L+KyDXxeRPyRbl6hQy+NmDmZtQ
         Ya/iJfn9C7NF5IalP0biVonnROZWVs7+MvVYnEZauBQEO3e9kpqQ5tPTDtRKcjJuPUUl
         pouOqsfSrnzWqlLJCIhuEM9q+bg9ohDhgMrHhQR3g3SaEQtp+F5lh/Dka9Pw0Rn9zbqL
         ZeMg==
X-Gm-Message-State: APjAAAU6LoNcgyZ1HAyrdhFZPU1d6mPuXctxMtJqErNK0BRfDFJVgaSD
        b58aqTTw4mYfQtOjZwFmn9I=
X-Google-Smtp-Source: APXvYqyQZbSkgVYTSJZRZbeBrgTs168W78IMreE/jqweUokSAkJEf3JMrVEnQd+u4Nw9Jlt1+JfhzQ==
X-Received: by 2002:a05:651c:1127:: with SMTP id e7mr11371383ljo.70.1572892149961;
        Mon, 04 Nov 2019 10:29:09 -0800 (PST)
Received: from [10.0.0.92] ([91.237.107.85])
        by smtp.gmail.com with ESMTPSA id a11sm7159646ljp.97.2019.11.04.10.29.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 04 Nov 2019 10:29:09 -0800 (PST)
Subject: [RFC PATCH 3/3] platform/x86: asus_wmi: Set default fan boost mode to
 normal
From:   Leonid Maksymchuk <leonmaxx@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     platform-driver-x86@vger.kernel.org,
        acpi4asus-user@lists.sourceforge.net, chiu@endlessm.com,
        yurii.pavlovskyi@gmail.com, kristian@klausen.dk,
        andy@infradead.org, dvhart@infradead.org, corentin.chary@gmail.com
References: <d3dbac09-3c93-c695-ae52-4b599a0a78c6@gmail.com>
Message-ID: <a0494561-3e48-d777-f228-e6dbe580f48a@gmail.com>
Date:   Mon, 4 Nov 2019 20:29:07 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.0
MIME-Version: 1.0
In-Reply-To: <d3dbac09-3c93-c695-ae52-4b599a0a78c6@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Set default fan boost mode to normal for multiple reasons:

1) existing code assumes that laptop started in normal mode and that is
    not always correct.
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
+	int result = 0;
+
+	if (asus->fan_boost_mode_available) {
+		asus->fan_boost_mode = ASUS_FAN_BOOST_MODE_NORMAL;
+		result = fan_boost_mode_write(asus);
+	}
+
+	return result;
+}
+
  static int fan_boost_mode_switch_next(struct asus_wmi *asus)
  {
  	u8 mask = asus->fan_boost_mode_mask;
@@ -2450,6 +2462,7 @@ static int asus_wmi_add(struct platform_device *pdev)
  	err = fan_boost_mode_check_present(asus);
  	if (err)
  		goto fail_fan_boost_mode;
+	fan_boost_mode_set_default(asus);
  
  	err = asus_wmi_sysfs_init(asus->platform_device);
  	if (err)
-- 
1.8.3.1

