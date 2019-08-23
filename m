Return-Path: <SRS0=31nU=WT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4B2D0C3A5A2
	for <linux-kernel@archiver.kernel.org>; Fri, 23 Aug 2019 08:14:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0B85A233A2
	for <linux-kernel@archiver.kernel.org>; Fri, 23 Aug 2019 08:14:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="yyPg/dah"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404406AbfHWIOc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 23 Aug 2019 04:14:32 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:43674 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387647AbfHWIOc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Aug 2019 04:14:32 -0400
Received: by mail-wr1-f65.google.com with SMTP id y8so7775450wrn.10
        for <linux-kernel@vger.kernel.org>; Fri, 23 Aug 2019 01:14:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=p/dmfnR+UyPL3cfGh6Tcm8LcRn0ZKE9YaND2fk1NH2Y=;
        b=yyPg/dahGVPnd10/YstcWu13LfyvUbPCagDdchUUo2M/ySvhyUVmcaIZK5JCG/z8BC
         1NqikkwjDSULYFKbgXAstzFPevXA/ttINob/6a5g3opj6SqYbVkP1T9KYXRLQsyOaeZ5
         DnmEoXJyBjQbV+En3rBuaAG7VqgXTfJlgH2HVvzpoXHi4dql+YyUnzlpSCMx66Ek/SaA
         9ZYtc2mYhjbvIvGHG7JVu6y/gevhoCttbeGfdne/LjcDZUOH+HUktrAInoPeE/G1hhAx
         14eIO0UIUCTBBr5VITI0afqTa1vOZCos9pABtPyrBxjpvNZ3/5bk3U+aQ+BsybejiXed
         3+DA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=p/dmfnR+UyPL3cfGh6Tcm8LcRn0ZKE9YaND2fk1NH2Y=;
        b=iERWMcLpmMnXEL0YiGzA8rvz7id8YjQX3ggckKFWS0WiUkk+kL8aQPFhe+N29lxYjv
         bKavILCo+vzZMU/QvCmXLRCr/mOnZ9FMuaprnN0jC6uC5eH3MZynQAvG74AofJIuK7Pk
         40hE8u8wqO8iQLV/IsTF48KuYmoKmWMAcSddk5fjX90g3Xj3opOOuDin8cVFPmeKkTnV
         BMN2NY3AiIbN6lg3Sg5P4yInvNUCBS3BHOqNT4j2dzReIObzspj2WPd2ru38aKRTSdlm
         bj0GsEV9q35mALk1yz7IG5Zul7/0j4rpEgTdfj/BZ4/94UbyKNk6DYmRPZRbe0T7pw+U
         wGpQ==
X-Gm-Message-State: APjAAAVwZOCTHp23BSFGuxHv3bBh5cThLmt24u1NlHeoQG9BKQgXOm9q
        RL/11xc+Xu8NrjlnmVa25ENAtA==
X-Google-Smtp-Source: APXvYqxSguZHrzvEBqYsIAePNZy235amcZ0FUJeSS9jeXh+GJxYdDqD5WfwsNnUyYL9qyLknD6HecQ==
X-Received: by 2002:adf:e50b:: with SMTP id j11mr3505523wrm.65.1566548070242;
        Fri, 23 Aug 2019 01:14:30 -0700 (PDT)
Received: from bender.baylibre.local (lmontsouris-657-1-212-31.w90-63.abo.wanadoo.fr. [90.63.244.31])
        by smtp.gmail.com with ESMTPSA id 74sm3632535wma.15.2019.08.23.01.14.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Aug 2019 01:14:29 -0700 (PDT)
From:   Neil Armstrong <narmstrong@baylibre.com>
To:     khilman@baylibre.com
Cc:     Neil Armstrong <narmstrong@baylibre.com>,
        linux-amlogic@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH 0/3] arm64: meson-sm1: add support for the SM1 based VIM3
Date:   Fri, 23 Aug 2019 10:14:24 +0200
Message-Id: <20190823081427.17228-1-narmstrong@baylibre.com>
X-Mailer: git-send-email 2.22.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patchset adds support for the Amlogic SM1 based Khadas VIM3 variant.

The S903D3 package variant of SM1 is pin-to-pin compatible with the
S922X and A311d, so only internal DT changes are needed :
- DVFS support is different
- Audio support not yet available for SM1

This patchset moved all the non-g12b nodes to meson-khadas-vim3.dtsi
and add the sm1 specific nodes into meson-sm1-khadas-vim3.dts.

Display has a color conversion bug on SM1 by using a more recent vendor
bootloader on the SM1 based VIM3, this is out of scope of this patchset
and will be fixed in the drm/meson driver.

Dependencies:
- patch 1,2: None
- patch 3: Depends on the "arm64: meson-sm1: add support for DVFS" patchset at [1]

[1] https://patchwork.kernel.org/cover/11109411/

Neil Armstrong (3):
  arm64: dts: khadas-vim3: move common nodes into meson-khadas-vim3.dtsi
  amlogic: arm: add Amlogic SM1 based Khadas VIM3 variant bindings
  arm64: dts: khadas-vim3: add support for the SM1 based VIM3

 .../devicetree/bindings/arm/amlogic.yaml      |   3 +-
 arch/arm64/boot/dts/amlogic/Makefile          |   1 +
 .../amlogic/meson-g12b-a311d-khadas-vim3.dts  |   1 +
 .../dts/amlogic/meson-g12b-khadas-vim3.dtsi   | 355 -----------------
 .../amlogic/meson-g12b-s922x-khadas-vim3.dts  |   1 +
 .../boot/dts/amlogic/meson-khadas-vim3.dtsi   | 360 ++++++++++++++++++
 .../dts/amlogic/meson-sm1-khadas-vim3.dts     |  69 ++++
 7 files changed, 434 insertions(+), 356 deletions(-)
 create mode 100644 arch/arm64/boot/dts/amlogic/meson-khadas-vim3.dtsi
 create mode 100644 arch/arm64/boot/dts/amlogic/meson-sm1-khadas-vim3.dts

-- 
2.22.0

