Return-Path: <SRS0=xYIU=RV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 554E3C43381
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Mar 2019 12:29:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 204E020854
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Mar 2019 12:29:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20150623.gappssmtp.com header.i=@bgdev-pl.20150623.gappssmtp.com header.b="kZsgkF7H"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726926AbfCRM3G (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Mar 2019 08:29:06 -0400
Received: from mail-wr1-f48.google.com ([209.85.221.48]:46396 "EHLO
        mail-wr1-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725973AbfCRM3G (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Mar 2019 08:29:06 -0400
Received: by mail-wr1-f48.google.com with SMTP id 33so16841532wrb.13
        for <linux-kernel@vger.kernel.org>; Mon, 18 Mar 2019 05:29:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=CQz0zn0pstfueJ5KOjdmhPoOyBM0THqguliDQKVgsdE=;
        b=kZsgkF7HsDajQyLrf59G7N4HX3OpXHnmS8W3nyfn9CM6c/EFQ/4BLEqSoqaBOtKXhO
         iUet6Y+V1hheVb11IaHEtX6TGYl1hln8LvTWRGtRQQnflbsuwHaT2FA15CyAT0m/EYet
         LsHw0e5J78TzvZUCOoDSzpOkqKmxLHVIhKsHNkUth4Hp+4yBJzeC+HIXHiR4kXN2ObcO
         ixt3FzP1vCN7MSziYLVQWCuv/iZvhg7c/ZHQXPMkR1rEzOUVY+usdslpw0R7C0wzUAQi
         R+uTcX2IvKLJgktq/QoeG8KjiWrzqDSNzgzAjuTwKwZck891peJmEHvlTQl/iGHgKxK4
         TE/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=CQz0zn0pstfueJ5KOjdmhPoOyBM0THqguliDQKVgsdE=;
        b=ebUDKVoeVsCrVfQDFJY+QMv2OWGbtKysOoAVZL8J/ChYovlaISBTb8cB0POFakWHKt
         gMlUIWsg/VOOH1ijEkvCd0WWJqKFzteBYkKUdohMPkBxK7WQGQj3cqUHQmE0Ve+7G8zu
         k6nnZRIElIMo3Az0jPYZE4bgUaLH1eaf5Sxqse59xLasqK5YKom5A3pvjtO3xi8aHgVt
         usOul/wx/Ih5bMMeOR6Llk/52adgfZvsEyku9EFN7xPz0YqgdcLEW1pzQapS54ejCV0T
         a8dG20FV9oUa+a/NAgeAkmvU6uqUfgsiKl4qDLGd9AsfQ5/e/0OaCvCi/MJTYHu8xkv3
         Z4uQ==
X-Gm-Message-State: APjAAAUdMof2S2y/3/ad1GNbXSqNooXsfWOQ5urm6dQR0DlHGZ/+oYrw
        kZ8FUDw/hWSZYly2CH5XX1mpfg==
X-Google-Smtp-Source: APXvYqxlYsbK1ymnOHMjOzBGub2AGPvfnPw3ry8rltdSAvMKfthI/db/buRjwn+20mwAdbqKbjCqEg==
X-Received: by 2002:adf:eac6:: with SMTP id o6mr11427324wrn.77.1552912144582;
        Mon, 18 Mar 2019 05:29:04 -0700 (PDT)
Received: from debian-brgl.home ([2a01:cb1d:af:5b00:6d6c:8493:1ab5:dad7])
        by smtp.gmail.com with ESMTPSA id v13sm2368112wmj.43.2019.03.18.05.29.03
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 18 Mar 2019 05:29:03 -0700 (PDT)
From:   Bartosz Golaszewski <brgl@bgdev.pl>
To:     Sekhar Nori <nsekhar@ti.com>, Kevin Hilman <khilman@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>,
        David Lechner <david@lechnology.com>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>
Subject: [RESEND PATCH 0/2] ARM: make DaVinci part of the ARM v5 multiplatform build
Date:   Mon, 18 Mar 2019 13:28:59 +0100
Message-Id: <20190318122901.7231-1-brgl@bgdev.pl>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Bartosz Golaszewski <bgolaszewski@baylibre.com>

Resending rebased on top of v5.1-rc1.

This series depends on the clocksource rework that's been earlier
posted to LKML[1].

The first one adds necessary bits and pieces for davinci to support
multiplatform build and the second one actually adds all davinci boards
to multi_v5_defconfig.

[1] https://lkml.org/lkml/2019/3/18/546

Bartosz Golaszewski (2):
  ARM: davinci: support multiplatform build for ARM v5
  ARM: multi_v5_defconfig: make DaVinci part of the ARM v5 multiplatform
    build

 arch/arm/Kconfig                       | 21 ---------------------
 arch/arm/configs/davinci_all_defconfig |  5 +++++
 arch/arm/configs/multi_v5_defconfig    | 12 ++++++++++++
 arch/arm/mach-davinci/Kconfig          | 16 ++++++++++++----
 arch/arm/mach-davinci/Makefile         |  2 ++
 5 files changed, 31 insertions(+), 25 deletions(-)

-- 
2.20.1

