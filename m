Return-Path: <SRS0=XcGb=25=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5B363C3F68F
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Jan 2020 03:24:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 25C622070E
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Jan 2020 03:24:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="h3BBlXN8"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726346AbgAHDYG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 Jan 2020 22:24:06 -0500
Received: from mail-pj1-f68.google.com ([209.85.216.68]:39699 "EHLO
        mail-pj1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726142AbgAHDYF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Jan 2020 22:24:05 -0500
Received: by mail-pj1-f68.google.com with SMTP id t101so451004pjb.4;
        Tue, 07 Jan 2020 19:24:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=sy0TPVo2jYoLirOgnD0I5TlsFYusUGHr86X3IrbRM40=;
        b=h3BBlXN8VgkzEVga98dRlUaRDkAVMk5bW704EQnrfcUr3DUHYTpvHfH+LhwRk31VQn
         dVJV1dJn2IQrm2fW6x4GF9seg5hXve7bnPDag382lpReJzay7BTEPIKUlCnobyzJK1Ym
         kHlqiP6xZzdpy+SFaWf7WkSPCGOrKHqrgfJGDppdDTOYY3pQ2gjPj86iRbCWIJlDEkWK
         CBQfJLcSR/FWl1B9PLt2b2Koxdx4/clGCg1v99+ZZeyxt+xN7pq36tzT8kphpKIuL7Je
         /mpSBpYGEdD/s66yTdB/GiVsy6b6qR+O3hYMwhN98M9i2rSdViHn9G1oXfMmW6ucbsfi
         RKKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=sy0TPVo2jYoLirOgnD0I5TlsFYusUGHr86X3IrbRM40=;
        b=pZDWyHnYXHqGeBM/BdLqM9WpY0C1OE+7PGkvbKUSe2nSfz04GW1K8+pW2EzP2Ys8eG
         2l38CDAgdu18TTD4zjZPVtAD7WwYuoeORo/81TNpcnFNlEQTU1yuWbxDN7ZIz8PW0WSK
         wVIV9ph+/r9L8FU/b7Qkgv8SCSfGa3FAGnfyJ3Eu844T08CRINOXzK3L1Mo6+270mdGS
         OQJzeDQB2e+ovb05oFyu+UAd7vy85aTA9fCDiHetdZ3qi4tq6CuDXf5F+OR8Q0thESXu
         vjT35HBlV/CwsW5ZVQupArYPHX2X2fqJGJNKysUwP8FlBKaJB8abqL1Ku/jGcKfr8CRp
         ho8g==
X-Gm-Message-State: APjAAAWKiSQyCED0qCaVDJ8OlNxi3SMZDvCbKgDpmv3+3miDGsYGyuiQ
        idaVjGwPwLcQIZYKKgBaCPE=
X-Google-Smtp-Source: APXvYqyMJlWNgMv5VydULs0NBAz3Q+VlKAEllzwaAqb78vpv5y6cfW1Oj0T3g5ErhM/lmtwgTEJHtw==
X-Received: by 2002:a17:902:7406:: with SMTP id g6mr3165376pll.103.1578453844855;
        Tue, 07 Jan 2020 19:24:04 -0800 (PST)
Received: from baolinwangubtpc.spreadtrum.com ([117.18.48.82])
        by smtp.gmail.com with ESMTPSA id g7sm1077875pfq.33.2020.01.07.19.24.02
        (version=TLS1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 07 Jan 2020 19:24:04 -0800 (PST)
From:   Baolin Wang <baolin.wang7@gmail.com>
To:     ohad@wizery.com, bjorn.andersson@linaro.org, baohua@kernel.org
Cc:     linux-arm-kernel@lists.infradead.org, baolin.wang7@gmail.com,
        linux-remoteproc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH RESEND 0/3] Some improvements for SIRF hwspinlock
Date:   Wed,  8 Jan 2020 11:23:43 +0800
Message-Id: <cover.1578453662.git.baolin.wang7@gmail.com>
X-Mailer: git-send-email 1.7.9.5
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch set did some improvements for the SIRF hwspinlock driver,
including changing to use devm_xxx APIs and removing some redundant
pm runtime functions.

Baolin Wang (3):
  hwspinlock: sirf: Change to use devm_platform_ioremap_resource()
  hwspinlock: sirf: Remove redundant PM runtime functions
  hwspinlock: sirf: Use devm_hwspin_lock_register() to register hwlock
    controller

 drivers/hwspinlock/sirf_hwspinlock.c |   46 ++++++----------------------------
 1 file changed, 7 insertions(+), 39 deletions(-)

-- 
1.7.9.5

