Return-Path: <SRS0=LGpO=UH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 66AE2C28CC5
	for <linux-kernel@archiver.kernel.org>; Sat,  8 Jun 2019 09:00:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2EBC3214AE
	for <linux-kernel@archiver.kernel.org>; Sat,  8 Jun 2019 09:00:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="J5Y7/RC7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726688AbfFHJA4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 8 Jun 2019 05:00:56 -0400
Received: from mail-pl1-f193.google.com ([209.85.214.193]:45841 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726305AbfFHJAz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 8 Jun 2019 05:00:55 -0400
Received: by mail-pl1-f193.google.com with SMTP id bi6so1324016plb.12;
        Sat, 08 Jun 2019 02:00:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=WNvqLoTkh0fWgkbS/w4CTYn2SASEM94dbBgdk4HmiaM=;
        b=J5Y7/RC7yDTLqB33iZOJHnhB+0UVex4VEmrvVxXMv7+x2Jup+1V7oJameXcXPZDndB
         zttzlKdq4FauXoGSiOSxKWkLm4AmBKxFhhIPiJbzI2tYMMogoIML1ozW8MfPaY4EDo0/
         XXnuVbQxs9tBIs6F6hHcOXF2ZXStCIodJCRa7PWVTJ4nKMdJrMaQecwUYu++AabPNBBz
         Z9Drj4lCJvYbP/R+EQwpbS678Qml6gsWNS/2KRESzdcBCbKOcD1J3CG9vA86i90LrGIG
         D0SU3mUBJkDgHLnLCrMbwfcbBBpKxvKIyy3ZlzgnROphrk1Hq2RnVrKSlAHrcWtAV+ey
         hhBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=WNvqLoTkh0fWgkbS/w4CTYn2SASEM94dbBgdk4HmiaM=;
        b=lGnoS3k/Ek3gpSApLwXLgnPmn77qOxgdZEp9H2F78+nT5bON1dOBc7PUHY/f+u/InL
         C4ho0V7g11J9AFakv7wA4TMTd5AhT4vngy413qa++k2uR3yen9Qr30ky0HqQPW3KvvMr
         HalbtBsbQHN1FGeIWpNGygni3c3GgtOEjR1m1iVW9OC4Mo62zqsayOMJwbkRUTcPvcYP
         5lmdsfBa4lLXFPnsgPWFwBQiqErNd384foFC4ObJ3lAFMAKZNjV+JBmwRvGZMCfwHAGf
         hT6iOyTzbNx1yOM19FMLH4pdVhga0mXQxshPFaGf1jzQYExdsSxbVLC4P9wYgPHpTwSg
         PVjw==
X-Gm-Message-State: APjAAAXQkv9wD/febValXCzCSuzFE3OmTklHZCA71gj2MuyBKKoxXw4Y
        yBhqqwXVmaUQ0pTY9cqLtbx2jj7Q
X-Google-Smtp-Source: APXvYqxnWdJ6aEaoRjcVGYEHm/4u2R3C5YViMzkvDQ6XPeeULLoxbr70Hgp3g3YlQvJgMOSewZJcmg==
X-Received: by 2002:a17:902:b717:: with SMTP id d23mr43537398pls.53.1559984455089;
        Sat, 08 Jun 2019 02:00:55 -0700 (PDT)
Received: from hari-Inspiron-1545 ([183.83.89.153])
        by smtp.gmail.com with ESMTPSA id p15sm5554623pgj.61.2019.06.08.02.00.53
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 08 Jun 2019 02:00:54 -0700 (PDT)
Date:   Sat, 8 Jun 2019 14:30:50 +0530
From:   Hariprasad Kelam <hariprasad.kelam@gmail.com>
To:     Steffen Klassert <steffen.klassert@secunet.com>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        "David S. Miller" <davem@davemloft.net>, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] af_key: make use of BUG_ON macro
Message-ID: <20190608090050.GA8339@hari-Inspiron-1545>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

fix below warnings reported by coccicheck

net/key/af_key.c:932:2-5: WARNING: Use BUG_ON instead of if condition
followed by BUG.
net/key/af_key.c:948:2-5: WARNING: Use BUG_ON instead of if condition
followed by BUG.

Signed-off-by: Hariprasad Kelam <hariprasad.kelam@gmail.com>
---
 net/key/af_key.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/net/key/af_key.c b/net/key/af_key.c
index fe5fc4b..b67ed3a 100644
--- a/net/key/af_key.c
+++ b/net/key/af_key.c
@@ -928,8 +928,7 @@ static struct sk_buff *__pfkey_xfrm_state2msg(const struct xfrm_state *x,
 		pfkey_sockaddr_fill(&x->props.saddr, 0,
 				    (struct sockaddr *) (addr + 1),
 				    x->props.family);
-	if (!addr->sadb_address_prefixlen)
-		BUG();
+	BUG_ON(!addr->sadb_address_prefixlen);
 
 	/* dst address */
 	addr = skb_put(skb, sizeof(struct sadb_address) + sockaddr_size);
@@ -944,8 +943,7 @@ static struct sk_buff *__pfkey_xfrm_state2msg(const struct xfrm_state *x,
 		pfkey_sockaddr_fill(&x->id.daddr, 0,
 				    (struct sockaddr *) (addr + 1),
 				    x->props.family);
-	if (!addr->sadb_address_prefixlen)
-		BUG();
+	BUG_ON(!addr->sadb_address_prefixlen);
 
 	if (!xfrm_addr_equal(&x->sel.saddr, &x->props.saddr,
 			     x->props.family)) {
-- 
2.7.4

