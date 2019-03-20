Return-Path: <SRS0=4Jrr=RX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AA1B5C43381
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Mar 2019 20:29:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 78EEF2190C
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Mar 2019 20:29:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="KGZy8MFa";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="im6uCycF"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727276AbfCTU3D (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Mar 2019 16:29:03 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:42966 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726686AbfCTU3C (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Mar 2019 16:29:02 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 3DFF960907; Wed, 20 Mar 2019 20:29:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1553113741;
        bh=HSAsGMK4zIf5wsNnIfiL39gqU97qYyfNfw2h3KZVNO4=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=KGZy8MFaDI1KTLbyy9LBS+mgt5JT4joA3jz5fe0VBe9iWaX0t35bFUPmdaSebly2O
         VazKjnm2fXptdVYV4wQ6Bg1Je/41sgxs8b8m+i7VCC5Fuu9OSRvIJfKWyZGjk3NzhV
         i3BI2LYwfTKqcfZyGWO/WzXchGresteQSAQjsT9E=
Received: from [10.79.162.149] (blr-bdr-fw-01_globalnat_allzones-outside.qualcomm.com [103.229.18.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: mojha@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id E05596053D;
        Wed, 20 Mar 2019 20:28:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1553113740;
        bh=HSAsGMK4zIf5wsNnIfiL39gqU97qYyfNfw2h3KZVNO4=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=im6uCycF8lIchyayrYttDxxsxWfVQ5jrq4yOGOG3yVzmLKhwWqSOEKWf/+yZX7wSS
         aJWwG0LpiIg+Mowkb0xCLPtd3POBj7VAkvwAyiRA3lVBioinFzT6YtJgKoNCaLMjfd
         sl/dSdREl5ZyhXbeOz19C69p5/s2ngu6hiUR5R0g=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org E05596053D
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=mojha@codeaurora.org
Subject: Re: [PATCH v3] staging: rtlwifi: rtl8822b: fix to avoid NULL pointer
 dereference
To:     Aditya Pakki <pakki001@umn.edu>
Cc:     kjlu@umn.edu, Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Sabin Mihai Rapan <sabin.rapan@gmail.com>,
        Nathan Chancellor <natechancellor@gmail.com>,
        devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org
References: <20190320170251.31838-1-pakki001@umn.edu>
From:   Mukesh Ojha <mojha@codeaurora.org>
Message-ID: <1d27e981-1407-3498-03a5-926abec634f3@codeaurora.org>
Date:   Thu, 21 Mar 2019 01:58:49 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <20190320170251.31838-1-pakki001@umn.edu>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 3/20/2019 10:32 PM, Aditya Pakki wrote:
> skb allocated via dev_alloc_skb can fail and return a NULL pointer.
> This patch avoids such a scenario and returns, consistent with other
> invocations.
>
> Signed-off-by: Aditya Pakki <pakki001@umn.edu>
>
> ---
> v2: Move signed off above the version change log
> v1: Patch collision with rtl_phydm.c, fix as per Greg
> ---
>   drivers/staging/rtlwifi/rtl8822be/fw.c | 2 ++
>   1 file changed, 2 insertions(+)
>
> diff --git a/drivers/staging/rtlwifi/rtl8822be/fw.c b/drivers/staging/rtlwifi/rtl8822be/fw.c
> index f061dd1382aa..cf6b7a80b753 100644
> --- a/drivers/staging/rtlwifi/rtl8822be/fw.c
> +++ b/drivers/staging/rtlwifi/rtl8822be/fw.c
> @@ -743,6 +743,8 @@ void rtl8822be_set_fw_rsvdpagepkt(struct ieee80211_hw *hw, bool b_dl_finished)
>   		      u1_rsvd_page_loc, 3);
>   
>   	skb = dev_alloc_skb(totalpacketlen);
> +	if (!skb)
> +		return;
>   	memcpy((u8 *)skb_put(skb, totalpacketlen), &reserved_page_packet,
>   	       totalpacketlen);
>   


Reviewed-by: Mukesh Ojha <mojha@codeaurora.org>

