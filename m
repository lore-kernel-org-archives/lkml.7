Return-Path: <SRS0=UImc=ZL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7B786C43215
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Nov 2019 05:43:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4ADD52071B
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Nov 2019 05:43:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1574142237;
	bh=LqMI0tEsXsqQ8LnuUkkaJDxRVpqdAujD1Vwxg1ehTU8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=2chUYlJ9+3oamXNhMpY10c7JI/TKb5GhCnzJF21YgePGzGr5PiirQGjEs+zpur7km
	 PXHb5/xxw/CRDvUeJFa/P1mN4ULYEK0EKZkDm0l6QKjWQQq2asN8uNmG5tJRN/Ik21
	 91wEZyzN4TwdF6lmo18J7XeOUuCJWQ0ljm9QgZoo=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730794AbfKSFn4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Nov 2019 00:43:56 -0500
Received: from mail.kernel.org ([198.145.29.99]:38818 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730778AbfKSFnt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Nov 2019 00:43:49 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D40EF2075E;
        Tue, 19 Nov 2019 05:43:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1574142229;
        bh=LqMI0tEsXsqQ8LnuUkkaJDxRVpqdAujD1Vwxg1ehTU8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=1ZwJTZnD5+mXEn5favhqAXtViNw/7MAz3z/VVBWiOzeMeHY0gDvOrWeMUhz2aDIrS
         uQXnl741MsCIgVRu+iiuam12fZw3iWvjIoiidYkliVeq+NG/iLoBQkV3+OfGbsCqVG
         487kEKschL+y68xbpaG/1HBekDzL6o8gk08fb3DM=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Takashi Iwai <tiwai@suse.de>,
        syzbot+abe1ab7afc62c6bb6377@syzkaller.appspotmail.com
Subject: [PATCH 4.14 011/239] ALSA: usb-audio: Fix missing error check at mixer resolution test
Date:   Tue, 19 Nov 2019 06:16:51 +0100
Message-Id: <20191119051300.187161524@linuxfoundation.org>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <20191119051255.850204959@linuxfoundation.org>
References: <20191119051255.850204959@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Takashi Iwai <tiwai@suse.de>

commit 167beb1756791e0806365a3f86a0da10d7a327ee upstream.

A check of the return value from get_cur_mix_raw() is missing at the
resolution test code in get_min_max_with_quirks(), which may leave the
variable untouched, leading to a random uninitialized value, as
detected by syzkaller fuzzer.

Add the missing return error check for fixing that.

Reported-and-tested-by: syzbot+abe1ab7afc62c6bb6377@syzkaller.appspotmail.com
Cc: <stable@vger.kernel.org>
Link: https://lore.kernel.org/r/20191109181658.30368-1-tiwai@suse.de
Signed-off-by: Takashi Iwai <tiwai@suse.de>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 sound/usb/mixer.c |    4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

--- a/sound/usb/mixer.c
+++ b/sound/usb/mixer.c
@@ -1052,7 +1052,8 @@ static int get_min_max_with_quirks(struc
 		if (cval->min + cval->res < cval->max) {
 			int last_valid_res = cval->res;
 			int saved, test, check;
-			get_cur_mix_raw(cval, minchn, &saved);
+			if (get_cur_mix_raw(cval, minchn, &saved) < 0)
+				goto no_res_check;
 			for (;;) {
 				test = saved;
 				if (test < cval->max)
@@ -1072,6 +1073,7 @@ static int get_min_max_with_quirks(struc
 			snd_usb_set_cur_mix_value(cval, minchn, 0, saved);
 		}
 
+no_res_check:
 		cval->initialized = 1;
 	}
 


