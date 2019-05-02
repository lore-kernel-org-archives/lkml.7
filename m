Return-Path: <SRS0=c+yg=TC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 80DB0C43219
	for <linux-kernel@archiver.kernel.org>; Thu,  2 May 2019 05:49:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 510CB20873
	for <linux-kernel@archiver.kernel.org>; Thu,  2 May 2019 05:49:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=skidata.com header.i=@skidata.com header.b="HAhHVFUw"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726310AbfEBFtf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 2 May 2019 01:49:35 -0400
Received: from mail1.skidata.com ([91.230.2.99]:28144 "EHLO mail1.skidata.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725763AbfEBFte (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 May 2019 01:49:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=skidata.com; i=@skidata.com; q=dns/txt; s=selector1;
  t=1556776196; x=1588312196;
  h=subject:to:cc:references:from:message-id:date:
   mime-version:in-reply-to:content-transfer-encoding;
  bh=+rh5gv9W5GlQRkk6kNOSWglbe02krW6W1cUYUx6+EZM=;
  b=HAhHVFUwa471myjZ69k4kEVyaM0a7vjCea2VMxwd1KPBWO6O+mX0YErl
   FiqvT2ahW1HlM3p4XFGPG7SPd6JjeFe3nNhglGuBU/GJKPCgezdEbJyw2
   v++ZJYMhwvUdfU9s5r2RQPkfiN+fWsyzyVLuAYxf2oZHfjf09xkB4Olod
   pU/trnPB8EoKbfje7npgKyfH+/s2idOo47uG4puSO+uyQ8Jgeif967SDo
   cbsxFuuFloHEM9f2+1pCvo442sBDJi0tOrL2GBucaNdE0RhwaSjgQlF3L
   nm7eQdTduXTj/9W290m8R80KjkSfTNM08ACCtSW9LJ7tiabX8S9nARfYy
   A==;
IronPort-SDR: TMoFwjRA8pYF1rDBStDY7lZeYT4oM/8ZnHkGglL0g/mFk2gXVsV+EeK4JQkHghG9sVlkPmqlGp
 CN4w2f23T66F6eNVclj3fybhYgoAxIlLg76JzyyPfJSu46yZtFLtifV93FhrWtyQFBXNgY0whU
 +40xGEI9ueSCVaZnsRJI9Zc7wth0gNlgdPdPWzAL15EuLoTbZ2HaRvUZeHH2ePBZyz+9Vu+dm4
 uJoBk2KZu8sNDxTCI2BPgyp8hjXvO3U+oSAVCH01Y+8vCrz17T8ebf3sCWaBHG9gHOH5qNdA6o
 LxY=
X-IronPort-AV: E=Sophos;i="5.60,420,1549926000"; 
   d="scan'208";a="16784896"
Subject: Re: [PATCH 2/3] usb: usb251xb: Create a ports field collector method
To:     Serge Semin <fancer.lancer@gmail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
CC:     Serge Semin <Sergey.Semin@t-platforms.ru>,
        <linux-usb@vger.kernel.org>, <linux-kernel@vger.kernel.org>
References: <20190424211208.17499-1-fancer.lancer@gmail.com>
 <20190424211208.17499-3-fancer.lancer@gmail.com>
From:   Richard Leitner <richard.leitner@skidata.com>
Message-ID: <9d8fddf3-52aa-f20f-e19c-a53f863cd3ef@skidata.com>
Date:   Thu, 2 May 2019 07:42:24 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190424211208.17499-3-fancer.lancer@gmail.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [192.168.111.252]
X-ClientProxiedBy: sdex5srv.skidata.net (192.168.111.83) To
 sdex5srv.skidata.net (192.168.111.83)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 24/04/2019 23:12, Serge Semin wrote:
> Seeing the ports field collection functionality is used four times per
> just one function, it's better to have a dedicated method performing
> the task. Note that this fix filters the port 0 out from the lanes
> swapping property the same way as it has been programmed for the rest
> multi-ports properties. But unlike the rest of ports config registers
> the BIT(0) of the Port Lanes Swap register refers to the Upstream Port
> lanes inversion. This fact hasn't been documented in the driver bindings
> nor there were any mentioning about port 0 being treated as upstream
> port. Lets then leave this fix as is for the properties unification
> and create an additional "swap-us-lanes" in the next patch.
> 
> Signed-off-by: Serge Semin <fancer.lancer@gmail.com>
> ---
>   drivers/usb/misc/usb251xb.c | 71 ++++++++++++++-----------------------
>   1 file changed, 26 insertions(+), 45 deletions(-)
> 

Acked-by: Richard Leitner <richard.leitner@skidata.com>
