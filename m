Return-Path: <SRS0=oHH8=SG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D6B5CC10F0B
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Apr 2019 00:46:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9ABA5214AF
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Apr 2019 00:46:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1554338772;
	bh=CW7oWxuz0vkBorOSTS4KBZ083lSAu5t1fcP6gbNwhok=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=rBetSxnPB7kBsKhO+IapVwGUy4M6OtIZs6QPEfwtM2aNAQaGxqj2h06rk3rd+i4Ad
	 m3Dkef9Q+k+WBCLJsjbB46iOyDbSpvsFt2NQlgkY4BpLkMoPzG2+hVLGyBEzbvzFnH
	 8BPbM7pbej9QOFbOPatvFx0gQ2idPFoJ6Nqe8qY4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726415AbfDDAqL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 3 Apr 2019 20:46:11 -0400
Received: from mail.kernel.org ([198.145.29.99]:49980 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726099AbfDDAqK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Apr 2019 20:46:10 -0400
Received: from localhost (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D1A272133D;
        Thu,  4 Apr 2019 00:46:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1554338770;
        bh=CW7oWxuz0vkBorOSTS4KBZ083lSAu5t1fcP6gbNwhok=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Lm+e0v2L/wRvPXiO3qwfGcREyNxpSJ9HC3QOIR0/oQbTU9zJju2/9jX0aFUdHqXuA
         AZ+UID9iSoU7gOv0g8hWv9xVf2GaT7LN/xrOpu/9CXDcUoBhu7brO2ZL96RA4QZEN/
         VHEbPCs3xEni6pj5y9XuITHoNcYFKA4W19pMdVRM=
Date:   Wed, 3 Apr 2019 20:46:08 -0400
From:   Sasha Levin <sashal@kernel.org>
To:     Mark Brown <broonie@kernel.org>
Cc:     linux-kernel@vger.kernel.org, stable@vger.kernel.org,
        Axel Lin <axel.lin@ingics.com>
Subject: Re: [PATCH AUTOSEL 5.0 209/262] regulator: mcp16502: Include
 linux/gpio/consumer.h to fix build error
Message-ID: <20190404004608.GG16241@sasha-vm>
References: <20190327180158.10245-1-sashal@kernel.org>
 <20190327180158.10245-209-sashal@kernel.org>
 <20190327193211.GC11404@sirena.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20190327193211.GC11404@sirena.org.uk>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 27, 2019 at 07:32:11PM +0000, Mark Brown wrote:
>On Wed, Mar 27, 2019 at 02:01:04PM -0400, Sasha Levin wrote:
>> From: Axel Lin <axel.lin@ingics.com>
>>
>> [ Upstream commit f3c6a1a194317f3a31ee2b2067bb0a41de64bc8b ]
>>
>> Fix below build error:
>> drivers/regulator/mcp16502.c: In function ‘mcp16502_gpio_set_mode’:
>> drivers/regulator/mcp16502.c:135:3: error: implicit declaration of function ‘gpiod_set_value’; did you mean ‘gpio_set_value’? [-Werror=implicit-function-declaration]
>>    gpiod_set_value(mcp->lpm, 0);
>
>Does this error actually manifest in v5.0?

I couldn't reproduce the error on f3c6a1a194317f^ so I assumed it
requires a specialized config.

--
Thanks,
Sasha
