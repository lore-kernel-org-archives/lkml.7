Return-Path: <SRS0=kjqD=WY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D5825C3A5A1
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Aug 2019 06:22:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A71E62070B
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Aug 2019 06:22:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726605AbfH1GW0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 28 Aug 2019 02:22:26 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:59759 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726052AbfH1GWZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Aug 2019 02:22:25 -0400
Received: from mail-pl1-f200.google.com ([209.85.214.200])
        by youngberry.canonical.com with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
        (Exim 4.76)
        (envelope-from <kai.heng.feng@canonical.com>)
        id 1i2rLb-0006P8-9j
        for linux-kernel@vger.kernel.org; Wed, 28 Aug 2019 06:22:23 +0000
Received: by mail-pl1-f200.google.com with SMTP id z7so959285plo.3
        for <linux-kernel@vger.kernel.org>; Tue, 27 Aug 2019 23:22:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:content-transfer-encoding:mime-version
         :subject:message-id:date:cc:to;
        bh=eErmgvLWpTvw79t37fqW5by++pBkMN7PzJVZAaJiWBc=;
        b=mHWQ1wofbm3tDV2AQwTNyjlDBkkhxHlwAZ1xRZo3KQb1m1lcM0H/SMNPsOQFmi3DOP
         xuZupPBqvIgi2hG9QBQ0bQPFKtuARqe5842NyzbhzEC9niH2dnwxU6JpyebpNM2thT2k
         OdXGUvQ4j+MzqI5l5hd6dm5ucL99tVji4eEEtHhEDTPlUq6bdL2zO2u6rOyfvfqfL5Gz
         GWx+s9pYvjjUmpMwYHVYC1IPC/bhO8L6OcALDOzvArCqm4TvLxstdmNaNAvgvcyt2pq9
         tnoEcwFcJLmtIcr1nkrSWHz+2JZDwdk4OvkOUoNQ7f5zHARNiNCsYbdkz6IEkYp4viqf
         Xp7A==
X-Gm-Message-State: APjAAAUdYKHYbaGL8f8hNHBOMgkqbNSsimkYXymDjeTdOuvbqNBiM4+Y
        wKPiPT+Aw48apshJDAMV8q9RwBq05rL/2bOwv8i/KxaGMQo0qRW2M53dxFHI8+t3sswwBqRBlXO
        WP/aLP1h/vTO7R9AsAsyfbuI4bm5ZPvZ4thSxVSj5bQ==
X-Received: by 2002:a65:464d:: with SMTP id k13mr1846281pgr.99.1566973341974;
        Tue, 27 Aug 2019 23:22:21 -0700 (PDT)
X-Google-Smtp-Source: APXvYqwzeZJ2AZhXpkhXpayJAnLK5l71RX5LcrFzSIL3dvryq9eP2qoVpnsbjyIl6xOIA9bblIN0nA==
X-Received: by 2002:a65:464d:: with SMTP id k13mr1846256pgr.99.1566973341602;
        Tue, 27 Aug 2019 23:22:21 -0700 (PDT)
Received: from 2001-b011-380f-3c42-f8f8-a260-49a8-d1ed.dynamic-ip6.hinet.net (2001-b011-380f-3c42-f8f8-a260-49a8-d1ed.dynamic-ip6.hinet.net. [2001:b011:380f:3c42:f8f8:a260:49a8:d1ed])
        by smtp.gmail.com with ESMTPSA id r75sm1524386pfc.18.2019.08.27.23.22.20
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 27 Aug 2019 23:22:21 -0700 (PDT)
From:   Kai-Heng Feng <kai.heng.feng@canonical.com>
Content-Type: text/plain;
        charset=utf-8;
        delsp=yes;
        format=flowed
Content-Transfer-Encoding: 8bit
Mime-Version: 1.0 (Mac OS X Mail 12.4 \(3445.104.11\))
Subject: Alps touchpad generates IRQ storm after S3
Message-Id: <44F93018-5F13-4932-A5AC-9D288CDF68DD@canonical.com>
Date:   Wed, 28 Aug 2019 14:22:18 +0800
Cc:     Mario Limonciello <mario.limonciello@dell.com>,
        "open list:HID CORE LAYER" <linux-input@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
To:     masaki.ota@jp.alps.com
X-Mailer: Apple Mail (2.3445.104.11)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Masaki,

The Alps touchpad (044E:1220) on Dell Precision 7530 causes IRQ storm after  
system suspend (S3).
Commit "HID: i2c-hid: Don't reset device upon system resume” which solves  
the same issue for other vendors, cause the issue on Alps touchpad.
So I’d like to know the correct command Alps touchpad expects after system  
resume.

Also Cc Mario because this could relate to BIOS.

Kai-Heng
