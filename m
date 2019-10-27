Return-Path: <SRS0=Ymnc=YU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D5974CA9EAF
	for <linux-kernel@archiver.kernel.org>; Sun, 27 Oct 2019 21:03:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9ED52208C0
	for <linux-kernel@archiver.kernel.org>; Sun, 27 Oct 2019 21:03:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1572210235;
	bh=ssO/fgfxNpvpT7q/HqGLGpAcTTDrtqgKuanlAZwDpQA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=VIGCzIBNWN7eq+oHYo4NM7/QYqbxkCVILTwebfVm0Ugd9sPuwQ4BkoDMdTIHbU3mI
	 tv9EECBOVbrNXgD4vkycberBREIiO/o7j3fglAHn8DnEpKyUJ0nQ9BZEtUCCJkpM+h
	 WH33QqwnMyz4ZaOog1+kUnW1bUUHIB8MP5IB8dsY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728480AbfJ0VDy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 27 Oct 2019 17:03:54 -0400
Received: from mail.kernel.org ([198.145.29.99]:49288 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728460AbfJ0VDv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 27 Oct 2019 17:03:51 -0400
Received: from localhost (100.50.158.77.rev.sfr.net [77.158.50.100])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 80A3B2064A;
        Sun, 27 Oct 2019 21:03:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1572210231;
        bh=ssO/fgfxNpvpT7q/HqGLGpAcTTDrtqgKuanlAZwDpQA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=lfKoHQ0MCXJ5xtGEDW5kK/3ky7MN8zeMUF6aeHJbhfVU0zytnLYGQtiS8LuxnNrzs
         mYPnJayG1rN2QH2DFNS/PBOt+kSBQkixgzDs8FEFFnLBmv/81KZFSydliJWu8IaTZk
         pdolJU0GHHOBA5FI3/vbnMSgMi84nsmvB4S4BWqU=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
        Ulf Hansson <ulf.hansson@linaro.org>
Subject: [PATCH 4.4 36/41] memstick: jmb38x_ms: Fix an error handling path in jmb38x_ms_probe()
Date:   Sun, 27 Oct 2019 22:01:14 +0100
Message-Id: <20191027203131.812210192@linuxfoundation.org>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20191027203056.220821342@linuxfoundation.org>
References: <20191027203056.220821342@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Christophe JAILLET <christophe.jaillet@wanadoo.fr>

commit 28c9fac09ab0147158db0baeec630407a5e9b892 upstream.

If 'jmb38x_ms_count_slots()' returns 0, we must undo the previous
'pci_request_regions()' call.

Goto 'err_out_int' to fix it.

Fixes: 60fdd931d577 ("memstick: add support for JMicron jmb38x MemoryStick host controller")
Cc: stable@vger.kernel.org
Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/memstick/host/jmb38x_ms.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/drivers/memstick/host/jmb38x_ms.c
+++ b/drivers/memstick/host/jmb38x_ms.c
@@ -947,7 +947,7 @@ static int jmb38x_ms_probe(struct pci_de
 	if (!cnt) {
 		rc = -ENODEV;
 		pci_dev_busy = 1;
-		goto err_out;
+		goto err_out_int;
 	}
 
 	jm = kzalloc(sizeof(struct jmb38x_ms)


