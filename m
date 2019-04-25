Return-Path: <SRS0=Q+aa=S3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3C7D6C43218
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Apr 2019 18:33:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A188720717
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Apr 2019 18:33:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="O/Ee76pu"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730593AbfDYSdw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Apr 2019 14:33:52 -0400
Received: from mail-pl1-f195.google.com ([209.85.214.195]:38712 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726020AbfDYSdw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Apr 2019 14:33:52 -0400
Received: by mail-pl1-f195.google.com with SMTP id f36so213363plb.5
        for <linux-kernel@vger.kernel.org>; Thu, 25 Apr 2019 11:33:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=G2YgNacUSGvQfoenjr0MC31lYNzLBltR3PjfCg1bekM=;
        b=O/Ee76pu85m95BmZnljEaTwIAwA67u6Ib542P2D/ZwM3axm9LJ+r/bOkXxqnhh8RvM
         /zfr7IRmtg06BxQqqAzRB8nKkVA8cjQOrMF59IVbawKp1hyETCLOPNOAWMc1V38BUWOj
         zQHFJQlCcSXERN90RJBA3+YbJUYXPIRP01l3YGsj1phv57M0yDEOuLTv92Tb07f70dVJ
         iWK0zBjYVB79cbOh33v3OmYxIR0AUKbVjjED/Cff77lo0ZhQlyzgFu+ZvJW01Q636CTu
         0Lr/KO+/sV1v6qd7HhpNCjqKu1jZGg1FdBPgkiKt+UkKA34mB8yKxnc6UzLGJrp15V+y
         om5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=G2YgNacUSGvQfoenjr0MC31lYNzLBltR3PjfCg1bekM=;
        b=hI2OsknQSKOlqrnuJlBSCYCdDimW1KQBUs98iwgdb9h/O+ZP31Xwc20HNkb1q3hivk
         JL/MPBVv2BkVQ1UQhGrucv+y0FKNo1da/rsPpDBoYEY2EHgit6IaMXsyiqSAe73T/8k/
         1izBB8b6FWzgErAKIoUKZr9y9S+vpSs8uIHvbD4T5D0IpjIzQqVwY7APGKlGChKkCh0q
         iBobVj0uDlbtI4NDmcu3jABlC3ynQza8YAcGS4k3H+UbP9wtSkdsfj6e3Fv+iHRnvb2w
         tmWw4LHpXXq0GFT42g+4hC8UilCLvmBDTsFphhJtIOPsXZu5SJACLVDbRvcdivblbYeI
         4xxg==
X-Gm-Message-State: APjAAAVkNaApJ9TbibcuAaa7O8tjxAyX06dtZz7I1l5/H662CMBDe9E7
        /HnAPaZKhCky817ttuInzR1icZ+i
X-Google-Smtp-Source: APXvYqzCdOT08TTdIeiWoACwbRDraP8CmvTVdTDjX6GdUrKed8dCrvA5G61nMB4PIOASPzyku8A75g==
X-Received: by 2002:a17:902:2d04:: with SMTP id o4mr41482963plb.88.1556217231526;
        Thu, 25 Apr 2019 11:33:51 -0700 (PDT)
Received: from localhost.localdomain ([103.87.57.142])
        by smtp.gmail.com with ESMTPSA id b1sm26050186pgq.15.2019.04.25.11.33.48
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 25 Apr 2019 11:33:51 -0700 (PDT)
From:   Vatsala Narang <vatsalanarang@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org,
        Julia.Lawall@lip6.fr, Vatsala Narang <vatsalanarang@gmail.com>
Subject: [PATCH] staging: rtl8192u: ieee80211: Replace bit shifting with BIT macro
Date:   Fri, 26 Apr 2019 00:03:20 +0530
Message-Id: <20190425183320.23962-1-vatsalanarang@gmail.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Challenge suggested by coccinelle.

Replace bit shifting on 1 with the BIT(x) macro.
Coccinelle script:

@@
expression c;
@@

-(1 << c)
+BIT(c)

Signed-off-by: Vatsala Narang <vatsalanarang@gmail.com>
---
 drivers/staging/rtl8192u/ieee80211/ieee80211_wx.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/staging/rtl8192u/ieee80211/ieee80211_wx.c b/drivers/staging/rtl8192u/ieee80211/ieee80211_wx.c
index fa59c712c74b..c44662f03a6b 100644
--- a/drivers/staging/rtl8192u/ieee80211/ieee80211_wx.c
+++ b/drivers/staging/rtl8192u/ieee80211/ieee80211_wx.c
@@ -86,7 +86,7 @@ static inline char *rtl819x_translate_scan(struct ieee80211_device *ieee,
 	/* Add the protocol name */
 	iwe.cmd = SIOCGIWNAME;
 	for(i=0; i<ARRAY_SIZE(ieee80211_modes); i++) {
-		if(network->mode&(1<<i)) {
+		if(network->mode&BIT(i)) {
 			sprintf(pname,ieee80211_modes[i].mode_string,ieee80211_modes[i].mode_size);
 			pname +=ieee80211_modes[i].mode_size;
 		}
@@ -394,7 +394,7 @@ int ieee80211_wx_set_encode(struct ieee80211_device *ieee,
 		sec.key_sizes[key] = len;
 		(*crypt)->ops->set_key(sec.keys[key], len, NULL,
 				       (*crypt)->priv);
-		sec.flags |= (1 << key);
+		sec.flags |= BIT(key);
 		/* This ensures a key will be activated if no key is
 		 * explicitely set */
 		if (key == sec.active_key)
@@ -415,7 +415,7 @@ int ieee80211_wx_set_encode(struct ieee80211_device *ieee,
 			(*crypt)->ops->set_key(sec.keys[key], 13, NULL,
 					       (*crypt)->priv);
 			sec.key_sizes[key] = 13;
-			sec.flags |= (1 << key);
+			sec.flags |= BIT(key);
 		}
 
 		/* No key data - just set the default TX key index */
@@ -636,7 +636,7 @@ int ieee80211_wx_set_encode_ext(struct ieee80211_device *ieee,
 	if (ext->alg != IW_ENCODE_ALG_NONE) {
 		//memcpy(sec.keys[idx], ext->key, ext->key_len);
 		sec.key_sizes[idx] = ext->key_len;
-		sec.flags |= (1 << idx);
+		sec.flags |= BIT(idx);
 		if (ext->alg == IW_ENCODE_ALG_WEP) {
 		      //  sec.encode_alg[idx] = SEC_ALG_WEP;
 			sec.flags |= SEC_LEVEL;
-- 
2.17.1

