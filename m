Return-Path: <SRS0=Z4g5=TY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3338CC072B5
	for <linux-kernel@archiver.kernel.org>; Fri, 24 May 2019 20:31:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E431A20868
	for <linux-kernel@archiver.kernel.org>; Fri, 24 May 2019 20:31:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nikanor-nu.20150623.gappssmtp.com header.i=@nikanor-nu.20150623.gappssmtp.com header.b="Gdc+4qH/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404208AbfEXUbG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 24 May 2019 16:31:06 -0400
Received: from mail-lj1-f195.google.com ([209.85.208.195]:36632 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2403760AbfEXUbF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 May 2019 16:31:05 -0400
Received: by mail-lj1-f195.google.com with SMTP id z1so4293422ljb.3
        for <linux-kernel@vger.kernel.org>; Fri, 24 May 2019 13:31:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=nikanor-nu.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=2VsBCh+s9KIchLXCnbVZm8l0SmiHYaF8UPE8Xvrj5NA=;
        b=Gdc+4qH/wJAUx2hnZjnMydWPk0n9vEpA2RsMguRl1uTzDCEZlNcaI1siyD0ZRPTvlI
         utVAC01y/J/n/lQF3/oimf4QPC8ujrgEMfiz8IZ0uTjwLjTq0SWj/YhldFZ6IEf4mpQy
         uXHR3WEdHzyYi3reTjt9tW495B1E/sOhVlM/kRtYaHB8KvUVnOERGpCqKkT1X3rVxsB6
         HH09xCgjRG+annGgktI5P11aDkEvzaLi+6TqldK7RMJvAniy9Ju3KHCuYd+mKZ1Dqve9
         F3UwXtMUus/lFoNFRyqT0wmzRhFHgw4V8szKmdXee2X7ZVCm6bD8cyCSeOvE631TvAgz
         X90Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=2VsBCh+s9KIchLXCnbVZm8l0SmiHYaF8UPE8Xvrj5NA=;
        b=TVb+lzuqL2P6HSishQx93aYxRAWscExViXnSQyEUEgsJTMFRIVb1UwPs3GW6g57IE1
         Y20leAV0Cuds2TBl1jozcwdScMODdXtBJRO9vTU/7Yf7Un+VKJGrPHeoB84DDX1Kc2oF
         87k3+mCZzysZhG9ekqir7IUgWFclvVkrxjFTDyJ3FNRGX1m97FjxehfX4ZoUS+hTQzDw
         18zlRRqYVVgWQmOpfLrmev4g3EaycF0uE1cdoX2gfIvw6JYkfyxSlpVhHcEcyVMWntUn
         E7xpBZnRqg/JLKBNQ4gkBgSKRB87eByING/cCkPbgotrquZNyNO6HFYnQMkkYxdjk5ei
         awAA==
X-Gm-Message-State: APjAAAVn5KIC+X4fM5Ioipq2AnGaateteCaa/9azDt2jiQN9RqRTbLOr
        n0jRg+slhHxayHWb8Dykk8eYtQ==
X-Google-Smtp-Source: APXvYqwsq61RAlojvloERPnYyishobLKCAybzkWKMeuy+RobXY7kCc3R8cmKvZ2ZQgSJI5Dz8RZfDQ==
X-Received: by 2002:a2e:9e4d:: with SMTP id g13mr10478905ljk.80.1558729863750;
        Fri, 24 May 2019 13:31:03 -0700 (PDT)
Received: from dev.nikanor.nu (78-72-133-4-no161.tbcn.telia.com. [78.72.133.4])
        by smtp.gmail.com with ESMTPSA id j69sm921036ljb.72.2019.05.24.13.31.02
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 24 May 2019 13:31:03 -0700 (PDT)
From:   =?UTF-8?q?Simon=20Sandstr=C3=B6m?= <simon@nikanor.nu>
To:     gregkh@linuxfoundation.org
Cc:     simon@nikanor.nu, Matt.Sickler@daktronics.com,
        devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org
Subject: [PATCH 0/2] Fixes for staging/kpc2000's Kconfig
Date:   Fri, 24 May 2019 22:30:56 +0200
Message-Id: <20190524203058.30022-1-simon@nikanor.nu>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Here are two patches that fixes issues in kpc2000's Kconfig.

The first one is a typo fix (I'm guessing Kaktronics is a typo...).

The second one is a fix for a dependency issues I met when trying to
build kpc2000 on a default x86_64 config. I'm not familiar with neither
MFD nor UIO, so I'm not sure that I solved it correctly. Maybe there are
some other things to consider as this is in staging?


- Simon

Simon Sandström (2):
  staging: kpc2000: fix typo in Kconfig
  staging: kpc2000: add missing dependencies for kpc2000

 drivers/staging/kpc2000/Kconfig | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

-- 
2.20.1

