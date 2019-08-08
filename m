Return-Path: <SRS0=IWld=WE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 53CFFC433FF
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Aug 2019 12:54:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2691C21880
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Aug 2019 12:54:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="oDJgQhcC"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732642AbfHHMyH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 8 Aug 2019 08:54:07 -0400
Received: from mail-vs1-f67.google.com ([209.85.217.67]:44306 "EHLO
        mail-vs1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727649AbfHHMyH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Aug 2019 08:54:07 -0400
Received: by mail-vs1-f67.google.com with SMTP id v129so62949612vsb.11
        for <linux-kernel@vger.kernel.org>; Thu, 08 Aug 2019 05:54:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ShrSLL/b1gcsvb3GwViTFYu5JAokgZtYFwFRvV/oi94=;
        b=oDJgQhcC45DpyXpfSGqGVR4b6ApvW/vXAvi6gCml3EbP8RpxY5sAqFpxbcaYqnhw1W
         3dYGyUe7yYlBul/Xrf4WstmuOI70fG//QTeiHWFsgzRblhQZ/mgyiA/T4t0vaT4znuAv
         shaDNxDtbz6uQ+7XWplbL2Qk+2WuQW/jubkdNCVErS5dQiPvrKpDCkOYJDtDuE+ivrsh
         PVmM+gm9fv0pYowHvHk/6UHu3WZwhSQ/V+fRqRaHTYWbiZCGiL/RqlAk8ySxXsG0m9Sf
         nMsm5P8ybyQAtiqL/F23yjhVmvXcyvkfNS9nUGRSLSLyyWf8tk79F7y4zgKfD4J0rmz5
         DfNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ShrSLL/b1gcsvb3GwViTFYu5JAokgZtYFwFRvV/oi94=;
        b=IZcu3nSV3bTtpUehgoiswkV30QwPouyeFQExroJl+Q2uBWF1d8nWezHZRjVMSvIpMQ
         bo2C58tKsRUxIIZwvx31FoGeOJt5B8JbiWzPgTY3Pcj0OnO3w7+zhvlh/EafNSPrOIty
         dw+f2ygzUGuaD9lGAaxS4JPEwdQ/o31bgjzJJQ8reeEE8glQrCX+sIhmGyukzAEudjD6
         yIXu1bI2/4RnBUP3HA9voWhp8WlPxd4Pu/5EYxxOZtfyjqWlFm7B8tPI4qb7KLpHwFYP
         DW3fddm1T23BnLGCWAbeY409qumRtffiJ2mweFuZ/rUizcK+gNT82Gz6+EijI0MCop6C
         +iug==
X-Gm-Message-State: APjAAAUU9DDyOCi50JIS1hgCbJc61MmCJ1oiH/2i3j/vux7m3MZo+cfS
        Z4w3iMc1tZXLh92ytZSjrDk=
X-Google-Smtp-Source: APXvYqwj2RNvx+wVHtRWzSRNhC1WiKniTpz5H8AEJV5En/XVfzbP19t9I8pBKpg+ACVw6YXxtr5sjg==
X-Received: by 2002:a67:f75a:: with SMTP id w26mr8870678vso.148.1565268846176;
        Thu, 08 Aug 2019 05:54:06 -0700 (PDT)
Received: from asus-S451LA.lan ([190.22.21.218])
        by smtp.gmail.com with ESMTPSA id r190sm26961692vkr.8.2019.08.08.05.54.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Aug 2019 05:54:05 -0700 (PDT)
From:   Luis Araneda <luaraneda@gmail.com>
To:     linux@armlinux.org.uk, michal.simek@xilinx.com
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Luis Araneda <luaraneda@gmail.com>
Subject: [PATCH v2 0/2] ARM: zynq: smp improvements
Date:   Thu,  8 Aug 2019 08:52:41 -0400
Message-Id: <20190808125243.31046-1-luaraneda@gmail.com>
X-Mailer: git-send-email 2.22.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This series adds support for kernel compiled in Thumb mode
and fixes a kernel panic on smp bring-up when FORTIFY_SOURCE
is enabled.

The series started with the second patch as an RFC, and
the first patch were suggested on the review to complement
the fix.

The changes were run-tested on a Digilent Zybo Z7 board
---
Changes:
v1 -> v2:
- Reword commit messages to include related commits
- Add Fixes tag to relevant commits
- Add Cc to stable to relevant commits


Luis Araneda (2):
  ARM: zynq: support smp in thumb mode
  ARM: zynq: Use memcpy_toio instead of memcpy on smp bring-up

 arch/arm/mach-zynq/headsmp.S | 2 ++
 arch/arm/mach-zynq/platsmp.c | 4 ++--
 2 files changed, 4 insertions(+), 2 deletions(-)

-- 
2.22.0

