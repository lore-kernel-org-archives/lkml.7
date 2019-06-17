Return-Path: <SRS0=xALZ=UQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 23A54C31E57
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Jun 2019 12:42:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 02B2820861
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Jun 2019 12:42:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727749AbfFQMl6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Jun 2019 08:41:58 -0400
Received: from mout.kundenserver.de ([212.227.126.134]:37155 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726005AbfFQMl6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Jun 2019 08:41:58 -0400
Received: from threadripper.lan ([149.172.19.189]) by mrelayeu.kundenserver.de
 (mreue010 [212.227.15.129]) with ESMTPA (Nemesis) id
 1N7Qkv-1iheZG478H-017ooU; Mon, 17 Jun 2019 14:41:52 +0200
From:   Arnd Bergmann <arnd@arndb.de>
To:     Oded Gabbay <oded.gabbay@gmail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Omer Shpigelman <oshpigelman@habana.ai>,
        Mike Rapoport <rppt@linux.ibm.com>,
        Dalit Ben Zoor <dbenzoor@habana.ai>,
        Tomer Tayar <ttayar@habana.ai>, linux-kernel@vger.kernel.org
Subject: [PATCH] habanalabs: use u64_to_user_ptr() for reading user pointers
Date:   Mon, 17 Jun 2019 14:41:33 +0200
Message-Id: <20190617124150.989515-1-arnd@arndb.de>
X-Mailer: git-send-email 2.20.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:6kBQWmB9Eiix9XGPUT/rWP2iXwrCtStMVjD4YJLXaKmrcjyeybc
 75IXtxsfP9mXX5V5LeHkToTr/XCOowMSiUXxHAcYx1jm4pYev6xgJgSSVtU61Rs0eCJOclR
 IpIMJ+PpOvYBI0FWidEYaxiMg+xhPjPUpiI9xiNrzlz9EPTLbfwzvrgQiWOxhx/ivoAl0Sg
 AHmItyeNBi8iQFXzgDFpw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:uSN/4pOj6Iw=:KZ1W+0SgQnY08CT7Z1gNmS
 7Jxfd5qLGxDOcEIg0U3uS2bbF3D8Zdtgv0232wUnB+Mt1dq6mUDAQXKxYqrbRoRwlrEJOZitC
 BJMyuotOD/stQ2jOh84w6eZJk+Oe9rjLdDeMkMWtdGBGOMRrnPgD1Oo+u7KruagowOgShdzoD
 Z74NrxEufJGzzqcW6vsqf68100zsPujgNRv7b8UOHkhWpps8l2BbxAYtrFuU+nlZErTvjduFl
 wBqXpxpW2zRyBiDSBW7pIodwHoWZ93Wm5XxyR17g21EosHd0kqfMVSu3f0lzksn7z/G55aDOb
 1vcasmmq9E59yrZCFa6nkLRm6Mg0bs6C1upRV1MFN9v1hW1rqYPzoX9pFb254au3KbnNzjTNy
 Wg6niceBjbHntsbHwzfJQ7lFQx4xCp40sEqghJJ3O6hyDBgRMk5DB9QW3IiEyp7rJgfCPxtAL
 mdUHVVh+IR3LUZTLxreE3v+60Kw9xmFdeZuqRtA7I6YKWp7QTGvmpm/YUjbg4kG6VYiaxoUSo
 O/bmgRgZWmQBldBIWNNjw6ImiRBDVnM/E7CQxEuDCn+gCa5F5qO2zLTsuzkK9NQN0y3kYXQc2
 ktl1RailC8isQH5kt9V+HWw3+q3413bnooJiOsLuSI4DizS6RBmiYJT3kbc+NfbN1ywRqltk1
 6bxAQ+wIPquINtib8Vk/WakkV72movflD9KZIaom1tXd46axT5rEOhI90pEL8hL8skS1nRvlF
 PJVmqheHpTAnr2/f3FHKEdhB0WfUIxE1Snouyw==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We cannot cast a 64-bit integer to a pointer on 32-bit architectures
without a warning:

drivers/misc/habanalabs/habanalabs_ioctl.c: In function 'debug_coresight':
drivers/misc/habanalabs/habanalabs_ioctl.c:143:23: error: cast to pointer from integer of different size [-Werror=int-to-pointer-cast]
   input = memdup_user((const void __user *) args->input_ptr,

Use the macro that was defined for this purpose.

Fixes: 315bc055ed56 ("habanalabs: add new IOCTL for debug, tracing and profiling")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 drivers/misc/habanalabs/habanalabs_ioctl.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/misc/habanalabs/habanalabs_ioctl.c b/drivers/misc/habanalabs/habanalabs_ioctl.c
index eeefb22023e9..b7a0eecf6b6c 100644
--- a/drivers/misc/habanalabs/habanalabs_ioctl.c
+++ b/drivers/misc/habanalabs/habanalabs_ioctl.c
@@ -140,7 +140,7 @@ static int debug_coresight(struct hl_device *hdev, struct hl_debug_args *args)
 	params->op = args->op;
 
 	if (args->input_ptr && args->input_size) {
-		input = memdup_user((const void __user *) args->input_ptr,
+		input = memdup_user(u64_to_user_ptr(args->input_ptr),
 					args->input_size);
 		if (IS_ERR(input)) {
 			rc = PTR_ERR(input);
-- 
2.20.0

