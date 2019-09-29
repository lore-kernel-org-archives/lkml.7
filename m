Return-Path: <SRS0=maO4=XY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DA34AC4360C
	for <linux-kernel@archiver.kernel.org>; Sun, 29 Sep 2019 14:03:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AC72521835
	for <linux-kernel@archiver.kernel.org>; Sun, 29 Sep 2019 14:03:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1569765836;
	bh=9K5VrEJ5Mu18MwhovO++6lF5hDTZl5gGUGSNuOZvb0w=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=wDyY1zspr62ktBs/6n/eRFIFXUey2Xrau7W+Ztj7subB77zVxQYqmlYU5o5cCjFci
	 sl9T6Ck/b4sNrJnNzq/7nu1IgdYmRe6VjBt19iaRbhfPd97jjAyw9kvbSVNOJMT1x/
	 t0OcW1+V2/LhYDTfHA2iSNTxa8P5tFrbBXRGPzu0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729699AbfI2ODy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 29 Sep 2019 10:03:54 -0400
Received: from mail.kernel.org ([198.145.29.99]:47026 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730392AbfI2ODr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 29 Sep 2019 10:03:47 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6A4B22086A;
        Sun, 29 Sep 2019 14:03:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1569765827;
        bh=9K5VrEJ5Mu18MwhovO++6lF5hDTZl5gGUGSNuOZvb0w=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=UMSP38b4q/LSOJTnZtc2mJGlxvvBiZAYxYW+LfjiGIZmbeVTwud3NAdhjOPkwhztP
         n4w3tGZMQDL/Zia2nEXnMR9DW1ZiefR8D3L+4HkCTMbxSfFooJ51P9gROCVWyCE5Lf
         h6BCZfTZmyH3JwLejjmWy3rRFR3Pc5aMpGuWWpzg=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Alan Stern <stern@rowland.harvard.edu>,
        Jiri Kosina <jkosina@suse.cz>,
        syzbot+1088533649dafa1c9004@syzkaller.appspotmail.com
Subject: [PATCH 5.3 09/25] HID: prodikeys: Fix general protection fault during probe
Date:   Sun, 29 Sep 2019 15:56:12 +0200
Message-Id: <20190929135012.543462189@linuxfoundation.org>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20190929135006.127269625@linuxfoundation.org>
References: <20190929135006.127269625@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Alan Stern <stern@rowland.harvard.edu>

commit 98375b86c79137416e9fd354177b85e768c16e56 upstream.

The syzbot fuzzer provoked a general protection fault in the
hid-prodikeys driver:

kasan: CONFIG_KASAN_INLINE enabled
kasan: GPF could be caused by NULL-ptr deref or user memory access
general protection fault: 0000 [#1] SMP KASAN
CPU: 0 PID: 12 Comm: kworker/0:1 Not tainted 5.3.0-rc5+ #28
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS
Google 01/01/2011
Workqueue: usb_hub_wq hub_event
RIP: 0010:pcmidi_submit_output_report drivers/hid/hid-prodikeys.c:300  [inline]
RIP: 0010:pcmidi_set_operational drivers/hid/hid-prodikeys.c:558 [inline]
RIP: 0010:pcmidi_snd_initialise drivers/hid/hid-prodikeys.c:686 [inline]
RIP: 0010:pk_probe+0xb51/0xfd0 drivers/hid/hid-prodikeys.c:836
Code: 0f 85 50 04 00 00 48 8b 04 24 4c 89 7d 10 48 8b 58 08 e8 b2 53 e4 fc
48 8b 54 24 20 48 b8 00 00 00 00 00 fc ff df 48 c1 ea 03 <80> 3c 02 00 0f
85 13 04 00 00 48 ba 00 00 00 00 00 fc ff df 49 8b

The problem is caused by the fact that pcmidi_get_output_report() will
return an error if the HID device doesn't provide the right sort of
output report, but pcmidi_set_operational() doesn't bother to check
the return code and assumes the function call always succeeds.

This patch adds the missing check and aborts the probe operation if
necessary.

Reported-and-tested-by: syzbot+1088533649dafa1c9004@syzkaller.appspotmail.com
Signed-off-by: Alan Stern <stern@rowland.harvard.edu>
CC: <stable@vger.kernel.org>
Signed-off-by: Jiri Kosina <jkosina@suse.cz>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/hid/hid-prodikeys.c |   12 ++++++++++--
 1 file changed, 10 insertions(+), 2 deletions(-)

--- a/drivers/hid/hid-prodikeys.c
+++ b/drivers/hid/hid-prodikeys.c
@@ -551,10 +551,14 @@ static void pcmidi_setup_extra_keys(
 
 static int pcmidi_set_operational(struct pcmidi_snd *pm)
 {
+	int rc;
+
 	if (pm->ifnum != 1)
 		return 0; /* only set up ONCE for interace 1 */
 
-	pcmidi_get_output_report(pm);
+	rc = pcmidi_get_output_report(pm);
+	if (rc < 0)
+		return rc;
 	pcmidi_submit_output_report(pm, 0xc1);
 	return 0;
 }
@@ -683,7 +687,11 @@ static int pcmidi_snd_initialise(struct
 	spin_lock_init(&pm->rawmidi_in_lock);
 
 	init_sustain_timers(pm);
-	pcmidi_set_operational(pm);
+	err = pcmidi_set_operational(pm);
+	if (err < 0) {
+		pk_error("failed to find output report\n");
+		goto fail_register;
+	}
 
 	/* register it */
 	err = snd_card_register(card);


