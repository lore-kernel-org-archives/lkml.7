Return-Path: <SRS0=tMFY=W7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CC357C3A5A8
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Sep 2019 18:11:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 96A0D22DBF
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Sep 2019 18:11:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1567620710;
	bh=2+lDASw6thM+eORtmapA7D8758mNopZ9lXcWqgfi+5E=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=2Mqf01US/saZP3HdvL4NcnVelzQ0KMH8V3gOsU9aNi9G0rDqYB+7C1ZUdQ4l6C8Ia
	 +iChZz9ggY7SZV+N2rzyAgigaoMHqrXoHp62jT1AdhKCEYUf21sHI0nqB5IXaOgNg8
	 +zM3eRPtA4HIdItYiOgTQh0hgRPxTSbVArnnQ0qg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390408AbfIDSLt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 4 Sep 2019 14:11:49 -0400
Received: from mail.kernel.org ([198.145.29.99]:55970 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2389206AbfIDSLs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Sep 2019 14:11:48 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2B4AD2087E;
        Wed,  4 Sep 2019 18:11:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1567620707;
        bh=2+lDASw6thM+eORtmapA7D8758mNopZ9lXcWqgfi+5E=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=LdhyAnDBdVMXztfBVDTzszZeBYQIp7CAfUJE/tQ1xTuivNYDGefXUO5wpobkRj4Yp
         yo58Mp0ufjTGdLiSVUkePPW1MHer4yAwzKcul73HZHjiBaV/YW7HIaXWqcHxyGoqwp
         +Y1yIoovGcVk56hTjuRAmerwNvJB7XgkWP8WgvLY=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 5.2 066/143] ALSA: usb-audio: Add implicit fb quirk for Behringer UFX1604
Date:   Wed,  4 Sep 2019 19:53:29 +0200
Message-Id: <20190904175316.650655704@linuxfoundation.org>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20190904175314.206239922@linuxfoundation.org>
References: <20190904175314.206239922@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Takashi Iwai <tiwai@suse.de>

commit 1a15718b41df026cffd0e42cfdc38a1384ce19f9 upstream.

Behringer UFX1604 requires the similar quirk to apply implicit fb like
another Behringer model UFX1204 in order to fix the noisy playback.

BugLink: https://bugzilla.kernel.org/show_bug.cgi?id=204631
Cc: <stable@vger.kernel.org>
Signed-off-by: Takashi Iwai <tiwai@suse.de>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 sound/usb/pcm.c |    1 +
 1 file changed, 1 insertion(+)

--- a/sound/usb/pcm.c
+++ b/sound/usb/pcm.c
@@ -339,6 +339,7 @@ static int set_sync_ep_implicit_fb_quirk
 		ep = 0x81;
 		ifnum = 2;
 		goto add_sync_ep_from_ifnum;
+	case USB_ID(0x1397, 0x0001): /* Behringer UFX1604 */
 	case USB_ID(0x1397, 0x0002): /* Behringer UFX1204 */
 		ep = 0x81;
 		ifnum = 1;


