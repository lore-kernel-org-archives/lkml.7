Return-Path: <SRS0=SHWF=W4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0696AC3A5A4
	for <linux-kernel@archiver.kernel.org>; Sun,  1 Sep 2019 19:49:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CB97F21897
	for <linux-kernel@archiver.kernel.org>; Sun,  1 Sep 2019 19:49:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="D7DAJ36E"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728979AbfIATtl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 1 Sep 2019 15:49:41 -0400
Received: from mail-lf1-f66.google.com ([209.85.167.66]:33925 "EHLO
        mail-lf1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728506AbfIATtk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 1 Sep 2019 15:49:40 -0400
Received: by mail-lf1-f66.google.com with SMTP id z21so8933526lfe.1
        for <linux-kernel@vger.kernel.org>; Sun, 01 Sep 2019 12:49:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=LwY5pl2zHPQpHCPl2EeMGMDJCM7CTQzDe7kSoMux6Pc=;
        b=D7DAJ36EbdYDxjCfKvTRc5FxFRgj+oFbazv3GDtCNFtYxKlbTFNHIXy1C53fDuR1sM
         qNZiJUn1bx0kB1nW5HFFnHIsVO5sGJ8p6WqE3pyfB3mT4rkUFH/PDik4Kt1tPxxEHf1l
         mVHY2tYxpiYPeki/NSg9s8/9l1gUSe8azuX7C4yQ4EuHrnNuxardH5aK/nVjkg2kdgd5
         88iPETTppWvFFJF8Ik+oiXY5MX2N8AFNL/y9qytW4aJ6S4pnTflLdjDXOssY1rGGO51z
         FycJqb3i5KfgMWsXO7nCiuLYSlgAquiw+uQ+EXpJojWDhTMj/eeb5ezX1YY+6NtoOOXg
         VLGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=LwY5pl2zHPQpHCPl2EeMGMDJCM7CTQzDe7kSoMux6Pc=;
        b=NWJ5Rfzz0bf86RvktZffETSqnCJj7UQIAnFkC4Ii15xwZj0CArA6OBOjmA/7K6lTdI
         lMLUcoWXbBCher4dOuKzIiTYiN9Jm8FJkBD03vFV2Q4igN1GtfavoKlZZtHfOHbC985q
         XOd+bNgRAjLAT9yesHyK1E1SCd3KCeDfFsDtZRZCDhLaD1WgvvhTF4sUMNA4PVpAh2pY
         J+5/K3b9eOhKUNGveaLzjOtQzeLNWK2bpcHa1idC3GKLnVPG92+s0yJcmw1RpABehgGK
         UzWJhee9fXkWYsf+wsLaedWEYKEaOkq9uzwxwxK18/VNeB+Q0dEqhuSurvY0GqbN8QRg
         3ugQ==
X-Gm-Message-State: APjAAAWPSJj4wwr3a5U4O4fVhaDsPHMi4VoljxAGCGCXOECcrFc+5Ryk
        3Sq1n05DSi3qrFGg5jSEDnI=
X-Google-Smtp-Source: APXvYqzQVFc8uN/bzBpPSo7IX2BqziQEK1EiWiUpg1HtX+tID+fZ0niyCHRn2TuTX/MtrIt2ft5Gew==
X-Received: by 2002:a19:4b4a:: with SMTP id y71mr10955740lfa.118.1567367378539;
        Sun, 01 Sep 2019 12:49:38 -0700 (PDT)
Received: from alpha ([178.71.207.205])
        by smtp.gmail.com with ESMTPSA id t1sm704861lji.101.2019.09.01.12.49.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 01 Sep 2019 12:49:38 -0700 (PDT)
Received: (nullmailer pid 16050 invoked by uid 1000);
        Sun, 01 Sep 2019 19:53:01 -0000
Date:   Sun, 1 Sep 2019 22:53:01 +0300
From:   Ivan Safonov <insafonov@gmail.com>
To:     Larry Finger <Larry.Finger@lwfinger.net>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Michael Straube <straube.linux@gmail.com>,
        Sanjana Sanikommu <sanjana99reddy99@gmail.com>,
        Vatsala Narang <vatsalanarang@gmail.com>,
        Colin Ian King <colin.king@canonical.com>,
        devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2] staging: r8188eu: use skb_put_data instead of
 skb_put/memcpy pair
Message-ID: <20190901195301.GA16043@alpha>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

skb_put_data is shorter and clear.

Signed-off-by: Ivan Safonov <insafonov@gmail.com>
---
Changes in v2:
  - add "staging: " in message subject;
  - all code lines now have no breaks in the middle of a sentence.

drivers/staging/rtl8188eu/core/rtw_recv.c        | 6 +-----
 drivers/staging/rtl8188eu/os_dep/usb_ops_linux.c | 3 +--
 2 files changed, 2 insertions(+), 7 deletions(-)

diff --git a/drivers/staging/rtl8188eu/core/rtw_recv.c b/drivers/staging/rtl8188eu/core/rtw_recv.c
index 620da6c003d8..d4278361e002 100644
--- a/drivers/staging/rtl8188eu/core/rtw_recv.c
+++ b/drivers/staging/rtl8188eu/core/rtw_recv.c
@@ -1373,11 +1373,7 @@ static struct recv_frame *recvframe_defrag(struct adapter *adapter,
 		/* append  to first fragment frame's tail (if privacy frame, pull the ICV) */
 		skb_trim(prframe->pkt, prframe->pkt->len - prframe->attrib.icv_len);
 
-		/* memcpy */
-		memcpy(skb_tail_pointer(prframe->pkt), pnfhdr->pkt->data,
-		       pnfhdr->pkt->len);
-
-		skb_put(prframe->pkt, pnfhdr->pkt->len);
+		skb_put_data(prframe->pkt, pnfhdr->pkt->data, pnfhdr->pkt->len);
 
 		prframe->attrib.icv_len = pnfhdr->attrib.icv_len;
 		plist = plist->next;
diff --git a/drivers/staging/rtl8188eu/os_dep/usb_ops_linux.c b/drivers/staging/rtl8188eu/os_dep/usb_ops_linux.c
index eedf2cd831d1..aaab0d577453 100644
--- a/drivers/staging/rtl8188eu/os_dep/usb_ops_linux.c
+++ b/drivers/staging/rtl8188eu/os_dep/usb_ops_linux.c
@@ -122,8 +122,7 @@ static int recvbuf2recvframe(struct adapter *adapt, struct sk_buff *pskb)
 			precvframe->pkt = pkt_copy;
 			skb_reserve(pkt_copy, 8 - ((size_t)(pkt_copy->data) & 7));/* force pkt_copy->data at 8-byte alignment address */
 			skb_reserve(pkt_copy, shift_sz);/* force ip_hdr at 8-byte alignment address according to shift_sz. */
-			memcpy(pkt_copy->data, (pbuf + pattrib->drvinfo_sz + RXDESC_SIZE), skb_len);
-			skb_put(precvframe->pkt, skb_len);
+			skb_put_data(pkt_copy, (pbuf + pattrib->drvinfo_sz + RXDESC_SIZE), skb_len);
 		} else {
 			DBG_88E("%s: alloc_skb fail , drop frag frame\n",
 				__func__);
-- 
2.21.0

