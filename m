Return-Path: <SRS0=6Pxm=X6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C5AEBC47404
	for <linux-kernel@archiver.kernel.org>; Sat,  5 Oct 2019 18:30:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 942CC2084D
	for <linux-kernel@archiver.kernel.org>; Sat,  5 Oct 2019 18:30:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="I/EFFs8t"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387903AbfJESaD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 5 Oct 2019 14:30:03 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:46784 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387486AbfJESaC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 5 Oct 2019 14:30:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        Content-Type:In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:
        Subject:Sender:Reply-To:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=+fgV0tic/m2eaYgm1jyj1dhCFsqYL5Ok8DtOhW/xIhw=; b=I/EFFs8tNcRNTTsh4FxjTYyqU
        9rK/La27+zAz+k0pn/W0fDccyNKZnMSCwifeFGutHV8k9SqZLz3/qEw3OD6QxNPV7F+QtpyQQTTqu
        wz4M8HwrLgQwofpqgq3Mcyzr5571Zr1KhNLq7ITtjbnaHYEGzVXb8G2SEQcgSpMNvIUdPaclF4UCl
        L2e25p8EVw8K9UDs20pWATHEi3nqarpH4ahUNWzlly2+iytBZQUsA6i4Z0KcvlMZVvZDeYD8bZOiC
        3R5yudalCyPgakpsmrsQF78TONjr5kIZXVJALtw4KBuLl8K8fkURfleFLHXNyIaRJTxyzUd13E9sT
        Zl4qVwEzA==;
Received: from [2601:1c0:6280:3f0::9ef4]
        by bombadil.infradead.org with esmtpsa (Exim 4.92.2 #3 (Red Hat Linux))
        id 1iGoob-00086Y-F8; Sat, 05 Oct 2019 18:30:01 +0000
Subject: Re: [PATCH] drm/amdkfd: add missing void argument to function
 kgd2kfd_init
To:     Colin Ian King <colin.king@canonical.com>,
        Felix Kuehling <Felix.Kuehling@amd.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>,
        David Zhou <David1.Zhou@amd.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>, amd-gfx@lists.freedesktop.org,
        dri-devel@lists.freedesktop.org
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20191005175808.32018-1-colin.king@canonical.com>
 <7677a8bc-cc5a-eb03-c7d4-b1a27330126f@infradead.org>
 <d9ae3586-f484-9734-1cc7-5e960fde76a3@canonical.com>
From:   Randy Dunlap <rdunlap@infradead.org>
Message-ID: <43fae0fa-aa26-c713-ca64-627b58c6519b@infradead.org>
Date:   Sat, 5 Oct 2019 11:30:00 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <d9ae3586-f484-9734-1cc7-5e960fde76a3@canonical.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/5/19 11:23 AM, Colin Ian King wrote:
> On 05/10/2019 19:10, Randy Dunlap wrote:
>> On 10/5/19 10:58 AM, Colin King wrote:
>>> From: Colin Ian King <colin.king@canonical.com>
>>>
>>> Function kgd2kfd_init is missing a void argument, add it
>>> to clean up the non-ANSI function declaration.
>>>
>>> Signed-off-by: Colin Ian King <colin.king@canonical.com>
>>
>> Acked-by: Randy Dunlap <rdunlap@infradead.org>
>>
>> sparse reports 2 such warnings in amdgpu:
>>
>> ../drivers/gpu/drm/amd/amdgpu/../amdkfd/kfd_module.c:85:18: warning: non-ANSI function declaration of function 'kgd2kfd_init'
>> ../drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v10.c:168:60: warning: non-ANSI function declaration of function 'amdgpu_amdkfd_gfx_10_0_get_functions'
> 
> Looking at linux-next, the amdgpu_amdkfd_gfx_10_0_get_functions() was
> removed in commit:
> 
> commit e392c887df979112af94cfec08dd87f4dd55d085
> Author: Yong Zhao <Yong.Zhao@amd.com>
> Date:   Fri Sep 27 22:03:42 2019 -0400
> 
>     drm/amdkfd: Use array to probe kfd2kgd_calls
> 
> ..so I didn't fix that one up

ah. Thanks.

-- 
~Randy
