Return-Path: <SRS0=xYIU=RV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1DC14C43381
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Mar 2019 15:53:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E279F2085A
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Mar 2019 15:53:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=skidata.com header.i=@skidata.com header.b="XG4pvG51"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727957AbfCRPxs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Mar 2019 11:53:48 -0400
Received: from mail1.skidata.com ([91.230.2.99]:22997 "EHLO mail1.skidata.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727915AbfCRPxn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Mar 2019 11:53:43 -0400
X-Greylist: delayed 428 seconds by postgrey-1.27 at vger.kernel.org; Mon, 18 Mar 2019 11:53:41 EDT
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=skidata.com; i=@skidata.com; q=dns/txt; s=selector1;
  t=1552924422; x=1584460422;
  h=subject:to:cc:references:from:message-id:date:
   mime-version:in-reply-to:content-transfer-encoding;
  bh=GxAeHEsDJIB64+V8841adqPaOZ/GZ0UvCz29xLXLyAo=;
  b=XG4pvG51PVjkBRgI9uv06IC14Y5CvyHmcVDrBRbwXvD3C1fH7MBWwVPj
   /QrBzhWqPSjoJIN6J0FbwUnqw7C6dU1IEZAKbULQltXhUIb5Ey8ipuUA5
   R7yVTDxN0gc4yBazi6pk13fE/WOqW4cIzB6H69HOfXc3DO4IOdtGG1xRb
   flDdFAjQoo/4r2SZVAxawbKX9GNAzXszb/qtCZLLR7txhAZc0B1QcvNE+
   nk5WdbR4YGJpyGXh9AGszPHXvEh57t3mc1oU8otVjaCFnLFlOGiEZ0Xg6
   CXVs829K0fL/eUrLcxcMVaSgtnyb8EAPuuLiGwdzNQFvlOj5VnGcy3Q3g
   w==;
IronPort-SDR: G52Hfi4f9VGGwRRBXJkphDfRiYz1vzStQiW2s6O5Uy4xKEAixgzCB/VKmCJkFO2UhKMMnPyXHm
 +NFrVkHOJzoD8nQaRcZa//R8sB9dvdX1XzphdO5TPN5DpDuiJ9zMfo/LLzJeXw86QSrQTqA9Qe
 geIMQDjd1gGsWTgKCgASJiObDJ20NAVJcCYfN+5WuIXERVuRhNKUg4fELdQr8on3jM+eWnd7uj
 szbxfCYsSB/jI3nXFAMgAWo1PiSpA3QA+NLI/IHWts+ys1RXB9umyuTGbfZvvSStBA/AVO9e6Y
 PlA=
IronPort-Data: A9a23:c62B7q+dZ6cUOZwHCCeGDrVtTnXEfa7SOkUsvfjUo+up9DbDjwXKp6
 svMLy0NsOX+81AG4GiIM988eyrpeDOC1n71sTp06L2dXC5ctfm7ZEiTLLuJtCKsDhdHCnqPX
 4DXfqRHgmwQrYqSKE2XQfzKVQZyP4gdo3BzfcbNuSmDqL4RYeQLGr18tIzBoOrqXniTrNi2P
 v+rJ2kOu55Dkyc646lGfHPAsNyjjbQhDmkN2xlm+YLniQ8BAO0pMyUSyY1AaTFESnKa9v/Sg
 0V6E5yPu5xx9qV1mCtJtx9nEm1jWv9l+yRIkO+Z2dF5Krrq9py/YNq5hdvoxxbIOPDeF7ZAF
 JUP+OjwnafPPTkknO+RpW4aY+xJItC0OHgWg655K6RgZnRYfU4mb0j+u9p10EYFDjwrbIY2R
 ujl/MtmD3isYYvA5To0cd96KIWZ3le6TfIwX844gO4mue9uzhNPIFTS0bCSrB8dXpPpSEZhp
 XMorgz3SHXdQvB4kDtRxkAEFNKTKqCe/mVbYrl+g0z8vS9k3MaSxfYD0l4oa5f7bdE1FeIep
 5AgtFBsRXZUQaVZKJ2f7LuN4oyYfmJaGFgtRHzwXWzERI8b+YRxmH918acLcz0vdvW/6GTiJ
 9hXe8zhe46AaguBul+Brj82uq8U6/p00LJGIS52TrOFvgFFgGzY5pbWGoXbiR4hIipNAY3QG
 A9tw4unRXQt2Sz7hMTRa2FYxff4W0JeYQgwkAJXux6g+ZrWxtq8+LbbR+RGONqusMLiMiLOK
 dK+HANKwFwuAJvpC7n7nZw83BTKp+5rE6l+DsZb+LvCisi/ewBoOfOF2Uir7qnat0IJk7oA2
 EIiLPyhIg=
X-IronPort-AV: E=Sophos;i="5.58,494,1544482800"; 
   d="scan'208";a="15819580"
Subject: Re: [PATCH] usb: usb251xb: Remove unnecessary comparison of unsigned
 integer with >= 0
To:     Marco Felsch <m.felsch@pengutronix.de>,
        "Gustavo A. R. Silva" <gustavo@embeddedor.com>
CC:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        <linux-usb@vger.kernel.org>, <linux-kernel@vger.kernel.org>
References: <20190318145024.GA572@embeddedor>
 <20190318153425.rxx3fwq2hi6tfocr@pengutronix.de>
From:   Richard Leitner <richard.leitner@skidata.com>
Message-ID: <f8785dc1-fa14-4e01-b89a-088cffdc350f@skidata.com>
Date:   Mon, 18 Mar 2019 16:46:31 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.1
MIME-Version: 1.0
In-Reply-To: <20190318153425.rxx3fwq2hi6tfocr@pengutronix.de>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [192.168.111.22]
X-ClientProxiedBy: sdex3srv.skidata.net (192.168.111.81) To
 sdex5srv.skidata.net (192.168.111.83)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Marco, Hi Gustavo,
thanks for the fix, please feel free to add

	Reviewed-by: Richard Leitner <richard.leitner@skidata.com>

On 18/03/2019 16:34, Marco Felsch wrote:
> Hi Silva,
> 
> On 19-03-18 09:50, Gustavo A. R. Silva wrote:
>> There is no need to compare *port* with >= 0 because such comparison
>> of an unsigned value is always true.
> 
> Absolutly.. It seems that it was an copy'n'paste failure. Thanks for
> fixing that.

A small note on further improvement from my side:

According the datasheet, when you set swap-dx-lanes to 0 (-> setting 
port to 0 -> setting bit 0 of PRTSP) "   the upstream port DP/DM is 
swapped".

IMHO this is not straight-forward, so maybe we want to additionally

	a) mention it somewhere in the documentation
	b) check on port >= 1
	c) something else?

