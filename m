Return-Path: <SRS0=pFUE=23=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E1555C33C8C
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Jan 2020 14:42:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B1D8F20731
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Jan 2020 14:42:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="N/wR7iDJ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726646AbgAFOmd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 Jan 2020 09:42:33 -0500
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:54287 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726526AbgAFOmb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Jan 2020 09:42:31 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1578321750;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=uIPMdNoqYViorxZmJuj+bSCuJOUht09G1c6uvWR6420=;
        b=N/wR7iDJs301GHzn1lE/x6RFiY4RuJUcmSFMvsxsddL+U1bMNL6R5LEnfP+NbGmBnNQeA+
        PhECxnlyWoS1bp3vWn/V9tk7DjtDD8Akke3MMoXO01I2v6IDrf2i9xUjmYgD8JpEt9zVmm
        vYKUF81Ob7vXTFlJvPB8r/5EQ+cHZHo=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-25-r_3q3ln9MdiHYNSDoXNxXg-1; Mon, 06 Jan 2020 09:42:27 -0500
X-MC-Unique: r_3q3ln9MdiHYNSDoXNxXg-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 7A62018B9FD3;
        Mon,  6 Jan 2020 14:42:26 +0000 (UTC)
Received: from shalem.localdomain.com (ovpn-116-130.ams2.redhat.com [10.36.116.130])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 195C25C6DC;
        Mon,  6 Jan 2020 14:42:23 +0000 (UTC)
From:   Hans de Goede <hdegoede@redhat.com>
To:     Darren Hart <dvhart@infradead.org>,
        Andy Shevchenko <andy@infradead.org>
Cc:     Hans de Goede <hdegoede@redhat.com>,
        platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jason Anderson <jasona.594@gmail.com>
Subject: [PATCH 2/2] platform/x86: GPD pocket fan: Allow somewhat lower/higher temperature limits
Date:   Mon,  6 Jan 2020 15:42:19 +0100
Message-Id: <20200106144219.525215-2-hdegoede@redhat.com>
In-Reply-To: <20200106144219.525215-1-hdegoede@redhat.com>
References: <20200106144219.525215-1-hdegoede@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Allow the user to configure the fan to turn on / speed-up at lower
thresholds then before (20 degrees Celcius as minimum instead of 40) and
likewise also allow the user to delay the fan speeding-up till the
temperature hits 90 degrees Celcius (was 70).

Cc: Jason Anderson <jasona.594@gmail.com>
Reported-by: Jason Anderson <jasona.594@gmail.com>
Signed-off-by: Hans de Goede <hdegoede@redhat.com>
---
 drivers/platform/x86/gpd-pocket-fan.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/platform/x86/gpd-pocket-fan.c b/drivers/platform/x86=
/gpd-pocket-fan.c
index 1e6a42f2ea8a..0ffcbf9bc18e 100644
--- a/drivers/platform/x86/gpd-pocket-fan.c
+++ b/drivers/platform/x86/gpd-pocket-fan.c
@@ -126,7 +126,7 @@ static int gpd_pocket_fan_probe(struct platform_devic=
e *pdev)
 	int i;
=20
 	for (i =3D 0; i < ARRAY_SIZE(temp_limits); i++) {
-		if (temp_limits[i] < 40000 || temp_limits[i] > 70000) {
+		if (temp_limits[i] < 20000 || temp_limits[i] > 90000) {
 			dev_err(&pdev->dev, "Invalid temp-limit %d (must be between 40000 and=
 70000)\n",
 				temp_limits[i]);
 			temp_limits[0] =3D TEMP_LIMIT0_DEFAULT;
--=20
2.24.1

