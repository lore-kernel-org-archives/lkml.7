Return-Path: <SRS0=sd1o=XD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D0D4BC433EF
	for <linux-kernel@archiver.kernel.org>; Sun,  8 Sep 2019 18:54:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A7C8B218AE
	for <linux-kernel@archiver.kernel.org>; Sun,  8 Sep 2019 18:54:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1567968868;
	bh=DEx3zEV1wNAa4sPvnHsY6/koGtXOQEQ6IqoLIjDkOko=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=IDosUhV7+WyNn4Ewa1yj8ZtAeZUKWoKoZlXP2IS4xbEOerP+uo8oIQjt64mab054L
	 K4QR8a36K9cyBl3eDZBMnNGCFnpLNoqtP3jZzxRvTKUG/nyXkVQ0oAptKH6l5gtbJh
	 iR6+vl3OEr1V89iVlTWxXkr0bIeS6HbGD35eX5eA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730912AbfIHSy1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 8 Sep 2019 14:54:27 -0400
Received: from mail.kernel.org ([198.145.29.99]:60648 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729973AbfIHSy1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 8 Sep 2019 14:54:27 -0400
Received: from localhost (unknown [62.28.240.114])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 21209216C8;
        Sun,  8 Sep 2019 18:54:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1567968866;
        bh=DEx3zEV1wNAa4sPvnHsY6/koGtXOQEQ6IqoLIjDkOko=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=LK2NTfAIENfNRPbT53b1fur5Ave3EAWfFyGzSoaoirdS6FyE+J9a3Rqn+FAm/YpsH
         QusnNG+qY52CPOva5zQPiV1pPiAU6vwnS8UdbIerJXsIduzok4bZ590IBbVxZ72TuQ
         zKQfv6YmLQerkgipwheZRV0Z15+QC9lPHeUs1bzY=
Date:   Sun, 8 Sep 2019 19:54:24 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Valentin Vidic <vvidic@valentin-vidic.from.hr>
Cc:     devel@driverdev.osuosl.org,
        Valdis Kletnieks <valdis.kletnieks@vt.edu>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 2/4] staging: exfat: drop duplicate date_time_t struct
Message-ID: <20190908185424.GB10011@kroah.com>
References: <20190908173539.26963-1-vvidic@valentin-vidic.from.hr>
 <20190908173539.26963-2-vvidic@valentin-vidic.from.hr>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190908173539.26963-2-vvidic@valentin-vidic.from.hr>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Sep 08, 2019 at 05:35:37PM +0000, Valentin Vidic wrote:
> Use timestamp_t for everything and cleanup duplicate code.
> 
> Signed-off-by: Valentin Vidic <vvidic@valentin-vidic.from.hr>
> ---
>  drivers/staging/exfat/exfat.h       |  35 +++---
>  drivers/staging/exfat/exfat_super.c | 158 ++++++++--------------------
>  2 files changed, 55 insertions(+), 138 deletions(-)
> 
> diff --git a/drivers/staging/exfat/exfat.h b/drivers/staging/exfat/exfat.h
> index 0aa14dea4e09..58e1e889779f 100644
> --- a/drivers/staging/exfat/exfat.h
> +++ b/drivers/staging/exfat/exfat.h
> @@ -241,16 +241,6 @@ static inline u16 get_row_index(u16 i)
>  #define UNI_PAR_DIR_NAME        "\0.\0."
>  #endif
>  
> -struct date_time_t {
> -	u16      Year;
> -	u16      Month;
> -	u16      Day;
> -	u16      Hour;
> -	u16      Minute;
> -	u16      Second;
> -	u16      MilliSecond;
> -};
> -
>  struct part_info_t {
>  	u32      Offset;    /* start sector number of the partition */
>  	u32      Size;      /* in sectors */
> @@ -289,6 +279,16 @@ struct file_id_t {
>  	u32      hint_last_clu;
>  };
>  
> +struct timestamp_t {
> +	u16      millisec;   /* 0 ~ 999              */

You added this field to this structure, why?  You did not document that
in the changelog text above.  Are you _sure_ you can do this and that
this does not refer to an on-disk layout?

thanks,

greg k-h
