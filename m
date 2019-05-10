Return-Path: <SRS0=sufd=TK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BEEBEC04AB1
	for <linux-kernel@archiver.kernel.org>; Fri, 10 May 2019 02:39:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8CE772183F
	for <linux-kernel@archiver.kernel.org>; Fri, 10 May 2019 02:39:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KEl11AVN"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727006AbfEJCjH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 9 May 2019 22:39:07 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:36373 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726806AbfEJCjH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 May 2019 22:39:07 -0400
Received: by mail-pf1-f196.google.com with SMTP id v80so2360320pfa.3
        for <linux-kernel@vger.kernel.org>; Thu, 09 May 2019 19:39:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=KlxDSnGXbNm8XMD67N/PB5Gqb9omE7jD432RyvZTRH4=;
        b=KEl11AVN2ASiGMBKu3GkFSZiIJTZ9Rsjtj0RB4lMikrNKk2swkczxZ7f+i3+B/9lUh
         lcK0THIBUlX47t2ho/ID8CyRYxqhSK/j+ehM6YOPV1b1ZZ95Z8CJMC1Vki1tICIu+nSt
         7O4Lc9cHYCanEluHk7Y3C3YG0Crp6peEY58ozVaqaxXLaCChFW2Qu9yPCZwZJrjBOSTc
         QQIquAIa4ND6ApfcHVAR1/XiL+ezdgAaGZsOdrG7xGHmAYRkQZQtUOalsE+n5fkLRhp3
         1Vq1YplkcHxeBTWJQcFG1Lfvm34gpQ8JH+lqEqryUxI8rDLhbhDvdrsnKKXiGMyNVjGI
         hSaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=KlxDSnGXbNm8XMD67N/PB5Gqb9omE7jD432RyvZTRH4=;
        b=eZf2hA63FSbzbNC2z1QA8gs5dQ58yWYhYYVCgFETlpGE0gn3f46KHOirrY4t75JlJ+
         3CQsdcF2RsaMGZx5LnM4Cv44iW+QUbVwCAdYuNiSi9HhSwHIizOZe1IT8BSJZ9dOP86h
         d3pzELnWcXPNKm6XVTaUDHdhWFWLafYZCy2kNUy+2G6BoYnShP3XDFl7GNleCIHXMitm
         stg11frfFc8r7h8ro2tOiv65aRCt5m440OWlegCE8eeQ+otnCPB6o2ZbxMegrZw7Xk41
         jYoxX86dp6OIG7dYcd0oGD8r8cMqsuaclo8S8ENZ3VOX87/IGWrx+TW54AfMaHQiWKE1
         s+0Q==
X-Gm-Message-State: APjAAAWQBhToA4fpNSz3qecvPazh2/goOWPT/60wfWjjvO2/7RtyBPim
        kVT6bHdiQysx1ANkMYfBFn1eSCSh
X-Google-Smtp-Source: APXvYqxME2jV6vhscQVnlbFqj2TvjyVBUlJwnAwJdiMMZPY6LJbG7DUrXD15+4nDQFO7qZH4PGPlxw==
X-Received: by 2002:a63:c509:: with SMTP id f9mr10477371pgd.143.1557455946352;
        Thu, 09 May 2019 19:39:06 -0700 (PDT)
Received: from hari-Inspiron-1545 ([183.83.92.73])
        by smtp.gmail.com with ESMTPSA id c14sm4041719pgl.43.2019.05.09.19.39.03
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 09 May 2019 19:39:05 -0700 (PDT)
Date:   Fri, 10 May 2019 08:09:00 +0530
From:   Hariprasad Kelam <hariprasad.kelam@gmail.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Tim Collier <osdevtc@gmail.com>,
        Chris Opperman <eklikeroomys@gmail.com>,
        Hariprasad Kelam <hariprasad.kelam@gmail.com>,
        devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org
Subject: [PATCH] staging: wlan-ng: collect return status without variable
Message-ID: <20190510023900.GA4390@hari-Inspiron-1545>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

err and result variables are declared to collect return status
of prism2_domibset_uint32.

Check return status in if loop and return directly.

Rearragne code such that we can avoid declaring these variables.

Signed-off-by: Hariprasad Kelam <hariprasad.kelam@gmail.com>
---
 drivers/staging/wlan-ng/cfg80211.c | 17 ++++++-----------
 1 file changed, 6 insertions(+), 11 deletions(-)

diff --git a/drivers/staging/wlan-ng/cfg80211.c b/drivers/staging/wlan-ng/cfg80211.c
index 8a862f7..5dad5ac 100644
--- a/drivers/staging/wlan-ng/cfg80211.c
+++ b/drivers/staging/wlan-ng/cfg80211.c
@@ -231,17 +231,12 @@ static int prism2_set_default_key(struct wiphy *wiphy, struct net_device *dev,
 {
 	struct wlandevice *wlandev = dev->ml_priv;
 
-	int err = 0;
-	int result = 0;
-
-	result = prism2_domibset_uint32(wlandev,
-		DIDMIB_DOT11SMT_PRIVACYTABLE_WEPDEFAULTKEYID,
-		key_index);
-
-	if (result)
-		err = -EFAULT;
-
-	return err;
+	if (prism2_domibset_uint32(wlandev,
+				   DIDMIB_DOT11SMT_PRIVACYTABLE_WEPDEFAULTKEYID,
+				   key_index))
+		return -EFAULT;
+	else
+		return 0;
 }
 
 static int prism2_get_station(struct wiphy *wiphy, struct net_device *dev,
-- 
2.7.4

