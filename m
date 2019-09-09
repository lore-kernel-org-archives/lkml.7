Return-Path: <SRS0=hqT0=XE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6759CC433EF
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Sep 2019 07:32:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3716B21A4A
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Sep 2019 07:32:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="HKRj88wL"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388180AbfIIHcD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 9 Sep 2019 03:32:03 -0400
Received: from mail-wm1-f66.google.com ([209.85.128.66]:35752 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732347AbfIIHcD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Sep 2019 03:32:03 -0400
Received: by mail-wm1-f66.google.com with SMTP id n10so13356555wmj.0
        for <linux-kernel@vger.kernel.org>; Mon, 09 Sep 2019 00:32:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=B1DB8hLBI0DfoqSgN7BPkx2C4LPQLRBtlT6+2pkAJhs=;
        b=HKRj88wLIuKKvMVrlcCv44LZGStlBJSMMWn4leonTHif3dSsI6XAAv+OM86+GCrN1v
         /hOaBr4dA9agJJsMN2NYIiBjmsuYpTNf+QT52+rpd974601QbtgJW3WkeenkfG758vHI
         8ZxT/x+F2of1EhU+ByWFVGSyy1wTh1hM88FeSE1dPOx5hCgQYmVMy2M94iciqXojaTmL
         3VOUCnsFbF9Ancywa6eTxH/S//UOOLO/4AZLR5wRM1KS4iGmDekWn9sLA1XZwuc5p3s5
         QmPtliwpPqY1PJaqx6n0mXBW58VfnEJe87NWLZ/rah0/r1Rte+oSMwZzDYGlc18n3Dpp
         7wUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=B1DB8hLBI0DfoqSgN7BPkx2C4LPQLRBtlT6+2pkAJhs=;
        b=LjwXsrRCEEwv0xvQ6r/2pNiJaXobwAhuy7N51JRXjzAziHairLt15yDvcx0ZmITUvN
         9iKR5EWxLqa/ZgQ85VfyeGQb1JxbXNBXLm0z7eyURVssCmfo7uCEogid/TC2BWtWUZou
         7UW4h9XE2ddsBTALwyBT5o09MDLs6/T4tdprjzCF718lww5I61jwtZih9QVl7dKpnFIS
         wnplFWUu56Jo7O7yTgQ30fR4e+4LPyto4kZ+ioECMwSXYVTpwMs+JV6bGQIVTf+0Pmnf
         zuyG8CRunl3nCCGUv8Pj8TFub+OivvkrrJwTWUisJdFSxDGtq90S7NINCNt1m85dCMRQ
         EAGA==
X-Gm-Message-State: APjAAAX4VdeoGezYLb2kLof91xKOwt1XgLvv4QgiWykBeSAoqUozCU6q
        vN7LKlNtiKvxWvDwYUzJvlrF2g==
X-Google-Smtp-Source: APXvYqzv1j7KdbWHRbYvFmEQmw0sUCnWSiYEhKtrI2a3yeQ+7I2WDIr3T9Q1zYOP3/YMvnPk/YV7DA==
X-Received: by 2002:a1c:7f4f:: with SMTP id a76mr11413619wmd.117.1568014320844;
        Mon, 09 Sep 2019 00:32:00 -0700 (PDT)
Received: from localhost.localdomain (146-241-7-242.dyn.eolo.it. [146.241.7.242])
        by smtp.gmail.com with ESMTPSA id c8sm617012wrr.49.2019.09.09.00.31.59
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 09 Sep 2019 00:32:00 -0700 (PDT)
From:   Paolo Valente <paolo.valente@linaro.org>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        ulf.hansson@linaro.org, linus.walleij@linaro.org,
        bfq-iosched@googlegroups.com, oleksandr@natalenko.name,
        Tejun Heo <tj@kernel.org>, cgroups@vger.kernel.org,
        Paolo Valente <paolo.valente@linaro.org>
Subject: [PATCH 0/1] block, bfq: remove bfq prefix from cgroups filenames
Date:   Mon,  9 Sep 2019 09:31:16 +0200
Message-Id: <20190909073117.20625-1-paolo.valente@linaro.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jens,
now that BFQ's weight interface has been fixed [1], can we proceed
with this change?

In addition to acking this solution, in [2] Tejun already suggested a
reduced version of the present patch. In Tejun's version, only
bfq.weight is changed. But I guess that legacy code may use also some
of the other bfq parameters in cgroups, without the bfq prefix. Apart
from that, any version is ok for me, provided that it solves the
current confusing situation for userspace [3].

Thanks,
Paolo

[1] https://lkml.org/lkml/2019/8/27/1716
[2] https://www.mail-archive.com/linux-block@vger.kernel.org/msg35823.html
[3] https://github.com/systemd/systemd/issues/7057

Angelo Ruocco (1):
  block, bfq: delete "bfq" prefix from cgroup filenames

 block/bfq-cgroup.c | 46 +++++++++++++++++++++++-----------------------
 1 file changed, 23 insertions(+), 23 deletions(-)

--
2.20.1
