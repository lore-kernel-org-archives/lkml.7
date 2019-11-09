Return-Path: <SRS0=HJxx=ZB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DEDB2C43331
	for <linux-kernel@archiver.kernel.org>; Sat,  9 Nov 2019 23:05:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B08C7207FF
	for <linux-kernel@archiver.kernel.org>; Sat,  9 Nov 2019 23:05:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=rajagiritech-edu-in.20150623.gappssmtp.com header.i=@rajagiritech-edu-in.20150623.gappssmtp.com header.b="MUH40SXX"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726616AbfKIXFa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 9 Nov 2019 18:05:30 -0500
Received: from mail-pf1-f194.google.com ([209.85.210.194]:39284 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726470AbfKIXFa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 9 Nov 2019 18:05:30 -0500
Received: by mail-pf1-f194.google.com with SMTP id x28so7577661pfo.6
        for <linux-kernel@vger.kernel.org>; Sat, 09 Nov 2019 15:05:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rajagiritech-edu-in.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=dirWlcLXMWe4DBJFlhecKvrzQebSxo/FvEC+4dhxwKo=;
        b=MUH40SXXiPqYO6J2DJEs7PwCT3R9HKOCxq1wGj4LxBXEYM2tJsthus8hybdFVP2N4s
         JrZhtBYV8v3Yrxp2Xz0307K4Dvn6rwC+LNd6PqSi/ly55v/rXnhwZ5FvUS7+MLFAlTBu
         fIOiXEYyXjNk46oW3WH12DzNfYusV/J7tc7kVSfRrJjvX02+5hQ7f/zd6eFQ38hEqkH/
         NHhOqOxBAcq/eEqIkUwO9w6v0nL12nDN7B6V2G+Rc2em6jAtDipPEWZPKBFjgN8oZMrl
         rjn1sDa5d0ZbDtulAff0lT5anwAgnfPDUWL3+QMXWQFHJH3auzM8ajqkANw6Eld2ySVO
         vMdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=dirWlcLXMWe4DBJFlhecKvrzQebSxo/FvEC+4dhxwKo=;
        b=Znu9O8bH2qux8zQ6xMdSrGjDjPAkvj8Rt5VVUcQ9EftUXcdHYo8oxDqyWPyIFOS+bV
         Bxc/2IFRmpvyUnEDnjT3iqRY2lv4tPGrxqVny3pKU412uGKF6zy2/Xt85fujgncc3lm/
         30qs6Yqsj5lEd1vjzePKSC+P+8iQdxLYqdmueZtCZpgOidR2VcfNlURkvAVA4+pY2YlI
         ICQF7W0W0slF3/Ycn9DM2PzI/gxxDXpAeZrVNqvTMYyGBK5SofBxPHPhLwKqnxcruf67
         LyfcKypJm5moPbagUTTDOUiRZKQq9GyvJaPT1yulSkfUXGWbE7o1WOcJngPNKZ96bzZO
         gCmw==
X-Gm-Message-State: APjAAAUgxxnIlNuB4fqmMh6YYaSIi7dAqAJEYFOs/miPjIZULJx+rGoP
        P2DdvMFo9MFizfB/4QwY42EuMQ==
X-Google-Smtp-Source: APXvYqydfzMdW+XGC8XiXFGzeGQvDbPZAp7+qG1LcX1F/4qpg1fQnSwlnhv4MEQrG7+7nFgozJR6Dg==
X-Received: by 2002:a63:644:: with SMTP id 65mr12050858pgg.306.1573340728005;
        Sat, 09 Nov 2019 15:05:28 -0800 (PST)
Received: from debian ([122.174.231.44])
        by smtp.gmail.com with ESMTPSA id i123sm16325565pfe.145.2019.11.09.15.05.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 09 Nov 2019 15:05:27 -0800 (PST)
Date:   Sun, 10 Nov 2019 04:35:20 +0530
From:   Jeffrin Jose <jeffrin@rajagiritech.edu.in>
To:     davem@davemloft.net, willemb@google.com, xiyou.wangcong@gmail.com,
        fw@strlen.de, jakub.kicinski@netronome.com,
        john.hurley@netronome.com, pabeni@redhat.com, brouer@redhat.com,
        bigeasy@linutronix.de, jonathan.lemon@gmail.com,
        edumazet@google.com
Cc:     netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org
Subject: objtool: skb_push.cold()+0x15: unreachable instruction
Message-ID: <20191109230520.GA22258@debian>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.12.2 (2019-09-21)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

hello,

i got a warning during kernel compilation.

net/core/skbuff.o: warning: objtool: skb_push.cold()+0x15: unreachable instruction

related clips...

--------------------x----------------x---------------------

(gdb) l skb_push.cold
1880	void *skb_push(struct sk_buff *skb, unsigned int len)
1881	{
1882		skb->data -= len;
1883		skb->len  += len;
1884		if (unlikely(skb->data < skb->head))
1885			skb_under_panic(skb, len, __builtin_return_address(0));
1886		return skb->data;
1887	}
1888	EXPORT_SYMBOL(skb_push);
1889	
(gdb) l *0xffffffff815ffc8e
0xffffffff815ffc8e is in skb_push (net/core/skbuff.c:1885).
1880	void *skb_push(struct sk_buff *skb, unsigned int len)
1881	{
1882		skb->data -= len;
1883		skb->len  += len;
1884		if (unlikely(skb->data < skb->head))
1885			skb_under_panic(skb, len, __builtin_return_address(0));
1886		return skb->data;
1887	}
1888	EXPORT_SYMBOL(skb_push);
1889	
(gdb)

------------------x-----------------------x------------------------------------

$uname -a
Linux debian 5.4.0-rc1+ #1 SMP Sat Nov 9 21:29:48 IST 2019 x86_64 GNU/Linux
$

this kernel is from linux-kselftest tree

---------------------------x-------------x------------------------------

$gcc --version
gcc (Debian 9.2.1-14) 9.2.1 20191025
Copyright (C) 2019 Free Software Foundation, Inc.
This is free software; see the source for copying conditions.  There is NO
warranty; not even for MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.

-------------------------x-------------------x-----------------------------

Linux debian 5.4.0-rc1+ #1 SMP Sat Nov 9 21:29:48 IST 2019 x86_64 GNU/Linux

GNU Make            	4.2.1
Binutils            	2.33.1
Util-linux          	2.33.1
Mount               	2.33.1
Linux C Library     	2.29
Dynamic linker (ldd)	2.29
Procps              	3.3.15
Kbd                 	2.0.4
Console-tools       	2.0.4
Sh-utils            	8.30
Udev                	241

-------------------------------x-----------------x----------------------------




--
software engineer
rajagiri school of engineering and technology
