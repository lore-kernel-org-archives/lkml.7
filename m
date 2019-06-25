Return-Path: <SRS0=/s9R=UY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8D0A0C48BD4
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Jun 2019 08:41:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 62439217D8
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Jun 2019 08:41:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nikanor-nu.20150623.gappssmtp.com header.i=@nikanor-nu.20150623.gappssmtp.com header.b="MO41+WE2"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730691AbfFYIlm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 25 Jun 2019 04:41:42 -0400
Received: from mail-lj1-f193.google.com ([209.85.208.193]:42319 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730832AbfFYIlk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Jun 2019 04:41:40 -0400
Received: by mail-lj1-f193.google.com with SMTP id t28so15359071lje.9
        for <linux-kernel@vger.kernel.org>; Tue, 25 Jun 2019 01:41:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=nikanor-nu.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Aj8XBum+Psok4AfC5NhqbglKzhmWo3QvztnHPGSovEY=;
        b=MO41+WE2fvaZeJ0tg0vTUdavI63QqHq6QZnU/mdkCevc8OiJD1qVoqVDWlHoCnm5oK
         irkXS02DUWyoRUMIKunYdsHTXUZylGnP7JzuFSgEh/B9k1Kkmiz1g+RGv3VI+xmusyS/
         OTbetwjDUo9T/1FuOU5zl5sH3pOUDrl07XLCPktl0K3qQWwWEBAwwfmAR2f9RzZwWZr5
         RGim5VFNGNdhKci3g+wTtXmvHgrJEOJTEt3owEXeu+K+UHI5eEoC04a+3UTNDgQgNKc3
         /ANVciUnRWPP2ws3qt0cGI2geQsdP5kGE3TB6UCioI4FDkdg5YEEb35Tv/pMeC4gX7UJ
         V93Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Aj8XBum+Psok4AfC5NhqbglKzhmWo3QvztnHPGSovEY=;
        b=uaoR0mz6Re6qiFwBl/yz0peThgOs9fx57pRCifz7zT+VKAPQ/v18GvHS5c0i97qzLU
         Oa9ee2/rUTur0XZe6D+Kv5DpUXX2CEeKJl1Nlk9uNn2VN/g+k5+RyV+d8q28Wh1Sbj9C
         hv8tT+Ajk5yd41toUnfIf+VcV2eZ3jwhTvu5N09qDivyZiNrNsl3l51758T5HZnhA1pq
         BQZDwSSA9jcZdLUnqFRqrSNY10UwJlau/SYEtc0iB2y9dLBY0DOaIW4CoYyVGpQIQxXI
         FjceKxKE6VIwaBeOfN8laZ0+HdjjMqriKRySwG0lGIPSO5+skISwzLDZOjEcFJSFetqq
         b8bg==
X-Gm-Message-State: APjAAAV/1va9QbnjPZ8gsSiepQrDxgMp+2W4DhNqJZ3KFyiqknsP7jmh
        yP0h1JcQzMIcpSolSdrC304LJw==
X-Google-Smtp-Source: APXvYqz6cmZc9JF/zjdV9CtaxqABGJCl+eIOCB5Uj7sH1pyMiOMJaI+bHvXRxgUdBQ2/vhHBXYPvsg==
X-Received: by 2002:a2e:5b5b:: with SMTP id p88mr73160093ljb.192.1561452098404;
        Tue, 25 Jun 2019 01:41:38 -0700 (PDT)
Received: from dev.nikanor.nu (78-72-133-4-no161.tbcn.telia.com. [78.72.133.4])
        by smtp.gmail.com with ESMTPSA id h78sm341564ljf.88.2019.06.25.01.41.36
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Tue, 25 Jun 2019 01:41:37 -0700 (PDT)
From:   =?UTF-8?q?Simon=20Sandstr=C3=B6m?= <simon@nikanor.nu>
To:     gregkh@linuxfoundation.org
Cc:     gneukum1@gmail.com, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org,
        =?UTF-8?q?Simon=20Sandstr=C3=B6m?= <simon@nikanor.nu>
Subject: [PATCH 3/4] staging: kpc2000: remove unnecessary parentheses in kpc2000_spi.c
Date:   Tue, 25 Jun 2019 10:41:29 +0200
Message-Id: <20190625084130.1107-4-simon@nikanor.nu>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190625084130.1107-1-simon@nikanor.nu>
References: <20190625084130.1107-1-simon@nikanor.nu>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fixes checkpatch "CHECK: Unnecessary parentheses around '...'".

Signed-off-by: Simon Sandström <simon@nikanor.nu>
---
 drivers/staging/kpc2000/kpc2000_spi.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/staging/kpc2000/kpc2000_spi.c b/drivers/staging/kpc2000/kpc2000_spi.c
index 98484fbb9d2e..68b049f9ad69 100644
--- a/drivers/staging/kpc2000/kpc2000_spi.c
+++ b/drivers/staging/kpc2000/kpc2000_spi.c
@@ -164,7 +164,7 @@ kp_spi_read_reg(struct kp_spi_controller_state *cs, int idx)
 	u64 val;
 
 	addr += idx;
-	if ((idx == KP_SPI_REG_CONFIG) && (cs->conf_cache >= 0)) {
+	if (idx == KP_SPI_REG_CONFIG && cs->conf_cache >= 0) {
 		return cs->conf_cache;
 	}
 	val = readq(addr);
-- 
2.20.1

