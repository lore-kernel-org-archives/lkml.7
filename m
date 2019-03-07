Return-Path: <SRS0=uyI7=RK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E6A61C43381
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Mar 2019 10:13:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B16FD20657
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Mar 2019 10:13:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="VMHGJoq0"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726414AbfCGKNR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 Mar 2019 05:13:17 -0500
Received: from mail-wr1-f66.google.com ([209.85.221.66]:45242 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726131AbfCGKNQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Mar 2019 05:13:16 -0500
Received: by mail-wr1-f66.google.com with SMTP id w17so16702442wrn.12
        for <linux-kernel@vger.kernel.org>; Thu, 07 Mar 2019 02:13:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=h9oyxbKLLsDgXrgTZ5qA4OFRGf/4wYDDRwPAd4FuZ+g=;
        b=VMHGJoq07WP78bMJvCWKAhE4hHWh1bUQpjV0tlEsOQbaRwdl7Sg+12IztDU3A2eJGM
         ejQbLnS1MkNWJlxJvj6FATxVCvkMALVwTK4R5KrHzR9TOLtIKHtz7fO+M09BPWZEFMI9
         p8UK1DV+Z+c6RdF4GuwjcmLbxp3NIdt8ZBte0Yplko62NmuVDuth4eghjsfFglaW+7lC
         5DcECVZSkmHtdX8IErpJLnqqotwzK9wozWmROuLB2NM1ZFpLaqU4QbeJreF7iYZ54kv5
         45yNOvtSry69mafLnCH0TtDSh6yxa1d3fgEndVNDZ7W1lMjdzEsbbGAkK6UEgRqLgF8Z
         vIrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=h9oyxbKLLsDgXrgTZ5qA4OFRGf/4wYDDRwPAd4FuZ+g=;
        b=mrdB+4Y2t+UqkOGh5YeGSAAz7ueYZN7bZnjRvpvr/mVy9YiOSb8gIHm/dNntJDDIyD
         7EzWFYlcqFq5qI6iWSY7NhElU3HCTnK/EAXhwv6HuAjBOWfjSzW3x1FDmeWLfsfhWDdT
         Tuf89QDZJfboTxH35fq4SbDtmTEu54/TbPJlpWo6VAdR2YH5sFwvd22Ud9XUXM23yFqc
         Uafkn3THGYN8zKAAmfqGwM4G2zN2SnZFqZX9kbCn5jYoZapBR/lbmHylDJrwJ5UD2hRN
         DJuSgfHqrASL85+Ls37aEJbMaeboTvB1xWdM/Ahz/TImgsRkk7QRWUg2tgBPdbRAzKBA
         K82w==
X-Gm-Message-State: APjAAAWP5fOG5ZE67YDI3yhGkcfuCcUM7/sdV5PgroBsmraLsZ1vu9+m
        RwT8JLtF/H0GAs5dCRlmPVKq5A==
X-Google-Smtp-Source: APXvYqw+IXmrpPWAjHlQ2+QB+MR/aXNEDIX+JW5HgIPzbhlojAVAUIgkSgSdhhneKOHvkBLKTfSszQ==
X-Received: by 2002:a5d:5544:: with SMTP id g4mr6110453wrw.269.1551953594544;
        Thu, 07 Mar 2019 02:13:14 -0800 (PST)
Received: from srini-hackbox.lan (cpc89974-aztw32-2-0-cust43.18-1.cable.virginm.net. [86.30.250.44])
        by smtp.gmail.com with ESMTPSA id n9sm3529767wmi.33.2019.03.07.02.13.13
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 07 Mar 2019 02:13:14 -0800 (PST)
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
To:     gregkh@linuxfoundation.org, arnd@arndb.de
Cc:     linux-kernel@vger.kernel.org, bjorn.andersson@linaro.org,
        bkumar@qti.qualcomm.com, linux-arm-msm@vger.kernel.org,
        ktadakam@qti.qualcomm.com,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: [PATCH 0/8] misc: fastrpc: few fixes
Date:   Thu,  7 Mar 2019 10:12:21 +0000
Message-Id: <20190307101229.7856-1-srinivas.kandagatla@linaro.org>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Greg, 

Doing some stress testing and Neural Processing library showed up some bugs
in the code, this patchset fix them.

Thanks to Bharath and Krish for testing and helping me debug the issues.

Thanks,
srini


Srinivas Kandagatla (6):
  misc: fastrpc: make sure memory read and writes are visible
  misc: fastrpc: use correct spinlock variant
  misc: fastrpc: consider address offset before sending to DSP
  misc: fastrpc: take into account of overlapping buffers
  misc: fastrpc: fix remote page size calculation
  misc: fastrpc: increase max init file size to 64 MB

Thierry Escande (2):
  misc: fastrpc: Avoid free of DMA buffer in interrupt context
  misc: fastrpc: Fix a possible double free

 drivers/misc/fastrpc.c | 235 ++++++++++++++++++++++++++++++++---------
 1 file changed, 187 insertions(+), 48 deletions(-)

-- 
2.21.0

