Return-Path: <SRS0=2Nly=TJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	T_DKIMWL_WL_HIGH,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 69EE0C04AB1
	for <linux-kernel@archiver.kernel.org>; Thu,  9 May 2019 18:47:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 415332183E
	for <linux-kernel@archiver.kernel.org>; Thu,  9 May 2019 18:47:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1557427637;
	bh=AIFK3L+c1H4rIB8vBSH4Xb25UaW6efGxn2GKIhav6QI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=SyUK3tcFb241oXKEK2G83Yq4/y0TW6W3phx8vR3CngEWI9fqLwUEkT4RFn5C3yBy7
	 296svk+79JjXhGONTlQgkIcySfIF387GiRVSebN2GvC9Wq0MzI6KEQ6qBjaTzMi+30
	 Kwm6+Gecix0Zad3qTSsh0ULMPYe9xCUC0xg5ed5Y=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727780AbfEISrQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 9 May 2019 14:47:16 -0400
Received: from mail.kernel.org ([198.145.29.99]:39744 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727769AbfEISrO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 May 2019 14:47:14 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2F6BB2184B;
        Thu,  9 May 2019 18:47:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1557427633;
        bh=AIFK3L+c1H4rIB8vBSH4Xb25UaW6efGxn2GKIhav6QI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=xUATGymAjFGBDMd13SqDq97eWR20GrbbQRm5lCGV/CbqpDd7SP/MxJRyzXSXAuWW9
         WTE50eo0558mMHl1su3t/ac9/h6DCiIijvXkoOWU+JqQl+xLCWtr+0MHl4+XELmY3C
         5QYyd7XwgFWsgqbkxTWzqYIWxK7UZZJF6hp0oyJ4=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Rui Miguel Silva <rui.silva@linaro.org>,
        Johan Hovold <johan@kernel.org>,
        Rui Miguel Silva <rmfrfs@gmail.com>
Subject: [PATCH 4.19 05/66] staging: greybus: power_supply: fix prop-descriptor request size
Date:   Thu,  9 May 2019 20:41:40 +0200
Message-Id: <20190509181302.358228702@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190509181301.719249738@linuxfoundation.org>
References: <20190509181301.719249738@linuxfoundation.org>
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


