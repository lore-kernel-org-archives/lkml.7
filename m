Return-Path: <SRS0=wo+8=V5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9B5B1C433FF
	for <linux-kernel@archiver.kernel.org>; Thu,  1 Aug 2019 19:51:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7237B20B7C
	for <linux-kernel@archiver.kernel.org>; Thu,  1 Aug 2019 19:51:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=starry.com header.i=@starry.com header.b="l7eWYEuc"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388784AbfHATvH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 1 Aug 2019 15:51:07 -0400
Received: from mail-qk1-f172.google.com ([209.85.222.172]:45695 "EHLO
        mail-qk1-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388658AbfHATvH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Aug 2019 15:51:07 -0400
Received: by mail-qk1-f172.google.com with SMTP id s22so53058031qkj.12
        for <linux-kernel@vger.kernel.org>; Thu, 01 Aug 2019 12:51:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=starry.com; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=3xy7RQ3BcymipnwY3KhbWAO8+bYN3ROc+uKInAGvCg8=;
        b=l7eWYEucOk3aQcAluytArXZ1+7RhXcdcblpXe5YCqaVeLM2GXlvS+PbH9iBpmkZVXL
         l28N1lMutvdEg/HLhZfQVplK+E1wfV+RKcMPLCF8ZwzMBbM7vniv/cIAmYIc9hOMhj0Z
         xX3qSQBpwu5bAoePP6JKHKtiyyGkpuIHfu3OU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=3xy7RQ3BcymipnwY3KhbWAO8+bYN3ROc+uKInAGvCg8=;
        b=AszjdoDz+z11WZJ7eGcUqBgCvYNVEAqpKOvzyeTes29dDiY5vOs71Qyq0axzjRRHXi
         Ds3CgdNED3CcnqlkVSWUzIxWchR09KEjZkc2nwgirrT0KiGzC4oQ6gS0mre6jO+d2PRL
         S3WjK6aqHnD95YEFW+3jew+TrEBB7T26Rcq9NcsG8bq2KUfPEmnXpNZbiqDgLhW8/1/+
         84grSa9mM1TvJAuUG4l2Quti0EAjYlRJj9RvyTf9tnRBlVzcLjhBHyrG4KSDylerPtqa
         VYXaR9NZ6sGhewrMs6tl/7/hP4EOrbJOtK4U0001gKGmEBQuk9u1E2bLPq+YvCLURWaM
         uDTQ==
X-Gm-Message-State: APjAAAXfccN2lxExGX0hUW98bexSu8beOmQwmBh2E3jI0n0o50LsLq5M
        mLrYscX48J7beqApPYP3Yq/ASavde6o=
X-Google-Smtp-Source: APXvYqxMusU8LcG0GuZiWpzooN842V1Hz/+Gj/4n/hrs1fuTqZuvwd7c2V1eUklFbhk3V1YTPzMz4Q==
X-Received: by 2002:a37:395:: with SMTP id 143mr26783147qkd.317.1564689065981;
        Thu, 01 Aug 2019 12:51:05 -0700 (PDT)
Received: from localhost.localdomain (205-201-16-55.starry-inc.net. [205.201.16.55])
        by smtp.gmail.com with ESMTPSA id h4sm31271944qkk.39.2019.08.01.12.51.05
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Thu, 01 Aug 2019 12:51:05 -0700 (PDT)
From:   Matt Pelland <mpelland@starry.com>
To:     linux-kernel@vger.kernel.org
Cc:     kishon@ti.com, antoine.tenart@bootlin.com,
        linux-arm-kernel@lists.infradead.org
Subject: [PATCH] phy: marvell: phy-mvebu-cp110-comphy: Implement RXAUI Support
Date:   Thu,  1 Aug 2019 15:50:57 -0400
Message-Id: <20190801195059.24005-1-mpelland@starry.com>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch set introduces support for configuring Marvell's cp110 comphy for
RXAUI operation. I can post the other half of these patches (for mvpp2) here if
need be but I'm preparing to submit them to netdev shortly. I've tested this on
a Marvell Armada 7040 based platform with no issues.


