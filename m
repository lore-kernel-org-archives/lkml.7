Return-Path: <SRS0=g5d9=RD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 44FD5C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Feb 2019 08:05:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F17382171F
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Feb 2019 08:05:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kroah.com header.i=@kroah.com header.b="P84r7zWC";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="yHwraVvE"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731936AbfB1IFA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Feb 2019 03:05:00 -0500
Received: from out2-smtp.messagingengine.com ([66.111.4.26]:44561 "EHLO
        out2-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1730263AbfB1IFA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Feb 2019 03:05:00 -0500
Received: from compute6.internal (compute6.nyi.internal [10.202.2.46])
        by mailout.nyi.internal (Postfix) with ESMTP id BACA82436D;
        Thu, 28 Feb 2019 03:04:58 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute6.internal (MEProxy); Thu, 28 Feb 2019 03:04:58 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kroah.com; h=
        date:from:to:cc:subject:message-id:references:mime-version
        :content-type:in-reply-to; s=fm3; bh=7ldWtmcG/d5iBw1BFnyPdc4WH1C
        DB0IBi9Fuwrv8RZA=; b=P84r7zWChz+ZPRISmUbsdiFvqQYE9WbiP0+/jlhraOY
        zPcmLvkm0SJihaQjcpzjl0tXMFMHTDptudVhnOmp4/tmrGcjqm7wKXb0fVwUZCvE
        oSejRx2womTwJ+hX3dwOBxlUlYBdtawJFZe5XJe5AzoJ9DYX9H1FbvyXbwbFcuVC
        dVl/cbTlgAzUJvzIvnJS3tbLO868nZfKXj6vH7m72q3FyhJoKzi1hDyYREVLrYVT
        c+rN077oHwNdu81xwgevS/GsxXKBEMFtq0PWKhhxkeJu4S+/CWIiHvZ9K8DSNmyx
        93mMuJE54f5HJ5RCgXvJXqhPM8N4uX7cMy3Isy1ul4w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; bh=7ldWtm
        cG/d5iBw1BFnyPdc4WH1CDB0IBi9Fuwrv8RZA=; b=yHwraVvEg6uVeJe/0Mq1GN
        mB/kUHmVZQs9wkAW1TjlpiZzpK34FrxnwGMrXeFHdruj8L0HS86eifbzkJq3IhtG
        oYuK3d3EuelCl4Z6fur2PPwDBypblQ75ttTyFy2tz/++0EhIc/MdwV+mFeWo34It
        spIyrCMI8vf+WNg2a5B9ZRyJ03AUxJA3eSSli7zgeZ/P2LKQiyg4HDXHaFMq7t2o
        rSH76My3iKLSm8Sfm8BmqWr9+aW35w/37IdV6MmU9ozVbMuOeM+Q+vjnjHDl9whT
        HRDL5Qf6zgTdaxIboKiqSwVLiwu84nHcpPpiGWmAc9vI2PHlqgHhfge0bdjrwXwQ
        ==
X-ME-Sender: <xms:KJZ3XA7chSQi1viF3tQ1HhtqSzWqdXuJpYvjHVs5Zm97oxRIc0GxSQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedutddrvddvgdduudduucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvffukfhfgggtuggjfgesthdtredttdervdenucfhrhhomhepifhrvghg
    ucfmjfcuoehgrhgvgheskhhrohgrhhdrtghomheqnecukfhppeekfedrkeeirdekledrud
    dtjeenucfrrghrrghmpehmrghilhhfrhhomhepghhrvghgsehkrhhorghhrdgtohhmnecu
    vehluhhsthgvrhfuihiivgeptd
X-ME-Proxy: <xmx:KZZ3XL-49dBa5239c4epTQaO-sKapslf8BLHzldkJPvz2QpyHjs9DA>
    <xmx:KZZ3XOhe6xJ0WfpspKqr5oIW91gX__XAlGo8Gv12YVIf26INtnGa_Q>
    <xmx:KZZ3XNRLx-iXj1E-c9XnsF7BoXkaIjUI0GM4EwGL9_S_AeApRlPe6w>
    <xmx:KpZ3XFPzNK0mh80o1Cri_jvx5Pn2MTWZf2l9oQMMD3TgS-zbT4Zz9w>
Received: from localhost (5356596b.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        by mail.messagingengine.com (Postfix) with ESMTPA id 6E173E4546;
        Thu, 28 Feb 2019 03:04:56 -0500 (EST)
Date:   Thu, 28 Feb 2019 09:04:54 +0100
From:   Greg KH <greg@kroah.com>
To:     Mao Wenan <maowenan@huawei.com>
Cc:     Larry.Finger@lwfinger.net, florian.c.schilhabel@googlemail.com,
        straube.linux@gmail.com, kernel-janitors@vger.kernel.org,
        devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] staging: rtl8712: assign initial value to a static
 variable in r8712_efuse_pg_packet_write()
Message-ID: <20190228080454.GA8210@kroah.com>
References: <20190227033322.127177-1-maowenan@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190227033322.127177-1-maowenan@huawei.com>
User-Agent: Mutt/1.11.3 (2019-02-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 27, 2019 at 11:33:22AM +0800, Mao Wenan wrote:
> repeat_times is a static variable, but each time when it enters
> r8712_efuse_pg_packet_write(), it is set to zero,
> this value is not consistent with last calling, so next behavior
> is not our expect.
> 
> Signed-off-by: Mao Wenan <maowenan@huawei.com>
> ---
>  drivers/staging/rtl8712/rtl8712_efuse.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
> 
> diff --git a/drivers/staging/rtl8712/rtl8712_efuse.c b/drivers/staging/rtl8712/rtl8712_efuse.c
> index 8bc45ffd3029..3e8421255170 100644
> --- a/drivers/staging/rtl8712/rtl8712_efuse.c
> +++ b/drivers/staging/rtl8712/rtl8712_efuse.c
> @@ -358,7 +358,7 @@ u8 r8712_efuse_pg_packet_write(struct _adapter *padapter, const u8 offset,
>  	u8 pg_header = 0;
>  	u16 efuse_addr = 0, curr_size = 0;
>  	u8 efuse_data, target_word_cnts = 0;
> -	static int repeat_times;
> +	static int repeat_times = 0;
>  	int sub_repeat;
>  	u8 bResult = true;
>  
> @@ -368,7 +368,6 @@ u8 r8712_efuse_pg_packet_write(struct _adapter *padapter, const u8 offset,
>  		return false;
>  	pg_header = MAKE_EFUSE_HEADER(offset, word_en);
>  	target_word_cnts = calculate_word_cnts(word_en);
> -	repeat_times = 0;
>  	efuse_addr = 0;
>  	while (efuse_addr < efuse_available_max_size) {
>  		curr_size = r8712_efuse_get_current_size(padapter);

This patch does not apply to my tree at all.

And are you sure this is correct?

greg k-h
