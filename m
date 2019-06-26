Return-Path: <SRS0=hRvo=UZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5BF1FC4646B
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Jun 2019 06:14:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3D5312085A
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Jun 2019 06:14:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726750AbfFZGOZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Jun 2019 02:14:25 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:38956 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726687AbfFZGOY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Jun 2019 02:14:24 -0400
Received: from mail-pg1-f200.google.com ([209.85.215.200])
        by youngberry.canonical.com with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
        (Exim 4.76)
        (envelope-from <kai.heng.feng@canonical.com>)
        id 1hg1CI-00011d-Rq
        for linux-kernel@vger.kernel.org; Wed, 26 Jun 2019 06:14:23 +0000
Received: by mail-pg1-f200.google.com with SMTP id b10so933867pgb.22
        for <linux-kernel@vger.kernel.org>; Tue, 25 Jun 2019 23:14:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=Qzj1f9ft1l/we0rK2p1RXiD5bfavnmcjFfDBQn4lzKU=;
        b=jKP/13a+wYiU+rxgESgg9BGOO4FpR7py3PyFGtlC0r4/rurzBaNC3b/VJK9X7Hp4RC
         HxlNvsIRF3JcnIp8DjYxsXHqPSnWqR8xYYyftQ/7At09prUhf8RKGbTxcBL0FmKLNWQh
         62egzGXA66KHPXxO57rMBqvqW6+0lZqVIOQ+a5na9dL77TvglLN29zMQjf62yJCFdxCb
         cga+uNJxtufvff0+eRPL2t2hDYcrmRKfEte5xqq9VJGcICtIhL5t3qA45UtuYY5dnIXy
         e6eBDrV4rdPvX3m9H7PlSW2lzR4XudknT9oE5UkksYcmzN+2DsvwCBVLsdwKDxUM6F+S
         teEQ==
X-Gm-Message-State: APjAAAUGx2TwJMzX+sh7Q0XketD7xGvl0Bu6q9LNMKNyXxpjD27uDHHW
        +wbxup4mATK2M8onlmjYx1bhZyeUYVTTY0gBpuH3O1NhEk7D9xeOjMGAiakfv6rYEmsPLcb8VAc
        Lcl1WDrJXikuMaRGYJAiuiWHn2T2jNsmA0+i+MRTb3A==
X-Received: by 2002:a17:902:9a84:: with SMTP id w4mr3295704plp.160.1561529661632;
        Tue, 25 Jun 2019 23:14:21 -0700 (PDT)
X-Google-Smtp-Source: APXvYqyHZrac8B6jpvkaO/VXWxU4A1aWKuSGiff3KI+tndM4pw00sha7p/0/aJVgC1+kv6pHFSnOGw==
X-Received: by 2002:a17:902:9a84:: with SMTP id w4mr3295682plp.160.1561529661445;
        Tue, 25 Jun 2019 23:14:21 -0700 (PDT)
Received: from [10.101.46.178] (61-220-137-37.HINET-IP.hinet.net. [61.220.137.37])
        by smtp.gmail.com with ESMTPSA id f64sm15747880pfa.115.2019.06.25.23.14.20
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 25 Jun 2019 23:14:21 -0700 (PDT)
Content-Type: text/plain;
        charset=utf-8;
        delsp=yes;
        format=flowed
Mime-Version: 1.0 (Mac OS X Mail 12.4 \(3445.104.11\))
Subject: Re: RX CRC errors on I219-V (6) 8086:15be
From:   Kai Heng Feng <kai.heng.feng@canonical.com>
In-Reply-To: <C4036C54-EEEB-47F3-9200-4DD1B22B4280@canonical.com>
Date:   Wed, 26 Jun 2019 14:14:16 +0800
Cc:     jeffrey.t.kirsher@intel.com,
        Anthony Wong <anthony.wong@canonical.com>,
        intel-wired-lan@lists.osuosl.org,
        linux-kernel <linux-kernel@vger.kernel.org>
Content-Transfer-Encoding: 8bit
Message-Id: <3975473C-B117-4DC6-809A-6623A5A478BF@canonical.com>
References: <C4036C54-EEEB-47F3-9200-4DD1B22B4280@canonical.com>
To:     "Neftin, Sasha" <sasha.neftin@intel.com>
X-Mailer: Apple Mail (2.3445.104.11)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Sasha

at 5:09 PM, Kai-Heng Feng <kai.heng.feng@canonical.com> wrote:

> Hi Jeffrey,
>
> We’ve encountered another issue, which causes multiple CRC errors and  
> renders ethernet completely useless, here’s the network stats:

I also tried ignore_ltr for this issue, seems like it alleviates the  
symptom a bit for a while, then the network still becomes useless after  
some usage.

And yes, it’s also a Whiskey Lake platform. What’s the next step to debug  
this problem?

Kai-Heng

>
> /sys/class/net/eno1/statistics$ grep . *
> collisions:0
> multicast:95
> rx_bytes:1499851
> rx_compressed:0
> rx_crc_errors:1165
> rx_dropped:0
> rx_errors:2330
> rx_fifo_errors:0
> rx_frame_errors:0
> rx_length_errors:0
> rx_missed_errors:0
> rx_nohandler:0
> rx_over_errors:0
> rx_packets:4789
> tx_aborted_errors:0
> tx_bytes:864312
> tx_carrier_errors:0
> tx_compressed:0
> tx_dropped:0
> tx_errors:0
> tx_fifo_errors:0
> tx_heartbeat_errors:0
> tx_packets:7370
> tx_window_errors:0
>
> Same behavior can be observed on both mainline kernel and on your  
> dev-queue branch.
> OTOH, the same issue can’t be observed on out-of-tree e1000e.
>
> Is there any plan to close the gap between upstream and out-of-tree  
> version?
>
> Kai-Heng


