Return-Path: <SRS0=Ecng=WJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 44153C433FF
	for <linux-kernel@archiver.kernel.org>; Tue, 13 Aug 2019 06:10:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 13BE720679
	for <linux-kernel@archiver.kernel.org>; Tue, 13 Aug 2019 06:10:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EFNBrpf4"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727530AbfHMGKo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 13 Aug 2019 02:10:44 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:36631 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725781AbfHMGKo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Aug 2019 02:10:44 -0400
Received: by mail-wr1-f68.google.com with SMTP id r3so12874655wrt.3
        for <linux-kernel@vger.kernel.org>; Mon, 12 Aug 2019 23:10:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=kBSt0AC9Wj3a2Ydwo1maYp10w7mbRorMD87B4HpPB2I=;
        b=EFNBrpf4FGy8XSbk7pjxipP5hP7dxFcpKbU3qvMtIJzOf1VB3T4nl+m93RK9SIgQWd
         vy7SOw3tnXpYDGANVBfSKDzG/RsM9zs7UFu7YLtphmPEJKaloc4faCWDOFcQRDOOq9PQ
         3XSrvcy07BVqhiWRJfjFJ54qSIVtFTblfvgZkGdRcuXPCOdc69btchprsNzrw4ADSt2X
         x6SOn+jSzWm9wAJjJirCqA9XSE+DiVWzJa59OFWJ50s6dTWqmu2BFEWSNeuVkiAv9x2W
         uLwHurY2yVU71+w7fEzw6p97QvGn781V0D2zUCGZ/ZX8y1kcQpCIrULkWAqbAexFqNMQ
         zrvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=kBSt0AC9Wj3a2Ydwo1maYp10w7mbRorMD87B4HpPB2I=;
        b=B6so5bL/lmWT1edWQlCE37obw+ryCwi1R9ROp8P3SWnlagSsPEM1FG5v1KCTiGzIeu
         Vw/avNXI+pXvJb1hQ6uIZDAV9n4oomzizyKrbMGuEwFVauBBwUrh6DRgj/nIWUiwaMeb
         VMvVSLJqavdUT6z3Vbjre6dHfgsR979VJOcfUpHdTb17CdjaNqq58X9qBOx63wWwwlgQ
         buAFifPPdgkkz82dQB1VpaP80l05X2fS2oabmgBQlgbllfRLgRpwqaSkXKo3i+ociouD
         B220ZBiIKt8vGqwfKG1wImR3isXPkDg677T2/uJWBwicfubyR1ye3izE+b9Pi8+rr8UF
         OmCw==
X-Gm-Message-State: APjAAAWinNvxXHRWqUWQiFhzfiF6FqXSDYW2SIfUndc1N32RqhBhyzJ1
        KLqq+gDvXgLGFwSxSV2n+TQ=
X-Google-Smtp-Source: APXvYqxGqC2rz8hc6nTl6Ie7zwuqOcKOu6mYW+16lrACD1nVavptVxrdjPIR+Sgem/E5tC8bo9nZsg==
X-Received: by 2002:a5d:424d:: with SMTP id s13mr25409745wrr.178.1565676641744;
        Mon, 12 Aug 2019 23:10:41 -0700 (PDT)
Received: from localhost.localdomain ([2a01:4f8:222:2f1b::2])
        by smtp.gmail.com with ESMTPSA id c1sm416096wmc.40.2019.08.12.23.10.40
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Mon, 12 Aug 2019 23:10:41 -0700 (PDT)
From:   Nathan Chancellor <natechancellor@gmail.com>
To:     Vinod Koul <vkoul@kernel.org>,
        Sanyog Kale <sanyog.r.kale@intel.com>,
        Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Cc:     alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
        clang-built-linux@googlegroups.com,
        Nathan Chancellor <natechancellor@gmail.com>
Subject: [PATCH] soundwire: Don't build sound.o without CONFIG_ACPI
Date:   Mon, 12 Aug 2019 23:10:14 -0700
Message-Id: <20190813061014.45015-1-natechancellor@gmail.com>
X-Mailer: git-send-email 2.23.0.rc2
MIME-Version: 1.0
X-Patchwork-Bot: notify
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

clang warns when CONFIG_ACPI is unset:

../drivers/soundwire/slave.c:16:12: warning: unused function
'sdw_slave_add' [-Wunused-function]
static int sdw_slave_add(struct sdw_bus *bus,
           ^
1 warning generated.

Before commit 8676b3ca4673 ("soundwire: fix regmap dependencies and
align with other serial links"), this code would only be compiled when
ACPI was set because it was only selected by SOUNDWIRE_INTEL, which
depends on ACPI.

Now, this code can be compiled without CONFIG_ACPI, which causes the
above warning. The IS_ENABLED(CONFIG_ACPI) guard could be moved to avoid
compiling the function; however, slave.c only contains three functions,
two of which are static. Only compile slave.o when CONFIG_ACPI is set,
where it will actually be used. bus.h contains a stub for
sdw_acpi_find_slaves so there will be no issues with an undefined
function.

This has been build tested with CONFIG_ACPI set and unset in combination
with CONFIG_SOUNDWIRE unset, built in, and a module.

Fixes: 8676b3ca4673 ("soundwire: fix regmap dependencies and align with other serial links")
Link: https://github.com/ClangBuiltLinux/linux/issues/637
Signed-off-by: Nathan Chancellor <natechancellor@gmail.com>
---
 drivers/soundwire/Makefile | 6 +++++-
 drivers/soundwire/slave.c  | 3 ---
 2 files changed, 5 insertions(+), 4 deletions(-)

diff --git a/drivers/soundwire/Makefile b/drivers/soundwire/Makefile
index 45b7e5001653..226090902716 100644
--- a/drivers/soundwire/Makefile
+++ b/drivers/soundwire/Makefile
@@ -4,9 +4,13 @@
 #
 
 #Bus Objs
-soundwire-bus-objs := bus_type.o bus.o slave.o mipi_disco.o stream.o
+soundwire-bus-objs := bus_type.o bus.o mipi_disco.o stream.o
 obj-$(CONFIG_SOUNDWIRE) += soundwire-bus.o
 
+ifdef CONFIG_ACPI
+soundwire-bus-objs += slave.o
+endif
+
 #Cadence Objs
 soundwire-cadence-objs := cadence_master.o
 obj-$(CONFIG_SOUNDWIRE_CADENCE) += soundwire-cadence.o
diff --git a/drivers/soundwire/slave.c b/drivers/soundwire/slave.c
index f39a5815e25d..0dc188e6873b 100644
--- a/drivers/soundwire/slave.c
+++ b/drivers/soundwire/slave.c
@@ -60,7 +60,6 @@ static int sdw_slave_add(struct sdw_bus *bus,
 	return ret;
 }
 
-#if IS_ENABLED(CONFIG_ACPI)
 /*
  * sdw_acpi_find_slaves() - Find Slave devices in Master ACPI node
  * @bus: SDW bus instance
@@ -110,5 +109,3 @@ int sdw_acpi_find_slaves(struct sdw_bus *bus)
 
 	return 0;
 }
-
-#endif
-- 
2.23.0.rc2

