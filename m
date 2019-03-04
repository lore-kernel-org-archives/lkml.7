Return-Path: <SRS0=91bA=RH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ECA45C43381
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Mar 2019 08:32:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BD3A321019
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Mar 2019 08:32:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1551688346;
	bh=YXzc1+6l7GDWK6Z1ZgbQ4BEXOl8KhCGva0BNjoMABUw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=S7/gfSK4SQQVFEF5rJuuWka+9lUa5bk03DwgkD+ZoGJoN4XRUZv+1fLg6hOTBcuj3
	 7AUbZQtIgMlBfkjIswjHa7ArfWtmNJmB5ac3tMZ9vHEn5ZhLC9ssD5of9ca3w90wXw
	 UeDBUKTvn98pPwHceZkZLrYZWvw6do2lUgZhjdTM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728076AbfCDIcZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 4 Mar 2019 03:32:25 -0500
Received: from mail.kernel.org ([198.145.29.99]:35684 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727709AbfCDIcV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Mar 2019 03:32:21 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2DDAF208E4;
        Mon,  4 Mar 2019 08:32:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1551688340;
        bh=YXzc1+6l7GDWK6Z1ZgbQ4BEXOl8KhCGva0BNjoMABUw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=2FXnNuUQP3qNCMBabArDZAaEezepO6/3K6Z3ej6nQAk+bm7LHU5fixM3Wz9EWiW3N
         HLjtw2PUBOiWQgfdlxj31u3L6ReQoNdxDhLzrzaJYu6nL0yjzjrJkBuudGHME1YX05
         +3OrouhFwLt1IjiBKaonI4b8xCi+E447bx8zIEgc=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Yizhuo <yzhai003@ucr.edu>,
        Mark Brown <broonie@kernel.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.20 07/88] ASoC: Variable "val" in function rt274_i2c_probe() could be uninitialized
Date:   Mon,  4 Mar 2019 09:21:50 +0100
Message-Id: <20190304081630.861396149@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190304081630.610632175@linuxfoundation.org>
References: <20190304081630.610632175@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.20-stable review patch.  If anyone has any objections, please let me know.

------------------

[ Upstream commit 8c3590de0a378c2449fc1aec127cc693632458e4 ]

Inside function rt274_i2c_probe(), if regmap_read() function
returns -EINVAL, then local variable "val" leaves uninitialized
but used in if statement. This is potentially unsafe.

Signed-off-by: Yizhuo <yzhai003@ucr.edu>
Signed-off-by: Mark Brown <broonie@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 sound/soc/codecs/rt274.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/sound/soc/codecs/rt274.c b/sound/soc/codecs/rt274.c
index 0ef966d56bac3..e2855ab9a2c6b 100644
--- a/sound/soc/codecs/rt274.c
+++ b/sound/soc/codecs/rt274.c
@@ -1128,8 +1128,11 @@ static int rt274_i2c_probe(struct i2c_client *i2c,
 		return ret;
 	}
 
-	regmap_read(rt274->regmap,
+	ret = regmap_read(rt274->regmap,
 		RT274_GET_PARAM(AC_NODE_ROOT, AC_PAR_VENDOR_ID), &val);
+	if (ret)
+		return ret;
+
 	if (val != RT274_VENDOR_ID) {
 		dev_err(&i2c->dev,
 			"Device with ID register %#x is not rt274\n", val);
-- 
2.19.1



