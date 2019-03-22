Return-Path: <SRS0=oArh=RZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2A739C10F11
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 11:20:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ED94421971
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 11:20:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1553253616;
	bh=hi6mJt25cE86RVv4ESzBNUlLQDjnk49JNou5OvXAdJw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=vWvPKWEykX7lqoZo04+uJur7MeTp0y/ULvacJRBw2/ZlwZxsdXz0G07eCBPFyiVQV
	 7mZbM8jut8MfPu1sHokH31pysv7UK27GrLX6OWl8CGzBBKhCic2Jdmv3lXpzzTQ4u8
	 RV62ZQvNDuu1qexVK046s8WHYFTSm1PBcC6x8mOo=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728246AbfCVLTw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Mar 2019 07:19:52 -0400
Received: from mail.kernel.org ([198.145.29.99]:46296 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728219AbfCVLTt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Mar 2019 07:19:49 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E096421929;
        Fri, 22 Mar 2019 11:19:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1553253588;
        bh=hi6mJt25cE86RVv4ESzBNUlLQDjnk49JNou5OvXAdJw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=C5oqlKKdgNrtTDxs+d05q1Hem8SIdcsxMp2DXoJL1kjJqp0/43/DpP2/jAQNB4k3b
         2Cc5+WI5m/h0iRBB6y2T6mk0x2HA28wlIHq/tImdSw1lb1ZuqXRPjThn0KUuanvdxY
         q2SViWzvVesQwIOIRsuJH35+WTHjhv8pzcWL2IQ8=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Jia-Ju Bai <baijiaju1990@gmail.com>,
        "David S. Miller" <davem@davemloft.net>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 3.18 014/134] isdn: i4l: isdn_tty: Fix some concurrency double-free bugs
Date:   Fri, 22 Mar 2019 12:13:47 +0100
Message-Id: <20190322111211.099297951@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190322111210.465931067@linuxfoundation.org>
References: <20190322111210.465931067@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

3.18-stable review patch.  If anyone has any objections, please let me know.

------------------

[ Upstream commit 2ff33d6637393fe9348357285931811b76e1402f ]

The functions isdn_tty_tiocmset() and isdn_tty_set_termios() may be
concurrently executed.

isdn_tty_tiocmset
  isdn_tty_modem_hup
    line 719: kfree(info->dtmf_state);
    line 721: kfree(info->silence_state);
    line 723: kfree(info->adpcms);
    line 725: kfree(info->adpcmr);

isdn_tty_set_termios
  isdn_tty_modem_hup
    line 719: kfree(info->dtmf_state);
    line 721: kfree(info->silence_state);
    line 723: kfree(info->adpcms);
    line 725: kfree(info->adpcmr);

Thus, some concurrency double-free bugs may occur.

These possible bugs are found by a static tool written by myself and
my manual code review.

To fix these possible bugs, the mutex lock "modem_info_mutex" used in
isdn_tty_tiocmset() is added in isdn_tty_set_termios().

Signed-off-by: Jia-Ju Bai <baijiaju1990@gmail.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/isdn/i4l/isdn_tty.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/isdn/i4l/isdn_tty.c b/drivers/isdn/i4l/isdn_tty.c
index bc912611fe097..b166354b80428 100644
--- a/drivers/isdn/i4l/isdn_tty.c
+++ b/drivers/isdn/i4l/isdn_tty.c
@@ -1459,15 +1459,19 @@ isdn_tty_set_termios(struct tty_struct *tty, struct ktermios *old_termios)
 {
 	modem_info *info = (modem_info *) tty->driver_data;
 
+	mutex_lock(&modem_info_mutex);
 	if (!old_termios)
 		isdn_tty_change_speed(info);
 	else {
 		if (tty->termios.c_cflag == old_termios->c_cflag &&
 		    tty->termios.c_ispeed == old_termios->c_ispeed &&
-		    tty->termios.c_ospeed == old_termios->c_ospeed)
+		    tty->termios.c_ospeed == old_termios->c_ospeed) {
+			mutex_unlock(&modem_info_mutex);
 			return;
+		}
 		isdn_tty_change_speed(info);
 	}
+	mutex_unlock(&modem_info_mutex);
 }
 
 /*
-- 
2.19.1



