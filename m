Return-Path: <SRS0=6SCO=RE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 80339C43381
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Mar 2019 12:21:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 464A520851
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Mar 2019 12:21:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="MEH/KoLC"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388195AbfCAMVO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 1 Mar 2019 07:21:14 -0500
Received: from mail-lj1-f194.google.com ([209.85.208.194]:35421 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388124AbfCAMVM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Mar 2019 07:21:12 -0500
Received: by mail-lj1-f194.google.com with SMTP id t13so15834801lji.2
        for <linux-kernel@vger.kernel.org>; Fri, 01 Mar 2019 04:21:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:mail-followup-to:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=FpAHPexo4EgurSuridiad74zEUWlpCxNg+eUgcImHpA=;
        b=MEH/KoLCVQ1RDdcpEVZSyf5Dlwm9ef6p48xTCyo5ht+EZ1QLNT2gzabZ2+c8I2fZ2Z
         4tmTpxijwUGi/uu3JGKqJV2MrFUGsgdtKKD2oCMIToGjpk1iKpx+JVzfrv7sGuO4/xeY
         fMYHYaItX7aJVgTVR3q5cpkehwvZCRRdipONUU8MHfBBAOWpuysdQc7SH9okZCepoZaz
         9nfuSAqmlOfuS+ho1HRzCF4Q+7X/rWEuc9iPRTYUnGC3esermrIkYqtfJZ2ntRf108A6
         blap3+musTp0ITfHOX/H4E1qIUSeYkRsgU3LbGW+fYKUNJJjPhTQZSvzo/KKysSSil83
         ywxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id
         :mail-followup-to:references:mime-version:content-disposition
         :in-reply-to:user-agent;
        bh=FpAHPexo4EgurSuridiad74zEUWlpCxNg+eUgcImHpA=;
        b=qgWa0jZ2L/mH/2B7tNW0wxRwozamEMmXczQWr/y/1co3Rp/rGn51ONkDixeUQqUrki
         2T8mD/xhjrUux2tmp+Ksy9sVQH4iT6orC2ITz9P/Da1w7DR2g3zNeIrf0WOhRe0EhtTG
         pG4PXCGHojJ9SpebeX9LmrqVxITNAgTRk4dunRaMyQj0f+wdPwG7HjY5OzL22+iS9OsR
         rBnlV2y/RwcHJji9CTcnkndS1/acE/P4AudYHET5xZ4XW+Mn1Fn8lBd6HCCortKDF1qs
         X7CcJdaB3bJ6om5i/DBjKJtbpdAIvhs8ocXLwlTN3j3IqnoWaob7RufM3zb4xdoGp7Dm
         Xhig==
X-Gm-Message-State: APjAAAUmymRbwmMaV1CPrtiLNTcDmglm+FLY0ecj80WKMna1ZM+Ce/BN
        iCT72ehJkPj3OOIl+bvtBNanhQ==
X-Google-Smtp-Source: APXvYqz7BvYjsF1wi0W2QaM/D+kR9Vq7xfdMyKRdzs5IR8aWlSjDk9yYABFzav0lHuY9LJHjR/RSRg==
X-Received: by 2002:a2e:9e09:: with SMTP id e9mr2543571ljk.14.1551442870664;
        Fri, 01 Mar 2019 04:21:10 -0800 (PST)
Received: from khorivan (59-201-94-178.pool.ukrtel.net. [178.94.201.59])
        by smtp.gmail.com with ESMTPSA id b15sm4592360ljj.70.2019.03.01.04.21.09
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 01 Mar 2019 04:21:10 -0800 (PST)
Date:   Fri, 1 Mar 2019 14:21:08 +0200
From:   Ivan Khoronzhuk <ivan.khoronzhuk@linaro.org>
To:     Florian Fainelli <f.fainelli@gmail.com>
Cc:     davem@davemloft.net, grygorii.strashko@ti.com,
        linux-omap@vger.kernel.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, jiri@mellanox.com,
        ilias.apalodimas@linaro.org
Subject: Re: [PATCH net-next 1/6] net: core: dev_addr_lists: add VID to
 device address
Message-ID: <20190301122107.GA4851@khorivan>
Mail-Followup-To: Florian Fainelli <f.fainelli@gmail.com>,
        davem@davemloft.net, grygorii.strashko@ti.com,
        linux-omap@vger.kernel.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, jiri@mellanox.com,
        ilias.apalodimas@linaro.org
References: <20190226184556.16082-1-ivan.khoronzhuk@linaro.org>
 <20190226184556.16082-2-ivan.khoronzhuk@linaro.org>
 <462e8b28-fc15-9321-2144-038a18e37170@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <462e8b28-fc15-9321-2144-038a18e37170@gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 27, 2019 at 08:24:00PM -0800, Florian Fainelli wrote:
>On 2/26/2019 10:45 AM, Ivan Khoronzhuk wrote:
>> Despite this is supposed to be used for Ethernet VLANs, not Ethernet
>> addresses with space for VID also can reuse this, so VID is considered
>> as virtual ID extension, not belonging strictly to Ethernet VLAN VIDs,
>> and overall change can be named individual virtual device filtering
>> (IVDF).
>>
>> This patch adds VID tag at the end of each address. The actual
>> reserved address size is 32 bytes. For Ethernet addresses with 6 bytes
>> long that's possible to add tag w/o increasing address size. Thus,
>> each address for the case has 32 - 6 = 26 bytes to hold additional
>> info, say VID for virtual device addresses.
>>
>> Therefore, when addresses are synced to the address list of parent
>> device the address list of latter can contain separate addresses for
>> virtual devices. It allows to track separate address tables for
>> virtual devices if they present and the device can be placed on
>> any place of device tree as the address is propagated to to the end
>> real device thru *_sync()/ndo_set_rx_mode() APIs. Also it simplifies
>> handling VID addresses at real device when it supports IVDF.
>>
>> If parent device doesn't want to have virtual addresses in its address
>> space the vid_len has to be 0, thus its address space is "shrunk" to
>> the state as before this patch. For now it's 0 for every device. It
>> allows two devices with and w/o IVDF to be part of same bond device
>> for instance.
>>
>> The end real device supporting IVDF can retrieve VID tag from an
>> address and set it for a given virtual device only. By default, vid 0
>> is used for real devices to distinguish it from virtual addresses.
>>
>> See next patches to see how it's used.
>>
>> Signed-off-by: Ivan Khoronzhuk <ivan.khoronzhuk@linaro.org>
>> ---
>
>[snip]
>
>
>> @@ -1889,6 +1890,7 @@ struct net_device {
>>  	unsigned char		perm_addr[MAX_ADDR_LEN];
>>  	unsigned char		addr_assign_type;
>>  	unsigned char		addr_len;
>> +	unsigned char		vid_len;
>
>Have not compiled or tested this patch series yet, but did you check
>that adding this member does not change the structure layout (you can
>use pahole for that purpose).

For ARM 32, on 1 hole less:
---------------------------

before (https://pastebin.com/DG1SVpFR):

/* size: 1344, cachelines: 21, members: 123 */
/* sum members: 1304, holes: 5, sum holes: 28 */
/* padding: 12 */
/* bit_padding: 31 bits */

after (https://pastebin.com/ZUMhxGkA):

/* size: 1344, cachelines: 21, members: 124 */
/* sum members: 1305, holes: 5, sum holes: 27 */
/* padding: 12 */
/* bit_padding: 31 bits */


For ARM 64, on 1 hole less:
---------------------------

before (https://pastebin.com/5CdTQWkc):

/* size: 2048, cachelines: 32, members: 120 */
/* sum members: 1972, holes: 7, sum holes: 48 */
/* padding: 28 */
/* bit_padding: 31 bits */

after (https://pastebin.com/32ktb1iV):

/* size: 2048, cachelines: 32, members: 121 */
/* sum members: 1973, holes: 7, sum holes: 47 */
/* padding: 28 */
/* bit_padding: 31 bits */

Looks Ok, but it depends on configuration ...

>
>>  	unsigned short		neigh_priv_len;
>>  	unsigned short          dev_id;
>>  	unsigned short          dev_port;
>> @@ -4141,8 +4143,10 @@ int dev_addr_init(struct net_device *dev);
>>
>>  /* Functions used for unicast addresses handling */
>>  int dev_uc_add(struct net_device *dev, const unsigned char *addr);
>> +int dev_vid_uc_add(struct net_device *dev, const unsigned char *addr);
>>  int dev_uc_add_excl(struct net_device *dev, const unsigned char *addr);
>>  int dev_uc_del(struct net_device *dev, const unsigned char *addr);
>> +int dev_vid_uc_del(struct net_device *dev, const unsigned char *addr);
>>  int dev_uc_sync(struct net_device *to, struct net_device *from);
>>  int dev_uc_sync_multiple(struct net_device *to, struct net_device *from);
>>  void dev_uc_unsync(struct net_device *to, struct net_device *from);
>> diff --git a/net/core/dev_addr_lists.c b/net/core/dev_addr_lists.c
>> index a6723b306717..e3c80e044b8c 100644
>> --- a/net/core/dev_addr_lists.c
>> +++ b/net/core/dev_addr_lists.c
>> @@ -545,6 +545,26 @@ int dev_addr_del(struct net_device *dev, const unsigned char *addr,
>>  }
>>  EXPORT_SYMBOL(dev_addr_del);
>>
>> +static int get_addr_len(struct net_device *dev)
>> +{
>> +	return dev->addr_len + dev->vid_len;
>> +}
>> +
>> +static int set_vid_addr(struct net_device *dev, const unsigned char *addr,
>> +			unsigned char *naddr)
>
>Having some kernel doc comments here would be nice to indicate that the
>return value is dev->addr_len, it was not obvious until I saw in the
>next function how you used it.

Agree

>
>> +{
>> +	int i;
>> +
>> +	if (!dev->vid_len)
>> +		return dev->addr_len;
>> +
>> +	memcpy(naddr, addr, dev->addr_len);
>> +	for (i = 0; i < dev->vid_len; i++)
>> +		naddr[dev->addr_len + i] = 0;
>
>memset(naddr + dev->addr_len, 0, dev->vid_len) would be more compact and
>maybe a little less error prone too?

Yes, would be

-- 
Regards,
Ivan Khoronzhuk
