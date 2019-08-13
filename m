Return-Path: <SRS0=Ecng=WJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 698FEC32750
	for <linux-kernel@archiver.kernel.org>; Tue, 13 Aug 2019 14:53:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3E300205F4
	for <linux-kernel@archiver.kernel.org>; Tue, 13 Aug 2019 14:53:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ePZ0JHbr"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729821AbfHMOxt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 13 Aug 2019 10:53:49 -0400
Received: from mail-lf1-f66.google.com ([209.85.167.66]:36001 "EHLO
        mail-lf1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729580AbfHMOxs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Aug 2019 10:53:48 -0400
Received: by mail-lf1-f66.google.com with SMTP id j17so22944913lfp.3
        for <linux-kernel@vger.kernel.org>; Tue, 13 Aug 2019 07:53:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ebrdQpGbryAbE+PVSjTFqlvSSqkSS1ZgUmlnEvCria0=;
        b=ePZ0JHbra+U1kuq1bS8PxUS1CRnF7QVaKlFGUIrgNjPDCu4+CCfrMg478Kb1CtUJH5
         vwdSrpBbXu81gGSt/pIg2vEHaMMOkhg+qpcLnEPCeBtgzNkT5Sw77IW4fkugaERdtQ6k
         gBW79xeVntMdVPqPn+LET9tGnch6A4FieJNKmotqtgIaWkiqCiktVaIjlgkJbLXo3Am1
         UeuWkhbrgOeNuAdaSume6zhNLlQ5n3/wgIU52bR+GtcKp6Bi40tqRsggtqc1+JbrP/gn
         O0bBpACubGme787uuCgKQbTv0V7zSZcmi1+d2rw/QseVTywbyZcdZFKF9mEVvWQK+zHU
         eGoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ebrdQpGbryAbE+PVSjTFqlvSSqkSS1ZgUmlnEvCria0=;
        b=fH8tOHb1Bi/znbcx+K/kpjLVh3E/gtBQYVz/4Gt4hUL/eDFLriWUs4Myg8LddU1pPs
         cisVGhcUru/DD2bZhvRa/TnwVA/oEI6FJF8/u7cjC47DqPP+W3ASUCVDLe+TxFTBE+FS
         VlfymTDy040DMFCF4lOMSuDP3dmGCyfv/T+7/ydWdkktsXLwyVmoAeuONhz6Zj7vWTHX
         k8ii24K1CP+MLz1CfCZUbkMM4HF+inWITYFWBTrYiG1V/1C5audrEEBal9HB1nulkH3J
         HKiqcCWYXQsev38gcAUYwr5nIA+x8lR4GjDpRR3qgEjhnPZ/WV3tJJp3B6EZZggFleSB
         ku1A==
X-Gm-Message-State: APjAAAUk45QKhZ9g8fycKub/c9MU3GkX0/xJPABpXBJ78o89tXuyEAy9
        TmwDpcJ14hhJ7Pn+GjsrVw6bZw==
X-Google-Smtp-Source: APXvYqxGmBjxCMEseACgPnI5Cfymrnnc2nKAKmnZdzJtjplWsZFE5p5T7yf6fHNJ8shzOl5yl71onA==
X-Received: by 2002:ac2:550c:: with SMTP id j12mr18293687lfk.171.1565708026123;
        Tue, 13 Aug 2019 07:53:46 -0700 (PDT)
Received: from localhost.localdomain ([212.45.67.2])
        by smtp.googlemail.com with ESMTPSA id r68sm19628100lff.52.2019.08.13.07.53.44
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 13 Aug 2019 07:53:45 -0700 (PDT)
From:   Georgi Djakov <georgi.djakov@linaro.org>
To:     linux-pm@vger.kernel.org, evgreen@chromium.org
Cc:     daidavid1@codeaurora.org, vincent.guittot@linaro.org,
        bjorn.andersson@linaro.org, amit.kucheria@linaro.org,
        dianders@chromium.org, seansw@qti.qualcomm.com,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-arm-msm@vger.kernel.org, georgi.djakov@linaro.org
Subject: [PATCH v4 0/3] interconnect: Add path tagging support
Date:   Tue, 13 Aug 2019 17:53:38 +0300
Message-Id: <20190813145341.28530-1-georgi.djakov@linaro.org>
X-Mailer: git-send-email 2.22.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SoCs that have multiple coexisting CPUs and DSPs, may have shared
interconnect buses between them. In such cases, each CPU/DSP may have
different bandwidth needs, depending on whether it is active or sleeping.
This means that we have to keep different bandwidth configurations for
the CPU (active/sleep). In such systems, usually there is a way to
communicate and synchronize this information with some firmware or pass
it to another processor responsible for monitoring and switching the
interconnect configurations based on the state of each CPU/DSP.

The above problem can be solved by introducing the path tagging concept,
that allows consumers to optionally attach a tag to each path they use.
This tag is used to differentiate between the aggregated bandwidth values
for each state. The tag is generic and how it's handled is up to the
platform specific interconnect provider drivers.

v4:
- Picked Reviewed-by tags (Thanks Evan!)
- Addressed comments on patch 3.

v3: https://lore.kernel.org/lkml/20190809121325.8138-1-georgi.djakov@linaro.org/
- New patch to add a pre_aggregate() callback.

v2: https://lore.kernel.org/lkml/20190618091724.28232-1-georgi.djakov@linaro.org/
- Store tag with the request. (Evan)
- Reorganize the code to save bandwidth values into buckets and use the
  tag as a bitfield. (Evan)
- Clear the aggregated values after icc_set().

v1: https://lore.kernel.org/lkml/20190208172152.1807-1-georgi.djakov@linaro.org/


David Dai (1):
  interconnect: qcom: Add tagging and wake/sleep support for sdm845

Georgi Djakov (2):
  interconnect: Add support for path tags
  interconnect: Add pre_aggregate() callback

 drivers/interconnect/core.c           |  27 ++++-
 drivers/interconnect/qcom/sdm845.c    | 141 ++++++++++++++++++++------
 include/linux/interconnect-provider.h |   7 +-
 include/linux/interconnect.h          |   5 +
 4 files changed, 145 insertions(+), 35 deletions(-)

