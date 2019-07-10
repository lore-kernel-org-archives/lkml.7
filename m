Return-Path: <SRS0=5O2B=VH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UPPERCASE_50_75,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4B1A6C74A23
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Jul 2019 14:13:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F0A682064B
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Jul 2019 14:13:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=aj.id.au header.i=@aj.id.au header.b="DJHF3jnf";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="QPsSNazK"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727444AbfGJONj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 10 Jul 2019 10:13:39 -0400
Received: from out3-smtp.messagingengine.com ([66.111.4.27]:55899 "EHLO
        out3-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727093AbfGJONi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Jul 2019 10:13:38 -0400
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
        by mailout.nyi.internal (Postfix) with ESMTP id CF2FA21E90;
        Wed, 10 Jul 2019 10:13:37 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute4.internal (MEProxy); Wed, 10 Jul 2019 10:13:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aj.id.au; h=from
        :to:cc:subject:date:message-id:in-reply-to:references
        :mime-version:content-transfer-encoding; s=fm3; bh=hDCc+1B/fxMD3
        q+Aooe1cCSSiOOVd979O3SjKxe+eqc=; b=DJHF3jnfwrDLGRoAOxBtdH+ISOvzN
        LtFGsjxbuR62itA/K+/CHnM9P1yrE2HiRQnPNHJ+e1t2BHVxQhGLuODss69UTooz
        tTbWj7DknJt+onihjFeZWFYYHVqgxaVtAXoF/vUWZwaAGKJk2Sr/KuX5H9lpfPx3
        IWWostGX0jGPnWskBEgdl1Wz9Qjw3fBJZ5xuyIOJ/1rq+UHLAVcIqnb9buwp9S5/
        QT2VlcuH8AqF1VycXIqglbFIvJO3iRu7QXBqFyFYijeOtYJ9odL4Sh8umxOf6/3Z
        PRcKfmKf60DpNiMH3ePd59iI+YGyAVrV8okZrIZEYAGISoqMo4fsGEz+g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:date:from
        :in-reply-to:message-id:mime-version:references:subject:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm3; bh=hDCc+1B/fxMD3q+Aooe1cCSSiOOVd979O3SjKxe+eqc=; b=QPsSNazK
        NGqI9lDFyzjZF0qDcERrQvjxltVuvc0ZLBk1yKcX0GltvN3w/YBEn69TBS4niauk
        MRJAConv2iR8qSeGn7ajL/SxJujan7Z1IFXbf2GKW05ngGiUlmL1XNF+RrsPYFKr
        Ec7zx18gcLiG6NUI3i7MhTibZLYOH9gnBuQR4KwpOEIhjEEN6T32AWsSLqxDF1ws
        WD309tChQhHdEArTp06qUJW5OLTNZD/yHgalCBh+56q8CLGbMCHbHCR2uVQ+KU+O
        +9VLuhEq184FuEeyBDL6kOCZ7n+eSiPa8cUBi4zgVFan5XoOObw00Sb8yY2qXhdC
        GK7zBb1DnCtZfA==
X-ME-Sender: <xms:kfIlXY7TEhb9AuA3PH-xihyNo5yGdzrh1tWoYXUuyZz1wnhrFTRhCw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduvddrgeeigdejhecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecunecujfgurhephffvufffkffojghfggfgsedtkeertd
    ertddtnecuhfhrohhmpeetnhgurhgvficulfgvfhhfvghrhicuoegrnhgurhgvfiesrghj
    rdhiugdrrghuqeenucfkphepudegrddvrdekhedrvddvnecurfgrrhgrmhepmhgrihhlfh
    hrohhmpegrnhgurhgvfiesrghjrdhiugdrrghunecuvehluhhsthgvrhfuihiivgeptd
X-ME-Proxy: <xmx:kfIlXeKcIhzJeYGEpggymKcGKf2wxH3EQk0gnmVX0BW3tX22mUbC-Q>
    <xmx:kfIlXSfFsnHzaTuHc5gtHaVNHdg_lXNT_j59vhW4yAzfbtfQaP0onQ>
    <xmx:kfIlXRcFMqcNwcPzVvquVymUV35STPjNc_iSW9tk7tqOVMGyZeJY1g>
    <xmx:kfIlXWKSnme4ttiwmlfJ1rg5gbeqBqLvHOjEMX7AXkzsqOdzjR99XA>
Received: from localhost.localdomain (ppp14-2-85-22.adl-apt-pir-bras31.tpg.internode.on.net [14.2.85.22])
        by mail.messagingengine.com (Postfix) with ESMTPA id CC4EB380076;
        Wed, 10 Jul 2019 10:13:34 -0400 (EDT)
From:   Andrew Jeffery <andrew@aj.id.au>
To:     linux-aspeed@lists.ozlabs.org
Cc:     Andrew Jeffery <andrew@aj.id.au>, joel@jms.id.au,
        ryanchen.aspeed@gmail.com, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 1/3] ARM: config: aspeed-g5: Refresh on 5.2
