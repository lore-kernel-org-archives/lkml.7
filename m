Return-Path: <SRS0=SA5R=SA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E3B54C43381
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Mar 2019 18:53:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 984572184D
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Mar 2019 18:53:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dMxlPdjL"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730106AbfC2SxP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 29 Mar 2019 14:53:15 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:45168 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730012AbfC2SxO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Mar 2019 14:53:14 -0400
Received: by mail-pg1-f196.google.com with SMTP id y3so1613847pgk.12;
        Fri, 29 Mar 2019 11:53:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:openpgp:autocrypt:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=p4A0Onlk3fOlyC8hVw6zpwCDzImpcG3mi2nr2uz+4xE=;
        b=dMxlPdjL7JvZuyC8qjzu05muk7DtQ4xwPPh+S8/SCw5zAaiWvAbnAPmU/c5SwIQEY+
         wY3yWdp5xW6ZXtXBxSbAbylFt73y5pUk/7SJfwP5+iilHmySnBoIToOsfOtG0i1TK1hh
         21Im8QiDomn/jLDY0E4dw2ReiQN8aaZ+qrU8E1OER9nVTWnBgn1J+tgcjiafFNVPlicc
         tj7rOMbDGsHWCrY2pBbiMieEzSiCTHSjxkqvQe2T2/ZonnLjSlJncHV4vXK9Vp/J5NB3
         Yh0igctVwtC8mudL11mnBkwMTo8qo/ILFpLj0EhMnhJ4225SimeocSgxniAq4BQcwVjh
         hDRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:openpgp:autocrypt
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=p4A0Onlk3fOlyC8hVw6zpwCDzImpcG3mi2nr2uz+4xE=;
        b=Pakvc93nLi6O4xrZ6MlRWPeeltgpACMfj0E/IBNDqmItIoHzGD2tSo9lfwqUdoVJY8
         eA9r9hmZzRVdR2YdIDf0WQXezTnUu87zZiA5STa0xUn9PdTIo+yUGqivzZNk0vbZXkW5
         JEQIHOVaaP7XnrvzXWTBQG7uGhiE/g6R0htkTRISxCygSOVwmNRSWL8Rl/k+Yz63B0qH
         YikJJF8DW3Da34I4cWbowHHWBjnBwDDKZLPaiuY8bU/8wVDvrO6VUZOz05Y4LCC6TXU5
         vui2NiBb4w1rHrh1UkB3HeREkd9DsM3pVNod4Zih95EcXPgfWRGFz1JyOxo7YM7NYj0P
         8cvQ==
X-Gm-Message-State: APjAAAU0GjM0ywfxcor7+c17zMcxE4U5UCPpS1cZCNhIcZ0xRzH2sWvv
        ExMeNRHZmOVyXxiKYud7Pl2sjrWW
X-Google-Smtp-Source: APXvYqx6VTlxN/ERWzy0LG4RQIFWjWU0a/91PTRDtdACMKogFAD1YXZ+IirvifAVdQV4trtUuQUjug==
X-Received: by 2002:a63:618d:: with SMTP id v135mr47391935pgb.2.1553885593420;
        Fri, 29 Mar 2019 11:53:13 -0700 (PDT)
Received: from [10.67.49.126] ([192.19.223.250])
        by smtp.googlemail.com with ESMTPSA id d25sm4080109pfn.154.2019.03.29.11.53.11
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 29 Mar 2019 11:53:12 -0700 (PDT)
Subject: Re: [PATCH net-next v5 13/22] ethtool: provide driver/device
 information in GET_INFO request
To:     Jakub Kicinski <jakub.kicinski@netronome.com>,
        Jiri Pirko <jiri@resnulli.us>
Cc:     Michal Kubecek <mkubecek@suse.cz>,
        David Miller <davem@davemloft.net>, netdev@vger.kernel.org,
        Andrew Lunn <andrew@lunn.ch>,
        John Linville <linville@tuxdriver.com>,
        Stephen Hemminger <stephen@networkplumber.org>,
        linux-kernel@vger.kernel.org
References: <cover.1553532199.git.mkubecek@suse.cz>
 <b7aea4b2642b2fe6f12cfb843a03154f584f3bf6.1553532199.git.mkubecek@suse.cz>
 <20190327201411.GH14297@nanopsycho> <20190327222554.GV26076@unicorn.suse.cz>
 <20190328092126.GL14297@nanopsycho> <20190328095347.GB26076@unicorn.suse.cz>
 <20190328163439.GP14297@nanopsycho>
 <20190328130904.48905338@cakuba.netronome.com>
From:   Florian Fainelli <f.fainelli@gmail.com>
Openpgp: preference=signencrypt
Autocrypt: addr=f.fainelli@gmail.com; prefer-encrypt=mutual; keydata=
 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
 M5kY0ACeNhCZJvZ5g4C2Lc9fcTHu8jxmEkI=
Message-ID: <82a76591-5f70-59fb-2bb5-81895b6c2e7c@gmail.com>
Date:   Fri, 29 Mar 2019 11:53:03 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190328130904.48905338@cakuba.netronome.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 3/28/19 1:09 PM, Jakub Kicinski wrote:
> On Thu, 28 Mar 2019 17:34:39 +0100, Jiri Pirko wrote:
>> Thu, Mar 28, 2019 at 10:53:47AM CET, mkubecek@suse.cz wrote:
>>> On Thu, Mar 28, 2019 at 10:21:26AM +0100, Jiri Pirko wrote:  
>>>> Wed, Mar 27, 2019 at 11:25:54PM CET, mkubecek@suse.cz wrote:  
>>>>>
>>>>> I'm all for implementing new features which are are related to physical
>>>>> device (ASIC) rather than network interface only in devlink (at the
>>>>> level of kernel-userspace interface). But for features already provided
>>>>> by ethtool (userspace utility) I can't help seeing the state of devlink
>>>>> support in NIC drivers as a serious blocker.  
>>>>
>>>> What I'm thinking about at for some time now would be en explicit
>>>> default devlink and devlink_port registration for every netdev for
>>>> drivers that does not support devlink themselves. I need to think about
>>>> it more, but it seems doable. Then we can hang appropriate things there
>>>> and make the ethtoolnl/devlink separation clear. I believe we need to do
>>>> it.  
>>>
>>> That sounds great, such "generic devlink" implementation would be a way
>>> around. Kernel could then emulate features which are not implemented by
>>> an actual devlink handler (i.e. "generic devlink" is used or particular
>>> handler is missing) by falling back to ethtool_ops handler so that
>>> userspace could rely on devlink API for things like device information,
>>> various dumps, flashing etc. without losing anything.  
>>
>> Yep. Plan to do that next week.
> 
> The problem with the main part of dev info - fw_version - is that it is
> often overloaded in drivers and becomes impossible to parse for users.
> I'd rather we didn't dump that nasty chaos in devlink info and let it
> die with ethtool IOCTL.
> 
> Flashing can also be handled at user space tool level.
> 

Yes, I really like how sfc does it which is to expose MTD devices and
certainly have a custom flashing tool, that should be the way to go IMHO.
-- 
Florian
