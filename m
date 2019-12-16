Return-Path: <SRS0=TLrx=2G=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B821EC43603
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Dec 2019 18:31:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 87D08206EC
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Dec 2019 18:31:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1576521105;
	bh=vp9h9sH+3jUCNoXaY9XmcYdycZ30TI2SG5ijrITR6Wo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=f/qE+hkWhVhixL2s9JTANtMDJqfsAIqQ42/8LdnVeYmcZC4oZSPh1eGa1C/Ba4OL7
	 kqWHhibPXXC/xtrSFFZoU30NuqTO+Q/+BEdk3+hip1MQo+RFfnTLzRqzDlz4Dpe5E5
	 JBQat8c+o6b8GfIggz+zKN2vUcbXXz1SBk4Tu+V4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730333AbfLPSbn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 16 Dec 2019 13:31:43 -0500
Received: from mail.kernel.org ([198.145.29.99]:54824 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730723AbfLPSLH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Dec 2019 13:11:07 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6E318206B7;
        Mon, 16 Dec 2019 18:11:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1576519866;
        bh=vp9h9sH+3jUCNoXaY9XmcYdycZ30TI2SG5ijrITR6Wo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=hKgg9g/ES5aXOcKdv1Vg3j+2B2FVzL9toQZpfRboxsGjlEnfmRiGV/8RYPgyei/xf
         Q2QBWQdtKR7wCslaSB9CDfLKj2T0lWYfzdG6HYiXgpeQZh+ERia3feGffWfiR/hN1y
         xlguCGE5kn8v7/aAY4OlH+lnMrQaLZ1P+q1gRhdQ=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Takashi Sakamoto <o-takashi@sakamocchi.jp>,
        Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 5.3 101/180] ALSA: fireface: fix return value in error path of isochronous resources reservation
Date:   Mon, 16 Dec 2019 18:49:01 +0100
Message-Id: <20191216174836.299780318@linuxfoundation.org>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20191216174806.018988360@linuxfoundation.org>
References: <20191216174806.018988360@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Takashi Sakamoto <o-takashi@sakamocchi.jp>

commit 480136343cbe89426d6c2ab74ffb4e3ee572c7ee upstream.

Even if isochronous resources reservation fails, error code doesn't return
in pcm.hw_params callback.

Cc: <stable@vger.kernel.org> #5.3+
Fixes: 55162d2bb0e8 ("ALSA: fireface: reserve/release isochronous resources in pcm.hw_params/hw_free callbacks")
Signed-off-by: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Link: https://lore.kernel.org/r/20191209151655.GA8090@workstation
Signed-off-by: Takashi Iwai <tiwai@suse.de>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 sound/firewire/fireface/ff-pcm.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/sound/firewire/fireface/ff-pcm.c
+++ b/sound/firewire/fireface/ff-pcm.c
@@ -219,7 +219,7 @@ static int pcm_hw_params(struct snd_pcm_
 		mutex_unlock(&ff->mutex);
 	}
 
-	return 0;
+	return err;
 }
 
 static int pcm_hw_free(struct snd_pcm_substream *substream)


