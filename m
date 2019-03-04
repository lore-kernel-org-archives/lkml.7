Return-Path: <SRS0=91bA=RH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C6B2CC43381
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Mar 2019 14:47:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9ED1020815
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Mar 2019 14:47:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726949AbfCDOrq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 4 Mar 2019 09:47:46 -0500
Received: from mga01.intel.com ([192.55.52.88]:32215 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726261AbfCDOrq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Mar 2019 09:47:46 -0500
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga101.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 04 Mar 2019 06:47:45 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.58,440,1544515200"; 
   d="scan'208";a="304248956"
Received: from romley-ivt3.sc.intel.com ([172.25.110.60])
  by orsmga005.jf.intel.com with ESMTP; 04 Mar 2019 06:47:44 -0800
Date:   Mon, 4 Mar 2019 06:40:50 -0800
From:   Fenghua Yu <fenghua.yu@intel.com>
To:     Paolo Bonzini <pbonzini@redhat.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
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
Message-ID: <20190304144050.GA230561@romley-ivt3.sc.intel.com>
References: <1551494711-213533-1-git-send-email-fenghua.yu@intel.com>
 <1551494711-213533-4-git-send-email-fenghua.yu@intel.com>
 <20190304101141.GB32477@hirez.programming.kicks-ass.net>
 <44bb6771-7aea-c44d-6605-45e7a1499d1b@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <44bb6771-7aea-c44d-6605-45e7a1499d1b@redhat.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 04, 2019 at 11:46:52AM +0100, Paolo Bonzini wrote:
> On 04/03/19 11:11, Peter Zijlstra wrote:
> > On Fri, Mar 01, 2019 at 06:44:57PM -0800, Fenghua Yu wrote:
> >> A bit in reg_ch_conf_pending in wl271 and tmp_ch_bitmap is set 
> >> atomically by set_bit(). set_bit() sets the bit in a single 
> >> unsigned long location. If the variables are not aligned to 
> >> unsigned long, set_bit() accesses two cache lines and thus causes 
> >> slower performance. On x86, this scenario is called split lock and 
> >> can cause overall performance degradation due to locked BTSL 
> >> instruction in set_bit() locks bus.
> >> 
> >> To avoid performance degradation, the two variables are aligned to
> >>  unsigned long.
> >> 
> >> Signed-off-by: Fenghua Yu <fenghua.yu@intel.com> --- 
> >> drivers/net/wireless/ti/wlcore/cmd.c    | 3 ++- 
> >> drivers/net/wireless/ti/wlcore/wlcore.h | 6 ++++-- 2 files
> >> changed, 6 insertions(+), 3 deletions(-)
> >> 
> >> diff --git a/drivers/net/wireless/ti/wlcore/cmd.c 
> >> b/drivers/net/wireless/ti/wlcore/cmd.c index 
> >> 903968735a74..8d15a6307d44 100644 --- 
> >> a/drivers/net/wireless/ti/wlcore/cmd.c +++ 
> >> b/drivers/net/wireless/ti/wlcore/cmd.c @@ -1707,7 +1707,8 @@ int 
> >> wlcore_cmd_regdomain_config_locked(struct wl1271 *wl) { struct 
> >> wl12xx_cmd_regdomain_dfs_config *cmd = NULL; int ret = 0, i, b, 
> >> ch_bit_idx; -	u32 tmp_ch_bitmap[2]; +	/* Align to unsigned long
> >> for better performance in set_bit() */ +	u32 tmp_ch_bitmap[2] 
> >> __aligned(sizeof(unsigned long));
> 
> This is the only place where an array of u32 is needed, because of
> 
>         cmd->ch_bit_map1 = cpu_to_le32(tmp_ch_bitmap[0]);
>         cmd->ch_bit_map2 = cpu_to_le32(tmp_ch_bitmap[1]);
> 
> All the others should use DECLARE_BITMAP, including reg_ch_conf_last 
> which was already using __aligned.  As Peter mentioned they should
> also use set_bit_le.  Actually they do not need locked access at all
> because the only code paths to the set_bit take a mutex.
> 
> There is one other place that is accessing the items of the array, but
> it is fixed easily.  The following patch should do everything:
> 
> ------------------- 8< --------------------------
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

Now __aligned() is unnecessary because __set_bit_le() handles tmp_ch_bitmap,
right?

>  	struct wiphy *wiphy = wl->hw->wiphy;
>  	struct ieee80211_supported_band *band;
>  	bool timeout = false;
> @@ -1717,7 +1717,7 @@ int wlcore_cmd_regdomain_config_locked(struct wl1271 *wl)
>  
>  	wl1271_debug(DEBUG_CMD, "cmd reg domain config");
>  
> -	memset(tmp_ch_bitmap, 0, sizeof(tmp_ch_bitmap));
> +	memcpy(tmp_ch_bitmap, wl->reg_ch_conf_pending, sizeof(tmp_ch_bitmap));
>  
>  	for (b = NL80211_BAND_2GHZ; b <= NL80211_BAND_5GHZ; b++) {
>  		band = wiphy->bands[b];
> @@ -1738,13 +1738,10 @@ int wlcore_cmd_regdomain_config_locked(struct wl1271 *wl)
>  			if (ch_bit_idx < 0)
>  				continue;
>  
> -			set_bit(ch_bit_idx, (long *)tmp_ch_bitmap);
> +			__set_bit_le(ch_bit_idx, (long *)tmp_ch_bitmap);

Is __test_and_set_bit_le() more meaningful to avoid duplicate bit setting ?

>  		}
>  	}
>  
> -	tmp_ch_bitmap[0] |= wl->reg_ch_conf_pending[0];
> -	tmp_ch_bitmap[1] |= wl->reg_ch_conf_pending[1];
> -
>  	if (!memcmp(tmp_ch_bitmap, wl->reg_ch_conf_last, sizeof(tmp_ch_bitmap)))
>  		goto out;
>  
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
>  	/* Reg domain pending configuration */
> -	u32 reg_ch_conf_pending[2];
> +	DECLARE_BITMAP(reg_ch_conf_pending, 64);
>  
>  	/* Pointer that holds DMA-friendly block for the mailbox */
>  	void *mbox;
