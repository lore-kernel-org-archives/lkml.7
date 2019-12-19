Return-Path: <SRS0=nnGO=2J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2BEE0C43603
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Dec 2019 19:01:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E7A7D206EC
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Dec 2019 19:01:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1576782072;
	bh=QXdiI/ulzS+Uh0MfYsWtw0lyrQyJtkOT3X4Om3aBep4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=OqYRRSJhLh7pGCtNbYo+edAAJEB4JT2nCdWKQ5M0veQ7ajv5v+WfQa6OP9OEcs6oV
	 Qd13jsr4RjnDx6a/ntVPfrUyDHD3u3AEcTLWQRWI4FjCthIkqzYLY8y5HRPVaKoiuw
	 UdGKDqJmVGaNlSsQHKG5pHQ44lkPbz9XrM4EcXms=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730123AbfLSTBK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 19 Dec 2019 14:01:10 -0500
Received: from mail.kernel.org ([198.145.29.99]:45678 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729870AbfLSSvZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Dec 2019 13:51:25 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 876962467F;
        Thu, 19 Dec 2019 18:51:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1576781484;
        bh=QXdiI/ulzS+Uh0MfYsWtw0lyrQyJtkOT3X4Om3aBep4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=bkNTku7Lyi9IIVonQRfKRnL9OgbWYP6x5bQXIlnVlmlcqqDYomm+wfSIZH2UdbOO9
         WofPNJa+dXxMSbFOU+I2Hs5ctRKcLTS2hJOaQlgmpwOUzhr4iuXgGZlV8OObLvF2IN
         kVH08buNGqejyqTCExiEaWSQsf0CAGlPJu9387so=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Chris Lew <clew@codeaurora.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>
Subject: [PATCH 4.14 19/36] rpmsg: glink: Set tail pointer to 0 at end of FIFO
Date:   Thu, 19 Dec 2019 19:34:36 +0100
Message-Id: <20191219182908.061383143@linuxfoundation.org>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20191219182848.708141124@linuxfoundation.org>
References: <20191219182848.708141124@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Chris Lew <clew@codeaurora.org>

commit 4623e8bf1de0b86e23a56cdb39a72f054e89c3bd upstream.

When wrapping around the FIFO, the remote expects the tail pointer to
be reset to 0 on the edge case where the tail equals the FIFO length.

Fixes: caf989c350e8 ("rpmsg: glink: Introduce glink smem based transport")
Cc: stable@vger.kernel.org
Signed-off-by: Chris Lew <clew@codeaurora.org>
Signed-off-by: Bjorn Andersson <bjorn.andersson@linaro.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/rpmsg/qcom_glink_smem.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/drivers/rpmsg/qcom_glink_smem.c
+++ b/drivers/rpmsg/qcom_glink_smem.c
@@ -119,7 +119,7 @@ static void glink_smem_rx_advance(struct
 	tail = le32_to_cpu(*pipe->tail);
 
 	tail += count;
-	if (tail > pipe->native.length)
+	if (tail >= pipe->native.length)
 		tail -= pipe->native.length;
 
 	*pipe->tail = cpu_to_le32(tail);


