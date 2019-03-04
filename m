Return-Path: <SRS0=91bA=RH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AFF3EC43381
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Mar 2019 13:09:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7D3572075B
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Mar 2019 13:09:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726671AbfCDNJh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 4 Mar 2019 08:09:37 -0500
Received: from mx1.redhat.com ([209.132.183.28]:45928 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726094AbfCDNJh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Mar 2019 08:09:37 -0500
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 2D2BB83F4C;
        Mon,  4 Mar 2019 13:09:36 +0000 (UTC)
Received: from [10.36.112.48] (ovpn-112-48.ams2.redhat.com [10.36.112.48])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 3F99B5D71D;
        Mon,  4 Mar 2019 13:09:31 +0000 (UTC)
Subject: Re: [PATCH v4 03/17] wlcore: Align reg_ch_conf_pending and
 tmp_ch_bitmap to unsigned long for better performance
To:     Peter Zijlstra <peterz@infradead.org>
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
References: <1551494711-213533-1-git-send-email-fenghua.yu@intel.com>
 <1551494711-213533-4-git-send-email-fenghua.yu@intel.com>
 <20190304101141.GB32477@hirez.programming.kicks-ass.net>
 <44bb6771-7aea-c44d-6605-45e7a1499d1b@redhat.com>
 <20190304124144.GD32477@hirez.programming.kicks-ass.net>
From:   Paolo Bonzini <pbonzini@redhat.com>
Openpgp: preference=signencrypt
Autocrypt: addr=pbonzini@redhat.com; prefer-encrypt=mutual; keydata=
 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
 uUHgL9dKIfvpm+rNXRn9wAwGjk0X/A==
Message-ID: <9f334d1e-491f-565e-02fc-1a769e4f1b79@redhat.com>
Date:   Mon, 4 Mar 2019 14:09:30 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <20190304124144.GD32477@hirez.programming.kicks-ass.net>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.27]); Mon, 04 Mar 2019 13:09:36 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 04/03/19 13:41, Peter Zijlstra wrote:
> On Mon, Mar 04, 2019 at 11:46:52AM +0100, Paolo Bonzini wrote:
>> From: Paolo Bonzini <pbonzini@redhat.com>
>> Subject: [PATCH] wlcore: simplify/fix/optimize reg_ch_conf_pending operations
>>
>> Bitmaps are defined on unsigned longs, so the usage of u32[2] in the
>> wlcore driver is incorrect.  As noted by Peter Zijlstra, casting arrays
>> to a bitmap is incorrect for big-endian architectures.
>>
>> When looking at it I observed that:
>>
>> - operations on reg_ch_conf_pending is always under the wl_lock mutex,
>> so set_bit is overkill
>>
>> - the only case where reg_ch_conf_pending is accessed a u32 at a time is
>> unnecessary too.
>>
>> This patch cleans up everything in this area, and changes tmp_ch_bitmap
>> to have the proper alignment.
>>
>> Reported-by: Fenghua Yu <fenghua.yu@intel.com>
>> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
>>
>> diff --git a/drivers/net/wireless/ti/wlcore/cmd.c b/drivers/net/wireless/ti/wlcore/cmd.c
>> index 903968735a74..3e093f3a7ec8 100644
>> --- a/drivers/net/wireless/ti/wlcore/cmd.c
>> +++ b/drivers/net/wireless/ti/wlcore/cmd.c
>> @@ -1700,14 +1700,14 @@ void wlcore_set_pending_regdomain_ch(struct wl1271 *wl, u16 channel,
>>  	ch_bit_idx = wlcore_get_reg_conf_ch_idx(band, channel);
>>  
>>  	if (ch_bit_idx >= 0 && ch_bit_idx <= WL1271_MAX_CHANNELS)
>> -		set_bit(ch_bit_idx, (long *)wl->reg_ch_conf_pending);
>> +		__set_bit_le(ch_bit_idx, (long *)wl->reg_ch_conf_pending);
>>  }
>>  
>>  int wlcore_cmd_regdomain_config_locked(struct wl1271 *wl)
>>  {
>>  	struct wl12xx_cmd_regdomain_dfs_config *cmd = NULL;
>>  	int ret = 0, i, b, ch_bit_idx;
>> -	u32 tmp_ch_bitmap[2];
>> +	u32 tmp_ch_bitmap[2] __aligned(sizeof(unsigned long));
> 
> Also mark it as __le32 ?

That would require more changes to mark ch_bit_map1/ch_bit_map2 as
__le32 (I think, I don't do much sparse), so I didn't do that.

>>  	struct wiphy *wiphy = wl->hw->wiphy;
>>  	struct ieee80211_supported_band *band;
>>  	bool timeout = false;
>> @@ -1717,7 +1717,7 @@ int wlcore_cmd_regdomain_config_locked(struct wl1271 *wl)
>>  
>>  	wl1271_debug(DEBUG_CMD, "cmd reg domain config");
>>  
>> -	memset(tmp_ch_bitmap, 0, sizeof(tmp_ch_bitmap));
>> +	memcpy(tmp_ch_bitmap, wl->reg_ch_conf_pending, sizeof(tmp_ch_bitmap));
> 
> How about using:
> 
> 	bitmap_to_arr32(tmp_ch_bitmap, wl->reg_ch_conf_pending, sizeof(tmp_ch_bitmap));
> 	for (i=0; i<2; i++)
> 		tmp_ch_bitmap[i] = cpu_to_le32(tmp_ch_bitmap[i]);
> 
> (or add bitmap_to_arr32_le ?)

I've used __set_bit_le when setting reg_ch_conf_pending so no need to
swizzle here; OTOH bitmap_to_arr32 doesn't work here that swizzle
already swaps halfwords.

>>  	for (b = NL80211_BAND_2GHZ; b <= NL80211_BAND_5GHZ; b++) {
>>  		band = wiphy->bands[b];
>> @@ -1738,13 +1738,10 @@ int wlcore_cmd_regdomain_config_locked(struct wl1271 *wl)
>>  			if (ch_bit_idx < 0)
>>  				continue;
>>  
>> -			set_bit(ch_bit_idx, (long *)tmp_ch_bitmap);
>> +			__set_bit_le(ch_bit_idx, (long *)tmp_ch_bitmap);
> 
> But you copied in reg_ch_conf_pending without doing an LE swizzle.
> With the proposed change, we have two __le32 here and it works again.

(Again there's no need to do an LE swizzle because it's done in
wlcore_set_pending_regdomain_ch).

>>  		}
>>  	}
>>  
>> -	tmp_ch_bitmap[0] |= wl->reg_ch_conf_pending[0];
>> -	tmp_ch_bitmap[1] |= wl->reg_ch_conf_pending[1];
>> -
>>  	if (!memcmp(tmp_ch_bitmap, wl->reg_ch_conf_last, sizeof(tmp_ch_bitmap)))
>>  		goto out;
>>  
> 
> And then remove the cpu_to_le32() on assignment to ch_bit_map*.

Yup, I forgot to commit that cpu_to_le32 removal.

>> diff --git a/drivers/net/wireless/ti/wlcore/wlcore.h b/drivers/net/wireless/ti/wlcore/wlcore.h
>> index dd14850b0603..870eea3e7a27 100644
>> --- a/drivers/net/wireless/ti/wlcore/wlcore.h
>> +++ b/drivers/net/wireless/ti/wlcore/wlcore.h
>> @@ -320,9 +320,9 @@ struct wl1271 {
>>  	bool watchdog_recovery;
>>  
>>  	/* Reg domain last configuration */
>> -	u32 reg_ch_conf_last[2]  __aligned(8);
>> +	DECLARE_BITMAP(reg_ch_conf_last, 64);
> 
> Is never actually used as a bitmap but used as opaque storage with
> memcpy and memcmp against tmp_ch_bitmap.

Yeah, but it is the easiest way to ensure it is the right size as
reg_ch_conf_pending.  The two are related, it makes sense to declare
them the same.

Paolo
