Return-Path: <SRS0=eu/B=UE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,T_DKIMWL_WL_HIGH,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 07DF9C28CC5
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Jun 2019 21:53:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8148F206BB
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Jun 2019 21:53:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1559771634;
	bh=Dm/usv2Lp33uGkK3aDiRre3Dz2r14D+/ly9LsMz6mb8=;
	h=From:To:Cc:Subject:Date:List-ID:From;
	b=gjsyNxj9kemo2/aliBjLqlX4+Y4uwVlFLAhIhuba15onkdkUULhtDlgHJgF5v+U6v
	 Jj0G8cvRX9+wVHQzMsocL8PDMLQIQgMDSy+l+vclSJVm27/fHs50mhzzoos7Qrd27W
	 qd/V7CUN5XvSdIfaPRSise3j//ErxofVK2/oCFWQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726742AbfFEVxx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Jun 2019 17:53:53 -0400
Received: from mail-it1-f196.google.com ([209.85.166.196]:54628 "EHLO
        mail-it1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726502AbfFEVxx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Jun 2019 17:53:53 -0400
Received: by mail-it1-f196.google.com with SMTP id h20so5945240itk.4
        for <linux-kernel@vger.kernel.org>; Wed, 05 Jun 2019 14:53:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=K+r7RaKysQWVK1kSGMptDDC44bF0ZIkuhOXfBK5LAE8=;
        b=W9wQlz4ewzWgIHUvyjdmghjfzs2N93XSM6bBGBSNwyk7szuqaElR9hETXLl5AiPMJ/
         HVMUsJErFNl3toJvO3QnBP70fopnoqjTCFvhqB6H9mBnv8ZfAXzor5U+HT7IiDfx8Si0
         b3PYidfXUcVIi8lUY3FNf0rtvCAWGe7BaT1ss=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=K+r7RaKysQWVK1kSGMptDDC44bF0ZIkuhOXfBK5LAE8=;
        b=KHlOZc55I8kz8MGxJy4ziRmc43oayi5KqUUg4Iz7IpgiqvW1HvcYwf4CFoUxiY94LW
         69G2j0VlaIZ+QUY3DKJaaeR65MZk7ZJTLsLRm4ccOo8tdoQO3nDhe5rjqf6gRvFNQN8x
         U4QUD4FPXokA7PjCg8ZtQLpOCM2BsEffoqTKHn7dDFU2tGHs5SgIjE/F0Ytuoi9dsr/i
         AqD0Jb0Cuntl6Afq6bHY+xZ2z0aC/tJGHCNr7BpPbTAK1bLN6zrfdL/gGSuDzfoLTlkK
         PJGootTnAv37g8vSEXFwuA8VQ2/GTT6IDOImrTzOJWstvGlrsnT1ALQ+Qaji2GdhSxgm
         FKSg==
X-Gm-Message-State: APjAAAWFksOtiqsHOuAJ9pY9VDbPPjAh0KJ6aHU8Ui5rc1UrUOnd6JTt
        Zfzg150PKn+XKd1eE5EaTL0zwg==
X-Google-Smtp-Source: APXvYqxtbeU9CnF1kOfkcBsm2/XWPfxEpuuzggpK+0/Cf1Ern2i+PfGC8ou5qpL8iPjP+HcxjVQrxA==
X-Received: by 2002:a24:2e8c:: with SMTP id i134mr27696135ita.9.1559771632716;
        Wed, 05 Jun 2019 14:53:52 -0700 (PDT)
Received: from shuah-t480s.internal (c-24-9-64-241.hsd1.co.comcast.net. [24.9.64.241])
        by smtp.gmail.com with ESMTPSA id e127sm37484ite.33.2019.06.05.14.53.51
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 05 Jun 2019 14:53:52 -0700 (PDT)
From:   Shuah Khan <skhan@linuxfoundation.org>
To:     mchehab@kernel.org, hverkuil-cisco@xs4all.nl,
        sakari.ailus@linux.intel.com,
        niklas.soderlund+renesas@ragnatech.se, ezequiel@collabora.com,
        paul.kocialkowski@bootlin.com
Cc:     Shuah Khan <skhan@linuxfoundation.org>,
        linux-media@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 0/2] Fixes to cppcheck errors in v4l2-ioctl.c
Date:   Wed,  5 Jun 2019 15:53:46 -0600
Message-Id: <cover.1559764506.git.skhan@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

cppcheck runs on the kernel found a couple of cppcheck errors in
v4l2-ioctl.c. These two patches fix them.

Shuah Khan (2):
  media: v4l2-core: Shifting signed 32-bit value by 31 bits error
  media: v4l2-core: fix uninitialized variable error

 drivers/media/v4l2-core/v4l2-ioctl.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

-- 
2.17.1

