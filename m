Return-Path: <SRS0=oArh=RZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8F7A1C43381
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 14:34:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 67EDC218D3
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 14:34:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729093AbfCVOeZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Mar 2019 10:34:25 -0400
Received: from mout.kundenserver.de ([212.227.126.133]:42545 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729067AbfCVOeY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Mar 2019 10:34:24 -0400
Received: from wuerfel.lan ([149.172.19.189]) by mrelayeu.kundenserver.de
 (mreue009 [212.227.15.129]) with ESMTPA (Nemesis) id
 1MPXpS-1hL0DB0LKc-00Ma3I; Fri, 22 Mar 2019 15:33:47 +0100
From:   Arnd Bergmann <arnd@arndb.de>
To:     Lee Jones <lee.jones@linaro.org>
Cc:     clang-built-linux@googlegroups.com,
        Nick Desaulniers <ndesaulniers@google.com>,
        Nathan Chancellor <natechancellor@gmail.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Charles Keepax <ckeepax@opensource.cirrus.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Sapthagiri Baratam <sapthagiri.baratam@cirrus.com>,
        Colin Ian King <colin.king@canonical.com>,
        patches@opensource.cirrus.com, linux-kernel@vger.kernel.org
Subject: [PATCH] mfd: arizona: fix undefined behavior
Date:   Fri, 22 Mar 2019 15:33:37 +0100
Message-Id: <20190322143345.1208144-1-arnd@arndb.de>
X-Mailer: git-send-email 2.20.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:xIa628kaEnjxRdbZtVTepxGCiZqr9F/xHj3Bl6rG4r9O/ufNc3k
 rfcAqo4uT3Q0sl+2SvhyhUf7rimuKFJa+zasw/NYhG/yVWAkF4hEAMbQCaT111cEB7eL/U+
 tXxl/zfWba0aeClXAkNk/6oq3LdL7jGRSe6ltKI16+nZ59l8dOHQIGbDtKcI8rMNAAe1Y2R
 4vib9SaiQnxLEMXJtT8IQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:PzEbtT9jSxA=:NxTZ9ZfLS8xWvzxLZ82av0
 sGiY7Yn/Ry7ePxEXa/CfUZp9rGnkJZyTV39wjYwQHCTwPubzfC+fig/ZkMfEqLzj5OjIK614s
 0Fw0I7eYK5L+g5wLMecGTKyPEibq+62iK2ing2VZI+45fnBoHV81lG7OPjIwHgJfkIKVl3h6F
 tD8el8YYbooMlYdalnHvVwZc8u3XDP63XwRawIR3UyWFWR0MydchCXJIOdnGLL05oPKBxj6zs
 1HMYliN0pHleHYv7XqHIeEW9bvZ7W8iZsVNDOjHYnaSDQqJyJYwejYfOm8Db9ND7rJbAk8akH
 vCQpt+xSIxAAnJJviM619ii/kMHNl1ruGYBL2wYXSxvAQEutTm1IgvC9VuASfi+JycFHJQ+OB
 q2YVugI15K/JeZ8SM77EUBdufhnmfRriehI/zl7GMFqXtv9MlQw+apv9EDFUwXs4ZXxk25FIJ
 1F/BgoEvlfEk6n+XfDq9VU48IpU2kTMkCDCE/DEVQY5iXw/PcoW5lzuPx3OOa0lGoT33w9bj7
 G4s51Dc+emTYHGlF0u2Ur3dOIFkqJR43Dkj+Am160aKzDnMFBE8EiPoc/X4tVwtOgp7h8N7T3
 6wez0KVKmRNGVR7z6UyZvqMfxyXpHhnwYosf2UK8keicJPO46NEpb6OTlV9w1JidVTBE3sKVb
 1/yHGwBNw9nJ/lIjAUZOvGdHE+pPPLWT3eVuioH2ZqN0YfudbOSgDJV4/ubj3HKv8Jh0neDRE
 WaO6Go6KMamAPLugWT8/1qw4ZrUeIb4r060nnA==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When the driver is used with a subdevice that is disabled in the
kernel configuration, clang gets a little confused about the
control flow and fails to notice that n_subdevs is only
uninitialized when subdevs is NULL, and we check for that,
leading to a false-positive warning:

drivers/mfd/arizona-core.c:1423:19: error: variable 'n_subdevs' is uninitialized when used here
      [-Werror,-Wuninitialized]
                              subdevs, n_subdevs, NULL, 0, NULL);
                                       ^~~~~~~~~
drivers/mfd/arizona-core.c:999:15: note: initialize the variable 'n_subdevs' to silence this warning
        int n_subdevs, ret, i;
                     ^
                      = 0

Ideally, we would rearrange the code to avoid all those early
initializations and have an explicit exit in each disabled case,
but it's much easier to chicken out and add one more initialization
here to shut up the warning.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 drivers/mfd/arizona-core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/mfd/arizona-core.c b/drivers/mfd/arizona-core.c
index 27b61639cdc7..0ca0fc9a67fd 100644
--- a/drivers/mfd/arizona-core.c
+++ b/drivers/mfd/arizona-core.c
@@ -996,7 +996,7 @@ int arizona_dev_init(struct arizona *arizona)
 	unsigned int reg, val;
 	int (*apply_patch)(struct arizona *) = NULL;
 	const struct mfd_cell *subdevs = NULL;
-	int n_subdevs, ret, i;
+	int n_subdevs = 0, ret, i;
 
 	dev_set_drvdata(arizona->dev, arizona);
 	mutex_init(&arizona->clk_lock);
-- 
2.20.0

