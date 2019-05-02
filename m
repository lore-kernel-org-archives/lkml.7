Return-Path: <SRS0=c+yg=TC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	T_DKIMWL_WL_HIGH,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 21F47C43219
	for <linux-kernel@archiver.kernel.org>; Thu,  2 May 2019 15:14:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D61A120675
	for <linux-kernel@archiver.kernel.org>; Thu,  2 May 2019 15:14:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1556810095;
	bh=ohHqPwx74D17f2d+EWbp7g0NclPuykBXXLNLUrD6NJk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=e3ifiszAcfsvikhQ3rX8MCoSbxj7vK8rbf+FFeGgVR+5NFkFoDFWGssQo8YO9nPRc
	 f+3W6UUpNLmzmW2Yj5S6IW6DMvcCsbOSZQcBrBWGFiZ+l0y29rBRx1Oz8RQ8WqkN/l
	 OczCXXNlBICkHMuCKWFBAJyEZ//RR+yrU/23+GVY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726390AbfEBPOx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 2 May 2019 11:14:53 -0400
Received: from mail-lj1-f196.google.com ([209.85.208.196]:42802 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726203AbfEBPOx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 May 2019 11:14:53 -0400
Received: by mail-lj1-f196.google.com with SMTP id r72so2508088ljb.9;
        Thu, 02 May 2019 08:14:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=5Hpg0RvkeeKrNdBmTzkGI8MH8deXoVOBZrG4ryDlr3k=;
        b=GTs+fjSkRPoq522KayleOqhVnDYv0MnmTEYbvo3o7vh1kSZbn40gaSx2iT0dwiu2TK
         oGDMNQljG6vawzpubr5sAtoyXM+qz2O6Gv4/WwAg1s0Z6G05qovc8oLxEKc0tdOsVlbD
         mpfygLnQzrAd4WG8v1B13A4YibTPsxh2vnkhKVxmP2HWKxpPmbbELC/5nT8AWmVv6iVz
         ldTu8qmf3XAih+TGogFvIWAj0q8Z3f8yy5GlH0irhalgl7zDVo67OOuIqAP9XOy1Zvdk
         HXjcxV7Wrutt3yoGMu9SORi3sx76wrUo4ZqSRKp5C9lM0jJN1p5a0zXnommEQ8F9DfpV
         Ba+Q==
X-Gm-Message-State: APjAAAUd0J9qOfUEnlG9lX8s2xWEZ2I9d3bcO+nQOZndMLqBJJpYSVo4
        Nw5CfpJD4zzpNGvGCLSv8+PGZD/5
X-Google-Smtp-Source: APXvYqy3QKjsCwzjpXQgrmvSpKWUPw5s667Bbm5+YuMIRZ9T2877oO8A8Tx7MSZrcrOKU1RqmBh5qQ==
X-Received: by 2002:a2e:9d59:: with SMTP id y25mr2161176ljj.137.1556810090086;
        Thu, 02 May 2019 08:14:50 -0700 (PDT)
Received: from xi.terra (c-74bee655.07-184-6d6c6d4.bbcust.telenor.se. [85.230.190.116])
        by smtp.gmail.com with ESMTPSA id d80sm10433379lfd.90.2019.05.02.08.14.48
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 02 May 2019 08:14:48 -0700 (PDT)
Received: from johan by xi.terra with local (Exim 4.91)
        (envelope-from <johan@kernel.org>)
        id 1hMDQJ-0003fL-5K; Thu, 02 May 2019 17:14:59 +0200
Date:   Thu, 2 May 2019 17:14:59 +0200
From:   Johan Hovold <johan@kernel.org>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     "Gustavo A. R. Silva" <gustavo@embeddedor.com>,
        Johan Hovold <johan@kernel.org>, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org, Kees Cook <keescook@chromium.org>
Subject: Re: [PATCH v2] USB: serial: io_edgeport: mark expected switch
 fall-throughs
Message-ID: <20190502151459.GX26546@localhost>
References: <20190501213329.GA26972@embeddedor>
 <20190502102608.GS26546@localhost>
 <df1feb28-58d0-7ac8-644d-0b48e5078edf@embeddedor.com>
 <20190502135636.GT26546@localhost>
 <f3fd7ece-98ff-4b67-6115-5f599e183508@embeddedor.com>
 <20190502144041.GA17960@kroah.com>
 <20190502144729.GB17960@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20190502144729.GB17960@kroah.com>
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 02, 2019 at 04:47:29PM +0200, Greg Kroah-Hartman wrote:
> On Thu, May 02, 2019 at 04:40:41PM +0200, Greg Kroah-Hartman wrote:
> > On Thu, May 02, 2019 at 09:28:37AM -0500, Gustavo A. R. Silva wrote:
> > > 
> > > 
> > > On 5/2/19 8:56 AM, Johan Hovold wrote:
> > > > On Thu, May 02, 2019 at 08:22:30AM -0500, Gustavo A. R. Silva wrote:
> > > >>
> > > >>
> > > >> On 5/2/19 5:26 AM, Johan Hovold wrote:
> > > >>> On Wed, May 01, 2019 at 04:33:29PM -0500, Gustavo A. R. Silva wrote:
> > > >>>> In preparation to enabling -Wimplicit-fallthrough, mark switch
> > > >>>> cases where we are expecting to fall through.
> > > >>>>
> > > >>>> This patch fixes the following warnings:
> > > >>>>
> > > >>>> drivers/usb/serial/io_edgeport.c: In function ‘process_rcvd_data’:
> > > >>>> drivers/usb/serial/io_edgeport.c:1750:7: warning: this statement may fall through [-Wimplicit-fallthrough=]
> > > >>>>     if (bufferLength == 0) {
> > > >>>>        ^
> > > >>>> drivers/usb/serial/io_edgeport.c:1755:3: note: here
> > > >>>>    case EXPECT_HDR2:
> > > >>>>    ^~~~
> > > >>>> drivers/usb/serial/io_edgeport.c:1810:8: warning: this statement may fall through [-Wimplicit-fallthrough=]
> > > >>>>      if (bufferLength == 0) {
> > > >>>>         ^
> > > >>>> drivers/usb/serial/io_edgeport.c:1816:3: note: here
> > > >>>>    case EXPECT_DATA: /* Expect data */
> > > >>>>    ^~~~
> > > >>>>
> > > >>>> Warning level 3 was used: -Wimplicit-fallthrough=3
> > > >>>>
> > > >>>> Notice that, in this particular case, the code comments are modified
> > > >>>> in accordance with what GCC is expecting to find.
> > > >>>>
> > > >>>> This patch is part of the ongoing efforts to enable
> > > >>>> -Wimplicit-fallthrough.
> > > >>>>
> > > >>>> Signed-off-by: Gustavo A. R. Silva <gustavo@embeddedor.com>
> > > >>>> ---
> > > >>>> Changes in v2:
> > > >>>>  - Warning level 3 is now used: -Wimplicit-fallthrough=3
> > > >>>>    instead of warning level 2.
> > > >>>>  - All warnings in the switch statement are addressed now.
> > > >>>>
> > > >>>> Notice that these are the last remaining fall-through warnings
> > > >>>> in the USB subsystem. :)
> > > >>>
> > > >>>>  drivers/usb/serial/io_edgeport.c | 3 ++-
> > > >>>>  1 file changed, 2 insertions(+), 1 deletion(-)
> > > >>>>
> > > >>>> diff --git a/drivers/usb/serial/io_edgeport.c b/drivers/usb/serial/io_edgeport.c
> > > >>>> index 4ca31c0e4174..7ad10328f4e2 100644
> > > >>>> --- a/drivers/usb/serial/io_edgeport.c
> > > >>>> +++ b/drivers/usb/serial/io_edgeport.c
> > > >>>> @@ -1751,7 +1751,7 @@ static void process_rcvd_data(struct edgeport_serial *edge_serial,
> > > >>>>  				edge_serial->rxState = EXPECT_HDR2;
> > > >>>>  				break;
> > > >>>>  			}
> > > >>>> -			/* otherwise, drop on through */
> > > >>>> +			/* Fall through - otherwise, drop on through */
> > > >>>>  		case EXPECT_HDR2:
> > > >>>>  			edge_serial->rxHeader2 = *buffer;
> > > >>>>  			++buffer;
> > > >>>> @@ -1813,6 +1813,7 @@ static void process_rcvd_data(struct edgeport_serial *edge_serial,
> > > >>>>  				}
> > > >>>>  				/* Else, drop through */
> > > >>>>  			}
> > > >>>> +			/* Fall through */
> > > >>>>  		case EXPECT_DATA: /* Expect data */
> > > >>>
> > > >>> Looks like you forgot to take the original review feedback you got into
> > > >>> account:
> > > >>>
> > > >>> 	https://lkml.kernel.org/r/87k1zf4k24.fsf@miraculix.mork.no
> > > >>>
> > > >>
> > > >> Oh, the thing is that the fall-through comments have to be placed at
> > > >> the very bottom of the case. Also, based on that feedback, this time
> > > >> I left the "Else, drop through" comment in place, so people can be
> > > >> informed that such fall-through is conditional.
> > > >>
> > > >> What do you think about this:
> > > >>
> > > >> diff --git a/drivers/usb/serial/io_edgeport.c b/drivers/usb/serial/io_edgeport.c
> > > >> index 4ca31c0e4174..52f27fc82563 100644
> > > >> --- a/drivers/usb/serial/io_edgeport.c
> > > >> +++ b/drivers/usb/serial/io_edgeport.c
> > > >> @@ -1751,7 +1751,7 @@ static void process_rcvd_data(struct edgeport_serial *edge_serial,
> > > >>                                 edge_serial->rxState = EXPECT_HDR2;
> > > >>                                 break;
> > > >>                         }
> > > >> -                       /* otherwise, drop on through */
> > > >> +                       /* Fall through - otherwise, drop on through */
> > > >>                 case EXPECT_HDR2:
> > > >>                         edge_serial->rxHeader2 = *buffer;
> > > >>                         ++buffer;
> > > >> @@ -1813,6 +1813,11 @@ static void process_rcvd_data(struct edgeport_serial *edge_serial,
> > > >>                                 }
> > > >>                                 /* Else, drop through */
> > > >>                         }
> > > >> +                       /* Beware that, currently, there are at least three
> > > >> +                        * break statements in this case block, so the
> > > >> +                        * fall-through marked below is NOT unconditional.
> > > >> +                        */
> > > >> +                       /* Fall through */
> > > >>                 case EXPECT_DATA: /* Expect data */
> > > >>                         if (bufferLength < edge_serial->rxBytesRemaining) {
> > > >>                                 rxLen = bufferLength;
> > > > 
> > > > It's better than v2, but I thought you said you were gonna look into
> > > > restructuring the code to maintain (or even improve) readability?
> > > > 
> > > 
> > > At first, I thought about that, but now I don't think that's realistic.
> > > I'd turn the if-else into a switch, and based on the history of feedback
> > > on this patch, we will end up having the same complains about the break
> > > statements in that new switch and the possibility of a fall-through to
> > > case EXPECT_DATA. At the end I would still have to add a comment explaining
> > > that the last fall-through mark in unconditional.
> > 
> > I love it how no one is blaming the original author of this code (i.e.
> > me...)
> > 
> > Let me see if I can fix it up to be more "sane", this is my fault.
> 
> How about the following patch?  Johan, this look nicer to you?  It makes
> more sense to me.

Hard to say... :) Less indentation is good, but the current flow seems
more in line with the comment preceding the if-statement

		/* Process depending on whether this header is
		 * data or status */

		if (IS_CMD_STAT_HDR(edge_serial->rxHeader1)) {
			a;
			break;
		} else {
			b;
		}
	case EXPECT_DATA: /* Expect data */

which sort of gets lost if you just replace the else clause with b.

But it still an improvement, let's go with it.

> And in looking at the history, I can't claim total credit for this
> monstrosity, it was originally written by someone else, I just "cleaned
> it up" back in 2001, to get it into mergable shape.  Clearly "mergable
> shape" was much looser back then :)

Heh.

> diff --git a/drivers/usb/serial/io_edgeport.c b/drivers/usb/serial/io_edgeport.c
> index 4ca31c0e4174..732081b3718f 100644
> --- a/drivers/usb/serial/io_edgeport.c
> +++ b/drivers/usb/serial/io_edgeport.c
> @@ -1751,7 +1751,8 @@ static void process_rcvd_data(struct edgeport_serial *edge_serial,
>  				edge_serial->rxState = EXPECT_HDR2;
>  				break;
>  			}
> -			/* otherwise, drop on through */
> +			/* Fall through */
> +

I think the comment should go immediately before the case (no newline)
here and below though.

>  		case EXPECT_HDR2:

Thanks,
Johan
