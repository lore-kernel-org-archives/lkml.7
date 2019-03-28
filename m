Return-Path: <SRS0=Qu8K=R7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 24D68C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Mar 2019 17:00:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D9D8920823
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Mar 2019 17:00:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="f3ZLDoEX"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727647AbfC1RAc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Mar 2019 13:00:32 -0400
Received: from mail-yw1-f68.google.com ([209.85.161.68]:40814 "EHLO
        mail-yw1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726200AbfC1RAa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Mar 2019 13:00:30 -0400
Received: by mail-yw1-f68.google.com with SMTP id p64so15360054ywg.7;
        Thu, 28 Mar 2019 10:00:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:openpgp:autocrypt:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=4EOrxe9UTLfry5hUVuzXaaJnZvKkUEEYPJRN/uJkGVg=;
        b=f3ZLDoEXEW2PnXjOpFJQ1VU2zlO7cSEjIKaVuhzdXFFJmzwhkS77JCG2jk0wD7TYpO
         OazdbEAwyjUb2zbwEnhCr0d/gWMilyEFHTdb8OzZuEVd+aRHPnApqtmFRRgXTWW9dAX5
         I90s+lS90AHi0nEU/sPOOcEluE2LEloaVK5FIzZhF0tJAMg5dBKglJ1yVzMoYjKPUBaF
         zgtzsmMxAaUFy18Yn+Hg6RF4Ji2PFAd1ykwdMwSEn12dnRdCYbLkCmrSzFl/hWlMJSoM
         fh6vT1JkNeqfl5zmlckSVagPMXqW4Ad7H1B2A4CCndv2jM9aktWQSmJ7iOrFSldok07g
         ewDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:openpgp:autocrypt
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=4EOrxe9UTLfry5hUVuzXaaJnZvKkUEEYPJRN/uJkGVg=;
        b=jEFRAh+SZ5B5NA0d3QAwIhuowReWl5RXYGfkoO2N1sACx4lRSfX7qHahYW8tQX3/hK
         HSqZJ2ohzUrZviJIpf+gup5gJCA/APQcfATqev35ALrnBMNr/O2ucCe8jLShhS50gWtJ
         kMUnWl8sjAy264p9XBj4rcmhEz1VekcZ5IrxVZZ4FDsYea/pZqXDHdb+Jbt0aNJCSjmG
         akzP1TBy3kJXVBmlhvsGhzXPGc6O/YpV0xl/VCTn12wmW3Gf2rAsHb3jAoMwMoOsW9TJ
         WqynAoBLkCCBXVwPWt59yMunrE5nWJGE2A2RKJlLkzc5zhxlYw2kmPRbrg7lR5ky2kZP
         Euug==
X-Gm-Message-State: APjAAAUknn9izleiV5IuohF3H5aDfZicyX7t4f28AGbvIL7wjO9re0F3
        nCpgX0wbJVBdTTEGWfY7xuwOmF+i
X-Google-Smtp-Source: APXvYqw8S/Fp48QaDnLrhQP+6syGLXWcHRmVeXFa3eMcjv2NDtyES2k8VUkk/jhjMkcOxVtvhsQI7Q==
X-Received: by 2002:a0d:c802:: with SMTP id k2mr38307194ywd.468.1553792428954;
        Thu, 28 Mar 2019 10:00:28 -0700 (PDT)
Received: from [10.67.50.115] ([192.19.223.250])
        by smtp.googlemail.com with ESMTPSA id z20sm8944589ywa.87.2019.03.28.10.00.26
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 28 Mar 2019 10:00:28 -0700 (PDT)
Subject: Re: [PATCH net-next v5 05/22] ethtool: introduce ethtool netlink
 interface
To:     Jiri Pirko <jiri@resnulli.us>, Michal Kubecek <mkubecek@suse.cz>
Cc:     David Miller <davem@davemloft.net>, netdev@vger.kernel.org,
        Jakub Kicinski <jakub.kicinski@netronome.com>,
        Andrew Lunn <andrew@lunn.ch>,
        John Linville <linville@tuxdriver.com>,
        Stephen Hemminger <stephen@networkplumber.org>,
        linux-kernel@vger.kernel.org
References: <cover.1553532199.git.mkubecek@suse.cz>
 <8795d07d3315b232b4e7ebc7d109c9aa3185e555.1553532199.git.mkubecek@suse.cz>
 <20190326120909.GF2230@nanopsycho> <20190326132427.GK26076@unicorn.suse.cz>
 <20190326134251.GA5181@nanopsycho.orion>
 <20190327092604.GP26076@unicorn.suse.cz> <20190327095023.GC6979@nanopsycho>
 <7e883a7c-7f1a-b1a0-4735-0ad368998c65@gmail.com>
 <20190328081010.GJ14297@nanopsycho> <20190328093746.GA26076@unicorn.suse.cz>
 <20190328132316.GM14297@nanopsycho>
From:   Florian Fainelli <f.fainelli@gmail.com>
Openpgp: preference=signencrypt
Autocrypt: addr=f.fainelli@gmail.com; prefer-encrypt=mutual; keydata=
 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
 M5kY0ACeNhCZJvZ5g4C2Lc9fcTHu8jxmEkI=
Message-ID: <5edb07f0-427f-8a06-97f5-d904b4a50cc1@gmail.com>
Date:   Thu, 28 Mar 2019 10:00:20 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.1
MIME-Version: 1.0
In-Reply-To: <20190328132316.GM14297@nanopsycho>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 3/28/19 6:23 AM, Jiri Pirko wrote:
> Thu, Mar 28, 2019 at 10:37:46AM CET, mkubecek@suse.cz wrote:
>> On Thu, Mar 28, 2019 at 09:10:10AM +0100, Jiri Pirko wrote:
>>> Thu, Mar 28, 2019 at 03:05:14AM CET, f.fainelli@gmail.com wrote:
>>>>
>>>>
>>>> On 3/27/2019 2:50 AM, Jiri Pirko wrote:
>>>>>
>>>>> Why don't you have ETHTOOL_MSG_SET_FOO for set? I think that for
>>>>> kerne->userspace the ETHTOOL_MSG_FOO if fine. I would change the
>>>>> ordering of words thought, but it is cosmetics:
>>>>> ETHTOOL_MSG_FOO /* kernel->userspace messages - replies, notifications */
>>>>> ETHTOOL_MSG_FOO_GET
>>>>> ETHTOOL_MSG_FOO_SET
>>>>> ETHTOOL_MSG_FOO_ACT
>>>>>
>>>>> What do you think?
>>>>
>>>> We could even name the notification explicitly with: ETHTOOL_MSG_NOTIF
>>>> or ETHTOOL_MSG_NTF just so we spell out exactly what those messages are.
>>>
>>> Sound good. Something like:
>>>
>>> ETHTOOL_MSG_FOO_GET
>>> ETHTOOL_MSG_FOO_GET_RPLY /* kernel->userspace replies to get */
>>> ETHTOOL_MSG_FOO_SET
>>> ETHTOOL_MSG_FOO_ACT
>>> ETHTOOL_MSG_FOO_NTF /* kernel->userspace async messages - notifications */
>>
>> The names sound fine to me and having different message ids would still
>> allow processing messages by the same handler easily.
>>
>> But there is one potential issue I would like to point out: this way we
>> spend 4 message ids for a get/set pair rather than 2. These message ids
>> (genlmsghdr::cmd) are u8, i.e. the resource is not as infinite as one
>> would wish. There are 80 ioctl commands (43 "get" and 29 "set") at the
>> moment.
>>
>> Netlink API should be less greedy in general. I already combined some
>> ioctl commands into one netlink request type and with an easy way to add
>> new attributes to existing commands, we won't need to add new commands
>> as often (certainly not in a way which left us with 9 "get" and 9 "set"
>> ioctl commands for netdev features). So even with 4 ids per get/set
>> pair, we might be safe for reasonably long time. But it's still
>> something to keep in mind.
> 
> There are still 16 bits reserve in genl msg header:
> struct genlmsghdr {
>         __u8    cmd;
>         __u8    version;
>         __u16   reserved;
> };
> 

And you know not all message IDs will be making sense depending on the
direction, so aliasing specific message IDs to an existing value should
be fine?
-- 
Florian
