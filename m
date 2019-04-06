Return-Path: <SRS0=Ybdz=SI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_MUTT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BAEDEC10F06
	for <linux-kernel@archiver.kernel.org>; Sat,  6 Apr 2019 13:14:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 883DE2173C
	for <linux-kernel@archiver.kernel.org>; Sat,  6 Apr 2019 13:14:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="uYWtEfqo"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726524AbfDFNOV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 6 Apr 2019 09:14:21 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:47020 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726316AbfDFNOU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 6 Apr 2019 09:14:20 -0400
Received: by mail-pf1-f193.google.com with SMTP id 9so4829223pfj.13;
        Sat, 06 Apr 2019 06:14:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=hCAUtgWINKqs78bBNa2DDxceJ2zmLMJLMaYO2OB0oPo=;
        b=uYWtEfqo2kWmDQXH9fH7Uvnt0M5c/Km8lh/UF8z94P3V59U+2shuUVK4zAJ5PEIxO1
         It9NxNqf80uC7y4gtyrE4Y974rU0+RODBrlB3n1YcVGicVz0ZrrYvscma44CUF1JnkuA
         FS5fSyY2qcSbkKZrG9lqWuVtLZO8pc8Zj6LTWOTJL4iPRC8ddlA1dG2b9JEKiYXNYH6j
         f9gqZV9mhCXyoDgL4k9PjPNHh+t9SFyS3fm42AjVBBIaNB7wISyYwxwAklWoAUjfzMF8
         9/AtvaLEKW5yMABZEDrF90YZG65yD4p7uGRXwnNyDUJx2cvJUKMFQ8y8X2v/sCtCZXW1
         AfHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=hCAUtgWINKqs78bBNa2DDxceJ2zmLMJLMaYO2OB0oPo=;
        b=XfkC6P8BlSyfC4yeZuk6i8XPSlKljSSjW0ovKMoItOTO20dg0KDda56mq84rQ/7l6Q
         L0W92KRDSkjXaiXNX/+dYHog+NKpAN/OaHWIDdXgPasc4ug57nhkFYx9RNto6aQ1wgsS
         1twn9U4+7N8y1N7nmyUPEek71HGR0tRNRlB1TFibyBlIk/dTIWFJR2DW1DLpa5ZHI1XM
         d+PaqoJGRwEAl6K8W5lbU7VSv5Ig29U81RdDgl4tXQdW9jo7fcm5JvZduhREhceTS+YZ
         N+GQWmvXKQAuPY7FK9RIck1jCFWEaz/WvJsSJeiw1Ixk/KhU2a6+lbWgoTpCT6xJqHg0
         RiLw==
X-Gm-Message-State: APjAAAVug//2JWT7CgAUO7Le1HevVGMVzqthYR47bFmgTM7TG4OPgdG8
        JPkLIwsKj5T4n9plycqpffBVQzD3
X-Google-Smtp-Source: APXvYqySlyWNDRO+FY/yxvS7TZDAitQimbUHxVFC1BnLjqjMTmfAFYIE7ojdFycF7O+lRQszUL21zg==
X-Received: by 2002:a62:121c:: with SMTP id a28mr18563648pfj.58.1554556459933;
        Sat, 06 Apr 2019 06:14:19 -0700 (PDT)
Received: from hari-Inspiron-1545 ([183.83.91.90])
        by smtp.gmail.com with ESMTPSA id b14sm36416569pfi.92.2019.04.06.06.14.17
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 06 Apr 2019 06:14:18 -0700 (PDT)
Date:   Sat, 6 Apr 2019 18:44:15 +0530
From:   Hariprasad Kelam <hariprasad.kelam@gmail.com>
To:     Wim Van Sebroeck <wim@linux-watchdog.org>,
        Guenter Roeck <linux@roeck-us.net>,
        linux-watchdog@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] watchdog: machzwd : fix warning Using plain integer as NULL
 pointer
Message-ID: <20190406131415.GA3844@hari-Inspiron-1545>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Changes passing function argument 0 to NULL to avoid below sparse
warning

 CHECK   drivers/watchdog//machzwd.c
drivers/watchdog//machzwd.c:321:25: warning: Using plain integer as NULL
pointer

Signed-off-by: Hariprasad Kelam <hariprasad.kelam@gmail.com>
---
 drivers/watchdog/machzwd.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/watchdog/machzwd.c b/drivers/watchdog/machzwd.c
index 88d823d..c3926d0 100644
--- a/drivers/watchdog/machzwd.c
+++ b/drivers/watchdog/machzwd.c
@@ -318,7 +318,7 @@ static long zf_ioctl(struct file *file, unsigned int cmd, unsigned long arg)
 	case WDIOC_GETBOOTSTATUS:
 		return put_user(0, p);
 	case WDIOC_KEEPALIVE:
-		zf_ping(0);
+		zf_ping(NULL);
 		break;
 	default:
 		return -ENOTTY;
-- 
2.7.4

