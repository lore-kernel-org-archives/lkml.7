Return-Path: <SRS0=xa+R=Y4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9EB3ECA9EC9
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Nov 2019 21:34:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 60E3220663
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Nov 2019 21:34:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IzBzn7rT"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729719AbfKDVen (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 4 Nov 2019 16:34:43 -0500
Received: from mail-lj1-f193.google.com ([209.85.208.193]:37848 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728602AbfKDVem (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Nov 2019 16:34:42 -0500
Received: by mail-lj1-f193.google.com with SMTP id l20so664928lje.4;
        Mon, 04 Nov 2019 13:34:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=f4G0b4Obygl/9es40ye6c4vJu0dcrHqI1qZPAhJWA5g=;
        b=IzBzn7rTgFdSNP2vz4FylyK7hZALct7piKMK0UT2Pwegcd2Et0rC7PORBtE7fcmEIq
         DJ3SUCU3+Qh5TjrbEoMfWLggWQ082IOgHRRd1mR0eY8IJI3LOqOJyDyodXPvp1tqI8kZ
         s02hbJqpMhNxRiOdSyRg/AUTD73YbfZZBaSAJuWsEv4MdHn6GdMPOhtjcd77C1wsO7uw
         eLNJtK78IRJLwRWox0MQDNORFD6fdcaLkK3gbmKwIU9UOEqNIDdyDexVgrKZcJtMhp4L
         7B80K2fyhdd3rwMVKALkzopgkGbDX/52Rwk1QsFiTibw031A5WjJMlAYs7naA6rnkZql
         5XpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=f4G0b4Obygl/9es40ye6c4vJu0dcrHqI1qZPAhJWA5g=;
        b=XBxoi9SEyLkQDQk7YGm5f4lwHfklOg9hkHhqs1wdSNaQJMLXaUvOBHpPhy6Vz09C5m
         NyZYScdMsM0xm3+hwVNE6AZtMf5EmVcRlBwPNtXabKZuuGhjdJQPe5m7/BMzpQ6al1pS
         GYMuIMKanb4urwalzhgtfIBhaFhUfnBnOJH2GIKDQDszddx1aHpNda9jXXrM1z+xoTf3
         hvi0iHltSjbKtazUARoI1ujR6+h9rEjgoeoHP4F1906421Ly5xxZDcLc0bh09MKqhOTW
         3Az1YAFPOVZVijEUdvzdSzHGdOhF/ZFR/5Kka3ncezzvv4JM0Crrlqrj+O9L85lhl3ub
         CccQ==
X-Gm-Message-State: APjAAAUy603SXd1XhV1j2sijGsl7eVJqxPQYLQPIwNuiokhNrJRWAZUH
        6MjLWvRnwbr5FltDNoCr+d3rU3IjfZI=
X-Google-Smtp-Source: APXvYqxz3M6HCJRMuwHMqLXb/F2TzfwgO25hHvvLiCniwY27OH8x778qvS1tvbysXkc6Lm5xzEQcuA==
X-Received: by 2002:a2e:7c12:: with SMTP id x18mr11183266ljc.130.1572903280493;
        Mon, 04 Nov 2019 13:34:40 -0800 (PST)
Received: from localhost.localdomain ([91.237.107.85])
        by smtp.googlemail.com with ESMTPSA id m62sm85114lfa.10.2019.11.04.13.34.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Nov 2019 13:34:39 -0800 (PST)
From:   Leonid Maksymchuk <leonmaxx@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     platform-driver-x86@vger.kernel.org,
        acpi4asus-user@lists.sourceforge.net, chiu@endlessm.com,
        yurii.pavlovskyi@gmail.com, kristian@klausen.dk,
        andy@infradead.org, dvhart@infradead.org, corentin.chary@gmail.com,
        Leonid Maksymchuk <leonmaxx@gmail.com>
Subject: [PATCH v2 0/3] asus_wmi: Support of ASUS TUF laptops on Ryzen CPUs
Date:   Mon,  4 Nov 2019 23:34:17 +0200
Message-Id: <20191104213417.18036-1-leonmaxx@gmail.com>
X-Mailer: git-send-email 2.23.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

this patch series adds support of ASUS TUF laptops on Ryzen CPUs to existing
asus_wmi platform driver and also fixes minor bug.

v2: fixed indentation.

Leonid Maksymchuk (3):
  asus_wmi: Fix return value of fan_boost_mode_store
  asus_wmi: Add support for fan boost mode on FX505DY/FX705DY
  asus_wmi: Set default fan boost mode to normal

 drivers/platform/x86/asus-wmi.c            | 57 ++++++++++++++++++++++--------
 include/linux/platform_data/x86/asus-wmi.h |  1 +
 2 files changed, 43 insertions(+), 15 deletions(-)

-- 
1.8.3.1

