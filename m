Return-Path: <SRS0=OvUS=X5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1C703C4CED1
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Oct 2019 22:27:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DBF13222C0
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Oct 2019 22:27:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ZL7TYe6Z"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388028AbfJDW1L (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 4 Oct 2019 18:27:11 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:43714 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728812AbfJDW1K (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Oct 2019 18:27:10 -0400
Received: by mail-pg1-f196.google.com with SMTP id v27so4511906pgk.10
        for <linux-kernel@vger.kernel.org>; Fri, 04 Oct 2019 15:27:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=MdgTtpJ3Fb1crDWamPJ2nMkskfT7oSxSe5O6OdgdxZ4=;
        b=ZL7TYe6ZIkKRam213eUarR6XVUZ9Z2pHkS0ETE0nwysjqnhcx4HvOaIh+KMQn6YsLq
         mKjtX2s1h3GN9lPCu75hOOIGG2YwV1kcO/oG3NM0MAGjNs6z5fuRscsGNynGgq4zk3aV
         2VBnpXHocWNZNNfgr8YUWQAm7VnCZLzKa0jC0DYYOquebKlujr4X4Jzy3pYoXyy6+oqG
         6EoXtVug7wgGjGw8Khr+CZvWQ0DT77ILwk4rvg8GREyipXETKPvkdepKtOurm3ynl8aC
         nnyazBw+l7iJro52OaxOnd+RknOcZ3lkI6PxLDL232PF6dH04WcfEnnThwiQ4qKsLcsh
         7FhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=MdgTtpJ3Fb1crDWamPJ2nMkskfT7oSxSe5O6OdgdxZ4=;
        b=ZLyGvsxj9A1CAb+ZwSoZbseDWaFzO/3U8VRYTZ1a2IlSuFVamQeJDd52L9Fc+8T97R
         iNclV3x9oWwd1xoarfyYve7PHn8+WQFT4B4GQPMUi1iJCcS9IZmrvo43djT05rMUnTVi
         V+kd8QaR52bHPeVUZE0q5LOzgy1MDJCg6UPIHIx6w6zxFc35T2501LTpiIDB6lDInyyI
         KntsHy4z76Domhhy3bBpxU+n26PhM25V197lgprI1pgjKI7Vbyj1uZ9CMY30PNP0p9nn
         wmdLFWEBBVWd1hVYm7V82c9maQOIW3Rc5o9D7G0dHoX5Silot4JvKqKlEBWAfWztduMg
         wFWg==
X-Gm-Message-State: APjAAAUoBVyKc1vKb7yIUBJNNA8ta1YMvqh7tv8UcJC/XdzxmMrrlSh0
        pqSXJGTtsXLeGfJmgQvJCjXoNaATxps=
X-Google-Smtp-Source: APXvYqy8P355fDdWZ7Bjd78TA0Rif1EjY23uAZcQptugi3FT1XaYfKGFi0ye/CSlumDYU5zIu9qqMg==
X-Received: by 2002:a65:500d:: with SMTP id f13mr17876281pgo.359.1570228028355;
        Fri, 04 Oct 2019 15:27:08 -0700 (PDT)
Received: from localhost.localdomain (104-188-17-28.lightspeed.sndgca.sbcglobal.net. [104.188.17.28])
        by smtp.gmail.com with ESMTPSA id x37sm6328136pgl.18.2019.10.04.15.27.07
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 04 Oct 2019 15:27:07 -0700 (PDT)
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Ohad Ben-Cohen <ohad@wizery.com>,
        Bjorn Andersson <bjorn.andersson@linaro.org>
Cc:     linux-arm-msm@vger.kernel.org, linux-remoteproc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 0/6] rpmsg: glink stability fixes
Date:   Fri,  4 Oct 2019 15:26:56 -0700
Message-Id: <20191004222702.8632-1-bjorn.andersson@linaro.org>
X-Mailer: git-send-email 2.18.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fixes for issues found in GLINK during reboot testing of a remoteproc.

Arun Kumar Neelakantam (2):
  rpmsg: glink: Fix reuse intents memory leak issue
  rpmsg: glink: Fix use after free in open_ack TIMEOUT case

Bjorn Andersson (2):
  rpmsg: glink: Don't send pending rx_done during remove
  rpmsg: glink: Free pending deferred work on remove

Chris Lew (2):
  rpmsg: glink: Put an extra reference during cleanup
  rpmsg: glink: Fix rpmsg_register_device err handling

 drivers/rpmsg/qcom_glink_native.c | 52 +++++++++++++++++++++++++------
 1 file changed, 42 insertions(+), 10 deletions(-)

-- 
2.18.0

