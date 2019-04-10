Return-Path: <SRS0=SZ1Q=SM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4A39DC10F11
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Apr 2019 20:15:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 122B62070D
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Apr 2019 20:15:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WmuuYEdu"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726656AbfDJUPZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 10 Apr 2019 16:15:25 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:36466 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726014AbfDJUPZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Apr 2019 16:15:25 -0400
Received: by mail-wr1-f67.google.com with SMTP id y13so4456236wrd.3;
        Wed, 10 Apr 2019 13:15:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=hK9vGrAk24MGIuEya3ulbjyPd4hoU272JXR2LsCNHAw=;
        b=WmuuYEduD9Ic6wTOl9z2WzbU8JZiOn3fSt7YbtKYfdjJJoooXerZMGAVHteUjpyYv5
         VDPe3tijW6GKa5a886WARw5gshzy5NAzc2LVWQkxLDTc+jgfGRPceCMB4gPJoV1TyY7d
         ekusHQhmRX+Bi9cnMzsaQWpt5F+xEsyDdOr196+BeDgpyW9DLchgJsfNbOEkAb7G+bEx
         d/zRN7nSGyMXVtA1RoM4ApIKLvnS2sbWZF1KiOpdqSZ+N6uUAuHb0QGpXmkm4e2YlzmS
         kxP8+EsuRR0HdkJ/V+RmE/Q4ZNU4sztSRQqlK8mS2VQFkMG3EbudtD7febTYU16zyJTx
         ZhxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=hK9vGrAk24MGIuEya3ulbjyPd4hoU272JXR2LsCNHAw=;
        b=ET5l7eyIlv9yVfDyJXgBge/PKz9Qr7F3uXUpEawWW66KNfBPLDaQ/T1761We3U+uwu
         f/5/3ayQVO3EonjZ59g9DZGdqKWCAuZVKxnAGs2j3wM99Mwut/G9qLwvt2zK2OwGuKO0
         KzghSICIL8cZJ2eFyr5Bh6o3hWOnh2B67o7sgbZjxoJzUPDHcae7zEIbanvk7dAhV/fI
         7fzoMYYrFFhFelifdCkoRLz94bQZzpriHd2h+Q+reiQRJ/4Odrxej5yM+aSnr0OYUBZ3
         WnzziX97d2PllaaJwuH69iyybfJVvqdMCaAsOnW8end47ELqI5cFHsswOUg0bmP237pV
         Y91A==
X-Gm-Message-State: APjAAAVqUolf2g3LoCmeaRHcy0hZNVo4hOhiXW2Elo7+Do9HBvcSj4jU
        2z1GDbpDLL6K51/ycgYY9o8=
X-Google-Smtp-Source: APXvYqyRlowiYDuL6F4fg2IidY8yN3FTxNRrjW66mpLJFO2zPsEH6KfmwHD6Iq6t79advobG7FmClQ==
X-Received: by 2002:adf:e78e:: with SMTP id n14mr5632166wrm.14.1554927323018;
        Wed, 10 Apr 2019 13:15:23 -0700 (PDT)
Received: from [192.168.1.2] (5-12-225-227.residential.rdsnet.ro. [5.12.225.227])
        by smtp.gmail.com with ESMTPSA id v184sm6394881wma.6.2019.04.10.13.15.21
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 10 Apr 2019 13:15:22 -0700 (PDT)
Subject: Re: [PATCH v2 net-next 05/22] net: dsa: Add more convenient functions
 for installing port VLANs
To:     Florian Fainelli <f.fainelli@gmail.com>, vivien.didelot@gmail.com,
        andrew@lunn.ch, davem@davemloft.net
Cc:     netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        georg.waibel@sensor-technik.de
References: <20190410005700.31582-1-olteanv@gmail.com>
 <20190410005700.31582-6-olteanv@gmail.com>
 <d9f4ec44-7cc6-0ffe-9d02-eb1b1b818340@gmail.com>
From:   Vladimir Oltean <olteanv@gmail.com>
Message-ID: <86d31830-bd53-2800-932b-de610586a5fb@gmail.com>
Date:   Wed, 10 Apr 2019 23:15:21 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.1
MIME-Version: 1.0
In-Reply-To: <d9f4ec44-7cc6-0ffe-9d02-eb1b1b818340@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 4/10/19 5:01 AM, Florian Fainelli wrote:
> On 4/9/2019 5:56 PM, Vladimir Oltean wrote:
>> This hides the need to perform a two-phase transaction and construct a
>> switchdev_obj_port_vlan struct.
>>
>> Call graph (including a function that will be introduced in a follow-up
>> patch) looks like this now (same for the *_vlan_del function):
>>
>> dsa_slave_vlan_rx_add_vid   dsa_port_setup_8021q_tagging
>>              |                        |
>>              |                        |
>>              |          +-------------+
>>              |          |
>>              v          v
>>             dsa_port_vid_add      dsa_slave_port_obj_add
>>                    |                         |
>>                    +-------+         +-------+
>>                            |         |
>>                            v         v
>>                         dsa_port_vlan_add
>>
>> Signed-off-by: Vladimir Oltean <olteanv@gmail.com>
>> ---
>> Changes in v2:
>> Renamed __dsa_port_vlan_add to dsa_port_vid_add and not to
>> dsa_port_vlan_add_trans, as suggested, because the corresponding _del function
>> does not have a transactional phase and the naming is more uniform this way.
> 
> Thanks the name does look a lot better now.
> 
> [snip]
> 
>> +int dsa_port_vid_del(struct dsa_port *dp, u16 vid)
>> +{
>> +	struct switchdev_obj_port_vlan vlan = {
>> +		.obj.id = SWITCHDEV_OBJ_ID_PORT_VLAN,
>> +		.vid_begin = vid,
>> +		.vid_end = vid,
>> +	};
> 
> Any reasons why this function does not take a flags argument? Also, did
> you intend to migrate dsa_slave_vlan_rx_kill_vid() to use this helper
> for deleting a VLAN ID?
> 

Hi Florian,

I don't think there's any semantics associated to deleting a VLAN with 
flags. The br_switchdev_port_vlan_del() function doesn't set the flags 
either.
And as for the dsa_slave_vlan_rx_kill_vid(), it wasn't an oversight, I 
just thought that the benefits weren't as great as in the case of *_add. 
I do see that not doing it somewhat breaks the uniformity and makes the 
commit message slightly inaccurate, so I can fix that up if you think 
it's necessary.

Thanks,
-Vladimir
