Return-Path: <SRS0=kpxk=YC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 26759C47404
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Oct 2019 06:46:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EBBF420B7C
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Oct 2019 06:46:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=netrounds-com.20150623.gappssmtp.com header.i=@netrounds-com.20150623.gappssmtp.com header.b="jAmFYcUl"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728132AbfJIGq0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 9 Oct 2019 02:46:26 -0400
Received: from mail-lj1-f193.google.com ([209.85.208.193]:33986 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725914AbfJIGqZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Oct 2019 02:46:25 -0400
Received: by mail-lj1-f193.google.com with SMTP id j19so1316058lja.1
        for <linux-kernel@vger.kernel.org>; Tue, 08 Oct 2019 23:46:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=netrounds-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:subject:message-id:date:user-agent:mime-version
         :content-language:content-transfer-encoding;
        bh=f+gWR+LjmSBbJitTfLQV8AjJIexhV1cxyS84yC8N87o=;
        b=jAmFYcUlczPMa/GIKzBcfOv+GCxavycEJ7t6U88F5+Dt2B4W3JRWnYpnfZi2+8G1bP
         G474GC8PZ+Mmwa3jHuw36I7zhhMQzCDkk6DRlLTYwxsPHU62/BRwJDubtpqA8CdnxLZg
         ZyUdURzQDXEG/2xxyBt/T7HjAFqNZSIw8r7GgIj9XTOidOzLJBwnwRWeznQOdDmtxvxk
         8ch2XqgSmiMqZfF+Nb11PHj+Ws1XmwUD5vtz4S6EaUn3czE2I4QF9Oh/DnYFm6I27RWs
         OGXcaA8nj3bF9/JxpIWR0+BIkcYMK6J8ZGTC9BFrH9bXgafMmcKaPHAy1N6jZzpHGybC
         1k6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:message-id:date:user-agent
         :mime-version:content-language:content-transfer-encoding;
        bh=f+gWR+LjmSBbJitTfLQV8AjJIexhV1cxyS84yC8N87o=;
        b=VUveHLSdMOItT8pOR7HtgUKq537BegSq5u78v3QHtKajVY+/Tzu1GXVVcUB2LSR4h8
         MdROMvRvVaGZPFMOHk/yixocCyddMxDi8Ur0+kXbIWgK26wNoUn8AtRUaUeE4PDmAycW
         dX6QL5guoLawr85uQXyLh8an7ES9BYAHpVygFjeht0lRKtC6CsgPddlB7UkQbOXaOSsa
         cB4MGQ0gEiRRX+e42XC53xXPXf0AmMBsb7ZAureWoK2Zqhrmrg4FQi1TbuiyddpljfQU
         PohwfcbGvUFUU92roH9PNP68KfZKLxD4tPKbtTGeb+5vsIeiTUi+W+E7DIF+LCUlPHHO
         VLdQ==
X-Gm-Message-State: APjAAAXwSh0YjF2bGRUPR/SHvhWrAxkor2MRE5c1Sxkfu8CSgnC+9olp
        64GVyNx/Ji+/4a/m2Qw4wDKVpg==
X-Google-Smtp-Source: APXvYqzMx79MdjNQ10diKOd4OBQPKpH0x6KeOmrH48ZVecxxD63q16fZKrPGZwtGBxkbUM7b6RnDnw==
X-Received: by 2002:a2e:880e:: with SMTP id x14mr1278708ljh.42.1570603583122;
        Tue, 08 Oct 2019 23:46:23 -0700 (PDT)
Received: from [10.0.156.104] ([195.22.87.57])
        by smtp.gmail.com with ESMTPSA id q16sm246677lfp.71.2019.10.08.23.46.22
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 08 Oct 2019 23:46:22 -0700 (PDT)
From:   Jonas Bonn <jonas.bonn@netrounds.com>
To:     "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        "David S . Miller" <davem@davemloft.net>, pabeni@redhat.com
Subject: Packet gets stuck in NOLOCK pfifo_fast qdisc
Message-ID: <d102074f-7489-e35a-98cf-e2cad7efd8a2@netrounds.com>
Date:   Wed, 9 Oct 2019 08:46:19 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

The lockless pfifo_fast qdisc has an issue with packets getting stuck in 
the queue.  What appears to happen is:

i)  Thread 1 holds the 'seqlock' on the qdisc and dequeues packets.
ii)  Thread 1 dequeues the last packet in the queue.
iii)  Thread 1 iterates through the qdisc->dequeue function again and 
determines that the queue is empty.

iv)  Thread 2 queues up a packet.  Since 'seqlock' is busy, it just 
assumes the packet will be dequeued by whoever is holding the lock.

v)  Thread 1 releases 'seqlock'.

After v), nobody will check if there are packets in the queue until a 
new packet is enqueued.  Thereby, the packet enqueued by Thread 2 may be 
delayed indefinitely.

What, I think, should probably happen is that Thread 1 should check that 
the queue is empty again after releasing 'seqlock'.  I poked at this, 
but it wasn't obvious to me how to go about this given the way the 
layering works here.  Roughly:

qdisc_run_end() {
...
	spin_unlock(seqlock);
	if (!qdisc_is_empty(qdisc))
		qdisc_run();
...
}

Calling qdisc_run() from qdisc_run_end() doesn't feel right!

There's a qdisc->empty property (and qdisc_is_empty() relies on it) but 
it's not particularly useful in this case since there's a race in 
setting this property which makes it not quite reliable.

Hope someone can shine some light on how to proceed here.

/Jonas
