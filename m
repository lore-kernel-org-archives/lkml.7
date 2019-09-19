Return-Path: <SRS0=X8En=XO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1067FC3A5A6
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Sep 2019 11:39:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C74BA21D6C
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Sep 2019 11:39:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=aurabindo.in header.i=@aurabindo.in header.b="VJjNIOqE"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390008AbfISLj6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 19 Sep 2019 07:39:58 -0400
Received: from mail1.protonmail.ch ([185.70.40.18]:36848 "EHLO
        mail1.protonmail.ch" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388068AbfISLj5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Sep 2019 07:39:57 -0400
Date:   Thu, 19 Sep 2019 11:39:50 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aurabindo.in;
        s=protonmail; t=1568893195;
        bh=P6KCUgwyggXktYCrQ9GHQnIhjLgRZDIyVhon5eQuAeg=;
        h=Date:To:From:Cc:Reply-To:Subject:Feedback-ID:From;
        b=VJjNIOqECPlxhzmMJZfJ5xOJyScZUcz43jWlbhS5blvtFKUWQlqinWgBFlNDfnEML
         Ch6HfZiEX2+oTG5E1SwlwCtewelbwzuzkYw9MCeuf664mJIzA95rNfJ9y8kQLCIazy
         iYrPzrYuF47KVxCRGjY+vv6G/bgF69VAgdV2wJZY=
To:     gregkh@linuxfoundation.org
From:   Aurabindo Jayamohanan <mail@aurabindo.in>
Cc:     devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org
Reply-To: Aurabindo Jayamohanan <mail@aurabindo.in>
Subject: [PATCH] staging: board: use appropriate macro to initialize struct
Message-ID: <20190919113945.13700-1-mail@aurabindo.in>
Feedback-ID: D1Wwva8zb0UdpJtanaReRLGO3iCsewpGmDn8ZDKmpao-Gnxd2qXPmwwrSQ99r5Q15lmK-D8x6vKzqhUKCgzweA==:Ext:ProtonMail
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Make code more readable by using macros defined for initializing
struct resource

Signed-off-by: Aurabindo Jayamohanan <mail@aurabindo.in>
---
 drivers/staging/board/armadillo800eva.c | 12 ++----------
 1 file changed, 2 insertions(+), 10 deletions(-)

diff --git a/drivers/staging/board/armadillo800eva.c b/drivers/staging/boar=
d/armadillo800eva.c
index 962cc0c79988..0225234dd7aa 100644
--- a/drivers/staging/board/armadillo800eva.c
+++ b/drivers/staging/board/armadillo800eva.c
@@ -50,16 +50,8 @@ static struct sh_mobile_lcdc_info lcdc0_info =3D {
 };
=20
 static struct resource lcdc0_resources[] =3D {
-=09[0] =3D {
-=09=09.name=09=3D "LCD0",
-=09=09.start=09=3D 0xfe940000,
-=09=09.end=09=3D 0xfe943fff,
-=09=09.flags=09=3D IORESOURCE_MEM,
-=09},
-=09[1] =3D {
-=09=09.start=09=3D 177 + 32,
-=09=09.flags=09=3D IORESOURCE_IRQ,
-=09},
+=09DEFINE_RES_MEM_NAMED(0xfe940000, 0x4000, "LCD0"),
+=09DEFINE_RES_IRQ(177 + 32),
 };
=20
 static struct platform_device lcdc0_device =3D {
--=20
2.23.0


