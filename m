Return-Path: <SRS0=hO5d=UX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 79EBAC43613
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Jun 2019 09:09:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 594C82133F
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Jun 2019 09:09:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728326AbfFXJJo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Jun 2019 05:09:44 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:35448 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728252AbfFXJJn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Jun 2019 05:09:43 -0400
Received: from mail-pl1-f199.google.com ([209.85.214.199])
        by youngberry.canonical.com with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
        (Exim 4.76)
        (envelope-from <kai.heng.feng@canonical.com>)
        id 1hfKyr-00079S-Fb
        for linux-kernel@vger.kernel.org; Mon, 24 Jun 2019 09:09:41 +0000
Received: by mail-pl1-f199.google.com with SMTP id y9so7011989plp.12
        for <linux-kernel@vger.kernel.org>; Mon, 24 Jun 2019 02:09:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:content-transfer-encoding:mime-version
         :subject:message-id:date:cc:to;
        bh=QJC6ineKcWeeajSasIMjIMAW2KBfua6rzVpCvcG7Tos=;
        b=VRk9loNBn1bAqPcIBwrUxLCQehBu31rlb+bj3YpOIt0HPZwyAevMUM/+q36yYGROFa
         XaUmv+geniWcYUgbscO4AGYAUhvT6J31/k2STUQ4SegraAUFvlFHQJAFBt1tU6Wxofr5
         zlpj/mdxxDnuyFhcMdbo9vydtbsbERtmLTRKMlpuFxSSFr+xiqcE+y8q13PUWqBD8V10
         pR/dqjGM0cdXcJ0Bj3h5eAprMDPHwpYSMYyBljqlaWKScIsVAEcZm6pCOR+c0F7It7M4
         mHJrw8ILX/uqBdei8Ra125w+YpDzkMwVC1PD5dMAIIv/dhjreUT3VwsLORr24VWPmaTu
         KEEQ==
X-Gm-Message-State: APjAAAWLPrtC9QgtZRS7EJqpq67cWCgvZk/ghfUkzmujREn3Mfj5Llpd
        l+SqZYqJz/jLoMXDULSz9nsXm5Z0fh+tPX08pfPgqCSsedel9W3ygxs1LHbS1PxdH4xQvMHyaNR
        Sxp6HQMPctIjviBkpvMVGw3u4nvmzViTX1qz09/YL6Q==
X-Received: by 2002:a63:6146:: with SMTP id v67mr26601242pgb.116.1561367380036;
        Mon, 24 Jun 2019 02:09:40 -0700 (PDT)
X-Google-Smtp-Source: APXvYqwUBA29vHrYby9DlI0HUkgkMFFp3ZlV+TTMcwiU5vgOmnXsH6y1N10N6w9VuDG0KK+KnwHL1A==
X-Received: by 2002:a63:6146:: with SMTP id v67mr26601205pgb.116.1561367379553;
        Mon, 24 Jun 2019 02:09:39 -0700 (PDT)
Received: from 2001-b011-380f-3511-4d72-4f7c-d6a5-6121.dynamic-ip6.hinet.net (2001-b011-380f-3511-4d72-4f7c-d6a5-6121.dynamic-ip6.hinet.net. [2001:b011:380f:3511:4d72:4f7c:d6a5:6121])
        by smtp.gmail.com with ESMTPSA id n184sm10261480pfn.21.2019.06.24.02.09.38
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 24 Jun 2019 02:09:39 -0700 (PDT)
From:   Kai-Heng Feng <kai.heng.feng@canonical.com>
Content-Type: text/plain;
        charset=utf-8;
        delsp=yes;
        format=flowed
Content-Transfer-Encoding: 8bit
Mime-Version: 1.0 (Mac OS X Mail 12.4 \(3445.104.11\))
Subject: RX CRC errors on I219-V (6) 8086:15be
Message-Id: <C4036C54-EEEB-47F3-9200-4DD1B22B4280@canonical.com>
Date:   Mon, 24 Jun 2019 17:09:37 +0800
Cc:     Anthony Wong <anthony.wong@canonical.com>,
        intel-wired-lan@lists.osuosl.org,
        linux-kernel <linux-kernel@vger.kernel.org>
To:     jeffrey.t.kirsher@intel.com
X-Mailer: Apple Mail (2.3445.104.11)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jeffrey,

We’ve encountered another issue, which causes multiple CRC errors and  
renders ethernet completely useless, here’s the network stats:

/sys/class/net/eno1/statistics$ grep . *
collisions:0
multicast:95
rx_bytes:1499851
rx_compressed:0
rx_crc_errors:1165
rx_dropped:0
rx_errors:2330
rx_fifo_errors:0
rx_frame_errors:0
rx_length_errors:0
rx_missed_errors:0
rx_nohandler:0
rx_over_errors:0
rx_packets:4789
tx_aborted_errors:0
tx_bytes:864312
tx_carrier_errors:0
tx_compressed:0
tx_dropped:0
tx_errors:0
tx_fifo_errors:0
tx_heartbeat_errors:0
tx_packets:7370
tx_window_errors:0

Same behavior can be observed on both mainline kernel and on your dev-queue  
branch.
OTOH, the same issue can’t be observed on out-of-tree e1000e.

Is there any plan to close the gap between upstream and out-of-tree version?

Kai-Heng
