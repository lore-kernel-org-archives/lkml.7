Return-Path: <SRS0=g5d9=RD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 14EEFC43381
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Feb 2019 23:05:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DBAFE20851
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Feb 2019 23:05:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732654AbfB1XFi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Feb 2019 18:05:38 -0500
Received: from smtprelay0205.hostedemail.com ([216.40.44.205]:56831 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727945AbfB1XFi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Feb 2019 18:05:38 -0500
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay02.hostedemail.com (Postfix) with ESMTP id 993CA6D86;
        Thu, 28 Feb 2019 23:05:36 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-HE-Tag: pies40_13b1a53101c42
X-Filterd-Recvd-Size: 2396
Received: from XPS-9350.home (unknown [47.151.153.53])
        (Authenticated sender: joe@perches.com)
        by omf20.hostedemail.com (Postfix) with ESMTPA;
        Thu, 28 Feb 2019 23:05:35 +0000 (UTC)
Message-ID: <1450785b937f4a2b5f98c8548986b162684a719b.camel@perches.com>
Subject: Re: [PATCH v2] wusb: use correct format characters
From:   Joe Perches <joe@perches.com>
To:     Jon Flatley <jflat@chromium.org>
Cc:     Louis Taylor <louis@kragniz.eu>, gregkh@linuxfoundation.org,
        linux-usb@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        clang-built-linux@googlegroups.com,
        Nick Desaulniers <ndesaulniers@google.com>
Date:   Thu, 28 Feb 2019 15:05:34 -0800
In-Reply-To: <CACJJ=pzfSMgJbt5zKzgN-AcugkYRuGhbB88tsTX7k+-qPnS0jA@mail.gmail.com>
References: <20190228115256.5446-1-louis@kragniz.eu>
         <20190228122417.9318-1-louis@kragniz.eu>
         <15c6689389503a82394bccb9204650bf20a7a6d3.camel@perches.com>
         <CACJJ=pzfSMgJbt5zKzgN-AcugkYRuGhbB88tsTX7k+-qPnS0jA@mail.gmail.com>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.30.1-1build1 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2019-02-28 at 14:23 -0800, Jon Flatley wrote:
> Thanks for the patch and comments.
> 
> On Thu, Feb 28, 2019 at 1:53 PM Joe Perches <joe@perches.com> wrote:
> > On Thu, 2019-02-28 at 12:24 +0000, Louis Taylor wrote:
> > > When compiling with -Wformat, clang warns:
> > > ./include/linux/usb/wusb.h:245:5: warning: format specifies type
> > > 'unsigned short' but the argument has type 'u8' (aka 'unsigned char')
> > > [-Wformat]
> > >   ckhdid->data[0],  ckhdid->data[1],
> > >   ^~~~~~~~~~~~~~~
> > 
> > I think the message is somewhat misguided as all the
> > vararg arguments have implicit integer promotions.
> 
> That's a fair point, but Clang checks the arguments against their
> format specifier before they're promoted when using -Wformat.

Perhaps clang could be a bit more verbose if
checking signed types emitted as unsigned or
unsigned types emitted as signed instead.

> When
> considering integer promotions it's difficult to say if this is
> "wrong",

I didn't write "wrong", I wrote misguided.

> but since 'unsigned char' corresponds to the "hh" length
> specifier I don't think this is misguided. Otherwise, why use the "h"
> length specifier at all?

e.g.: signed char as %x needs %hhx

cheers, Joe

