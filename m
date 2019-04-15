Return-Path: <SRS0=rNeM=SR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 92D67C10F0E
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Apr 2019 11:16:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5A73E2073F
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Apr 2019 11:16:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=mev.co.uk header.i=@mev.co.uk header.b="ChvxF7ND"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727269AbfDOLQw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 15 Apr 2019 07:16:52 -0400
Received: from smtp89.iad3a.emailsrvr.com ([173.203.187.89]:41512 "EHLO
        smtp89.iad3a.emailsrvr.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726298AbfDOLQv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Apr 2019 07:16:51 -0400
X-Greylist: delayed 385 seconds by postgrey-1.27 at vger.kernel.org; Mon, 15 Apr 2019 07:16:51 EDT
Received: from smtp36.relay.iad3a.emailsrvr.com (localhost [127.0.0.1])
        by smtp36.relay.iad3a.emailsrvr.com (SMTP Server) with ESMTP id E299E439A;
        Mon, 15 Apr 2019 07:10:25 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=mev.co.uk;
        s=20190130-41we5z8j; t=1555326625;
        bh=u1YBA1qinJiN8oenxmdCjykH2lLWHSKmI0Oq9IT6qjE=;
        h=From:To:Subject:Date:From;
        b=ChvxF7NDAFOBckNAS8i5kipPizaH5WHcp/6sHvnkmc1NcLd1gYh/kiPy42c5TpXbb
         PMfCTe81qra2DMVpZa8IInyhZZ3+w7BLhr90dERKKMo6RvZA2MDg0AyaGJ3/bGtiYA
         1Bimn4p7FCtAHmHdi3mIPNIlqRX/p6p6XMsucbLw=
X-Auth-ID: abbotti@mev.co.uk
Received: by smtp36.relay.iad3a.emailsrvr.com (Authenticated sender: abbotti-AT-mev.co.uk) with ESMTPSA id 27FD55407;
        Mon, 15 Apr 2019 07:10:25 -0400 (EDT)
X-Sender-Id: abbotti@mev.co.uk
Received: from ian-deb.inside.mev.co.uk (remote.quintadena.com [81.133.34.160])
        (using TLSv1.2 with cipher DHE-RSA-AES128-GCM-SHA256)
        by 0.0.0.0:465 (trex/5.7.12);
        Mon, 15 Apr 2019 07:10:25 -0400
From:   Ian Abbott <abbotti@mev.co.uk>
To:     devel@driverdev.osuosl.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Ian Abbott <abbotti@mev.co.uk>,
        H Hartley Sweeten <hsweeten@visionengravers.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH 0/2] staging: comedi: vmk80xx: Fix a couple of bugs
Date:   Mon, 15 Apr 2019 12:10:13 +0100
Message-Id: <20190415111015.8257-1-abbotti@mev.co.uk>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix a bug detected by syzbot and another bug that I noticed while
investigating the syzbot reported bug.

1) staging: comedi: vmk80xx: Fix use of uninitialized semaphore
2) staging: comedi: vmk80xx: Fix possible double-free of ->usb_rx_buf

 drivers/staging/comedi/drivers/vmk80xx.c | 8 +++-----
 1 file changed, 3 insertions(+), 5 deletions(-)

