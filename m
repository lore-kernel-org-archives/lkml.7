Return-Path: <SRS0=TLrx=2G=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EB03FC2D0BF
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Dec 2019 17:58:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B580F2166E
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Dec 2019 17:58:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1576519135;
	bh=tlchDs7TvajlhgCZ7OeyLriVnH9A9S73sL+PYnPpnpw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=VsxNP2Hnrga6Z42fhqftDVESySWqz52myVQ01NoWac00Yk0G8Nx9ozIVWi7PxW5nz
	 6vXb2domEjX4rSvyd7BltU8dpxvVpsFXtf661KZEBMIHPAxF2AoXu21EPiwqZTcn67
	 nhOPWQRTFCmJrTmDH1P0W3FjA1xrp9alcMtCJKRw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728314AbfLPR6y (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 16 Dec 2019 12:58:54 -0500
Received: from mail.kernel.org ([198.145.29.99]:58978 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726865AbfLPR6s (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Dec 2019 12:58:48 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id BB11920733;
        Mon, 16 Dec 2019 17:58:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1576519127;
        bh=tlchDs7TvajlhgCZ7OeyLriVnH9A9S73sL+PYnPpnpw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=QrmDF5GT3OjkogJ7kKYGaJhuxhbi6urNwVGl9wM39ncOEFNdm29cjo3lMtskoWage
         BsBa8pPk1WIlIStBSl46k54V2J8pj7u5NMVGEWwlwMSqsluUgGswn4jvX+KnGdPFsd
         JKssoHGunMb9Zombi1ONoZRM4RNnV3kZZqxcnSxk=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Pontus Fuchs <pontus.fuchs@gmail.com>,
        Kalle Valo <kvalo@codeaurora.org>,
        "David S. Miller" <davem@davemloft.net>,
        David Laight <David.Laight@ACULAB.COM>,
        Denis Efremov <efremov@linux.com>
Subject: [PATCH 4.14 206/267] ar5523: check NULL before memcpy() in ar5523_cmd()
Date:   Mon, 16 Dec 2019 18:48:52 +0100
Message-Id: <20191216174913.820607863@linuxfoundation.org>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20191216174848.701533383@linuxfoundation.org>
References: <20191216174848.701533383@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Denis Efremov <efremov@linux.com>

commit 315cee426f87658a6799815845788fde965ddaad upstream.

memcpy() call with "idata == NULL && ilen == 0" results in undefined
behavior in ar5523_cmd(). For example, NULL is passed in callchain
"ar5523_stat_work() -> ar5523_cmd_write() -> ar5523_cmd()". This patch
adds ilen check before memcpy() call in ar5523_cmd() to prevent an
undefined behavior.

Cc: Pontus Fuchs <pontus.fuchs@gmail.com>
Cc: Kalle Valo <kvalo@codeaurora.org>
Cc: "David S. Miller" <davem@davemloft.net>
Cc: David Laight <David.Laight@ACULAB.COM>
Cc: stable@vger.kernel.org
Signed-off-by: Denis Efremov <efremov@linux.com>
Signed-off-by: Kalle Valo <kvalo@codeaurora.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/net/wireless/ath/ar5523/ar5523.c |    3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

--- a/drivers/net/wireless/ath/ar5523/ar5523.c
+++ b/drivers/net/wireless/ath/ar5523/ar5523.c
@@ -255,7 +255,8 @@ static int ar5523_cmd(struct ar5523 *ar,
 
 	if (flags & AR5523_CMD_FLAG_MAGIC)
 		hdr->magic = cpu_to_be32(1 << 24);
-	memcpy(hdr + 1, idata, ilen);
+	if (ilen)
+		memcpy(hdr + 1, idata, ilen);
 
 	cmd->odata = odata;
 	cmd->olen = olen;


