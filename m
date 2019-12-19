Return-Path: <SRS0=nnGO=2J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6EFCFC43603
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Dec 2019 18:47:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 36E7E24672
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Dec 2019 18:47:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1576781220;
	bh=tlchDs7TvajlhgCZ7OeyLriVnH9A9S73sL+PYnPpnpw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=lVxHmgz2iNOrblds2GHInnN+w0l2VMiOlRkq6SiejdIgIGjlIguOui54c83Jzv2xN
	 CMsmpZtwMTygaAudlMdzXxWcORND1QkznHN27XOCvYN+RPoOZqOL7ZztxovZYcIMHE
	 P6JCX3i8dnyAToqC3Fmwpcro16aSmnNtAj774uWA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729079AbfLSSq6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 19 Dec 2019 13:46:58 -0500
Received: from mail.kernel.org ([198.145.29.99]:39726 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729395AbfLSSqy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Dec 2019 13:46:54 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8294E24672;
        Thu, 19 Dec 2019 18:46:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1576781214;
        bh=tlchDs7TvajlhgCZ7OeyLriVnH9A9S73sL+PYnPpnpw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ppqVDrJnx82hN0OfHtvGOZ8BVj9DY/TZXRCy0NolxfsedJJpZ2mzi8VXno7XtelAq
         +ogganEQwCWm+AiN9RZCUOuDkvtU/qo5/qAarh1Hw6FP+OG3b4ERHoTPoLITTSrVdU
         fcjlSiw+f67OVDudG7b1OoOMpxow6mDNXVHyslWs=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Pontus Fuchs <pontus.fuchs@gmail.com>,
        Kalle Valo <kvalo@codeaurora.org>,
        "David S. Miller" <davem@davemloft.net>,
        David Laight <David.Laight@ACULAB.COM>,
        Denis Efremov <efremov@linux.com>
Subject: [PATCH 4.9 130/199] ar5523: check NULL before memcpy() in ar5523_cmd()
Date:   Thu, 19 Dec 2019 19:33:32 +0100
Message-Id: <20191219183222.231631189@linuxfoundation.org>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20191219183214.629503389@linuxfoundation.org>
References: <20191219183214.629503389@linuxfoundation.org>
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


