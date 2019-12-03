Return-Path: <SRS0=Tfva=ZZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BC188C43215
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Dec 2019 23:00:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8318720656
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Dec 2019 23:00:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1575414041;
	bh=D0BI7uvsR2toHHS39zyx3t22aAkKT99mkx4mwPedCbo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=ExY9XGdgcC4lUQP2lI6iXIl8PiELfgjpHtDpkKx69haWkCplaozNlgqPWohnEx4SO
	 9bYr8CZra/ni3ft6qOusGw5VaxJBcjlt68HoTlGM4Gu+LVhJw+0aSD+LqK6eeg3cra
	 7olwzM38SqocctHsqbTiMcW8KNaNCYuuxqx2hRuo=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730534AbfLCW5U (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 3 Dec 2019 17:57:20 -0500
Received: from mail.kernel.org ([198.145.29.99]:52752 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730530AbfLCW5P (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Dec 2019 17:57:15 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3368A20656;
        Tue,  3 Dec 2019 22:57:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1575413834;
        bh=D0BI7uvsR2toHHS39zyx3t22aAkKT99mkx4mwPedCbo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=S7+1Vn+//yvD2n8heoUgVkU0Wg77mxxpH9yzs2EKz+eUMQxd/G+MmiRlfoLDb2Dv7
         gDVEXt9TkM7368KzceLt8ku7lGVFmp6ACBDFjUtfpjVeFEB3vR4J1X+NzqmXo86ozf
         X985RQypeITcwV2eyHLZMPwg2LIBjFBoJlPlNwgU=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Eugen Hristev <eugen.hristev@microchip.com>,
        Hans Verkuil <hverkuil-cisco@xs4all.nl>,
        Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        Lee Jones <lee.jones@linaro.org>
Subject: [PATCH 4.19 280/321] media: atmel: atmel-isc: fix asd memory allocation
Date:   Tue,  3 Dec 2019 23:35:46 +0100
Message-Id: <20191203223441.692023594@linuxfoundation.org>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <20191203223427.103571230@linuxfoundation.org>
References: <20191203223427.103571230@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Eugen Hristev <eugen.hristev@microchip.com>

commit 1e4e25c4959c10728fbfcc6a286f9503d32dfe02 upstream.

The subsystem will free the asd memory on notifier cleanup, if the asd is
added to the notifier.
However the memory is freed using kfree.
Thus, we cannot allocate the asd using devm_*
This can lead to crashes and problems.
To test this issue, just return an error at probe, but cleanup the
notifier beforehand.

Fixes: 106267444f ("[media] atmel-isc: add the Image Sensor Controller code")

Signed-off-by: Eugen Hristev <eugen.hristev@microchip.com>
Signed-off-by: Hans Verkuil <hverkuil-cisco@xs4all.nl>
Signed-off-by: Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
Signed-off-by: Lee Jones <lee.jones@linaro.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/media/platform/atmel/atmel-isc.c |    8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

--- a/drivers/media/platform/atmel/atmel-isc.c
+++ b/drivers/media/platform/atmel/atmel-isc.c
@@ -2062,8 +2062,11 @@ static int isc_parse_dt(struct device *d
 			break;
 		}
 
-		subdev_entity->asd = devm_kzalloc(dev,
-				     sizeof(*subdev_entity->asd), GFP_KERNEL);
+		/* asd will be freed by the subsystem once it's added to the
+		 * notifier list
+		 */
+		subdev_entity->asd = kzalloc(sizeof(*subdev_entity->asd),
+					     GFP_KERNEL);
 		if (!subdev_entity->asd) {
 			of_node_put(rem);
 			ret = -ENOMEM;
@@ -2209,6 +2212,7 @@ static int atmel_isc_probe(struct platfo
 						   &subdev_entity->notifier);
 		if (ret) {
 			dev_err(dev, "fail to register async notifier\n");
+			kfree(subdev_entity->asd);
 			goto cleanup_subdev;
 		}
 


