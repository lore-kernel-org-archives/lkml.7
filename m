Return-Path: <SRS0=P610=TX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ECA0FC282DD
	for <linux-kernel@archiver.kernel.org>; Thu, 23 May 2019 11:46:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AC28D20851
	for <linux-kernel@archiver.kernel.org>; Thu, 23 May 2019 11:46:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="kBRcan3e"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730444AbfEWLqX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 23 May 2019 07:46:23 -0400
Received: from mail-pl1-f193.google.com ([209.85.214.193]:37537 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729361AbfEWLqX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 May 2019 07:46:23 -0400
Received: by mail-pl1-f193.google.com with SMTP id p15so2666978pll.4
        for <linux-kernel@vger.kernel.org>; Thu, 23 May 2019 04:46:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=wCUem1x/ylV1bJblqN5DyUuj9iRlSTgirM+Nihz6Yc0=;
        b=kBRcan3ex7if0+/zQ6bxlRiznWrjYUd+Ho3MCpSpAJ3oI1kOro4TWWVqTr4YjeoAKQ
         m6ousfyZQWk4f6F4ysIa/GCw5se1GTJWlIALfspm0wUD1QUCHZXLy40cP8cfZ3DsG8VX
         hYFTF+SAT4gQfiK+oF7F+JIEHF0DEotkzap6a2rIfoVmGpS4dyltZJ6/WP67CY1GJjTu
         WxOBsrcRA1jE5vQMuCZnAFTY5P3MKkGvN3AiL+YK++gwzVpeaaY0fo7RzBQJoQWi2RJh
         dts2N4sCqCe/yvCxlveHNdRP/FsbOaqNx5W1AOp2mJ3BEZBZVXFTOkxn8AP5WETImJ8b
         VmkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=wCUem1x/ylV1bJblqN5DyUuj9iRlSTgirM+Nihz6Yc0=;
        b=PgjA5T2NVM/GZQ/Qzk7E3RBzC+n8CrHjQr1143rATdQ1e0IQFASHkooSIFrGi5kXN8
         +r+OyAhM0DR3vsbazbnqQDaeH7H8CAD5jCYND6Z3xF1GhWIWuusrsGt7MGIXzQZStGWT
         r+HdZXSdwqlUS0gSiR/6Hk6Rv+Hr0JFrQu2t50+17GBZKC7Unj6ePMm/210afmm184Re
         hOlfGcfi/kg3D2MPycvwKAWNxh9BTYXouegApbweeENFRkvUziy4V08Aiysw0kIRj6Oq
         efcQFCQDXQDaa4KY8aFes/I5e3lBoLrOstXD0bY8EF09K05Mwa1Cnamx8d1CR2A85z5s
         Vmfg==
X-Gm-Message-State: APjAAAUUWFUMjrPfI4qntdFyUY7rUJjIITmfU6JSCzbU7w0Y+ftSjv6v
        sIaoaCFZFXDCxKHh471wlMmsWxXwgcU=
X-Google-Smtp-Source: APXvYqxVNdT42fnzi2SZEZYBxORLSTPqXLfNElPuLBHxSdMY7xWL/p1mDc4dwYQBFNxX2+n1KhaIwg==
X-Received: by 2002:a17:902:ab98:: with SMTP id f24mr95930813plr.223.1558611982802;
        Thu, 23 May 2019 04:46:22 -0700 (PDT)
Received: from buildserver-90.open-silicon.com ([114.143.65.226])
        by smtp.googlemail.com with ESMTPSA id l43sm565045pjb.7.2019.05.23.04.46.17
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 23 May 2019 04:46:21 -0700 (PDT)
From:   Yash Shah <yash.shah@sifive.com>
To:     davem@davemloft.net, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org,
        devicetree@vger.kernel.org
Cc:     robh+dt@kernel.org, mark.rutland@arm.com,
        nicolas.ferre@microchip.com, palmer@sifive.com,
        aou@eecs.berkeley.edu, ynezz@true.cz, paul.walmsley@sifive.com,
        sachin.ghadi@sifive.com, Yash Shah <yash.shah@sifive.com>
Subject: [PATCH 0/2] net: macb: Add support for SiFive FU540-C000
Date:   Thu, 23 May 2019 17:15:50 +0530
Message-Id: <1558611952-13295-1-git-send-email-yash.shah@sifive.com>
X-Mailer: git-send-email 1.9.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On FU540, the management IP block is tightly coupled with the Cadence
MACB IP block. It manages many of the boundary signals from the MACB IP
This patchset controls the tx_clk input signal to the MACB IP. It
switches between the local TX clock (125MHz) and PHY TX clocks. This
is necessary to toggle between 1Gb and 100/10Mb speeds.

Future patches may add support for monitoring or controlling other IP
boundary signals.

This patchset is mostly based on work done by
Wesley Terpstra <wesley@sifive.com>

This patchset is based on Linux v5.2-rc1 and tested on HiFive Unleashed
board with additional board related patches needed for testing can be
found at dev/yashs/ethernet branch of:
https://github.com/yashshah7/riscv-linux.git

Yash Shah (2):
  net/macb: bindings doc: add sifive fu540-c000 binding
  net: macb: Add support for SiFive FU540-C000

 Documentation/devicetree/bindings/net/macb.txt |   3 +
 drivers/net/ethernet/cadence/macb_main.c       | 118 +++++++++++++++++++++++++
 2 files changed, 121 insertions(+)

-- 
1.9.1

