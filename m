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
	by smtp.lore.kernel.org (Postfix) with ESMTP id B86A8CA9EB5
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Nov 2019 18:26:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8A7B820869
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Nov 2019 18:26:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YBrxIv6U"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729499AbfKDS0k (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 4 Nov 2019 13:26:40 -0500
Received: from mail-lj1-f195.google.com ([209.85.208.195]:39962 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727998AbfKDS0k (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Nov 2019 13:26:40 -0500
Received: by mail-lj1-f195.google.com with SMTP id q2so12209937ljg.7;
        Mon, 04 Nov 2019 10:26:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:from:to:cc:references:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=aM/NqY9X7bejgM2hiDB5HuQIJW6HNTiHKqYAR0ieXv4=;
        b=YBrxIv6UrijO5SS6pz/P6wAwlVWcSD+pk1Qxi+ZdOCSGV9b/VHYT286G/hoFHd7r14
         +QR47o9s7Lacdgs3WpbBgWW182/Rvr8pmJ/+gkl8pFKO20ahJj62atzX5iKL3PA4FxiL
         gCSSW9DXeHSadbLtl6SiuT2VOpzK3tItjqcuWJSPoRpWTr9rBB9m5BBh9fdAMj0U023b
         Vi2S0RzbA64YznCBkKa3fU2zKd/7buvAXfRxvAVLlvLqaq9k4atlN+DpA8bK8eY8aBfO
         lbzIZG2mpuzklUIrrwHPMdMGYiPoIuoKw8yrWxn0vbHRPMdDW8sZdPow3fnwNYoorrvn
         rsrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:from:to:cc:references:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=aM/NqY9X7bejgM2hiDB5HuQIJW6HNTiHKqYAR0ieXv4=;
        b=aMdDOtGhywssH9vhYz0IG3mHk6a5ao+9963zXDw0+StmxaYSc+GQT9GE+FbiajnMgu
         xA4IoeY/sTSU2P5wxQreTS1RwMEf90A11dr0Hs+q67FG5uCjvc0EqybNzvd2NQZOHNhf
         KNBLJCALzK/Ak7iKJjrPiJ5EX7o9U3cv728DyUXcISAH/yJeuGoDm/+T5E1bt0EFBn0Y
         /TOzSmqgCWLOihEEOb99Dav6TRvrx//DOhMDYgeNQMokXrhxVjZA3npwyzCmYPzN6T4Z
         p6/tq1fg37XtNAtV8BUa+V7pN2bFhIQWuo2+Kf77E1Fxzx5MV8VjdkGqdJtYA49/BZf4
         SqPA==
X-Gm-Message-State: APjAAAXTH+QLCHhXBZo3ydZZOoBjKapV4mSBQVicBDaF5WcjkIs1J+aB
        RAOYS3mxL+GK/tlG/g4ZVdY=
X-Google-Smtp-Source: APXvYqxFiVpWB2HnWSrfAlikObQNMCR3fieTkw2KFMjLHb+7UhapvHY+NYuyfmMkjXOyj9hATZLBIQ==
X-Received: by 2002:a2e:3a1a:: with SMTP id h26mr19999494lja.25.1572891998287;
        Mon, 04 Nov 2019 10:26:38 -0800 (PST)
Received: from [10.0.0.92] ([91.237.107.85])
        by smtp.gmail.com with ESMTPSA id t10sm7394339ljt.68.2019.11.04.10.26.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 04 Nov 2019 10:26:37 -0800 (PST)
Subject: [RFC PATCH 1/3] platform/x86: asus_wmi: Fix return value of
 fan_boost_mode_store
From:   Leonid Maksymchuk <leonmaxx@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     platform-driver-x86@vger.kernel.org,
        acpi4asus-user@lists.sourceforge.net, chiu@endlessm.com,
        yurii.pavlovskyi@gmail.com, kristian@klausen.dk,
        andy@infradead.org, dvhart@infradead.org, corentin.chary@gmail.com
References: <d3dbac09-3c93-c695-ae52-4b599a0a78c6@gmail.com>
Message-ID: <6452b246-ab31-2a0e-8324-f951681154af@gmail.com>
Date:   Mon, 4 Nov 2019 20:26:34 +0200
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

Function fan_boost_mode_store should return number of bytes written
but instead it returns return value of kstrtou8 which is 0 if
conversion is succefull. This leads to infinite loop after any
write to it's SysFS entry.

Fixes: b096f626a682 ("platform/x86: asus-wmi: Switch fan boost mode")
Signed-off-by: Leonid Maksymchuk <leonmaxx@gmail.com>
---
  drivers/platform/x86/asus-wmi.c | 2 +-
  1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/platform/x86/asus-wmi.c b/drivers/platform/x86/asus-wmi.c
index 821b08e..723aa4d 100644
--- a/drivers/platform/x86/asus-wmi.c
+++ b/drivers/platform/x86/asus-wmi.c
@@ -1718,7 +1718,7 @@ static ssize_t fan_boost_mode_store(struct device *dev,
  	asus->fan_boost_mode = new_mode;
  	fan_boost_mode_write(asus);
  
-	return result;
+	return count;
  }
  
  // Fan boost mode: 0 - normal, 1 - overboost, 2 - silent
-- 
1.8.3.1

