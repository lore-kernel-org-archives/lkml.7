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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9DEFDC432C1
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Sep 2019 04:30:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6AE612054F
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Sep 2019 04:30:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DLSdyfZ7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2442272AbfIYEam (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 25 Sep 2019 00:30:42 -0400
Received: from mail-io1-f68.google.com ([209.85.166.68]:42027 "EHLO
        mail-io1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390426AbfIYEam (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Sep 2019 00:30:42 -0400
Received: by mail-io1-f68.google.com with SMTP id n197so10155199iod.9
        for <linux-kernel@vger.kernel.org>; Tue, 24 Sep 2019 21:30:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=Een0CpGnMmjlIwv6SGvcNYXFPmeEyRahY8Cx/ZLw6Cs=;
        b=DLSdyfZ7jMpKvSBsDSe7mOpAysxnrw6UY6qtMxOjDFe9vauIc1eUtuQkHTRe9saurj
         sUUAYFB/R+ae8fTscfHi6/muabc8G1gFEydiAZM8qAqKnIxbvOuYB4zWpWzmt9dQiYCE
         rHDv6db0OavUV30UpKkXkowxibuS6fjz5+1ud3L9CgQ0m2xMRGx8ql7XaNFC3ywAWJxV
         MjsC0INc0XpGuC+YgC328Pz2Y5IssNWwN2PemFjnEHftVZXdB0E7Z7Bh2Qoc6d/CVvEM
         HtPD+XfgI0bE4VSspBvxxDJiFwSp1CbmHP0WelXA5DBSZjSwCHfGBS/rIRcjOaSnlrHm
         TFiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=Een0CpGnMmjlIwv6SGvcNYXFPmeEyRahY8Cx/ZLw6Cs=;
        b=fkFl7d18bdWqw05x7BXTjyWf2VfgHmHi4pgaiJCfIti7D6K8ksY/+p1CWcK/8swgmE
         wl77l49Mt8hK5pOnYh2q0rfjTIIyRmEbFSXZy+e5Gx5+JH6bSwYrZIFPLpzSfjQIe1Io
         hPqaXlqYzX4KlTQWV3HXxE24O4P3OlsP3MopzJfQ5E0h1wwSKzdKJIZvhqjh9U+euE4Y
         G2jsg67nVk9KYOH0a78wyyKAzr92x2mcUVXHeT1Lbf1V8NFyjCqmpvtilVaDSXqOeQVI
         81Qc2+fkC5aqMz3T+H570eAcjvuzBvX7NWrjTuNWCJlWabh9+Cyuyqw02JWizhYnSxMM
         mE5Q==
X-Gm-Message-State: APjAAAVV3d3ZA+UxOtQL+whKWLTIEIn0GXYycor8WezHTQKdIiefzOJJ
        mrZv9ApwbrxYjFwMRH/xbtk=
X-Google-Smtp-Source: APXvYqzEomJ2P1aN8yp1bKMYaBxSHch+LNln2o811DhB87lddkLKVluZBUQPiHMnHUBd6N5Ipj+Bdw==
X-Received: by 2002:a5d:8f92:: with SMTP id l18mr4766636iol.143.1569385841381;
        Tue, 24 Sep 2019 21:30:41 -0700 (PDT)
Received: from cs-dulles.cs.umn.edu (cs-dulles.cs.umn.edu. [128.101.35.54])
        by smtp.googlemail.com with ESMTPSA id o16sm42508ilf.80.2019.09.24.21.30.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Sep 2019 21:30:40 -0700 (PDT)
From:   Navid Emamdoost <navid.emamdoost@gmail.com>
Cc:     emamd001@umn.edu, kjlu@umn.edu, smccaman@umn.edu,
        Navid Emamdoost <navid.emamdoost@gmail.com>,
        "James (Qian) Wang" <james.qian.wang@arm.com>,
        Liviu Dudau <liviu.dudau@arm.com>,
        Brian Starkey <brian.starkey@arm.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: [PATCH] drm/komeda: prevent memory leak in komeda_wb_connector_add
Date:   Tue, 24 Sep 2019 23:30:30 -0500
Message-Id: <20190925043031.32308-1-navid.emamdoost@gmail.com>
X-Mailer: git-send-email 2.17.1
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In komeda_wb_connector_add if drm_writeback_connector_init fails the
allocated memory for kwb_conn should be released.

Signed-off-by: Navid Emamdoost <navid.emamdoost@gmail.com>
---
 drivers/gpu/drm/arm/display/komeda/komeda_wb_connector.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/arm/display/komeda/komeda_wb_connector.c b/drivers/gpu/drm/arm/display/komeda/komeda_wb_connector.c
index 2851cac94d86..75133f967fdb 100644
--- a/drivers/gpu/drm/arm/display/komeda/komeda_wb_connector.c
+++ b/drivers/gpu/drm/arm/display/komeda/komeda_wb_connector.c
@@ -166,8 +166,10 @@ static int komeda_wb_connector_add(struct komeda_kms_dev *kms,
 					   &komeda_wb_encoder_helper_funcs,
 					   formats, n_formats);
 	komeda_put_fourcc_list(formats);
-	if (err)
+	if (err) {
+		kfree(kwb_conn);
 		return err;
+	}
 
 	drm_connector_helper_add(&wb_conn->base, &komeda_wb_conn_helper_funcs);
 
-- 
2.17.1

