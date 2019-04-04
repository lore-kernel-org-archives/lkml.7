Return-Path: <SRS0=oHH8=SG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D1998C4360F
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Apr 2019 06:53:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A2CEF206DF
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Apr 2019 06:53:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1554360836;
	bh=NJ/IiNqbo/rtg/7ylurc+ZOSCAUVh/fv0f37NHxxez0=;
	h=From:To:Cc:Subject:Date:List-ID:From;
	b=eJuVpLq/1JO6u+dvlF8I0ixUivQC++InNf9xVtj4rbwHxynwFxZB9ayMbZHBPzmOk
	 9eLWdhBAX0JOiwcnQcCgfGrCh1mebQWcAXBk3UjaTC/AjEj5/vlrfLsArGpQMUUYqF
	 8FwMtDJ4mIM9rno/gaEhb/ZWA6LhQRJlGlOlWMSU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727080AbfDDGxz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 4 Apr 2019 02:53:55 -0400
Received: from mail-lj1-f194.google.com ([209.85.208.194]:44379 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726031AbfDDGxx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Apr 2019 02:53:53 -0400
Received: by mail-lj1-f194.google.com with SMTP id h16so1031771ljg.11;
        Wed, 03 Apr 2019 23:53:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=F1EyUqvW99EmCbH6MSECgtJTS+0K2xvbEd3iSF9+PkM=;
        b=pgH0NGqDPkO4/SuE0nwajMDOAPW+VlPxlvLBQAOT+TUEbX4uAorkuxckHu9srno3Ub
         HEY+PLEJAh8ZhQNkTqXJIvUByVQoHtdvOfSkpCIviwTCerh9PB7w14landHsOMjr5PeK
         gmlQ/wgSms0H4y9x9tDXIF5viA+nRgO/lElVNfEaDRGXPmaQisU1J5gO0w5wCFsOCaBu
         RT+kKXZmk5K6gZUpQOIGxPMAwtqClg2shBe8RTiA0QyZTICnRKMR+U3gFE8AHZK3ihML
         PXT5XKBx3s7Rj/OVTx+v48U2W69oaowgNwa693D7dRyDmxTrK3Fv87ROEe4w5ivWzahX
         cHNA==
X-Gm-Message-State: APjAAAWh9kT0O5yi4OG3JPlxGZKMgY9YBK5VgTawFt1m2H4FQBJcKSNo
        /bhgc8qWfQDlJAqRAS0KUiA=
X-Google-Smtp-Source: APXvYqz4c0KO4doxwHjk7GP0IbJAbO74FdCmF+H0L/A1zpZyLSPVW1eXXuu3fv2yF0Zjx8H8dLuv4Q==
X-Received: by 2002:a2e:2a03:: with SMTP id q3mr2301729ljq.56.1554360831020;
        Wed, 03 Apr 2019 23:53:51 -0700 (PDT)
Received: from xi.terra (c-74bee655.07-184-6d6c6d4.bbcust.telenor.se. [85.230.190.116])
        by smtp.gmail.com with ESMTPSA id a7sm3393407lfo.8.2019.04.03.23.53.50
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 03 Apr 2019 23:53:50 -0700 (PDT)
Received: from johan by xi.terra with local (Exim 4.91)
        (envelope-from <johan@xi.terra>)
        id 1hBwGM-0003Eo-Ru; Thu, 04 Apr 2019 08:54:14 +0200
From:   Johan Hovold <johan@kernel.org>
To:     Rui Miguel Silva <rmfrfs@gmail.com>
Cc:     Johan Hovold <johan@kernel.org>, Alex Elder <elder@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        greybus-dev@lists.linaro.org, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org,
        "Gustavo A. R. Silva" <gustavo@embeddedor.com>,
        stable <stable@vger.kernel.org>,
        Rui Miguel Silva <rui.silva@linaro.org>
Subject: [PATCH] staging: greybus: power_supply: fix prop-descriptor request size
Date:   Thu,  4 Apr 2019 08:53:30 +0200
Message-Id: <20190404065330.12382-1-johan@kernel.org>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

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
---
 drivers/staging/greybus/power_supply.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/staging/greybus/power_supply.c b/drivers/staging/greybus/power_supply.c
index 0529e5628c24..ae5c0285a942 100644
--- a/drivers/staging/greybus/power_supply.c
+++ b/drivers/staging/greybus/power_supply.c
@@ -520,7 +520,7 @@ static int gb_power_supply_prop_descriptors_get(struct gb_power_supply *gbpsy)
 
 	op = gb_operation_create(connection,
 				 GB_POWER_SUPPLY_TYPE_GET_PROP_DESCRIPTORS,
-				 sizeof(req), sizeof(*resp) + props_count *
+				 sizeof(*req), sizeof(*resp) + props_count *
 				 sizeof(struct gb_power_supply_props_desc),
 				 GFP_KERNEL);
 	if (!op)
-- 
2.21.0

