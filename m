Return-Path: <SRS0=dUEL=RQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E61CDC10F03
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Mar 2019 18:57:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B8C2F2075C
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Mar 2019 18:57:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=mev.co.uk header.i=@mev.co.uk header.b="Xa4xelCU"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726618AbfCMS5V (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Mar 2019 14:57:21 -0400
Received: from smtp105.iad3b.emailsrvr.com ([146.20.161.105]:36652 "EHLO
        smtp105.iad3b.emailsrvr.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726272AbfCMS5V (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Mar 2019 14:57:21 -0400
Received: from smtp6.relay.iad3b.emailsrvr.com (localhost [127.0.0.1])
        by smtp6.relay.iad3b.emailsrvr.com (SMTP Server) with ESMTP id 8A0E12035A;
        Wed, 13 Mar 2019 14:57:19 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=mev.co.uk;
        s=20190130-41we5z8j; t=1552503439;
        bh=PGJT3UlrKMLIL0Qa1Ikopy4ipwpdTS4ajLHSIt9nses=;
        h=Subject:To:From:Date:From;
        b=Xa4xelCUb8ha5PRxWijuQljWxnTf/e3WIbMUgm5djjc370xyFLlWbVs/4m2h7J29d
         Qxqoy8tLJYcLWtTm9Be7Sk8xzkRhZGEK4uf8KEytL/SQrt2ACb8p+5ji9/jWGz8MmG
         8wAcOCEbXCpG76ZmzUSbk+9WiBaD8SBko+xy5QiA=
X-Auth-ID: abbotti@mev.co.uk
Received: by smtp6.relay.iad3b.emailsrvr.com (Authenticated sender: abbotti-AT-mev.co.uk) with ESMTPSA id BD0792029B;
        Wed, 13 Mar 2019 14:57:18 -0400 (EDT)
X-Sender-Id: abbotti@mev.co.uk
Received: from [10.0.0.185] (remote.quintadena.com [81.133.34.160])
        (using TLSv1.2 with cipher AES128-SHA)
        by 0.0.0.0:465 (trex/5.7.12);
        Wed, 13 Mar 2019 14:57:19 -0400
Subject: Re: [PATCH] staging: comedi: ni_mio_common: Fix divide-by-zero for
 DIO cmdtest
To:     devel@driverdev.osuosl.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        H Hartley Sweeten <hsweeten@visionengravers.com>,
        linux-kernel@vger.kernel.org, stable@vger.kernel.org,
        "Spencer E . Olson" <olsonse@umich.edu>
References: <20190304143354.4964-1-abbotti@mev.co.uk>
From:   Ian Abbott <abbotti@mev.co.uk>
Organization: MEV Ltd.
Message-ID: <a8c166a9-5362-227d-bd57-f14b2932f5a1@mev.co.uk>
Date:   Wed, 13 Mar 2019 18:57:17 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.1
MIME-Version: 1.0
In-Reply-To: <20190304143354.4964-1-abbotti@mev.co.uk>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 04/03/2019 14:33, Ian Abbott wrote:
> `ni_cdio_cmdtest()` validates Comedi asynchronous commands for the DIO
> subdevice (subdevice 2) of supported National Instruments M-series
> cards.  It is called when handling the `COMEDI_CMD` and `COMEDI_CMDTEST`
> ioctls for this subdevice.  There are two causes for a possible
> divide-by-zero error when validating that the `stop_arg` member of the
> passed-in command is not too large.
> 
> The first cause for the divide-by-zero is that calls to
> `comedi_bytes_per_scan()` are only valid once the command has been
> copied to `s->async->cmd`, but that copy is only done for the
> `COMEDI_CMD` ioctl.  For the `COMEDI_CMDTEST` ioctl, it will use
> whatever was left there by the previous `COMEDI_CMD` ioctl, if any.
> (This is very likely, as it is usual for the application to use
> `COMEDI_CMDTEST` before `COMEDI_CMD`.) If there has been no previous,
> valid `COMEDI_CMD` for this subdevice, then `comedi_bytes_per_scan()`
> will return 0, so the subsequent division in `ni_cdio_cmdtest()` of
> `s->async->prealloc_bufsz / comedi_bytes_per_scan(s)` will be a
> divide-by-zero error.  To fix this error, call a new function
> `comedi_bytes_per_scan_cmd(s, cmd)`, based on the existing
> `comedi_bytes_per_scan(s)` but using a specified `struct comedi_cmd` for
> its calculations.  (Also refactor `comedi_bytes_per_scan()` to call the
> new function.)
> 
> Once the first cause for the divide-by-zero has been fixed, the second
> cause is that `comedi_bytes_per_scan_cmd()` can legitimately return 0 if
> the `scan_end_arg` member of the `struct comedi_cmd` being tested is 0.
> Fix it by only performing the division (and validating that `stop_arg`
> is no more than the maximum value) if `comedi_bytes_per_scan_cmd()`
> returns a non-zero value.
> 
> The problem was reported on the COMEDI mailing list here:
> https://groups.google.com/forum/#!topic/comedi_list/4t9WlHzMhKM
> 
> Fixes: f164cbf98fa8 ("staging: comedi: ni_mio_common: add finite regeneration to dio output")

Greg,
If it's not too late, it would be nice if the following "Reported-by:" 
and "Tested-by:" lines could be added (or I can resend with these lines 
included if necessary).  It's no big deal if this is too late.  I'll 
live with it.  Thanks.

Reported-by: Ivan Vasilyev <grabesstimme@gmail.com>
Tested-by: Ivan Vasilyev <grabesstimme@gmail.com>

> Cc: <stable@vger.kernel.org> # 4.6+
> Cc: Spencer E. Olson <olsonse@umich.edu>
> Signed-off-by: Ian Abbott <abbotti@mev.co.uk>
> ---
>   drivers/staging/comedi/comedidev.h            |  2 ++
>   drivers/staging/comedi/drivers.c              | 33 ++++++++++++++++---
>   .../staging/comedi/drivers/ni_mio_common.c    | 10 ++++--
>   3 files changed, 38 insertions(+), 7 deletions(-)

-- 
-=( Ian Abbott <abbotti@mev.co.uk> || Web: www.mev.co.uk )=-
-=( MEV Ltd. is a company registered in England & Wales. )=-
-=( Registered number: 02862268.  Registered address:    )=-
-=( 15 West Park Road, Bramhall, STOCKPORT, SK7 3JZ, UK. )=-
