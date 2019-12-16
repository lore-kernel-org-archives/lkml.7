Return-Path: <SRS0=TLrx=2G=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8BD13C3F68F
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Dec 2019 18:38:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5A8202082E
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Dec 2019 18:38:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1576521516;
	bh=ALqeQ1mlQFZm/ZCQSnRaAsLeLzHzRts0tCbGZwrATSk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=KbhTGgRrJktSuIVSEhOrBAagRigwNL9KYbLKOfJ/ie+Wc5M3U8FB/Ac7WoNaCitvr
	 X9U8CEVgc0Y4f6HHQCsxOevA6oHV4aDvzgNzq053QFfoVKDRPbuE0CsS+pJEISPeRZ
	 xV271BnM2sS1BEFr6m0qCWdINcPXhZwHbzaIsoMs=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729505AbfLPSEl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 16 Dec 2019 13:04:41 -0500
Received: from mail.kernel.org ([198.145.29.99]:42056 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729687AbfLPSEi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Dec 2019 13:04:38 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 589E320700;
        Mon, 16 Dec 2019 18:04:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1576519477;
        bh=ALqeQ1mlQFZm/ZCQSnRaAsLeLzHzRts0tCbGZwrATSk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=GbNsmdGczIB4Y9lygeTS7WRdr+eWf0Y8LIfYPvaJ4YDxK2b8y0MefdVCRhDlmAQu4
         Gz3/oZjfGMP22yh2Aqw2d8cbQw3WPoK+RSh9+RvMHC/DNDBuVkb0J+fM4s054vGwia
         Uwa9XmCHiSrkIkMNP2ArKrtSpXmcANJgZA8dvxYY=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Krzysztof Kozlowski <krzk@kernel.org>
Subject: [PATCH 4.19 081/140] pinctrl: samsung: Fix device node refcount leaks in init code
Date:   Mon, 16 Dec 2019 18:49:09 +0100
Message-Id: <20191216174809.093575097@linuxfoundation.org>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20191216174747.111154704@linuxfoundation.org>
References: <20191216174747.111154704@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Krzysztof Kozlowski <krzk@kernel.org>

commit a322b3377f4bac32aa25fb1acb9e7afbbbbd0137 upstream.

Several functions use for_each_child_of_node() loop with a break to find
a matching child node.  Although each iteration of
for_each_child_of_node puts the previous node, but early exit from loop
misses it.  This leads to leak of device node.

Cc: <stable@vger.kernel.org>
Fixes: 9a2c1c3b91aa ("pinctrl: samsung: Allow grouping multiple pinmux/pinconf nodes")
Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/pinctrl/samsung/pinctrl-samsung.c |   10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

--- a/drivers/pinctrl/samsung/pinctrl-samsung.c
+++ b/drivers/pinctrl/samsung/pinctrl-samsung.c
@@ -272,6 +272,7 @@ static int samsung_dt_node_to_map(struct
 						&reserved_maps, num_maps);
 		if (ret < 0) {
 			samsung_dt_free_map(pctldev, *map, *num_maps);
+			of_node_put(np);
 			return ret;
 		}
 	}
@@ -785,8 +786,10 @@ static struct samsung_pmx_func *samsung_
 		if (!of_get_child_count(cfg_np)) {
 			ret = samsung_pinctrl_create_function(dev, drvdata,
 							cfg_np, func);
-			if (ret < 0)
+			if (ret < 0) {
+				of_node_put(cfg_np);
 				return ERR_PTR(ret);
+			}
 			if (ret > 0) {
 				++func;
 				++func_cnt;
@@ -797,8 +800,11 @@ static struct samsung_pmx_func *samsung_
 		for_each_child_of_node(cfg_np, func_np) {
 			ret = samsung_pinctrl_create_function(dev, drvdata,
 						func_np, func);
-			if (ret < 0)
+			if (ret < 0) {
+				of_node_put(func_np);
+				of_node_put(cfg_np);
 				return ERR_PTR(ret);
+			}
 			if (ret > 0) {
 				++func;
 				++func_cnt;


