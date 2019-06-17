Return-Path: <SRS0=xALZ=UQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3B166C31E5B
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Jun 2019 21:19:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0458F2089E
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Jun 2019 21:19:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1560806373;
	bh=x7eZg+XnraK1zyNh45kBrIrXiTjSPE5QLBHqmdyQ2Wo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=yrITlqpsUbvzAcS9ZVBhW+z1LSXHuUwv6TwHgMbB7Z7zjZXetHYQvc8O2ZZ6PcUT+
	 6i4D4T3k44mlcdTqdZ6+Qpn9IDzYnKMmfC4JtHXbSTdubCVDoayXbSbzXKaUJuAM2w
	 G9ePiBhmFnbhMIkosBDAqLsBjlDK53WK9yglX3Lw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728836AbfFQVTb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Jun 2019 17:19:31 -0400
Received: from mail.kernel.org ([198.145.29.99]:43224 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728808AbfFQVT0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Jun 2019 17:19:26 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 377442089E;
        Mon, 17 Jun 2019 21:19:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1560806365;
        bh=x7eZg+XnraK1zyNh45kBrIrXiTjSPE5QLBHqmdyQ2Wo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=kUnf5BTJleJV7u8OusPmRnOWa9hHBWM32sAP0B6AMo9b8vJ1TTRgC/5Lr57Hw3Jql
         ZEBjN7IxVQyT6mPLuSK47tME4YRdspOAgHVx3klIbY1R3Ipvq5uOet/qC3WlMWvayy
         rfAkttW/iI6i1C17CXW/ubBn/U94xWY0W04OEGn8=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Sean Young <sean@mess.org>,
        Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
Subject: [PATCH 5.1 027/115] media: dvb: warning about dvb frequency limits produces too much noise
Date:   Mon, 17 Jun 2019 23:08:47 +0200
Message-Id: <20190617210801.333369369@linuxfoundation.org>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20190617210759.929316339@linuxfoundation.org>
References: <20190617210759.929316339@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Sean Young <sean@mess.org>

commit eb96e57b913ff668b8b804178cdc509f9b3d4472 upstream.

This can be a debug message. Favour dev_dbg() over dprintk() as this is
already used much more than dprintk().

dvb_frontend: dvb_frontend_get_frequency_limits: frequency interval: tuner: 45000000...860000000, frontend: 44250000...867250000

Fixes: 00ecd6bc7128 ("media: dvb_frontend: add debug message for frequency intervals")

Cc: <stable@vger.kernel.org> # 5.0
Signed-off-by: Sean Young <sean@mess.org>
Signed-off-by: Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/media/dvb-core/dvb_frontend.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/drivers/media/dvb-core/dvb_frontend.c
+++ b/drivers/media/dvb-core/dvb_frontend.c
@@ -917,7 +917,7 @@ static void dvb_frontend_get_frequency_l
 			 "DVB: adapter %i frontend %u frequency limits undefined - fix the driver\n",
 			 fe->dvb->num, fe->id);
 
-	dprintk("frequency interval: tuner: %u...%u, frontend: %u...%u",
+	dev_dbg(fe->dvb->device, "frequency interval: tuner: %u...%u, frontend: %u...%u",
 		tuner_min, tuner_max, frontend_min, frontend_max);
 
 	/* If the standard is for satellite, convert frequencies to kHz */


