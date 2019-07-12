Return-Path: <SRS0=V+Ds=VJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CFF72C742BB
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Jul 2019 12:42:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9726F20645
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Jul 2019 12:42:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1562935324;
	bh=cdGGU7dTEh/uiM1hU41FdGVoWkOY8aZ/LfB1z6F9uxo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=UrHOSqsddvD/RNTujzS//unlFbbBNk5PJOPm6y5iR6aJLhjnSb2ljLCpCua0XTGNl
	 8++QROj33R+GE3qVowXHrKRyhWSP0aWBtxpx/NadO7KJ7tbJL4StTNFr4xVqY4VBox
	 HvS5++p2XG2qioVuHvAge0MIdmLqW+ZooO/zSPdQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726155AbfGLMWv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 12 Jul 2019 08:22:51 -0400
Received: from mail.kernel.org ([198.145.29.99]:57754 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727781AbfGLMWq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Jul 2019 08:22:46 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0B1D0216B7;
        Fri, 12 Jul 2019 12:22:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1562934166;
        bh=cdGGU7dTEh/uiM1hU41FdGVoWkOY8aZ/LfB1z6F9uxo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=SvnO/jZPuC8rB0lX8wwpHjzMd32jC7F9SY4C0f4Sdyc4t76Nwghi++TjzbvbYmvEG
         lDdnWSZ6E5QFE8UIeHQyreGFUNBkZgC/sCXZjS3nZIfbdrKqxtbItlr//3N8vDk4Yp
         7piPhq+brCoUgBSpAkQS4yqGpGcns92e5N+q3fpM=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        =?UTF-8?q?Ari=20Kohtam=C3=A4ki?= <ari.kohtamaki@gmail.com>,
        Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        Sean Young <sean@mess.org>
Subject: [PATCH 4.19 58/91] media: stv0297: fix frequency range limit
Date:   Fri, 12 Jul 2019 14:19:01 +0200
Message-Id: <20190712121624.847241572@linuxfoundation.org>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20190712121621.422224300@linuxfoundation.org>
References: <20190712121621.422224300@linuxfoundation.org>
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
@@ -694,7 +694,7 @@ static const struct dvb_frontend_ops stv
 	.delsys = { SYS_DVBC_ANNEX_A },
 	.info = {
 		 .name = "ST STV0297 DVB-C",
-		 .frequency_min_hz = 470 * MHz,
+		 .frequency_min_hz = 47 * MHz,
 		 .frequency_max_hz = 862 * MHz,
 		 .frequency_stepsize_hz = 62500,
 		 .symbol_rate_min = 870000,


