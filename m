Return-Path: <SRS0=uTOJ=ST=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1EE1BC282DA
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Apr 2019 23:12:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DC8A3217FA
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Apr 2019 23:12:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="uZIRDiS9"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387661AbfDQXM1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Apr 2019 19:12:27 -0400
Received: from mail-pf1-f182.google.com ([209.85.210.182]:44704 "EHLO
        mail-pf1-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387442AbfDQXM0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Apr 2019 19:12:26 -0400
Received: by mail-pf1-f182.google.com with SMTP id y13so159839pfm.11;
        Wed, 17 Apr 2019 16:12:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=9MeJfX8AhkDmLZiky0PXJ/7e+UR8rQn8VpbqN2N+3D8=;
        b=uZIRDiS9X9d/WeMZbegAimneyAs9RRW6uq8A8Sk5jpU/GRNrJ5uvwNvCzBW9/b/cwz
         IcUjebMzEpDMGn00KBBAgKdHR3VM0PhxFx0ETC8WqXorP8yuzPc/2ATs5/6TuGniyOIS
         qnbZ/eEqvz/WDyR342vJahRbOimB0KAsB6DPuG7/945vmI5W6fN93Kf4FhMj0JAe1uAm
         b95xSpPWZwYLEETqZz1sTak2KrU+KnsXCU1WkBsMkyqxHIHWBI/gV1TAphGMvfZEKm8c
         0ueP2OuNMMaBkDKsbbpoKIPYfVaB6P9JUvA5iUopYgBUsK1vckng1Jis2aUHfEv2dN/b
         isVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=9MeJfX8AhkDmLZiky0PXJ/7e+UR8rQn8VpbqN2N+3D8=;
        b=UlLe2pb6gVsjk/0GhRBZUADgPdm7J0Y9kwNOebryUbATf0Hr+xaq47mKHFNova48dO
         o0SudhpK6Vd5wSU46/vHDK91iZci/eXx+tddX3E7ltM23ShLeTUzaSbdyXhEcRWWwzsf
         yHsL3flPLX7b9Xkf3SF45jf+CpGhHayHPhrmqEYEdn3HAswBNMWGkwOYBUQba8B3gO58
         aw/JxvJv4M32Ylsb2TSId+T8IKfK+s3HjNgi5sDY+C4poYAnCEH5SnFeG1jLuFwTqDEd
         S1DoBLDR9VnXOIReuLC6MlStTlv7tlwu+3IuZnHeGJPezoLHhX9cru4Wsx24LfTp2tUj
         NVlw==
X-Gm-Message-State: APjAAAUU6jX+sC/1zviILdKkA5ejt+REqeVwHVREehz6/KliRJYkRV9S
        HevFq1qAGbGiijCmyp5Yr2duxTtLdm8=
X-Google-Smtp-Source: APXvYqzlVo3UOj45o/ATGbfQdIztfhqOTg0C+OatZHyLJiPi2VzxlqSoFqAB8nRNrI2uv2w8kta1Eg==
X-Received: by 2002:a63:c54a:: with SMTP id g10mr85002737pgd.71.1555542745940;
        Wed, 17 Apr 2019 16:12:25 -0700 (PDT)
Received: from Asurada-Nvidia.nvidia.com (thunderhill.nvidia.com. [216.228.112.22])
        by smtp.gmail.com with ESMTPSA id j62sm370466pfg.6.2019.04.17.16.12.24
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 17 Apr 2019 16:12:25 -0700 (PDT)
From:   Nicolin Chen <nicoleotsuka@gmail.com>
To:     jdelvare@suse.com, linux@roeck-us.net
Cc:     linux-hwmon@vger.kernel.org, linux-kernel@vger.kernel.org,
        corbet@lwn.net, linux-doc@vger.kernel.org
Subject: [PATCH v2 0/2] hwmon: (ina3221) Two changes for INA3221
Date:   Wed, 17 Apr 2019 16:12:08 -0700
Message-Id: <20190417231210.5762-1-nicoleotsuka@gmail.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Adding two changes for INA3221 HWMON driver.

Changlog
v1->v2:
 * Added PATCH-1
 * Rebased PATCH-2 (see detail of changelog in it)

Nicolin Chen (2):
  hwmon: (ina3221) Do not read-back to cache reg_config
  hwmon: (ina3221) Add voltage conversion time settings

 Documentation/hwmon/ina3221 |  9 +++++
 drivers/hwmon/ina3221.c     | 77 +++++++++++++++++++++++++++++--------
 2 files changed, 69 insertions(+), 17 deletions(-)

-- 
2.17.1

