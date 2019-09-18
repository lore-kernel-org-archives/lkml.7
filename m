Return-Path: <SRS0=HfRD=XN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D3CB2C4CEC4
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Sep 2019 17:19:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A895721924
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Sep 2019 17:19:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="bn4andAX"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732215AbfIRRTw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 18 Sep 2019 13:19:52 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:45312 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731759AbfIRRTW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Sep 2019 13:19:22 -0400
Received: by mail-pf1-f196.google.com with SMTP id y72so387995pfb.12
        for <linux-kernel@vger.kernel.org>; Wed, 18 Sep 2019 10:19:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=bRO4CCi6O02IiQvOc11mCJZTaWPh+1gIDXkPeGZg2yU=;
        b=bn4andAXlapruN28brXgH2AM8ReanDolwH7WcQgBc8GyiIvksNsmBbbHU+5j5QkmkQ
         dNQdBRugV0VibxQmM9NcBdxXs6X/DbEnHxcN9Nx09qVwwwO/LxHop3kOqVHYd99IcQzB
         bQMgViSIuf4qNELiCIajF6lozazm2IeSQdwwJYHNXX5Mztwm9UY+f1XEONWam8nPuq8K
         eefbviSYxfXdXkEAjmgOtgbPBKlZWbWRGwyE62QPJhzOZojvHnDqOUB+c6XtFB0fwaiM
         1XqOChqRHMdJfgk3iQAI9T33ur0YmWvt3TXXSyzWkf/x5iXX0ETXfj/dms0i2Oj0KxUD
         c4Kg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=bRO4CCi6O02IiQvOc11mCJZTaWPh+1gIDXkPeGZg2yU=;
        b=AcSSgajZ1ub2CsZZP+txUL5YmJSbrOoLvaQfR+37NRXnaFtdRK9Y5DTsO1ILwdcoO9
         Z7G7VKdJ1ZNMTwiJ6wLJ1MOYdxaeiennyhXPMQaosgeTrxi8EcQ5qYvaj7aZ6VixEnP6
         mp7RPRg2JYYLStBBM7JfY77s38H7CeT0TC2ELOb+lpMICV4JOMTcOiqWfEmgVsu7HLmc
         gEzG2vxGT4Ff5PvLzyzwN5FaCuAx8bEWrx/EnLLitRSzCd7CgeALSd/0y78gC/XLPcBW
         0vq6vutFNSLzYBBjSRx49V5tp8HojLe8kTpgGBe55NysU5WCtX9/WYh6vWgZA8BFun5K
         b2Og==
X-Gm-Message-State: APjAAAVpbtd24yQHxmZ5nFoBlwWHsbtFHtBe9l0Yu4/7Gml3ukIHoezk
        ugNWO5zTzZ6pUa9GFe8gzHZ4ma0yqMw=
X-Google-Smtp-Source: APXvYqyPk20iR8I62eO+samk866W6GDYk7anz2Mi1dRwIdNGKY38wrQ6lsz0CSIlroam2w1NoQuQQw==
X-Received: by 2002:a63:791:: with SMTP id 139mr4554810pgh.199.1568827159819;
        Wed, 18 Sep 2019 10:19:19 -0700 (PDT)
Received: from localhost.localdomain (104-188-17-28.lightspeed.sndgca.sbcglobal.net. [104.188.17.28])
        by smtp.gmail.com with ESMTPSA id y4sm2614981pjn.19.2019.09.18.10.19.18
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 18 Sep 2019 10:19:19 -0700 (PDT)
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Ohad Ben-Cohen <ohad@wizery.com>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Jorge Ramirez <jorge.ramirez-ortiz@linaro.org>
Cc:     linux-arm-msm@vger.kernel.org, linux-remoteproc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 0/6] rpmsg: glink stability fixes
Date:   Wed, 18 Sep 2019 10:19:10 -0700
Message-Id: <20190918171916.4039-1-bjorn.andersson@linaro.org>
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

 drivers/rpmsg/qcom_glink_native.c | 50 ++++++++++++++++++++++++++-----
 1 file changed, 42 insertions(+), 8 deletions(-)

-- 
2.18.0

