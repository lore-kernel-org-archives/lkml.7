Return-Path: <SRS0=91bA=RH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8DDABC43381
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Mar 2019 10:11:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5C8B321019
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Mar 2019 10:11:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="AVvyYWoR"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726118AbfCDKLu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 4 Mar 2019 05:11:50 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:51482 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726029AbfCDKLt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Mar 2019 05:11:49 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=GnlNTXzWNcsYGkrROUWKstGiSe8R6kfVZq8nFhziDsg=; b=AVvyYWoRt+SetRYPmMIJZM6Ps
        mlXGa8EbwMAuMG3IPoXVG+VC5zYYlIeKFR+19wIUohEZjV2Z8JfYObmoMW95CXiR/tqWpLN+mcG9T
        QVZe3qdkzocmZbw0SJ+H0PHPprYjaVwQMWdf8DkLTtG2vC5nLoUpDFRDXfv4pFoqvvDIDkHDmJW0t
        zMEvblwM3r/qmHGmxGCl8CBt2gh4dMygENUlV0b7Voahmn+anCANdQXr41hR90WLHxPOPF/nuYrfM
        gzBxzDnbhmNJgplVHupzMn+oxfg7jw+Wrvdv3HcFh34LQRi8kfcIknQqHzacQq6p5GO9LSSVbobzC
        cgn4xP7EQ==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1h0kZU-0006ft-9r; Mon, 04 Mar 2019 10:11:44 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 9728920295AAE; Mon,  4 Mar 2019 11:11:41 +0100 (CET)
Date:   Mon, 4 Mar 2019 11:11:41 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Fenghua Yu <fenghua.yu@intel.com>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        H Peter Anvin <hpa@zytor.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Dave Hansen <dave.hansen@intel.com>,
        Ashok Raj <ashok.raj@intel.com>,
        Ravi V Shankar <ravi.v.shankar@intel.com>,
        Xiaoyao Li <xiaoyao.li@intel.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        x86 <x86@kernel.org>, kvm@vger.kernel.org
Subject: Re: [PATCH v4 03/17] wlcore: Align reg_ch_conf_pending and
 tmp_ch_bitmap to unsigned long for better performance
Message-ID: <20190304101141.GB32477@hirez.programming.kicks-ass.net>
References: <1551494711-213533-1-git-send-email-fenghua.yu@intel.com>
 <1551494711-213533-4-git-send-email-fenghua.yu@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1551494711-213533-4-git-send-email-fenghua.yu@intel.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 01, 2019 at 06:44:57PM -0800, Fenghua Yu wrote:
> A bit in reg_ch_conf_pending in wl271 and tmp_ch_bitmap is set atomically
> by set_bit(). set_bit() sets the bit in a single unsigned long location. If
> the variables are not aligned to unsigned long, set_bit() accesses two
> cache lines and thus causes slower performance. On x86, this scenario is
> called split lock and can cause overall performance degradation due to
> locked BTSL instruction in set_bit() locks bus.
> 
> To avoid performance degradation, the two variables are aligned to
> unsigned long.
> 
> Signed-off-by: Fenghua Yu <fenghua.yu@intel.com>
> ---
>  drivers/net/wireless/ti/wlcore/cmd.c    | 3 ++-
>  drivers/net/wireless/ti/wlcore/wlcore.h | 6 ++++--
>  2 files changed, 6 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/net/wireless/ti/wlcore/cmd.c b/drivers/net/wireless/ti/wlcore/cmd.c
> index 903968735a74..8d15a6307d44 100644
> --- a/drivers/net/wireless/ti/wlcore/cmd.c
> +++ b/drivers/net/wireless/ti/wlcore/cmd.c
> @@ -1707,7 +1707,8 @@ int wlcore_cmd_regdomain_config_locked(struct wl1271 *wl)
>  {
>  	struct wl12xx_cmd_regdomain_dfs_config *cmd = NULL;
>  	int ret = 0, i, b, ch_bit_idx;
> -	u32 tmp_ch_bitmap[2];
> +	/* Align to unsigned long for better performance in set_bit() */
> +	u32 tmp_ch_bitmap[2] __aligned(sizeof(unsigned long));
>  	struct wiphy *wiphy = wl->hw->wiphy;
>  	struct ieee80211_supported_band *band;
>  	bool timeout = false;
> diff --git a/drivers/net/wireless/ti/wlcore/wlcore.h b/drivers/net/wireless/ti/wlcore/wlcore.h
> index dd14850b0603..92d878f01fa5 100644
> --- a/drivers/net/wireless/ti/wlcore/wlcore.h
> +++ b/drivers/net/wireless/ti/wlcore/wlcore.h
> @@ -321,8 +321,10 @@ struct wl1271 {
>  
>  	/* Reg domain last configuration */
>  	u32 reg_ch_conf_last[2]  __aligned(8);
> -	/* Reg domain pending configuration */
> -	u32 reg_ch_conf_pending[2];
> +	/* Reg domain pending configuration. Aligned to unsigned long for
> +	 * better performane in set_bit().
> +	 */
> +	u32 reg_ch_conf_pending[2] __aligned(sizeof(unsigned long));
>  
>  	/* Pointer that holds DMA-friendly block for the mailbox */
>  	void *mbox;

This has nothing to do with better performance. This is generic code,
not x86 arch code. Many RISC platforms will already refuse unaligned
atomic ops.

Also, how is this set_bit() usage endian safe?

And no wireless person on Cc anywhere.
