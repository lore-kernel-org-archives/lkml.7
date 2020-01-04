Return-Path: <SRS0=lTpO=2Z=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,HK_RANDOM_FROM,HK_RANDOM_REPLYTO,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 22111C2D0C2
	for <linux-kernel@archiver.kernel.org>; Sat,  4 Jan 2020 11:08:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D249C21734
	for <linux-kernel@archiver.kernel.org>; Sat,  4 Jan 2020 11:08:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=protonmail.com header.i=@protonmail.com header.b="yI/baj7+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725886AbgADLHS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 4 Jan 2020 06:07:18 -0500
Received: from mail-40135.protonmail.ch ([185.70.40.135]:41575 "EHLO
        mail-40135.protonmail.ch" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725796AbgADLHS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 4 Jan 2020 06:07:18 -0500
Date:   Sat, 04 Jan 2020 11:02:01 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=protonmail.com;
        s=default; t=1578135729;
        bh=9lo0cZrYUn87JmWrXa1EzvMoWSlzQ91H4SkQQpgpMfU=;
        h=Date:To:From:Cc:Reply-To:Subject:Feedback-ID:From;
        b=yI/baj7+QElBKg71HnKQ5mg8mMRbrg8J7KtnOltDb85qpQPkD58Ry2OREyCvQ4T3k
         HoS3g084E2h0k1gsBDmh8Me6ZFR/7kPrUjrCtZ7bbBrEn7qJvNda1senhCPm4EVb4e
         yw95/t55kxjlw6313COaB0Cx5orNfMA2x/m7P7dw=
To:     "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>
From:   atmgnd <atmgnd@protonmail.com>
Cc:     Alan Stern <stern@rowland.harvard.edu>,
        Randy Dunlap <rdunlap@infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        USB list <linux-usb@vger.kernel.org>
Reply-To: atmgnd <atmgnd@protonmail.com>
Subject: [PATCH] usb: missing parentheses in USE_NEW_SCHEME
Message-ID: <ht4mtag8ZP-HKEhD0KkJhcFnVlOFV8N8eNjJVRD9pDkkLUNhmEo8_cL_sl7xy9mdajdH-T8J3TFQsjvoYQT61NFjQXy469Ed_BbBw_x4S1E=@protonmail.com>
Feedback-ID: py-oVO8Vt0vS1FKaKugS2_MTpFC3lKhHMurhoXPAalWk9Eh40Mo1lZOn2CI1vswSSKJBwBLYgn_VKFu9qW3csg==:Ext:ProtonMail
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

accroding to bd0e6c9#diff-28615d62e1250eadc353d804f49bc6d6, will try old en=
umeration
scheme first for high speed devices. for example, when a high speed device =
pluged in,
line 2720 should expand to 0 at the first time. USE_NEW_SCHEME(0, 0 || 0 ||=
 1) =3D=3D=3D 0.
but it wrongly expand to 1(alway expand to 1 for high speed device), and ch=
ange
USE_NEW_SCHEME to USE_NEW_SCHEME((i) % 2 =3D=3D (int)(scheme)) may be bette=
r ?

Acked-by: Alan Stern <stern@rowland.harvard.edu>
Signed-off-by: Qi Zhou <atmgnd@outlook.com>
---
 drivers/usb/core/hub.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/usb/core/hub.c b/drivers/usb/core/hub.c
index f229ad6952c0..7d17deca7021 100644
--- a/drivers/usb/core/hub.c
+++ b/drivers/usb/core/hub.c
@@ -2692,7 +2692,7 @@ static unsigned hub_is_wusb(struct usb_hub *hub)
 #define SET_ADDRESS_TRIES=092
 #define GET_DESCRIPTOR_TRIES=092
 #define SET_CONFIG_TRIES=09(2 * (use_both_schemes + 1))
-#define USE_NEW_SCHEME(i, scheme)=09((i) / 2 =3D=3D (int)scheme)
+#define USE_NEW_SCHEME(i, scheme)=09((i) / 2 =3D=3D (int)(scheme))

 #define HUB_ROOT_RESET_TIME=0960=09/* times are in msec */
 #define HUB_SHORT_RESET_TIME=0910
--
2.17.1


