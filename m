Return-Path: <SRS0=K9bG=V2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3189CC7618B
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jul 2019 13:42:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F204A206DD
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jul 2019 13:42:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=cumulusnetworks.com header.i=@cumulusnetworks.com header.b="MC7xU0pH"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728189AbfG2Nm2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 29 Jul 2019 09:42:28 -0400
Received: from mail-wm1-f67.google.com ([209.85.128.67]:40192 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727222AbfG2Nm0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Jul 2019 09:42:26 -0400
Received: by mail-wm1-f67.google.com with SMTP id v19so53554002wmj.5
        for <linux-kernel@vger.kernel.org>; Mon, 29 Jul 2019 06:42:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cumulusnetworks.com; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=j+ACxE9Mwzw6xWU30d22KqY3pHLYPl1O/glNu0hxiHY=;
        b=MC7xU0pHuapGWfs4KLHfrnZcN05TRPsFKeNY4bNmRTwgUa1w+s5GMeKUT4NXEqf4oi
         YzG0l8BxpwqnFh6cKdI7jv5i0TBkyM/RMk6cd8rR1w/ujyRFlexytPmDF1yVjDvdo2an
         LwMVs9uSbWG5X1wea8aZ90BzvWg+Em85UW3Yg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=j+ACxE9Mwzw6xWU30d22KqY3pHLYPl1O/glNu0hxiHY=;
        b=JsgZVKkCC8IsDgnEnPw0sJC7F3d1Uk/2txUrqh70Xvi8ErBDvYBjNfnhyGCi6Q79o/
         mAzSzPYfONdyQLd4nZBqBWGBN0hfz3OtVaUBBOEv0xUzK9DZTKQLkH/n9UGhkEfTy0r9
         EwRfN6oSGVKzCnp9jysdpPHvZlg8r62TJaHjY0rbyurOa96+tbQ9B8lYV9oNPu21D3XT
         KxpKOntwj7rQDmBvgLirm95QXIEcha4ybKGT5v/du/XDYAqKMgo5xog7LJzJ0L7Wlqoc
         PNSavxBxMWgWKQPYCUut+dPcEtzyGwFjZU2BNqE6La73NJSoBPbTcS6ZZ7Au+XKjWlCs
         t01Q==
X-Gm-Message-State: APjAAAXsdDtPHtp9mpAp9PY190V6sxJ4yQPRTHZ16hbysartEZETzTPs
        6N6MsjtOtynKtH6izoyrnS8Co2KMTno=
X-Google-Smtp-Source: APXvYqydOKWO17ri+TzMoeOccpJuKMChMjFQ6Bvu+YRI/iEq3SL6FX0mvLlJqrz6+KJNGCmDp0lcYw==
X-Received: by 2002:a1c:a5c2:: with SMTP id o185mr97993540wme.172.1564407742994;
        Mon, 29 Jul 2019 06:42:22 -0700 (PDT)
Received: from [192.168.0.107] (84-238-136-197.ip.btc-net.bg. [84.238.136.197])
        by smtp.gmail.com with ESMTPSA id q10sm63839086wrf.32.2019.07.29.06.42.22
        (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
        Mon, 29 Jul 2019 06:42:22 -0700 (PDT)
Subject: Re: [PATCH] net: bridge: Allow bridge to joing multicast groups
To:     "Allan W. Nielsen" <allan.nielsen@microchip.com>
Cc:     Horatiu Vultur <horatiu.vultur@microchip.com>,
        roopa@cumulusnetworks.com, davem@davemloft.net,
        bridge@lists.linux-foundation.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <1564055044-27593-1-git-send-email-horatiu.vultur@microchip.com>
 <7e7a7015-6072-d884-b2ba-0a51177245ab@cumulusnetworks.com>
 <eef063fe-fd3a-7e02-89c2-e40728a17578@cumulusnetworks.com>
 <20190725142101.65tusauc6fzxb2yp@soft-dev3.microsemi.net>
 <b9ce433a-3ef7-fe15-642a-659c5715d992@cumulusnetworks.com>
 <e6ad982f-4706-46f9-b8f0-1337b09de350@cumulusnetworks.com>
 <20190726120214.c26oj5vks7g5ntwu@soft-dev3.microsemi.net>
 <b755f613-e6d8-a2e6-16cd-6f13ec0a6ddc@cumulusnetworks.com>
 <20190729121409.wa47uelw5f6l4vs4@lx-anielsen.microsemi.net>
 <95315f9e-0d31-2d34-ba50-11e1bbc1465c@cumulusnetworks.com>
 <20190729131420.tqukz55tz26jkg73@lx-anielsen.microsemi.net>
From:   Nikolay Aleksandrov <nikolay@cumulusnetworks.com>
Message-ID: <3cc69103-d194-2eca-e7dd-e2fa6a730223@cumulusnetworks.com>
Date:   Mon, 29 Jul 2019 16:42:21 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
MIME-Version: 1.0
In-Reply-To: <20190729131420.tqukz55tz26jkg73@lx-anielsen.microsemi.net>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 29/07/2019 16:14, Allan W. Nielsen wrote:
> The 07/29/2019 15:22, Nikolay Aleksandrov wrote:
>> Yes, all of the multicast code is handled differently, it doesn't go through the fdb
>> lookup or code at all. I don't see how you'll do a lookup in the fdb table with a
>> multicast mac address, take a look at br_handle_frame_finish() and you'll notice
>> that when a multicast dmac is detected then we use the bridge mcast code for lookups
>> and forwarding.
> 
> Here is my thinking (needs much more elaboration, which will come if we do a
> patch to test it out):
> 
> 
> In br_pkt_type
> 
> Rename BR_PKT_MULTICAST to BR_PKT_MULTICAST_IP
> Add a new type called BR_PKT_MULTICAST_L2
> 
> In br_handle_frame_finish
> 
> 	if (is_multicast_ether_addr(dest)) {
> 		/* by definition the broadcast is also a multicast address */
> 		if (is_broadcast_ether_addr(dest)) {
> 			pkt_type = BR_PKT_BROADCAST;
> 			local_rcv = true;
> 		} else {
> 			pkt_type = BR_PKT_MULTICAST;
> 			if (br_multicast_rcv(br, p, skb, vid))
> 				goto drop;
> 		}
> 	}
> 
> Change the code above to detect if it is a BR_PKT_MULTICAST_IP or a
> BR_PKT_MULTICAST_L2
> 
> 
> In this section:
> 
> switch (pkt_type) {
> ....
> }
> 
> if (dst) {
> } else {
> }
> 
> Add awareness to the BR_PKT_MULTICAST_L2 type, and allow it do forwarding
> according to the static entry if it is there.
> 

All of these add overhead to everyone - standard unicast and multicast forwarding.
Also as mentioned in my second email the fdb would need changes which would further
increase that overhead and also the code complexity for everyone for a use-case which
is very rare when there are alternatives today which avoid all of that. Offload tc rules
and add a rule to allow that traffic on ingress for particular ports, then either use
the bridge multicast flood flag or tc again to restrict flood to other egress ports.

Alternatively use ip maddr add which calls dev_mc_add() which is what the patch was
trying to do in the first place to allow the Rx of these packets and then control
the flooding via one of the above methods.

Alternatively offload nft and use that to control the traffic.

I'm sure there are more ways that I'm missing. :)

If you find a way to achieve this without incurring a performance hit or significant
code complexity increase, and without breaking current use-cases (e.g. unexpected default
forwarding behaviour changes) then please send a patch and we can discuss it further with
all details present. People have provided enough alternatives which avoid all of the
problems.

>> If you're trying to achieve Rx only on the bridge of these then
>> why not just use Ido's tc suggestion or even the ip maddr add offload for each port ?
>>
>> If you add a multicast mac in the fdb (currently allowed, but has no effect) and you
>> use dev_mc_add() as suggested that'd just be a hack to pass it down and it is already
>> possible to achieve via other methods, no need to go through the bridge.
> 
> Well, I wanted the SW bridge implementation to behave the same with an without
> HW offload.
> 
> And also, I believe that is conceptually belongs to the MAC tables.
> 
> /Allan
> 

