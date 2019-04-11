Return-Path: <SRS0=BPXs=SN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C4D8BC10F13
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Apr 2019 21:50:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7E9B920850
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Apr 2019 21:50:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WIiRIipA"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726923AbfDKVuC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 11 Apr 2019 17:50:02 -0400
Received: from mail-lj1-f194.google.com ([209.85.208.194]:38790 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726847AbfDKVuB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Apr 2019 17:50:01 -0400
Received: by mail-lj1-f194.google.com with SMTP id p14so6941743ljg.5;
        Thu, 11 Apr 2019 14:50:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=QNyK4CTT8ag3XH7RsT6VwTMfAaX2XjunudxJNewmRXc=;
        b=WIiRIipASLtWSeDXBPE/YGRzdFm1I+P9L1/Wj7gumZrw0Q8Dlv0P05ESmsoP0Z4uHu
         7KkrLYVnDZpys4nBXRlokXlqbWsAG60IHKEiXDWXCmAwk/Bw6UmR9y/tz/+emUNOUmat
         OWNaJ5SM8IQOKhG3mKf+MxKiI9gDbalYkeEHaRBIJaLCprpA921V8Eef96frh0V+w6uj
         OIIsNgnE0bAM3/ZPSctAD4yLiFDe0dNKYkkRcwZAaPe31HQRuGpAmomFOd6Gnbo1Uh4I
         hDHD2rjTE8+xTZJjd7JlWoHRV5CSIsiFNSre5lFlCCfmT38aIqjVl045j1TG2WTWDCdf
         uZFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=QNyK4CTT8ag3XH7RsT6VwTMfAaX2XjunudxJNewmRXc=;
        b=HHT8THyEXUD0+uFxUGvQVp888wsk7xMwdervckkanq3Z3Kbo1tagqaSSDOi53V5boM
         bVToSPuaBx7aWtwtevEPGha3pj/Qsbm0mxZ4ppMdzyuW7cAJFcJSKARQVBjOW6Dfz6tX
         OmE6a7Cg5IF7mCyydppJ8q6QCbsN1JnScyrMgUyU/IjZ9VWiwgvvP5+I3ArjN68KnraL
         DyuIYZCiXqMfTGRXOCYn+B5ZECYWjr4BFTSpsaiL9zg1Mfbp1kdbM51Su0MkosrGpPdv
         hW+T4bcFwHphVqSaj2VeOKcVIhvXgognTz3WYmCifwQIERONXnidx3n5EtQT7wGfFnfS
         TLkw==
X-Gm-Message-State: APjAAAUH6H/6HwKSrwZe2qc68XELaNQT7s7RHl1s1t+cixVImd5QBs1N
        TMxj+jx8fr/FsTCodX+USgY=
X-Google-Smtp-Source: APXvYqyQecZtxn6aYZeGKUl50tRKjwn4pmIEjmJERu0raud/r1xg6ig7VMoJ+09xFnq8Vrnnq/hTQA==
X-Received: by 2002:a2e:94c7:: with SMTP id r7mr27836842ljh.91.1555019399506;
        Thu, 11 Apr 2019 14:49:59 -0700 (PDT)
Received: from localhost.localdomain (ppp94-29-35-107.pppoe.spdop.ru. [94.29.35.107])
        by smtp.gmail.com with ESMTPSA id t29sm7819985ljd.82.2019.04.11.14.49.58
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 11 Apr 2019 14:49:58 -0700 (PDT)
From:   Dmitry Osipenko <digetx@gmail.com>
To:     Peter De Schrijver <pdeschrijver@nvidia.com>,
        Prashant Gaikwad <pgaikwad@nvidia.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>
Cc:     linux-clk@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v1 0/2] clk: Tegra124 PLLM fixes
Date:   Fri, 12 Apr 2019 00:48:33 +0300
Message-Id: <20190411214835.19947-1-digetx@gmail.com>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello, here are two trivial patches that are correcting PLLM on Tegra124.
First fixes system lockup due to a bad hardware configuration, second
removes usage of a non-existent register bit.

Dmitry Osipenko (2):
  clk: tegra: Fix PLLM programming on Tegra124+ when PMC overrides
    divider
  clk: tegra124: Remove lock-enable bit from PLLM

 drivers/clk/tegra/clk-pll.c      | 4 ++--
 drivers/clk/tegra/clk-tegra124.c | 3 +--
 2 files changed, 3 insertions(+), 4 deletions(-)

-- 
2.21.0

