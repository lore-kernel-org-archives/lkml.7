Return-Path: <SRS0=wETr=XU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 562DEC432C2
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Sep 2019 18:24:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1B97521655
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Sep 2019 18:24:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CJBIqnUi"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2634174AbfIYSYP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 25 Sep 2019 14:24:15 -0400
Received: from mail-io1-f67.google.com ([209.85.166.67]:41189 "EHLO
        mail-io1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2408520AbfIYSYP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Sep 2019 14:24:15 -0400
Received: by mail-io1-f67.google.com with SMTP id r26so1264213ioh.8;
        Wed, 25 Sep 2019 11:24:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=6xjol+n/30NhNrorA1nuQM26Ppj6oKqSnjtWLX2XseA=;
        b=CJBIqnUij2EVW5e23A7nSjpCnt1SNL0X/3euzdTJ/z9TUR3gImi+QltSfURY/pxSby
         Wg7kQV1LnchSeJl2ak/EBCScicYBJB/GnNj+ZOC3TBrs22gzdklX6DICoD3Xg61kD21+
         k8cTBNqMRZ+Tzr35lTTsQWK+AaD9GhyIdqUv9n0CDdo2tyjcYg6twfdHWfusvAWeiaC/
         TjOaNSmgWaD0zAiYXvdwKeWSc0MfSFlfC73Pmsr0rhX0KRpJgrn//XnSktpTykEXSUry
         PeMeVKxQskUGP7FZb2+Sd6l4hzusEaXdoG5aKbSLFH7YyLhDKbg2kPWgSiMwyxd1o0at
         Dn8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=6xjol+n/30NhNrorA1nuQM26Ppj6oKqSnjtWLX2XseA=;
        b=mWh41TgoTzIxSmuGQytNyRoOtlmY11GmwHF/kmH05VQauj59zor/fMx+eOBIijYKkE
         Ts28dEj0kaGINFm8Tda/TIq8WsQWCsTxFfe3o/0LLVIcK4amywcB7IT2+kzDC2p2KSaC
         mwyVN4tcB7wxtyUuLY52AVhhKGbZaLytk2hleqYxfIQkkPkOX/yzprpMeR6Aavf+KgqN
         cfPlLuNRgPRzVjl70dCugrHQPOQ/rSb8ZdEJztuim0/W3dzwMiVEu20afygH0vjSj/jY
         jOqHlMJZjmbi3Kdt0J4GOJOzLx67Q6Hk9bw9f0LlRtM8qwdiYTP5GzkB92nLgGWUWA5u
         MMLA==
X-Gm-Message-State: APjAAAXyRfsDwMKwfcKjk30Ix+N77ABLTomRmNIUJVdVhQTiCQYCYLvy
        VMQyEffw+vbzpHPIAE1MEF8=
X-Google-Smtp-Source: APXvYqyD8Fs8XfvHAB0lOgHz7Vqb4KWU5w97yNmLZM6eggM6pL8Ngc3IGo3Uw3oeq9v2rhw4tTgxTg==
X-Received: by 2002:a5d:8911:: with SMTP id b17mr779988ion.287.1569435853982;
        Wed, 25 Sep 2019 11:24:13 -0700 (PDT)
Received: from cs-dulles.cs.umn.edu (cs-dulles.cs.umn.edu. [128.101.35.54])
        by smtp.googlemail.com with ESMTPSA id f7sm185591ioj.66.2019.09.25.11.24.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Sep 2019 11:24:13 -0700 (PDT)
From:   Navid Emamdoost <navid.emamdoost@gmail.com>
Cc:     emamd001@umn.edu, kjlu@umn.edu, smccaman@umn.edu,
        Navid Emamdoost <navid.emamdoost@gmail.com>,
        Jakub Kicinski <jakub.kicinski@netronome.com>,
        "David S. Miller" <davem@davemloft.net>,
        John Hurley <john.hurley@netronome.com>,
        Simon Horman <simon.horman@netronome.com>,
        Pieter Jansen van Vuuren 
        <pieter.jansenvanvuuren@netronome.com>,
        Fred Lotter <frederik.lotter@netronome.com>,
        oss-drivers@netronome.com, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] nfp: flower: prevent memory leak in nfp_flower_spawn_phy_reprs
Date:   Wed, 25 Sep 2019 13:24:02 -0500
Message-Id: <20190925182405.31287-1-navid.emamdoost@gmail.com>
X-Mailer: git-send-email 2.17.1
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In nfp_flower_spawn_phy_reprs, in the for loop over eth_tbl if any of
intermediate allocations or initializations fail memory is leaked.
requiered releases are added.

Signed-off-by: Navid Emamdoost <navid.emamdoost@gmail.com>
---
 drivers/net/ethernet/netronome/nfp/flower/main.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/net/ethernet/netronome/nfp/flower/main.c b/drivers/net/ethernet/netronome/nfp/flower/main.c
index 7a20447cca19..91a47899220f 100644
--- a/drivers/net/ethernet/netronome/nfp/flower/main.c
+++ b/drivers/net/ethernet/netronome/nfp/flower/main.c
@@ -515,6 +515,7 @@ nfp_flower_spawn_phy_reprs(struct nfp_app *app, struct nfp_flower_priv *priv)
 		repr_priv = kzalloc(sizeof(*repr_priv), GFP_KERNEL);
 		if (!repr_priv) {
 			err = -ENOMEM;
+			nfp_repr_free(repr);
 			goto err_reprs_clean;
 		}
 
@@ -525,11 +526,13 @@ nfp_flower_spawn_phy_reprs(struct nfp_app *app, struct nfp_flower_priv *priv)
 		port = nfp_port_alloc(app, NFP_PORT_PHYS_PORT, repr);
 		if (IS_ERR(port)) {
 			err = PTR_ERR(port);
+			kfree(repr_priv);
 			nfp_repr_free(repr);
 			goto err_reprs_clean;
 		}
 		err = nfp_port_init_phy_port(app->pf, app, port, i);
 		if (err) {
+			kfree(repr_priv);
 			nfp_port_free(port);
 			nfp_repr_free(repr);
 			goto err_reprs_clean;
@@ -542,6 +545,7 @@ nfp_flower_spawn_phy_reprs(struct nfp_app *app, struct nfp_flower_priv *priv)
 		err = nfp_repr_init(app, repr,
 				    cmsg_port_id, port, priv->nn->dp.netdev);
 		if (err) {
+			kfree(repr_priv);
 			nfp_port_free(port);
 			nfp_repr_free(repr);
 			goto err_reprs_clean;
-- 
2.17.1

