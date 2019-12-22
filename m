Return-Path: <SRS0=7h0X=2M=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DEA65C2D0C8
	for <linux-kernel@archiver.kernel.org>; Sun, 22 Dec 2019 20:11:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A4943205C9
	for <linux-kernel@archiver.kernel.org>; Sun, 22 Dec 2019 20:11:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726564AbfLVUHT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 22 Dec 2019 15:07:19 -0500
Received: from vps-vb.mhejs.net ([37.28.154.113]:35264 "EHLO vps-vb.mhejs.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725951AbfLVUHS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 22 Dec 2019 15:07:18 -0500
Received: from MUA
        by vps-vb.mhejs.net with esmtps (TLSv1.2:ECDHE-RSA-AES128-GCM-SHA256:128)
        (Exim 4.92.3)
        (envelope-from <mail@maciej.szmigiero.name>)
        id 1ij7VP-0003E8-0U; Sun, 22 Dec 2019 21:07:11 +0100
From:   "Maciej S. Szmigiero" <mail@maciej.szmigiero.name>
Subject: [PATCH v6] zswap: allow setting default status, compressor and
 allocator in Kconfig
To:     Seth Jennings <sjenning@redhat.com>,
        Dan Streetman <ddstreet@ieee.org>
Cc:     Vitaly Wool <vitalywool@gmail.com>,
        Vlastimil Babka <vbabka@suse.cz>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Autocrypt: addr=mail@maciej.szmigiero.name; prefer-encrypt=mutual; keydata=
 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 PA==
Message-ID: <01197b3b-85ea-1a82-5bd4-8f18a622202c@maciej.szmigiero.name>
Date:   Sun, 22 Dec 2019 21:07:05 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.3.1
MIME-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The compressed cache for swap pages (zswap) currently needs from 1 to 3
extra kernel command line parameters in order to make it work: it has to be
enabled by adding a "zswap.enabled=1" command line parameter and if one
wants a different compressor or pool allocator than the default lzo / zbud
combination then these choices also need to be specified on the kernel
command line in additional parameters.

Using a different compressor and allocator for zswap is actually pretty
common as guides often recommend using the lz4 / z3fold pair instead of
the default one.
In such case it is also necessary to remember to enable the appropriate
compression algorithm and pool allocator in the kernel config manually.

Let's avoid the need for adding these kernel command line parameters and
automatically pull in the dependencies for the selected compressor
algorithm and pool allocator by adding an appropriate default switches to
Kconfig.

The default values for these options match what the code was using
previously as its defaults.

Signed-off-by: Maciej S. Szmigiero <mail@maciej.szmigiero.name>
Reviewed-by: Vitaly Wool <vitaly.wool@konsulko.com>
---
Changes from v1:
Rename CONFIG_ZSWAP_DEFAULT_COMP_* to CONFIG_ZSWAP_COMPRESSOR_DEFAULT_*
and CONFIG_ZSWAP_DEFAULT_ZPOOL_* to CONFIG_ZSWAP_ZPOOL_DEFAULT_* while
dropping the "_NAME" suffix from the final string option in both cases.

Changes from v2:
Add zsmalloc as a pool allocator choice, add a link to a page with
benchmarks of various compression algorithms to the compression
algorithm prompt option.

Changes from v3:
Update the zswap doc in Documentation, too.

Changes from v4:
Use IS_ENABLED() macro to initialize the zswap_enabled variable,
make CONFIG_ZSWAP_COMPRESSOR_DEFAULT and CONFIG_ZSWAP_ZPOOL_DEFAULT
depend on CONFIG_ZSWAP so they don't show in .config when zswap is
deselected in Kconfig.

Changes from v5:
Add Vitaly's "Reviewed-by" tag.

Documentation/vm/zswap.rst |  20 +++++---
 mm/Kconfig                 | 118 ++++++++++++++++++++++++++++++++++++++++++++-
 mm/zswap.c                 |  24 ++++-----
 3 files changed, 141 insertions(+), 21 deletions(-)

diff --git a/Documentation/vm/zswap.rst b/Documentation/vm/zswap.rst
index 1444ecd40911..2df6ee6b7a1d 100644
--- a/Documentation/vm/zswap.rst
+++ b/Documentation/vm/zswap.rst
@@ -35,9 +35,11 @@ Zswap evicts pages from compressed cache on an LRU basis to the backing swap
 device when the compressed pool reaches its size limit.  This requirement had
 been identified in prior community discussions.
 
-Zswap is disabled by default but can be enabled at boot time by setting
-the ``enabled`` attribute to 1 at boot time. ie: ``zswap.enabled=1``.  Zswap
-can also be enabled and disabled at runtime using the sysfs interface.
+Whether Zswap is enabled at the boot time depends on whether
+the ``CONFIG_ZSWAP_DEFAULT_ON`` Kconfig option is enabled or not.
+This setting can then be overridden by providing the kernel command line
+``zswap.enabled=`` option, for example ``zswap.enabled=0``.
+Zswap can also be enabled and disabled at runtime using the sysfs interface.
 An example command to enable zswap at runtime, assuming sysfs is mounted
 at ``/sys``, is::
 
@@ -64,9 +66,10 @@ allocation in zpool is not directly accessible by address.  Rather, a handle is
 returned by the allocation routine and that handle must be mapped before being
 accessed.  The compressed memory pool grows on demand and shrinks as compressed
 pages are freed.  The pool is not preallocated.  By default, a zpool
-of type zbud is created, but it can be selected at boot time by
-setting the ``zpool`` attribute, e.g. ``zswap.zpool=zbud``. It can
-also be changed at runtime using the sysfs ``zpool`` attribute, e.g.::
+of type selected in ``CONFIG_ZSWAP_ZPOOL_DEFAULT`` Kconfig option is created,
+but it can be overridden at boot time by setting the ``zpool`` attribute,
+e.g. ``zswap.zpool=zbud``. It can also be changed at runtime using the sysfs
+``zpool`` attribute, e.g.::
 
 	echo zbud > /sys/module/zswap/parameters/zpool
 
@@ -97,8 +100,9 @@ controlled policy:
 * max_pool_percent - The maximum percentage of memory that the compressed
   pool can occupy.
 
-The default compressor is lzo, but it can be selected at boot time by
-setting the ``compressor`` attribute, e.g. ``zswap.compressor=lzo``.
+The default compressor is selected in ``CONFIG_ZSWAP_COMPRESSOR_DEFAULT``
+Kconfig option, but it can be overridden at boot time by setting the
+``compressor`` attribute, e.g. ``zswap.compressor=lzo``.
 It can also be changed at runtime using the sysfs "compressor"
 attribute, e.g.::
 
diff --git a/mm/Kconfig b/mm/Kconfig
index ab80933be65f..1209240bfbe0 100644
--- a/mm/Kconfig
+++ b/mm/Kconfig
@@ -526,7 +526,6 @@ config MEM_SOFT_DIRTY
 config ZSWAP
 	bool "Compressed cache for swap pages (EXPERIMENTAL)"
 	depends on FRONTSWAP && CRYPTO=y
-	select CRYPTO_LZO
 	select ZPOOL
 	help
 	  A lightweight compressed cache for swap pages.  It takes
@@ -542,6 +541,123 @@ config ZSWAP
 	  they have not be fully explored on the large set of potential
 	  configurations and workloads that exist.
 
+choice
+	prompt "Compressed cache for swap pages default compressor"
+	depends on ZSWAP
+	default ZSWAP_COMPRESSOR_DEFAULT_LZO
+	help
+	  Selects the default compression algorithm for the compressed cache
+	  for swap pages.
+
+	  For an overview what kind of performance can be expected from
+	  a particular compression algorithm please refer to the benchmarks
+	  available at the following LWN page:
+	  https://lwn.net/Articles/751795/
+
+	  If in doubt, select 'LZO'.
+
+	  The selection made here can be overridden by using the kernel
+	  command line 'zswap.compressor=' option.
+
+config ZSWAP_COMPRESSOR_DEFAULT_DEFLATE
+	bool "Deflate"
+	select CRYPTO_DEFLATE
+	help
+	  Use the Deflate algorithm as the default compression algorithm.
+
+config ZSWAP_COMPRESSOR_DEFAULT_LZO
+	bool "LZO"
+	select CRYPTO_LZO
+	help
+	  Use the LZO algorithm as the default compression algorithm.
+
+config ZSWAP_COMPRESSOR_DEFAULT_842
+	bool "842"
+	select CRYPTO_842
+	help
+	  Use the 842 algorithm as the default compression algorithm.
+
+config ZSWAP_COMPRESSOR_DEFAULT_LZ4
+	bool "LZ4"
+	select CRYPTO_LZ4
+	help
+	  Use the LZ4 algorithm as the default compression algorithm.
+
+config ZSWAP_COMPRESSOR_DEFAULT_LZ4HC
+	bool "LZ4HC"
+	select CRYPTO_LZ4HC
+	help
+	  Use the LZ4HC algorithm as the default compression algorithm.
+
+config ZSWAP_COMPRESSOR_DEFAULT_ZSTD
+	bool "zstd"
+	select CRYPTO_ZSTD
+	help
+	  Use the zstd algorithm as the default compression algorithm.
+endchoice
+
+config ZSWAP_COMPRESSOR_DEFAULT
+       string
+       depends on ZSWAP
+       default "deflate" if ZSWAP_COMPRESSOR_DEFAULT_DEFLATE
+       default "lzo" if ZSWAP_COMPRESSOR_DEFAULT_LZO
+       default "842" if ZSWAP_COMPRESSOR_DEFAULT_842
+       default "lz4" if ZSWAP_COMPRESSOR_DEFAULT_LZ4
+       default "lz4hc" if ZSWAP_COMPRESSOR_DEFAULT_LZ4HC
+       default "zstd" if ZSWAP_COMPRESSOR_DEFAULT_ZSTD
+       default ""
+
+choice
+	prompt "Compressed cache for swap pages default allocator"
+	depends on ZSWAP
+	default ZSWAP_ZPOOL_DEFAULT_ZBUD
+	help
+	  Selects the default allocator for the compressed cache for
+	  swap pages.
+	  The default is 'zbud' for compatibility, however please do
+	  read the description of each of the allocators below before
+	  making a right choice.
+
+	  The selection made here can be overridden by using the kernel
+	  command line 'zswap.zpool=' option.
+
+config ZSWAP_ZPOOL_DEFAULT_ZBUD
+	bool "zbud"
+	select ZBUD
+	help
+	  Use the zbud allocator as the default allocator.
+
+config ZSWAP_ZPOOL_DEFAULT_Z3FOLD
+	bool "z3fold"
+	select Z3FOLD
+	help
+	  Use the z3fold allocator as the default allocator.
+
+config ZSWAP_ZPOOL_DEFAULT_ZSMALLOC
+	bool "zsmalloc"
+	select ZSMALLOC
+	help
+	  Use the zsmalloc allocator as the default allocator.
+endchoice
+
+config ZSWAP_ZPOOL_DEFAULT
+       string
+       depends on ZSWAP
+       default "zbud" if ZSWAP_ZPOOL_DEFAULT_ZBUD
+       default "z3fold" if ZSWAP_ZPOOL_DEFAULT_Z3FOLD
+       default "zsmalloc" if ZSWAP_ZPOOL_DEFAULT_ZSMALLOC
+       default ""
+
+config ZSWAP_DEFAULT_ON
+	bool "Enable the compressed cache for swap pages by default"
+	depends on ZSWAP
+	help
+	  If selected, the compressed cache for swap pages will be enabled
+	  at boot, otherwise it will be disabled.
+
+	  The selection made here can be overridden by using the kernel
+	  command line 'zswap.enabled=' option.
+
 config ZPOOL
 	tristate "Common API for compressed memory storage"
 	help
diff --git a/mm/zswap.c b/mm/zswap.c
index 46a322316e52..1af303e88008 100644
--- a/mm/zswap.c
+++ b/mm/zswap.c
@@ -71,8 +71,8 @@
 
 #define ZSWAP_PARAM_UNSET ""
 
-/* Enable/disable zswap (disabled by default) */
-static bool zswap_enabled;
+/* Enable/disable zswap */
+static bool zswap_enabled = IS_ENABLED(CONFIG_ZSWAP_DEFAULT_ON);
 static int zswap_enabled_param_set(const char *,
 				   const struct kernel_param *);
 static struct kernel_param_ops zswap_enabled_param_ops = {
@@ -82,8 +82,7 @@ static int zswap_enabled_param_set(const char *,
 module_param_cb(enabled, &zswap_enabled_param_ops, &zswap_enabled, 0644);
 
 /* Crypto compressor to use */
-#define ZSWAP_COMPRESSOR_DEFAULT "lzo"
-static char *zswap_compressor = ZSWAP_COMPRESSOR_DEFAULT;
+static char *zswap_compressor = CONFIG_ZSWAP_COMPRESSOR_DEFAULT;
 static int zswap_compressor_param_set(const char *,
 				      const struct kernel_param *);
 static struct kernel_param_ops zswap_compressor_param_ops = {
@@ -95,8 +94,7 @@ static int zswap_compressor_param_set(const char *,
 		&zswap_compressor, 0644);
 
 /* Compressed storage zpool to use */
-#define ZSWAP_ZPOOL_DEFAULT "zbud"
-static char *zswap_zpool_type = ZSWAP_ZPOOL_DEFAULT;
+static char *zswap_zpool_type = CONFIG_ZSWAP_ZPOOL_DEFAULT;
 static int zswap_zpool_param_set(const char *, const struct kernel_param *);
 static struct kernel_param_ops zswap_zpool_param_ops = {
 	.set =		zswap_zpool_param_set,
@@ -569,11 +567,12 @@ static __init struct zswap_pool *__zswap_pool_create_fallback(void)
 	bool has_comp, has_zpool;
 
 	has_comp = crypto_has_comp(zswap_compressor, 0, 0);
-	if (!has_comp && strcmp(zswap_compressor, ZSWAP_COMPRESSOR_DEFAULT)) {
+	if (!has_comp && strcmp(zswap_compressor,
+				CONFIG_ZSWAP_COMPRESSOR_DEFAULT)) {
 		pr_err("compressor %s not available, using default %s\n",
-		       zswap_compressor, ZSWAP_COMPRESSOR_DEFAULT);
+		       zswap_compressor, CONFIG_ZSWAP_COMPRESSOR_DEFAULT);
 		param_free_charp(&zswap_compressor);
-		zswap_compressor = ZSWAP_COMPRESSOR_DEFAULT;
+		zswap_compressor = CONFIG_ZSWAP_COMPRESSOR_DEFAULT;
 		has_comp = crypto_has_comp(zswap_compressor, 0, 0);
 	}
 	if (!has_comp) {
@@ -584,11 +583,12 @@ static __init struct zswap_pool *__zswap_pool_create_fallback(void)
 	}
 
 	has_zpool = zpool_has_pool(zswap_zpool_type);
-	if (!has_zpool && strcmp(zswap_zpool_type, ZSWAP_ZPOOL_DEFAULT)) {
+	if (!has_zpool && strcmp(zswap_zpool_type,
+				 CONFIG_ZSWAP_ZPOOL_DEFAULT)) {
 		pr_err("zpool %s not available, using default %s\n",
-		       zswap_zpool_type, ZSWAP_ZPOOL_DEFAULT);
+		       zswap_zpool_type, CONFIG_ZSWAP_ZPOOL_DEFAULT);
 		param_free_charp(&zswap_zpool_type);
-		zswap_zpool_type = ZSWAP_ZPOOL_DEFAULT;
+		zswap_zpool_type = CONFIG_ZSWAP_ZPOOL_DEFAULT;
 		has_zpool = zpool_has_pool(zswap_zpool_type);
 	}
 	if (!has_zpool) {
