Return-Path: <SRS0=4ODY=VF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 575C1C606BA
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Jul 2019 13:53:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3673620861
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Jul 2019 13:53:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731540AbfGHNxi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Jul 2019 09:53:38 -0400
Received: from mout.kundenserver.de ([212.227.126.134]:51085 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727401AbfGHNxi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Jul 2019 09:53:38 -0400
Received: from threadripper.lan ([149.172.19.189]) by mrelayeu.kundenserver.de
 (mreue012 [212.227.15.129]) with ESMTPA (Nemesis) id
 1MUTxo-1htFVa4BHs-00QViS; Mon, 08 Jul 2019 15:53:31 +0200
From:   Arnd Bergmann <arnd@arndb.de>
To:     Harry Wentland <harry.wentland@amd.com>,
        Leo Li <sunpeng.li@amd.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
        "David (ChunMing) Zhou" <David1.Zhou@amd.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Bhawanpreet Lakha <Bhawanpreet.Lakha@amd.com>,
        Tony Cheng <Tony.Cheng@amd.com>,
        Joshua Aberback <joshua.aberback@amd.com>,
        Wenjing Liu <Wenjing.Liu@amd.com>,
        Dmytro Laktyushkin <Dmytro.Laktyushkin@amd.com>,
        amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] drm/amd/display: dcn20: include linux/delay.h
Date:   Mon,  8 Jul 2019 15:53:18 +0200
Message-Id: <20190708135329.694852-1-arnd@arndb.de>
X-Mailer: git-send-email 2.20.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:3AQbgHoIbkOa32VoDk5bLzC+5QlQ4gP5p6DVn/CsMDmYXi/m3vL
 3BU/ivzqXjNLdw6xN1FFBUQ+tuVhp1PKBGcs7RmcqllpBPfmKkAvq6E4wGu54wTkaoM/dVH
 dlHE8H/kl1J+q3cngDKcctqTKQVCcr/8GT+crkUtFmxFRKK25L7Yw5J/I4mKE7HpHXlTWMH
 LUFe1p4fz8TwIpDYFPPNA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:P81gE92WStQ=:bH84Tou9LSbpmtFO553fOz
 A6Dgyr8tJZi6gj5u5tpt6WsU8m6Kx+STtblR6JYxgDbz3zHGangCly7WJ7Nxu+EWPt6Ho9als
 m9dL2tSwqpFpiPmeQbZ9+gMfOGnX6eNsgqqERayPBvI7GUmnf2gPrgXW7MguC3PHR/VpmNYUp
 MXEPbPB1B2HaZnjR5iIjKFzPnTAYl3KeANI3jfxMf1PpT4mNvLhPHS46qGSrUynA7/HoHBUO+
 IKpqEAVla65evxD9bAp+UkYWOHTFfzUdaC6MKYLbDPTGhXd5/t+l/wlWmBZOj6RxWkymgo+S+
 gMyktF0RDqB9WhF9IDSqSZHpRxXu1GNHtqghwAP9iuKLFhdeC3Md4DcbCDKWq3zg8Rt2nuUHI
 GcMvOJdh6zcX4gpwI+FvA3qL2HxsPsrEkhS76K/xV7R+GLlCSPSvYMvSXko8tOOParDcfpF4D
 FRhofMcLBx7SaGSmkYIv2mqHehRhioD4BwbxIbXgArV5c7FVZdTwnxX+LJDz7kqxx0Mo2l3TI
 cJ4mGVXKoP0D4NDgjpAdKsgNNFyy9bbs2KsGhpsWwbL1FCUv6iNZkNCBC8kCmeRaq4EoKMUEG
 kWfhC3IlOvRtTS7LCw6p3j4GOxk/lYPCjOqiZhbJPnrqCLxZzqDNqZoEUUQpGbuBkxUUFuks/
 nBK1zS+4/NBZL+KkLATpuci0ibacgIHbiyu+DsIQb8XCHnF1e7WxwwpoIrdQ5cf/9u206wdk9
 KhS8BeTojgu5lfDZNMYvu5xWcVTN7mDYE3DfBQ==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Without this header, we get a compiler error in some configurations:

.../dc/dcn20/dcn20_hwseq.c: In function 'dcn20_hwss_wait_for_blank_complete':
.../dc/dcn20/dcn20_hwseq.c:1493:3: error: implicit declaration of function 'udelay' [-Werror=implicit-function-declaration]

Note: the use of udelay itself may be problematic, as can occupy
the CPU for 200ms in a busy-loop here.

Fixes: 7ed4e6352c16 ("drm/amd/display: Add DCN2 HW Sequencer and Resource")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 drivers/gpu/drm/amd/display/dc/dcn20/dcn20_hwseq.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_hwseq.c b/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_hwseq.c
index 4b0d8b9f61da..6925d25d2457 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_hwseq.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_hwseq.c
@@ -22,6 +22,7 @@
  * Authors: AMD
  *
  */
+#include <linux/delay.h>
 
 #include "dm_services.h"
 #include "dm_helpers.h"
-- 
2.20.0

