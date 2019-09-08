Return-Path: <SRS0=sd1o=XD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4DA69C4332F
	for <linux-kernel@archiver.kernel.org>; Sun,  8 Sep 2019 16:40:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1B2B7218AC
	for <linux-kernel@archiver.kernel.org>; Sun,  8 Sep 2019 16:40:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1567960847;
	bh=bduxlRgncCtH3hgLHIejYjY8raG/27q0wSfHeokzmIo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=Tj23bv/j+8lF//DYNaXlIrl/9HetV53FBn1yE2rMOclNLeP00RrFdZBtsMg1T9H9A
	 5/QyUea1h6rxy6Yc9aVTIzBVHTDLHMlH/y3T6er+r/hb1ZNdK84MpBZcz67OhxqEQG
	 yNt1C0xBJ6W1aIE1bbIh6atDjl+bQTlc17am9Pfc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729782AbfIHQkq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 8 Sep 2019 12:40:46 -0400
Received: from mail.kernel.org ([198.145.29.99]:52674 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729739AbfIHQkp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 8 Sep 2019 12:40:45 -0400
Received: from localhost (unknown [62.28.240.114])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1E2FF216C8;
        Sun,  8 Sep 2019 16:40:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1567960843;
        bh=bduxlRgncCtH3hgLHIejYjY8raG/27q0wSfHeokzmIo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=OxCUenmIjPZFRc/qXl24QboLCTj6xfk/P6Nonl5k5Kw1nzUZIXl/iRpdYQAPsntFV
         pKqWr28SoNQop/QBnqiA5y9k0IK/MbxOoWlkX2aUpCA+K4iHzWeASAPi3ZdjAOb5No
         uoEy/ILzUHAMjJV2m45hFaOYyBiGV/gRZqMuXqbk=
Date:   Sun, 8 Sep 2019 17:40:40 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Valentin Vidic <vvidic@valentin-vidic.from.hr>
Cc:     devel@driverdev.osuosl.org,
        Valdis Kletnieks <valdis.kletnieks@vt.edu>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 3/3] staging: exfat: add millisecond support
Message-ID: <20190908164040.GA8362@kroah.com>
References: <20190908161015.26000-1-vvidic@valentin-vidic.from.hr>
 <20190908161015.26000-3-vvidic@valentin-vidic.from.hr>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190908161015.26000-3-vvidic@valentin-vidic.from.hr>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Sep 08, 2019 at 04:10:15PM +0000, Valentin Vidic wrote:
> Use create_time_ms modify_time_ms fields to store the millisecond
> part of the file timestamp with the precision of 10 ms.
> 
> Signed-off-by: Valentin Vidic <vvidic@valentin-vidic.from.hr>
> ---
>  drivers/staging/exfat/exfat_core.c | 30 ++++++++++++++++++++++++++++++
>  1 file changed, 30 insertions(+)
> 
> diff --git a/drivers/staging/exfat/exfat_core.c b/drivers/staging/exfat/exfat_core.c
> index 8476eeedba83..e87119fa8c0a 100644
> --- a/drivers/staging/exfat/exfat_core.c
> +++ b/drivers/staging/exfat/exfat_core.c
> @@ -1139,6 +1139,7 @@ void exfat_set_entry_size(struct dentry_t *p_entry, u64 size)
>  void fat_get_entry_time(struct dentry_t *p_entry, struct timestamp_t *tp,
>  			u8 mode)
>  {
> +	u8 ms = 0;
>  	u16 t = 0x00, d = 0x21;
>  	struct dos_dentry_t *ep = (struct dos_dentry_t *)p_entry;
>  
> @@ -1146,6 +1147,7 @@ void fat_get_entry_time(struct dentry_t *p_entry, struct timestamp_t *tp,
>  	case TM_CREATE:
>  		t = GET16_A(ep->create_time);
>  		d = GET16_A(ep->create_date);
> +		ms = ep->create_time_ms * 10;
>  		break;
>  	case TM_MODIFY:
>  		t = GET16_A(ep->modify_time);
> @@ -1159,11 +1161,17 @@ void fat_get_entry_time(struct dentry_t *p_entry, struct timestamp_t *tp,
>  	tp->day  = (d & 0x001F);
>  	tp->mon  = (d >> 5) & 0x000F;
>  	tp->year = (d >> 9);
> +
> +	if (ms >= 1000) {
> +		ms -= 1000;
> +		tp->sec++;
> +	}
>  }
>  
>  void exfat_get_entry_time(struct dentry_t *p_entry, struct timestamp_t *tp,
>  			  u8 mode)
>  {
> +	u8 ms = 0;
>  	u16 t = 0x00, d = 0x21;
>  	struct file_dentry_t *ep = (struct file_dentry_t *)p_entry;
>  
> @@ -1171,10 +1179,12 @@ void exfat_get_entry_time(struct dentry_t *p_entry, struct timestamp_t *tp,
>  	case TM_CREATE:
>  		t = GET16_A(ep->create_time);
>  		d = GET16_A(ep->create_date);
> +		ms = ep->create_time_ms * 10;
>  		break;
>  	case TM_MODIFY:
>  		t = GET16_A(ep->modify_time);
>  		d = GET16_A(ep->modify_date);
> +		ms = ep->modify_time_ms * 10;
>  		break;
>  	case TM_ACCESS:
>  		t = GET16_A(ep->access_time);
> @@ -1188,21 +1198,33 @@ void exfat_get_entry_time(struct dentry_t *p_entry, struct timestamp_t *tp,
>  	tp->day  = (d & 0x001F);
>  	tp->mon  = (d >> 5) & 0x000F;
>  	tp->year = (d >> 9);
> +
> +	if (ms >= 1000) {
> +		ms -= 1000;
> +		tp->sec++;
> +	}
>  }
>  
>  void fat_set_entry_time(struct dentry_t *p_entry, struct timestamp_t *tp,
>  			u8 mode)
>  {
> +	u8 ms;
>  	u16 t, d;
>  	struct dos_dentry_t *ep = (struct dos_dentry_t *)p_entry;
>  
>  	t = (tp->hour << 11) | (tp->min << 5) | (tp->sec >> 1);
>  	d = (tp->year <<  9) | (tp->mon << 5) |  tp->day;
>  
> +	ms = tp->millisec;
> +	if (tp->sec & 1) {
> +		ms += 1000;
> +	}

checkpatch didn't complain about this { } not being needed?

Same in other parts of this patch, please fix up.

thanks,

greg k-h
