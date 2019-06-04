Return-Path: <SRS0=CtY/=UD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	UNPARSEABLE_RELAY,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B57BDC282CE
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Jun 2019 18:27:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6AEFF2070B
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Jun 2019 18:27:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726521AbfFDS1d (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Jun 2019 14:27:33 -0400
Received: from bhuna.collabora.co.uk ([46.235.227.227]:43914 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726179AbfFDS1d (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Jun 2019 14:27:33 -0400
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: koike)
        with ESMTPSA id 6F0C326B37F
From:   Helen Koike <helen.koike@collabora.com>
To:     dm-devel@redhat.com, swboyd@chromium.org
Cc:     wad@chromium.org, keescook@chromium.org, snitzer@redhat.com,
        linux-doc@vger.kernel.org, richard.weinberger@gmail.com,
        linux-kernel@vger.kernel.org, linux-lvm@redhat.com,
        enric.balletbo@collabora.com, kernel@collabora.com, agk@redhat.com,
        Helen Koike <helen.koike@collabora.com>,
        Jonathan Corbet <corbet@lwn.net>
Subject: [PATCH] Documentation/dm-init: fix multi device example
Date:   Tue,  4 Jun 2019 15:27:19 -0300
Message-Id: <20190604182719.15944-1-helen.koike@collabora.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The example in the docs regarding multiple device-mappers is invalid (it
has a wrong number of arguments), it's a left over from previous
versions of the patch.
Replace the example with an valid and tested one.

Signed-off-by: Helen Koike <helen.koike@collabora.com>

---

 Documentation/device-mapper/dm-init.txt | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/Documentation/device-mapper/dm-init.txt b/Documentation/device-mapper/dm-init.txt
index 8464ee7c01b8..130b3c3679c5 100644
--- a/Documentation/device-mapper/dm-init.txt
+++ b/Documentation/device-mapper/dm-init.txt
@@ -74,13 +74,13 @@ this target to /dev/mapper/lroot (depending on the rules). No uuid was assigned.
 An example of multiple device-mappers, with the dm-mod.create="..." contents is shown here
 split on multiple lines for readability:
 
-  vroot,,,ro,
-    0 1740800 verity 254:0 254:0 1740800 sha1
-      76e9be054b15884a9fa85973e9cb274c93afadb6
-      5b3549d54d6c7a3837b9b81ed72e49463a64c03680c47835bef94d768e5646fe;
-  vram,,,rw,
-    0 32768 linear 1:0 0,
-    32768 32768 linear 1:1 0
+  dm-linear,,1,rw,
+    0 32768 linear 8:1 0,
+    32768 1024000 linear 8:2 0;
+  dm-verity,,3,ro,
+    0 1638400 verity 1 /dev/sdc1 /dev/sdc2 4096 4096 204800 1 sha256
+    ac87db56303c9c1da433d7209b5a6ef3e4779df141200cbd7c157dcb8dd89c42
+    5ebfe87f7df3235b80a117ebc4078e44f55045487ad4a96581d1adb564615b51
 
 Other examples (per target):
 
-- 
2.20.1

