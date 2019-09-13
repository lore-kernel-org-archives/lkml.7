Return-Path: <SRS0=WcLH=XI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 361C7C49ED7
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Sep 2019 13:23:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EE649206A5
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Sep 2019 13:23:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1568381020;
	bh=zm2mKZJbhXD36e1PCCkOnk5RqOK1VDdH6CD1TDRaXx0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=VfD+vTvvj3oXwC+5Olvg3oE/cpf9wVOw7UdAwfzf8bhFxiEq5KVuCXtEhVVpN1nvL
	 9n69HTIGW7G9ZpT3/qqa8AxZIxItY6SuPRbTTnOMixRRrgfb+U6Lgf0S0FaVZMmSnd
	 LLiRDLa8Fl5DYDTxSmKk9Ys72c+XZpTyX/DDkA68=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390701AbfIMNU7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 13 Sep 2019 09:20:59 -0400
Received: from mail.kernel.org ([198.145.29.99]:50260 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2390680AbfIMNU4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Sep 2019 09:20:56 -0400
Received: from localhost (unknown [104.132.45.99])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1AF29214DE;
        Fri, 13 Sep 2019 13:20:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1568380855;
        bh=zm2mKZJbhXD36e1PCCkOnk5RqOK1VDdH6CD1TDRaXx0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=n92i55jSaMkFBOyN72YUTj6OGA24TTvRyrxRtb1GpG54rqPcbCKDPJ4uYxCrh5PFf
         eIisXErE+zW6xGyX5vPkwOH2Besnt3GCLs1xM8dKbAXzzlaeJZIEnfSOf5VBog3i68
         H5qq9O7LwFt8grxnVecQEUWbVm1UMYiDQQI5CP4Y=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 5.2 03/37] ALSA: hda - Fix potential endless loop at applying quirks
Date:   Fri, 13 Sep 2019 14:07:08 +0100
Message-Id: <20190913130511.612416529@linuxfoundation.org>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20190913130510.727515099@linuxfoundation.org>
References: <20190913130510.727515099@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Takashi Iwai <tiwai@suse.de>

commit 333f31436d3db19f4286f8862a00ea1d8d8420a1 upstream.

Since the chained quirks via chained_before flag is applied before the
depth check, it may lead to the endless recursive calls, when the
chain were set up incorrectly.  Fix it by moving the depth check at
the beginning of the loop.

Fixes: 1f57825077dc ("ALSA: hda - Add chained_before flag to the fixup entry")
Cc: <stable@vger.kernel.org>
Signed-off-by: Takashi Iwai <tiwai@suse.de>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 sound/pci/hda/hda_auto_parser.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

--- a/sound/pci/hda/hda_auto_parser.c
+++ b/sound/pci/hda/hda_auto_parser.c
@@ -824,6 +824,8 @@ static void apply_fixup(struct hda_codec
 	while (id >= 0) {
 		const struct hda_fixup *fix = codec->fixup_list + id;
 
+		if (++depth > 10)
+			break;
 		if (fix->chained_before)
 			apply_fixup(codec, fix->chain_id, action, depth + 1);
 
@@ -863,8 +865,6 @@ static void apply_fixup(struct hda_codec
 		}
 		if (!fix->chained || fix->chained_before)
 			break;
-		if (++depth > 10)
-			break;
 		id = fix->chain_id;
 	}
 }


