Return-Path: <SRS0=s1fu=UU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6E216C43613
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Jun 2019 10:57:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3B13020673
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Jun 2019 10:57:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="Spoip36r"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726414AbfFUK5c (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Jun 2019 06:57:32 -0400
Received: from mail-pf1-f195.google.com ([209.85.210.195]:38776 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726232AbfFUK5b (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Jun 2019 06:57:31 -0400
Received: by mail-pf1-f195.google.com with SMTP id a186so3417580pfa.5
        for <linux-kernel@vger.kernel.org>; Fri, 21 Jun 2019 03:57:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=m4SystdEUYyTsZI3hnmFt3ur3sFjiDU6l/WcXNGnPvU=;
        b=Spoip36rQtmU/CyiMWVfJkYQIPink69AqYVxGtT0MpDnfdIT8FRP/FE3WbuZtH5Udb
         1zQ5J4mGDp2M57h6LgFxrEwKsi5/LPSA+xfL19vy/+41LBqTRapVUYPTVqEibPZwyN6t
         xGC0HNetqBxwnbd7RVVshUR/qKe85V/san+6PTJT6etBRJhBdK64vEVvBUd2CaOA7EJV
         kfSAnaKfW3RjlHQ2PbyyCGa/nW3NLdWUCU9APcgtpzH5+MwdjIAphhPYGrKy1y9onmIP
         Q4/C+TtHoKZxaIdW4Vgy5uoMErHjx+atNADwwvOjae2ibnebibV/f9Bs1b/Fsnfe0tXN
         hDJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=m4SystdEUYyTsZI3hnmFt3ur3sFjiDU6l/WcXNGnPvU=;
        b=Ca9CJgT77Qbj2wdcNmX2OHWGi8sXdHBYzXDWZSgaD2WHnNX3EJUF8/3aZ94T8sdPPh
         g5Mfsig4B/liif+BJhAdEzQtck1BTrFqHXTiKfSTW66WEcZwdhOQF+wwZBjWo1kqYhUI
         lo+4/CLnaO3hUs39QmH2HM3r1WE2VJyq8LOz2MIFr24K33fjAk14EqdfFpVCb209b+B2
         eOE+ECCinUY9xa15XrsfGf1dpVyGwopPomG0loO4RrWufcnxI63nPcT+HYGR14wWDMrM
         L9TbeKeqI/PSG4UJo6he/LVUfTSEzuZX4nAdKiA94B4hQUZPPI+jnNK4K6M2Xld/LK0B
         aqTA==
X-Gm-Message-State: APjAAAWDWuxxjfh9XHuaRkUjLgS5KxgAxXtkUyiX5Yb6OAKqiOXY4N3z
        IH1wysl6aGF0sdwLXqGMzocmCg==
X-Google-Smtp-Source: APXvYqwzjjm4483alu65arc4JSsx+I/alCHC31k15aRzcosRcQA2NcisAKHpGycWDhXMyiza4ypiEg==
X-Received: by 2002:a63:c20e:: with SMTP id b14mr17159994pgd.96.1561114650984;
        Fri, 21 Jun 2019 03:57:30 -0700 (PDT)
Received: from buildserver-90.open-silicon.com ([114.143.65.226])
        by smtp.googlemail.com with ESMTPSA id q63sm3889442pfb.81.2019.06.21.03.57.26
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 21 Jun 2019 03:57:30 -0700 (PDT)
From:   Yash Shah <yash.shah@sifive.com>
To:     robh+dt@kernel.org, paul.walmsley@sifive.com,
        devicetree@vger.kernel.org, linux-riscv@lists.infradead.org,
        linux-kernel@vger.kernel.org
Cc:     mark.rutland@arm.com, palmer@sifive.com, aou@eecs.berkeley.edu,
        sachin.ghadi@sifive.com, Yash Shah <yash.shah@sifive.com>
Subject: [PATCH v2] DT node for SiFive FU540 Ethernet Controller driver
Date:   Fri, 21 Jun 2019 16:23:48 +0530
Message-Id: <1561114429-29612-1-git-send-email-yash.shah@sifive.com>
X-Mailer: git-send-email 1.9.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch-set is based on 'riscv-for-v5.2/fixes-rc6' tag of
git://git.kernel.org/pub/scm/linux/kernel/git/riscv/linux.git

Tested on HiFive Unleashed board with additional patches required for
testing can be found at dev/yashs/ethernet_dt_v2 branch of:
https://github.com/yashshah7/riscv-linux.git

Change history:
v2:
- Set "status = disabled" in DTSI file and enable it in Board DTS file
- Move PHY related nodes into board DTS file

Yash Shah (1):
  riscv: dts: Add DT node for SiFive FU540 Ethernet controller driver

 arch/riscv/boot/dts/sifive/fu540-c000.dtsi          | 16 ++++++++++++++++
 arch/riscv/boot/dts/sifive/hifive-unleashed-a00.dts |  9 +++++++++
 2 files changed, 25 insertions(+)

-- 
1.9.1

