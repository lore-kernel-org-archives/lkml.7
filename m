Return-Path: <SRS0=WRlz=SV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D68DAC282DA
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Apr 2019 18:29:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9808720449
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Apr 2019 18:29:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1555698559;
	bh=303gAaiUE5R3dQExfBtJ8EvjoHzMdyHL08HUoe5pGYI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=VDeyruIVHv0W2Mvjd3Mekty6q/cJR/0VQULSJ9MVYvwZhhj+RK1Dg6V3klvLqKGmK
	 voxeSY5XHU8r02dvJna+BT7ffYgrrMx0Be3jliPTqxIjf8hF5NEO8fVaNy8grEc/7L
	 hoOK49h5VBVyclqK1z6+08iDfK1FjP1qz+nP+Jso=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727959AbfDSS3T (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 19 Apr 2019 14:29:19 -0400
Received: from mail.kernel.org ([198.145.29.99]:53876 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727451AbfDSS3P (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Apr 2019 14:29:15 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1A0D621916;
        Fri, 19 Apr 2019 11:22:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1555672954;
        bh=303gAaiUE5R3dQExfBtJ8EvjoHzMdyHL08HUoe5pGYI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=wiiwK0fqLTiovDFf5PLdIh8oAXSLyYDnld7XmaxyXJdTcRR0dicVqs+SJhihV0OBE
         pmfOgs6QWzXHQ8KL7CpKJjXeygyBW/l+5bPlLT7ey+XnV+BbSyi9wIdGl+6ylZZjg2
         KNW6TvhPpuZBo/8RWF87e8FujHsMlRAd7FUGOJ8M=
Date:   Fri, 19 Apr 2019 13:22:32 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Bhanusree Pola <bhanusreemahesh@gmail.com>
Cc:     devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Staging: rtl8723bs: core: Replace rtw_malloc with kmalloc
Message-ID: <20190419112232.GB14886@kroah.com>
References: <1555669363-19782-1-git-send-email-bhanusreemahesh@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1555669363-19782-1-git-send-email-bhanusreemahesh@gmail.com>
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 19, 2019 at 03:52:43PM +0530, Bhanusree Pola wrote:
> Replace rtw_malloc with kmalloc to make code OS independent
> use kmalloc second argument as GFP_ATOMIC as these are called by functions
> that holds lock.
> 
> Signed-off-by: Bhanusree Pola <bhanusreemahesh@gmail.com>
> ---
>  drivers/staging/rtl8723bs/core/rtw_ap.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/staging/rtl8723bs/core/rtw_ap.c b/drivers/staging/rtl8723bs/core/rtw_ap.c
> index 18fabf5..6a6683c 100644
> --- a/drivers/staging/rtl8723bs/core/rtw_ap.c
> +++ b/drivers/staging/rtl8723bs/core/rtw_ap.c
> @@ -128,7 +128,7 @@ static void update_BCNTIM(struct adapter *padapter)
>  		}
>  
>  		if (remainder_ielen > 0) {
> -			pbackup_remainder_ie = rtw_malloc(remainder_ielen);
> +			pbackup_remainder_ie = kmalloc(remainder_ielen,GFP_ATOMIC);

Always run checkpatch.pl on your patches so you do nto get grumpy
maintainers telling you to run checkpatch.pl on your code :)

Why not fix up all of the callers of this function?  And are you sure
that GFP_ATOMIC is the correct thing to do here?

thanks,

greg k-h
