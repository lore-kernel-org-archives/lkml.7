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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7074EC433FF
	for <linux-kernel@archiver.kernel.org>; Tue, 13 Aug 2019 18:12:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4214520844
	for <linux-kernel@archiver.kernel.org>; Tue, 13 Aug 2019 18:12:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fvp7xvUo"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728501AbfHMSMS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 13 Aug 2019 14:12:18 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:44592 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728453AbfHMSMO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Aug 2019 14:12:14 -0400
Received: by mail-wr1-f68.google.com with SMTP id p17so108601760wrf.11
        for <linux-kernel@vger.kernel.org>; Tue, 13 Aug 2019 11:12:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=H+HyNYqumhgzAfb6RQPcG1woV31dCtkzQNv0Z0BtjIQ=;
        b=fvp7xvUoAEO8LLtyrZs5Yi0BBIa9cTCA3g44OvUxFc8MB6V7gtoyk8ZX6aCCatQpyq
         IF3Iw296V6/hMXs8TSlQCGQ3WwORhSHmTbSmSi6ZHuSsok3Uybyi82sl93cdtM22rKIN
         vASlEhBGHPIn+XdY4eVclFBooSNxyJgKvqqmK6ahw/tygeGpSYF2HUUPMmbCuZ3Qkwvc
         bfkMW9zQ+h4/kco4b1k39AevSUtpm7x7LklvnVCj499Oss2vV6ZMnQnH4wYKTGnTvuRu
         8kOE96yIdnS03sAhIsWvw1+KY7VNksPSFI7LCZwrKfZO2spx9jZg8cZz/UMWJ/nxbqta
         q3mQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=H+HyNYqumhgzAfb6RQPcG1woV31dCtkzQNv0Z0BtjIQ=;
        b=CsD50UhWOWcK67R8Bj0EC6l3eewPID2v0chy4cZhvdizZFA2AkwlsVxquVss1D+nNo
         6qIUjDP0k9BQPb5/AI5H6MZaL4N0FkgIaMHb4AgE3opuXVNZi4cupmVeKzqCi+Gk2OiM
         R2zVSC+t4z4LaxvAHIT9uEAKsRPCGu7FfWEGPHRRcVRLxrk1m18xwzXR65GbGkQZFqjl
         lOu+fefB0iN6nyVejxhYHIiFEaDl1L/sAK3HllMWFwJl+U7uDeGLCCn4N52TL6vg6Lrl
         D15j9Db263Jy0VecH1wc1op+fzmkNp/p709QSONfnSyk+he2wkVk4sZ6gsyifJ2V02LC
         ww/w==
X-Gm-Message-State: APjAAAXkFJKz58TvMoaCAZe6Tim3Eeuc/AbtMRTWP9dswa8yWPPOHBHM
        m53mcghI4I4P6eyQ9d46dRw=
X-Google-Smtp-Source: APXvYqwjsJco2jXdMRkUTIwWS2QWhfQFiEMv9osfzl+KqkM1x4EDJWCjMdbH4r3jUxyvxr1DFQNJJA==
X-Received: by 2002:a5d:4a4e:: with SMTP id v14mr28818222wrs.200.1565719932335;
        Tue, 13 Aug 2019 11:12:12 -0700 (PDT)
Received: from localhost.localdomain ([2a01:4f8:222:2f1b::2])
        by smtp.gmail.com with ESMTPSA id a6sm1435050wmj.15.2019.08.13.11.12.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Aug 2019 11:12:11 -0700 (PDT)
From:   Nathan Chancellor <natechancellor@gmail.com>
To:     Vinod Koul <vkoul@kernel.org>,
        Sanyog Kale <sanyog.r.kale@intel.com>,
        Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Cc:     alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
        clang-built-linux@googlegroups.com,
        Nathan Chancellor <natechancellor@gmail.com>
Subject: [PATCH v2] soundwire: Make slave.o depend on ACPI and rename to acpi_slave.o
Date:   Tue, 13 Aug 2019 11:09:30 -0700
Message-Id: <20190813180929.22497-1-natechancellor@gmail.com>
X-Mailer: git-send-email 2.23.0.rc2
In-Reply-To: <20190813061014.45015-1-natechancellor@gmail.com>
References: <20190813061014.45015-1-natechancellor@gmail.com>
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
two of which are static. Since slave.c is completetely dependent on
ACPI, rename it to acpi_slave.c and only compile it when CONFIG_ACPI
is set so sdw_acpi_find_slaves will actually be used. bus.h contains
a stub for sdw_acpi_find_slaves so there will be no issues with an
undefined function.

This has been build tested with CONFIG_ACPI set and unset in combination
with CONFIG_SOUNDWIRE unset, built in, and a module.

Fixes: 8676b3ca4673 ("soundwire: fix regmap dependencies and align with other serial links")
Link: https://github.com/ClangBuiltLinux/linux/issues/637
Signed-off-by: Nathan Chancellor <natechancellor@gmail.com>
---

v1 -> v2:

* Rename slave.o to acpi_slave.o
* Reword commit message to reflect this

 drivers/soundwire/Makefile                  | 6 +++++-
 drivers/soundwire/{slave.c => acpi_slave.c} | 3 ---
 2 files changed, 5 insertions(+), 4 deletions(-)
 rename drivers/soundwire/{slave.c => acpi_slave.c} (98%)

diff --git a/drivers/soundwire/Makefile b/drivers/soundwire/Makefile
index 45b7e5001653..718d8dd0ac79 100644
--- a/drivers/soundwire/Makefile
+++ b/drivers/soundwire/Makefile
@@ -4,9 +4,13 @@
 #
 
 #Bus Objs
-soundwire-bus-objs := bus_type.o bus.o slave.o mipi_disco.o stream.o
+soundwire-bus-objs := bus_type.o bus.o mipi_disco.o stream.o
 obj-$(CONFIG_SOUNDWIRE) += soundwire-bus.o
 
+ifdef CONFIG_ACPI
+soundwire-bus-objs += acpi_slave.o
+endif
+
 #Cadence Objs
 soundwire-cadence-objs := cadence_master.o
 obj-$(CONFIG_SOUNDWIRE_CADENCE) += soundwire-cadence.o
diff --git a/drivers/soundwire/slave.c b/drivers/soundwire/acpi_slave.c
similarity index 98%
rename from drivers/soundwire/slave.c
rename to drivers/soundwire/acpi_slave.c
index f39a5815e25d..0dc188e6873b 100644
--- a/drivers/soundwire/slave.c
+++ b/drivers/soundwire/acpi_slave.c
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

