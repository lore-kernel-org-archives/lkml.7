Return-Path: <SRS0=/BGd=SD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9E7FDC43381
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Apr 2019 17:39:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 63BAA20830
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Apr 2019 17:39:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1554140353;
	bh=M71vB0l9o7LX7Z6dcp8VORJyBN83Q2lGNd0QkngRO5Q=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=RCzGEM/3wWuupueut32oZLyhJUJl0fn0S2+gFWwLjaYJXtWh0vYpJeKpJiImVB/Sq
	 WYYZgC0TrTt4eQ3JrHl+QKzKfCDXWpcrr8lSIOgqOnuWnqiZhGFzoaV8kRuckokHbm
	 Gkkm60NiK76Ca/K2K6yjPPJETTAKq3gGDKGaW1ck=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388410AbfDARjM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Apr 2019 13:39:12 -0400
Received: from mail.kernel.org ([198.145.29.99]:52826 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388189AbfDARjJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Apr 2019 13:39:09 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 61EE220830;
        Mon,  1 Apr 2019 17:39:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1554140348;
        bh=M71vB0l9o7LX7Z6dcp8VORJyBN83Q2lGNd0QkngRO5Q=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=G8/ZdkU9yhzgSsOylqkEdffsfgq+qgAJzT7vtZ98CZAtOAxdvea7J3/i3IUkVpb7f
         cDIzSM5r9GvRsDU8IjzSq93FAB7vfBXcguY+djFq2/565JLInePaYBWkw2tG13F/wL
         SWfFVx11eIrPfIvErOYcQYDd1yu5mUDbH7aD3oXM=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Axel Lin <axel.lin@ingics.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>
Subject: [PATCH 3.18 46/50] gpio: adnp: Fix testing wrong value in adnp_gpio_direction_input
Date:   Mon,  1 Apr 2019 19:03:29 +0200
Message-Id: <20190401170046.372325271@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190401170041.257273804@linuxfoundation.org>
References: <20190401170041.257273804@linuxfoundation.org>
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

3.18-stable review patch.  If anyone has any objections, please let me know.

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
@@ -137,8 +137,10 @@ static int adnp_gpio_direction_input(str
 	if (err < 0)
 		goto out;
 
-	if (err & BIT(pos))
-		err = -EACCES;
+	if (value & BIT(pos)) {
+		err = -EPERM;
+		goto out;
+	}
 
 	err = 0;
 


