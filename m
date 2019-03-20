Return-Path: <SRS0=4Jrr=RX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 25E61C4360F
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Mar 2019 10:56:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EFC7C2175B
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Mar 2019 10:56:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727850AbfCTK44 convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Mar 2019 06:56:56 -0400
Received: from eu-smtp-delivery-151.mimecast.com ([146.101.78.151]:36387 "EHLO
        eu-smtp-delivery-151.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727661AbfCTK4z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Mar 2019 06:56:55 -0400
Received: from AcuMS.aculab.com (156.67.243.126 [156.67.243.126]) (Using
 TLS) by relay.mimecast.com with ESMTP id
 uk-mta-97-u-qw3I3fPsWFgZeY5gnTrg-1; Wed, 20 Mar 2019 10:56:51 +0000
Received: from AcuMS.Aculab.com (fd9f:af1c:a25b:0:43c:695e:880f:8750) by
 AcuMS.aculab.com (fd9f:af1c:a25b:0:43c:695e:880f:8750) with Microsoft SMTP
 Server (TLS) id 15.0.1347.2; Wed, 20 Mar 2019 10:57:54 +0000
Received: from AcuMS.Aculab.com ([fe80::43c:695e:880f:8750]) by
 AcuMS.aculab.com ([fe80::43c:695e:880f:8750%12]) with mapi id 15.00.1347.000;
 Wed, 20 Mar 2019 10:57:54 +0000
From:   David Laight <David.Laight@ACULAB.COM>
To:     'Aditya Pakki' <pakki001@umn.edu>
CC:     "kjlu@umn.edu" <kjlu@umn.edu>,
        Andreas Noever <andreas.noever@gmail.com>,
        Michael Jamet <michael.jamet@intel.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Yehezkel Bernat <YehezkelShB@gmail.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <jakub.kicinski@netronome.com>,
        Jesper Dangaard Brouer <hawk@kernel.org>,
        John Fastabend <john.fastabend@gmail.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        "xdp-newbies@vger.kernel.org" <xdp-newbies@vger.kernel.org>,
        "bpf@vger.kernel.org" <bpf@vger.kernel.org>
Subject: RE: [PATCH] thunderbolt: xdomain: Fix to check return value of
 kmemdup
Thread-Topic: [PATCH] thunderbolt: xdomain: Fix to check return value of
 kmemdup
Thread-Index: AQHU3d3P6yfm6q4n/EWUAqU+kGwm2qYUW5Hg
Date:   Wed, 20 Mar 2019 10:57:54 +0000
Message-ID: <57793438545e41cc85d00beab7505143@AcuMS.aculab.com>
References: <20190318225508.7886-1-pakki001@umn.edu>
In-Reply-To: <20190318225508.7886-1-pakki001@umn.edu>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [10.202.205.107]
MIME-Version: 1.0
X-MC-Unique: u-qw3I3fPsWFgZeY5gnTrg-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Aditya Pakki
> Sent: 18 March 2019 22:55
> 
> kmemdup can fail and return a NULL pointer. The patch modifies the
> signature of tb_xdp_schedule_request and passes the failure error upstream.
> 
> Signed-off-by: Aditya Pakki <pakki001@umn.edu>
> ---
>  drivers/thunderbolt/xdomain.c | 10 ++++++----
>  1 file changed, 6 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/thunderbolt/xdomain.c b/drivers/thunderbolt/xdomain.c
> index e27dd8beb94b..b0e9cc30d708 100644
> --- a/drivers/thunderbolt/xdomain.c
> +++ b/drivers/thunderbolt/xdomain.c
> @@ -526,7 +526,7 @@ static void tb_xdp_handle_request(struct work_struct *work)
>  	kfree(xw);
>  }
> 
> -static void
> +static bool
>  tb_xdp_schedule_request(struct tb *tb, const struct tb_xdp_header *hdr,
>  			size_t size)
>  {
> @@ -534,13 +534,16 @@ tb_xdp_schedule_request(struct tb *tb, const struct tb_xdp_header *hdr,
> 
>  	xw = kmalloc(sizeof(*xw), GFP_KERNEL);
>  	if (!xw)
> -		return;
> +		return false;
> 
>  	INIT_WORK(&xw->work, tb_xdp_handle_request);
>  	xw->pkg = kmemdup(hdr, size, GFP_KERNEL);
> +	if (!xw->pkg)
> +		return false;

You're leaking 'xw' here.

	David

-
Registered Address Lakeside, Bramley Road, Mount Farm, Milton Keynes, MK1 1PT, UK
Registration No: 1397386 (Wales)

