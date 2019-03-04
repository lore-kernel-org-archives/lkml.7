Return-Path: <SRS0=91bA=RH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 29037C43381
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Mar 2019 12:42:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B98F820830
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Mar 2019 12:42:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="B29km6Np"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726567AbfCDMl7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 4 Mar 2019 07:41:59 -0500
Received: from merlin.infradead.org ([205.233.59.134]:43966 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726181AbfCDMl7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Mar 2019 07:41:59 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=mlAtjb/BpRzlbTczCYrs9gwKr+YvBuNFP5mfUazYSqo=; b=B29km6Np7863VXL6Iimoqw06i
        Zo8HkhjNNPYjGdz+UhHp+OCI3aBbnPtjQGNEYE2zKmRQUv8QeHjew6dc6okMpaJRa4eZATOOXuxQL
        ATjmoUqohC+TaH3+6ldziSW3/7TBG1k275H0fVlZv1fh4olRwn8N/C9+QiZ/6bWTZ5h4tF9BEex94
        e1fad7bcD/66lg+0wFHxa0wxq7iWx6T15Xou9+N8c8k+BqdjSvnyMbqhuF1ll4bjQgww6OYPUG3a6
        ysy1TNcDC6gWU9IFnILlUbOWU6hGwJdK/FkdnfmXg8JzaZnYk6k8zxkInM0nmkQdCgIWiKSxIV93i
        8T+ZtrFgw==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1h0mug-0004Lt-Md; Mon, 04 Mar 2019 12:41:47 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 35B2F20295395; Mon,  4 Mar 2019 13:41:44 +0100 (CET)
Date:   Mon, 4 Mar 2019 13:41:44 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Paolo Bonzini <pbonzini@redhat.com>
Cc:     Fenghua Yu <fenghua.yu@intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        H Peter Anvin <hpa@zytor.com>,
        Dave Hansen <dave.hansen@intel.com>,
        Ashok Raj <ashok.raj@intel.com>,
        Ravi V Shankar <ravi.v.shankar@intel.com>,
        Xiaoyao Li <xiaoyao.li@intel.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        x86 <x86@kernel.org>, kvm@vger.kernel.org
Subject: Re: [PATCH v4 03/17] wlcore: Align reg_ch_conf_pending and
 tmp_ch_bitmap to unsigned long for better performance
Message-ID: <20190304124144.GD32477@hirez.programming.kicks-ass.net>
References: <1551494711-213533-1-git-send-email-fenghua.yu@intel.com>
 <1551494711-213533-4-git-send-email-fenghua.yu@intel.com>
 <20190304101141.GB32477@hirez.programming.kicks-ass.net>
 <44bb6771-7aea-c44d-6605-45e7a1499d1b@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <44bb6771-7aea-c44d-6605-45e7a1499d1b@redhat.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 04, 2019 at 11:46:52AM +0100, Paolo Bonzini wrote:
> From: Paolo Bonzini <pbonzini@redhat.com>
> Subject: [PATCH] wlcore: simplify/fix/optimize reg_ch_conf_pending operations
> 
> Bitmaps are defined on unsigned longs, so the usage of u32[2] in the
> wlcore driver is incorrect.  As noted by Peter Zijlstra, casting arrays
> to a bitmap is incorrect for big-endian architectures.
> 
> When looking at it I observed that:
> 
> - operations on reg_ch_conf_pending is always under the wl_lock mutex,
> so set_bit is overkill
> 
> - the only case where reg_ch_conf_pending is accessed a u32 at a time is
> unnecessary too.
> 
> This patch cleans up everything in this area, and changes tmp_ch_bitmap
> to have the proper alignment.
> 
> Reported-by: Fenghua Yu <fenghua.yu@intel.com>
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> 
> diff --git a/drivers/net/wireless/ti/wlcore/cmd.c b/drivers/net/wireless/ti/wlcore/cmd.c
> index 903968735a74..3e093f3a7ec8 100644
> --- a/drivers/net/wireless/ti/wlcore/cmd.c
> +++ b/drivers/net/wireless/ti/wlcore/cmd.c
> @@ -1700,14 +1700,14 @@ void wlcore_set_pending_regdomain_ch(struct wl1271 *wl, u16 channel,
>  	ch_bit_idx = wlcore_get_reg_conf_ch_idx(band, channel);
>  
>  	if (ch_bit_idx >= 0 && ch_bit_idx <= WL1271_MAX_CHANNELS)
> -		set_bit(ch_bit_idx, (long *)wl->reg_ch_conf_pending);
> +		__set_bit_le(ch_bit_idx, (long *)wl->reg_ch_conf_pending);
>  }
>  
>  int wlcore_cmd_regdomain_config_locked(struct wl1271 *wl)
>  {
>  	struct wl12xx_cmd_regdomain_dfs_config *cmd = NULL;
>  	int ret = 0, i, b, ch_bit_idx;
> -	u32 tmp_ch_bitmap[2];
> +	u32 tmp_ch_bitmap[2] __aligned(sizeof(unsigned long));

Also mark it as __le32 ?

>  	struct wiphy *wiphy = wl->hw->wiphy;
>  	struct ieee80211_supported_band *band;
>  	bool timeout = false;
> @@ -1717,7 +1717,7 @@ int wlcore_cmd_regdomain_config_locked(struct wl1271 *wl)
>  
>  	wl1271_debug(DEBUG_CMD, "cmd reg domain config");
>  
> -	memset(tmp_ch_bitmap, 0, sizeof(tmp_ch_bitmap));
> +	memcpy(tmp_ch_bitmap, wl->reg_ch_conf_pending, sizeof(tmp_ch_bitmap));

How about using:

	bitmap_to_arr32(tmp_ch_bitmap, wl->reg_ch_conf_pending, sizeof(tmp_ch_bitmap));
	for (i=0; i<2; i++)
		tmp_ch_bitmap[i] = cpu_to_le32(tmp_ch_bitmap[i]);

(or add bitmap_to_arr32_le ?)

>  	for (b = NL80211_BAND_2GHZ; b <= NL80211_BAND_5GHZ; b++) {
>  		band = wiphy->bands[b];
> @@ -1738,13 +1738,10 @@ int wlcore_cmd_regdomain_config_locked(struct wl1271 *wl)
>  			if (ch_bit_idx < 0)
>  				continue;
>  
> -			set_bit(ch_bit_idx, (long *)tmp_ch_bitmap);
> +			__set_bit_le(ch_bit_idx, (long *)tmp_ch_bitmap);

But you copied in reg_ch_conf_pending without doing an LE swizzle.
With the proposed change, we have two __le32 here and it works again.

>  		}
>  	}
>  
> -	tmp_ch_bitmap[0] |= wl->reg_ch_conf_pending[0];
> -	tmp_ch_bitmap[1] |= wl->reg_ch_conf_pending[1];
> -
>  	if (!memcmp(tmp_ch_bitmap, wl->reg_ch_conf_last, sizeof(tmp_ch_bitmap)))
>  		goto out;
>  

And then remove the cpu_to_le32() on assignment to ch_bit_map*.

> diff --git a/drivers/net/wireless/ti/wlcore/wlcore.h b/drivers/net/wireless/ti/wlcore/wlcore.h
> index dd14850b0603..870eea3e7a27 100644
> --- a/drivers/net/wireless/ti/wlcore/wlcore.h
> +++ b/drivers/net/wireless/ti/wlcore/wlcore.h
> @@ -320,9 +320,9 @@ struct wl1271 {
>  	bool watchdog_recovery;
>  
>  	/* Reg domain last configuration */
> -	u32 reg_ch_conf_last[2]  __aligned(8);
> +	DECLARE_BITMAP(reg_ch_conf_last, 64);

Is never actually used as a bitmap but used as opaque storage with
memcpy and memcmp against tmp_ch_bitmap.

>  	/* Reg domain pending configuration */
> -	u32 reg_ch_conf_pending[2];
> +	DECLARE_BITMAP(reg_ch_conf_pending, 64);
>  
>  	/* Pointer that holds DMA-friendly block for the mailbox */
>  	void *mbox;
