Return-Path: <SRS0=PjNn=RI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0F74EC4360F
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Mar 2019 12:11:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CA2A2206DD
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Mar 2019 12:11:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=mev.co.uk header.i=@mev.co.uk header.b="MLT15a2g"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728051AbfCEMLr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 5 Mar 2019 07:11:47 -0500
Received: from smtp121.iad3b.emailsrvr.com ([146.20.161.121]:52868 "EHLO
        smtp121.iad3b.emailsrvr.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726150AbfCEMLr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Mar 2019 07:11:47 -0500
X-Greylist: delayed 415 seconds by postgrey-1.27 at vger.kernel.org; Tue, 05 Mar 2019 07:11:46 EST
Received: from smtp16.relay.iad3b.emailsrvr.com (localhost [127.0.0.1])
        by smtp16.relay.iad3b.emailsrvr.com (SMTP Server) with ESMTP id 32170C027C;
        Tue,  5 Mar 2019 07:04:51 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=mev.co.uk;
        s=20190130-41we5z8j; t=1551787491;
        bh=x9fTJmAb/bVCoAohjNpBMOmDiO/HmJ4e2SFY0LGS9Oo=;
        h=Subject:To:From:Date:From;
        b=MLT15a2gywq9x+wl0BxyLksyUSVgSXjcxZsVIPlWA0b0KWx4BbjWAzffJHolJtNVi
         j88Ft0PBFAS475JuqYus86j4ii6hCkOlUtH1tnu1J85/mjfs1PpQHSfzVHIADQqHoP
         X6a2f0FbFVS5IaGXkyAtghQ3CPQNncIprJ0SbmGE=
X-Auth-ID: abbotti@mev.co.uk
Received: by smtp16.relay.iad3b.emailsrvr.com (Authenticated sender: abbotti-AT-mev.co.uk) with ESMTPSA id 64B4CC0259;
        Tue,  5 Mar 2019 07:04:50 -0500 (EST)
X-Sender-Id: abbotti@mev.co.uk
Received: from [10.0.0.185] (remote.quintadena.com [81.133.34.160])
        (using TLSv1.2 with cipher AES128-SHA)
        by 0.0.0.0:465 (trex/5.7.12);
        Tue, 05 Mar 2019 07:04:51 -0500
Subject: Re: [PATCH] staging: comedi: ni_mio_common: Fix divide-by-zero for
 DIO cmdtest
To:     Dan Carpenter <dan.carpenter@oracle.com>
Cc:     devel@driverdev.osuosl.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Spencer E . Olson" <olsonse@umich.edu>,
        linux-kernel@vger.kernel.org, stable@vger.kernel.org
References: <20190304143354.4964-1-abbotti@mev.co.uk>
 <20190305081629.GA13474@kadam>
 <261cec72-ed19-7092-5307-76481e9f20ba@mev.co.uk>
 <20190305113915.GB13474@kadam>
From:   Ian Abbott <abbotti@mev.co.uk>
Organization: MEV Ltd.
Message-ID: <8b6ca08f-ec7f-4a8f-7cdc-c42bf540aff1@mev.co.uk>
Date:   Tue, 5 Mar 2019 12:04:49 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.1
MIME-Version: 1.0
In-Reply-To: <20190305113915.GB13474@kadam>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 05/03/2019 11:39, Dan Carpenter wrote:
> On Tue, Mar 05, 2019 at 11:32:18AM +0000, Ian Abbott wrote:
>> On 05/03/2019 11:10, Dan Carpenter wrote:
>>> On Mon, Mar 04, 2019 at 02:33:54PM +0000, Ian Abbott wrote:
>>>> The problem was reported on the COMEDI mailing list here:
>>>> https://groups.google.com/forum/#!topic/comedi_list/4t9WlHzMhKM
>>>>
>>>
>>> Can you give Ivan a Reported-by tag?  It's a public mailing list so
>>> that shouldn't be a problem.
>>
>> I can do, but I don't know his full name.  Will that be a problem?
>>
> 
> Nah, it's not a problem.  People should fix their email headers to
> reflect what they want to be called.
> 
> Or you could ask but I don't think I have ever asked for someone's name
> I've always just gone with their email header name.

In this case, Ivan just signed off with that name and it didn't appear 
in the email headers.

-- 
-=( Ian Abbott <abbotti@mev.co.uk> || Web: www.mev.co.uk )=-
-=( MEV Ltd. is a company registered in England & Wales. )=-
-=( Registered number: 02862268.  Registered address:    )=-
-=( 15 West Park Road, Bramhall, STOCKPORT, SK7 3JZ, UK. )=-
