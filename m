Return-Path: <SRS0=rNeM=SR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BFD54C10F0E
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Apr 2019 11:43:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8416D2073F
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Apr 2019 11:43:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=mev.co.uk header.i=@mev.co.uk header.b="QTuPngJY"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727237AbfDOLnN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 15 Apr 2019 07:43:13 -0400
Received: from smtp107.iad3a.emailsrvr.com ([173.203.187.107]:40502 "EHLO
        smtp107.iad3a.emailsrvr.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725794AbfDOLnM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Apr 2019 07:43:12 -0400
Received: from smtp22.relay.iad3a.emailsrvr.com (localhost [127.0.0.1])
        by smtp22.relay.iad3a.emailsrvr.com (SMTP Server) with ESMTP id DDA9E6852;
        Mon, 15 Apr 2019 07:43:11 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=mev.co.uk;
        s=20190130-41we5z8j; t=1555328591;
        bh=dK8JmowgnblOSshUIQYchgoSt4n19Vlz1Em/WdH9390=;
        h=From:To:Subject:Date:From;
        b=QTuPngJYq/Qqfag8wP/V30ZYNnipHrtc9EUUKUlgc2v2GT93heKTXyBUgNkqvw38E
         glith+JehOWkoTSt0YNxay5mrqxY7+VOy6HvfOgnNDbmkhY9YA/xzq4xMnbnxE2cHT
         nodyB6Rn2FQk8SR838yAy6IYfWOYnpmoS92OaY28=
X-Auth-ID: abbotti@mev.co.uk
Received: by smtp22.relay.iad3a.emailsrvr.com (Authenticated sender: abbotti-AT-mev.co.uk) with ESMTPSA id 272B65E66;
        Mon, 15 Apr 2019 07:43:10 -0400 (EDT)
X-Sender-Id: abbotti@mev.co.uk
Received: from ian-deb.inside.mev.co.uk (remote.quintadena.com [81.133.34.160])
        (using TLSv1.2 with cipher DHE-RSA-AES128-GCM-SHA256)
        by 0.0.0.0:465 (trex/5.7.12);
        Mon, 15 Apr 2019 07:43:11 -0400
From:   Ian Abbott <abbotti@mev.co.uk>
To:     devel@driverdev.osuosl.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Ian Abbott <abbotti@mev.co.uk>,
        H Hartley Sweeten <hsweeten@visionengravers.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH 0/2] staging: comedi: ni_usb6501: Fix a couple of bugs
Date:   Mon, 15 Apr 2019 12:43:00 +0100
Message-Id: <20190415114302.6569-1-abbotti@mev.co.uk>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix a bug detected by syzbot and another that I found while
investigating it.

1) staging: comedi: ni_usb6501: Fix use of uninitialized mutex
2) staging: comedi: ni_usb6501: Fix possible double-free of ->usb_rx_buf

 drivers/staging/comedi/drivers/ni_usb6501.c | 10 ++++------
 1 file changed, 4 insertions(+), 6 deletions(-)

