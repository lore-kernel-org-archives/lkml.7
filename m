Return-Path: <SRS0=Iet2=Z5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0F252C43603
	for <linux-kernel@archiver.kernel.org>; Sat,  7 Dec 2019 21:42:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BCA582082E
	for <linux-kernel@archiver.kernel.org>; Sat,  7 Dec 2019 21:42:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kudzu-us.20150623.gappssmtp.com header.i=@kudzu-us.20150623.gappssmtp.com header.b="ufHC+NWg"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726469AbfLGVmq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 7 Dec 2019 16:42:46 -0500
Received: from mail-qt1-f172.google.com ([209.85.160.172]:41329 "EHLO
        mail-qt1-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726378AbfLGVmp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 7 Dec 2019 16:42:45 -0500
Received: by mail-qt1-f172.google.com with SMTP id v2so11159585qtv.8
        for <linux-kernel@vger.kernel.org>; Sat, 07 Dec 2019 13:42:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kudzu-us.20150623.gappssmtp.com; s=20150623;
        h=from:date:to:cc:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=/FNfGO9/5GkHxo/iV/FuELwfPIwUxQkTsttLHMUCdbo=;
        b=ufHC+NWgPQcA2g/btN2kB+PByWguxVleFvIZiUlRmw6GIP22cFeN3c+aU2oVmCvogt
         imkdcDZovBQlApzt7H9lN1OyPJijxLcqAK54c+hMuNeUK5c60WBaJsAvD8U9KYGOt+k9
         1xBFKq3TuudPtaI3TSnZVnfhS6YmEzMddwFEVDWQBWEEVwbP3AJfZTFWcCMfnVf+git5
         sjnpB/chpcXxgdxng2zrvAd3G+da2BdREARkN5FdsoyPYEaQ6RJijuGg0dL7d9qbkUjo
         zz2BDmYzqljc+I9RXlvRz/bmwpBK7dS9ii8k60Y5cRfzc0EkgM/AceY1S1ZhtWmJcQsJ
         4mBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=/FNfGO9/5GkHxo/iV/FuELwfPIwUxQkTsttLHMUCdbo=;
        b=b240cLvZaMlG9xwvFfAiTmbmCp7qsSJQ1saA/tgeYDbEk9GNTkMu8fouUzoL4FA+ms
         liJ5R2lvf3n85XMMioHcE276VbKrbUCORSrVri5jMiG5scKf3nTi7UMBH4WNMLF7vkXm
         gPE+QHzLUE9UHzPuK/32whCk48Cqor7aLtrscIaQZRqA/UPrcYTnmu9q36dQHSBhVfCG
         zaRj/wpoWtlY4vnyfe7ZLHqRdQxmHHlyW2EOjQnsf5LU3/YOb8v/JQZx6aMED9t4V5pk
         E95/UxOM9/rfktXKIRr3t/wyi3jMRqrzspJlCMaqRACgPbxr6vlou+mMPWuBz/f4Uz2k
         /41A==
X-Gm-Message-State: APjAAAWF5uzt6waO5E2Ee0czHMS+Jas8Ar9UNjn2D26YwodDlafHOQ9q
        iKYnd1VnWeAAWOl6T6voEObUsw==
X-Google-Smtp-Source: APXvYqyqWbVZVl3ZatBZIJBHPtw4zSg1SbABppPAlSfIsIWgizMI+kTg54QHwvQhw/DRuvWTnSOZjQ==
X-Received: by 2002:aed:376a:: with SMTP id i97mr19224853qtb.44.1575754964477;
        Sat, 07 Dec 2019 13:42:44 -0800 (PST)
Received: from graymalkin ([2605:a601:a609:c200:eb24:d1e6:7c8f:65d0])
        by smtp.gmail.com with ESMTPSA id m6sm7368023qke.80.2019.12.07.13.42.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 07 Dec 2019 13:42:44 -0800 (PST)
From:   Jon Mason <jdmason@kudzu.us>
X-Google-Original-From: Jon Mason <jdm@graymalkin>
Received: by graymalkin (sSMTP sendmail emulation); Sat, 07 Dec 2019 16:42:42 -0500
Date:   Sat, 7 Dec 2019 16:42:42 -0500
To:     torvalds@linux-foundation.org
Cc:     linux-kernel@vger.kernel.org, linux-ntb@googlegroups.com
Subject: [GIT PULL] NTB patches for v5.5
Message-ID: <20191207214242.GA22441@graymalkin>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Linus,
Here is the NTB pull request for v5.5.  It only contains a simple patch to add a new NTB Device ID.  Please consider pulling it.

Thanks,
Jon



The following changes since commit 54ecb8f7028c5eb3d740bb82b0f1d90f2df63c5c:

  Linux 5.4-rc1 (2019-09-30 10:35:40 -0700)

are available in the Git repository at:

  git://github.com/jonmason/ntb tags/ntb-5.5

for you to fetch changes up to 9b5b99a89f641555d9d00452afb0a8aea4471eba:

  NTB: Add Hygon Device ID (2019-12-07 16:29:44 -0500)

----------------------------------------------------------------
Add Hygon Device ID to the AMD NTB device driver

----------------------------------------------------------------
Jiasen Lin (1):
      NTB: Add Hygon Device ID

 drivers/ntb/hw/amd/ntb_hw_amd.c | 1 +
 1 file changed, 1 insertion(+)