Date:   Wed, 10 Jul 2019 23:43:23 +0930
Message-Id: <20190710141325.20888-2-andrew@aj.id.au>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190710141325.20888-1-andrew@aj.id.au>
References: <20190710141325.20888-1-andrew@aj.id.au>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

$ make aspeed_g5_defconfig &&
         make savedefconfig &&
         mv defconfig arch/arm/configs/aspeed_g5_defconfig

Signed-off-by: Andrew Jeffery <andrew@aj.id.au>
---
 arch/arm/configs/aspeed_g5_defconfig | 54 ++++++++++++----------------
 1 file changed, 22 insertions(+), 32 deletions(-)

diff --git a/arch/arm/configs/aspeed_g5_defconfig b/arch/arm/configs/aspeed_g5_defconfig
index 407ffb7655a8..249eeeb55d59 100644
--- a/arch/arm/configs/aspeed_g5_defconfig
+++ b/arch/arm/configs/aspeed_g5_defconfig
@@ -20,29 +20,28 @@ CONFIG_PERF_EVENTS=y
 # CONFIG_COMPAT_BRK is not set
 CONFIG_SLAB=y
 CONFIG_SLAB_FREELIST_RANDOM=y
-CONFIG_JUMP_LABEL=y
-CONFIG_STRICT_KERNEL_RWX=y
-CONFIG_GCC_PLUGINS=y
-# CONFIG_BLK_DEV_BSG is not set
-# CONFIG_BLK_DEBUG_FS is not set
-# CONFIG_IOSCHED_DEADLINE is not set
-# CONFIG_MQ_IOSCHED_DEADLINE is not set
-# CONFIG_MQ_IOSCHED_KYBER is not set
 CONFIG_ARCH_MULTI_V6=y
 # CONFIG_ARCH_MULTI_V7 is not set
 CONFIG_ARCH_ASPEED=y
 CONFIG_MACH_ASPEED_G5=y
 # CONFIG_CACHE_L2X0 is not set
 CONFIG_VMSPLIT_2G=y
-# CONFIG_COMPACTION is not set
 CONFIG_UACCESS_WITH_MEMCPY=y
 CONFIG_SECCOMP=y
 # CONFIG_ATAGS is not set
 CONFIG_ZBOOT_ROM_TEXT=0x0
 CONFIG_ZBOOT_ROM_BSS=0x0
 CONFIG_KEXEC=y
-# CONFIG_CORE_DUMP_DEFAULT_ELF_HEADERS is not set
 # CONFIG_SUSPEND is not set
+CONFIG_FIRMWARE_MEMMAP=y
+CONFIG_JUMP_LABEL=y
+CONFIG_STRICT_KERNEL_RWX=y
+# CONFIG_BLK_DEV_BSG is not set
+# CONFIG_BLK_DEBUG_FS is not set
+# CONFIG_MQ_IOSCHED_DEADLINE is not set
+# CONFIG_MQ_IOSCHED_KYBER is not set
+# CONFIG_CORE_DUMP_DEFAULT_ELF_HEADERS is not set
+# CONFIG_COMPACTION is not set
 CONFIG_NET=y
 CONFIG_PACKET=y
 CONFIG_PACKET_DIAG=y
@@ -51,20 +50,12 @@ CONFIG_UNIX_DIAG=y
 CONFIG_INET=y
 CONFIG_IP_MULTICAST=y
 CONFIG_SYN_COOKIES=y
-# CONFIG_INET_XFRM_MODE_TRANSPORT is not set
-# CONFIG_INET_XFRM_MODE_TUNNEL is not set
-# CONFIG_INET_XFRM_MODE_BEET is not set
 # CONFIG_INET_DIAG is not set
