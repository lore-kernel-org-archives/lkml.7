Return-Path: <SRS0=bMiL=T7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 72099C28CC0
	for <linux-kernel@archiver.kernel.org>; Fri, 31 May 2019 01:17:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4AE5A26163
	for <linux-kernel@archiver.kernel.org>; Fri, 31 May 2019 01:17:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="AXivDdUX"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726862AbfEaBR6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 May 2019 21:17:58 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:36517 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726741AbfEaBR6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 May 2019 21:17:58 -0400
Received: by mail-pg1-f193.google.com with SMTP id a3so3031366pgb.3
        for <linux-kernel@vger.kernel.org>; Thu, 30 May 2019 18:17:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=lqXIB5VYrvs6jzaa1g5z58dzubUn6chXga4pIoclBMk=;
        b=AXivDdUXnwZ3DRv77pdpJFBVOOGHV1N7WPHdh9KEJTOWB3mZHDRvAnvsgTK02YurLB
         vnM1t3CvOCRY5Bk/K9EAvON7MrmcrcdjRV8WyVkSRwh1QVtmWXEbTPR/LuREG/7IRHNM
         vizi3cLSebt1yXXSvgW3YrJmFYDVya3Pdf0EvelPlIUSvOX9dVqYrvRyiIGXkmqd1CEl
         HtLEqvoVqfMhZrpIx/ReMAgY0822LS5+V6sOYtSSsfN/G2aviSY/y7laA2a/zM20uOwF
         wnBVbIq4UFV22XROuPjXI1gQ20y+6FC1nBDuha4RERDo8jynH7+WXL4Dk6xvNWWmCvmL
         zI6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=lqXIB5VYrvs6jzaa1g5z58dzubUn6chXga4pIoclBMk=;
        b=oz2UeNWXDcS6PK2cHtzLo/Yy0LJ3OlIikhBvUBIFiCSj9T3oKBM6867QmN2XaSGG/S
         tO/Z/Vp7EzDuAHgPit3CYsznQ+LOlxrpx6sIujo13qhavjVe7wiLmOtuWi7NBKJGQ4vt
         z8/VcdpWmHStSzgv29zfQwEyqF+s9lqPKNUhFPUMAtwlraQYeqIGjEhMAyxGOJqhxYp0
         7uvZNwT3mVzv/Yz3YW7XlIUYPC/AT2/2xfwdJnJry0BTrZXRwjuR9m3Q23zaJ9IYl79q
         qahmpqX1WxSwEIxAmucXu71PjYxJA0nWmkgh2krKvfCMEb/d0tkqpwWfuqNBT43w9JY6
         bjgA==
X-Gm-Message-State: APjAAAWK4Vl9gvElXd1OgLnFa+a7gfjMIfB83ToBvy4IguyaKFbAWuDP
        lGhUkFVNz5/q9qiSmjQuSQTG6A==
X-Google-Smtp-Source: APXvYqwhmKCBjnssnPJFBip10hmLkNMYYCUmPPrBrlyQG6qHzxD+sqJ+lptQQWwYUYt4XCmVMKfY/A==
X-Received: by 2002:a63:ed16:: with SMTP id d22mr6374376pgi.35.1559265477220;
        Thu, 30 May 2019 18:17:57 -0700 (PDT)
Received: from localhost.localdomain (104-188-17-28.lightspeed.sndgca.sbcglobal.net. [104.188.17.28])
        by smtp.gmail.com with ESMTPSA id j20sm1819042pff.183.2019.05.30.18.17.56
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 30 May 2019 18:17:56 -0700 (PDT)
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     "David S. Miller" <davem@davemloft.net>
Cc:     Arun Kumar Neelakantam <aneela@codeaurora.org>,
        Chris Lew <clew@codeaurora.org>, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org
Subject: [PATCH v2 0/5] QRTR flow control improvements
Date:   Thu, 30 May 2019 18:17:48 -0700
Message-Id: <20190531011753.11840-1-bjorn.andersson@linaro.org>
X-Mailer: git-send-email 2.18.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In order to prevent overconsumption of resources on the remote side QRTR
implements a flow control mechanism.

Move the handling of the incoming confirm_rx to the receiving process to
ensure incoming flow is controlled. Then implement outgoing flow
control, using the recommended algorithm of counting outstanding
non-confirmed messages and blocking when hitting a limit. The last three
patches refactors the node assignment and port lookup, in order to
remove the worker in the receive path.

Bjorn Andersson (5):
  net: qrtr: Move resume-tx transmission to recvmsg
  net: qrtr: Implement outgoing flow control
  net: qrtr: Migrate node lookup tree to spinlock
  net: qrtr: Make qrtr_port_lookup() use RCU
  net: qrtr: Remove receive worker

 net/qrtr/qrtr.c | 308 +++++++++++++++++++++++++++++++++++++-----------
 1 file changed, 239 insertions(+), 69 deletions(-)

-- 
2.18.0

