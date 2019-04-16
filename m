Return-Path: <SRS0=BZT9=SS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,USER_AGENT_GIT,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3C03CC10F13
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Apr 2019 16:22:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EDFCD20868
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Apr 2019 16:22:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="C0sntPUK"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729284AbfDPQWS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Apr 2019 12:22:18 -0400
Received: from mail-pl1-f202.google.com ([209.85.214.202]:54523 "EHLO
        mail-pl1-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726230AbfDPQWS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Apr 2019 12:22:18 -0400
Received: by mail-pl1-f202.google.com with SMTP id d16so13647292pll.21
        for <linux-kernel@vger.kernel.org>; Tue, 16 Apr 2019 09:22:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=qAdw7p8zilHKmYUU8VNX5UhVmrGvyecyfpqBwyWB8lM=;
        b=C0sntPUKRJ5mzqtDByzjZBwu15k0L4LO2WKRn3JAll0p+U1MFV9Vj3MLzF9lWrpBhx
         rwfpbdZz5c+iHkPr2ReR4ABR6OX79FsGBqjZSYTHRyquYNgLm826a4t1zFp1f0AR4F8e
         ux5dEKlv22Su+0BENf7FOEAKzQu1BGIYxszqR5Xv+IjNzPEJ+tGJl3DZanPu2K0R3hsI
         jLID2lJB9P/Qc1rQX8IOv6u47Ud3cuQRO9ikrrYG24XQshx6xjSsF29kDcWcjbbqpgd4
         Ku9XBGh3eeoTi+cDaRLXMhSfz6KJnrgqmllbxql9T5HRhcL3riaWaUa9TDPDrrPQL3A7
         xRig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=qAdw7p8zilHKmYUU8VNX5UhVmrGvyecyfpqBwyWB8lM=;
        b=kctIyTX1ArbqtWZcg3ZdBJtuJLbTFLdBzfjvVGgbKc6nwv5X/qleoFX1/qEAci6PSK
         uexkM3lji4OAjVX7QzYEpsbOk28xj8mqYSJvRfEV4v7HW85NXOaQPcq8mr87E/zVsTZw
         TrWNrKxJTfqBk5WwEzjYfaw6MFTqFa1mS8CDkcQc3E3miSwDiPZ5iT2gmtRohL1Et/2k
         fitVkmJQ2BKiAwO/uEpIkDnusVhjYbfvL62Akpei2Wo/YmseT6Uds+29YG1xPPxmpx1T
         tNjHjW0DAsdPaFFQPscIvEAoC9ueHxE5MtN/d0Nu+0sLA5eYKsg/+krDFrIq/noBgF5p
         38Aw==
X-Gm-Message-State: APjAAAUpid5yq8YXy9jc+vxH9DJlaPVCGJJ4iJyoQmDo+xfPw04qaDYq
        9Hi/b+XtHGGMsOGGyK8GyggNUldjpdfr
X-Google-Smtp-Source: APXvYqzRNIWJwu0BKdCTwU2EK/hAD2NWoOOaYz3j/qkoQ2rfLW/QtLKs//6FRqY205vs2Yl8PId43wtf0lww
X-Received: by 2002:a62:ab09:: with SMTP id p9mr1575645pff.6.1555431737662;
 Tue, 16 Apr 2019 09:22:17 -0700 (PDT)
Date:   Tue, 16 Apr 2019 09:21:48 -0700
Message-Id: <20190416162150.150154-1-venture@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.21.0.392.gf8f6787159e-goog
Subject: [PATCH 0/3] update aspeed-bmc-opp-zaius device-tree
From:   Patrick Venture <venture@google.com>
To:     venture@google.com, robh+dt@kernel.org, mark.rutland@arm.com,
        joel@jms.id.au, andrew@aj.id.au
Cc:     devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-aspeed@lists.ozlabs.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

This series contains three updates to the Zaius ASPEED device-tree to
add voltrage regulators, and update addresses and aliases.  The Infineon
and Intersil drivers are staged on hwmon-next, and the trivial device
dt-bindings changed are up for review.

Maxim Sloyko (1):
  ARM: dts: aspeed: zaius: add Infineon and Intersil regulators

Robert Lippert (2):
  ARM: dts: aspeed: zaius: update 12V brick I2C address
  ARM: dts: aspeed: zaius: fixed I2C bus numbers for pcie slots

 arch/arm/boot/dts/aspeed-bmc-opp-zaius.dts | 121 +++++++++++++++++++--
 1 file changed, 113 insertions(+), 8 deletions(-)

-- 
2.21.0.392.gf8f6787159e-goog

