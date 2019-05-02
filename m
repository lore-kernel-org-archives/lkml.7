Return-Path: <SRS0=c+yg=TC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_HIGH,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DA1D0C43219
	for <linux-kernel@archiver.kernel.org>; Thu,  2 May 2019 14:48:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A389D20656
	for <linux-kernel@archiver.kernel.org>; Thu,  2 May 2019 14:48:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1556808487;
	bh=Qe5twwbXdCNOJCV/x3zC4Et43HpncH7Z5E0BfqtXSvE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=2R1JGkznWEjmMk0xhsk5NaLeQEUfaIbNwS5oGFse8wNNCuhrXb8w8XeOtYUQaUp+3
	 x1EDOglMkm9n3uj+Q02VmMVr2hCyroz+Jlgnq8eOZwL8AiWcuI/hYS+JDtEeMpXDCY
	 MatNF2+XssN/D348askRFk6T82QTdQnqdyYxoAp8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726428AbfEBOsG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 2 May 2019 10:48:06 -0400
Received: from mail-lj1-f193.google.com ([209.85.208.193]:46677 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726197AbfEBOsG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 May 2019 10:48:06 -0400
Received: by mail-lj1-f193.google.com with SMTP id h21so2401807ljk.13;
        Thu, 02 May 2019 07:48:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=TRsUL+/lAkniHNhKMMSf6UQnO5lUvvQWskmDhwJ5gVo=;
        b=aUYgGFQYmPyR/FKPMUqoQFurJk9trKoKIgDz08XEsnvimM6Efhrle30oZPn90o7ksF
         cxnGwkrY1e/fsIA7K59oZLz62H4qzRRv4Ct+3w0inK6JFY+Hm2Ejxe6Me9eMO1/zjrD+
         e+QghwCGm3MGoAu+BOLflbrcT358Qat2DSkbnUIfAnzSqvAePSGYizIdS+0GHwWBPkdX
         r6Qe730Roq7qo+nZiyiBIs0U7trusbD8BRhZrFeJ1QUhLH55d0Z53Z1aWY0vlMTylSN0
         GSgBaTdzN/F3mxtp+SPnTCWLfj7Ipr+gBhffSJNo9agvUT0TR2mzXHeKv+9JFazFj6Bz
         QRBA==
X-Gm-Message-State: APjAAAV2V+J48OQJbUgx77QZ4705T8FDwB8RkN9W1J53Ru0TX7i4vTuZ
        eYnC7sieooHEFS1YYt/Ei1A=
X-Google-Smtp-Source: APXvYqxZsE2YBL/XpPCmdhnPx9C9hLu50MtUOZLaQChBJzwTG5MF++8SRvEv0a/loPukkLR+USB8vQ==
X-Received: by 2002:a2e:2b8c:: with SMTP id r12mr2283031ljr.115.1556808483573;
        Thu, 02 May 2019 07:48:03 -0700 (PDT)
Received: from xi.terra (c-74bee655.07-184-6d6c6d4.bbcust.telenor.se. [85.230.190.116])
        by smtp.gmail.com with ESMTPSA id m28sm9465085lfc.71.2019.05.02.07.48.02
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 02 May 2019 07:48:02 -0700 (PDT)
Received: from johan by xi.terra with local (Exim 4.91)
        (envelope-from <johan@kernel.org>)
        id 1hMD0O-0003US-E7; Thu, 02 May 2019 16:48:13 +0200
Date:   Thu, 2 May 2019 16:48:12 +0200
From:   Johan Hovold <johan@kernel.org>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     "Gustavo A. R. Silva" <gustavo@embeddedor.com>,
        Johan Hovold <johan@kernel.org>, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org, Kees Cook <keescook@chromium.org>
Subject: Re: [PATCH v2] USB: serial: io_edgeport: mark expected switch
 fall-throughs
Message-ID: <20190502144812.GW26546@localhost>
References: <20190501213329.GA26972@embeddedor>
 <20190502102608.GS26546@localhost>
 <df1feb28-58d0-7ac8-644d-0b48e5078edf@embeddedor.com>
 <20190502135636.GT26546@localhost>
 <f3fd7ece-98ff-4b67-6115-5f599e183508@embeddedor.com>
 <20190502144041.GA17960@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190502144041.GA17960@kroah.com>
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 02, 2019 at 04:40:41PM +0200, Greg Kroah-Hartman wrote:
> On Thu, May 02, 2019 at 09:28:37AM -0500, Gustavo A. R. Silva wrote:

> > >>>> @@ -1813,6 +1813,7 @@ static void process_rcvd_data(struct edgeport_serial *edge_serial,
> > >>>>  				}
> > >>>>  				/* Else, drop through */
> > >>>>  			}
> > >>>> +			/* Fall through */
> > >>>>  		case EXPECT_DATA: /* Expect data */
> > >>>
> > >>> Looks like you forgot to take the original review feedback you got into
> > >>> account:
> > >>>
> > >>> 	https://lkml.kernel.org/r/87k1zf4k24.fsf@miraculix.mork.no
> > >>>
> > >>
> > >> Oh, the thing is that the fall-through comments have to be placed at
> > >> the very bottom of the case. Also, based on that feedback, this time
> > >> I left the "Else, drop through" comment in place, so people can be
> > >> informed that such fall-through is conditional.
> > >>
> > >> What do you think about this:
> > >>
> > >> diff --git a/drivers/usb/serial/io_edgeport.c b/drivers/usb/serial/io_edgeport.c
> > >> index 4ca31c0e4174..52f27fc82563 100644
> > >> --- a/drivers/usb/serial/io_edgeport.c
> > >> +++ b/drivers/usb/serial/io_edgeport.c
> > >> @@ -1751,7 +1751,7 @@ static void process_rcvd_data(struct edgeport_serial *edge_serial,
> > >>                                 edge_serial->rxState = EXPECT_HDR2;
> > >>                                 break;
> > >>                         }
> > >> -                       /* otherwise, drop on through */
> > >> +                       /* Fall through - otherwise, drop on through */
> > >>                 case EXPECT_HDR2:
> > >>                         edge_serial->rxHeader2 = *buffer;
> > >>                         ++buffer;
> > >> @@ -1813,6 +1813,11 @@ static void process_rcvd_data(struct edgeport_serial *edge_serial,
> > >>                                 }
> > >>                                 /* Else, drop through */
> > >>                         }
> > >> +                       /* Beware that, currently, there are at least three
> > >> +                        * break statements in this case block, so the
> > >> +                        * fall-through marked below is NOT unconditional.
> > >> +                        */
> > >> +                       /* Fall through */
> > >>                 case EXPECT_DATA: /* Expect data */
> > >>                         if (bufferLength < edge_serial->rxBytesRemaining) {
> > >>                                 rxLen = bufferLength;
> > > 
> > > It's better than v2, but I thought you said you were gonna look into
> > > restructuring the code to maintain (or even improve) readability?
> > > 
> > 
> > At first, I thought about that, but now I don't think that's realistic.
> > I'd turn the if-else into a switch, and based on the history of feedback
> > on this patch, we will end up having the same complains about the break
> > statements in that new switch and the possibility of a fall-through to
> > case EXPECT_DATA. At the end I would still have to add a comment explaining
> > that the last fall-through mark in unconditional.
> 
> I love it how no one is blaming the original author of this code (i.e.
> me...)
>
> Let me see if I can fix it up to be more "sane", this is my fault.

Thanks, that'd be great. I haven't looked at it myself in a long time,
but judging from the old thread it did not seem impossible at least.

Getting rid of some of that deep nesting would be good either way. :)

Johan
