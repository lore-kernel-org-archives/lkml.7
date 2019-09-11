Return-Path: <SRS0=Kqgt=XG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 20E58ECDE27
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Sep 2019 09:04:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F20A320CC7
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Sep 2019 09:04:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727308AbfIKJEv convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 11 Sep 2019 05:04:51 -0400
Received: from mxout012.mail.hostpoint.ch ([217.26.49.172]:13203 "EHLO
        mxout012.mail.hostpoint.ch" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726696AbfIKJEu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Sep 2019 05:04:50 -0400
Received: from [10.0.2.46] (helo=asmtp013.mail.hostpoint.ch)
        by mxout012.mail.hostpoint.ch with esmtp (Exim 4.92.2 (FreeBSD))
        (envelope-from <sandro@volery.com>)
        id 1i7yYJ-000Dkw-Uz; Wed, 11 Sep 2019 11:04:39 +0200
Received: from [213.55.220.251] (helo=[100.66.103.90])
        by asmtp013.mail.hostpoint.ch with esmtpsa (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.92.2 (FreeBSD))
        (envelope-from <sandro@volery.com>)
        id 1i7yYJ-000NhF-QB; Wed, 11 Sep 2019 11:04:39 +0200
X-Authenticated-Sender-Id: sandro@volery.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8BIT
From:   Sandro Volery <sandro@volery.com>
Mime-Version: 1.0 (1.0)
Subject: Re: [PATCH] Staging: octeon: Avoid several usecases of strcpy
Date:   Wed, 11 Sep 2019 11:04:38 +0200
Message-Id: <39D8B984-479C-42D5-8431-9FF7BD3A96D6@volery.com>
References: <20190911084956.GH15977@kadam>
Cc:     gregkh@linuxfoundation.org, davem@davemloft.net,
        aaro.koskinen@iki.fi, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20190911084956.GH15977@kadam>
To:     Dan Carpenter <dan.carpenter@oracle.com>
X-Mailer: iPhone Mail (17A5831c)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> On 11 Sep 2019, at 10:52, Dan Carpenter <dan.carpenter@oracle.com> wrote:
> 
> ﻿On Wed, Sep 11, 2019 at 08:23:59AM +0200, Sandro Volery wrote:
>> strcpy was used multiple times in strcpy to write into dev->name.
>> I replaced them with strscpy.
>> 
>> Signed-off-by: Sandro Volery <sandro@volery.com>
>> ---
>> drivers/staging/octeon/ethernet.c | 16 ++++++++--------
>> 1 file changed, 8 insertions(+), 8 deletions(-)
>> 
>> diff --git a/drivers/staging/octeon/ethernet.c b/drivers/staging/octeon/ethernet.c
>> index 8889494adf1f..cf8e9a23ebf9 100644
>> --- a/drivers/staging/octeon/ethernet.c
>> +++ b/drivers/staging/octeon/ethernet.c
>> @@ -784,7 +784,7 @@ static int cvm_oct_probe(struct platform_device *pdev)
>>            priv->imode = CVMX_HELPER_INTERFACE_MODE_DISABLED;
>>            priv->port = CVMX_PIP_NUM_INPUT_PORTS;
>>            priv->queue = -1;
>> -            strcpy(dev->name, "pow%d");
>> +            strscpy(dev->name, "pow%d", sizeof(dev->name));
> 
> Is there a program which is generating a warning for this code?  We know
> that "pow%d" is 6 characters and static analysis tools can understand
> this code fine so we know it's safe.

Well I was confused too but checkpatch complained about 
it so I figured I'd clean it up quick