-# CONFIG_INET6_XFRM_MODE_TRANSPORT is not set
-# CONFIG_INET6_XFRM_MODE_TUNNEL is not set
-# CONFIG_INET6_XFRM_MODE_BEET is not set
 CONFIG_NETFILTER=y
 # CONFIG_NETFILTER_ADVANCED is not set
 CONFIG_VLAN_8021Q=y
 CONFIG_NET_NCSI=y
-CONFIG_BPF_STREAM_PARSER=y
 # CONFIG_WIRELESS is not set
-CONFIG_UEVENT_HELPER_PATH="/sbin/hotplug"
 CONFIG_DEVTMPFS=y
 CONFIG_DEVTMPFS_MOUNT=y
 # CONFIG_PREVENT_FIRMWARE_BUILD is not set
@@ -78,8 +69,6 @@ CONFIG_MTD_UBI=y
 CONFIG_MTD_UBI_FASTMAP=y
 CONFIG_MTD_UBI_BLOCK=y
 CONFIG_BLK_DEV_LOOP=y
-CONFIG_ASPEED_LPC_CTRL=y
-CONFIG_ASPEED_LPC_SNOOP=y
 CONFIG_EEPROM_AT24=y
 CONFIG_NETDEVICES=y
 CONFIG_NETCONSOLE=y
@@ -209,6 +198,8 @@ CONFIG_RTC_DRV_PCF8523=y
 CONFIG_RTC_DRV_RV8803=y
 # CONFIG_VIRTIO_MENU is not set
 # CONFIG_IOMMU_SUPPORT is not set
+CONFIG_ASPEED_LPC_CTRL=y
+CONFIG_ASPEED_LPC_SNOOP=y
 CONFIG_IIO=y
 CONFIG_ASPEED_ADC=y
 CONFIG_MAX1363=y
@@ -219,7 +210,6 @@ CONFIG_FSI_MASTER_HUB=y
 CONFIG_FSI_MASTER_AST_CF=y
 CONFIG_FSI_SCOM=y
 CONFIG_FSI_SBEFIFO=y
-CONFIG_FIRMWARE_MEMMAP=y
 CONFIG_FANOTIFY=y
 CONFIG_OVERLAY_FS=y
 CONFIG_TMPFS=y
@@ -232,6 +222,17 @@ CONFIG_SQUASHFS=y
 CONFIG_SQUASHFS_XZ=y
 CONFIG_SQUASHFS_ZSTD=y
 # CONFIG_NETWORK_FILESYSTEMS is not set
+CONFIG_HARDENED_USERCOPY=y
+CONFIG_FORTIFY_SOURCE=y
+# CONFIG_CRYPTO_ECHAINIV is not set
+CONFIG_CRYPTO_HMAC=y
+CONFIG_CRYPTO_SHA256=y
+CONFIG_CRYPTO_USER_API_HASH=y
+# CONFIG_CRYPTO_HW is not set
+# CONFIG_XZ_DEC_X86 is not set
+# CONFIG_XZ_DEC_POWERPC is not set
+# CONFIG_XZ_DEC_IA64 is not set
+# CONFIG_XZ_DEC_SPARC is not set
 CONFIG_PRINTK_TIME=y
 CONFIG_DYNAMIC_DEBUG=y
 CONFIG_DEBUG_INFO=y
@@ -250,14 +251,3 @@ CONFIG_FUNCTION_TRACER=y
 # CONFIG_RUNTIME_TESTING_MENU is not set
 CONFIG_DEBUG_WX=y
 CONFIG_DEBUG_USER=y
-CONFIG_HARDENED_USERCOPY=y
-CONFIG_FORTIFY_SOURCE=y
-# CONFIG_CRYPTO_ECHAINIV is not set
-CONFIG_CRYPTO_HMAC=y
-CONFIG_CRYPTO_SHA256=y
-CONFIG_CRYPTO_USER_API_HASH=y
-# CONFIG_CRYPTO_HW is not set
-# CONFIG_XZ_DEC_X86 is not set
-# CONFIG_XZ_DEC_POWERPC is not set
-# CONFIG_XZ_DEC_IA64 is not set
-# CONFIG_XZ_DEC_SPARC is not set
-- 
2.20.1

