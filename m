Return-Path: <SRS0=uOpN=TO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 193CDC04AB4
	for <linux-kernel@archiver.kernel.org>; Tue, 14 May 2019 19:03:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D688C20881
	for <linux-kernel@archiver.kernel.org>; Tue, 14 May 2019 19:03:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Fk3l+KWq"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727733AbfENTD5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 May 2019 15:03:57 -0400
Received: from mail-wm1-f66.google.com ([209.85.128.66]:54182 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726261AbfENTD5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 May 2019 15:03:57 -0400
Received: by mail-wm1-f66.google.com with SMTP id 198so186149wme.3;
        Tue, 14 May 2019 12:03:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:from:cc:references:message-id:date:user-agent:mime-version
         :in-reply-to:content-language:content-transfer-encoding;
        bh=sYVFDe3XqiJYZ+Tuzea4frhnmRETpX1L6lMup8xZtl4=;
        b=Fk3l+KWqIIZwCrXmXQw/HBB3jC+TlCkRV1reTLvun1PUrOnB7zdmo8Ou5HysPsE8Sx
         UQUwsTPMDVj4C74rilPIyn6TLodnbCnyn/C0xaCg1s1eTv17MIfJTbnfm1VKN4s5Vor0
         jnsoCvjMMMk1NxVmRGYU5i0bo7f6xbgqWHFpcXd0JHxR5frVSA/gVZlDUNrKOoP7687x
         q7TVwTHy0vz2JBwRQ6p3N3WIPgnwHZ3Fb47cHmsP00yPhhm8jAkWy1fSeiTN7uXncxFR
         jfsiqXrEKCrr06TSKlt4cokIokIDSrtfinGxMq3XN5mVP3adCl+r//B9MfcLK3034BSu
         YZuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:from:cc:references:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=sYVFDe3XqiJYZ+Tuzea4frhnmRETpX1L6lMup8xZtl4=;
        b=D75rEJMqDh29+7f626yPbdhfuckQiA816oE7bTBaw0pArY3NugARIOmaUmok1wIUJt
         u7H5UKIztBq4ICc40spHLZE1qs/dLnHFbjDSV5aS0qsdjoXylYZyJ+NlqVRNhgAY493j
         Cdfr2ppf3ZczrivytK90VYFRqIdcJ9mRX5UMBTvopN0hWYb5o/u0NQmb1XygFHhCEZWw
         Ngfw82V33yH0IyLSanD6vVzKsFHKFzcDeGNNF5Ne3ESxgs/M/IDtM/uQsxK04TXvS2N+
         T1BofN98kmKpNhd4xvl6XvLhfpa/RiV+iDXu2P+3Nn1ACT13WTVZz3w01MUZSMkRlbSi
         KOUg==
X-Gm-Message-State: APjAAAVFlZlzGFG7FUfcCc2piZ62QZ0k0Ybwt8yLLK+Ii96OFEwus0MU
        /wu6C2uG/VKbqhO8uEtz8GMDyhPm
X-Google-Smtp-Source: APXvYqyX0XNMs0j6zQtvmRM5tuqM0jYm2QFJfJx+fzJ9g3rwQQRpJBojJeR+Q/sFDCgqkEnfDi2PJg==
X-Received: by 2002:a1c:9d0f:: with SMTP id g15mr21128730wme.97.1557860634659;
        Tue, 14 May 2019 12:03:54 -0700 (PDT)
Received: from [192.168.20.141] ([194.99.104.18])
        by smtp.gmail.com with ESMTPSA id 15sm3999650wmg.36.2019.05.14.12.03.53
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 14 May 2019 12:03:54 -0700 (PDT)
Subject: [PATCH v4 09/13] platform/x86: asus-wmi: Refactor error handling
From:   Yurii Pavlovskyi <yurii.pavlovskyi@gmail.com>
Cc:     Corentin Chary <corentin.chary@gmail.com>,
        Darren Hart <dvhart@infradead.org>,
        Andy Shevchenko <andy@infradead.org>,
        Daniel Drake <drake@endlessm.com>,
        Chris Chiu <chiu@endlessm.com>,
        acpi4asus-user@lists.sourceforge.net,
        platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org
References: <c8cdb347-e206-76b2-0d43-546ef660ffb7@gmail.com>
Message-ID: <18233d8b-0724-f0c7-2931-def225bd650c@gmail.com>
Date:   Tue, 14 May 2019 21:03:50 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <c8cdb347-e206-76b2-0d43-546ef660ffb7@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove exit label as it is only used once from the point in code where no
cleanup is required and return can be called immediately.

Signed-off-by: Yurii Pavlovskyi <yurii.pavlovskyi@gmail.com>
---
 drivers/platform/x86/asus-wmi.c | 6 +-----
 1 file changed, 1 insertion(+), 5 deletions(-)

diff --git a/drivers/platform/x86/asus-wmi.c b/drivers/platform/x86/asus-wmi.c
index 7bfac06abae4..090a00af4017 100644
--- a/drivers/platform/x86/asus-wmi.c
+++ b/drivers/platform/x86/asus-wmi.c
@@ -255,7 +255,7 @@ static int asus_wmi_evaluate_method3(u32 method_id,
 				     &input, &output);
 
 	if (ACPI_FAILURE(status))
-		goto exit;
+		return -EIO;
 
 	obj = (union acpi_object *)output.pointer;
 	if (obj && obj->type == ACPI_TYPE_INTEGER)
@@ -266,10 +266,6 @@ static int asus_wmi_evaluate_method3(u32 method_id,
 
 	kfree(obj);
 
-exit:
-	if (ACPI_FAILURE(status))
-		return -EIO;
-
 	if (tmp == ASUS_WMI_UNSUPPORTED_METHOD)
 		return -ENODEV;
 
-- 
2.17.1

