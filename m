Return-Path: <SRS0=FHjv=VA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8FAE0C06511
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Jul 2019 20:56:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 735C521852
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Jul 2019 20:56:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727350AbfGCU4y (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 3 Jul 2019 16:56:54 -0400
Received: from mout.kundenserver.de ([212.227.126.187]:40747 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726678AbfGCU4y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Jul 2019 16:56:54 -0400
Received: from threadripper.lan ([149.172.19.189]) by mrelayeu.kundenserver.de
 (mreue010 [212.227.15.129]) with ESMTPA (Nemesis) id
 1MCbZL-1hrszW1Wi3-009fcz; Wed, 03 Jul 2019 22:56:37 +0200
From:   Arnd Bergmann <arnd@arndb.de>
To:     Florian Fainelli <f.fainelli@gmail.com>
Cc:     Andrey Ryabinin <aryabinin@virtuozzo.com>,
        Abbott Liu <liuwenliang@huawei.com>,
        linux-arm-kernel@lists.infradead.org, kasan-dev@googlegroups.com,
        Linus Walleij <linus.walleij@linaro.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Andrew Morton <akpm@linux-foundation.org>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Kees Cook <keescook@chromium.org>, linux-kernel@vger.kernel.org
Subject: [PATCH 3/3] kasan: increase 32-bit stack frame warning limit
Date:   Wed,  3 Jul 2019 22:54:38 +0200
Message-Id: <20190703205527.955320-3-arnd@arndb.de>
X-Mailer: git-send-email 2.20.0
In-Reply-To: <20190703205527.955320-1-arnd@arndb.de>
References: <20190703205527.955320-1-arnd@arndb.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:8pSJiH+6Agod8nzM29uheH50kgOrBaKHZzl6ndhrvPiQDTdiHui
 W5pteQ/meterbUyb16uPXBdh/bTTq2+X7Dk5d7PAcip6R5BCBPu9tNJQGkCbISINyzxc4E3
 ufLi+uJnI/JUTqJcROzbiTnzXM5lLSFjTSMLV+q7duZFqGKVqJd+NvheDVswutkffm0UA2T
 TfDWqX7IhnITKKyiWsxrA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:3Ix8Jf1u9lw=:pjqfTjTFLOmjIDonH9fhGO
 mHR6MCXiiA+Fcqph4cAytscXm6iAv/rKcr/9/TiHbHVVsjckLsemrX4ckG9DSoruNNgcyJZU6
 iOh8oppdJ0CmQLWMXd9XwgOkCOhnP9vSEcCbJv0xxPSh5jCSx9DuUzhZyzfxwQUQSPTD8ZZ2i
 t8FXl40rX/HMeA4I13WzDKH/5A2FNnIENm7M9rUTO700Bd7uTcBKAa7mlM+VdnwpaYWJ2RRtA
 WfqrTrQsGfObU4oOpKitmyB50dNiiNQMY56Dn6Dsh76mVyRlLUnc6QHQ4N0elrylTNwYj/ihI
 61Ox5FaGZmJDnXmnGoFY2sD2hny0rzusVuk5DpRThYWLJ5aatwd+B3ce7oeeO9NJRExGDIni4
 BHuWsm+m/eCraU0WPVTSM87vm1asD/ayohcM1+LdMTcoMzb9LlWx0ALq9MJu/CKgV9De8/3b9
 d3/VN94DYA9jeePRDe7XPFDTNj2Tn+7KpCruJu15FS9qth6rpir7mcXY3UcNbIiiAW0gMe7w+
 /OOpsa7lPMhg8f39gUMxhnjD6EufdR5k/B56MNvwwXPkkoRSgsJHf6gc9m7CmmxVLAsNOqOJm
 hN2h21mCFCGBXsyB5O/KCiZHxoEKeC65vGSjC034oyin5/vtkSzw+IjuYpdEELk2rIyJOnRgX
 zFxLbriBO8AJIvgkUiCOqFp7zMO5cjWvACRnImwP8b5VHSmDtbyQA6vmdcyt/fVyBlbr/1b48
 GyzK0D05aGULm/4LZ3MsFTAW2SkdaJZmX220Qg==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Enabling kasan on 32-bit ARM introduces some new warnings in the
allmodconfig build due to mildly increased kernel stack usage, even when
asan-stack is disabled:

fs/select.c:621:5: error: stack frame size of 1032 bytes in function 'core_sys_select'
net/mac80211/mlme.c:4047:6: error: stack frame size of 1032 bytes in function 'ieee80211_sta_rx_queued_mgmt'
drivers/infiniband/sw/rxe/rxe_req.c:583:5: error: stack frame size of 1152 bytes in function 'rxe_requester'
fs/ubifs/replay.c:1193:5: error: stack frame size of 1152 bytes in function 'ubifs_replay_journal'
drivers/mtd/chips/cfi_cmdset_0001.c:1868:12: error: stack frame size of 1104 bytes in function 'cfi_intelext_writev'
drivers/ntb/hw/idt/ntb_hw_idt.c:1041:27: error: stack frame size of 1032 bytes in function 'idt_scan_mws'
drivers/mtd/nftlcore.c:674:12: error: stack frame size of 1120 bytes in function 'nftl_writeblock'
drivers/net/wireless/cisco/airo.c:3793:12: error: stack frame size of 1040 bytes in function 'setup_card'
drivers/staging/fbtft/fbtft-core.c:989:5: error: stack frame size of 1232 bytes in function 'fbtft_init_display'
drivers/staging/fbtft/fbtft-core.c:907:12: error: stack frame size of 1072 bytes in function 'fbtft_init_display_dt'
drivers/staging/wlan-ng/cfg80211.c:272:12: error: stack frame size of 1040 bytes in function 'prism2_scan'

Some of these are intentionally high, others are from sloppy coding
practice and should perhaps be reduced a lot.

For 64-bit, the limit is currently much higher at 2048 bytes, which
does not cause many warnings and could even be reduced. Changing the
limit to 1280 bytes with KASAN also takes care of all cases I see.
If we go beyond that with KASAN, or over the normal 1024 byte limit
without it, that is however something we should definitely address
in the code.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 lib/Kconfig.debug | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/lib/Kconfig.debug b/lib/Kconfig.debug
index 6d2799190fba..41b0ae9d05d9 100644
--- a/lib/Kconfig.debug
+++ b/lib/Kconfig.debug
@@ -251,7 +251,7 @@ config FRAME_WARN
 	int "Warn for stack frames larger than (needs gcc 4.4)"
 	range 0 8192
 	default 2048 if GCC_PLUGIN_LATENT_ENTROPY
-	default 1280 if (!64BIT && PARISC)
+	default 1280 if (!64BIT && (PARISC || KASAN))
 	default 1024 if (!64BIT && !PARISC)
 	default 2048 if 64BIT
 	help
-- 
2.20.0

