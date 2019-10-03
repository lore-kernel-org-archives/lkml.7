Return-Path: <SRS0=6dNS=X4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0CF18C10F14
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Oct 2019 16:50:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CD0732086A
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Oct 2019 16:50:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1570121431;
	bh=VaJEsh5UkLakPlc6ctisliyWBlDu3TrANxzQLBFR4vY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=nGpSfbVh0/4p5IcqtCwo8Z+pN65M9E7/Z5+wn/NEoCBe7LKcrRejQ8MrDw9wFxz8i
	 u/NDQ1LvjBDQVx+vlZm1P59jrHmHJQT4yAgDa8YQREKRykLmjjmvkdfJ/Crwj5dmwT
	 nIx8mi493m/Y009cdTVYyypFJhRx3GB5AanArtpQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405924AbfJCQub (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 3 Oct 2019 12:50:31 -0400
Received: from mail.kernel.org ([198.145.29.99]:37518 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2392223AbfJCQuY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Oct 2019 12:50:24 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 583CF2070B;
        Thu,  3 Oct 2019 16:50:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1570121423;
        bh=VaJEsh5UkLakPlc6ctisliyWBlDu3TrANxzQLBFR4vY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=iVQkkdKxYieE5+kvW86IyVoh2m20c63Xo8OdxNO4gfE9dVZOSTxteaXikHZuRHZuJ
         d/zkIDRzgW3GQIWKaONqq4Kdo/hZvLzuCZ5DW34OZ9uKnygrHkN0ehxdCHeqPgOUIa
         /0ikgeCAkKiT9qafinEP6Eg6lMx5lt1zVC8J/HbI=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Vladimir Oltean <olteanv@gmail.com>,
        Mark Brown <broonie@kernel.org>
Subject: [PATCH 5.3 274/344] spi: spi-fsl-dspi: Exit the ISR with IRQ_NONE when its not ours
Date:   Thu,  3 Oct 2019 17:53:59 +0200
Message-Id: <20191003154607.205922020@linuxfoundation.org>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20191003154540.062170222@linuxfoundation.org>
References: <20191003154540.062170222@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Vladimir Oltean <olteanv@gmail.com>

commit d41f36a6464a85c06ad920703d878e4491d2c023 upstream.

The DSPI interrupt can be shared between two controllers at least on the
LX2160A. In that case, the driver for one controller might misbehave and
consume the other's interrupt. Fix this by actually checking if any of
the bits in the status register have been asserted.

Fixes: 13aed2392741 ("spi: spi-fsl-dspi: use IRQF_SHARED mode to request IRQ")
Signed-off-by: Vladimir Oltean <olteanv@gmail.com>
Link: https://lore.kernel.org/r/20190822212450.21420-2-olteanv@gmail.com
Signed-off-by: Mark Brown <broonie@kernel.org>
Cc: stable@vger.kernel.org
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/spi/spi-fsl-dspi.c |    4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

--- a/drivers/spi/spi-fsl-dspi.c
+++ b/drivers/spi/spi-fsl-dspi.c
@@ -886,9 +886,11 @@ static irqreturn_t dspi_interrupt(int ir
 					trans_mode);
 			}
 		}
+
+		return IRQ_HANDLED;
 	}
 
-	return IRQ_HANDLED;
+	return IRQ_NONE;
 }
 
 static const struct of_device_id fsl_dspi_dt_ids[] = {


