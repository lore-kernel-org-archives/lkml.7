Return-Path: <SRS0=c+yg=TC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	T_DKIMWL_WL_HIGH,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E07C8C43219
	for <linux-kernel@archiver.kernel.org>; Thu,  2 May 2019 13:56:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A6D632063F
	for <linux-kernel@archiver.kernel.org>; Thu,  2 May 2019 13:56:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1556805392;
	bh=bwmJRWM4rgIvmb7W4Nw2g1YBFCAM3jL/YPYGTss5OEU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=UfN8Kgk0SqpCINuJ+H4FNXob6aA0ktlJycgYIHk3aeP4p1HkVG1jcJcZ2ulAdAbR1
	 YpU07Ty/IMhz8j8WEIe8eB/xE9MNwoeY6XXdPFDaCBfoFVBmCGao0RhKQVOkl0WnXa
	 jIqn65olE3VXL68/dazJh1r8++2MO+oxkVTXVzJg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726378AbfEBN4b (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 2 May 2019 09:56:31 -0400
Received: from mail-lf1-f67.google.com ([209.85.167.67]:41147 "EHLO
        mail-lf1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726302AbfEBN4a (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 May 2019 09:56:30 -0400
Received: by mail-lf1-f67.google.com with SMTP id d8so1942275lfb.8;
        Thu, 02 May 2019 06:56:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=/VM2EPbaQGkjwVj3LHXmEyZv0mSCYwQuitq78e8x8+4=;
        b=H6m5bt83WI7VgIZVTkwD1ttH62PtSUVQE215GE+U8PrTRo/dM2WWHvDiniWHJ0PI6h
         4unbflDaJu3DrgNKv8ea4U1sz9xwqHN6S0mTBQJmgMpgKt8X3zmApkyghCMAA8Jij+TZ
         0nKd6axbRd1T4Uxuh8bMq/BwuaA6me7ZykLW0cZXuZxyc3CfV3RSCmsWoorQKmFrZg1y
         eGXId/PmAPahkORX2HR7y0ZZlhwoXOxZJxHJHTfLT1v6KArIbGlpxP/eSG+rtDYE4Pgb
         rfy1ie5kUP1RA77qpLoNEmpZ8hyOI5gEMhtoaHqJxY6nOe11qROklP0WzM8kVsEudYHy
         oFzw==
X-Gm-Message-State: APjAAAXnuZy+dTVPUUR/hreMdbbI/xAit1hutiM+FE0LZDO5yDuDGyra
        geGFZ4HunSCVy0YFmM2+TAE=
X-Google-Smtp-Source: APXvYqz/5j7YFIF0fcF9qHJWGYVHusZfI5dnPpLYjeKOGVNBnoEJ5oH5NzA7po/x6AC+jW/IGg9myA==
X-Received: by 2002:a19:7d04:: with SMTP id y4mr2112437lfc.153.1556805387716;
        Thu, 02 May 2019 06:56:27 -0700 (PDT)
Received: from xi.terra (c-74bee655.07-184-6d6c6d4.bbcust.telenor.se. [85.230.190.116])
        by smtp.gmail.com with ESMTPSA id q15sm4106884lfh.59.2019.05.02.06.56.26
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 02 May 2019 06:56:26 -0700 (PDT)
Received: from johan by xi.terra with local (Exim 4.91)
        (envelope-from <johan@kernel.org>)
        id 1hMCCS-0005iF-Dj; Thu, 02 May 2019 15:56:37 +0200
Date:   Thu, 2 May 2019 15:56:36 +0200
From:   Johan Hovold <johan@kernel.org>
To:     "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Cc:     Johan Hovold <johan@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        Kees Cook <keescook@chromium.org>
Subject: Re: [PATCH v2] USB: serial: io_edgeport: mark expected switch
 fall-throughs
Message-ID: <20190502135636.GT26546@localhost>
References: <20190501213329.GA26972@embeddedor>
 <20190502102608.GS26546@localhost>
 <df1feb28-58d0-7ac8-644d-0b48e5078edf@embeddedor.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <df1feb28-58d0-7ac8-644d-0b48e5078edf@embeddedor.com>
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 02, 2019 at 08:22:30AM -0500, Gustavo A. R. Silva wrote:
> 
> 
> On 5/2/19 5:26 AM, Johan Hovold wrote:
> > On Wed, May 01, 2019 at 04:33:29PM -0500, Gustavo A. R. Silva wrote:
> >> In preparation to enabling -Wimplicit-fallthrough, mark switch
> >> cases where we are expecting to fall through.
> >>
> >> This patch fixes the following warnings:
> >>
> >> drivers/usb/serial/io_edgeport.c: In function ‘process_rcvd_data’:
> >> drivers/usb/serial/io_edgeport.c:1750:7: warning: this statement may fall through [-Wimplicit-fallthrough=]
> >>     if (bufferLength == 0) {
> >>        ^
> >> drivers/usb/serial/io_edgeport.c:1755:3: note: here
> >>    case EXPECT_HDR2:
> >>    ^~~~
> >> drivers/usb/serial/io_edgeport.c:1810:8: warning: this statement may fall through [-Wimplicit-fallthrough=]
> >>      if (bufferLength == 0) {
> >>         ^
> >> drivers/usb/serial/io_edgeport.c:1816:3: note: here
> >>    case EXPECT_DATA: /* Expect data */
> >>    ^~~~
> >>
> >> Warning level 3 was used: -Wimplicit-fallthrough=3
> >>
> >> Notice that, in this particular case, the code comments are modified
> >> in accordance with what GCC is expecting to find.
> >>
> >> This patch is part of the ongoing efforts to enable
> >> -Wimplicit-fallthrough.
> >>
> >> Signed-off-by: Gustavo A. R. Silva <gustavo@embeddedor.com>
> >> ---
> >> Changes in v2:
> >>  - Warning level 3 is now used: -Wimplicit-fallthrough=3
> >>    instead of warning level 2.
> >>  - All warnings in the switch statement are addressed now.
> >>
> >> Notice that these are the last remaining fall-through warnings
> >> in the USB subsystem. :)
> > 
> >>  drivers/usb/serial/io_edgeport.c | 3 ++-
> >>  1 file changed, 2 insertions(+), 1 deletion(-)
> >>
> >> diff --git a/drivers/usb/serial/io_edgeport.c b/drivers/usb/serial/io_edgeport.c
> >> index 4ca31c0e4174..7ad10328f4e2 100644
> >> --- a/drivers/usb/serial/io_edgeport.c
> >> +++ b/drivers/usb/serial/io_edgeport.c
> >> @@ -1751,7 +1751,7 @@ static void process_rcvd_data(struct edgeport_serial *edge_serial,
> >>  				edge_serial->rxState = EXPECT_HDR2;
> >>  				break;
> >>  			}
> >> -			/* otherwise, drop on through */
> >> +			/* Fall through - otherwise, drop on through */
> >>  		case EXPECT_HDR2:
> >>  			edge_serial->rxHeader2 = *buffer;
> >>  			++buffer;
> >> @@ -1813,6 +1813,7 @@ static void process_rcvd_data(struct edgeport_serial *edge_serial,
> >>  				}
> >>  				/* Else, drop through */
> >>  			}
> >> +			/* Fall through */
> >>  		case EXPECT_DATA: /* Expect data */
> > 
> > Looks like you forgot to take the original review feedback you got into
> > account:
> > 
> > 	https://lkml.kernel.org/r/87k1zf4k24.fsf@miraculix.mork.no
> > 
> 
> Oh, the thing is that the fall-through comments have to be placed at
> the very bottom of the case. Also, based on that feedback, this time
> I left the "Else, drop through" comment in place, so people can be
> informed that such fall-through is conditional.
> 
> What do you think about this:
> 
> diff --git a/drivers/usb/serial/io_edgeport.c b/drivers/usb/serial/io_edgeport.c
> index 4ca31c0e4174..52f27fc82563 100644
> --- a/drivers/usb/serial/io_edgeport.c
> +++ b/drivers/usb/serial/io_edgeport.c
> @@ -1751,7 +1751,7 @@ static void process_rcvd_data(struct edgeport_serial *edge_serial,
>                                 edge_serial->rxState = EXPECT_HDR2;
>                                 break;
>                         }
> -                       /* otherwise, drop on through */
> +                       /* Fall through - otherwise, drop on through */
>                 case EXPECT_HDR2:
>                         edge_serial->rxHeader2 = *buffer;
>                         ++buffer;
> @@ -1813,6 +1813,11 @@ static void process_rcvd_data(struct edgeport_serial *edge_serial,
>                                 }
>                                 /* Else, drop through */
>                         }
> +                       /* Beware that, currently, there are at least three
> +                        * break statements in this case block, so the
> +                        * fall-through marked below is NOT unconditional.
> +                        */
> +                       /* Fall through */
>                 case EXPECT_DATA: /* Expect data */
>                         if (bufferLength < edge_serial->rxBytesRemaining) {
>                                 rxLen = bufferLength;

It's better than v2, but I thought you said you were gonna look into
restructuring the code to maintain (or even improve) readability?

Johan
