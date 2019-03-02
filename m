Return-Path: <SRS0=OfNL=RF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 52DBFC43381
	for <linux-kernel@archiver.kernel.org>; Sat,  2 Mar 2019 03:33:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F2CF220838
	for <linux-kernel@archiver.kernel.org>; Sat,  2 Mar 2019 03:33:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Y11dACsM"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727767AbfCBDdb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 1 Mar 2019 22:33:31 -0500
Received: from mail-pl1-f193.google.com ([209.85.214.193]:41684 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726412AbfCBDdb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Mar 2019 22:33:31 -0500
Received: by mail-pl1-f193.google.com with SMTP id y5so12387671plk.8;
        Fri, 01 Mar 2019 19:33:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:references:from:openpgp:autocrypt:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=5uRhLd/5OEOTEeXNeoR+e/vYCw35+cUUT0IbziL42Xs=;
        b=Y11dACsM910XxEEeqxL2uE65K4mwAgnOvDToZLDrdyugT6Jp4kSy4j/0pMyKoTV53y
         TLjMpOlw0eGtIdacdL0I3F1zlQD8mnq0ldgNdkgHljNytO93F/nbMqojbhHBMKBcze05
         aQsO+kczyqm9P4kLaa9WaUb+XTmM2JjRiHdaO7rml9HYrNkMV2IhiyxBtI5Nej+CunxN
         k9dpS3+IskXz0m9olN7WAZ+G/ds+Cs/wYDkjOAZO5Db0RkhFcr1BgXX76u4igF9pprCj
         bB0tv9v47gK+IBNF54N30T+i0oyt2dq21FYblYzfaRoePg/g1spbCfBQcPLzstzxHLlK
         v8hQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:openpgp:autocrypt
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=5uRhLd/5OEOTEeXNeoR+e/vYCw35+cUUT0IbziL42Xs=;
        b=nivSfnZPYC3LqZ6odvkExqAHuZdio/eTFHhx9rF/9mJUm7dKXBLwALSCaWHhEsbVVu
         o8j8jvQ0kngFJW0Qt3el3EoCtwBb1wTYApHYr5Nt3RN4lPgv+xyEnOL2w1hMBVvYUpiH
         Z/aJwdKcf9YTrzon7MQfA+SgjY4B6i7KiNflCweFA/TBXwcZ62OdebXS8myVPXXr6Db5
         imYoVQjm//5TholD+TTttcJ+JxJUU2V+5qdDmMRdz1IOs+Gtlxjt0j43nL0qqTFO/Gk7
         biMUrBXOPCu1/tMN+mbFlw/QtzEboExLfSPnDovcpbYJQAywf2hO6z/D6dZPQPaa3DRw
         Tl0A==
X-Gm-Message-State: APjAAAVQ4Fa3gZqs8JIo3s71FjgnaxMXXhEgik7/rcRwgagcF2NO0Vm5
        LUxLr+ksJKQcf5ozOB3mHpwVAod/
X-Google-Smtp-Source: APXvYqw+MQvPtVFiaoreh4jZ0ga16sTuf1scBWjtUyemsE3gQ0g2/b4MtEgE6CvNhttXkUZVR8Zlfg==
X-Received: by 2002:a17:902:14b:: with SMTP id 69mr8786059plb.120.1551497609969;
        Fri, 01 Mar 2019 19:33:29 -0800 (PST)
Received: from [10.230.26.115] ([192.19.224.250])
        by smtp.gmail.com with ESMTPSA id y16sm8020016pfa.69.2019.03.01.19.33.27
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 01 Mar 2019 19:33:29 -0800 (PST)
Subject: Re: [PATCH net-next 4/6] ethernet: eth: add default vid len for all
 ehternet kind devices
To:     davem@davemloft.net, grygorii.strashko@ti.com,
        linux-omap@vger.kernel.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, jiri@mellanox.com,
        ilias.apalodimas@linaro.org
References: <20190226184556.16082-1-ivan.khoronzhuk@linaro.org>
 <20190226184556.16082-5-ivan.khoronzhuk@linaro.org>
 <30890ef3-7da8-8399-7388-cc22e000a67f@gmail.com>
 <20190301131153.GD4851@khorivan>
From:   Florian Fainelli <f.fainelli@gmail.com>
Openpgp: preference=signencrypt
Autocrypt: addr=f.fainelli@gmail.com; keydata=
 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
 w0j9Sw==
Message-ID: <2f3bd59c-0662-7f8c-de22-28fd6a81067a@gmail.com>
Date:   Fri, 1 Mar 2019 19:33:26 -0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.2
MIME-Version: 1.0
In-Reply-To: <20190301131153.GD4851@khorivan>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 3/1/2019 5:11 AM, Ivan Khoronzhuk wrote:
> On Wed, Feb 27, 2019 at 08:29:20PM -0800, Florian Fainelli wrote:
>>
>>
>> On 2/26/2019 10:45 AM, Ivan Khoronzhuk wrote:
>>> IVDF - individual virtual device filtering. Allows to set per vlan
>>> l2 address filters on end real network device (for unicast and for
>>> multicast) and drop redundant not expected packet income.
>>>
>>> If CONFIG_VLAN_8021Q_IVDF is enabled the following changes are
>>> applied, and only for ethernet network devices.
>>>
>>> By default every ethernet netdev needs vid len = 2 bytes to be able to
>>> hold up to 4096 vids. So set it for every eth device to be correct,
>>> except vlan devs.
>>>
>>> In order to shrink all addresses of devices above vlan, the vid_len
>>> for vlan dev = 0, as result all suckers sync their addresses to common
>>> base not taking in to account vid part (vid_len of "to" devices is
>>> important only). And only vlan device is the source of addresses with
>>> actual its vid set, propagating it to parent devices while rx_mode().
>>>
>>> Also, don't bother those ethernet devices that at this moment are not
>>> moved to vlan addressing scheme, so while end ethernet device is
>>> created - set vid_len to 0, thus, while syncing, its address space is
>>> concatenated to one dimensional like usual, and who needs IVDF - set
>>> it to NET_8021Q_VID_TSIZE.
>>>
>>> There is another decision - is to inherit vid_len or some feature flag
>>> from end root device in order to all upper devices have vlan extended
>>> address space only if exact end real device have such capability. But
>>> I didn't, because it requires more changes and probably I'm not
>>> familiar with all places where it should be inherited, I would
>>> appreciate if someone can guid where it's applicable, then it could
>>> become a little bit more limited.
>>
>> I would think that a call to vlan_dev_ivdf_set() would be enough to
>> indicate that the underlying network device driver supports IVDF and
>> wants to make use of it. The infrastructure itself that you added costs
>> little memory, it is once the call to vlan_dev_ivdf_set() is made that
>> the memory consumption increases which is fine, since we want to make
>> use of that feature.
>>
>> While I appreciate the thoughts given to making this a configurable
>> option, I feel that enabling it unconditionally and having the
>> underlying driver decide would be more manageable.
> 
> Not exactly. Even system has no driver calling vlan_dev_ivdf_set()
> I still has this "mem consumption" from the very beginning. That's why I
> made
> this depended on the driver and CONF. For embedded world it looks fine.
> 
> The issues is that I can't change addressing scheme dynamically since some
> drivers and infrastructure that exists before I called vlan_dev_ivdf_set()
> can already have some synced addresses using old scheme. To do this
> dynamically it needs unsync vlans from old scheme and make sync again.
> Probably that is topic to "sync" :-| about....

Good one, that would be very complicated indeed.

> 
> I considered idea making "above infrastructure" IVDF to be dependent on
> underneath end device IVDF and remove this config at all, but here several
> issues with this, the infrastructure has to be "resynced" and some
> signal has
> to inform each vlan to do this, and while this happens, all end devices
> already
> configured and not supported IVDF shouldn't suffer. I can try but it
> looks not
> doable in normal way, and appreciate any thoughts about this.
> 
> Meanwhile, this option looks fine for small embedded paltforms.
> 
>>
>> We have had that conversation before, but let me ask again when we call
>> dev_{uc,mc}_sync() and ultimately the network device's
>> ndo_set_rx_mode(), by the time the ndo_set_rx_mode() function is called,
>> we lost track of the call chain, like which virtual device was it
>> originating from. If we somehow added a notification information about
>> the network device stack (and we could use netdevice notifiers for
>> that), then maybe we don't really need to add all of this code and we
>> can just derive the necessary bits of information we want by checking:
>> is this a VLAN network device? It is, okay what's your VLAN ID, etc.?
>>
>> Either approach would get us our cookie anyway :)
> 
> Postulate here is that address of vlan device is separate from netdevice
> entity
> with it's own context.
> 
> Several cases talking about this:
> 
> - bound device having 2 slaves can have added vid to both slave devices but
> synced addresses for only one of them. So, if vid is set in real device
> it doesn't mean it needs addresses of vlan device.
> 
> - I know that's crazy, but net device tree can contain 2 same vlan
> devices ).
> The scheme doesn't prevent this case. So one vid address can be counted
> by two
> vlan network devices.
> 
> - Any of the devices in _sync/rx_mode() chain is legal to do with addresses
> what ever it's allowed to do, drop some of them, combine with others and
> more,
> even add it's own vid addresses w/o actual vlan network device.
> 
> These made me to look in side of building rx_sync netdevice tree holding
> links
> on nodes per each address. And I've did this mostly...then after short look
> on this asked myself "who is going to support this ..." and it anyway
> doesn't
> cover all possible cases.
> 
> So, lost track of the device looks not so bad and opens more possibilities.

Sounds like you did give a lot of thoughts about the scheme, I am fine
with the current approach and will hook it up to DSA next week to make
sure this resolves the current issues I had with VLAN filtering enabled.
Thanks Ivan!
-- 
Florian
