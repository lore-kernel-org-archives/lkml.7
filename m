Return-Path: <SRS0=4Jrr=RX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A6C7FC43381
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Mar 2019 19:21:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7B34A21841
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Mar 2019 19:21:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="HiUqBcYT";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="YJuQKBUc"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726465AbfCTTVd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Mar 2019 15:21:33 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:34996 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726681AbfCTTVc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Mar 2019 15:21:32 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id B904B60E73; Wed, 20 Mar 2019 19:21:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1553109691;
        bh=+2l973189PQlhjIYHo1woP/hpgZQIV4Yuzpxe3Y4NH0=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=HiUqBcYTGo9W55aTFe8J26iNibj/8FGu9hmB2yUqzGXGbMxC/I1u1C1qvA15SrCzW
         E6UO5C7gGm/sXxEIm6D0tr6RDu7o3nl5pwKo0MW+UMR/MnA6BCbPJ3ymzOd6OAcDZs
         6E208OwqBkAARhNfwA3Eat0bsFNP8/vXAljQvTro=
Received: from [10.79.162.149] (blr-bdr-fw-01_globalnat_allzones-outside.qualcomm.com [103.229.18.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: mojha@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 1F30560240;
        Wed, 20 Mar 2019 19:21:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1553109690;
        bh=+2l973189PQlhjIYHo1woP/hpgZQIV4Yuzpxe3Y4NH0=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=YJuQKBUcO08Dw1TRzND4Z8M+aFERUbtMAETneuxb2b+Z2jE0iiVw26o4KLOXZudGl
         ky02Lye+JMCPlBxprY7JZvgzWEI3Hf3ava4n7y0XfUTMRqHsaJ4QsmUI+qsvZTc0nO
         O5YHIX64PHfLAAaTTJPPf3+Bj/aMSVx6VlPRz238=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 1F30560240
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=mojha@codeaurora.org
Subject: Re: [PATCH v3] staging: rtlwifi: Fix potential NULL pointer
 dereference of kzalloc
To:     Aditya Pakki <pakki001@umn.edu>
Cc:     kjlu@umn.edu, Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Nathan Chancellor <natechancellor@gmail.com>,
        devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org
References: <20190320154234.29242-1-pakki001@umn.edu>
From:   Mukesh Ojha <mojha@codeaurora.org>
Message-ID: <b21893ef-6326-fef0-9e3f-60627d58b12d@codeaurora.org>
Date:   Thu, 21 Mar 2019 00:51:17 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <20190320154234.29242-1-pakki001@umn.edu>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 3/20/2019 9:12 PM, Aditya Pakki wrote:
> phydm.internal is allocated using kzalloc which is used multiple
> times without a check for NULL pointer. This patch avoids such a
> scenario by returning 0, consistent with the failure case.
>
> Signed-off-by: Aditya Pakki <pakki001@umn.edu>
>
> ---
> v2: Move the signed off line above
> v1: Patch collision with different things, fix as per Greg
> ---
>   drivers/staging/rtlwifi/phydm/rtl_phydm.c | 2 ++
>   1 file changed, 2 insertions(+)
>
> diff --git a/drivers/staging/rtlwifi/phydm/rtl_phydm.c b/drivers/staging/rtlwifi/phydm/rtl_phydm.c
> index 9930ed954abb..4cc77b2016e1 100644
> --- a/drivers/staging/rtlwifi/phydm/rtl_phydm.c
> +++ b/drivers/staging/rtlwifi/phydm/rtl_phydm.c
> @@ -180,6 +180,8 @@ static int rtl_phydm_init_priv(struct rtl_priv *rtlpriv,
>   
>   	rtlpriv->phydm.internal =
>   		kzalloc(sizeof(struct phy_dm_struct), GFP_KERNEL);
> +	if (!rtlpriv->phydm.internal)
> +		return 0;
>   
>   	_rtl_phydm_init_com_info(rtlpriv, ic, params);
>   



Reviewed-by:  Mukesh Ojha <mojha@codeaurora.org>

Thanks,
Mukesh


