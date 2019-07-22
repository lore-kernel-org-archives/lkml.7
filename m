Return-Path: <SRS0=CEgE=VT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.8 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BDD99C76194
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Jul 2019 11:41:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A22C42190D
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Jul 2019 11:41:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729969AbfGVLly (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 22 Jul 2019 07:41:54 -0400
Received: from mout.kundenserver.de ([217.72.192.74]:55713 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728312AbfGVLlx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Jul 2019 07:41:53 -0400
Received: from threadripper.lan ([149.172.19.189]) by mrelayeu.kundenserver.de
 (mreue106 [212.227.15.145]) with ESMTPA (Nemesis) id
 1Mlvr3-1iG1wW44iB-00j0GR; Mon, 22 Jul 2019 13:41:40 +0200
From:   Arnd Bergmann <arnd@arndb.de>
To:     Andrew Morton <akpm@linux-foundation.org>,
        James Morris <jmorris@namei.org>,
        "Serge E. Hallyn" <serge@hallyn.com>
Cc:     Arnd Bergmann <arnd@arndb.de>, Kees Cook <keescook@chromium.org>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Alexander Potapenko <glider@google.com>,
        linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] [RESEND v2] structleak: disable STRUCTLEAK_BYREF in combination with KASAN_STACK
Date:   Mon, 22 Jul 2019 13:41:20 +0200
Message-Id: <20190722114134.3123901-1-arnd@arndb.de>
X-Mailer: git-send-email 2.20.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:URkxje0XIcwUJNU8iin9fvxldK+WJvgwEJJ/hdbLv3uYfhzFeyb
 877EltBbCblmGJzqDmMAErOtw1aWONQE6UOAZu6zvBgH9VCGRT/6VJ91tIMvgXSHWhF26Z7
 bvDxkMeUtVHv+8JbSaS7fkNApOt8R6XXpvW961TkfIqckSE3QEC9Zxk+85n3Kglndvfj0AO
 dH3RucquOIrbYTb87SXZQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:H8MEUjKd9/A=:4C6M7iBeU6O1m8CkfFVDlq
 0GD3UolWHsFZm6Qg5+qbJaQyeEbRZlGCzXtdeHRlhI9XAKXPWNxkciFroyzNOzYRW2U2yJPuU
 1YpR/oRuDsk8WhHWHwvBpwiQ+B+b0V6/ZssPAMe/2dNYXFJYYy7CXOGvGHTWIjI75+TG3SySp
 4+rBo7xgR9CiFw6Mgif8WloyXfRTDGW+K9+u/qQ1Kyqx1UVjshBT9EUjLsOjNVohq1OL/ypNc
 4gatrhEu3GZbQe1RXx85SAxLbixd/QHT7YGc9VfzxPh/ZoVJRzhL7eNvqw6m1ExRpjGsBhQRI
 2upP4NZVhA6481CD6ptkh/b0T5u5RH/t1pSbUFw6BUoM9sz5aoRJT+evBo3T70SazGG5BqLAf
 CCZnZobPkmmaD8cnkwFPXO4weoXA+Tw6vdEN2ahpMiqrG4OA+4i6mnnZZLk2nBT2roHJQ4pJ9
 l2298gN2f4eA9N/fLhePz8S0cAaMQe1YTph1zTEQrufh2FUDS5RGdS3Vcx9qgngAjc9Iw6i/o
 8h0WHJ/bwBJIYHXxeDyU7u92j33F0zqzXYTjHfjFmXUoCn1KLTpt2mMyiLpkqGhhuvGXS1vNQ
 JK0i+payOea1S/bkt+n7rZA75ubOsA6HMhwJxYB/1gFb9+Fn5U51YssIdZOlnOa6ZKPYEszWr
 TAf1q/+UsEd6ahkNWXRkPXLTtXhSxl9tbl0OLmloXjTfc570MWT6Ga1XC9RKrUo8CEv5HP9wK
 nlrAzZbG9rzPyRpiVA1Dj4+Pz5bOFRR8+OhsEA==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The combination of KASAN_STACK and GCC_PLUGIN_STRUCTLEAK_BYREF
leads to much larger kernel stack usage, as seen from the warnings
about functions that now exceed the 2048 byte limit:

drivers/media/i2c/tvp5150.c:253:1: error: the frame size of 3936 bytes is larger than 2048 bytes
drivers/media/tuners/r820t.c:1327:1: error: the frame size of 2816 bytes is larger than 2048 bytes
drivers/net/wireless/broadcom/brcm80211/brcmsmac/phy/phy_n.c:16552:1: error: the frame size of 3144 bytes is larger than 2048 bytes [-Werror=frame-larger-than=]
fs/ocfs2/aops.c:1892:1: error: the frame size of 2088 bytes is larger than 2048 bytes
fs/ocfs2/dlm/dlmrecovery.c:737:1: error: the frame size of 2088 bytes is larger than 2048 bytes
fs/ocfs2/namei.c:1677:1: error: the frame size of 2584 bytes is larger than 2048 bytes
fs/ocfs2/super.c:1186:1: error: the frame size of 2640 bytes is larger than 2048 bytes
fs/ocfs2/xattr.c:3678:1: error: the frame size of 2176 bytes is larger than 2048 bytes
net/bluetooth/l2cap_core.c:7056:1: error: the frame size of 2144 bytes is larger than 2048 bytes [-Werror=frame-larger-than=]
net/bluetooth/l2cap_core.c: In function 'l2cap_recv_frame':
net/bridge/br_netlink.c:1505:1: error: the frame size of 2448 bytes is larger than 2048 bytes
net/ieee802154/nl802154.c:548:1: error: the frame size of 2232 bytes is larger than 2048 bytes
net/wireless/nl80211.c:1726:1: error: the frame size of 2224 bytes is larger than 2048 bytes
net/wireless/nl80211.c:2357:1: error: the frame size of 4584 bytes is larger than 2048 bytes
net/wireless/nl80211.c:5108:1: error: the frame size of 2760 bytes is larger than 2048 bytes
net/wireless/nl80211.c:6472:1: error: the frame size of 2112 bytes is larger than 2048 bytes

The structleak plugin was previously disabled for CONFIG_COMPILE_TEST,
but meant we missed some bugs, so this time we should address them.

The frame size warnings are distracting, and risking a kernel stack
overflow is generally not beneficial to performance, so it may be best
to disallow that particular combination. This can be done by turning
off either one. I picked the dependency in GCC_PLUGIN_STRUCTLEAK_BYREF
and GCC_PLUGIN_STRUCTLEAK_BYREF_ALL, as this option is designed to
make uninitialized stack usage less harmful when enabled on its own,
but it also prevents KASAN from detecting those cases in which it was
in fact needed.

KASAN_STACK is currently implied by KASAN on gcc, but could be made a
user selectable option if we want to allow combining (non-stack) KASAN
with GCC_PLUGIN_STRUCTLEAK_BYREF.

Note that it would be possible to specifically address the files that
print the warning, but presumably the overall stack usage is still
significantly higher than in other configurations, so this would not
address the full problem.

I could not test this with CONFIG_INIT_STACK_ALL, which may or may not
suffer from a similar problem.

Fixes: 81a56f6dcd20 ("gcc-plugins: structleak: Generalize to all variable types")
Acked-by: Kees Cook <keescook@chromium.org>
Link: https://lore.kernel.org/lkml/20190628123819.2785504-1-arnd@arndb.de/
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
[v2] do it for both GCC_PLUGIN_STRUCTLEAK_BYREF and GCC_PLUGIN_STRUCTLEAK_BYREF_ALL.

Andrew, can you pick this up in -mm? It looks like nobody else
wanted it in their trees even though there was agreement on the
patch itself.
---
 security/Kconfig.hardening | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/security/Kconfig.hardening b/security/Kconfig.hardening
index a1ffe2eb4d5f..af4c979b38ee 100644
--- a/security/Kconfig.hardening
+++ b/security/Kconfig.hardening
@@ -61,6 +61,7 @@ choice
 	config GCC_PLUGIN_STRUCTLEAK_BYREF
 		bool "zero-init structs passed by reference (strong)"
 		depends on GCC_PLUGINS
+		depends on !(KASAN && KASAN_STACK=1)
 		select GCC_PLUGIN_STRUCTLEAK
 		help
 		  Zero-initialize any structures on the stack that may
@@ -70,9 +71,15 @@ choice
 		  exposures, like CVE-2017-1000410:
 		  https://git.kernel.org/linus/06e7e776ca4d3654
 
+		  As a side-effect, this keeps a lot of variables on the
+		  stack that can otherwise be optimized out, so combining
+		  this with CONFIG_KASAN_STACK can lead to a stack overflow
+		  and is disallowed.
+
 	config GCC_PLUGIN_STRUCTLEAK_BYREF_ALL
 		bool "zero-init anything passed by reference (very strong)"
 		depends on GCC_PLUGINS
+		depends on !(KASAN && KASAN_STACK=1)
 		select GCC_PLUGIN_STRUCTLEAK
 		help
 		  Zero-initialize any stack variables that may be passed
-- 
2.20.0

