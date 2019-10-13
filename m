Return-Path: <SRS0=daYT=YG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4D6DDC4360C
	for <linux-kernel@archiver.kernel.org>; Sun, 13 Oct 2019 19:20:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2465520659
	for <linux-kernel@archiver.kernel.org>; Sun, 13 Oct 2019 19:20:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SGgntrP+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729508AbfJMTUA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 13 Oct 2019 15:20:00 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:35755 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728982AbfJMTT7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 13 Oct 2019 15:19:59 -0400
Received: by mail-pf1-f194.google.com with SMTP id 205so9136619pfw.2;
        Sun, 13 Oct 2019 12:19:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=lRxf/vrG9t+cMEQuqxixOE+c6Dr/iWC77uPoe58nNNw=;
        b=SGgntrP+Yup2ENd2fVKPff1wGrEmryh+1fCrncAsrikd8e/Zv5U+MRWQjaRWvSgzIf
         KbGwvo4VXV9KBF87iDQg5td72rnePTD/8dUMXkThgsJqxyXarShHHjIEHQtnCgcKLSLj
         OEc4AKKg0ybxc2l37/axgwlTKXC0mCkXNjEJ/2Ky+NuHHZ+YA+So8cCcUIq8thXGJZeO
         IJUTWwL2je6M/QY7Xjion2ZYGYDVN3jg19p/HahQGwgCIPo5zraGRx2NLi3/XzJUYut1
         S8qOa3kvMgWuGk2EP0QBpqxn/rdpckje1xED3tOilCi9MzEB4F5NdNw1dYfw6n5WsLyf
         ZI+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=lRxf/vrG9t+cMEQuqxixOE+c6Dr/iWC77uPoe58nNNw=;
        b=KxC7yPPd6guaZeqlEMzijpNK2neQZ6RfeiTV/cXRvsjHY9j+VLLvq0l13xlfY0FoUU
         C4a8NZ6NIvvtdBmp7NXGE0laUArWdA9z5JXqN3tpW4I/jsDCF8U8nHpQYrXQ7mu9Pi5J
         2pYzoosiIfj3o6BROZqb29KSLoxmI/8K8TGHhqA8kZhe52L+d8MIsRANsV7vzo3U8TI8
         +0t5N4McyQYTRBGn7i/gQrafX2M45zufJL7ns7KoABUq51Zt9cD51GcwUKOfrIybWDT+
         PonylpMQW/coVi3yiMmpCeTowwwjiXM+rgA3livhuiLoTnlK64LF+PJD+QaDyIOYS4ik
         lRAA==
X-Gm-Message-State: APjAAAV0Lzt0UZfEFQG/kFjexqEKTDdihR7JwbZQi+cMNcWuhAZZ5ZX5
        qFdZeA/tkrENgeoKzUwMEBn6+A+f
X-Google-Smtp-Source: APXvYqzLbTKziQGuwKu2hH5qEstlBYM5Nko/pZSX4t8b9AAXB+d9CizX6GPr1c5GZDxHfs6dk7++fQ==
X-Received: by 2002:a63:1b07:: with SMTP id b7mr11328013pgb.166.1570994398196;
        Sun, 13 Oct 2019 12:19:58 -0700 (PDT)
Received: from [192.168.1.3] (ip68-111-84-250.oc.oc.cox.net. [68.111.84.250])
        by smtp.gmail.com with ESMTPSA id 20sm16619394pfp.153.2019.10.13.12.19.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 13 Oct 2019 12:19:57 -0700 (PDT)
Subject: Re: [PATCH v1 3/3] ARM: dts: bcm2711: Enable GENET support for the
 RPi4
To:     Stefan Wahren <wahrenst@gmx.net>, matthias.bgg@kernel.org,
        "David S . Miller" <davem@davemloft.net>
