Return-Path: <SRS0=camR=ZD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C5A63C43331
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Nov 2019 18:40:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 94E8F20659
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Nov 2019 18:40:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1573497657;
	bh=2UNOtVcCgsWOM9ecfbBQ1K/3t56d8DMFfhrPNwCxjK4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=wQQa2jDU+AfsifAtRjozPqyIcHBpNOaNZb9Njr/APk3f4yZqwlRaD8bXqP3Tjd+Bj
	 2TNocnVPGy3h0bS1db+gk9CWcRXfcKVQ0Mx3QQgHBsu7boGvTZLIHnF4scB8GfC3vG
	 61m7Fu7JjQC5M54oEVyld0q++H4FkUiNPbh7vK5A=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728827AbfKKSk4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Nov 2019 13:40:56 -0500
Received: from mail.kernel.org ([198.145.29.99]:60068 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729307AbfKKSky (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Nov 2019 13:40:54 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 225C721783;
        Mon, 11 Nov 2019 18:40:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1573497653;
        bh=2UNOtVcCgsWOM9ecfbBQ1K/3t56d8DMFfhrPNwCxjK4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=St+R1/Goyb7ZwIu9AjmmXjB7k/93w2CRzWqqonyJK7GVwo2ElxhSbUK+pAdFNG2YW
         q1c77u7bUQrzus6uLeto6yo1rf+ZgkQmVKbJqVBb7Q53tuIYcLISb5BdGYSxPdwSeo
         Ghe9AWffYl2xlmOduSRMGioH/DV/MdFwJ/LhNjos=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 4.19 018/125] ALSA: hda/ca0132 - Fix possible workqueue stall
Date:   Mon, 11 Nov 2019 19:27:37 +0100
Message-Id: <20191111181442.369597747@linuxfoundation.org>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <20191111181438.945353076@linuxfoundation.org>
References: <20191111181438.945353076@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Takashi Iwai <tiwai@suse.de>

commit 15c2b3cc09a31620914955cb2a89c277c18ee999 upstream.

The unsolicited event handler for the headphone jack on CA0132 codec
driver tries to reschedule the another delayed work with
cancel_delayed_work_sync().  It's no good idea, unfortunately,
especially after we changed the work queue to the standard global
one; this may lead to a stall because both works are using the same
global queue.

Fix it by dropping the _sync but does call cancel_delayed_work()
instead.

Fixes: 993884f6a26c ("ALSA: hda/ca0132 - Delay HP amp turnon.")
BugLink: https://bugzilla.suse.com/show_bug.cgi?id=1155836
Cc: <stable@vger.kernel.org>
Link: https://lore.kernel.org/r/20191105134316.19294-1-tiwai@suse.de
Signed-off-by: Takashi Iwai <tiwai@suse.de>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 sound/pci/hda/patch_ca0132.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/sound/pci/hda/patch_ca0132.c
+++ b/sound/pci/hda/patch_ca0132.c
@@ -6769,7 +6769,7 @@ static void hp_callback(struct hda_codec
 	/* Delay enabling the HP amp, to let the mic-detection
 	 * state machine run.
 	 */
-	cancel_delayed_work_sync(&spec->unsol_hp_work);
+	cancel_delayed_work(&spec->unsol_hp_work);
 	schedule_delayed_work(&spec->unsol_hp_work, msecs_to_jiffies(500));
 	tbl = snd_hda_jack_tbl_get(codec, cb->nid);
 	if (tbl)


