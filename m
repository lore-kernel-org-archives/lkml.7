Return-Path: <SRS0=w7sF=2K=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E4497C2D0D2
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Dec 2019 17:13:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B2DF421D7E
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Dec 2019 17:13:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="uYwyK2Vt"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727419AbfLTRNP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 20 Dec 2019 12:13:15 -0500
Received: from mail-wr1-f67.google.com ([209.85.221.67]:35739 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727362AbfLTRNO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Dec 2019 12:13:14 -0500
Received: by mail-wr1-f67.google.com with SMTP id g17so10134395wro.2
        for <linux-kernel@vger.kernel.org>; Fri, 20 Dec 2019 09:13:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=CnU4xvfoNnMFHRMSFrsXcG1YgG1fyn/xauqN1cixU2I=;
        b=uYwyK2VtKQBp/NbuJmih9sxLppLZ6LHHB56L7qjb11pFtES/khKnUpWxpALlmCtVYp
         pmUQVraNEl5aowRXY8HqyZNdCi4v4LbGRsex6T3o1Xg39qtzJk7Y9v3VW/xx0F/pujK4
         exHrBOwT3H93AQRVHyQHL/gOoq0udEoM37PYXqoOJpKlD1PFbzw94NSWVlZYWdH+On1N
         iDnCf/0KlnBFKVlWv4DqAYnBEOVzKV4MklX+0seFQpxMmpTHXdPBUodW34ObneBcIjqv
         WmIw8turqV+UOsiThIS2tkpX8ouPcNxQulPAWbQ7bWJK7FQzK+t3a978irbB/Y8ASENU
         t9hw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=CnU4xvfoNnMFHRMSFrsXcG1YgG1fyn/xauqN1cixU2I=;
        b=ESJWZgyRGCgIpOmooLWSQCzucriMaectEP9XgCa7L2ASIj6ThYF+lafPjzccRrpZSW
         TB0W6+RheoU8EtbSKw8iqE6cYaWc15nAdhMnwRO2q0M3HPMeopWvh6uuT4Tk+666K+1F
         YllHgIm4EwesnScpUB8bLtMDUmP67GomTkgVNFGnR92LN/XhIrmriUxzMhTSbLRIurvS
         InZIIfsMkYDK9tYoy1IqzDZpvRZfg00oHx0Te1bNfbZBCih16ZkdCnilG7Z/XY8Q1I4s
         pZHa7b4XBCt8qaIH9/DWgT0qSzCLYGu7WP/6Msed0yqROZNmFfpn3QXxwKaZKDqbah9V
         ihAA==
X-Gm-Message-State: APjAAAX446bzB3sh36r70DrscXyCAWf2JLRZ2k3BeFpNwy7P7jANMIPU
        vufEbPAu5f/RYDACcdHVJrl3sw==
X-Google-Smtp-Source: APXvYqxmxO9UFUF3xQfA5fp0bQKpI1PQbCxM6J/wAH6gpIdilo8iKFwjXyrtVbdIMu0087TFGHx0Rg==
X-Received: by 2002:adf:e5ca:: with SMTP id a10mr16179218wrn.347.1576861992379;
        Fri, 20 Dec 2019 09:13:12 -0800 (PST)
Received: from localhost.localdomain ([212.45.67.2])
        by smtp.googlemail.com with ESMTPSA id k13sm10276085wrx.59.2019.12.20.09.13.11
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 20 Dec 2019 09:13:11 -0800 (PST)
From:   Georgi Djakov <georgi.djakov@linaro.org>
To:     linux-pm@vger.kernel.org
Cc:     bjorn.andersson@linaro.org, evgreen@chromium.org,
        daidavid1@codeaurora.org, okukatla@codeaurora.org,
        jcrouse@codeaurora.org, georgi.djakov@linaro.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] interconnect: Check for valid path in icc_set_bw()
Date:   Fri, 20 Dec 2019 19:13:10 +0200
Message-Id: <20191220171310.24169-1-georgi.djakov@linaro.org>
X-Mailer: git-send-email 2.24.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use IS_ERR() to ensure that the path passed to icc_set_bw() is valid.

Signed-off-by: Georgi Djakov <georgi.djakov@linaro.org>
---
 drivers/interconnect/core.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/interconnect/core.c b/drivers/interconnect/core.c
index 63c164264b73..14a6f7ade44a 100644
--- a/drivers/interconnect/core.c
+++ b/drivers/interconnect/core.c
@@ -498,6 +498,11 @@ int icc_set_bw(struct icc_path *path, u32 avg_bw, u32 peak_bw)
 	if (!path || !path->num_nodes)
 		return 0;
 
+	if (IS_ERR(path)) {
+		pr_err("%s: invalid path=%ld\n", __func__, PTR_ERR(path));
+		return -EINVAL;
+	}
+
 	mutex_lock(&icc_lock);
 
 	old_avg = path->reqs[0].avg_bw;
