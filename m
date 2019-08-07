Return-Path: <SRS0=/Haq=WD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7FAACC433FF
	for <linux-kernel@archiver.kernel.org>; Wed,  7 Aug 2019 12:50:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5550721BF6
	for <linux-kernel@archiver.kernel.org>; Wed,  7 Aug 2019 12:50:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387884AbfHGMuZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 7 Aug 2019 08:50:25 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:47076 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729712AbfHGMuY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Aug 2019 08:50:24 -0400
Received: from mail-pl1-f197.google.com ([209.85.214.197])
        by youngberry.canonical.com with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
        (Exim 4.76)
        (envelope-from <kai.heng.feng@canonical.com>)
        id 1hvLOY-0007ex-LZ
        for linux-kernel@vger.kernel.org; Wed, 07 Aug 2019 12:50:22 +0000
Received: by mail-pl1-f197.google.com with SMTP id o6so51762000plk.23
        for <linux-kernel@vger.kernel.org>; Wed, 07 Aug 2019 05:50:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:content-transfer-encoding:mime-version
         :subject:message-id:date:cc:to;
        bh=uW0MrXbB3BW7ZtLsIKXuNS6TLMaCGNiLsqZ7mbvjEew=;
        b=EMQwkT6OhHcpBV1zgUuF5gD73O5/A26kyDsfuhYQj1HkdO2qGJa2sBSnEIeTWytU0z
         QKMLm9E0xU8agzI0ICP+0OV92bBqrO/QsXZQVUV6w8sI6oqQH3AsR9+JtYbAo/SXLZ3y
         EqlsNsidO/v8v2YakJ7LORPBv2SjkK5s9v0eC8NI19eX0Ftb90pBKqcJ2aSqeG6pet7o
         bCb8TiTRG1CBnuqIqgLGVwZFv0hIz9t7FR1vwREXTqZAE2jIOUgeEJfPGU720w6kgODC
         v2IjK95tNZ57GWxDGJOh9bufUZO2YnzzAYxUs8nBFdCZXL5hUk2gVccl6dyOHBr0HH2W
         gt0g==
X-Gm-Message-State: APjAAAWNtQCChA0yZnH4ITzHVw+R8Awgenkq7DFGV/G1TzNrAQ2PQH+x
        IjPKO38xIj1uL4mm2FH+ds4Bl2pyAar8Zh08W0Ol5hUCgjFTWynRA4EeLc+ADsBqrZpdm1MuMro
        ib9+/aWa9fz5AKP7jbg50APQSPMHn7Rt6RlbIJHesbg==
X-Received: by 2002:a17:902:2ea2:: with SMTP id r31mr8140590plb.200.1565182221406;
        Wed, 07 Aug 2019 05:50:21 -0700 (PDT)
X-Google-Smtp-Source: APXvYqyP0mQsPRLO2O4uMJVwX5RbRxIPKKkBUk5N/K6JMpdRXjIw0uJRlI9ss9Nu1lLF3yZ0bhwyuw==
X-Received: by 2002:a17:902:2ea2:: with SMTP id r31mr8140558plb.200.1565182221045;
        Wed, 07 Aug 2019 05:50:21 -0700 (PDT)
Received: from 2001-b011-380f-37d3-744a-8654-5394-196d.dynamic-ip6.hinet.net (2001-b011-380f-37d3-744a-8654-5394-196d.dynamic-ip6.hinet.net. [2001:b011:380f:37d3:744a:8654:5394:196d])
        by smtp.gmail.com with ESMTPSA id o129sm68613198pfg.1.2019.08.07.05.50.19
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 07 Aug 2019 05:50:20 -0700 (PDT)
From:   Kai-Heng Feng <kai.heng.feng@canonical.com>
Content-Type: text/plain;
        charset=utf-8;
        delsp=yes;
        format=flowed
Content-Transfer-Encoding: 8bit
Mime-Version: 1.0 (Mac OS X Mail 12.4 \(3445.104.11\))
Subject: [Regression] "drm/amdgpu: enable gfxoff again on raven series (v2)"
Message-Id: <3EB0E920-31D7-4C91-A360-DBFB4417AC2F@canonical.com>
Date:   Wed, 7 Aug 2019 20:50:17 +0800
Cc:     "Deucher, Alexander" <alexander.deucher@amd.com>,
        Christian Koenig <christian.koenig@amd.com>,
        Chunming Zhou <David1.Zhou@amd.com>,
        amd-gfx list <amd-gfx@lists.freedesktop.org>,
        dri-devel@lists.freedesktop.org,
        LKML <linux-kernel@vger.kernel.org>,
        Anthony Wong <anthony.wong@canonical.com>
To:     Huang Rui <ray.huang@amd.com>
X-Mailer: Apple Mail (2.3445.104.11)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

After commit 005440066f92 ("drm/amdgpu: enable gfxoff again on raven series  
(v2)”), browsers on Raven Ridge systems cause serious corruption like this:
https://launchpadlibrarian.net/436319772/Screenshot%20from%202019-08-07%2004-20-34.png

Firmwares for Raven Ridge is up-to-date.

Kai-Heng
