Return-Path: <SRS0=xaRW=WR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 98EF5C3A5A1
	for <linux-kernel@archiver.kernel.org>; Wed, 21 Aug 2019 14:51:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6ECE922D6D
	for <linux-kernel@archiver.kernel.org>; Wed, 21 Aug 2019 14:51:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=brennan.io header.i=stephen@brennan.io header.b="L/pE0eqs"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729534AbfHUOvH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 21 Aug 2019 10:51:07 -0400
Received: from sender4-of-o55.zoho.com ([136.143.188.55]:21541 "EHLO
        sender4-of-o55.zoho.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729263AbfHUOvG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Aug 2019 10:51:06 -0400
ARC-Seal: i=1; a=rsa-sha256; t=1566398151; cv=none; 
        d=zoho.com; s=zohoarc; 
        b=cL02qjJAOnYnebNhtmrDznfB43rtd01FCVvemwv7Vjj+jdizNgFXQzj0IOV78XT6pZX66jqHoDg2ifCeGM6my0alQela6aCKffnKVgkS11yq7nhYUIk7171kuNVvW3svTH2du91AOCAMbgj9+eGKQ3IjWunlisNA6egNqjtcmKI=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zoho.com; s=zohoarc; 
        t=1566398151; h=Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:To:ARC-Authentication-Results; 
        bh=2Keke6E9k3129XO4cirIcgVepYbFZOAHpypo//HJdzE=; 
        b=WWjLtI6Xna6xVpn1sQA8uRb3d2P2g6lHP2P+k4mS6W7jhgRef5A6DZPNm9xeiI9Vw/c+hc6QO5g9yl8rFL3RssU/FQ2ko71aubZW5wycAQtspdpIBLZrYJ7aom8cMi/DDNJbdbvhzB+RLsWK/XhT3Uku6IwuOGmFcP2Rey/PfoE=
ARC-Authentication-Results: i=1; mx.zoho.com;
        dkim=pass  header.i=brennan.io;
        spf=pass  smtp.mailfrom=stephen@brennan.io;
        dmarc=pass header.from=<stephen@brennan.io> header.from=<stephen@brennan.io>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1566398151;
        s=selector01; d=brennan.io; i=stephen@brennan.io;
        h=From:To:Cc:Message-ID:Subject:Date:In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:Content-Type;
        l=4116; bh=2Keke6E9k3129XO4cirIcgVepYbFZOAHpypo//HJdzE=;
        b=L/pE0eqscmV1vgablx2KFPit+NjorQJmvkAxAmZcMCwa133qHgm3B/QrSdI1PdAC
        YnWL9MgYwWYAPwnZMxyGa/j1oppRGoZ2jXIuCekh4s246vyetFAc0WqUicxImK+pL/N
        voiI9UxAE9oSdEw1BOD3i5FYn2ffCQqYbg/2EGEw=
Received: from localhost (67.218.105.90 [67.218.105.90]) by mx.zohomail.com
        with SMTPS id 1566398149523279.5236183715351; Wed, 21 Aug 2019 07:35:49 -0700 (PDT)
From:   Stephen Brennan <stephen@brennan.io>
To:     "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>
Cc:     Stephen Brennan <stephen@brennan.io>, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org, "Tobin C . Harding" <me@tobin.cc>
Message-ID: <20190821143540.4501-3-stephen@brennan.io>
Subject: [PATCH v2 2/3] staging: rtl8192u: fix macro alignment in ieee80211
Date:   Wed, 21 Aug 2019 07:35:39 -0700
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20190821143540.4501-1-stephen@brennan.io>
References: <20190821143540.4501-1-stephen@brennan.io>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-ZohoMailClient: External
Content-Type: text/plain; charset=utf8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Several macros display unaligned, due to mixes of tabs and spaces. These
can be fixed by making spacing consistent, do this.

Signed-off-by: Stephen Brennan <stephen@brennan.io>
---
 .../staging/rtl8192u/ieee80211/ieee80211.h    | 35 ++++++++++---------
 .../staging/rtl8192u/ieee80211/rtl819x_HT.h   |  8 ++---
 2 files changed, 22 insertions(+), 21 deletions(-)

diff --git a/drivers/staging/rtl8192u/ieee80211/ieee80211.h b/drivers/stagi=
ng/rtl8192u/ieee80211/ieee80211.h
index 129dcb5a0f2e..6b7828a9e71d 100644
--- a/drivers/staging/rtl8192u/ieee80211/ieee80211.h
+++ b/drivers/staging/rtl8192u/ieee80211/ieee80211.h
@@ -169,9 +169,9 @@ struct cb_desc {
 #define MGN_MCS14               0x8e
 #define MGN_MCS15               0x8f
=20
-#define aSifsTime ((priv->ieee80211->current_network.mode =3D=3D IEEE_A ||=
 \
+#define aSifsTime ((priv->ieee80211->current_network.mode =3D=3D IEEE_A ||=
     \
 =09=09    priv->ieee80211->current_network.mode =3D=3D IEEE_N_24G || \
-=09=09    priv->ieee80211->current_network.mode =3D=3D IEEE_N_5G) ? \
+=09=09    priv->ieee80211->current_network.mode =3D=3D IEEE_N_5G) ?  \
 =09=09   16 : 10)
