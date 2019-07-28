Return-Path: <SRS0=snA0=VZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E1859C7618B
	for <linux-kernel@archiver.kernel.org>; Sun, 28 Jul 2019 15:27:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B0D9A2087C
	for <linux-kernel@archiver.kernel.org>; Sun, 28 Jul 2019 15:27:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1564327647;
	bh=bSQqj81OFhTS9fr+a17fW6IivROjh1l2SgkZJuOQ7Ig=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=u6vtcdKWVRHpdNDH0xwk2S2GGCb1SXLiz3KhSKr2nxeEj5M0P5xnsHfTj54954zZ3
	 CkjXulD6+NPzsBkxLxcrihu2NM+lFG32dtJTamU0EH7M9IGN5hhx2/QPNg0iB1bPEo
	 3+EsOlaSwtGnZWNplJOGRbBWm2yizAQcRHWZw67k=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726129AbfG1P10 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 28 Jul 2019 11:27:26 -0400
Received: from mail.kernel.org ([198.145.29.99]:46676 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726046AbfG1P10 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 28 Jul 2019 11:27:26 -0400
Received: from localhost (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2CB4D2077C;
        Sun, 28 Jul 2019 15:27:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1564327645;
        bh=bSQqj81OFhTS9fr+a17fW6IivROjh1l2SgkZJuOQ7Ig=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=CJy53QQHH7HkTyXVF/sQUeuAD+Pk2nNmfgGOD0BMpldhNG3sUyV0jA66vawRIHFkw
         B1LuNm+6kF3qPEyjrMnSrCPfWdBQL1KEwT3AqD287PAKoYlaycmodCShjEpD2v3D3p
         aL22sXyXF/nSmVY8OAe6+yYhMWAy6EcwmL0ED8zQ=
Date:   Sun, 28 Jul 2019 11:27:24 -0400
From:   Sasha Levin <sashal@kernel.org>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-kernel@vger.kernel.org, stable@vger.kernel.org,
        Gen Zhang <blackgod016574@gmail.com>,
        Kees Cook <keescook@chromium.org>
Subject: Re: [PATCH AUTOSEL 5.2 014/171] consolemap: Fix a memory leaking bug
 in drivers/tty/vt/consolemap.c
Message-ID: <20190728152724.GE8637@sasha-vm>
References: <20190719035643.14300-1-sashal@kernel.org>
 <20190719035643.14300-14-sashal@kernel.org>
 <20190719100331.GA11778@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20190719100331.GA11778@kroah.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 19, 2019 at 07:03:31PM +0900, Greg Kroah-Hartman wrote:
>On Thu, Jul 18, 2019 at 11:54:05PM -0400, Sasha Levin wrote:
>> From: Gen Zhang <blackgod016574@gmail.com>
>>
>> [ Upstream commit 84ecc2f6eb1cb12e6d44818f94fa49b50f06e6ac ]
>>
>> In function con_insert_unipair(), when allocation for p2 and p1[n]
>> fails, ENOMEM is returned, but previously allocated p1 is not freed,
>> remains as leaking memory. Thus we should free p1 as well when this
>> allocation fails.
>>
>> Signed-off-by: Gen Zhang <blackgod016574@gmail.com>
>> Reviewed-by: Kees Cook <keescook@chromium.org>
>> Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
>> Signed-off-by: Sasha Levin <sashal@kernel.org>
>> ---
>>  drivers/tty/vt/consolemap.c | 6 +++++-
>>  1 file changed, 5 insertions(+), 1 deletion(-)
>
>No, please do not take this patch, it was reverted in commit
>15b3cd8ef46a ("Revert "consolemap: Fix a memory leaking bug in
>drivers/tty/vt/consolemap.c"") because it was broken.
>
>Please drop from all of the autosel queues.

Now dropped, thanks!

--
Thanks,
Sasha
