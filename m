Return-Path: <SRS0=/WLL=WS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4432FC3A5A3
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Aug 2019 17:39:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 14E8F20870
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Aug 2019 17:39:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1566495555;
	bh=sWPY5wHpHQYElFzjxxqjIGiuU7yleBCilc6zKT7o3IQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=MYpFrBCJgf0zhqV0D4bai9ASubtUCallFi0c+AKQilnlUuQvDRLVJtqF57//jFZ+8
	 LDyRgrz1JdjYKjIxuY/VEWMIvdoEOQ84WSxn3/DuG0wP0eGfad9BETQeCIDtvSPLxp
	 IjkzQpM+47dnCUlpZwrc51HBU/XBfaAliEcHSXkQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404153AbfHVRYR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 22 Aug 2019 13:24:17 -0400
Received: from mail.kernel.org ([198.145.29.99]:44390 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2404006AbfHVRXt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Aug 2019 13:23:49 -0400
Received: from localhost (wsip-184-188-36-2.sd.sd.cox.net [184.188.36.2])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3DE4623402;
        Thu, 22 Aug 2019 17:23:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1566494628;
        bh=sWPY5wHpHQYElFzjxxqjIGiuU7yleBCilc6zKT7o3IQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=n0jRHdqvXzW3YTdTteveIuHk11XnBQ6afRSYTUrsH71bsi+F8f98qTXHxmv+nWhxa
         h7FZ/UMtjAA3P8Vs4hSUFC1uPeiSUGoyitQfIStxxtqMUjN6SUdpJ09OWgtyyl5k17
         OIvr0+5eLVaSLW/yBC1reCJ3nzsfywPmI7C2+xYE=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Wenwen Wang <wenwen@cs.uga.edu>,
        Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 4.9 059/103] ALSA: hda - Fix a memory leak bug
Date:   Thu, 22 Aug 2019 10:18:47 -0700
Message-Id: <20190822171731.176777180@linuxfoundation.org>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20190822171728.445189830@linuxfoundation.org>
References: <20190822171728.445189830@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Wenwen Wang <wenwen@cs.uga.edu>

commit cfef67f016e4c00a2f423256fc678a6967a9fc09 upstream.

In snd_hda_parse_generic_codec(), 'spec' is allocated through kzalloc().
Then, the pin widgets in 'codec' are parsed. However, if the parsing
process fails, 'spec' is not deallocated, leading to a memory leak.

To fix the above issue, free 'spec' before returning the error.

Fixes: 352f7f914ebb ("ALSA: hda - Merge Realtek parser code to generic parser")
Signed-off-by: Wenwen Wang <wenwen@cs.uga.edu>
Cc: <stable@vger.kernel.org>
Signed-off-by: Takashi Iwai <tiwai@suse.de>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 sound/pci/hda/hda_generic.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/sound/pci/hda/hda_generic.c
+++ b/sound/pci/hda/hda_generic.c
@@ -5898,7 +5898,7 @@ static int snd_hda_parse_generic_codec(s
 
 	err = snd_hda_parse_pin_defcfg(codec, &spec->autocfg, NULL, 0);
 	if (err < 0)
-		return err;
+		goto error;
 
 	err = snd_hda_gen_parse_auto_config(codec, &spec->autocfg);
 	if (err < 0)


