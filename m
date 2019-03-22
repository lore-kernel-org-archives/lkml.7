Return-Path: <SRS0=oArh=RZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C57DEC43381
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 14:08:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8A78321874
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 14:08:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728084AbfCVOIO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Mar 2019 10:08:14 -0400
Received: from mout.kundenserver.de ([212.227.126.130]:53411 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727487AbfCVOIN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Mar 2019 10:08:13 -0400
Received: from wuerfel.lan ([149.172.19.189]) by mrelayeu.kundenserver.de
 (mreue012 [212.227.15.129]) with ESMTPA (Nemesis) id
 1N7xml-1gujVI0uTD-014xXn; Fri, 22 Mar 2019 15:06:51 +0100
From:   Arnd Bergmann <arnd@arndb.de>
To:     Takashi Iwai <tiwai@suse.com>,
        Connor McAdams <conmanx360@gmail.com>,
        Takashi Sakamoto <o-takashi@sakamocchi.jp>
Cc:     clang-built-linux@googlegroups.com,
        Nick Desaulniers <ndesaulniers@google.com>,
        Nathan Chancellor <natechancellor@gmail.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Jaroslav Kysela <perex@perex.cz>,
        Alastair Bridgewater <alastair.bridgewater@gmail.com>,
        alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
Subject: [PATCH] ALSA: hda/ca0132: work around clang -Wuninitialized warning
Date:   Fri, 22 Mar 2019 15:06:28 +0100
Message-Id: <20190322140649.197027-1-arnd@arndb.de>
X-Mailer: git-send-email 2.20.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:evwjwt7mhgRLU3GN33j/cnsVOiV9wjtnPs/Dj8C9wsXFF7C7+eG
 KQftvmfclIpjzA1lm+KnVgJGY+aizj2DBCfem1Hi0U7EjOTEllryll26CsB42wPv6dsbF1E
 CEIvqkUZzFlTa2gp36kUqL23R0B+GNzD7O6D2N+Ac8hlmvWTh6S7+mXtd2jmlVenCxHydYA
 hQnSGqwKjuRwRm1r4vEgg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:3wEGlyncInU=:JLa7x3tbCMH4nqij1shbri
 1xq5ojC/sg+a7kY5uMO4xkVsvGVDMMsQjuxcjIDblPP60GITXocCVHQ7xFhEQSjbmLnVjwnYp
 Tgc0jmUlMoTcYZVKy+Y3HX+MKSoewt7gEjeHNgy9/BOSrXDlcwIKRcLiA0qL/Y7mVF+G7heDu
 uYK2wNYWGLtdJ5XZbGZeI6ERlXCRI5RboGYefcKeOm8dzERDQtZhg+6v+hPtEIQ3M9SnWT79L
 eCP4HoljvvJPPWe6foESCtfg9UfiP/KSWjLBWOn5pnLEnNwIbv8rlDjCqFq9oksq40iM6EkGs
 naZpyz9qPuBvFcSvquPL0IaKftJIBZ0425E1E+GqQjKGAnV5F8zq+Z5nzlqnVjVbmoVbI4ucg
 7b3WhkNCsEgmN7R9yjmjEYi3wAC7ym1iUzebRZ1D7CSAx8dDZDjvI+4umCKD6S3nE2rq2MYDn
 CH1bzybw0w39JvLmb+18jLZwMV5tIbRKB1X29xuiY5rEql06RzMR4onrsxj07lowf62E4iX3J
 /zgk7tLeMbz+Ai6i/IZJCsA79VIY2CyOA9oYjYJz7Fn/8xJo21w5l7N2GLodHwW4YKq1jrt6Y
 kEVn/7/uSczGN2zo3QeF9X9zoIa48+0xni9FsLfjaGxluG2y8zd+FATDyIW2/Z7WoGbEmsLNs
 pqmrbH/cksXIOVsAQ3HytSRx1gD9AqfADM4d6qDrZvER6o034q4SWHCVfdlIolDSwGdEE9AR2
 v624crwjxrDeOLPCOxBOtTH1HgikuOnqJVYnGw==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When CONFIG_PCI is disabled, clang gets confused about the
control flow of the switch() statement always ending up
in the default case, and warns:

sound/pci/hda/patch_ca0132.c:7558:6: error: variable 'fw_entry' is used uninitialized whenever 'if' condition is false
      [-Werror,-Wsometimes-uninitialized]
        if (!spec->alt_firmware_present) {
            ^~~~~~~~~~~~~~~~~~~~~~~~~~~
sound/pci/hda/patch_ca0132.c:7565:42: note: uninitialized use occurs here
        dsp_os_image = (struct dsp_image_seg *)(fw_entry->data);
                                                ^~~~~~~~
sound/pci/hda/patch_ca0132.c:7558:2: note: remove the 'if' if its condition is always true
        if (!spec->alt_firmware_present) {
        ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
sound/pci/hda/patch_ca0132.c:7521:33: note: initialize the variable 'fw_entry' to silence this warning
        const struct firmware *fw_entry;
                                       ^
                                        = NULL

Adding an explicit check for CONFIG_PCI avoids the issue.
Unfortunately this is not very intuitive here.

Link: https://bugs.llvm.org/show_bug.cgi?id=41197#c1
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
Any suggestions for other workarounds appreciated. If you can think
of a better fix, please treat this as a reported-by:
---
 sound/pci/hda/patch_ca0132.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/pci/hda/patch_ca0132.c b/sound/pci/hda/patch_ca0132.c
index 29882bda7632..415b16b7db70 100644
--- a/sound/pci/hda/patch_ca0132.c
+++ b/sound/pci/hda/patch_ca0132.c
@@ -7555,7 +7555,7 @@ static bool ca0132_download_dsp_images(struct hda_codec *codec)
 	 * Use default ctefx.bin if no alt firmware is detected, or if none
 	 * exists for your particular codec.
 	 */
-	if (!spec->alt_firmware_present) {
+	if (!IS_ENABLED(CONFIG_PCI) || !spec->alt_firmware_present) {
 		codec_dbg(codec, "Default firmware selected.");
 		if (request_firmware(&fw_entry, EFX_FILE,
 					codec->card->dev) != 0)
-- 
2.20.0

