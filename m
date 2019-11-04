Return-Path: <SRS0=xa+R=Y4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2D80DCA9EC9
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Nov 2019 22:13:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EBABC204EC
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Nov 2019 22:13:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1572905584;
	bh=kiqSDfakghTbJOA43TAye7jS9c+JcWR0lr5s80yto1E=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=p2XRNLMQ/yKt2DvzhrFX744NKBR910IIAjBWudYpn5AoebkAl2Ybjo6xxjC4zeLIh
	 fgy9X6LKuo5BcRX9qCeXHAC7ibKmohPpN02ud9t3nLskxqfShNS47HpTin7d2820GR
	 dMAQo9nvW4BUeQ/opifZgtYt3ZkQeqt6MAB82uBM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390142AbfKDWNC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 4 Nov 2019 17:13:02 -0500
Received: from mail.kernel.org ([198.145.29.99]:43560 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388431AbfKDWKW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Nov 2019 17:10:22 -0500
Received: from localhost (6.204-14-84.ripe.coltfrance.com [84.14.204.6])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5D6EA20650;
        Mon,  4 Nov 2019 22:10:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1572905421;
        bh=kiqSDfakghTbJOA43TAye7jS9c+JcWR0lr5s80yto1E=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=dVh8mZlyXtZgNPzygQ+Qn/Dxx05cqad2JdOCq3ZdrpDpGzhGtsKLmiQRR68GwDmx5
         CdsoX414MGZTj43idQbuW61cKXxso63yV+QinwbSploneYiboeuF0VyFQULta0atVr
         mveDUO2rCVh0soibbTiOpI41OMjQmlvyI7v0rH3Q=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Takashi Sakamoto <o-takashi@sakamocchi.jp>,
        Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 5.3 097/163] ALSA: bebob: Fix prototype of helper function to return negative value
Date:   Mon,  4 Nov 2019 22:44:47 +0100
Message-Id: <20191104212147.127226477@linuxfoundation.org>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20191104212140.046021995@linuxfoundation.org>
References: <20191104212140.046021995@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Takashi Sakamoto <o-takashi@sakamocchi.jp>

commit f2bbdbcb075f3977a53da3bdcb7cd460bc8ae5f2 upstream.

A helper function of ALSA bebob driver returns negative value in a
function which has a prototype to return unsigned value.

This commit fixes it by changing the prototype.

Fixes: eb7b3a056cd8 ("ALSA: bebob: Add commands and connections/streams management")
Cc: <stable@vger.kernel.org> # v3.16+
Signed-off-by: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Link: https://lore.kernel.org/r/20191026030620.12077-1-o-takashi@sakamocchi.jp
Signed-off-by: Takashi Iwai <tiwai@suse.de>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 sound/firewire/bebob/bebob_stream.c |    3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

--- a/sound/firewire/bebob/bebob_stream.c
+++ b/sound/firewire/bebob/bebob_stream.c
@@ -252,8 +252,7 @@ end:
 	return err;
 }
 
-static unsigned int
-map_data_channels(struct snd_bebob *bebob, struct amdtp_stream *s)
+static int map_data_channels(struct snd_bebob *bebob, struct amdtp_stream *s)
 {
 	unsigned int sec, sections, ch, channels;
 	unsigned int pcm, midi, location;


