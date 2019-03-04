Return-Path: <SRS0=91bA=RH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2B92FC43381
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Mar 2019 18:10:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EB277206BA
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Mar 2019 18:10:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="seZ1Ls2x"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727577AbfCDSKi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 4 Mar 2019 13:10:38 -0500
Received: from mail-wr1-f68.google.com ([209.85.221.68]:33586 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726095AbfCDSKi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Mar 2019 13:10:38 -0500
Received: by mail-wr1-f68.google.com with SMTP id i12so6610951wrw.0;
        Mon, 04 Mar 2019 10:10:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=OGfXcYbnn3m3u5865QGto1JIPL4VYtqkDmIO+n2mR9Y=;
        b=seZ1Ls2x6KNoSIMCbDWgA0YF4yQbLRArFj6Yxms5HHPWXU7Q+uegvV7laES69XHF6o
         GVeeMRp49/r2P2lIZfvd11DuCTEy5/a2kVnqhvGTKFUPPw5Por/gubXuOkFe0x/5W2Ha
         EHnsizAfHzOTfsiHRbxaj40swhhZ6AfCp5IWY9rXa5CbPk3moVXDWb7lJ4+SeOztEfQQ
         4xipv2t8Kv0opeuRMRHEsOEf19/WwABjqjqgwEGtCejvYuzGBesBJw3zGm8SGOBIp0JI
         +3575RXIi94alIvvVWtUmUVdoEFEeoom2mKTYnIHouNCP8D0d+qhvk3CeqjNQBKC2hWH
         5fMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=OGfXcYbnn3m3u5865QGto1JIPL4VYtqkDmIO+n2mR9Y=;
        b=O3tbjQDpRab9MXV4QMyLe0WlggqzIHFHpTdgy1OUzqn5Qbc4SoJ3gtt0AKyTcqvA/B
         N6ryFPXNSPySJdHCjpBdd+ffjcsadW3cx5MFj1+J2u8iIkR3gVKdEXAsxLCihybTYVqu
         xRoJpINdlZtBAhN6uhm3+pQIT0liznsYhaalhBI9fSMglbTOP3r0k5+JJ5DAMUkZkOpb
         F4Z/6oGTkEEW++ztsnsj7jV5YcZCc4nokt471gaDmP7aBLTGsoKplIDXo+Me10mxvMQR
         KoXVWw8VP0mQC18vbt0xEsqdd5CumVs7e5LKVyFjvqOjZ3z/6Sa4WeVtuy1bY3I54wGa
         RS6g==
X-Gm-Message-State: APjAAAVFitLBvkNayax0bHMk5kviwwfbgpntHaS5HKOfCKfwvNbEmkw7
        oAJV/qtL2WlMZ5WzsqQ1pBA=
X-Google-Smtp-Source: APXvYqydata/8PymsI+FWqITMhVISAMD87FoiCDftcS3UH30au+njwcOeobQyUNBurbhJYLrh6pjXw==
X-Received: by 2002:a5d:6781:: with SMTP id v1mr12803038wru.167.1551723036334;
        Mon, 04 Mar 2019 10:10:36 -0800 (PST)
Received: from ?IPv6:2003:ea:8bf1:e200:d8e4:889a:5ed6:37cb? (p200300EA8BF1E200D8E4889A5ED637CB.dip0.t-ipconnect.de. [2003:ea:8bf1:e200:d8e4:889a:5ed6:37cb])
        by smtp.googlemail.com with ESMTPSA id g81sm7129744wmf.7.2019.03.04.10.10.34
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 04 Mar 2019 10:10:35 -0800 (PST)
Subject: Re: [PATCH net 2/2] net: phy: Use C45 Helpers in PHY_FORCING state
To:     Andrew Lunn <andrew@lunn.ch>, Jose Abreu <jose.abreu@synopsys.com>
Cc:     netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        Florian Fainelli <f.fainelli@gmail.com>,
        "David S. Miller" <davem@davemloft.net>,
        Joao Pinto <joao.pinto@synopsys.com>
References: <cover.1551437561.git.joabreu@synopsys.com>
 <8480c38d6f3bc5c4f6c332a788bc82999266aab7.1551437561.git.joabreu@synopsys.com>
 <20190301135302.GB19813@lunn.ch>
 <97425bd9-3ea5-b2c3-abc1-e5285a3e677e@synopsys.com>
 <20190304154455.GD18622@lunn.ch>
From:   Heiner Kallweit <hkallweit1@gmail.com>
Message-ID: <1ef0e8a7-1c46-38f6-fd87-b2a2b395c38c@gmail.com>
Date:   Mon, 4 Mar 2019 19:10:28 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.1
MIME-Version: 1.0
In-Reply-To: <20190304154455.GD18622@lunn.ch>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 04.03.2019 16:44, Andrew Lunn wrote:
> On Mon, Mar 04, 2019 at 03:07:24PM +0000, Jose Abreu wrote:
>> Hi Andrew,
>>
>> On 3/1/2019 1:53 PM, Andrew Lunn wrote:
>>> On Fri, Mar 01, 2019 at 11:54:24AM +0100, Jose Abreu wrote:
>>>> +static inline int phy_update_link(struct phy_device *phydev)
>>>> +{
>>>> +	if (!phydev->drv)
>>>> +		return -EIO;
>>>> +
>>>> +	if (phydev->drv->read_status)
>>>> +		return phydev->drv->read_status(phydev);
>>>> +	else if (phydev->is_c45)
>>>> +		return gen10g_read_status(phydev);
>>>> +	else
>>>> +		return genphy_update_link(phydev);
>>>> +}
>>>
>>> Hi Jose
>>>
>>> The asymmetry here could be an issue.  We might fall into the trap
>>> that a c45 PHY has the full state in phydev updated, were as a c22
>>> only has the link updated. Somebody testing on C45 might miss a bug
>>> for a C22 device.
>>
>> Notice that this phy_update_link() is called from PHY_FORCING
>> state which in my case happens when autoneg is not enabled / is
>> not supported.
>>
>> I think it makes sense, in this case, to only update link status,
>> no ?
>  
> Hi Jose
> 
> It is actually quite difficult to determine when the link is up. I
> personally would not trust gen10g_read_status() to get this right, and
> would always implement the read_status callback.
> 
Not to forget that we just stopped exporting gen10g_read_status().
genphy_c45_read_link() seems to be the right function to be used
in phy_update_link().

> Which PHY driver are you using, which does not support
> read_status(). All the mainline PHY drivers do seem to have
> read_status implemented.
> 
>     Andrew
> 
Heiner
