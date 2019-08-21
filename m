Return-Path: <SRS0=xaRW=WR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CEB30C3A589
	for <linux-kernel@archiver.kernel.org>; Wed, 21 Aug 2019 00:18:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 39D862087E
	for <linux-kernel@archiver.kernel.org>; Wed, 21 Aug 2019 00:18:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Y+y5p8B0"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726554AbfHUASu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 20 Aug 2019 20:18:50 -0400
Received: from mail-pl1-f194.google.com ([209.85.214.194]:34972 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726372AbfHUASu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Aug 2019 20:18:50 -0400
Received: by mail-pl1-f194.google.com with SMTP id gn20so312927plb.2
        for <linux-kernel@vger.kernel.org>; Tue, 20 Aug 2019 17:18:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=57gZcRfgDGHX2fT3IVW27Y0VYhsGx0ciLsG0pvlDHNg=;
        b=Y+y5p8B0lzLHuW5kG8ttgFqeebFNxTZObxgwNZkCBWf+QQLk00bDixWY6RzBduTqFe
         edkSMEFNdGWiMeFMUGvE8Ae01qK/32fR2gRIRFVPzil18srA2XfLmQjEsfo8mzvUMVbA
         RL/7fcoiT827dXrb1ZWE6jpZ+ICelcQjWSlgt/twGBWHQp5Cl8AM1QMACZULkNzs57ED
         5xs/UTcKuYOkLDepi0uEoAzSc3ZgBU7E1IWpHOc+3KYCRw7OL4sY1yGjY8zlOahyLHS0
         7PdiWY1g4wEPPteK4PzrROEZ5K4ceX8WLZKAQhJgfIvYYIswBZXC7qYGmhxFijfxG4VM
         j8hQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=57gZcRfgDGHX2fT3IVW27Y0VYhsGx0ciLsG0pvlDHNg=;
        b=X3TXCrl1Z48v0Z/3/gCGpxS8ib/q7WY4VIUUKjUpcGcUK1U8DTW5hTc2Pnn2eO/fuQ
         SRkJ3P156G5gXb8EcpTOIm3UWffX7TrPBL5a9VrZc8j1E02dFyFAi0VgnGtKuE+smVaS
         6UM9nNfwIIHI9GliTTOWRB8ZmdSWixLddOFd44jx9CJ/7MDQSaaG7PvaYwJ3KN+zSn30
         WjxWr4B6SX9SfhyEzQk+0BpmaYsUanxrZsiE0rWV61n+dFmJUUksAPZNnu9OCd8kAsQg
         GiXAMBZlzYrwV+s/sLQWMytr5XofFO+aNVKHBGPyrNwJAEMaGCe3u+Xz6Ne8YbUUubbt
         clww==
X-Gm-Message-State: APjAAAX3jHhgel/W+0qp82zOwMPA4a0hBFhYBR1MJIIbrSz5VUGPisoj
        72HQKbWCBXWngDAiCozYhUY=
X-Google-Smtp-Source: APXvYqxQmbLxyDLbT0LkOLDX9rn36HoZ95N9Vdi5ziVyq4qecfy7S6EgpHIvECqUKI4WrFTEsbf1Iw==
X-Received: by 2002:a17:902:346:: with SMTP id 64mr31089028pld.151.1566346729667;
        Tue, 20 Aug 2019 17:18:49 -0700 (PDT)
Received: from localhost.localdomain (wsip-184-188-36-2.sd.sd.cox.net. [184.188.36.2])
        by smtp.googlemail.com with ESMTPSA id g2sm18806323pfm.32.2019.08.20.17.18.48
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 20 Aug 2019 17:18:49 -0700 (PDT)
From:   Caitlyn <caitlynannefinn@gmail.com>
To:     Gao Xiang <gaoxiang25@huawei.com>, Chao Yu <yuchao0@huawei.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Caitlyn <caitlynannefinn@gmail.com>,
        "Tobin C . Harding" <me@tobin.cc>, linux-erofs@lists.ozlabs.org,
        devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org
Subject: [PATCH 0/2] Submitting my first patch series (Checkpatch fixes)
Date:   Tue, 20 Aug 2019 20:18:18 -0400
Message-Id: <1566346700-28536-1-git-send-email-caitlynannefinn@gmail.com>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello!

This patch series cleans up some checkpatch fixes in erofs. The patches
include balancing conditional braces and fixing some indentation. No testing
done, all patches build and checkpath cleanly.

Caitlyn (2):
  staging/erofs/xattr.h: Fixed misaligned function arguments.
  staging/erofs: Balanced braces around a few conditional statements.

 drivers/staging/erofs/inode.c     |  4 ++--
 drivers/staging/erofs/unzip_vle.c | 12 ++++++------
 drivers/staging/erofs/xattr.h     |  6 +++---
 3 files changed, 11 insertions(+), 11 deletions(-)

-- 
2.7.4

