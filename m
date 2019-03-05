Return-Path: <SRS0=PjNn=RI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1C5CBC43381
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Mar 2019 11:32:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E1ACE2084F
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Mar 2019 11:32:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=mev.co.uk header.i=@mev.co.uk header.b="hmfMJQUx"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727829AbfCELcW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 5 Mar 2019 06:32:22 -0500
Received: from smtp113.ord1d.emailsrvr.com ([184.106.54.113]:39122 "EHLO
        smtp113.ord1d.emailsrvr.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727305AbfCELcV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Mar 2019 06:32:21 -0500
Received: from smtp23.relay.ord1d.emailsrvr.com (localhost [127.0.0.1])
        by smtp23.relay.ord1d.emailsrvr.com (SMTP Server) with ESMTP id B207A201BD;
        Tue,  5 Mar 2019 06:32:20 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=mev.co.uk;
        s=20190130-41we5z8j; t=1551785540;
        bh=aTS+w9vaCrfJLA/t7vBQ3ycgmUsOm+Ymcbo0/vx4F30=;
        h=Subject:To:From:Date:From;
        b=hmfMJQUx0i4L5GyKJ4brP+n7SuCeH333xl1GePUo8+XFL0AgwGFvPKdmIB1EQ9Eud
         O9CfLgBLGiApaiPbRstidn4rp6HzilLTN0H3cxo8i+6LFH8D1DkELod29xFkfbfKPG
         tLpophMNne4qosoIHUxJfW2clqOU702deQRqvGwU=
X-Auth-ID: abbotti@mev.co.uk
Received: by smtp23.relay.ord1d.emailsrvr.com (Authenticated sender: abbotti-AT-mev.co.uk) with ESMTPSA id CFC20201E7;
        Tue,  5 Mar 2019 06:32:19 -0500 (EST)
X-Sender-Id: abbotti@mev.co.uk
Received: from [10.0.0.185] (remote.quintadena.com [81.133.34.160])
        (using TLSv1.2 with cipher AES128-SHA)
        by 0.0.0.0:465 (trex/5.7.12);
        Tue, 05 Mar 2019 06:32:20 -0500
Subject: Re: [PATCH] staging: comedi: ni_mio_common: Fix divide-by-zero for
 DIO cmdtest
To:     Dan Carpenter <dan.carpenter@oracle.com>
Cc:     devel@driverdev.osuosl.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org, stable@vger.kernel.org,
        "Spencer E . Olson" <olsonse@umich.edu>
References: <20190304143354.4964-1-abbotti@mev.co.uk>
 <20190305081629.GA13474@kadam>
From:   Ian Abbott <abbotti@mev.co.uk>
Organization: MEV Ltd.
Message-ID: <261cec72-ed19-7092-5307-76481e9f20ba@mev.co.uk>
Date:   Tue, 5 Mar 2019 11:32:18 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.1
MIME-Version: 1.0
In-Reply-To: <20190305081629.GA13474@kadam>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 05/03/2019 11:10, Dan Carpenter wrote:
> On Mon, Mar 04, 2019 at 02:33:54PM +0000, Ian Abbott wrote:
>> The problem was reported on the COMEDI mailing list here:
>> https://groups.google.com/forum/#!topic/comedi_list/4t9WlHzMhKM
>>
> 
> Can you give Ivan a Reported-by tag?  It's a public mailing list so
> that shouldn't be a problem.

I can do, but I don't know his full name.  Will that be a problem?

> 
>> Fixes: f164cbf98fa8 ("staging: comedi: ni_mio_common: add finite regeneration to dio output")
>> Cc: <stable@vger.kernel.org> # 4.6+
>> Cc: Spencer E. Olson <olsonse@umich.edu>
>> Signed-off-by: Ian Abbott <abbotti@mev.co.uk>
>> ---
> 
> regards,
> dan carpenter
> 
> 


-- 
-=( Ian Abbott <abbotti@mev.co.uk> || Web: www.mev.co.uk )=-
-=( MEV Ltd. is a company registered in England & Wales. )=-
-=( Registered number: 02862268.  Registered address:    )=-
-=( 15 West Park Road, Bramhall, STOCKPORT, SK7 3JZ, UK. )=-
