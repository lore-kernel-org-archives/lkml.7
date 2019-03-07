Return-Path: <SRS0=uyI7=RK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8238BC43381
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Mar 2019 09:30:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 870A120835
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Mar 2019 09:30:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726281AbfCGJag (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 Mar 2019 04:30:36 -0500
Received: from mout.kundenserver.de ([212.227.126.187]:39459 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726136AbfCGJaf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Mar 2019 04:30:35 -0500
Received: from wuerfel.lan ([109.192.41.194]) by mrelayeu.kundenserver.de
 (mreue011 [212.227.15.129]) with ESMTPA (Nemesis) id
 1Mq33i-1ggE2u0AMs-00n6Hn; Thu, 07 Mar 2019 10:30:22 +0100
From:   Arnd Bergmann <arnd@arndb.de>
To:     Jeff Kirsher <jeffrey.t.kirsher@intel.com>,
        "David S. Miller" <davem@davemloft.net>
Cc:     Nick Desaulniers <ndesaulniers@google.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Sasha Neftin <sasha.neftin@intel.com>,
        intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] igc: remove unused igc_priv_flags_strings array
Date:   Thu,  7 Mar 2019 10:29:57 +0100
Message-Id: <20190307093014.3293229-1-arnd@arndb.de>
X-Mailer: git-send-email 2.20.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:N3mvzSfNDVeTkiwt0IdLZpwokV6/9jud1nD98nGRX1EUJEqVPGy
 D2FdE55gGo8FUMjX06Bg4VZA9E54mdlygtYJUcS7FI6C/ZB1B7u0MjZegnvMLTGa5WpGGMj
 nd/QizUeLx5QaBZmbTJIfXJevyB6Ro4KkAPCFyr4jFi7x7eNzOKB4sWax3vGxfiVt+AfnJI
 XvWa8gjtxBb8xjlcZfm7A==
X-UI-Out-Filterresults: notjunk:1;V03:K0:Lli521qOlkE=:PQHUQR4B0W6D5kxGg4KDai
 CaPaQ7rmfvijXUDElKJIpX6wIA3PMiPIyYHn6DIafsclM4zWtO6+MctLLywc11FiY+v11EXKq
 p4HYL3npnjPKIyYj4z6AIzgTyEy6YhjfoNtnu1FLfcgY7sGHn5OLff0gLXejiGbg/2mry0Mzh
 GrK8h3cn2iHBCqROZ2mPmPtsyA/g/NotVV/ZRci8zG+0r625RaxBdeyMa34TL3+vo8mikE8sB
 7mDDi3rnV7QMyRDHWZmgPkvNzyx9788YsmmRJu4cUhFuLrwFEVzocaBudfWuB3VefxXNqwS3p
 /YoNsZas5TvgS8pllNKmEn61M3fZ+tka7qLEZCw5TIfV/Ysz0Gdtb9MwvRSh37bb6A7qlqDQp
 AHoCJv9foPLiiSZSehr2IVOi1wmoy6MV99YtVuV3QAwQIYQ8qqwIEdFqdY8wsS2/gHGss6lgO
 5p3EQyOTIsVfpHv8aSzsN+zOtRAypuamLs7s5rDjvCQqUCUmfoYymt9SHFwGPFFyE68IAI7Qu
 KgQjY0hj3MyfmuGJMyvibNpR1o0MgUvVDj5Yvq4w0N+8WDQtu8ljqbvMx0ZwP6OWIipYhH320
 86rBAdheiNp/nCgUpgUtxwgYUdsPqOmxFGlOO1kHYeSCKW4RiuaoMdoch7khTsVPjNsRLabN8
 XPNGA7j50MKYFHD7ksAoTqapOqNcNN5kSsZDABXU44esuKPEApCQmFaqR6aGVJQjUyqfEY50R
 1oR/kQiOUYuEOTFefrgNCp5QovGoM0Iq0ORYLQ==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

clang points out that the igc_priv_flags_strings[] array is never
referenced, aside from being used for calculating its length:

drivers/net/ethernet/intel/igc/igc_ethtool.c:9:19: error: variable 'igc_priv_flags_strings' is not needed and will not
      be emitted [-Werror,-Wunneeded-internal-declaration]
static const char igc_priv_flags_strings[][ETH_GSTRING_LEN] = {

A similar array is present in several other intel ethernet drivers,
but all the others use it in their .get_strings() callback, which
igc does not implement (yet).

Probably it should be implemented, but as I have no way of testing
it, this does the simpler alternative of removing the array to
get rid of the warning.

Fixes: 8c5ad0dae93c ("igc: Add ethtool support")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 drivers/net/ethernet/intel/igc/igc_ethtool.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/drivers/net/ethernet/intel/igc/igc_ethtool.c b/drivers/net/ethernet/intel/igc/igc_ethtool.c
index eff37a6c0afa..9e352c2be644 100644
--- a/drivers/net/ethernet/intel/igc/igc_ethtool.c
+++ b/drivers/net/ethernet/intel/igc/igc_ethtool.c
@@ -6,12 +6,9 @@
 
 #include "igc.h"
 
-static const char igc_priv_flags_strings[][ETH_GSTRING_LEN] = {
 #define IGC_PRIV_FLAGS_LEGACY_RX	BIT(0)
-	"legacy-rx",
-};
 
-#define IGC_PRIV_FLAGS_STR_LEN ARRAY_SIZE(igc_priv_flags_strings)
+#define IGC_PRIV_FLAGS_STR_LEN		1
 
 static void igc_get_drvinfo(struct net_device *netdev,
 			    struct ethtool_drvinfo *drvinfo)
-- 
2.20.0

