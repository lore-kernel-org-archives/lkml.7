Return-Path: <SRS0=FHjv=VA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 922C0C0650E
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Jul 2019 15:58:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 66E12218A4
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Jul 2019 15:58:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1562169534;
	bh=J4HlPTdF3jGMTjrdkC8qObdbo2O6ahjLRxOMA7sWIZc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=oFARdFYrMKpMwmjddnxZv8G614RGUr7InRbQGjGKa0wTwEpjZhG8YDHS9x3ZQeOiX
	 JwDYtu7RUzU+7SHzjw3HYy0pub/xghqRG/TlKvFBHLE2cLgJe46lXLPfTMlpgEc3re
	 aMOupwYfTIGFbIg/Gu8Gz13GBP2ASPisc/87WGtk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726871AbfGCP6x (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 3 Jul 2019 11:58:53 -0400
Received: from mail.kernel.org ([198.145.29.99]:54110 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726614AbfGCP6w (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Jul 2019 11:58:52 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5C6C92189E;
        Wed,  3 Jul 2019 15:58:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1562169531;
        bh=J4HlPTdF3jGMTjrdkC8qObdbo2O6ahjLRxOMA7sWIZc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ZB5UzKWCkybRxzVYyxh4b4PA357aO27DtdsZWYIRSIs5reL4uCKUb9b4Te9OfRbPU
         oOzAJwV89J+aPFY+ojXFj41NnfOT5RXlSqynHt0Bn0nocqH0kCCzNyUEt152+VrOn6
         yUm2lmhJQPjkMGggR56rixMwbe2PBH47f6SO2L+4=
Date:   Wed, 3 Jul 2019 17:58:49 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc:     linux-kernel@vger.kernel.org,
        Shaokun Zhang <zhangshaokun@hisilicon.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: Re: [GIT PULL 1/9] intel_th: msu: Fix unused variable warning on
 arm64 platform
Message-ID: <20190703155849.GA19567@kroah.com>
References: <20190627125152.54905-1-alexander.shishkin@linux.intel.com>
 <20190627125152.54905-2-alexander.shishkin@linux.intel.com>
 <20190703154551.GA19371@kroah.com>
 <87muhvt8pu.fsf@ashishki-desk.ger.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <87muhvt8pu.fsf@ashishki-desk.ger.corp.intel.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 03, 2019 at 06:54:05PM +0300, Alexander Shishkin wrote:
> Greg Kroah-Hartman <gregkh@linuxfoundation.org> writes:
> 
> > On Thu, Jun 27, 2019 at 03:51:44PM +0300, Alexander Shishkin wrote:
> >> From: Shaokun Zhang <zhangshaokun@hisilicon.com>
> >> 
> >> Commit ba39bd8306057 ("intel_th: msu: Switch over to scatterlist")
> >> introduced the following warnings on non-x86 architectures, as a result
> >> of reordering the multi mode buffer allocation sequence:
> >> 
> >> > drivers/hwtracing/intel_th/msu.c: In function ‘msc_buffer_win_alloc’:
> >> > drivers/hwtracing/intel_th/msu.c:783:21: warning: unused variable ‘i’
> >> > [-Wunused-variable]
> >> > int ret = -ENOMEM, i;
> >> >                    ^
> >> > drivers/hwtracing/intel_th/msu.c: In function ‘msc_buffer_win_free’:
> >> > drivers/hwtracing/intel_th/msu.c:863:6: warning: unused variable ‘i’
> >> > [-Wunused-variable]
> >> > int i;
> >> >     ^
> >> 
> >> Fix this compiler warning by factoring out set_memory sequences and making
> >> them x86-only.
> >> 
> >> Suggested-by: Alexander Shishkin <alexander.shishkin@linux.intel.com>
> >> Signed-off-by: Shaokun Zhang <zhangshaokun@hisilicon.com>
> >> Fixes: ba39bd8306057 ("intel_th: msu: Switch over to scatterlist")
> >> Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> >> Signed-off-by: Alexander Shishkin <alexander.shishkin@linux.intel.com>
> >> ---
> >>  drivers/hwtracing/intel_th/msu.c | 40 +++++++++++++++++++++-----------
> >>  1 file changed, 27 insertions(+), 13 deletions(-)
> >
> > Does not apply to my tree :(
> 
> It's the same one as the one in the fixes series. I just put it here for
> completeness.

to be extra sure it was really applied?  that's funny...
