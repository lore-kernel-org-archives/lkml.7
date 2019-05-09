Return-Path: <SRS0=2Nly=TJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	T_DKIMWL_WL_HIGH,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AED7AC04AB1
	for <linux-kernel@archiver.kernel.org>; Thu,  9 May 2019 18:56:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 65D4C20578
	for <linux-kernel@archiver.kernel.org>; Thu,  9 May 2019 18:56:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1557428188;
	bh=GnB4mLSRRipVoJKGB3Hsztd53ht23uQOmOMWNCqXfsg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=ih6odcP5A8wpB5lm3IfgkaGj5a122JhR72gru8/bOin6WR5TDy/foCl5g92IE8q+3
	 31XQBzS8VrrgmB3hUbIWwJmdl3nxHJSGl3z7gSWTnv3Fn/fPiG6Hm+kjWeQAuw/PAh
	 wL14W2I9pedO2DosDB7LXVtYDyHNZkwoFSLJu5ag=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729135AbfEIS41 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 9 May 2019 14:56:27 -0400
Received: from mail.kernel.org ([198.145.29.99]:50022 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728919AbfEISzA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 May 2019 14:55:00 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6331F217D6;
        Thu,  9 May 2019 18:54:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1557428099;
        bh=GnB4mLSRRipVoJKGB3Hsztd53ht23uQOmOMWNCqXfsg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=PNSHXZ4n3k8iugyg9w+PJxBA2Se1Wv1DH3iJDKarlXx7Z2o7olxlI68O5mipNzB8v
         bG0ExrZ3L7pCF1lVOg72YIpCXoQrdGrfLfzGo8FzARYm/nM/x0GzL3shQC+cTAKR5a
         wSpJH+IUmvCvNeWxP5rpXJkQGmDzH/G/9qXqvArs=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Rui Miguel Silva <rui.silva@linaro.org>,
        Johan Hovold <johan@kernel.org>,
        Rui Miguel Silva <rmfrfs@gmail.com>
Subject: [PATCH 5.1 03/30] staging: greybus: power_supply: fix prop-descriptor request size
Date:   Thu,  9 May 2019 20:42:35 +0200
Message-Id: <20190509181251.309889371@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190509181250.417203112@linuxfoundation.org>
References: <20190509181250.417203112@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Johan Hovold <johan@kernel.org>

commit 47830c1127ef166af787caf2f871f23089610a7f upstream.

Since moving the message buffers off the stack, the dynamically
allocated get-prop-descriptor request buffer is incorrectly sized due to
using the pointer rather than request-struct size when creating the
operation.

Fortunately, the pointer size is always larger than this one-byte
request, but this could still cause trouble on the remote end due to the
unexpected message size.

Fixes: 9d15134d067e ("greybus: power_supply: rework get descriptors")
Cc: stable <stable@vger.kernel.org>     # 4.9
Cc: Rui Miguel Silva <rui.silva@linaro.org>
Signed-off-by: Johan Hovold <johan@kernel.org>
Reviewed-by: Rui Miguel Silva <rmfrfs@gmail.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/staging/greybus/power_supply.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/drivers/staging/greybus/power_supply.c
+++ b/drivers/staging/greybus/power_supply.c
@@ -520,7 +520,7 @@ static int gb_power_supply_prop_descript
 
 	op = gb_operation_create(connection,
 				 GB_POWER_SUPPLY_TYPE_GET_PROP_DESCRIPTORS,
-				 sizeof(req), sizeof(*resp) + props_count *
+				 sizeof(*req), sizeof(*resp) + props_count *
 				 sizeof(struct gb_power_supply_props_desc),
 				 GFP_KERNEL);
 	if (!op)


