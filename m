Return-Path: <SRS0=GgR0=RR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6BE6DC43381
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Mar 2019 17:15:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 355C4217F5
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Mar 2019 17:15:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1552583749;
	bh=yeydLTbTVc7QWNo+P79fprtWsnwGJd7EbsJQWE+gORY=;
	h=Subject:To:Cc:References:From:Date:In-Reply-To:List-ID:From;
	b=w65cwBSL6FPLBqHLbrsRarGkGXErwMGbU1R6QnaFCfu/PQ70u7UY10NMuta+PFVg9
	 nxZZpPPm5AKKYFQWTSNQLcsCQq62elkYfMDMXpHLQkZW5gSvPoheGhx9iBIYJdH5ud
	 2APzK1xbWOcsdPEDe02nv6jB8mDPlQSH/uIDRYsc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727215AbfCNRPr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Mar 2019 13:15:47 -0400
Received: from mail.kernel.org ([198.145.29.99]:50408 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726157AbfCNRPr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Mar 2019 13:15:47 -0400
Received: from [172.22.82.216] (unknown [12.27.65.221])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 83423217F5;
        Thu, 14 Mar 2019 17:15:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1552583746;
        bh=yeydLTbTVc7QWNo+P79fprtWsnwGJd7EbsJQWE+gORY=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=fj4ps5hK3cUQqXYuIVd9nAB1TARcVE+A5v+suyCOcYItDhAfgz9J9fzxEqXKSCB4d
         0dIq4Q8R8GeADgezaPIHV6LMoplwvf5Nf6n49leSUrgV5/aLg/UHin7gArekO3Ropc
         mF7kiU+Q8+YS3cfSW9wfevIR3xAXy7h4uPXbhfTQ=
Subject: Re: WARNING: ODEBUG bug in vudc_probe
To:     Dmitry Vyukov <dvyukov@google.com>
Cc:     Valentina Manea <valentina.manea.m@gmail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        USB list <linux-usb@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>, shuah <shuah@kernel.org>
References: <CACT4Y+Ywimrr3_oD2r=u0-Sz-PFXL2tpXA4q0odKDMM_Tvw0AA@mail.gmail.com>
 <8e8f8ac1-8b72-a21c-f504-74a5ce12b625@kernel.org>
 <CACT4Y+bJ+o7yLcPwQRbsD4_Ye_SsXe3GfmiozVJ-8w-4asyxbQ@mail.gmail.com>
 <7c37c201-8bca-ffa4-5e8d-5e0b4b268b3f@kernel.org>
 <CACT4Y+ZV2aMWjobgV=-aUdSLnGU=_2yuf2TOx4TD8ApoVqRVYw@mail.gmail.com>
 <CACT4Y+abRq25axHrxNczh7sVw2RjYJB8y7JOBmyMmVF5xJ+Y1w@mail.gmail.com>
 <CACT4Y+a2aQ31MVxtb0hYZ0mxaXLVmhgeP2iE5gFQgmafv3p7gw@mail.gmail.com>
From:   shuah <shuah@kernel.org>
Message-ID: <1694e4f1-de18-bb34-2031-7d570d977495@kernel.org>
Date:   Thu, 14 Mar 2019 11:15:44 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.1
MIME-Version: 1.0
In-Reply-To: <CACT4Y+a2aQ31MVxtb0hYZ0mxaXLVmhgeP2iE5gFQgmafv3p7gw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Dmitry,

On 3/11/19 8:18 AM, Dmitry Vyukov wrote:
> On Mon, Mar 11, 2019 at 3:16 PM Dmitry Vyukov <dvyukov@google.com> wrote:
>>

>>
>> The boot seems to be fixed now, but what commit fixed it?
>>
>> This bug makes all kernels starting from 4.14 unbootable for the
>> purposes of bisection. If we figure out what was the bug and what
>> fixed it, we can think of possible ways of unbreaking kernel boot.
> 
> 


Upstream commit:
commit e28fd56ad5273be67d0fae5bedc7e1680e729952

4.14.81 commit:

commit 255624a35b4ca228bac9a1f135263e28c27c4640

Please let me know if you are still seeing the problem. I will start
looking at it.

thanks,
-- Shuah