=20
 #define MGMT_QUEUE_NUM 5
@@ -387,7 +387,7 @@ struct ieee_param {
 #define IEEE80211_STYPE_ACK=09=090x00D0
 #define IEEE80211_STYPE_CFEND=09=090x00E0
 #define IEEE80211_STYPE_CFENDACK=090x00F0
-#define IEEE80211_STYPE_BLOCKACK   0x0094
+#define IEEE80211_STYPE_BLOCKACK=090x0094
=20
 /* data */
 #define IEEE80211_STYPE_DATA=09=090x0000
@@ -452,18 +452,19 @@ do { if (ieee80211_debug_level & (level)) \
   printk(KERN_DEBUG "ieee80211: " fmt, ## args); } while (0)
 //wb added to debug out data buf
 //if you want print DATA buffer related BA, please set ieee80211_debug_lev=
el to DATA|BA
-#define IEEE80211_DEBUG_DATA(level, data, datalen)=09\
-=09do { if ((ieee80211_debug_level & (level)) =3D=3D (level))=09\
-=09=09{=09\
-=09=09=09int i;=09=09=09=09=09\
-=09=09=09u8 *pdata =3D (u8 *) data;=09=09=09\
-=09=09=09printk(KERN_DEBUG "ieee80211: %s()\n", __func__);=09\
-=09=09=09for (i =3D 0; i < (int)(datalen); i++) {=09=09\
-=09=09=09=09printk("%2x ", pdata[i]);=09=09\
-=09=09=09=09if ((i + 1) % 16 =3D=3D 0) printk("\n");=09\
-=09=09=09}=09=09=09=09\
-=09=09=09printk("\n");=09=09=09\
-=09=09}=09=09=09=09=09\
+#define IEEE80211_DEBUG_DATA(level, data, datalen)                        =
     \
+=09do { if ((ieee80211_debug_level & (level)) =3D=3D (level))             =
    \
+=09=09{                                                              \
+=09=09=09int i;                                                 \
+=09=09=09u8 *pdata =3D (u8 *) data;                               \
+=09=09=09printk(KERN_DEBUG "ieee80211: %s()\n", __func__);      \
+=09=09=09for (i =3D 0; i < (int)(datalen); i++) {                 \
+=09=09=09=09printk("%2x ", pdata[i]);                      \
+=09=09=09=09if ((i + 1) % 16 =3D=3D 0)                         \
+=09=09=09=09=09printk("\n");                          \
+=09=09=09}                                                      \
+=09=09=09printk("\n");                                          \
+=09=09}                                                              \
 =09} while (0)
 #else
 #define IEEE80211_DEBUG (level, fmt, args...) do {} while (0)
@@ -2014,8 +2015,8 @@ struct ieee80211_device {
 #define IEEE_A            (1<<0)
 #define IEEE_B            (1<<1)
 #define IEEE_G            (1<<2)
-#define IEEE_N_24G=09=09  (1<<4)
-#define=09IEEE_N_5G=09=09  (1<<5)
+#define IEEE_N_24G        (1<<4)
+#define IEEE_N_5G         (1<<5)
 #define IEEE_MODE_MASK    (IEEE_A | IEEE_B | IEEE_G)
=20
 /* Generate a 802.11 header */
diff --git a/drivers/staging/rtl8192u/ieee80211/rtl819x_HT.h b/drivers/stag=
ing/rtl8192u/ieee80211/rtl819x_HT.h
index 3fca0d3a1d05..586d93720e37 100644
--- a/drivers/staging/rtl8192u/ieee80211/rtl819x_HT.h
+++ b/drivers/staging/rtl8192u/ieee80211/rtl819x_HT.h
@@ -253,10 +253,10 @@ extern u8 MCS_FILTER_1SS[16];
 /* 2007/07/12 MH We only define legacy and HT wireless mode now. */
 #define=09LEGACY_WIRELESS_MODE=09IEEE_MODE_MASK
=20
-#define CURRENT_RATE(WirelessMode, LegacyRate, HTRate)=09\
-=09=09=09=09=09((WirelessMode & (LEGACY_WIRELESS_MODE)) !=3D 0) ?\
-=09=09=09=09=09=09(LegacyRate) :\
-=09=09=09=09=09=09(PICK_RATE(LegacyRate, HTRate))
+#define CURRENT_RATE(WirelessMode, LegacyRate, HTRate)           \
+=09=09((WirelessMode & (LEGACY_WIRELESS_MODE)) !=3D 0) ? \
+=09=09=09(LegacyRate) :                           \
+=09=09=09(PICK_RATE(LegacyRate, HTRate))
=20
 // MCS Bw 40 {1~7, 12~15,32}
 #define=09RATE_ADPT_1SS_MASK=09=090xFF
--=20
2.22.0



