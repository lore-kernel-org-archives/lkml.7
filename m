Return-Path: <SRS0=4ODY=VF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E38A1C606BD
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Jul 2019 15:24:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B27E220665
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Jul 2019 15:24:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1562599485;
	bh=nBB6RH8DlhwgZizyYTe+f/eNVq+Li7TO2zarQoSczqY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=PrRh0oS4EDOTK0360wrBuy12ArKy2SyYduRLsLmS7qGL6Kvc+n31MWq7EINyEzXnG
	 cIjOciNqaGe05vkdQ7VMHc0lG4AR5oJHMErXbiaxoGxRGS2WU6eTQd+tkTqsWaLoO0
	 xlmUGIhONNqisRgdMZvoYM6mHL32TLJ0OaQpxu2k=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388394AbfGHPYo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Jul 2019 11:24:44 -0400
Received: from mail.kernel.org ([198.145.29.99]:52004 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388389AbfGHPYk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Jul 2019 11:24:40 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9A0E1204EC;
        Mon,  8 Jul 2019 15:24:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1562599480;
        bh=nBB6RH8DlhwgZizyYTe+f/eNVq+Li7TO2zarQoSczqY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=K+S2sUw03hT/umG/hYJG0LUKTkel2aFn6TayDRM1rU6r3NvcGKdZP29iowmpsVTL0
         hoiOPSs2FjIoaAwxqbXGk50VMVKiro5YPUhNYgNMs+UmuUREHDqRDEaX6sF29fZJOu
         2IrksMwkf6KCougdDFAQlm3P4q6ZgePSiTnW3Gtk=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Colin Ian King <colin.king@canonical.com>,
        Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 4.14 29/56] ALSA: usb-audio: fix sign unintended sign extension on left shifts
Date:   Mon,  8 Jul 2019 17:13:21 +0200
Message-Id: <20190708150522.585884964@linuxfoundation.org>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20190708150514.376317156@linuxfoundation.org>
References: <20190708150514.376317156@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Colin Ian King <colin.king@canonical.com>

commit 2acf5a3e6e9371e63c9e4ff54d84d08f630467a0 upstream.

There are a couple of left shifts of unsigned 8 bit values that
first get promoted to signed ints and hence get sign extended
on the shift if the top bit of the 8 bit values are set. Fix
this by casting the 8 bit values to unsigned ints to stop the
unintentional sign extension.

Addresses-Coverity: ("Unintended sign extension")
Signed-off-by: Colin Ian King <colin.king@canonical.com>
Cc: <stable@vger.kernel.org>
Signed-off-by: Takashi Iwai <tiwai@suse.de>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 sound/usb/mixer_quirks.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

--- a/sound/usb/mixer_quirks.c
+++ b/sound/usb/mixer_quirks.c
@@ -754,7 +754,7 @@ static int snd_ni_control_init_val(struc
 		return err;
 	}
 
-	kctl->private_value |= (value << 24);
+	kctl->private_value |= ((unsigned int)value << 24);
 	return 0;
 }
 
@@ -915,7 +915,7 @@ static int snd_ftu_eff_switch_init(struc
 	if (err < 0)
 		return err;
 
-	kctl->private_value |= value[0] << 24;
+	kctl->private_value |= (unsigned int)value[0] << 24;
 	return 0;
 }
 


