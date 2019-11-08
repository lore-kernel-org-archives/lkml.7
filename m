Return-Path: <SRS0=1LW7=ZA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AFDC0FA372C
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Nov 2019 16:43:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 85CBA206A3
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Nov 2019 16:43:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WEgXKDDO"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726970AbfKHQnm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 Nov 2019 11:43:42 -0500
Received: from mail-lf1-f67.google.com ([209.85.167.67]:41432 "EHLO
        mail-lf1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726095AbfKHQnl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Nov 2019 11:43:41 -0500
Received: by mail-lf1-f67.google.com with SMTP id j14so4937655lfb.8;
        Fri, 08 Nov 2019 08:43:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=QQ9Okkt9tA9DcQ4nFpYeZ1WKHytWDSMkKTvTbeicM/E=;
        b=WEgXKDDOlyqloOBhHSSpkydfNPJ03NP3InerMKtkGE7BGl9rgKG8ashzNF8/l1+yR0
         H+IjxkCoWYJ1owLsaRCBPRQ6hocLxEmE0HkcSwMEwASexM4/dl5VKSLC0FZikE6TqJkq
         svoSmD3NDUTcsq92uGofM9gTB8MIJeVhmNYzxeUdGf3kIl3ARzSZAMf3QX0GfY1Hww/3
         09/PeZbkYQaefV5xpmNtyw/Kve4potPWEOl0cXRK2pZaXYLTZ2Il1aTPS3LdK1MWuGVU
         LUcX3LcWpM+dk7dDV0X0pPfn8rZGUcgCDd7YfwqFmaGq663F7E3gT1oxUjG3XEF3FCH8
         5Uug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=QQ9Okkt9tA9DcQ4nFpYeZ1WKHytWDSMkKTvTbeicM/E=;
        b=WNA3oWU5ZfJN5TcchMj/PjtBAES2VMAcnzTn67NeNbWMKunB8UbPPirmIDiR2Cgpty
         A58CAtnLygszhDkBOyCDF48gjZCWnxy1JG4E9E9YdcaI/qsFlnwKYc5Lz8TWu2UaLDSo
         +lrruAQJ/N3FgAffAyBBKT+9ivuptlZ8EEYeL6Yy/jY6uw8Vs6zwOc6NEZXVSacTHNrE
         oVM0Psgf3TwgqfWnYtal2WfZ93m7gP1Sk9EDoKJ/nE+aUAwk9RuaID8+GtVRt6t1RZtg
         l/k1aKPUyJj4B5vLSQ+ArNE59sxrExRfyNY5dCUaRbUSubxtmbuKRvFud8QH9EB40w8F
         6x5w==
X-Gm-Message-State: APjAAAVNIoc2DGWRoQPVAlj9DOS8/dv4phZiKSTw7ZHj9ZZhG7zR374o
        vhjPDc8hWpNWmWXnj1GHKzO4eQRyWAs=
X-Google-Smtp-Source: APXvYqyPGYgKX6sIBRZoLrk6RVsabIfXRiR0Rz/knooZTmYPnbXuSAVw6N4BvTqOogMFWgVCslX7rw==
X-Received: by 2002:ac2:4248:: with SMTP id m8mr7247338lfl.94.1573231419472;
        Fri, 08 Nov 2019 08:43:39 -0800 (PST)
Received: from localhost.localdomain ([91.237.107.85])
        by smtp.googlemail.com with ESMTPSA id a81sm3616844ljf.49.2019.11.08.08.43.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 Nov 2019 08:43:38 -0800 (PST)
From:   Leonid Maksymchuk <leonmaxx@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     platform-driver-x86@vger.kernel.org,
        acpi4asus-user@lists.sourceforge.net, chiu@endlessm.com,
        yurii.pavlovskyi@gmail.com, kristian@klausen.dk,
        andy@infradead.org, dvhart@infradead.org, corentin.chary@gmail.com,
        Leonid Maksymchuk <leonmaxx@gmail.com>
Subject: [PATCH v4 0/3] asus_wmi: Support of ASUS TUF laptops on Ryzen CPUs
Date:   Fri,  8 Nov 2019 18:43:17 +0200
Message-Id: <20191108164317.2874-1-leonmaxx@gmail.com>
X-Mailer: git-send-email 2.23.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

this patch series adds support of ASUS TUF laptops on Ryzen CPUs to
existing asus_wmi platform driver and also fixes minor bug.

v2: fixed indentation.
v3: patches 2/3 and 3/3 are refactored.
v4: patch 2/3 are simplified.

Leonid Maksymchuk (3):
  asus_wmi: Fix return value of fan_boost_mode_store
  asus_wmi: Support fan boost mode on FX505DY/FX705DY
  asus_wmi: Set default fan boost mode to normal

 drivers/platform/x86/asus-wmi.c            | 41 +++++++++++++++++-----
 include/linux/platform_data/x86/asus-wmi.h |  1 +
 2 files changed, 34 insertions(+), 8 deletions(-)

-- 
2.23.0

