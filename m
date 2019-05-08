Return-Path: <SRS0=J8hU=TI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B4AA9C04A6B
	for <linux-kernel@archiver.kernel.org>; Wed,  8 May 2019 07:33:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 835442173C
	for <linux-kernel@archiver.kernel.org>; Wed,  8 May 2019 07:33:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="JAI6ShQF"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727081AbfEHHdi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 8 May 2019 03:33:38 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:43557 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726967AbfEHHdh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 May 2019 03:33:37 -0400
Received: by mail-pg1-f194.google.com with SMTP id t22so9643925pgi.10
        for <linux-kernel@vger.kernel.org>; Wed, 08 May 2019 00:33:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=cXDSUoWLJ80ofU9SNBABTlyG/UyP3q/4EzPOKhLgxHM=;
        b=JAI6ShQFH5LPrZX4xP0iFXDlDAd4VN4ubLGwY2TwHwEtFJ4qd+UKB0kAFNMmlDUy3/
         9k6f03F08QS2BDgt/s4UrtkxIbFJsaLs76mX9jjd5fOIsOuNzAivPbnD08UX7gb3Jgqw
         1ldBY+aY6kti87kHKpHzxW5ZMzbT0SLV3Eitc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=cXDSUoWLJ80ofU9SNBABTlyG/UyP3q/4EzPOKhLgxHM=;
        b=GHCr2U22Yx2KBHWdNYRlbnGqcQmMMF1gv0ZGJQqobn9xb4vZzi1k+Ff8QQtGKIu5ka
         arL687HKJkuOzHd3VN7Bg79wPt+w/Z/s7hIeYaWW/cJ/8NGwLVwaXbhXX7ZLYdP+DuGS
         4ibGLxU1VUS8CDwhpaKVo4cLjhU+B+nBIxefsZDXhOVZgXID5+qa3McNFPUmgNg16Nx8
         mzUQcld3iP7dDqYDxDSf6O6Arll5TyZBYYmhjjilDHMzYfIQicVESQ5SbLxdNHLqtr5e
         v8PSwHV+4j4hJWIXQtHvjvpLIcpspKU9nK14SrqLizZOt8bZJW34kOGRMVlxn/oR/TpL
         geQA==
X-Gm-Message-State: APjAAAUy44IBsY/8+lpqi44G/miREOTSuWW82x0ICUGFZRUlLJNBPUoJ
        RO2UNDm6FYLcDd5pcC/KEBWV0w==
X-Google-Smtp-Source: APXvYqwZZ1j+Kgl5thN1AhwfMfoLsny+ZI4X49uRTCohf76ophHTPd+CXngETV9CgnXsMhUfkhp3zg==
X-Received: by 2002:a62:1897:: with SMTP id 145mr47430119pfy.122.1557300817134;
        Wed, 08 May 2019 00:33:37 -0700 (PDT)
Received: from drinkcat2.tpe.corp.google.com ([2401:fa00:1:b:d8b7:33af:adcb:b648])
        by smtp.gmail.com with ESMTPSA id n26sm29539047pfi.165.2019.05.08.00.33.34
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 08 May 2019 00:33:36 -0700 (PDT)
From:   Nicolas Boichat <drinkcat@chromium.org>
To:     linux-mediatek@lists.infradead.org
Cc:     Sean Wang <sean.wang@kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        linux-gpio@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org,
        Chuanjia Liu <Chuanjia.Liu@mediatek.com>, evgreen@chromium.org,
        swboyd@chromium.org
Subject: [PATCH v2 0/2] pinctrl: mediatek: mt8183: Add support for wake sources
Date:   Wed,  8 May 2019 15:33:29 +0800
Message-Id: <20190508073331.27475-1-drinkcat@chromium.org>
X-Mailer: git-send-email 2.21.0.1020.gf2820cf01a-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This adds support for wake sources in pinctrl-mtk-common-v2, and
pinctrl-mt8183. Without this patch, all interrupts that are left
enabled on suspend act as wake sources (and wake sources without
interrupt enabled do not).

Changes since v1:
 - Move changes from mtk-common-v2 to mtk-pinctrl-paris, as
   recommended by Sean, to keep better separation between eint
   and pinctrl-common features.

Nicolas Boichat (2):
  pinctrl: mediatek: Add pm_ops to pinctrl-paris
  pinctrl: mediatek: mt8183: Add mtk_pinctrl_paris_pm_ops

 drivers/pinctrl/mediatek/pinctrl-mt8183.c |  1 +
 drivers/pinctrl/mediatek/pinctrl-paris.c  | 19 +++++++++++++++++++
 drivers/pinctrl/mediatek/pinctrl-paris.h  |  2 ++
 3 files changed, 22 insertions(+)

-- 
2.21.0.1020.gf2820cf01a-goog

