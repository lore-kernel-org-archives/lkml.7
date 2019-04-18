Return-Path: <SRS0=NWWL=SU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 09682C10F0B
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Apr 2019 04:37:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CCDAD2184B
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Apr 2019 04:37:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BfHA7hoc"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726779AbfDREhI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 18 Apr 2019 00:37:08 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:40109 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725710AbfDREhI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Apr 2019 00:37:08 -0400
Received: by mail-pf1-f193.google.com with SMTP id c207so505737pfc.7
        for <linux-kernel@vger.kernel.org>; Wed, 17 Apr 2019 21:37:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=kF43dh0ZxJQOL3p4gvaqdt1Xkf4aI0fRWli00kFYg5c=;
        b=BfHA7hocFMVSvkXO+uLAo8FluCzQrxY9nECRNjlONI6vWf5fPYubGmb2MkpV2pJjsE
         P3ErPXfeDKIcpOepHtp3jkXDc3B3snla3bHgCpsiae8YlBDzxCEVkDFv9+3wzSCCWRFq
         EY+t93CrLxIfopFXu3CiPVlVW2VxVVybBTUWA8mRW9XPaE4jARYeH02lEnNJMSBBJqE1
         tV/Uv6qECKEjOYDw1bNpDRDWM9fVklKnFi/WlDge91lmNPYDF+SI72VYrkK3+8aZJSLq
         DOCHqO7T2mncnIUjojBWtf9FrSuGPlapNcYK9a01Zlaf6i3zE+4viMuyObscGRpRinZ2
         BwOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=kF43dh0ZxJQOL3p4gvaqdt1Xkf4aI0fRWli00kFYg5c=;
        b=jhmYcbuKMopRr7NuW+H+yjv1ANjYW4JY6Djl1dGZpwvdZdj9cEjXW1+Ch1PLV4SR3D
         GA/qL6jo7WjuEHViD/wfvoA2MLxY6j6XTi1Pv+Nqci3lCHju404LIYxsLTPLDM+hx7k9
         0oEfQgp7usjVQZWJd50wGkw6f2PfO/jhn71+PlNnkxYRBgiPTcwSHmQcqEfocuUCUGiQ
         yeN7ByxSRkFbnOZTeXPqvVNraO94ZYjBZDIm9AcxsWI/yRg+KqYlwlTMWoolo5i5yHpf
         iJOo0zZRIRYzocE1MbsOH2v+hmo1aXI4ePqBME0ex+OMajQa4Pj2l54wcMvmarWPalaQ
         SXtw==
X-Gm-Message-State: APjAAAUzV/2k52OspjNVgvTMzz2wWZHpSXXpT5MiXylGI/AWpI6Gr11q
        2ABW0PA/f+LDJkvEILbIEyo=
X-Google-Smtp-Source: APXvYqwBFPVSZYWKAdiW6jPwiYyfkqnFdTFNh/io5qmwFFtVVg0Q6JCv9e7yywW/efDwLGwUJaTViw==
X-Received: by 2002:a62:1bc7:: with SMTP id b190mr95031213pfb.29.1555562227523;
        Wed, 17 Apr 2019 21:37:07 -0700 (PDT)
Received: from hfq-skylake.ipads-lab.se.sjtu.edu.cn ([202.120.40.82])
        by smtp.googlemail.com with ESMTPSA id a3sm1109363pfn.182.2019.04.17.21.37.04
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 17 Apr 2019 21:37:07 -0700 (PDT)
From:   Fuqian Huang <huangfq.daxian@gmail.com>
Cc:     Fuqian Huang <huangfq.daxian@gmail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jslaby@suse.com>, linux-kernel@vger.kernel.org
Subject: [PATCH v5 02/02] tty: rocket: deprecate the rp_ioctl
Date:   Thu, 18 Apr 2019 12:35:58 +0800
Message-Id: <20190418043558.10577-2-huangfq.daxian@gmail.com>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20190418043558.10577-1-huangfq.daxian@gmail.com>
References: <20190418043558.10577-1-huangfq.daxian@gmail.com>
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch depends on patch 01.

The rp_ioctl is deprecated.
Add dev_warn_ratelimited to warn the use of rp_ioctl.

Signed-off-by: Fuqian Huang <huangfq.daxian@gmail.com>
---
 drivers/tty/rocket.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/drivers/tty/rocket.c b/drivers/tty/rocket.c
index b6543e28bd8b..1e1bcb54b680 100644
--- a/drivers/tty/rocket.c
+++ b/drivers/tty/rocket.c
@@ -1284,18 +1284,28 @@ static int rp_ioctl(struct tty_struct *tty,
 
 	switch (cmd) {
 	case RCKP_GET_CONFIG:
+		dev_warn_ratelimited(tty->dev,
+					"RCKP_GET_CONFIG option is deprecated\n");
 		ret = get_config(info, argp);
 		break;
 	case RCKP_SET_CONFIG:
+		dev_warn_ratelimited(tty->dev,
+					"RCKP_SET_CONFIG option is deprecated\n");
 		ret = set_config(tty, info, argp);
 		break;
 	case RCKP_GET_PORTS:
+		dev_warn_ratelimited(tty->dev,
+					"RCKP_GET_PORTS option is deprecated\n");
 		ret = get_ports(info, argp);
 		break;
 	case RCKP_RESET_RM2:
+		dev_warn_ratelimited(tty->dev,
+					"RCKP_RESET_RM2 option is deprecated\n");
 		ret = reset_rm2(info, argp);
 		break;
 	case RCKP_GET_VERSION:
+		dev_warn_ratelimited(tty->dev,
+					"RCKP_GET_VERSION option is deprecated\n");
 		ret = get_version(info, argp);
 		break;
 	default:
-- 
2.11.0

