Return-Path: <SRS0=B1dt=RW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CA033C43381
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Mar 2019 13:11:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9014A213F2
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Mar 2019 13:11:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=skidata.com header.i=@skidata.com header.b="V4rtM+Am"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727018AbfCSNL0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Mar 2019 09:11:26 -0400
Received: from mail1.skidata.com ([91.230.2.99]:45039 "EHLO mail1.skidata.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726464AbfCSNL0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Mar 2019 09:11:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=skidata.com; i=@skidata.com; q=dns/txt; s=selector1;
  t=1553001085; x=1584537085;
  h=subject:to:cc:references:from:message-id:date:
   mime-version:in-reply-to:content-transfer-encoding;
  bh=YZ4J5UTncLJ/PTFt2yYwAjChO7oWMvH/+rMsTnRSgfw=;
  b=V4rtM+AmerDXPPGQIeVtvjSqr6XaqAIG2LBM0vwmVgUpYkOtd/0Mue79
   FbCjwInPRAvGKWJXEHuZ6U7Efhdrw0BV8xJ0xvAGjKYbVxOycB6fFDlFr
   Auppo1Atvax65Z06Yve1+F3vC60+8F++1qLNA9dVjgh/Lsa4xZ/Vg7LuM
   xpd7UPIvEd8Ab+o50kG4jl85/d+yTd94zwl6i2edPih8qW1F8G4MLpu4M
   J8j6cPt5NKXEZ7PQKFnaY757lbI9wmRxlfZJHD4m7ZG6C+Fh169HrLkON
   yTyOmVgX0ieZY2T4k03Zoz9RT8z07oIpvegTkJCSoLMMELfmKauJBN9zQ
   Q==;
IronPort-SDR: 5j2gXmfIar4y/PK4X+4aMPH0oLHne63aFz8r1AihWn59PVIvIuiYdsJYaat5I7hg1rSjjyQl0T
 iVQmYhbo47DUcX8Ousg9Pr8sl7+eqmkl69PMMkL3zIR6UamJFjK+kuIwDekHG5K0uaGZPPcHah
 Oiz9p4mXVnSucZSlrPuM6CKwFhoHj7kyn73v0/bhQqbRlJFwJWfCrw6LDs4nEaxcsmNWx9HTgF
 40LzYNyWzlRrlSrA1JiP4oHNb0eYs4SKdSGbLlmq1rOVWhlHSY/uF1DICln9UrI4SVcPo38ml7
 zag=
X-IronPort-AV: E=Sophos;i="5.58,498,1544482800"; 
   d="scan'208";a="15841402"
Subject: Re: [PATCH] usb: usb251xb: fix to avoid potential NULL pointer
 dereference
To:     Aditya Pakki <pakki001@umn.edu>
CC:     <kjlu@umn.edu>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        <linux-usb@vger.kernel.org>, <linux-kernel@vger.kernel.org>
References: <20190318235605.11055-1-pakki001@umn.edu>
From:   Richard Leitner <richard.leitner@skidata.com>
Message-ID: <3579fc19-dde7-968b-3918-39f1cc4ee3bc@skidata.com>
Date:   Tue, 19 Mar 2019 14:11:23 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.1
MIME-Version: 1.0
In-Reply-To: <20190318235605.11055-1-pakki001@umn.edu>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [192.168.111.22]
X-ClientProxiedBy: sdex5srv.skidata.net (192.168.111.83) To
 sdex5srv.skidata.net (192.168.111.83)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 19/03/2019 00:56, Aditya Pakki wrote:
> of_match_device in usb251xb_probe can fail and returns a NULL pointer.
> The patch avoids a potential NULL pointer dereference in this scenario.
> 
> Signed-off-by: Aditya Pakki <pakki001@umn.edu>
> ---
>   drivers/usb/misc/usb251xb.c | 2 ++
>   1 file changed, 2 insertions(+)
> 
> diff --git a/drivers/usb/misc/usb251xb.c b/drivers/usb/misc/usb251xb.c
> index 4d72b7d1d383..fe5266dc8864 100644
> --- a/drivers/usb/misc/usb251xb.c
> +++ b/drivers/usb/misc/usb251xb.c
> @@ -612,6 +612,8 @@ static int usb251xb_probe(struct usb251xb *hub)
>   							   dev);
>   	int err;
>   
> +	if (!of_id)
> +		return -ENODEV;

Hi Aditya,
thanks for finding this issue!

Nonetheless I'd prefer to change this to not return here but rather do 
something like:

	if (np && of_id) {

So we still may bring up the hub in its default config in scenarios 
without dt/of...

Any comments/objections on that?

regards;Richard.L

>   	if (np) {
>   		err = usb251xb_get_ofdata(hub,
>   					  (struct usb251xb_data *)of_id->data);
> 
