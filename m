Return-Path: <SRS0=i7el=ZO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DACA6C432C0
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Nov 2019 22:03:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A3CDC20708
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Nov 2019 22:03:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="A1gGUxST"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726869AbfKVWDD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Nov 2019 17:03:03 -0500
Received: from mail-il1-f193.google.com ([209.85.166.193]:45245 "EHLO
        mail-il1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726760AbfKVWDC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Nov 2019 17:03:02 -0500
Received: by mail-il1-f193.google.com with SMTP id o18so8362761ils.12;
        Fri, 22 Nov 2019 14:03:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=Am+hWmHqZI8W0GbJ/AGvDY6oQA/XKRSe9fojsLPxqlI=;
        b=A1gGUxSTGeZe9hMX0v/ChN19GwHKKYO9berCRmlzXnae8tkzPwwpS3HF6Dnk+mALeK
         y7jo7yOD+yZtWAbtRiZ+XPWNZrQ1ehXSktmvO+tqn4bmfb74nNixIXbC2xRmfPkY7m4C
         ySy5MMN0gfI5C5NDGF4YfkoQmmVfU4ObcJPmVhS2cP5eovfDtbNv3/+UDvduI1FRkLHg
         xjczVtHDcgYBepb28Mihwc6Fcu6ogRC1oNNYEfVmnlDqnShx5Lgxk6yhz8E7kK1orSA6
         zj2bA0JAdlYqp//yH8aaFgVR75bEyQDP3IFdZV35SkuUPLE+H9Dz4IO6JSKRQkTM9lUX
         VCbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=Am+hWmHqZI8W0GbJ/AGvDY6oQA/XKRSe9fojsLPxqlI=;
        b=s+ji+SlcZCyY88y7pGxEqrFan47xSC0REb7f51gfc2sCVdTuwTljw/sw5dpSWHYD9h
         2xwtokIuYbj3v0NrVSEQhcjzURKOxxAo3Jxyv3GMQJh9BDmkPQIiseMeif8n1Mg+ADgo
         VLUe10hdLmzPomFf67a3IVo3605jisOUydfmsr6Fq5w4kcBozGhNdLGkoZDBR3x2WOAn
         QYB05vjPw9NccB5E2VAQtPI0srNZXDhzJHHSfKnrqUaR5lSBxyISO66zXjxy7hPolPWL
         cmjykUwdx/LbWUoQeepYkGxNmewy1iBn5Y4IFlTPV5UTnji0Xa3gTl9F9GH6a5MSH0to
         xtlw==
X-Gm-Message-State: APjAAAUVHh9dmyX+oFHmnqB5z1h60C9OrQ2DL+GxNHM0zVHDrBpCmqYu
        zaQQWSNmKHKRCflayq7FcDM=
X-Google-Smtp-Source: APXvYqxq/NaRlUElg8aDh6NXB9iZFW2P1SdbE37kyQqlEaBv1EmQCtiC3LYcYMVX8FBz5LcjhBjzhA==
X-Received: by 2002:a92:109c:: with SMTP id 28mr19188959ilq.142.1574460181744;
        Fri, 22 Nov 2019 14:03:01 -0800 (PST)
Received: from cs-dulles.cs.umn.edu (cs-dulles.cs.umn.edu. [128.101.35.54])
        by smtp.googlemail.com with ESMTPSA id a19sm2648147ioo.51.2019.11.22.14.03.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 Nov 2019 14:03:00 -0800 (PST)
From:   Navid Emamdoost <navid.emamdoost@gmail.com>
To:     "David S. Miller" <davem@davemloft.net>,
        Johannes Berg <johannes.berg@intel.com>,
        Taehee Yoo <ap420073@gmail.com>,
        Andreas Steinmetz <ast@domdv.de>,
        Navid Emamdoost <navid.emamdoost@gmail.com>,
        Michal Kubecek <mkubecek@suse.cz>,
        Florian Westphal <fw@strlen.de>,
        Thomas Gleixner <tglx@linutronix.de>, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     emamd001@umn.edu
Subject: [PATCH] macsec: Fix memory leaks in macsec_decrypt()
Date:   Fri, 22 Nov 2019 16:02:36 -0600
Message-Id: <20191122220242.29359-1-navid.emamdoost@gmail.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In the implementation of macsec_decrypt(), there are two memory leaks
when crypto_aead_decrypt() fails. Release allocated req and skb before
return.

Fixes: c3b7d0bd7ac2 ("macsec: fix rx_sa refcounting with decrypt callback")
Signed-off-by: Navid Emamdoost <navid.emamdoost@gmail.com>
---
 drivers/net/macsec.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/net/macsec.c b/drivers/net/macsec.c
index afd8b2a08245..34c6fb4eb9ef 100644
--- a/drivers/net/macsec.c
+++ b/drivers/net/macsec.c
@@ -986,6 +986,8 @@ static struct sk_buff *macsec_decrypt(struct sk_buff *skb,
 	dev_hold(dev);
 	ret = crypto_aead_decrypt(req);
 	if (ret == -EINPROGRESS) {
+		aead_request_free(req);
+		kfree_skb(skb);
 		return ERR_PTR(ret);
 	} else if (ret != 0) {
 		/* decryption/authentication failed
-- 
2.17.1

