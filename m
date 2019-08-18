Return-Path: <SRS0=w4Fx=WO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F07DEC3A59F
	for <linux-kernel@archiver.kernel.org>; Sun, 18 Aug 2019 01:47:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C5ACC21773
	for <linux-kernel@archiver.kernel.org>; Sun, 18 Aug 2019 01:47:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1566092877;
	bh=ChAVdJpNLOryLOHbb3Di/mHnhmC5olD86fEm37XBG2Y=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=raX+4fT19yrGlij6fRMumwVIoFctq42xFDfItmILIWKvjQIMkslg5nby501r9rTDU
	 1eb00Wbvw1HER5hdWX66BQQHbLtCy9VAHGbFTJUBE9c9yPp16Q8tbtk/xL1soBD0tF
	 B7enMn5HQUXPKLegsI6gLwCVVlrolu6v2daJDuhw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726513AbfHRBr5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 17 Aug 2019 21:47:57 -0400
Received: from mail.kernel.org ([198.145.29.99]:54318 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726463AbfHRBr4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 17 Aug 2019 21:47:56 -0400
Received: from localhost (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5A3972086C;
        Sun, 18 Aug 2019 01:47:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1566092875;
        bh=ChAVdJpNLOryLOHbb3Di/mHnhmC5olD86fEm37XBG2Y=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=KXwHHxunnE2XJaI4MsPpbWNswT0MoXe46Aegh6eQyTKR0cZU2bGR75KCt8qeIAZRy
         Krba46V3X39/Kj00cUWW2yQpkuN5zu46CLZ9INRyWf7z3k+OlUXaFn8QEKkZS9Jdo1
         EqEWYzBeSxHdXaQYrX9Z8dGe1cUvnWhJg5pM+++8=
Date:   Sat, 17 Aug 2019 21:47:54 -0400
From:   Sasha Levin <sashal@kernel.org>
To:     David Laight <David.Laight@ACULAB.COM>
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>,
        Colin Ian King <colin.king@canonical.com>,
        Inki Dae <inki.dae@samsung.com>,
        "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>
Subject: Re: [PATCH AUTOSEL 5.2 51/59] drm/exynos: fix missing decrement of
 retry counter
Message-ID: <20190818014754.GE1318@sasha-vm>
References: <20190806213319.19203-1-sashal@kernel.org>
 <20190806213319.19203-51-sashal@kernel.org>
 <2ecde45912fc44b88df2ff5129b8ab67@AcuMS.aculab.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <2ecde45912fc44b88df2ff5129b8ab67@AcuMS.aculab.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 07, 2019 at 08:49:52AM +0000, David Laight wrote:
>From: Sasha Levin
>> Sent: 06 August 2019 22:33
>>
>> From: Colin Ian King <colin.king@canonical.com>
>>
>> [ Upstream commit 1bbbab097a05276e312dd2462791d32b21ceb1ee ]
>>
>> Currently the retry counter is not being decremented, leading to a
>> potential infinite spin if the scalar_reads don't change state.
>>
>> Addresses-Coverity: ("Infinite loop")
>> Fixes: 280e54c9f614 ("drm/exynos: scaler: Reset hardware before starting the operation")
>> Signed-off-by: Colin Ian King <colin.king@canonical.com>
>> Signed-off-by: Inki Dae <inki.dae@samsung.com>
>> Signed-off-by: Sasha Levin <sashal@kernel.org>
>> ---
>>  drivers/gpu/drm/exynos/exynos_drm_scaler.c | 4 ++--
>>  1 file changed, 2 insertions(+), 2 deletions(-)
>>
>> diff --git a/drivers/gpu/drm/exynos/exynos_drm_scaler.c b/drivers/gpu/drm/exynos/exynos_drm_scaler.c
>> index ec9c1b7d31033..8989f8af716b7 100644
>> --- a/drivers/gpu/drm/exynos/exynos_drm_scaler.c
>> +++ b/drivers/gpu/drm/exynos/exynos_drm_scaler.c
>> @@ -94,12 +94,12 @@ static inline int scaler_reset(struct scaler_context *scaler)
>>  	scaler_write(SCALER_CFG_SOFT_RESET, SCALER_CFG);
>>  	do {
>>  		cpu_relax();
>> -	} while (retry > 1 &&
>> +	} while (--retry > 1 &&
>>  		 scaler_read(SCALER_CFG) & SCALER_CFG_SOFT_RESET);
>>  	do {
>>  		cpu_relax();
>>  		scaler_write(1, SCALER_INT_EN);
>> -	} while (retry > 0 && scaler_read(SCALER_INT_EN) != 1);
>> +	} while (--retry > 0 && scaler_read(SCALER_INT_EN) != 1);
>>
>>  	return retry ? 0 : -EIO;
>
>If the first loop hits the retry limit the second loop won't be right
>and the final return value will be 0.

This looks like an upstream problem as well, no?

--
Thanks,
Sasha
