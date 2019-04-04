Return-Path: <SRS0=oHH8=SG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	UNWANTED_LANGUAGE_BODY,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4A247C4360F
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Apr 2019 16:57:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1A183206DD
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Apr 2019 16:57:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TOD+G23Y"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729393AbfDDQ5d (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 4 Apr 2019 12:57:33 -0400
Received: from mail-pg1-f181.google.com ([209.85.215.181]:42543 "EHLO
        mail-pg1-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727415AbfDDQ5d (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Apr 2019 12:57:33 -0400
Received: by mail-pg1-f181.google.com with SMTP id p6so1521043pgh.9;
        Thu, 04 Apr 2019 09:57:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=Um6oni1SDHEKK6vDK5CNnvZd9AgYA0ZYByeEx8gtbyk=;
        b=TOD+G23Ys76fvSt0aknXQKqtd2aI7nwGjFp4TEpkiPzjbP0si8qDR9UXkMuWnv48J1
         oUw7iKTz3EhX6XWkL6E88DOld3Sqs1m2KHTahBS5BXf8kbZmVdx5FYeJ+Lw3r3YIhxWj
         Q8x/kK1kgbKWEiU26WvgVPKnLrb1vXvBOJMhW95zdeDGQIvuo6L2fj07qbtzBPobuDV2
         g+lpxYvHNMksau5zQWDgdFWOJVIWELgVDOfgf/vhjO6rFOBREc+YEOFsm9K+fQ81MS83
         64G8ozk8j7ayMI/Bn9Ng+iaPg7wRvL3mbWMjaooAKYkR8Wd0dbiRcZcpdzVO/1YJWdJb
         7oQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=Um6oni1SDHEKK6vDK5CNnvZd9AgYA0ZYByeEx8gtbyk=;
        b=DlIXavmDsQOZrzX7JaNWEy3Byx2PZRk5tJsrcBgpRtVxbTh5yaYkAc8rEKZZVOufif
         btkIk/XPxwRQeMjolDVHeV+f3uGyeIY5NzSC8sl3GSCYyceOBmVGjoFuEf+/s5bQf386
         GnH+QI2Lq5uU5FvuB8dfohTiXp30Ota9Ds2wwDzz7k20BlF1n7+w5+L5GdGsA0uRmtMK
         5TeXL5+yrTPWxmSYXcBv5QgNDY/GZYW0clF5kDTgsD8+RnnpaHWrzpJgizdhjnXN4Zis
         T9vFd89bk7R33q1LxluuTDWVSX6d9x3bQQ2yFnEeMgXsf6BXht6jSfCHOBajiPAej48d
         ywXA==
X-Gm-Message-State: APjAAAUmAawrWeco5Z95DADjOAYPoR06nDQBuOpkD3BaPVqAREF9Him+
        XT82FHafwB3593rFqPHm5O8=
X-Google-Smtp-Source: APXvYqwLEFmUJ5BghmjIAPSCgYTIPVkpUlIRjZq9iqNMy0HVwZhDL7K6VwxrHyTUXYGuRj6dpsmX1A==
X-Received: by 2002:a63:2c55:: with SMTP id s82mr6658457pgs.356.1554397052684;
        Thu, 04 Apr 2019 09:57:32 -0700 (PDT)
Received: from localhost (68.168.130.77.16clouds.com. [68.168.130.77])
        by smtp.gmail.com with ESMTPSA id f63sm22674233pfc.180.2019.04.04.09.57.31
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 04 Apr 2019 09:57:31 -0700 (PDT)
From:   Yangtao Li <tiny.windzz@gmail.com>
To:     maxime.ripard@bootlin.com, wens@csie.org, robh+dt@kernel.org,
        mark.rutland@arm.com, srinivas.kandagatla@linaro.org
Cc:     linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Yangtao Li <tiny.windzz@gmail.com>
Subject: [RESEND 0/2] nvmem: sunxi-sid: add SID controller support for H6
Date:   Thu,  4 Apr 2019 12:57:24 -0400
Message-Id: <20190404165726.13149-1-tiny.windzz@gmail.com>
X-Mailer: git-send-email 2.17.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add SID's support for H6.

Yangtao Li (2):
  nvmem: sunxi_sid: Support SID on H6
  arm64: dts: sunxi: h6: Add device node for SID

 arch/arm64/boot/dts/allwinner/sun50i-h6.dtsi | 5 +++++
 drivers/nvmem/sunxi_sid.c                    | 6 ++++++
 2 files changed, 11 insertions(+)

-- 
2.17.0

