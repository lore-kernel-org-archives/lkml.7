Return-Path: <SRS0=xALZ=UQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 15786C31E57
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Jun 2019 13:00:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D24E02089E
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Jun 2019 13:00:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727518AbfFQNAj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Jun 2019 09:00:39 -0400
Received: from mout.kundenserver.de ([212.227.17.10]:59849 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725983AbfFQNAj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Jun 2019 09:00:39 -0400
Received: from threadripper.lan ([149.172.19.189]) by mrelayeu.kundenserver.de
 (mreue106 [212.227.15.145]) with ESMTPA (Nemesis) id
 1N4hBx-1iaUKt1pPL-011g38; Mon, 17 Jun 2019 15:00:16 +0200
From:   Arnd Bergmann <arnd@arndb.de>
To:     Luis Chamberlain <mcgrof@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Arnd Bergmann <arnd@arndb.de>, Matteo Croce <mcroce@redhat.com>,
        Kees Cook <keescook@chromium.org>,
        Aaron Tomlin <atomlin@redhat.com>,
        Matthew Wilcox <willy@infradead.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        linux-kernel@vger.kernel.org
Subject: [PATCH] proc/sysctl: make firmware loader table conditional
Date:   Mon, 17 Jun 2019 14:59:42 +0200
Message-Id: <20190617130014.1713870-1-arnd@arndb.de>
X-Mailer: git-send-email 2.20.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:XTaIUBGjnjT9WW+czXzvrv/r6EJZj+23Cfw8xaApEgCOB08WIB2
 Caascn262VC4BGM7/2JOvQmm1nrwtRybanDDj6heklnQ2fppRPXpumytuwrjV6UD6Q4iP2C
 X4f6AHv7mT1R68rVpfFnXJ0p0XOVTtRdLdRd/KdiOwi8+Ylup8EA71o6vGuLganbXPo628K
 5kOm82C+aVxLM08P75kRw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:hMkOW4RJ2SI=:Vg0iBnXdbNqA7hKySE5/Vn
 s+mXw+lDyr66Gs5nXuWJxU2nbaiCgkSBh858yebRs+4VlQt562twokmps5zKjVn73nTyd3lAd
 A7Uib48RFr0mmR46ff0nH1uTml5BpL9Jl3Q1zcGUqOUcnECeHWt2SYZlnkCmX/197X87rl5iA
 lnPIg/U5StCueSKDJ0y6cAQ7suhziSl8/yln6JofhqGkh2cTNGe/t4IpXW6Kj2Ap2VwhZyyQm
 hYzoz5MIOWJhEEFHh9Foi5dlzKu9NPN+z182zFnxaROmnkARmGOFQybM1o5B5YkkX+smFXrIX
 w5Gqe06Ui7/4ez9GWBjG4M1Nk8QYEXCUNdCbeBo4szPELGqjYv1wYHVWULXNgSrzHGOxWSHQA
 pw/xox9+ZdbWAI7vD/G7la/xN7WNpkOesMnzFVHLRmX54JUbHywTB/mBwzJUJQ5PmbOt5plv7
 w8FPUtD7gRUc2D8QHfDNUzYPv1GyH2tFyA7qDUlOf3N54fZw0P1G1ow8IunWg3dj6pBdvN2jg
 3sQEqdaZMuvuU+oKtvZ7A/OTDymex75ivvLMARQ6G46Sss8bITW79gxb5sdRasAMkyYuhk93J
 lphWHohjS6q6cK5oRrtsmvxUkdqLoblEIV4lnQCeLp5QrYFrmm7wTl496sFhvCmrEQtaI7VcD
 CSiP9rc5XAw9RvyCtXT9AV0qDHzLA1h6RcoxPH8+MHVr2gCFG/W+DPTdSWgvvFclIy1+PF+fC
 9LGY4lxjbWJiV8X+ECpCNKy++s14rgfw0QhUrg==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We get a link error in the firmware loader fallback table,
which now refers to the global sysctl_vals variable:

drivers/base/firmware_loader/fallback_table.o:(.data+0x2c): undefined reference to `sysctl_vals'
drivers/base/firmware_loader/fallback_table.o:(.data+0x30): undefined reference to `sysctl_vals'
drivers/base/firmware_loader/fallback_table.o:(.data+0x50): undefined reference to `sysctl_vals'
drivers/base/firmware_loader/fallback_table.o:(.data+0x54): undefined reference to `sysctl_vals'

Add an #ifdef that only builds that table when it is being
used.

Fixes: c81c506545f4 ("proc/sysctl: add shared variables for range check")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 drivers/base/firmware_loader/fallback_table.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/base/firmware_loader/fallback_table.c b/drivers/base/firmware_loader/fallback_table.c
index 58d4a1263480..ba9d30b28edc 100644
--- a/drivers/base/firmware_loader/fallback_table.c
+++ b/drivers/base/firmware_loader/fallback_table.c
@@ -23,6 +23,7 @@ struct firmware_fallback_config fw_fallback_config = {
 };
 EXPORT_SYMBOL_GPL(fw_fallback_config);
 
+#ifdef CONFIG_SYSCTL
 struct ctl_table firmware_config_table[] = {
 	{
 		.procname	= "force_sysfs_fallback",
@@ -45,3 +46,4 @@ struct ctl_table firmware_config_table[] = {
 	{ }
 };
 EXPORT_SYMBOL_GPL(firmware_config_table);
+#endif
-- 
2.20.0

