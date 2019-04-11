Return-Path: <SRS0=BPXs=SN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 487EDC10F14
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Apr 2019 08:45:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 099832082E
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Apr 2019 08:45:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="eodPEEfg"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726964AbfDKIpl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 11 Apr 2019 04:45:41 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:36969 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726607AbfDKIpl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Apr 2019 04:45:41 -0400
Received: by mail-wr1-f65.google.com with SMTP id w10so6197346wrm.4
        for <linux-kernel@vger.kernel.org>; Thu, 11 Apr 2019 01:45:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:subject:date:message-id;
        bh=+8KV1rYOptyfogTlAgW1rSp2oGnqn2LH/HebVU6g4OY=;
        b=eodPEEfgGiM5Yns5TWxodKnukbFnK+yjnMpL327eI1HCD6REyONMTrmgUGTYoyb5vB
         L0o1khBew4M940ti80SA93Qp3gjMceiQno/8zSOHozcsMX+EbJaqlo7fteOniity29xa
         aelm3q7WE+MgyPW6SKodaONlC450SG3ntWyZV1RYIu3RCidWuFClHHCCf//pLu184aCW
         Ej5Vz31ZbVg6C/AmiLherWXuihf0AmF1DDF67znsMZaVUJK4Ji+oQP0SLk1IOWBZKkeO
         y8y2AzZp8ONvOVAlRgDA9xQcJWsmbQmocgwHWCEamka+oYDOzCKhDv4z542m0/uX+mHs
         P++w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id;
        bh=+8KV1rYOptyfogTlAgW1rSp2oGnqn2LH/HebVU6g4OY=;
        b=G/3fnRsDvbxlbCf9Ttv2/JHiwbH1vXAqAEqVq7ZM5r/gV/Uq1/HEbBM7usbt0EuTht
         Yj7ppfHxmANvDUursOFkFsAowidPk8gGVY7jX1W+DkjSpUYNQH2FGXUpWu8BQ9KF8bSn
         KulZ06Xo2Fs2+21w+mPvfBC7/cUow1pKxsBmV8BwGSWOZ2jwUbW8EWj+rEvf39v+Xltl
         8OC+MUo4mewSVHTw33ECoxYd5eIa7jxEoi70WhWxbslqNodTtbBhN52xq5x3iAe2gqiK
         qs4AgjNTZwrUVMMhVjnEfKrsFN31iIfKhoGbxtYSRHX+IzD2y5tuA+2w7c0apf4BAoHK
         JciQ==
X-Gm-Message-State: APjAAAVB6bXV9MTCvvaPiLV6d5NflvB3ZvzDOqLOsrkIktyZl5lVI93e
        +Rk/XG8nFDRRSHIPMDVyn4rojQ==
X-Google-Smtp-Source: APXvYqwFPnGbM15P/fHGakMx0heW6tW0fam1knMzXhOVTLTlgzFAac4PWrVhbHJAFpKUdEcCGpImaA==
X-Received: by 2002:adf:e288:: with SMTP id v8mr24708101wri.7.1554972339567;
        Thu, 11 Apr 2019 01:45:39 -0700 (PDT)
Received: from glaroque-ThinkPad-T480.baylibre.local (lmontsouris-657-1-212-31.w90-63.abo.wanadoo.fr. [90.63.244.31])
        by smtp.gmail.com with ESMTPSA id 7sm128602876wrc.81.2019.04.11.01.45.38
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 11 Apr 2019 01:45:38 -0700 (PDT)
From:   Guillaume La Roque <glaroque@baylibre.com>
To:     jbrunet@baylibre.com, narmstrong@baylibre.com,
        khilman@baylibre.com, linux-amlogic@lists.infradead.org,
        linux-clk@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
Subject: [PATCH 0/2] Add support of Temperature sensor Clock for G12 SoC
Date:   Thu, 11 Apr 2019 10:45:35 +0200
Message-Id: <20190411084537.30299-1-glaroque@baylibre.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch series add support of Clock for temperature sensor
on Amlogic G12a SoC.

Guillaume

Guillaume La Roque (2):
  dt-bindings: clk: g12a-clkc: add Temperature Sensor clock ID
  clk: meson-g12a: Add Temperature Sensor clock

 drivers/clk/meson/g12a.c              | 31 +++++++++++++++++++++++++++
 drivers/clk/meson/g12a.h              |  3 ++-
 include/dt-bindings/clock/g12a-clkc.h |  1 +
 3 files changed, 34 insertions(+), 1 deletion(-)

-- 
2.17.1

