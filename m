Return-Path: <SRS0=1LW7=ZA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DEFC9C5DF60
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Nov 2019 15:36:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ADEF721882
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Nov 2019 15:36:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=norrbonn-se.20150623.gappssmtp.com header.i=@norrbonn-se.20150623.gappssmtp.com header.b="hrJLm8NT"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727431AbfKHPgw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 Nov 2019 10:36:52 -0500
Received: from mail-lj1-f195.google.com ([209.85.208.195]:45941 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726129AbfKHPgw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Nov 2019 10:36:52 -0500
Received: by mail-lj1-f195.google.com with SMTP id n21so6651062ljg.12
        for <linux-kernel@vger.kernel.org>; Fri, 08 Nov 2019 07:36:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=norrbonn-se.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=2pe6fLgoaZ20F6d1ALx8ua+vYps6HC8ap7HyPfV+7qA=;
        b=hrJLm8NT5gvZlCLVkDal51GeCoaKTjY3KJCkYz2j5LVZ+4oYahm+oTar+PhaGjcYwF
         Igw4em3xySiJL8DsHAdByg4PeswhflQq/4q/J70XFPzXdF1Wc8Rr15NEiV78eWG/51RB
         XEU3Cxpt44PGidtswt/SH/Wa0gfVqq8VxC+WIS1ubqtu8ZEApFD3XGSOdwv798ltSt3+
         JOMLZ9Uv8bxKRzVRT7qGi+uOrerthzymaeSnZBlU/eKv0fpHoH40MGb6olgJEzRHplh5
         BGHGZ/hSZ9QGDtNe8+SnoSeOWzyvb59rXaqUgRbnfag6y7wiNqZoWa19bNOwTtuh+jDu
         SrWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=2pe6fLgoaZ20F6d1ALx8ua+vYps6HC8ap7HyPfV+7qA=;
        b=ujn4ofILBwOqjXX0tcDJkYHmFs34/es18NmTagy/W9LJN5pFAs8AWokw9guxUxb028
         iN3lbp/nscSeE0G9Q5FS+NsFSDK7pI/+8aK73B/UyBioWIn9rV+qDzEc/4h9Yi3hQ9pk
         oy2ns3i/oDmn7Ex3ndEBbWUAyoIAm8oWd727aaLfm628jlWsy4jM8qmugnxLgi9BqkD4
         xQRYqVd3Vk7K26WRZUoCpX2d+1O0+QJAcwObtKIsjxI/08eFntTh6pzqIGu2TDQOlkVg
         Pw0LFP6/HAoFhbC5Z020SdiQ6iqDRoJM3NWvbxQoo84OqoJqi9E4oKOUPsiVBkXR53P1
         73uw==
X-Gm-Message-State: APjAAAUXs8rA9WKKdDF2XBqGlPHl2eZUho1mDlyv1+ACmE+womwRkTtz
        JcfjKEsWtqubvDUX+0Q7570YRg==
X-Google-Smtp-Source: APXvYqyUgqYQ3oDvYgH32FgzCklgL9KCOEjJQGak0IjSzDhdq744+iVcrZsQtqMfAO54gdDffckFsw==
X-Received: by 2002:a2e:81d2:: with SMTP id s18mr7088062ljg.189.1573227409814;
        Fri, 08 Nov 2019 07:36:49 -0800 (PST)
Received: from [10.0.156.104] ([195.22.87.57])
        by smtp.gmail.com with ESMTPSA id q16sm1072855lfm.87.2019.11.08.07.36.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 08 Nov 2019 07:36:48 -0800 (PST)
Subject: Re: [PATCH v3 0/6] Add namespace awareness to Netlink methods
To:     David Ahern <dsahern@gmail.com>,
        =?UTF-8?B?TWFoZXNoIEJhbmRld2FyICjgpK7gpLngpYfgpLYg4KSs4KSC4KSh4KWH4KS14KS+?=
         =?UTF-8?B?4KSwKQ==?= <maheshb@google.com>
Cc:     nicolas.dichtel@6wind.com, linux-netdev <netdev@vger.kernel.org>,
        linux-kernel@vger.kernel.org, David Miller <davem@davemloft.net>
References: <20191107132755.8517-1-jonas@norrbonn.se>
 <CAF2d9jjteagJGmt64mNFH-pFmGg_eM8_NNBrDtROcaVKhcNkRQ@mail.gmail.com>
 <d34174c2-a4d4-b3da-ded5-dcb97a89c80c@gmail.com>
From:   Jonas Bonn <jonas@norrbonn.se>
Message-ID: <229cdce6-f510-5d9f-401b-69bad4af0722@norrbonn.se>
Date:   Fri, 8 Nov 2019 16:36:46 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.2
MIME-Version: 1.0
In-Reply-To: <d34174c2-a4d4-b3da-ded5-dcb97a89c80c@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 07/11/2019 22:11, David Ahern wrote:
> On 11/7/19 1:40 PM, Mahesh Bandewar (महेश बंडेवार) wrote:
>> On Thu, Nov 7, 2019 at 5:30 AM Jonas Bonn <jonas@norrbonn.se> wrote:
>>>
>>> Changed in v3:
>>> - added patch 6 for setting IPv6 address outside current namespace
>>> - address checkpatch warnings
>>> - address comment from Nicolas
>>>
>>> Changed in v2:
>>> - address comment from Nicolas
>>> - add accumulated ACK's
>>>
>>> Currently, Netlink has partial support for acting outside of the current
>>> namespace.  It appears that the intention was to extend this to all the
>>> methods eventually, but it hasn't been done to date.
>>>
>>> With this series RTM_SETLINK, RTM_NEWLINK, RTM_NEWADDR, and RTM_NEWNSID
>>> are extended to respect the selection of the namespace to work in.
>>>
>> This is nice, is there a plan to update userspace commands using this?
> 
> I'm hoping for an iproute2 update and test cases to validate the changes.
> 

I'm looking into it.  The change to iproute2 to support 
(namespace,index) pairs instead of just (index) to identify interfaces 
looks to be invasive.  The rest of it looks like trivial changes.

I've got all these kernel patches tested against my own "namespace aware 
network manager" that I'm writing for a customer with a particular use 
case.  iproute2 wasn't actually in play here.

/Jonas
