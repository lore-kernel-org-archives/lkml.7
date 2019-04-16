Return-Path: <SRS0=BZT9=SS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C95F5C10F13
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Apr 2019 20:21:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9539D20663
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Apr 2019 20:21:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730426AbfDPUVP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Apr 2019 16:21:15 -0400
Received: from mout.kundenserver.de ([212.227.126.135]:50809 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728373AbfDPUVP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Apr 2019 16:21:15 -0400
Received: from threadripper.lan ([149.172.19.189]) by mrelayeu.kundenserver.de
 (mreue012 [212.227.15.129]) with ESMTPA (Nemesis) id
 1MdNwm-1ghQsK48lU-00ZNI6; Tue, 16 Apr 2019 22:21:13 +0200
From:   Arnd Bergmann <arnd@arndb.de>
To:     Alexander Viro <viro@zeniv.linux.org.uk>
Cc:     linux-fsdevel@vger.kernel.org, y2038@lists.linaro.org,
        linux-kernel@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>
Subject: [PATCH v3 03/26] compat_ioctl: avoid unused function warning for do_ioctl
Date:   Tue, 16 Apr 2019 22:19:41 +0200
Message-Id: <20190416202013.4034148-4-arnd@arndb.de>
X-Mailer: git-send-email 2.20.0
In-Reply-To: <20190416202013.4034148-1-arnd@arndb.de>
References: <20190416202013.4034148-1-arnd@arndb.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:L+82VjtPNvJ/9cddonfdgesyM2cGZaLGxjHkIqcfsx+rOv8O6Ly
 /DyHOZgU2AA7jki8pndUtENOpJ2bpEu0hmyEGK8DR+IN1Qoh0MeppXgfugDyXCFVdFVc0Jh
 A/OCMaFzrorxhDQtf+HHhRmRQ721VcX4hj+3txfKGC95ge5u7KSuXQg+vzq/B1Bw0CK3HIC
 deP8RTtFmaZv8/f4+p21Q==
X-UI-Out-Filterresults: notjunk:1;V03:K0:ivXdclr+H2A=:bDNmQTqWjYLHmBCcjNyLe/
 gbRn8XJELMvytWkqJiOwVGX9KpRPTB1avv9/pvci0OzdpdUhyGboNqSlNKIlq/9eG5yARrFOP
 FQ7dTJrTW7nKWlDZCqN5FoWV0/TWx5gFz3SRn0Ah6a8YqW+k+qWIafukqEeaTxhPexTk8ttC/
 ec1jHkveXLW6wEepuEhhhfi2DXmwv3cbBzVoLV0VoFg7MlJJYypDtW1YHUBwIe9XIJoc+XPNF
 eFieSzGXILUjkkX6fgVoQM15lXCsdpnpKfPiSAWQ+hsl4F3LgH7RP+hebr70WMamfOiAXBl7w
 jcUYwF+dqkHFWYbW1hJg8NreJ+Rp/yUNl+fqeJBKM6ieH+HpTyGwSUbN8+DzCPwD3EXanGGhK
 tkkkz5tA7+ltQNAUPnX3r338LWGJYwQyswK35lv9xPPqPBykXbMN++nX9xd/CT3wTFnTEo/7O
 0GcKVQwiYlRaR09StA8SjBtBY/tWTaGgoKXbbarfWaTMC3BqxhcErr4DYgh6UrvfxD8pyBxBz
 R3ym+6DC8QKvVv6H1XpTbh5VqOBEzyzXPuvDhZ0u0McqkHlNKANpdVJx6u27CyiVjpBp0nMhI
 R1d6H/8MN5WVXfr75np4SQTDhbqF+7R1KPFG0qKYB2a3epLf3KvM/ypY/NEsY5om3d+yjUjvs
 X3U0K/Ozo4vgTUhe/vcpy986AJRBCV6C1wgmcnjdzgDevYMUzYP1kvEZ7jBcqrJZf1OimopmE
 PXLSZdLkyOm/u2zzc2nFj6VNyGvTsoVlM4ijlw==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The users are becoming rarer, and when the remaining ones are
all turned off, gcc warns about an unused function.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 fs/compat_ioctl.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/compat_ioctl.c b/fs/compat_ioctl.c
index 54f26a9fa9f2..2772b539674d 100644
--- a/fs/compat_ioctl.c
+++ b/fs/compat_ioctl.c
@@ -79,7 +79,7 @@
 	get_user(val, srcptr) || put_user(val, dstptr);	\
 })
 
-static int do_ioctl(struct file *file, unsigned int cmd, unsigned long arg)
+static inline int do_ioctl(struct file *file, unsigned int cmd, unsigned long arg)
 {
 	int err;
 
-- 
2.20.0

