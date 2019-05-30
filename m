Return-Path: <SRS0=Dgga=T6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 60646C28CC0
	for <linux-kernel@archiver.kernel.org>; Thu, 30 May 2019 23:56:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 335E02341F
	for <linux-kernel@archiver.kernel.org>; Thu, 30 May 2019 23:56:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MD0KhmNl"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726684AbfE3X4U (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 May 2019 19:56:20 -0400
Received: from mail-pf1-f182.google.com ([209.85.210.182]:44990 "EHLO
        mail-pf1-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726029AbfE3X4T (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 May 2019 19:56:19 -0400
Received: by mail-pf1-f182.google.com with SMTP id c9so1702380pfc.11;
        Thu, 30 May 2019 16:56:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=ci6z0DpBFa7HuJWAHxGdHuYnW8mClDBsdXXC0tted/Q=;
        b=MD0KhmNl+8nPftm4tU/0uii3Fi1m2zcXy7+Nk+4Vae1qpwqaE7vkkZHlor8ZGrc7nF
         KNvdGW3Bw65OsNoUFdE8pLIce3OzVcJW9+duoU+MsQ0AuQcKBOU2Ri4AjVDIU3kZyPw8
         denkj6wnL0oIQKXoEO1qQEBNFqdRkLw41FGgzeo3Wv7CA85+y24KC1oLsT5zo1I/y/tV
         R2+Qkfc6+E3Q4BM17qRSnkqQQNRFbfz95rmIIn+hkWtrSkPN7LtbaPEsrABp9+Y/6hjZ
         R01C1RVlSZmJYdxl4o/RYMdu9FlKgjAaYIpmLTi2Cj4Sz0ILXXAbech9rQJLa9GSuvnF
         yhRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=ci6z0DpBFa7HuJWAHxGdHuYnW8mClDBsdXXC0tted/Q=;
        b=ifJuOwyBVCYdsRhBmV1Bmm1rvKxanOWQ8Oahe/LuyJ5rkzX6x1dujBOTxm8KjRFYRi
         1YKAMb2hpb9qCyypi0IYqZg5qNMbKHOoC0iaI9Ie5c8bNUlzFXPCy3NxUDY2Syy+kwWP
         Vtq+CTTMGdvIjBK5UXi3BSXQ7ya9+B/Qbu/cFBeKKRrkiYkbeVnkXBT5VVrRVUIAPdYZ
         YWPTYmfhVLhX3bGJCyv2ZdWS57+BJGhfnAW3wVl1GCrcZxzWaPddwyrsFhiiwOwEkDY6
         Q+d71ebOFomef7tZeAGTprO1EMh8qclqCXtInDdGiEDzHQsXDun0NP2E9zyDZX3lCfLX
         iaXw==
X-Gm-Message-State: APjAAAX1svgUMKZx8HLZLAtuh/usFEsLlCvDPr4HklqQDwkT4FKIsBeL
        nSZc7TdCSNe94oJEHlB1foQJqJPu
X-Google-Smtp-Source: APXvYqz8WkrdvsiTQenk5sYYRR2nwXJ5N2Xhb0SFlPDYaRQ6N2bxST9T1QkWN6c2DB31jNYNWR+x9Q==
X-Received: by 2002:a63:18e:: with SMTP id 136mr5987289pgb.277.1559260578504;
        Thu, 30 May 2019 16:56:18 -0700 (PDT)
Received: from ?IPv6:2620:15c:2c1:200:55c7:81e6:c7d8:94b? ([2620:15c:2c1:200:55c7:81e6:c7d8:94b])
        by smtp.gmail.com with ESMTPSA id 124sm4830985pfe.124.2019.05.30.16.56.16
        (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
        Thu, 30 May 2019 16:56:17 -0700 (PDT)
Subject: Re: Driver has suspect GRO implementation, TCP performance may be
 compromised.
To:     Alexander Duyck <alexander.duyck@gmail.com>,
        Stephen Hemminger <stephen@networkplumber.org>
Cc:     Eric Dumazet <edumazet@google.com>,
        Paul Menzel <pmenzel@molgen.mpg.de>,
        Jeff Kirsher <jeffrey.t.kirsher@intel.com>,
        intel-wired-lan <intel-wired-lan@lists.osuosl.org>,
        netdev <netdev@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <e070e241-fb65-a5b0-3155-7380a9203bcf@molgen.mpg.de>
 <8627ea1e-8e51-c425-97f6-aeb57176e11a@gmail.com>
 <eb730f01-0c6d-0589-36cc-7193d64c1ee8@molgen.mpg.de>
 <CANn89i+VvwMaHy2Br-0CcC3gPQ+PmG3Urpn4KpqL0P7XBykmcw@mail.gmail.com>
 <20190529093548.3df7ee73@hermes.lan>
 <CAKgT0UdWmu3GjeMd9jmA=5FGQ=5cLnFb51arf+zkX7omc-G1fg@mail.gmail.com>
From:   Eric Dumazet <eric.dumazet@gmail.com>
Message-ID: <50261bc0-2732-5adb-1ff6-a4ac040e39b1@gmail.com>
Date:   Thu, 30 May 2019 16:56:15 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <CAKgT0UdWmu3GjeMd9jmA=5FGQ=5cLnFb51arf+zkX7omc-G1fg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 5/30/19 3:52 PM, Alexander Duyck wrote:

> Actually I think there are some parts that don't have any receive
> limits that are supported by the e1000 part. What ends up happening is
> that we only drop the packet if it spans more than one buffer if I
> recall correctly, and buffer size is determined by MTU.
> 
> I always thought MTU only applied to transmit since it is kind of in
> the name. As a result I am pretty sure igb and ixgbe will be able to
> trigger this warning under certain circumstances as well. Also what
> about the case where someone sets the MTU to less than 1500? I think
> most NICs probably don't update their limits in such a case and
> wouldn't it also trigger a similar error?
> 


Linux does not have a notion of MRU, mtu is used for both tx and rx.

Most NIC drivers allocate skb of the maximal size (derived from netdev->mtu)
and program the NIC to drop packets bigger than X bytes  (X also derived from netdev->mtu)

Another interesting point is that Paul host is receiving big packets,
that means that one host in his local network is overriding the 1500 MTU :)

Eventually we could add a netdev->mru and allow few drivers to set
their maximal mru, if bigger than netdev->mtu.

e1000e would probably set netdev->mru to 2048 - sizeof(ethernet headers), if
the driver is operating at MTU = 1500

