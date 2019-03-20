Return-Path: <SRS0=4Jrr=RX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F2FAFC43381
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Mar 2019 07:20:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BFA7B2184E
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Mar 2019 07:20:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1553066404;
	bh=2R86JuAXmJSN2vrRSyP9wfLMx8KdM8WmaZexVVPDbOY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=NDt5c7l4Q0ZDNQNGCzqPytx15R+uiLTYjIxdfrAeqElWlgRcg75d/LEa8GCtPVfEw
	 wLhnk5eOxBH5jk9w2ZxD2Fpke3tFsPDDymbP1xGIA3LqSaOp1DA3mZlKB0ShHwHjfH
	 wBwHJ1n64bL/1KbcqU7m1vS1pcEx7p/xBxNOPq8k=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727359AbfCTHUD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Mar 2019 03:20:03 -0400
Received: from mail.kernel.org ([198.145.29.99]:53026 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727008AbfCTHUC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Mar 2019 03:20:02 -0400
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8AF2421841;
        Wed, 20 Mar 2019 07:20:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1553066402;
        bh=2R86JuAXmJSN2vrRSyP9wfLMx8KdM8WmaZexVVPDbOY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=0i2ISWq5s5ZYQA9xNo5/hdn14lVvmIuqPT+GvvuLaBzgje/pqYhrDIYo236dcXkpp
         5x90U5SlngwPOkmk+qGHX5urrBAgdKgBs7nWyIRgjj7GLZP+hQ+untqhwtAIsnaNBl
         OhOK0lo8UUfhu98J1mEFM/3PD+LfGWFdjDZEyOec=
Date:   Wed, 20 Mar 2019 08:19:58 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     George Hilliard <thirtythreeforty@gmail.com>
Cc:     linux-mips@linux-mips.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 03/11] staging: mt7621-mmc: Fix warning when reloading
 module with debug msgs enabled
Message-ID: <20190320071958.GA1914@kroah.com>
References: <20190319022012.11051-1-thirtythreeforty@gmail.com>
 <20190319022012.11051-4-thirtythreeforty@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190319022012.11051-4-thirtythreeforty@gmail.com>
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 18, 2019 at 08:20:04PM -0600, George Hilliard wrote:
> The kernel complained:
> 
>     [  510.277151] WARNING: CPU: 0 PID: 395 at fs/proc/generic.c:360 proc_register+0xf0/0x108
>     [  510.292891] proc_dir_entry '/proc/msdc_debug' already registered
> 
> when doing a modprobe/rmmod/modprobe of this module if debug messages
> are compiled in.  Fix this by removing the proc entry when the module is
> unloaded.
> 
> Signed-off-by: George Hilliard <thirtythreeforty@gmail.com>
> ---
>  drivers/staging/mt7621-mmc/dbg.c | 15 ++++++++++++---
>  drivers/staging/mt7621-mmc/dbg.h |  3 ++-
>  drivers/staging/mt7621-mmc/sd.c  |  4 ++++
>  3 files changed, 18 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/staging/mt7621-mmc/dbg.c b/drivers/staging/mt7621-mmc/dbg.c
> index fda3ba38ba37..2310f3bcc16e 100644
> --- a/drivers/staging/mt7621-mmc/dbg.c
> +++ b/drivers/staging/mt7621-mmc/dbg.c
> @@ -294,9 +294,18 @@ static const struct file_operations msdc_debug_fops = {
>  	.release	= single_release,
>  };
>  
> -void msdc_debug_proc_init(void)
> +// Keep ahold of the proc entry we create so it can be freed during
> +// module removal
> +struct proc_dir_entry *msdc_debug_proc_entry;
> +
> +void __init msdc_debug_proc_init(void)
>  {
> -	proc_create("msdc_debug", 0660, NULL, &msdc_debug_fops);
> +	msdc_debug_proc_entry = proc_create("msdc_debug", 0660,
> +					    NULL, &msdc_debug_fops);
> +}
> +
> +void __exit msdc_debug_proc_deinit(void)
> +{
> +	proc_remove(msdc_debug_proc_entry);
>  }
> -EXPORT_SYMBOL_GPL(msdc_debug_proc_init);
>  #endif
> diff --git a/drivers/staging/mt7621-mmc/dbg.h b/drivers/staging/mt7621-mmc/dbg.h
> index 2d447b2d92ae..d100324aa3fe 100644
> --- a/drivers/staging/mt7621-mmc/dbg.h
> +++ b/drivers/staging/mt7621-mmc/dbg.h
> @@ -93,7 +93,8 @@ enum msdc_dbg {
>  
>  extern unsigned int sd_debug_zone[4];
>  #define TAG "msdc"
> -void msdc_debug_proc_init(void);
> +void __init msdc_debug_proc_init(void);
> +void __exit msdc_debug_proc_deinit(void);
>  
>  u32 msdc_time_calc(u32 old_L32, u32 old_H32, u32 new_L32, u32 new_H32);
>  void msdc_performance(u32 opcode, u32 sizes, u32 bRx, u32 ticks);
> diff --git a/drivers/staging/mt7621-mmc/sd.c b/drivers/staging/mt7621-mmc/sd.c
> index 9074848a8251..306b3b46f7c9 100644
> --- a/drivers/staging/mt7621-mmc/sd.c
> +++ b/drivers/staging/mt7621-mmc/sd.c
> @@ -1841,6 +1841,10 @@ static int __init mt_msdc_init(void)
>  
>  static void __exit mt_msdc_exit(void)
>  {
> +#if defined(MT6575_SD_DEBUG)
> +	msdc_debug_proc_deinit();
> +#endif

You shouldn't need a #ifdef in .c code.  In the .h file provide an
"empty" function for this if the option is not defined.  Then you can
just call this function in the .c file no matter what.

thanks,

greg k-h
