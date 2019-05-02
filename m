Return-Path: <SRS0=c+yg=TC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,T_DKIMWL_WL_HIGH,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DE5B9C04AA9
	for <linux-kernel@archiver.kernel.org>; Thu,  2 May 2019 14:47:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A4AC820644
	for <linux-kernel@archiver.kernel.org>; Thu,  2 May 2019 14:47:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1556808454;
	bh=mUEsG/SRoI8Ieb161/tWDISH+t6jDgm6B4+KcuOh3AU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=D56ppZEwpeQDZyOg+8oVo47Kt77PZ7UTUIDDg37dyHrhTrh19BPcWqy/nu/XMAB0M
	 gQa9uJFyAor0tmzVhAcZXTTCifLWGEkUGPDAUMdA2vs6mcroiv8GMeMFyKeIiCbUcq
	 aRm5cBA7R48XKNVFqdmvRsR3LG5P9vWoW2q671Zk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726334AbfEBOrd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 2 May 2019 10:47:33 -0400
Received: from mail.kernel.org ([198.145.29.99]:54982 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726197AbfEBOrd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 May 2019 10:47:33 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 588FB20651;
        Thu,  2 May 2019 14:47:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1556808451;
        bh=mUEsG/SRoI8Ieb161/tWDISH+t6jDgm6B4+KcuOh3AU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=daoNFnVLgHi38BNQTCjcJHVMB3FJn5fa190DI9hpsfgdcKxn3knE8h6al6P4cILPh
         f+Z1Xany8A1U7D87Tn8muq7h7PpYkrXw8ctMwqk6+VzBfxF7XURgRPPILL+BpxRZ5X
         jToGz+zj+t/AOVd7od5hCcDaJIs66thXngIokvGg=
Date:   Thu, 2 May 2019 16:47:29 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Cc:     Johan Hovold <johan@kernel.org>, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org, Kees Cook <keescook@chromium.org>
Subject: Re: [PATCH v2] USB: serial: io_edgeport: mark expected switch
 fall-throughs
Message-ID: <20190502144729.GB17960@kroah.com>
References: <20190501213329.GA26972@embeddedor>
 <20190502102608.GS26546@localhost>
 <df1feb28-58d0-7ac8-644d-0b48e5078edf@embeddedor.com>
 <20190502135636.GT26546@localhost>
 <f3fd7ece-98ff-4b67-6115-5f599e183508@embeddedor.com>
 <20190502144041.GA17960@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20190502144041.GA17960@kroah.com>
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 02, 2019 at 04:40:41PM +0200, Greg Kroah-Hartman wrote:
> On Thu, May 02, 2019 at 09:28:37AM -0500, Gustavo A. R. Silva wrote:
> > 
> > 
> > On 5/2/19 8:56 AM, Johan Hovold wrote:
> > > On Thu, May 02, 2019 at 08:22:30AM -0500, Gustavo A. R. Silva wrote:
> > >>
> > >>
> > >> On 5/2/19 5:26 AM, Johan Hovold wrote:
> > >>> On Wed, May 01, 2019 at 04:33:29PM -0500, Gustavo A. R. Silva wrote:
> > >>>> In preparation to enabling -Wimplicit-fallthrough, mark switch
> > >>>> cases where we are expecting to fall through.
> > >>>>
> > >>>> This patch fixes the following warnings:
> > >>>>
> > >>>> drivers/usb/serial/io_edgeport.c: In function ‘process_rcvd_data’:
> > >>>> drivers/usb/serial/io_edgeport.c:1750:7: warning: this statement may fall through [-Wimplicit-fallthrough=]
> > >>>>     if (bufferLength == 0) {
> > >>>>        ^
> > >>>> drivers/usb/serial/io_edgeport.c:1755:3: note: here
> > >>>>    case EXPECT_HDR2:
> > >>>>    ^~~~
> > >>>> drivers/usb/serial/io_edgeport.c:1810:8: warning: this statement may fall through [-Wimplicit-fallthrough=]
> > >>>>      if (bufferLength == 0) {
> > >>>>         ^
> > >>>> drivers/usb/serial/io_edgeport.c:1816:3: note: here
> > >>>>    case EXPECT_DATA: /* Expect data */
> > >>>>    ^~~~
> > >>>>
> > >>>> Warning level 3 was used: -Wimplicit-fallthrough=3
> > >>>>
> > >>>> Notice that, in this particular case, the code comments are modified
> > >>>> in accordance with what GCC is expecting to find.
> > >>>>
> > >>>> This patch is part of the ongoing efforts to enable
> > >>>> -Wimplicit-fallthrough.
> > >>>>
> > >>>> Signed-off-by: Gustavo A. R. Silva <gustavo@embeddedor.com>
> > >>>> ---
> > >>>> Changes in v2:
> > >>>>  - Warning level 3 is now used: -Wimplicit-fallthrough=3
> > >>>>    instead of warning level 2.
> > >>>>  - All warnings in the switch statement are addressed now.
> > >>>>
> > >>>> Notice that these are the last remaining fall-through warnings
> > >>>> in the USB subsystem. :)
> > >>>
> > >>>>  drivers/usb/serial/io_edgeport.c | 3 ++-
> > >>>>  1 file changed, 2 insertions(+), 1 deletion(-)
> > >>>>
> > >>>> diff --git a/drivers/usb/serial/io_edgeport.c b/drivers/usb/serial/io_edgeport.c
> > >>>> index 4ca31c0e4174..7ad10328f4e2 100644
> > >>>> --- a/drivers/usb/serial/io_edgeport.c
> > >>>> +++ b/drivers/usb/serial/io_edgeport.c
> > >>>> @@ -1751,7 +1751,7 @@ static void process_rcvd_data(struct edgeport_serial *edge_serial,
> > >>>>  				edge_serial->rxState = EXPECT_HDR2;
> > >>>>  				break;
> > >>>>  			}
> > >>>> -			/* otherwise, drop on through */
> > >>>> +			/* Fall through - otherwise, drop on through */
> > >>>>  		case EXPECT_HDR2:
> > >>>>  			edge_serial->rxHeader2 = *buffer;
> > >>>>  			++buffer;
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

How about the following patch?  Johan, this look nicer to you?  It makes
more sense to me.

And in looking at the history, I can't claim total credit for this
monstrosity, it was originally written by someone else, I just "cleaned
it up" back in 2001, to get it into mergable shape.  Clearly "mergable
shape" was much looser back then :)

thanks,

greg k-h

----------------

diff --git a/drivers/usb/serial/io_edgeport.c b/drivers/usb/serial/io_edgeport.c
index 4ca31c0e4174..732081b3718f 100644
--- a/drivers/usb/serial/io_edgeport.c
+++ b/drivers/usb/serial/io_edgeport.c
@@ -1751,7 +1751,8 @@ static void process_rcvd_data(struct edgeport_serial *edge_serial,
 				edge_serial->rxState = EXPECT_HDR2;
 				break;
 			}
-			/* otherwise, drop on through */
+			/* Fall through */
+
 		case EXPECT_HDR2:
 			edge_serial->rxHeader2 = *buffer;
 			++buffer;
@@ -1790,29 +1791,21 @@ static void process_rcvd_data(struct edgeport_serial *edge_serial,
 						edge_serial->rxHeader2, 0);
 				edge_serial->rxState = EXPECT_HDR1;
 				break;
-			} else {
-				edge_serial->rxPort =
-				    IOSP_GET_HDR_PORT(edge_serial->rxHeader1);
-				edge_serial->rxBytesRemaining =
-				    IOSP_GET_HDR_DATA_LEN(
-						edge_serial->rxHeader1,
-						edge_serial->rxHeader2);
-				dev_dbg(dev, "%s - Data for Port %u Len %u\n",
-					__func__,
-					edge_serial->rxPort,
-					edge_serial->rxBytesRemaining);
-
-				/* ASSERT(DevExt->RxPort < DevExt->NumPorts);
-				 * ASSERT(DevExt->RxBytesRemaining <
-				 *		IOSP_MAX_DATA_LENGTH);
-				 */
-
-				if (bufferLength == 0) {
-					edge_serial->rxState = EXPECT_DATA;
-					break;
-				}
-				/* Else, drop through */
 			}
+
+			edge_serial->rxPort = IOSP_GET_HDR_PORT(edge_serial->rxHeader1);
+			edge_serial->rxBytesRemaining = IOSP_GET_HDR_DATA_LEN(edge_serial->rxHeader1,
+									      edge_serial->rxHeader2);
+			dev_dbg(dev, "%s - Data for Port %u Len %u\n", __func__,
+				edge_serial->rxPort,
+				edge_serial->rxBytesRemaining);
+
+			if (bufferLength == 0) {
+				edge_serial->rxState = EXPECT_DATA;
+				break;
+			}
+			/* Fall through */
+
 		case EXPECT_DATA: /* Expect data */
 			if (bufferLength < edge_serial->rxBytesRemaining) {
 				rxLen = bufferLength;
