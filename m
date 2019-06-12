Return-Path: <SRS0=n7Fw=UL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DE253C31E46
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Jun 2019 13:58:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B025A20B1F
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Jun 2019 13:58:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nikanor-nu.20150623.gappssmtp.com header.i=@nikanor-nu.20150623.gappssmtp.com header.b="tZDCsWFo"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2437191AbfFLN6s (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Jun 2019 09:58:48 -0400
Received: from mail-lf1-f67.google.com ([209.85.167.67]:33066 "EHLO
        mail-lf1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2437126AbfFLN6s (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Jun 2019 09:58:48 -0400
Received: by mail-lf1-f67.google.com with SMTP id y17so12206261lfe.0
        for <linux-kernel@vger.kernel.org>; Wed, 12 Jun 2019 06:58:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=nikanor-nu.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=df7h8XbfBjQ7PT3PnDdcy3ikJ1Yz667tuld2uk1NxPc=;
        b=tZDCsWFoxx/9s8Pjlf4oWRhkFr+Ab/cFt9QZKV4C0IA1K7KtM/MLM+Rz0Cbla/y116
         bFcnPumnaW5ZKF6lji8/jrzUMuzXcCSRx3TI7MQstdnNwI5ryGsVmfQI414A0WUjyzjF
         DX+/NfVQu982noklSvGeB17UFoQcPS8Low2EQWoHtXzXuthe/lq6kwB7ZAcywX3RFz9u
         lseBKVtE1ZjFQoi9OS3dRVDWir139Ncj73p0YExgZd2bLfZnLUM3whdoobAe490RNw9u
         EkMNPrbpolWWie4GMMuNY5GR3onvu6FuK1VCiT8s6aT7f/Ls3ZRxXA/HuLlT48caGBVE
         Vk1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=df7h8XbfBjQ7PT3PnDdcy3ikJ1Yz667tuld2uk1NxPc=;
        b=bVtCGQ0YL8sy7BwyCfXu8i4IxntPZJMj5azKINUwYd0x1T90lkd9I1qCIXVQ7Olglj
         6DP9SIOdYTfBwoIS6fFVElp9s0umA7ugv2c3zU99zmhsJDQ/wFtcne+n5uzZwFCWTT7X
         JFqRulbT/VQBunCUlQqQzup8faJqhs+ujdpsObYLl12oRCdNW66TV59+KqUkHSWA8U7G
         nGCBeHyM+B/q+rEXxbpSsf7JMQiKOH8QGHYiPp27stu9Ld0Id+ID8c2W03uSJVRVnOaI
         wkKjmd7Hcs833wqNLfBC0DXNvEMyMZvgNY1Nc6soW/OvNBfoHB+8Ua2It7IeNbvSv6ll
         myEA==
X-Gm-Message-State: APjAAAWiI/HNKEahgLy519ye5UF0WeEcTjY4Pews5XBHJkL6D4zarUzc
        vf3Ngh8H1ToC3h7bOAin1GvKlg==
X-Google-Smtp-Source: APXvYqwFPBhjcJcSHHMP7YRorWH1Ods0kRvh+DZaB1OW4q7ldZF83QIKr1lUqXvhpRf/g6Rgh2fgpQ==
X-Received: by 2002:a19:e619:: with SMTP id d25mr41854421lfh.34.1560347926118;
        Wed, 12 Jun 2019 06:58:46 -0700 (PDT)
Received: from dev.nikanor.nu (78-72-133-4-no161.tbcn.telia.com. [78.72.133.4])
        by smtp.gmail.com with ESMTPSA id x194sm2621999lfa.64.2019.06.12.06.58.45
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Wed, 12 Jun 2019 06:58:45 -0700 (PDT)
From:   =?UTF-8?q?Simon=20Sandstr=C3=B6m?= <simon@nikanor.nu>
To:     gregkh@linuxfoundation.org
Cc:     simon@nikanor.nu, dan.carpenter@oracle.com,
        devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 0/2] staging: kpc2000: minor fixes in kp2000_pcie_probe
Date:   Wed, 12 Jun 2019 15:58:34 +0200
Message-Id: <20190612135836.23009-1-simon@nikanor.nu>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190610200535.31820-1-simon@nikanor.nu>
References: <20190610200535.31820-1-simon@nikanor.nu>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

These two patches fixes issues pointed out by Dan in a previous
staging/kpc2000 patch thread: many comments in kp2000_pcie_probe just
repeats the code and the current label names doesn't add any information
and makes it hard to follow the code.

Rename all labels and remove the comments that just repeats the code.

Version 2:
 - Don't convert C style comments to C++ style

Simon Sandström (2):
  staging: kpc2000: improve label names in kp2000_pcie_probe
  staging: kpc2000: remove unnecessary comments in kp2000_pcie_probe

 drivers/staging/kpc2000/kpc2000/core.c | 80 ++++++++------------------
 1 file changed, 25 insertions(+), 55 deletions(-)

-- 
2.20.1

