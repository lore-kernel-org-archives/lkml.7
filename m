Return-Path: <SRS0=camR=ZD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 77637C17445
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Nov 2019 14:12:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4DEEB2196E
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Nov 2019 14:12:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1573481555;
	bh=amOAITn6Bln8gutQPmeHELe5goUXxy57gxcBhf7a1+Q=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=Om34Ck+UTKhspKgnt+/lnBov/+18KhNrr1KbpqrUP7tUlzUj2kzXGGVR70cf05nFb
	 QVowHMGEUdotch6JNb5u+/woRrU07kSWA2IUlgMUm/L+o/R/BClF9DRY478BFFkpC2
	 5gPbnMncNk0t1saFIgwr8IVzd6XhX3mbb9qARkPs=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727137AbfKKOMe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Nov 2019 09:12:34 -0500
Received: from mail.kernel.org ([198.145.29.99]:59970 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726912AbfKKOMd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Nov 2019 09:12:33 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9BCC02196E;
        Mon, 11 Nov 2019 14:12:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1573481553;
        bh=amOAITn6Bln8gutQPmeHELe5goUXxy57gxcBhf7a1+Q=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=JwdQbdv6t1N+4FDZ6MMmweNqwij+bP/74MMUVr0S3NeQeXl+Cp6B9e7dTzzPMkYuG
         j0cZ3aI1HxrGrQ0GbP5a6UAUsDG0XbCO1EDUXK4TZ4YkOy3iPf0fDGDv11GzYDDe9S
         LLPlW6VHQpgUn52VdMf/7GktFuiV/Ndl/7aIs1NE=
Date:   Mon, 11 Nov 2019 15:12:30 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Jules Irenge <jbi.octave@gmail.com>
Cc:     devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 3/3] staging: wfx: replace u32 by __le32
Message-ID: <20191111141230.GA585609@kroah.com>
References: <20191111133055.214410-1-jbi.octave@gmail.com>
 <20191111133055.214410-3-jbi.octave@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191111133055.214410-3-jbi.octave@gmail.com>
User-Agent: Mutt/1.12.2 (2019-09-21)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 11, 2019 at 01:30:55PM +0000, Jules Irenge wrote:
> Replace u32 by __le32 to fix warning of cast from restricted __le32.
> Issue detected by sparse tool.
> 
> Signed-off-by: Jules Irenge <jbi.octave@gmail.com>
> ---
> v1 uses casting to fix the warnings
> v2 replace the declaration type of the variables
> 
>  drivers/staging/wfx/hif_api_mib.h | 48 +++++++++++++++----------------
>  1 file changed, 24 insertions(+), 24 deletions(-)
> 
> diff --git a/drivers/staging/wfx/hif_api_mib.h b/drivers/staging/wfx/hif_api_mib.h
> index 94b789ceb4ff..e0a67410add2 100644
> --- a/drivers/staging/wfx/hif_api_mib.h
> +++ b/drivers/staging/wfx/hif_api_mib.h
> @@ -295,31 +295,31 @@ struct hif_mib_stats_table {
>  } __packed;
>  
>  struct hif_mib_extended_count_table {
> -	u32   count_plcp_errors;
> -	u32   count_fcs_errors;
> -	u32   count_tx_packets;
> -	u32   count_rx_packets;
> -	u32   count_rx_packet_errors;
> -	u32   count_rx_decryption_failures;
> -	u32   count_rx_mic_failures;
> -	u32   count_rx_no_key_failures;
> -	u32   count_tx_multicast_frames;
> -	u32   count_tx_frames_success;
> -	u32   count_tx_frame_failures;
> -	u32   count_tx_frames_retried;
> -	u32   count_tx_frames_multi_retried;
> -	u32   count_rx_frame_duplicates;
> -	u32   count_rts_success;
> -	u32   count_rts_failures;
> -	u32   count_ack_failures;
> -	u32   count_rx_multicast_frames;
> -	u32   count_rx_frames_success;
> -	u32   count_rx_cmacicv_errors;
> -	u32   count_rx_cmac_replays;
> -	u32   count_rx_mgmt_ccmp_replays;
> +	__le32   count_plcp_errors;
> +	__le32   count_fcs_errors;
> +	__le32   count_tx_packets;
> +	__le32   count_rx_packets;
> +	__le32   count_rx_packet_errors;
> +	__le32   count_rx_decryption_failures;
> +	__le32   count_rx_mic_failures;
> +	__le32   count_rx_no_key_failures;
> +	__le32   count_tx_multicast_frames;
> +	__le32   count_tx_frames_success;
> +	__le32   count_tx_frame_failures;
> +	__le32   count_tx_frames_retried;
> +	__le32   count_tx_frames_multi_retried;
> +	__le32   count_rx_frame_duplicates;
> +	__le32   count_rts_success;
> +	__le32   count_rts_failures;
> +	__le32   count_rx_multicast_frames;
> +	__le32   count_rx_cmacicv_errors;
> +	__le32   count_rx_cmac_replays;
> +	__le32   count_rx_mgmt_ccmp_replays;
> +	__le32   count_rx_beacon;
> +	__le32   count_miss_beacon;
> +	__le32   count_ack_failures;
> +	__le32   count_rx_frames_success;
>  	u32   count_rx_bipmic_errors;
> -	u32   count_rx_beacon;
> -	u32   count_miss_beacon;
>  	u32   reserved[15];
>  } __packed;

Is this structure coming from the hardware directly?  If so, you just
messed up the layout by moving things around, which will break the
driver :(

thanks,

greg k-h
