Return-Path: <SRS0=Dgga=T6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 84E2FC28CC3
	for <linux-kernel@archiver.kernel.org>; Thu, 30 May 2019 10:30:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 599772574B
	for <linux-kernel@archiver.kernel.org>; Thu, 30 May 2019 10:30:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="JfaWrNGv"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726581AbfE3KaB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 May 2019 06:30:01 -0400
Received: from smtprelay-out1.synopsys.com ([198.182.47.102]:33224 "EHLO
        smtprelay-out1.synopsys.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726029AbfE3KaB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 May 2019 06:30:01 -0400
Received: from mailhost.synopsys.com (dc2-mailhost2.synopsys.com [10.12.135.162])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        by smtprelay-out1.synopsys.com (Postfix) with ESMTPS id 7DE91C00FD;
        Thu, 30 May 2019 10:30:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
        t=1559212209; bh=gg8NunW7XsIUu7tJ+B+7jsvCIrIgnJylMlUTpkU5OaY=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=JfaWrNGvxdfq5OVVVJUOyO/WniWH1ZwTN88+4vua73kUXzL+7qBWFF4VvxP0SXF7R
         vxQjdu0KVs1Tuuwno7OB+6Ufbk6tjwcyfOw2xBn/O4AlQXpjfEGhUUV/6S9ZWzpPcI
         Oov+LRE4fSq+mNF7PsYoBoM+aa4YJHfuFBj2ooWsjX57ZWkf/7lwWP9dXcClip586m
         Xwp6kOvJX7K/v24iT7FH19sv9lHOMXui32/58RRgG/6/pTEmLEBEUhgspLymjgdggT
         UI3i3awQlpTBf89CwDeFIV54HuaagwcEC/EFy2QyxuFBiFksAibqVvfsmU7jTsb9EW
         MDh6ofLlrzIig==
Received: from [10.116.70.206] (hminas-7480.internal.synopsys.com [10.116.70.206])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mailhost.synopsys.com (Postfix) with ESMTPSA id 62570A0093;
        Thu, 30 May 2019 10:29:56 +0000 (UTC)
Subject: Re: [PATCH] usb: dwc2: Fix DMA cache alignment issues
To:     Doug Anderson <dianders@chromium.org>,
        Martin Schiller <ms@dev.tdt.de>,
        Felipe Balbi <felipe.balbi@linux.intel.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        =?UTF-8?B?QW50dGkgU2VwcMOkbMOk?= <a.seppala@gmail.com>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Tomasz Figa <tfiga@chromium.org>
References: <20190218063730.26870-1-ms@dev.tdt.de>
 <CAD=FV=Viag00jL-QRLsnyDoXWT5KFyZ3TnMdTPSJ-dbuNNiFVQ@mail.gmail.com>
From:   Minas Harutyunyan <Minas.Harutyunyan@synopsys.com>
Message-ID: <7bf6f5dd-6f0f-4470-51c7-d024fc8ef4df@synopsys.com>
Date:   Thu, 30 May 2019 14:29:31 +0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <CAD=FV=Viag00jL-QRLsnyDoXWT5KFyZ3TnMdTPSJ-dbuNNiFVQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 5/29/2019 10:31 PM, Doug Anderson wrote:
> Hi,
> 
> On Sun, Feb 17, 2019 at 10:37 PM Martin Schiller <ms@dev.tdt.de> wrote:
>>
>> Insert a padding between data and the stored_xfer_buffer pointer to
>> ensure they are not on the same cache line.
>>
>> Otherwise, the stored_xfer_buffer gets corrupted for IN URBs on
>> non-cache-coherent systems. (In my case: Lantiq xRX200 MIPS)
>>
>> Fixes: 3bc04e28a030 ("usb: dwc2: host: Get aligned DMA in a more supported way")
>> Fixes: 56406e017a88 ("usb: dwc2: Fix DMA alignment to start at allocated boundary")
>> Signed-off-by: Martin Schiller <ms@dev.tdt.de>
>> ---
>>   drivers/usb/dwc2/hcd.c | 10 +++++++---
>>   1 file changed, 7 insertions(+), 3 deletions(-)
> 
> This patch has been in the back of my mind for a while bug I never got
> around to it.  Today I was debugging memory corruption problems when
> using a webcam on dwc2 on rk3288-veyron-jerry.  This patch appears to
> solve my problems nicely.  Thanks!
> 
> Tested-by: Douglas Anderson <dianders@chromium.org>
> Reviewed-by: Douglas Anderson <dianders@chromium.org>
> Cc: <stable@vger.kernel.org>
> 
Acked-by: Minas Harutyunyan <hminas@synopsys.com>