Cc:     Nicolas Saenz Julienne <nsaenzjulienne@suse.de>,
        linux-rpi-kernel@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org,
        Matthias Brugger <mbrugger@suse.com>,
        Eric Anholt <eric@anholt.net>,
        Mark Rutland <mark.rutland@arm.com>,
        Rob Herring <robh+dt@kernel.org>,
        bcm-kernel-feedback-list@broadcom.com, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20191011184822.866-1-matthias.bgg@kernel.org>
 <20191011184822.866-4-matthias.bgg@kernel.org>
 <a514751e-e82a-b5ea-34d3-46468c851a80@gmail.com>
 <c7fac096-4a0a-1d52-2284-4fe86554fbc8@gmx.net>
From:   Florian Fainelli <f.fainelli@gmail.com>
Message-ID: <15b182b4-488a-c023-91ff-e0e253dc41f9@gmail.com>
Date:   Sun, 13 Oct 2019 12:19:55 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.2
MIME-Version: 1.0
In-Reply-To: <c7fac096-4a0a-1d52-2284-4fe86554fbc8@gmx.net>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 10/13/2019 11:41 AM, Stefan Wahren wrote:
> Hi Florian,
> 
> Am 11.10.19 um 21:31 schrieb Florian Fainelli:
>> On 10/11/19 11:48 AM, matthias.bgg@kernel.org wrote:
>>> From: Matthias Brugger <mbrugger@suse.com>
>>>
>>> Enable Gigabit Ethernet support on the Raspberry Pi 4
>>> Model B.
>>>
>>> Signed-off-by: Matthias Brugger <mbrugger@suse.com>
>>>
>>> ---
>>>
>>>  arch/arm/boot/dts/bcm2711-rpi-4-b.dts | 22 ++++++++++++++++++++++
>>>  arch/arm/boot/dts/bcm2711.dtsi        | 18 ++++++++++++++++++
>>>  2 files changed, 40 insertions(+)
>>>
>>> diff --git a/arch/arm/boot/dts/bcm2711-rpi-4-b.dts b/arch/arm/boot/dts/bcm2711-rpi-4-b.dts
>>> index cccc1ccd19be..958553d62670 100644
>>> --- a/arch/arm/boot/dts/bcm2711-rpi-4-b.dts
>>> +++ b/arch/arm/boot/dts/bcm2711-rpi-4-b.dts
>>> @@ -97,6 +97,28 @@
>>>  	status = "okay";
>>>  };
>>>
>>> +&genet {
>>> +	phy-handle = <&phy1>;
>>> +	phy-mode = "rgmii";
>> Can you check that things still work against David Miller's net-next?
>> Tree, in particular the BCM54213PE PHY might be matched by the BCM54210E
>> entry in drivers/net/phy/broadcom.c and I just fixed an issue in how
>> RGMII delays were configured:
>>
>> https://git.kernel.org/pub/scm/linux/kernel/git/davem/net-next.git/commit/?id=fea7fda7f50a6059220f83251e70709e45cc8040
>>
>> This might require you to change the 'phy-mode' property to what is
>> appropriate.
> 
> i applied your changes, kept the phy-mode above and the interfaces cames
> up. But there is a lot of packet loss using ping. After applying this
> downstream patch [1] the packet loss doesn't occur.

Packet loss is symptomatic of a mis-configured RGMII interface between
the MAC and the PHY.

> 
> Is the packet loss a possible cause of the wrong phy-mode and mentioned
> patch only a workaround?

The patch at [1] is not doing much with respect to RGMII delays, so it
will just keep whatever was configured prior to Linux taking over the
PHY. The addition of the BCM54213PE entry makes use of the
bcm54xx_config_init() callback, which does not call
bcm54xx_config_clock_delay() for the BCM54213PE PHY model, which is why
it "solves" the packet loss by preserving whatever was already configured.

I would suggest checking with the Pi folks whether 'rgmii' is really the
right mode of operation here (that is, the PHY is not adding TXC or RXC
delays at all), or it just happens to work by virtue of the PHY device
defaulting to a certain mode *and* the PHY device driver in Linux not
attempting to correctly change the RX/TX clock delays based on the
phy_interface_t value (aka: maintain the status quo).

Thanks for checking!

> 
> [1] -
> https://github.com/raspberrypi/linux/commit/360c8e98883f9cd075564be8a7fc25ac0785dee4
> 

-- 
Florian
