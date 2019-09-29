Return-Path: <SRS0=maO4=XY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1C02BC4360C
	for <linux-kernel@archiver.kernel.org>; Sun, 29 Sep 2019 13:58:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E303121882
	for <linux-kernel@archiver.kernel.org>; Sun, 29 Sep 2019 13:58:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1569765511;
	bh=+zBkcUkYtt3pOXMW0GqJj/HYBp0SzBX7UyGOcQgPo0c=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=fsQwJrmFNh+tnEArrr0Pd7MvGnaFkMX/L0O9eMLN69sn8D3ltcwJiRs/qiD2pxClR
	 dlIstNbogi4rvPlQo5qT7RsPWnClI8pWWcJMnU40QhHin5HKennRAn+6GAmB0AKG7w
	 x9bwLcWK15B0kIhUzb32umH+3RIeG9nKReWPZfmI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729502AbfI2N63 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 29 Sep 2019 09:58:29 -0400
Received: from mail.kernel.org ([198.145.29.99]:39122 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729484AbfI2N60 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 29 Sep 2019 09:58:26 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id DCB7F2082F;
        Sun, 29 Sep 2019 13:58:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1569765505;
        bh=+zBkcUkYtt3pOXMW0GqJj/HYBp0SzBX7UyGOcQgPo0c=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=RvSY1M+EesNBE/cAIIkCYgukdlDgWdFKvDurbGfYWJjkhroyg153048DN9/LT1T8T
         4LYSMGseLsRlJMHTwdKkja1o8cxfKd2aKv6fA8K09+TmyJSMsjRh+VcgZsQNC1ORFv
         qzUSPWtMcDjp3TjUpbMrDuFjxxVoi6omvCOjf1Tg=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Marco Felsch <m.felsch@pengutronix.de>,
        Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
Subject: [PATCH 4.19 24/63] media: tvp5150: fix switch exit in set control handler
Date:   Sun, 29 Sep 2019 15:53:57 +0200
Message-Id: <20190929135036.802291906@linuxfoundation.org>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20190929135031.382429403@linuxfoundation.org>
References: <20190929135031.382429403@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Marco Felsch <m.felsch@pengutronix.de>

commit 2d29bcc8c237874795175b2930fa9a45a115175a upstream.

The function only consists of a single switch case block without a
default case. Unsupported control requests are indicated by the -EINVAL
return code trough the last return statement at the end of the function. So
exiting just the switch case block returns the -EINVAL error code but the
hue control is supported and a zero should be returned instead.

Replace the break by a 'return 0' to fix this behaviour.

Fixes: d183e4efcae8 ("[media] v4l: tvp5150: Add missing break in set
control handler")

Signed-off-by: Marco Felsch <m.felsch@pengutronix.de>
Signed-off-by: Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/media/i2c/tvp5150.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/drivers/media/i2c/tvp5150.c
+++ b/drivers/media/i2c/tvp5150.c
@@ -828,7 +828,7 @@ static int tvp5150_s_ctrl(struct v4l2_ct
 		return 0;
 	case V4L2_CID_HUE:
 		tvp5150_write(sd, TVP5150_HUE_CTL, ctrl->val);
-		break;
+		return 0;
 	case V4L2_CID_TEST_PATTERN:
 		decoder->enable = ctrl->val ? false : true;
 		tvp5150_selmux(sd);


