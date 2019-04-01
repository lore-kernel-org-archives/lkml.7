Return-Path: <SRS0=/BGd=SD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 775B4C43381
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Apr 2019 17:28:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 46B8A20856
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Apr 2019 17:28:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1554139706;
	bh=lK9osWPx2dvLAmhpnDmSMvlaqEIJnSggg2rXZxdOOvQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=Mi4EmKnE3p2tEWTVtdbp+H2fJ86zS6SCWJJOSYhcD/mTiHhuouuquUENzq0lqSegz
	 fKFJRmY+3pRr/Qyea52Iatyi9hgNlRRh6yX2B5yUq2XZpaX4KrbBxxDFFieR09Iig5
	 MHrPGMBr5Eb/oCfByc3TGYIyY/wj8XY9zudypOnE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732783AbfDAR2Z (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Apr 2019 13:28:25 -0400
Received: from mail.kernel.org ([198.145.29.99]:34174 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732775AbfDAR2U (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Apr 2019 13:28:20 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 62ED320856;
        Mon,  1 Apr 2019 17:28:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1554139699;
        bh=lK9osWPx2dvLAmhpnDmSMvlaqEIJnSggg2rXZxdOOvQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=vrl8lwP/7i0nGkKyW1ta/9jK1pzRMfhQZRcHTClJfzkddtYwFYH2Xc1az7bxNh1lA
         W/5Qtpbll1CFsAp9/mukx8gndo/UCItrstPmF0GN10CQLZoqCstA5a5IlnWwLCtQTY
         Ny9C/7Sm159omOsDcoDMVWX4xEe724nOY71PZZXo=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Axel Lin <axel.lin@ingics.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>
Subject: [PATCH 4.9 45/56] gpio: adnp: Fix testing wrong value in adnp_gpio_direction_input
Date:   Mon,  1 Apr 2019 19:03:01 +0200
Message-Id: <20190401170106.373066782@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190401170103.398401360@linuxfoundation.org>
References: <20190401170103.398401360@linuxfoundation.org>
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

4.9-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Axel Lin <axel.lin@ingics.com>

commit c5bc6e526d3f217ed2cc3681d256dc4a2af4cc2b upstream.

Current code test wrong value so it does not verify if the written
data is correctly read back. Fix it.
Also make it return -EPERM if read value does not match written bit,
just like it done for adnp_gpio_direction_output().

Fixes: 5e969a401a01 ("gpio: Add Avionic Design N-bit GPIO expander support")
Cc: <stable@vger.kernel.org>
Signed-off-by: Axel Lin <axel.lin@ingics.com>
Reviewed-by: Thierry Reding <thierry.reding@gmail.com>
Signed-off-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/gpio/gpio-adnp.c |    6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

--- a/drivers/gpio/gpio-adnp.c
+++ b/drivers/gpio/gpio-adnp.c
@@ -132,8 +132,10 @@ static int adnp_gpio_direction_input(str
 	if (err < 0)
 		goto out;
 
-	if (err & BIT(pos))
-		err = -EACCES;
+	if (value & BIT(pos)) {
+		err = -EPERM;
+		goto out;
+	}
 
 	err = 0;
 


