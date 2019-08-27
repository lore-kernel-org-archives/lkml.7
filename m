Return-Path: <SRS0=qJmF=WX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BA4DDC3A5A3
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Aug 2019 05:06:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8EE9A2186A
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Aug 2019 05:06:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="ACmTv+sL"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729251AbfH0FGa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 27 Aug 2019 01:06:30 -0400
Received: from mail-pg1-f195.google.com ([209.85.215.195]:35391 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729072AbfH0FG3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Aug 2019 01:06:29 -0400
Received: by mail-pg1-f195.google.com with SMTP id n4so11954834pgv.2
        for <linux-kernel@vger.kernel.org>; Mon, 26 Aug 2019 22:06:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=bk+JaA9Wm7oz2NoF52hCcBz04mg8rRkowz0Je01pv/o=;
        b=ACmTv+sLluHVTa5psjJ02RKShK7i0i9u1wgYGE7mrIr27NYnWxyVpGgxOzII3/NkyE
         dcoF0oVkDA3ndBTXpDNr8h+v5nvKj60M9IB055E6ZLm8qKCtCdTHLKRU7m/4NeGBFukc
         rHO7CjH0RFgBg4lMAavNeYOr7y5MuBhvmKspsGrtop7wf6QqmRhh03Wc39j197QoXCSU
         i3XIUBDvUp73QKxExLUVdEYRU0e6OKJyjQSbc0rRVtpLYQRIjhNxX7u3Ie5e8vh8bkmB
         BGteBb35BoV3Sd1/lVG4AnrWhtD9XuEksL6oFgBBiLn0JRaayRVtCgrnvS5UOQWJ8eI1
         hgpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=bk+JaA9Wm7oz2NoF52hCcBz04mg8rRkowz0Je01pv/o=;
        b=I2gLAD6WK/YTL1phzITOHf2ZGNxLAiUcNv7n/pqTeHeMQNiAI6RbGCsjpWUnJA27VS
         PDzqG6+slqK0WnDLKhMslQ7s+FE87AJ3kHOu85nHIaj4Eq9hyUwr1Mar2munR5zAR/iJ
         RbLL7eXWE3ZPwFsaQsAKFkaYGaNxPX8u99CQeMIfSUzc2lkHm2l7ZKq+VYMovUoJCMiJ
         JoQFNZJDyhV8XHsI9piWT3GYPrXiBZKq09gxbe5oJP31cNTkNd7pYuOwThHRT/eghvKn
         9PUrYcNdRciNNmA9LLsgD9xNb84mUfymWrW61J09jvYf1YTzgh6BG8fmnKDurbewzMwA
         esKg==
X-Gm-Message-State: APjAAAWzrvrWo0mni+iEfiC8CJ4hN6Qumgq79qMc92qDCImrWlQj2+2F
        DlDrcnrsZSJGxRs2T7HFPEZb6Fq7INg=
X-Google-Smtp-Source: APXvYqx2+mfszF4XOEdf2VyJdPl/56BfxhDiG//VfH7sfIzgWmV7i6pR1y1dd5w9xBmLxpAPPz0suA==
X-Received: by 2002:aa7:9e4f:: with SMTP id z15mr23349159pfq.89.1566882389075;
        Mon, 26 Aug 2019 22:06:29 -0700 (PDT)
Received: from buildserver-90.open-silicon.com ([114.143.65.226])
        by smtp.googlemail.com with ESMTPSA id q8sm896414pjq.20.2019.08.26.22.06.24
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 26 Aug 2019 22:06:28 -0700 (PDT)
From:   Yash Shah <yash.shah@sifive.com>
To:     davem@davemloft.net, netdev@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-riscv@lists.infradead.org
Cc:     robh+dt@kernel.org, mark.rutland@arm.com,
        nicolas.ferre@microchip.com, palmer@sifive.com,
        paul.walmsley@sifive.com, ynezz@true.cz, sachin.ghadi@sifive.com,
        Yash Shah <yash.shah@sifive.com>
Subject: [PATCH v2 0/2] Update ethernet compatible string for SiFive FU540
Date:   Tue, 27 Aug 2019 10:36:02 +0530
Message-Id: <1566882364-23891-1-git-send-email-yash.shah@sifive.com>
X-Mailer: git-send-email 1.9.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch series renames the compatible property to a more appropriate
string. The patchset is based on Linux-5.3-rc6 and tested on SiFive
Unleashed board

Change history:
Since v1:
- Dropped PATCH3 because it's already merged
- Change the reference url in the patch descriptions to point to a
  'lore.kernel.org' link instead of 'lkml.org'

Yash Shah (2):
  macb: bindings doc: update sifive fu540-c000 binding
  macb: Update compatibility string for SiFive FU540-C000

 Documentation/devicetree/bindings/net/macb.txt | 4 ++--
 drivers/net/ethernet/cadence/macb_main.c       | 2 +-
 2 files changed, 3 insertions(+), 3 deletions(-)

-- 
1.9.1

