Return-Path: <SRS0=WTd2=XW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0B38CC4360C
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Sep 2019 07:11:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C46D6207FF
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Sep 2019 07:11:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Z+7ixFdy"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726368AbfI0HLM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 27 Sep 2019 03:11:12 -0400
Received: from mail-pl1-f193.google.com ([209.85.214.193]:34857 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725812AbfI0HLL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Sep 2019 03:11:11 -0400
Received: by mail-pl1-f193.google.com with SMTP id y10so713627plp.2
        for <linux-kernel@vger.kernel.org>; Fri, 27 Sep 2019 00:11:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=QRNTfvVyCK5bbHeSG6WJ7G90ba0BRcjEhnvGaZUR3O4=;
        b=Z+7ixFdyDjZdCoa7+16p/WiWMn+KKodd3MLzu1wCZ5xIkH+B+R5rIK0VHDHcL1v+M3
         k55HUqLAHv/FhmSTVDCgI6DJACQn9AoS4wmhcXWd9/QSjQ3x/BSWT9jnKrzlDLez0DAp
         JjM3S4w4Y1upRO5PoxuJ/P68VME6HX4wj7VUz6HlxKrOPMCEf5oLmpAhCqIBL/JZGn3r
         mPQ+aOS202oWHpwI0hGouy7a8PSU90PsmeylYBRwoNKBmkA8x3gOR6eneeo64Qi2hnYE
         S0tgjl96eQgvBK4B0WCQg8NgQHxp/LUvYd6T/cJULd3nZe8bo39xMsmsv6hMyg519gS4
         RA/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=QRNTfvVyCK5bbHeSG6WJ7G90ba0BRcjEhnvGaZUR3O4=;
        b=JQ4M7sHfoHKm9Xkxoa67KnvtYZrBHijDa9dHyZccDnt/0BuwCFOoYtkIA003pAYy7u
         t8P100f6DvAoS0sZ5x+FwdDSGG3W6slkbOffArPrnGnkPBLs+cF/WCuqfgPfAeGcMMWn
         1Yjj9WvDixYYejwmitrUyMwRHLBGuhUHMHoN3eYpWrnwatCsolKe/bsbXlAKQCm+gxrJ
         PvrVr0ZXz1CBn4Oil2h/OXTxU54CeG/veaJdkF92DAqE6fhd2U5kB+KdwSWNNw8ceW1J
         uC/z+ptl9ocugduytDokwexqXwtkxW0OMdUlie8/x4a1yJN/Rktwsb5o2kyuMX+iuRI1
         mopQ==
X-Gm-Message-State: APjAAAU+HJeCQp+Qew57v7ebVvwmdHaiOPxaFJ/E9Lf3Y68+4bMgKbUz
        0BXeHibujJ3oLugjRgpXrImihw==
X-Google-Smtp-Source: APXvYqyqfHUXWwRMV3DOgX6ALCpaD1faiee6ZVSazk+b4FUfUrv2vIQUnJsVq/3monizvbWaexoD5Q==
X-Received: by 2002:a17:902:a613:: with SMTP id u19mr2998244plq.122.1569568271110;
        Fri, 27 Sep 2019 00:11:11 -0700 (PDT)
Received: from baolinwangubtpc.spreadtrum.com ([117.18.48.82])
        by smtp.gmail.com with ESMTPSA id f74sm1733288pfa.34.2019.09.27.00.11.08
        (version=TLS1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 27 Sep 2019 00:11:10 -0700 (PDT)
From:   Baolin Wang <baolin.wang@linaro.org>
To:     ohad@wizery.com, bjorn.andersson@linaro.org
Cc:     orsonzhai@gmail.com, baolin.wang@linaro.org, zhang.lyra@gmail.com,
        linux-remoteproc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 0/4] Some optimization for Spreadtrum hwlock controller
Date:   Fri, 27 Sep 2019 15:10:43 +0800
Message-Id: <cover.1569567749.git.baolin.wang@linaro.org>
X-Mailer: git-send-email 1.7.9.5
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch set did some optimization for Spreadtrum hwlock controller,
including using some devm_xxx APIs to simplify code and validating the
return value when enabling clock.

Baolin Wang (4):
  hwspinlock: sprd: Change to use devm_platform_ioremap_resource()
  hwspinlock: sprd: Check the return value of clk_prepare_enable()
  hwspinlock: sprd: Use devm_add_action_or_reset() for calls to
    clk_disable_unprepare()
  hwspinlock: sprd: Use devm_hwspin_lock_register() to register hwlock
    controller

 drivers/hwspinlock/sprd_hwspinlock.c |   33 ++++++++++++++++++++++-----------
 1 file changed, 22 insertions(+), 11 deletions(-)

-- 
1.7.9.5

