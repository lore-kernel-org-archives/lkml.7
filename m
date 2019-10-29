Return-Path: <SRS0=sYEh=YW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E1118CA9EAE
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Oct 2019 09:40:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A36342087F
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Oct 2019 09:40:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ncentric-com.20150623.gappssmtp.com header.i=@ncentric-com.20150623.gappssmtp.com header.b="b7Wvn9TY"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729948AbfJ2JkL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 29 Oct 2019 05:40:11 -0400
Received: from mail-wm1-f67.google.com ([209.85.128.67]:55811 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728684AbfJ2JkL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Oct 2019 05:40:11 -0400
Received: by mail-wm1-f67.google.com with SMTP id g24so1743941wmh.5
        for <linux-kernel@vger.kernel.org>; Tue, 29 Oct 2019 02:40:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ncentric-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=2Aa5j2eV/0WKF03bDFsIwtghRGSKb/OqNGsEyVUDvWw=;
        b=b7Wvn9TYfGj9kmhJZFlMf0XSxya4fT2WHQUdC9GD4TP99uxK3aR55urIElBfE0YGRc
         SrdjJ0UtTiQhsA0a5PXzKo1xDTLywFg8w4FbuhuEdWJvVkYXmR3mPL47gc8cGG1HL/So
         zZhhMnoQai5MOJnRY3CV0itPx0qrD53DBC0gujZ6bJYV2l4xbhLjimkVKFYU0Fem2Bv8
         I4XmrSFAFDF+K2VlY2I0OglJQKSjNP/Dag6k9dWCMctxRdXdaXRp+OvaGWlfILAkocwT
         3uCbPr5qTQcw4MYPyH5Yhgd3VreRJptew48RprMLz1kRyL6CvMA5+hm7GL1q+8UEVrVj
         F+sw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=2Aa5j2eV/0WKF03bDFsIwtghRGSKb/OqNGsEyVUDvWw=;
        b=r9/fz+Tc6Muff2rIH4zkJ9R6BEqEJUaIqxxzh1ASdon7De2bFthtE9vc9sGIV6H5rN
         tcfNTmHgSvnOaAMj8mS4Ak1HO4nW2xVY0+loreUgHtUPkiY24RoPCVg0NPPt2phi0Fsd
         CfrhMXwAfKB0AY7KOFlrunwMG0/X8EaKVdP/8sg/EnDW6ILs2DOWb/zaATvHXa6wWfBQ
         S/9vlhZSyFnqDG81y0hx4zab5qatrPpU6pVfdQCknVHNg8yiepDjN4Ph89T25wgeaiGM
         372wsYKROshhaiIba0xGu5GIJYFuxU59X/yEhStygqoOsemtE4XecN1LZ2BpuqYvtLW7
         itfg==
X-Gm-Message-State: APjAAAVxSe1P7MbViyRxPsDb89MDkd62v64goK0Z2UH0RDfqOEjerl64
        4krzQT75LFeUm+GR7w47p4UO0jhxaR0=
X-Google-Smtp-Source: APXvYqybfJwsbSSLUwelX1MCkNxRbHTiindnv/Z3xFpqXx2ui62l5VksJqY5AC/XaTjKFMQQK0R9OA==
X-Received: by 2002:a1c:ed0e:: with SMTP id l14mr3125989wmh.102.1572342008103;
        Tue, 29 Oct 2019 02:40:08 -0700 (PDT)
Received: from [192.168.3.176] (d515300d8.static.telenet.be. [81.83.0.216])
        by smtp.gmail.com with ESMTPSA id v8sm16115329wra.79.2019.10.29.02.40.07
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 29 Oct 2019 02:40:07 -0700 (PDT)
Subject: Re: [PATCH v2] 802.11n IBSS: wlan0 stops receiving packets due to
 aggregation after sender reboot
To:     Sebastian Gottschall <s.gottschall@newmedia-net.de>,
        Johannes Berg <johannes@sipsolutions.net>,
        =?UTF-8?Q?Krzysztof_Ha=c5=82asa?= <khalasa@piap.pl>
Cc:     "David S. Miller" <davem@davemloft.net>,
        linux-wireless@vger.kernel.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <m34l02mh71.fsf@t19.piap.pl> <m37e4tjfbu.fsf@t19.piap.pl>
 <e5b07b4ce51f806ce79b1ae06ff3cbabbaa4873d.camel@sipsolutions.net>
 <30465e05-3465-f496-d57f-5e115551f5cb@ncentric.com>
 <b51030e8-7c56-0e24-4454-ff70f83d5ae8@newmedia-net.de>
From:   Koen Vandeputte <koen.vandeputte@ncentric.com>
Message-ID: <8c4325e2-6ec6-59f1-89df-36392f674530@ncentric.com>
Date:   Tue, 29 Oct 2019 10:40:07 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <b51030e8-7c56-0e24-4454-ff70f83d5ae8@newmedia-net.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 29.10.19 09:58, Sebastian Gottschall wrote:
> 35 km? for 802.11n with ht40 this is out of the ack timing range the 
> chipset supports. so this should be considered at any troubles with 
> connections
>
(Please don't top-post)

When we know a link can exceed ~ 21km, it's set to HT20 for this reason.

Koen

> Am 29.10.2019 um 09:41 schrieb Koen Vandeputte:
>>
>> On 28.10.19 13:21, Johannes Berg wrote:
>>> On Fri, 2019-10-25 at 12:21 +0200, Krzysztof Hałasa wrote:
>>>> Fix a bug where the mac80211 RX aggregation code sets a new 
>>>> aggregation
>>>> "session" at the remote station's request, but the head_seq_num
>>>> (the sequence number the receiver expects to receive) isn't reset.
>>>>
>>>> Spotted on a pair of AR9580 in IBSS mode.
>>>>
>>>> Signed-off-by: Krzysztof Halasa <khalasa@piap.pl>
>>>>
>>>> diff --git a/net/mac80211/agg-rx.c b/net/mac80211/agg-rx.c
>>>> index 4d1c335e06e5..67733bd61297 100644
>>>> --- a/net/mac80211/agg-rx.c
>>>> +++ b/net/mac80211/agg-rx.c
>>>> @@ -354,10 +354,13 @@ void ___ieee80211_start_rx_ba_session(struct 
>>>> sta_info *sta,
>>>>                */
>>>>               rcu_read_lock();
>>>>               tid_rx = rcu_dereference(sta->ampdu_mlme.tid_rx[tid]);
>>>> -            if (tid_rx && tid_rx->timeout == timeout)
>>>> +            if (tid_rx && tid_rx->timeout == timeout) {
>>>> +                tid_rx->ssn = start_seq_num;
>>>> +                tid_rx->head_seq_num = start_seq_num;
>>>>                   status = WLAN_STATUS_SUCCESS;
>>> This is wrong, this is the case of *updating an existing session*, we
>>> must not reset the head SN then.
>>>
>>> I think you just got very lucky (or unlucky) to have the same dialog
>>> token, because we start from 0 - maybe we should initialize it to a
>>> random value to flush out such issues.
>>>
>>> Really what I think probably happened is that one of your stations lost
>>> the connection to the other, and didn't tell it about it in any way 
>>> - so
>>> the other kept all the status alive.
>>>
>>> I suspect to make all this work well we need to not only have the fixes
>>> I made recently to actually send and parse deauth frames, but also to
>>> even send an auth and reset the state when we receive that, so if we
>>> move out of range and even the deauth frame is lost, we can still reset
>>> properly.
>>>
>>> In any case, this is not the right approach - we need to handle the
>>> "lost connection" case better I suspect, but since you don't say what
>>> really happened I don't really know that that's what you're seeing.
>>>
>>> johannes
>>
>> Hi all,
>>
>> I can confirm the issue as I'm also seeing this sometimes in the 
>> field here.
>>
>> Sometimes when a devices goes out of range and then re-enters,
>> the link refuses to "come up", as in rx looks to be "stuck" without 
>> any reports in system log or locking issues (lockdep enabled)
>>
>> I have dozens of devices installed offshore (802.11n based), both on 
>> static and moving assets,
>> which cover from short (250m) up to very long distances (~35km)
>>
>> So .. while there is some momentum for this issue,
>> I'm more than happy to provide extensive testing should fixes be 
>> posted regarding IBSS in general.
>>
>> Regards,
>>
>> Koen
>>
>>