Any opinions on that from your side? ... I'd prefer "a"...

regards;Richard.L

> 
> Regards,
> Marco
> 
>> Fix this by removing such comparison.
>>
>> Addresses-Coverity-ID: 1443949 ("Unsigned compared against 0")
>> Fixes: 02a50b875046 ("usb: usb251xb: add usb data lane port swap feature")
>> Signed-off-by: Gustavo A. R. Silva <gustavo@embeddedor.com>
>> ---
>>   drivers/usb/misc/usb251xb.c | 2 +-
>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/drivers/usb/misc/usb251xb.c b/drivers/usb/misc/usb251xb.c
>> index 4d72b7d1d383..2c8e2cad7e10 100644
>> --- a/drivers/usb/misc/usb251xb.c
>> +++ b/drivers/usb/misc/usb251xb.c
>> @@ -547,7 +547,7 @@ static int usb251xb_get_ofdata(struct usb251xb *hub,
>>   	 */
>>   	hub->port_swap = USB251XB_DEF_PORT_SWAP;
>>   	of_property_for_each_u32(np, "swap-dx-lanes", prop, p, port) {
>> -		if ((port >= 0) && (port <= data->port_cnt))
>> +		if (port <= data->port_cnt)
>>   			hub->port_swap |= BIT(port);
>>   	}
>>   
>> -- 
>> 2.21.0
>>
>>
> 
