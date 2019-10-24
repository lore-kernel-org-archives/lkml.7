Return-Path: <SRS0=Yun1=YR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 15EF9CA9EAF
	for <linux-kernel@archiver.kernel.org>; Thu, 24 Oct 2019 15:26:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DC990205C9
	for <linux-kernel@archiver.kernel.org>; Thu, 24 Oct 2019 15:26:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="VvGDl+Z9"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2503173AbfJXP0E (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 24 Oct 2019 11:26:04 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:58400 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2503092AbfJXP0E (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Oct 2019 11:26:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        Content-Type:In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:
        Subject:Sender:Reply-To:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=BTqk/quYZ0PsikyKSM8B9GWYX1I9kMYV4Oehz8S/Sn0=; b=VvGDl+Z9DRnvhV+J0LRBvrhlw
        /6BjlEs+PEg3z1OR9FxnlREDa6eCqsYM4wl0/fALby7IY1yPiOOdfphsLoIk0nJ2mPCECrPZSQpCc
        8Ut7ZY9Hxab5yHfrvcNj0vHf8QwFMn+5IPC3SrREX0uuW7A329qOj2lttjc4h1/HDqAKLs5zg3i2C
        v6D+aVJfnun54lP8NDQn+FWJ88qmmuKD/ELm9FmYI6yrRD5YFzRXzX5HTvWYpP1fMc4Ex4qrokUjj
        3VgnKbbVmGbTh0fGFhO/3ZcPy3++KUPz0/RjqGqs+bEYNiKSuYpvn+GDwhY9U3483p4ePsXnT1TFb
        SaXF+otHQ==;
Received: from [2601:1c0:6280:3f0::9ef4]
        by bombadil.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1iNf00-0008Nj-Ca; Thu, 24 Oct 2019 15:26:04 +0000
Subject: Re: [PATCH] reset: fix kernel-doc warnings
To:     Philipp Zabel <p.zabel@pengutronix.de>,
        LKML <linux-kernel@vger.kernel.org>
Cc:     "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>
References: <6e166445-2a3d-dd4d-22ea-3ab77d3d3b11@infradead.org>
 <1971768470f06ad1a051b44ed0041de6550964b8.camel@pengutronix.de>
From:   Randy Dunlap <rdunlap@infradead.org>
Message-ID: <aa63055c-c015-0383-02eb-494bfb312f9d@infradead.org>
Date:   Thu, 24 Oct 2019 08:26:03 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
MIME-Version: 1.0
In-Reply-To: <1971768470f06ad1a051b44ed0041de6550964b8.camel@pengutronix.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/24/19 1:47 AM, Philipp Zabel wrote:
> Hi Randy,
> 
> thank you for the fixes.
> 
> On Tue, 2019-10-22 at 20:57 -0700, Randy Dunlap wrote:
>> From: Randy Dunlap <rdunlap@infradead.org>
>>
>> Fix kernel-doc warnings discovered in the reset controller API chapter.
>> Fixes these warnings:
>>
>> ./drivers/reset/core.c:86: warning: Excess function parameter 'flags' description in 'of_reset_simple_xlate'
>> ./drivers/reset/core.c:830: warning: Incorrect use of kernel-doc format:  * of_reset_control_get_count - Count number of resets available with a device
>> ./drivers/reset/core.c:838: warning: Function parameter or member 'node' not described in 'of_reset_control_get_count'
>> ./include/linux/reset-controller.h:45: warning: Function parameter or member 'con_id' not described in 'reset_control_lookup'
>> ./drivers/reset/core.c:86: warning: Excess function parameter 'flags' description in 'of_reset_simple_xlate'
>> ./drivers/reset/core.c:830: warning: Incorrect use of kernel-doc format:  * of_reset_control_get_count - Count number of resets available with a device
>>
>> Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
>> Cc: Philipp Zabel <p.zabel@pengutronix.de>
>> ---
>>  drivers/reset/core.c             |    4 ++--
>>  include/linux/reset-controller.h |    4 ++--
> [...]
>> @@ -7,7 +7,7 @@
>>  struct reset_controller_dev;
>>  
>>  /**
>> - * struct reset_control_ops
>> + * struct reset_control_ops - reset controller driver callbacks
>>   *
>>   * @reset: for self-deasserting resets, does all necessary
>>   *         things to reset the device
> 
> This is all that remains when I rebase onto reset/fixes. Ok to apply
> this and change the commit message to:
> 
>   reset: fix reset_control_ops kerneldoc comment
> 
>   Add a missing short description to the reset_control_ops
>   documentation.
> 
> ?

Of course.  Go for it.

-- 
~Randy

