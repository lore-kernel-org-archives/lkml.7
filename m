Return-Path: <SRS0=x0+x=RM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5108FC43381
	for <linux-kernel@archiver.kernel.org>; Sat,  9 Mar 2019 14:56:44 +0000 (UTC)
Received: from vger.kernel.org (unknown [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 040642081B
	for <linux-kernel@archiver.kernel.org>; Sat,  9 Mar 2019 14:56:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="l5wkoyH2"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 040642081B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726381AbfCIO4d (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 9 Mar 2019 09:56:33 -0500
Received: from mail-wm1-f66.google.com ([209.85.128.66]:50176 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725841AbfCIO4c (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 9 Mar 2019 09:56:32 -0500
Received: by mail-wm1-f66.google.com with SMTP id x7so413397wmj.0;
        Sat, 09 Mar 2019 06:56:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=nRMpYaf5E2vtnJjJUJu5i61gfiOYfU/mJd/ZXoAGej8=;
        b=l5wkoyH2qtbtEO0kpFzLAs9geu7ZZ3xoakc7L4G0NJgf+R4k2SntCOz1tXJIw0M33+
         WOv/1c72FAXjQqf4FECJRgAfUcbrfAFQM8q2USvrAzoHzp9uBSUGMnNqbGIzaOXQNnk2
         exTZkYo7GOQh9vCr5Y8UzaRbIux6AjxqaFdpNaTsd2ewlzOW+azj72C88Mj1px++kqVu
         Apb38bGTx0fHjbSYygOerES1StMK9yV7iVD2ti7P5aOXuYN0YrJWetwVnq9CjMPrHxUr
         foIq4AST/wSZgX85YjIxswnxnNd0VDSphmHazH3grpq8Fj3nK+cX4VC/Qrqzmyo/tE3t
         S4rg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=nRMpYaf5E2vtnJjJUJu5i61gfiOYfU/mJd/ZXoAGej8=;
        b=tiolnXSdPeL8EGG2zoXEzvtjYve0mNjvAShnQTODSF6JwHJp4fNAgYbPHZbHVtTCij
         +TNtaKsn/ReaKsR1nYCsfhBQcj89E6IlSNQ3iOVgdLees/HIUOjiqbKhZIVkdiQWttSW
         vDj2qQIsQ74tXlps9NoglatOmvQ5cI8tts8eQFjiVSzkkUVFd6ljmZxNe5HbKU0LriDl
         +4HMD2Kpw72b14pFlqDwkeEq8m/7zoRahFaM7nyxjUwd/PoTHCYFEgrGGMe4WMkHQXAZ
         ukUdmfg86jHBcyPXrePGMniZ+mNgOoT92PIIqIvAANwtAkTLF8nHnkJaJSIECaMsKfGG
         81lg==
X-Gm-Message-State: APjAAAVWAFsoTg3eTl2MBggJv2zukDqw5Qr+0Q2wX1oZxsu9o3vny49g
        99r1Rw/0cgESW/mgFgZxaSkAP0gDyaU=
X-Google-Smtp-Source: APXvYqyrb7+z+83OMCrxQ/83gHd5OmjoO6W0HPQZ1XfE1/pCGmW92qxfqiw3pnWnlparDje3UJWRGg==
X-Received: by 2002:a1c:4006:: with SMTP id n6mr12774808wma.137.1552143390223;
        Sat, 09 Mar 2019 06:56:30 -0800 (PST)
Received: from ?IPv6:2003:ee:f27:ae00:bc3a:186e:8458:23ed? (p200300EE0F27AE00BC3A186E845823ED.dip0.t-ipconnect.de. [2003:ee:f27:ae00:bc3a:186e:8458:23ed])
        by smtp.googlemail.com with ESMTPSA id v20sm16575854wmj.2.2019.03.09.06.56.29
        (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
        Sat, 09 Mar 2019 06:56:29 -0800 (PST)
Subject: Re: [PATCH] net: can: Increase tx queue length
To:     Appana Durga Kedareswara Rao <appanad@xilinx.com>,
        "wg@grandegger.com" <wg@grandegger.com>,
        "mkl@pengutronix.de" <mkl@pengutronix.de>,
        "davem@davemloft.net" <davem@davemloft.net>,
        Oliver Hartkopp <socketcan@hartkopp.net>
Cc:     "linux-can@vger.kernel.org" <linux-can@vger.kernel.org>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <1552140446-31535-1-git-send-email-appana.durga.rao@xilinx.com>
 <cd71079c-664f-b1b6-bb21-ecda639ecbed@gmail.com>
 <CY4PR02MB2183E0667CF67DEE6A297FF8DC4E0@CY4PR02MB2183.namprd02.prod.outlook.com>
From:   Andre Naujoks <nautsch2@gmail.com>
Message-ID: <bed965ce-0af5-ef0e-4f13-296064cede72@gmail.com>
Date:   Sat, 9 Mar 2019 15:56:29 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.1
MIME-Version: 1.0
In-Reply-To: <CY4PR02MB2183E0667CF67DEE6A297FF8DC4E0@CY4PR02MB2183.namprd02.prod.outlook.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 3/9/19 3:40 PM, Appana Durga Kedareswara Rao wrote:
> Hi Andre,
> 
> <Snip> 
>>
>> On 3/9/19 3:07 PM, Appana Durga Kedareswara rao wrote:
>>> While stress testing the CAN interface on xilinx axi can in loopback
>>> mode getting message "write: no buffer space available"
>>> Increasing device tx queue length resolved the above mentioned issue.
>>
>> No need to patch the kernel:
>>
>> $ ip link set <dev-name> txqueuelen 500
>>
>> does the same thing.
> 
> Thanks for the review... 
> Agree but it is not an out of box solution right?? 
> Do you have any idea for socket can devices why the tx queue length is 10 whereas
> for other network devices (ex: ethernet) it is 1000 ?? 

I think the 1000 queue length is the system default and CAN just
overwrites that (a vcan does curiously does not). There probably is a
reason for the short queue for CAN. But I don't know why it was set so
low. My guess is as good as yours.

I ran into your problem multiple times, too, when replaying recorded CAN
traces. We worked around it, by adding the txqueuelen to the setup
parameters for the CAN devices. If you use ifupdown (we use a different
solution), then you could probably put it in there somewhere.

I'd be reluctant to change that default without knowing why it was set
in the first place.

Maybe Oliver can help here?

Regards
  Andre

> 
> Regards,
> Kedar.
>>
>>>
>>> Signed-off-by: Appana Durga Kedareswara rao
>>> <appana.durga.rao@xilinx.com>
>>> ---
>>> --> Network devices default tx_queue_len is 1000 but for socket
>>> can device it is 10 any reason for it??
>>>
>>>  drivers/net/can/dev.c | 2 +-
>>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>>
>>> diff --git a/drivers/net/can/dev.c b/drivers/net/can/dev.c index
>>> c05e4d5..32bd5be 100644
>>> --- a/drivers/net/can/dev.c
>>> +++ b/drivers/net/can/dev.c
>>> @@ -642,7 +642,7 @@ static void can_setup(struct net_device *dev)
>>>  	dev->mtu = CAN_MTU;
>>>  	dev->hard_header_len = 0;
>>>  	dev->addr_len = 0;
>>> -	dev->tx_queue_len = 10;
>>> +	dev->tx_queue_len = 500;
>>>
>>>  	/* New-style flags. */
>>>  	dev->flags = IFF_NOARP;
>>>
> 

