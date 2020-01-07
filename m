Return-Path: <SRS0=facv=24=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CE2DCC282DD
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Jan 2020 20:30:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9CE422077B
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Jan 2020 20:30:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728736AbgAGU37 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 Jan 2020 15:29:59 -0500
Received: from mout.kundenserver.de ([212.227.126.135]:56829 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728358AbgAGU37 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Jan 2020 15:29:59 -0500
Received: from threadripper.lan ([149.172.19.189]) by mrelayeu.kundenserver.de
 (mreue009 [212.227.15.129]) with ESMTPA (Nemesis) id
 1N9dkD-1jj51m2Ceb-015b7v; Tue, 07 Jan 2020 21:29:51 +0100
From:   Arnd Bergmann <arnd@arndb.de>
To:     David Kershner <david.kershner@unisys.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Ken Cox <jkc@redhat.com>
Cc:     Oleksandr Natalenko <oleksandr@redhat.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Ben Romer <sparmaintainer@unisys.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH] visorbus: fix uninitialized variable access
Date:   Tue,  7 Jan 2020 21:29:40 +0100
Message-Id: <20200107202950.782951-1-arnd@arndb.de>
X-Mailer: git-send-email 2.20.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:A3vqejOyvQFg7EgPKffaWXbL66TEeJSQDnB6fJS2Cl71lvFcAg9
 MK19iLCmfeaWBAnxw+502EVUjkfUzn8UEBKftVyS9zLMD7UzjimfIODtOlZVvvldTZW/0sD
 ppLslFLMtIFMA+YLBL4jI/BsyOxcb33bl8NK0ihk1PiuKK4Gaw3gymQSNeWVhHnXEAJZjGu
 0P+08o43YYBYqWEinY3AQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:Sq5Ej1NwByc=:YTbtF4Mw3YPLwIC2BrgVHl
 9IZsaOCLg4ITa+BDxz+5V67U+GopIYWiPUcwn5ML2+kGNOB84Q6b2Zbw9EwoR6iPMqcLyC/+9
 dd6ehQOlSLW7Tk1D3zLLnYF+7ANlopW5jBpMpOhCrMau/4Nqhr/jFmMS9Sf/8l6umJM2q9xQY
 Y4bysTo1NRJ5Xdh7N5uxu4T6G9322PfgyPwuIxJXmUFFto3Mc7Iw/sLMHDuBVfubVjUauiSrj
 t4ExIIx+VUFSMMQHvGNMeXOurYfmmdSynyJMZSKVu8SDdltOR5R1KzgRNT857QllUBzTDTknu
 gZICsCEYALzKtKRgs1rcP/SUDg4+YY4uJUDsGg+JtU1W+xn9OqavNgcc6AtA3Kj2it49aBL6/
 BRiFShuTVrxTfPm7bKTI5rnuyQvVW3R9tgKRuJ+5gZ73D0jva9XzVZpc5GheP8c00bRnC9ZEL
 UZ1ZwoJFd0G7qM7xFcyO2FZAED9aw4jfkoY78wiJWVmFJ/NJo8N8AOcAMaNYDopnWcnJOIELy
 fiaW4ZYTvFuF4926ItvKIdo7YrhnPDurI/hQtIOw9uSd/OK/J7TypW3I1Jteg5F+VfDMuYTqp
 QEOMf70cKx7KiAZ4BT87PFNcGPooHGV+VeKEcSPzd70kBN0Eo+LghwDE4R+YvOgRH9LDOxl+F
 SH7qL9ZVHm4nb/7Z9uOD5zaFfv0YvrS7RHttMzF+5w2ByTbCs20TyU1qf6Ch2T6YtnYrN5yA6
 wxOJ13labI2Ys1zF/x43N2AkSJd5jsImGvWCQlNcw5VY0s509wISYW53QFOn8QcBFWvso3jGw
 m8D2zM7YgE0v91KHpVCrIjMeK7NOH5UtfKtFaDIVeoQfu+iWQNJfhHScOvfFZfDUx18zZ5TWu
 mjiBE2hmblWYjX9A8UlQ==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The setup_crash_devices_work_queue function only partially initializes
the message it sends to chipset_init, leading to undefined behavior:

drivers/visorbus/visorchipset.c: In function 'setup_crash_devices_work_queue':
drivers/visorbus/visorchipset.c:333:6: error: '((unsigned char*)&msg.hdr.flags)[0]' is used uninitialized in this function [-Werror=uninitialized]
  if (inmsg->hdr.flags.response_expected)

Set up the entire structure, zero-initializing the 'response_expected'
flag.

This was apparently found by the patch that added the -O3 build option
in Kconfig.

Fixes: 12e364b9f08a ("staging: visorchipset driver to provide registration and other services")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 drivers/visorbus/visorchipset.c | 11 +++++++----
 1 file changed, 7 insertions(+), 4 deletions(-)

diff --git a/drivers/visorbus/visorchipset.c b/drivers/visorbus/visorchipset.c
index ca752b8f495f..cb1eb7e05f87 100644
--- a/drivers/visorbus/visorchipset.c
+++ b/drivers/visorbus/visorchipset.c
@@ -1210,14 +1210,17 @@ static void setup_crash_devices_work_queue(struct work_struct *work)
 {
 	struct controlvm_message local_crash_bus_msg;
 	struct controlvm_message local_crash_dev_msg;
-	struct controlvm_message msg;
+	struct controlvm_message msg = {
+		.hdr.id = CONTROLVM_CHIPSET_INIT,
+		.cmd.init_chipset = {
+			.bus_count = 23,
+			.switch_count = 0,
+		},
+	};
 	u32 local_crash_msg_offset;
 	u16 local_crash_msg_count;
 
 	/* send init chipset msg */
-	msg.hdr.id = CONTROLVM_CHIPSET_INIT;
-	msg.cmd.init_chipset.bus_count = 23;
-	msg.cmd.init_chipset.switch_count = 0;
 	chipset_init(&msg);
 	/* get saved message count */
 	if (visorchannel_read(chipset_dev->controlvm_channel,
-- 
2.20.0

