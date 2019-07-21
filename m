Return-Path: <SRS0=KmSF=VS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C9F09C76195
	for <linux-kernel@archiver.kernel.org>; Sun, 21 Jul 2019 14:25:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9AA5320823
	for <linux-kernel@archiver.kernel.org>; Sun, 21 Jul 2019 14:25:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nifty.com header.i=@nifty.com header.b="1FApfRSi"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726481AbfGUOZj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 21 Jul 2019 10:25:39 -0400
Received: from conuserg-09.nifty.com ([210.131.2.76]:62041 "EHLO
        conuserg-09.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726338AbfGUOZj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 21 Jul 2019 10:25:39 -0400
Received: from grover.flets-west.jp (softbank126026094249.bbtec.net [126.26.94.249]) (authenticated)
        by conuserg-09.nifty.com with ESMTP id x6LENIai000764;
        Sun, 21 Jul 2019 23:23:18 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conuserg-09.nifty.com x6LENIai000764
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1563718999;
        bh=TgOPi4OI1U4SdoPkJqKJcXQszKG8Kxse+HEK34XePJk=;
        h=From:To:Cc:Subject:Date:From;
        b=1FApfRSiENS3WRZpU6ySuiAAfzqq6EZu4OJSrIQ+KHEey91/xZbaS+4IHX/Rsc2Mi
         lGvBezwmbpj+Bnwht4hEnR2cfQlO1PvONQmGE7FQo43fDuUS5XZ0TxJcU9NITfCqLc
         90bEFpJYvCYwcYoHhj1+O51sFeU8fSxM11RkwORxQ8p2wXjgSIVAvBH2Yhs1TpBkUa
         2nXZTk8eow/a+PODwEof1tgvv0pnnJANK908/ax8pXVgnmg+1fteJTqW0i+FrFuScS
         b4M0UkNMRzNPbBV5rScBg0kmwWq52dx8sKwHIKuDeTI7KqGIthe5Ci0tTuNcxix5Az
         hJC2HFg4sIu/Q==
X-Nifty-SrcIP: [126.26.94.249]
From:   Masahiro Yamada <yamada.masahiro@socionext.com>
To:     Mark Brown <broonie@kernel.org>, alsa-devel@alsa-project.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Liam Girdwood <liam.r.girdwood@linux.intel.com>,
        Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        Takashi Iwai <tiwai@suse.com>, linux-kernel@vger.kernel.org
Subject: [PATCH] ASoC: SOF: use __u32 instead of uint32_t in uapi headers
Date:   Sun, 21 Jul 2019 23:23:08 +0900
Message-Id: <20190721142308.30306-1-yamada.masahiro@socionext.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When CONFIG_UAPI_HEADER_TEST=y, exported headers are compile-tested to
make sure they can be included from user-space.

Currently, header.h and fw.h are excluded from the test coverage.
To make them join the compile-test, we need to fix the build errors
attached below.

For a case like this, we decided to use __u{8,16,32,64} variable types
in this discussion:

  https://lkml.org/lkml/2019/6/5/18

Build log:

  CC      usr/include/sound/sof/header.h.s
  CC      usr/include/sound/sof/fw.h.s
In file included from <command-line>:32:0:
./usr/include/sound/sof/header.h:19:2: error: unknown type name ‘uint32_t’
  uint32_t magic;  /**< 'S', 'O', 'F', '\0' */
  ^~~~~~~~
./usr/include/sound/sof/header.h:20:2: error: unknown type name ‘uint32_t’
  uint32_t type;  /**< component specific type */
  ^~~~~~~~
./usr/include/sound/sof/header.h:21:2: error: unknown type name ‘uint32_t’
  uint32_t size;  /**< size in bytes of data excl. this struct */
  ^~~~~~~~
./usr/include/sound/sof/header.h:22:2: error: unknown type name ‘uint32_t’
  uint32_t abi;  /**< SOF ABI version */
  ^~~~~~~~
./usr/include/sound/sof/header.h:23:2: error: unknown type name ‘uint32_t’
  uint32_t reserved[4]; /**< reserved for future use */
  ^~~~~~~~
./usr/include/sound/sof/header.h:24:2: error: unknown type name ‘uint32_t’
  uint32_t data[0]; /**< Component data - opaque to core */
  ^~~~~~~~
In file included from <command-line>:32:0:
./usr/include/sound/sof/fw.h:49:2: error: unknown type name ‘uint32_t’
  uint32_t size;  /* bytes minus this header */
  ^~~~~~~~
./usr/include/sound/sof/fw.h:50:2: error: unknown type name ‘uint32_t’
  uint32_t offset; /* offset from base */
  ^~~~~~~~
./usr/include/sound/sof/fw.h:64:2: error: unknown type name ‘uint32_t’
  uint32_t size;  /* bytes minus this header */
  ^~~~~~~~
./usr/include/sound/sof/fw.h:65:2: error: unknown type name ‘uint32_t’
  uint32_t num_blocks; /* number of blocks */
  ^~~~~~~~
./usr/include/sound/sof/fw.h:73:2: error: unknown type name ‘uint32_t’
  uint32_t file_size; /* size of file minus this header */
  ^~~~~~~~
./usr/include/sound/sof/fw.h:74:2: error: unknown type name ‘uint32_t’
  uint32_t num_modules; /* number of modules */
  ^~~~~~~~
./usr/include/sound/sof/fw.h:75:2: error: unknown type name ‘uint32_t’
  uint32_t abi;  /* version of header format */
  ^~~~~~~~

Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
---

 include/uapi/sound/sof/fw.h     | 16 +++++++++-------
 include/uapi/sound/sof/header.h | 14 ++++++++------
 2 files changed, 17 insertions(+), 13 deletions(-)

diff --git a/include/uapi/sound/sof/fw.h b/include/uapi/sound/sof/fw.h
index 1afca973eb09..e9f697467a86 100644
--- a/include/uapi/sound/sof/fw.h
+++ b/include/uapi/sound/sof/fw.h
@@ -13,6 +13,8 @@
 #ifndef __INCLUDE_UAPI_SOF_FW_H__
 #define __INCLUDE_UAPI_SOF_FW_H__
 
+#include <linux/types.h>
+
 #define SND_SOF_FW_SIG_SIZE	4
 #define SND_SOF_FW_ABI		1
 #define SND_SOF_FW_SIG		"Reef"
@@ -46,8 +48,8 @@ enum snd_sof_fw_blk_type {
 
 struct snd_sof_blk_hdr {
 	enum snd_sof_fw_blk_type type;
-	uint32_t size;		/* bytes minus this header */
-	uint32_t offset;	/* offset from base */
+	__u32 size;		/* bytes minus this header */
+	__u32 offset;		/* offset from base */
 } __packed;
 
 /*
@@ -61,8 +63,8 @@ enum snd_sof_fw_mod_type {
 
 struct snd_sof_mod_hdr {
 	enum snd_sof_fw_mod_type type;
-	uint32_t size;		/* bytes minus this header */
-	uint32_t num_blocks;	/* number of blocks */
+	__u32 size;		/* bytes minus this header */
+	__u32 num_blocks;	/* number of blocks */
 } __packed;
 
 /*
@@ -70,9 +72,9 @@ struct snd_sof_mod_hdr {
  */
 struct snd_sof_fw_header {
 	unsigned char sig[SND_SOF_FW_SIG_SIZE]; /* "Reef" */
-	uint32_t file_size;	/* size of file minus this header */
-	uint32_t num_modules;	/* number of modules */
-	uint32_t abi;		/* version of header format */
+	__u32 file_size;	/* size of file minus this header */
+	__u32 num_modules;	/* number of modules */
+	__u32 abi;		/* version of header format */
 } __packed;
 
 #endif
diff --git a/include/uapi/sound/sof/header.h b/include/uapi/sound/sof/header.h
index 7868990b0d6f..5f4518e7a972 100644
--- a/include/uapi/sound/sof/header.h
+++ b/include/uapi/sound/sof/header.h
@@ -9,6 +9,8 @@
 #ifndef __INCLUDE_UAPI_SOUND_SOF_USER_HEADER_H__
 #define __INCLUDE_UAPI_SOUND_SOF_USER_HEADER_H__
 
+#include <linux/types.h>
+
 /*
  * Header for all non IPC ABI data.
  *
@@ -16,12 +18,12 @@
  * Used by any bespoke component data structures or binary blobs.
  */
 struct sof_abi_hdr {
-	uint32_t magic;		/**< 'S', 'O', 'F', '\0' */
-	uint32_t type;		/**< component specific type */
-	uint32_t size;		/**< size in bytes of data excl. this struct */
-	uint32_t abi;		/**< SOF ABI version */
-	uint32_t reserved[4];	/**< reserved for future use */
-	uint32_t data[0];	/**< Component data - opaque to core */
+	__u32 magic;		/**< 'S', 'O', 'F', '\0' */
+	__u32 type;		/**< component specific type */
+	__u32 size;		/**< size in bytes of data excl. this struct */
+	__u32 abi;		/**< SOF ABI version */
+	__u32 reserved[4];	/**< reserved for future use */
+	__u32 data[0];		/**< Component data - opaque to core */
 }  __packed;
 
 #endif
-- 
2.17.1

