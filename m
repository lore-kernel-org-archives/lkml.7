Return-Path: <SRS0=g5d9=RD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 06D1FC43381
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Feb 2019 12:32:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CA0E42183F
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Feb 2019 12:32:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="S3W7NN/K"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732510AbfB1Mcr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Feb 2019 07:32:47 -0500
Received: from mail-it1-f181.google.com ([209.85.166.181]:39174 "EHLO
        mail-it1-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726534AbfB1Mcr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Feb 2019 07:32:47 -0500
Received: by mail-it1-f181.google.com with SMTP id l15so15345028iti.4
        for <linux-kernel@vger.kernel.org>; Thu, 28 Feb 2019 04:32:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:from:date:message-id:subject:to:cc;
        bh=ctV3Xipy0cqNktxBB6ikyuqjzf/HR3oFkDOEhdVvbhs=;
        b=S3W7NN/Kivz0ilHlNRotsjx9qj4EOdy/tGzYWcH+CHttBlhFtpz/r/GJkE9ozZ0Zbr
         Msrr1SqiWK1ZKP3yP/P+OFSn7P8LVr9acAmoZ413oTQg/kVA6ncr+YlbKfspkYKoKQnm
         xPNxJF2eSMboqz/TBB8ZRyHfmd1+47wIiiN65DrJGNGykfHCYXnvGr/LHu11zGpN5TpV
         kAZSx1WhDv3fHWShI3WYTzYAdxgDBP8DvQbWU0JfhBVO5EvHyI9KPPYy/HNbGGLXFDt9
         e/+NTO25RRPYxhTEOW9XRNhhcX+6qeqnrJM8FGoglEQaVD9Deh84ObsiJxwN0zOE78ds
         VuGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=ctV3Xipy0cqNktxBB6ikyuqjzf/HR3oFkDOEhdVvbhs=;
        b=sxrKoE3IUzwUXhvbmZMDIwX5BPV7u8r/kZClSoIFPd/+XUlXHcZnjttERJzyHar8bP
         QCML/TVaua8RWJuOC9QZmR/Ew9dhOS4E1KVU+guPBu359qrHi+xLvDPHdZFzWsSeYoMP
         MY2A652AlgCGpyXS8oc4+ciJQNPsHAl3rfx7xdF4jzVJh7fJ8cMyIZHGXkfVHusxoArL
         yO1jSqEef2MeSm9AfEe1h10//38S9qrQ2temS4CokGw6QVSXbKPxEKRepoqh63d+/D1D
         +/H/zQ/A0HNQSYYbVx0vCQMUxnE78m/ghlqpwLOKp0acNWkjX81bfhO+A3miOnBx5J6+
         kHkA==
X-Gm-Message-State: APjAAAVxVPel7L0f8hqoZE1QeB184caAXpfrZw43DCNQicSSwEtWmODq
        wTp3GtinxLRoAWBalUXH8SyyQ1Ez+KDVKsScxCFLTQ==
X-Google-Smtp-Source: AHgI3IYx1mQdYfv+5+yszdzUA/+hs0y7bET17xLJqyaaUnIO9sWRlWFLrfzF1fpzLjZKe1r1s4r5jI8/1LWC2QngE8Y=
X-Received: by 2002:a24:9686:: with SMTP id z128mr2684441itd.97.1551357166036;
 Thu, 28 Feb 2019 04:32:46 -0800 (PST)
MIME-Version: 1.0
From:   Jens Wiklander <jens.wiklander@linaro.org>
Date:   Thu, 28 Feb 2019 13:32:35 +0100
Message-ID: <CAHUa44G17ksP7qcXTeNb_8TXby++=DmSo9FcDUTNsWBVqL7wpA@mail.gmail.com>
Subject: [GIT PULL] tee subsys fixes for v5.0
To:     arm-soc <arm@kernel.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello arm-soc maintainers,

Please pull this last minute fix for the OP-TEE driver.

Thanks,
Jens

The following changes since commit 49a57857aeea06ca831043acbb0fa5e0f50602fd:

  Linux 5.0-rc3 (2019-01-21 13:14:44 +1300)

are available in the Git repository at:

  https://git.linaro.org/people/jens.wiklander/linux-tee.git
tags/tee-fix-for-v5.0

for you to fetch changes up to c7c0d8df0b94a67377555a550b8d66ee2ad2f4ed:

  tee: optee: add missing of_node_put after of_device_is_available
(2019-02-28 10:23:04 +0100)

----------------------------------------------------------------
OP-TEE driver
- add missing of_node_put after of_device_is_available

----------------------------------------------------------------
Julia Lawall (1):
      tee: optee: add missing of_node_put after of_device_is_available

 drivers/tee/optee/core.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)
