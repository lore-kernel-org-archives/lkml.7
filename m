Return-Path: <SRS0=4Jrr=RX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CB128C43381
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Mar 2019 10:07:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6EB2F21850
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Mar 2019 10:07:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=skidata.com header.i=@skidata.com header.b="UbE1R924"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727970AbfCTKH2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Mar 2019 06:07:28 -0400
Received: from mail1.skidata.com ([91.230.2.99]:55594 "EHLO mail1.skidata.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726875AbfCTKH1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Mar 2019 06:07:27 -0400
X-Greylist: delayed 429 seconds by postgrey-1.27 at vger.kernel.org; Wed, 20 Mar 2019 06:07:25 EDT
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=skidata.com; i=@skidata.com; q=dns/txt; s=selector1;
  t=1553076446; x=1584612446;
  h=subject:to:cc:references:from:message-id:date:
   mime-version:in-reply-to:content-transfer-encoding;
  bh=Yf98xqdSflMmZyDCVuR+0USkBzTHlthe+01vNzwTUXI=;
  b=UbE1R924IZyiwp2MYQPKdotrPiMrE+W12WYSIFWbQRzJ+/4qCsalqEow
   AniIrWC+ZLr6C6kxVNzKr+8vq5RzpDpS9S0VH46iiNjzHi++2KGld5efr
   YqyG2U3sY/in8flU/pb4SoxVO0RCZAUD/GLCis+2bJTDk7BYlfL+XcN16
   fcM94Sp5b7K/NS6uqevw948DA7u023t9lNBiwJaa4N/dCs+y9yQH6k4aA
   vY2jxpXtAmjdr/acAjXQygekgJJ7y992zRyQuv6521ZROe1SWe0zzKlSz
   rYqdTocNsf6/B++RZCmO7mk0zI48QgqBTSr3XTziSpFkdvoGO5bNpsVGK
   A==;
IronPort-SDR: WXU+rwwh/2StGNNA0EzHogoIhiBN79nS8MTeV8jIb0PbBn3JPIQHqG4yTd4inYaQQvA0QOhTfj
 WGgbYY9qMoFibAeNGF9FmQ+3L4MBBEa7+nsMDHYz/zyzM3Fi51oOZxLtXs5EsqkWxwHEwt8cxq
 xuDKmV7KYNR21ZkHTDMy33RWkJiJCY/R1umXI+S6oe7s3X9FnZyJDr9YfV6TiTbad+64NwAN85
 TMoqAgBKdTdA/XOF9KkWXCZMudMQxNegFoftnhKKGWBQgZaKSC5x+i4DsyPcbTQI6g4GH1xXm0
 HXY=
X-IronPort-AV: E=Sophos;i="5.60,248,1549926000"; 
   d="scan'208";a="15864786"
Subject: Re: [PATCH v2] usb: usb251xb: fix to avoid potential NULL pointer
 dereference
To:     Aditya Pakki <pakki001@umn.edu>
CC:     <kjlu@umn.edu>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        <linux-usb@vger.kernel.org>, <linux-kernel@vger.kernel.org>
References: <20190319202658.17116-1-pakki001@umn.edu>
From:   Richard Leitner <richard.leitner@skidata.com>
Message-ID: <593fcaca-8732-94b0-08fb-b1c6738cd688@skidata.com>
Date:   Wed, 20 Mar 2019 11:00:14 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.1
MIME-Version: 1.0
In-Reply-To: <20190319202658.17116-1-pakki001@umn.edu>
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

Hi, thanks for the updated patch.

Please find my comments below.

On 19/03/2019 21:26, Aditya Pakki wrote:
> of_match_device in usb251xb_probe can fail and returns a NULL pointer.
> The patch avoids a potential NULL pointer dereference in this scenario.
> 
> --

This should be 3 dashes "---" ;-)

> v1: Fix to avoid return in case of error, per Richard's suggestion.
> Signed-off-by: Aditya Pakki <pakki001@umn.edu>

This signed-off-by line should be in the commit message, not the 
"version history" which is not included in the commit.

Apart from that (if you send a fixed v3) feel free to add
	Reviewed-by: Richard Leitner <richard.leitner@skidata.com>

regards;Richard.L

> ---
>   drivers/usb/misc/usb251xb.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/usb/misc/usb251xb.c b/drivers/usb/misc/usb251xb.c
> index 4d72b7d1d383..bbfdb7447d6f 100644
> --- a/drivers/usb/misc/usb251xb.c
> +++ b/drivers/usb/misc/usb251xb.c
> @@ -612,7 +612,7 @@ static int usb251xb_probe(struct usb251xb *hub)
>   							   dev);
>   	int err;
>   
> -	if (np) {
> +	if (np && of_id) {
>   		err = usb251xb_get_ofdata(hub,
>   					  (struct usb251xb_data *)of_id->data);
>   		if (err) {
> 
