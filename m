Return-Path: <SRS0=V+Ds=VJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D32E8C742BA
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Jul 2019 12:33:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9FC342166E
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Jul 2019 12:33:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1562934839;
	bh=LOjqXMQkYpBHBq0FVWz6MT6stsHQBZJOIBT/ryXpphw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=kO1IQB4y2LGD2Exm4WMK1NEWg0tileyKqOSyy0yUmxZ+ePTS45Jgk1ItWQ27q+Z2T
	 47GCcnV8o2bg6ifduAKJi6yQaTkDIoNP6GelFwt3O2nji6cEu+L0tIP4aSmOySk4Tb
	 2Jbyy9v9YRjREs4ktFOsNXxdlm1d6qi14cCvXHzU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729692AbfGLMd6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 12 Jul 2019 08:33:58 -0400
Received: from mail.kernel.org ([198.145.29.99]:53476 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728879AbfGLMd4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Jul 2019 08:33:56 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9EF5320645;
        Fri, 12 Jul 2019 12:33:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1562934836;
        bh=LOjqXMQkYpBHBq0FVWz6MT6stsHQBZJOIBT/ryXpphw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=s5pNDEe7J9x9o663UehLqw+PWmgVVYovOfovtG1E81Dhj975Sel473y1GyB1rWhXO
         qqjfAdS+GVdXCS8kRywb5SwH5OFfcrZjuTtwyDRkj7WdbkT8ZvgyAGeQFcGFbFWiIQ
         PZH6RRgQ/mswF7c1149O/OCnrhYnxxOBAQHTwlI4=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        =?UTF-8?q?Ari=20Kohtam=C3=A4ki?= <ari.kohtamaki@gmail.com>,
        Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        Sean Young <sean@mess.org>
Subject: [PATCH 5.2 06/61] media: stv0297: fix frequency range limit
Date:   Fri, 12 Jul 2019 14:19:19 +0200
Message-Id: <20190712121620.959309512@linuxfoundation.org>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20190712121620.632595223@linuxfoundation.org>
References: <20190712121620.632595223@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Mauro Carvalho Chehab <mchehab+samsung@kernel.org>

commit b09a2ab2baeb36bf7ef7780405ad172281741c7c upstream.

There was a typo at the lower frequency limit for a DVB-C
card, causing the driver to fail while tuning channels at the
VHF range.

https://bugzilla.kernel.org/show_bug.cgi?id=202083

Fixes: f1b1eabff0eb ("media: dvb: represent min/max/step/tolerance freqs in Hz")
Reported-by: Ari Kohtamäki <ari.kohtamaki@gmail.com>
Cc: stable@vger.kernel.org
Signed-off-by: Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
Signed-off-by: Sean Young <sean@mess.org>
Signed-off-by: Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/media/dvb-frontends/stv0297.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/drivers/media/dvb-frontends/stv0297.c
+++ b/drivers/media/dvb-frontends/stv0297.c
@@ -682,7 +682,7 @@ static const struct dvb_frontend_ops stv
 	.delsys = { SYS_DVBC_ANNEX_A },
 	.info = {
 		 .name = "ST STV0297 DVB-C",
-		 .frequency_min_hz = 470 * MHz,
+		 .frequency_min_hz = 47 * MHz,
 		 .frequency_max_hz = 862 * MHz,
 		 .frequency_stepsize_hz = 62500,
 		 .symbol_rate_min = 870000,


