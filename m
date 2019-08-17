Return-Path: <SRS0=F9vw=WN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 579CDC3A59B
	for <linux-kernel@archiver.kernel.org>; Sat, 17 Aug 2019 07:00:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1A77821744
	for <linux-kernel@archiver.kernel.org>; Sat, 17 Aug 2019 07:00:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1566025242;
	bh=OStIBI1ZJgY+MM6yqEMNY8tMtf83IPMpNpoDqAi3sZg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=N3aca8jCyErqOrd9AhjKhvi++jDsQ0z738cezWoOU//Q3cK/O2QA9Nk7QFLzvPnic
	 5hiLLkb4ByZkVwZK3jv7QsDOqSlnuwEZ2lmKbM4FY0ZtiWQdn+/hrbKCntuVkt3H/5
	 ERzj25t31NP7lpO71KolofmZaDgPcvMMLFeT2jVo=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726088AbfHQHAk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 17 Aug 2019 03:00:40 -0400
Received: from mail.kernel.org ([198.145.29.99]:50204 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725889AbfHQHAk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 17 Aug 2019 03:00:40 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 47B04205ED;
        Sat, 17 Aug 2019 07:00:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1566025239;
        bh=OStIBI1ZJgY+MM6yqEMNY8tMtf83IPMpNpoDqAi3sZg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=u63HIs2LdbriCOqVZmnjF64QGCCIhSoRqvi210Q8STnuSP+hBpSrfitluwAFEQyoS
         4U/FTTBEER9ewor79jzOF/IGIXIJ0l8ZgtehymEM4sztfl1utFG2sD+Y6ovRmgSozy
         01AUDiYQeiwXsCro1Gqmx8INhhkYcz9SoikVl6cE=
Date:   Sat, 17 Aug 2019 09:00:37 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Matthew Hanzelik <matthew.hanzelik@gmail.com>
Cc:     w.d.hubbs@gmail.com, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Staging: speakup: spk_types: fixed an unnamed parameter
 style issue
Message-ID: <20190817070037.GA14489@kroah.com>
References: <20190817065426.2090-1-matthew.hanzelik@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190817065426.2090-1-matthew.hanzelik@gmail.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Aug 17, 2019 at 02:54:26AM -0400, Matthew Hanzelik wrote:
> Fixed an unnamed parameter style issue.
> 
> Signed-off-by: Matthew Hanzelik <matthew.hanzelik@gmail.com>
> ---
>  drivers/staging/speakup/spk_types.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/staging/speakup/spk_types.h b/drivers/staging/speakup/spk_types.h
> index a2fc72c29894..afa64eb9afb4 100644
> --- a/drivers/staging/speakup/spk_types.h
> +++ b/drivers/staging/speakup/spk_types.h
> @@ -189,7 +189,7 @@ struct spk_synth {
>  	void (*flush)(struct spk_synth *synth);
>  	int (*is_alive)(struct spk_synth *synth);
>  	int (*synth_adjust)(struct st_var_header *var);
> -	void (*read_buff_add)(u_char);
> +	void (*read_buff_add)(u_char *add);

You just changed the function prototype from taking a single character,
to taking a pointer to a character, are you sure this is correct?

No other build warnings with this patch enabled?

thanks,

greg k-h
