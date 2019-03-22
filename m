Return-Path: <SRS0=oArh=RZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CA15AC43381
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 12:31:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9037C2070D
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 12:31:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1553257885;
	bh=WZ7RTKOEGH+XUTkntjZgNZtyeSOp8PWhs34mipaEf4M=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=b3IOzCotxHfONxMIBtonZcZmo3iTdhanrhY1U+iF0sbDVmI3YQ4J/Ta4OtD8JsFKf
	 rmBdtOApoIWrtpfI036GD/P3q4r/sjAH6Y9mTd5t6yE/B6UIdaZ2rBkvk2craTTJ2k
	 g/2tL1JN1ux9VK5BjkoB+RuwomEE2kWLVgZ3nF4A=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390206AbfCVMbY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Mar 2019 08:31:24 -0400
Received: from mail.kernel.org ([198.145.29.99]:56248 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2390351AbfCVMRU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Mar 2019 08:17:20 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0B49D2195D;
        Fri, 22 Mar 2019 12:17:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1553257039;
        bh=WZ7RTKOEGH+XUTkntjZgNZtyeSOp8PWhs34mipaEf4M=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=E3eh+0ZldH/1AqP/HnlONFgwS3ahQMO8IpcXgUsJp/4HiiC/NFg3y2IStkGoKSjKc
         ulwsV/3eLpkulYj3KH4DSb8ZeFZfX2lGIeAeRdQRfzLpB7Vjg2pLdcP4ob3S8Zguvb
         ZwEw+xCPITaKM/F7vcgRylE0d83geYkpBnYi+Vns=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: [PATCH 5.0 113/238] nvmem: core: dont check the return value of notifier chain call
Date:   Fri, 22 Mar 2019 12:15:32 +0100
Message-Id: <20190322111305.189438111@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190322111258.383569278@linuxfoundation.org>
References: <20190322111258.383569278@linuxfoundation.org>
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

5.0-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Bartosz Golaszewski <bgolaszewski@baylibre.com>

commit f4853e1c321edb48af229ad5ac85076790d34968 upstream.

blocking_notifier_call_chain() returns the value returned by the last
registered callback. A positive return value doesn't indicate an error
and an nvmem device should correctly register irrespective of any
notifier callback failures. Drop the retval check.

Fixes: bee1138bea15 ("nvmem: add a notifier chain")
Cc: stable@vger.kernel.org
Signed-off-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>
Acked-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/nvmem/core.c |    4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

--- a/drivers/nvmem/core.c
+++ b/drivers/nvmem/core.c
@@ -686,9 +686,7 @@ struct nvmem_device *nvmem_register(cons
 	if (rval)
 		goto err_remove_cells;
 
-	rval = blocking_notifier_call_chain(&nvmem_notifier, NVMEM_ADD, nvmem);
-	if (rval)
-		goto err_remove_cells;
+	blocking_notifier_call_chain(&nvmem_notifier, NVMEM_ADD, nvmem);
 
 	return nvmem;
 


