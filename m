Return-Path: <SRS0=w7sF=2K=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 10FB0C43603
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Dec 2019 02:09:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D7791206CB
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Dec 2019 02:09:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BmSaiBYb"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727328AbfLTCJY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 19 Dec 2019 21:09:24 -0500
Received: from mail-lf1-f68.google.com ([209.85.167.68]:45885 "EHLO
        mail-lf1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726986AbfLTCJY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Dec 2019 21:09:24 -0500
Received: by mail-lf1-f68.google.com with SMTP id 203so5749765lfa.12;
        Thu, 19 Dec 2019 18:09:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=2FZDuRrkg0MK5EazQDFs/JFQpPQ+hrz3+xAe79A8Gjw=;
        b=BmSaiBYbzFkOQhYKOf5zg5oT3Y32bPBAMHURPVOeU/gaJaLwE7ajGHCzIW1kierd/5
         E9qAhcik78M7PLPYAU7/21pU7Ji5R1qCpPwY4qeiMjYtb1079ebdGQ4lKM8r1K34mpnK
         1W0wxvsfw4VueipjO2OMTXU6FzcituocrFtNE4AMk2QKvKZ9vBmILDzY8vH6xatIm0c+
         s+QkHSOc2gfP+qaSBLa1eoBoPDniFRfiikS01YwL3GTdfX+jLvu8/CDPnZGLTdQ2WijT
         8DJiGEd4xL5oOn+TotR8JFLReq/TZY9xr2tWYjODh9y4HbVEIDixojnwt9qVkPtrXiUp
         ceRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=2FZDuRrkg0MK5EazQDFs/JFQpPQ+hrz3+xAe79A8Gjw=;
        b=ohz8l2t6ro9BDBzSBPl85ZtxwGX75q9RXUi44iiHKc6euOEGQnHTNuttrxpYCalA4A
         OtT9w1cwjDyzviD4d4lYKNS7ipW5EE0qC/q1Ze2rIxPdfgezcyHBb3QJHqWg5R+SjtAB
         7wX8dc9mJk150+u8PlShiK4QkiqarzxVrojJIVL/lRo4CJ1+h0hG+0yY/Xn+8yXb49LF
         YFp5zo92xq28tAVPLCXDRd4dZIBbmHCSE6dPN31hsieMbKZ0DbbZsP9WqURbzMC9a5RY
         P+Q+Jomd9gjQDt72ZbxLDdQlV/4hURJfaxcCSeUGSrbCEbbHxeGSepOAdWJHxlBlL7XF
         vSFA==
X-Gm-Message-State: APjAAAXcVx7Tzzt/Ua9PTke31jJ99760ZAYD53Ra661ukEBZn2/O8dbh
        sCj49d29Jg4I0McP2it8ocbISVFL
X-Google-Smtp-Source: APXvYqynhVnf5APG8vMo1x/SfnuVHA71qL6UOqEANdwepcqoDVmwt7YEhHxxzUFrdj8gvmkA0EcfbA==
X-Received: by 2002:ac2:4884:: with SMTP id x4mr7129919lfc.92.1576807761872;
        Thu, 19 Dec 2019 18:09:21 -0800 (PST)
Received: from localhost.localdomain (79-139-233-37.dynamic.spd-mgts.ru. [79.139.233.37])
        by smtp.gmail.com with ESMTPSA id m13sm3279818lfo.40.2019.12.19.18.09.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Dec 2019 18:09:21 -0800 (PST)
From:   Dmitry Osipenko <digetx@gmail.com>
To:     Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>
Cc:     linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 0/3] NVIDIA Tegra30 EMC driver improvements
Date:   Fri, 20 Dec 2019 05:08:46 +0300
Message-Id: <20191220020849.11175-1-digetx@gmail.com>
X-Mailer: git-send-email 2.24.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

I took a refreshed look at the driver's code and spotted few things that
could be improved. No critical fixes here, just improvements. Please
review and apply, thanks in advance!

Changelog:

v2: - Now using WRITE/READ_ONCE() in the "Firm up hardware programming
      sequence" patch for interrupt handler interactions, to firm driver
      even further.

Dmitry Osipenko (3):
  memory: tegra30-emc: Firm up suspend/resume sequence
  memory: tegra30-emc: Firm up hardware programming sequence
  memory: tegra30-emc: Correct error message for timed out auto
    calibration

 drivers/memory/tegra/tegra30-emc.c | 179 +++++++++++++++++------------
 1 file changed, 104 insertions(+), 75 deletions(-)

-- 
2.24.0

