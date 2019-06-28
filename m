Return-Path: <SRS0=E/6H=U3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F2251C4321A
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Jun 2019 10:49:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D0D5820656
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Jun 2019 10:49:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726801AbfF1Kta (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 28 Jun 2019 06:49:30 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:53359 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726543AbfF1Kta (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Jun 2019 06:49:30 -0400
Received: from mail-pl1-f200.google.com ([209.85.214.200])
        by youngberry.canonical.com with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
        (Exim 4.76)
        (envelope-from <kai.heng.feng@canonical.com>)
        id 1hgoRb-0003dp-Hh
        for linux-kernel@vger.kernel.org; Fri, 28 Jun 2019 10:49:27 +0000
Received: by mail-pl1-f200.google.com with SMTP id e95so3319353plb.9
        for <linux-kernel@vger.kernel.org>; Fri, 28 Jun 2019 03:49:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=Iwcwu8EhYBQtmQq06vx5HeybIZVBqkP7FYte+n7wh10=;
        b=h8oIdONQpcqqqi9MItqGEaudGH1Ipz5qSK/CZogXJTz85fBIRuURtW2s+cb+WPyxOc
         F2j5PNOCAVQSKFbLBFaqAtLRDp8BM8mIdRHk6SyyCLfu8jds800U/65qsWpq5YPYY+o5
         scstGM15TAWcYoJAHcDkQNTmT4rPrYOqn1Hg5rtUnIff61ogDAyw46TPe7z4EDGp+Yxk
         GrAhJv+cdAPkMq8KzOxckA4/4dAKEffoGIUEHB/ox3VFeAtXK84ifarZZdPTJB1+hguK
         LMc3RwLoNo429O6xkSPS1g6NhQgJUSWvnJMh6OVXGvsx/z2NFluuVaiSYo/yyJzgvc86
         VukQ==
X-Gm-Message-State: APjAAAXexQP4n/i+08AILBc3xwGiiBTJ2eQHi2wY06NpBo7WeMUjAawE
        Qy56HMEbGQPBFOHvnXo6EnxlpsAll3OLVFRnKSEKH3lL4zvTeqG3N6veWzXYSKhjvA9919V7R+B
        y2Vhl7v5ZKNLWW2zkwi6hCF9Qohgdid3gbJbtrJBYIw==
X-Received: by 2002:a17:90a:ad41:: with SMTP id w1mr12253099pjv.52.1561718966070;
        Fri, 28 Jun 2019 03:49:26 -0700 (PDT)
X-Google-Smtp-Source: APXvYqwHSzLGj7RNMgY9viMUYdktryg7yAm3bRja6SaV/JtanR/yUz2rnrUAgGwDNqp4EnSG/IoeDg==
X-Received: by 2002:a17:90a:ad41:: with SMTP id w1mr12253069pjv.52.1561718965820;
        Fri, 28 Jun 2019 03:49:25 -0700 (PDT)
Received: from 2001-b011-380f-3511-c09f-cbfd-7c09-2630.dynamic-ip6.hinet.net (2001-b011-380f-3511-c09f-cbfd-7c09-2630.dynamic-ip6.hinet.net. [2001:b011:380f:3511:c09f:cbfd:7c09:2630])
        by smtp.gmail.com with ESMTPSA id b36sm5214620pjc.16.2019.06.28.03.49.24
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 28 Jun 2019 03:49:25 -0700 (PDT)
Content-Type: text/plain;
        charset=utf-8;
        delsp=yes;
        format=flowed
Mime-Version: 1.0 (Mac OS X Mail 12.4 \(3445.104.11\))
Subject: Re: RX CRC errors on I219-V (6) 8086:15be
From:   Kai-Heng Feng <kai.heng.feng@canonical.com>
In-Reply-To: <ed4eca8e-d393-91d7-5d2f-97d42e0b75cb@intel.com>
Date:   Fri, 28 Jun 2019 18:49:22 +0800
Cc:     jeffrey.t.kirsher@intel.com,
        Anthony Wong <anthony.wong@canonical.com>,
        intel-wired-lan@lists.osuosl.org,
        linux-kernel <linux-kernel@vger.kernel.org>
Content-Transfer-Encoding: 8bit
Message-Id: <1804A45E-71B5-4C41-839C-AF0CFAD0D785@canonical.com>
References: <C4036C54-EEEB-47F3-9200-4DD1B22B4280@canonical.com>
 <3975473C-B117-4DC6-809A-6623A5A478BF@canonical.com>
 <ed4eca8e-d393-91d7-5d2f-97d42e0b75cb@intel.com>
To:     "Neftin, Sasha" <sasha.neftin@intel.com>
X-Mailer: Apple Mail (2.3445.104.11)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

at 14:26, Neftin, Sasha <sasha.neftin@intel.com> wrote:

> On 6/26/2019 09:14, Kai Heng Feng wrote:
>> Hi Sasha
>> at 5:09 PM, Kai-Heng Feng <kai.heng.feng@canonical.com> wrote:
>>> Hi Jeffrey,
>>>
>>> We’ve encountered another issue, which causes multiple CRC errors and  
>>> renders ethernet completely useless, here’s the network stats:
>> I also tried ignore_ltr for this issue, seems like it alleviates the  
>> symptom a bit for a while, then the network still becomes useless after  
>> some usage.
>> And yes, it’s also a Whiskey Lake platform. What’s the next step to  
>> debug this problem?
>> Kai-Heng
> CRC errors not related to the LTR. Please, try to disable the ME on your  
> platform. Hope you have this option in BIOS. Another way is to contact  
> your PC vendor and ask to provide NVM without ME. Let's start debugging  
> with these steps.

According to ODM, the ME can be physically disabled by a jumper.
But after disabling the ME the same issue can still be observed.

Kai-Heng

>>> /sys/class/net/eno1/statistics$ grep . *
>>> collisions:0
>>> multicast:95
>>> rx_bytes:1499851
>>> rx_compressed:0
>>> rx_crc_errors:1165
>>> rx_dropped:0
>>> rx_errors:2330
>>> rx_fifo_errors:0
>>> rx_frame_errors:0
>>> rx_length_errors:0
>>> rx_missed_errors:0
>>> rx_nohandler:0
>>> rx_over_errors:0
>>> rx_packets:4789
>>> tx_aborted_errors:0
>>> tx_bytes:864312
>>> tx_carrier_errors:0
>>> tx_compressed:0
>>> tx_dropped:0
>>> tx_errors:0
>>> tx_fifo_errors:0
>>> tx_heartbeat_errors:0
>>> tx_packets:7370
>>> tx_window_errors:0
>>>
>>> Same behavior can be observed on both mainline kernel and on your  
>>> dev-queue branch.
>>> OTOH, the same issue can’t be observed on out-of-tree e1000e.
>>>
>>> Is there any plan to close the gap between upstream and out-of-tree  
>>> version?
>>>
>>> Kai-Heng


