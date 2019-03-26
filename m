Return-Path: <SRS0=4nbc=R5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 44761C43381
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Mar 2019 06:41:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 008F320896
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Mar 2019 06:41:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1553582492;
	bh=dEYfebLHPaLEcBJMQmEdbr/y0VDHyw1mgg7GaAxw08Q=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=PjkO3xtqwtfJ+deffiGmdGtfLdRlKhb4TgDJWo/WXAZ+6zpP9m6AVIq7tZg0cxiTr
	 Fj/cOXd7cmMH3+dOvMsIpxtkVdRJ4qCUQLS1zeD3XvyOUTWdZQPoCo6HYvT9HG0x56
	 rM7QjSQIrT9BKLBZtD/x0zsyIkEj1lKGKEbPNT1k=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732753AbfCZGla (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Mar 2019 02:41:30 -0400
Received: from mail.kernel.org ([198.145.29.99]:57312 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732620AbfCZGko (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Mar 2019 02:40:44 -0400
Received: from localhost (unknown [104.132.152.111])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4B2FF2086C;
        Tue, 26 Mar 2019 06:40:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1553582443;
        bh=dEYfebLHPaLEcBJMQmEdbr/y0VDHyw1mgg7GaAxw08Q=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=wkhIz4yXhLmQSsB+fdco19ffoIVlOwvvu5n+bPE9HImj4zP1BFeVc0IC3JgeHm/Gt
         0VslX91pnQFmPvyRhGSZnfxW6Ut/bvW9E9kDNSEH92djbo/WcvZg6TxF5wM5mrgeJ/
         vhCmg8j+zdEr+XXor3zcX+kl+jxewQX5HWPxKmeo=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>,
        Shayenne Moura <shayenneluzmoura@gmail.com>,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        syzbot <syzbot+12f1b031b6da017e34f8@syzkaller.appspotmail.com>
Subject: [PATCH 5.0 41/52] drm/vkms: Fix flush_work() without INIT_WORK().
Date:   Tue, 26 Mar 2019 15:30:28 +0900
Message-Id: <20190326042703.158950790@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190326042700.963224437@linuxfoundation.org>
References: <20190326042700.963224437@linuxfoundation.org>
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

5.0-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>

commit b30b61ff6b1dc37f276cf56a8328b80086a3ffca upstream.

syzbot is hitting a lockdep warning [1] because flush_work() is called
without INIT_WORK() after kzalloc() at vkms_atomic_crtc_reset().

Commit 6c234fe37c57627a ("drm/vkms: Implement CRC debugfs API") added
INIT_WORK() to only vkms_atomic_crtc_duplicate_state() side. Assuming
that lifecycle of crc_work is appropriately managed, fix this problem
by adding INIT_WORK() to vkms_atomic_crtc_reset() side.

[1] https://syzkaller.appspot.com/bug?id=a5954455fcfa51c29ca2ab55b203076337e1c770

Reported-and-tested-by: syzbot <syzbot+12f1b031b6da017e34f8@syzkaller.appspotmail.com>
Signed-off-by: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
Reviewed-by: Shayenne Moura <shayenneluzmoura@gmail.com>
Signed-off-by: Daniel Vetter <daniel.vetter@ffwll.ch>
Link: https://patchwork.freedesktop.org/patch/msgid/1547829823-9877-1-git-send-email-penguin-kernel@I-love.SAKURA.ne.jp
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/gpu/drm/vkms/vkms_crtc.c |    1 +
 1 file changed, 1 insertion(+)

--- a/drivers/gpu/drm/vkms/vkms_crtc.c
+++ b/drivers/gpu/drm/vkms/vkms_crtc.c
@@ -98,6 +98,7 @@ static void vkms_atomic_crtc_reset(struc
 	vkms_state = kzalloc(sizeof(*vkms_state), GFP_KERNEL);
 	if (!vkms_state)
 		return;
+	INIT_WORK(&vkms_state->crc_work, vkms_crc_work_handle);
 
 	crtc->state = &vkms_state->base;
 	crtc->state->crtc = crtc;


