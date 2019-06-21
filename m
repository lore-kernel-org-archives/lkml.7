Return-Path: <SRS0=s1fu=UU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E96FCC43613
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Jun 2019 06:10:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AF1182089E
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Jun 2019 06:10:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="EdW+NqcL"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726183AbfFUGKo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Jun 2019 02:10:44 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:35629 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726054AbfFUGKo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Jun 2019 02:10:44 -0400
Received: by mail-pf1-f194.google.com with SMTP id d126so3028051pfd.2
        for <linux-kernel@vger.kernel.org>; Thu, 20 Jun 2019 23:10:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=PpljmC8SLGkbR///XDkhntsRZdsmMvo/H3sw/I6A+Yg=;
        b=EdW+NqcLDpoZy6NvRMoxmD74pUzzt5PXYcRlmmEybEXBEoJoGrsC0sjcXC7JteWoAk
         met5tggjZVdSjqyNl03Wc4taU6vT2DYFO1c7gTi3i8P4wSP2BYH15enBj66j9xo0Euok
         3T4PzyrhZ3h8UQPbNBAC3zqAgtXNdCLUWC/ZHSdLt6i9cD9JU+/AhSxSuXsGRH5PfDy/
         /gEw2agtLxkl30fng4hU9XZPPAcEbFuHnAp3M20Ofc4mq95gRNZx6bft69ZB4h/jwgo5
         g79SL6OxLUSTEuqX+wVN1cKgEI+wiGql6VZJ4RA29H3BGQmHfZgM0rHNNFCCR0gbR6Zc
         lxsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=PpljmC8SLGkbR///XDkhntsRZdsmMvo/H3sw/I6A+Yg=;
        b=RmKITFLv7IdCN7j/OXbMZ3quD/U6J+Y7UN0Xq5/QcXQ90y26J/2F/N0PZZ8PfDk7wf
         RlJs0pnFAD5s0/ntUfBj6+w35PZTwgVqd3xSTc0/Cesi4dOtjC1MBTmvie+WDnPvaezm
         F6j8kjlqzrsZKj5QxYXB3kjVtJ2JCxPwxIxdP96Gqp53CQJpwegbbC05wY24Dcm/gv8s
         E7lCPj1XiqNVNf4RL/oLXguIrXUALZle/L1NEfm+1taWnG0KJzqqXYC0nWWQaOMAPZlp
         cHNTNMN888U5+8xWet7Hg20sF9Du6g4jJitGsETN4r7iMuewT08XgiLPcaB1mwxJMKUe
         vyRw==
X-Gm-Message-State: APjAAAU38kl/5KFFPRexFLSuewGnCo3dW1U0ZFTzahzpSahEj/9MuV8z
        D2oFsJi5GvQ63RyioBZL87ceug==
X-Google-Smtp-Source: APXvYqzDsMUW7ZM0Bq051HoAYberjSCM05y0nHuvchc1Fadi0aGQa2Jg5EWR/GbdwYOUinaVk+lXGA==
X-Received: by 2002:a17:90a:2ec1:: with SMTP id h1mr4272423pjs.101.1561097443303;
        Thu, 20 Jun 2019 23:10:43 -0700 (PDT)
Received: from buildserver-90.open-silicon.com ([114.143.65.226])
        by smtp.googlemail.com with ESMTPSA id x17sm1450053pgk.72.2019.06.20.23.10.39
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 20 Jun 2019 23:10:42 -0700 (PDT)
From:   Yash Shah <yash.shah@sifive.com>
To:     robh+dt@kernel.org, paul.walmsley@sifive.com,
        devicetree@vger.kernel.org, linux-riscv@lists.infradead.org,
        linux-kernel@vger.kernel.org
Cc:     mark.rutland@arm.com, palmer@sifive.com, aou@eecs.berkeley.edu,
        sachin.ghadi@sifive.com, Yash Shah <yash.shah@sifive.com>
Subject: [PATCH] DT node for SiFive FU540 Ethernet Controller driver
Date:   Fri, 21 Jun 2019 11:40:21 +0530
Message-Id: <1561097422-25130-1-git-send-email-yash.shah@sifive.com>
X-Mailer: git-send-email 1.9.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch-set is based on 'riscv-for-v5.2/fixes-rc6' tag of
git://git.kernel.org/pub/scm/linux/kernel/git/riscv/linux.git

Tested on HiFive Unleashed board with additional patches required for
testing can be found at dev/yashs/ethernet_dt branch of:
https://github.com/yashshah7/riscv-linux.git

Yash Shah (1):
  riscv: dts: Add DT node for SiFive FU540 Ethernet controller driver

 arch/riscv/boot/dts/sifive/fu540-c000.dtsi | 20 ++++++++++++++++++++
 1 file changed, 20 insertions(+)

-- 
1.9.1

