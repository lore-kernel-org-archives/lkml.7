Return-Path: <SRS0=cgli=V4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BC8DAC433FF
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Jul 2019 12:44:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8A1A2208E3
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Jul 2019 12:44:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1564577082;
	bh=s/o85LgOgrz+NL81CJ0O41qg2AEbSHcUvLhO/JZzLjo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=uP2aaRW00+cZWdr0//Q73GmIh4582QtNxS11JztdFnbaEKl1gl8HgtJsuk5Vc41Q6
	 fwVhSDG1bI6nJ3CO+Un7IofQ5GLcDsRxCXkxNmJL3/jNnNY5oMXJKIZmvYRhcQThnp
	 6/Sw+dv2NHZk4MWw+1VuCNPB5CMeteQmuOsQxTWU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388097AbfGaMol (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 31 Jul 2019 08:44:41 -0400
Received: from mail.kernel.org ([198.145.29.99]:37142 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388086AbfGaMok (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Jul 2019 08:44:40 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4700C208E3;
        Wed, 31 Jul 2019 12:44:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1564577079;
        bh=s/o85LgOgrz+NL81CJ0O41qg2AEbSHcUvLhO/JZzLjo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=OCNuaykWq4Qyn47KFZbb8RTUM7JZX8qcznR5vKfGKuz7e2Mga/YPwSKC3zWuXWRGH
         4oRNc6uAT5Dq/Rqjs2hsvNQrrBmBNOMbg81C+ZdIt82pqwqXF/SanTTJU71LBFDhsc
         hkDzD+m3JyTdJ0wiaX3qAtGOzeCH1Pn1E82erwOA=
Date:   Wed, 31 Jul 2019 14:44:37 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Qian Cai <cai@lca.pw>
Cc:     mcgrof@kernel.org, issor.oruam@gmail.com, tiwai@suse.de,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] firmware: fix -Wunused-function compiler warnings
Message-ID: <20190731124437.GA4786@kroah.com>
References: <1563888722-24141-1-git-send-email-cai@lca.pw>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1563888722-24141-1-git-send-email-cai@lca.pw>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 23, 2019 at 09:32:02AM -0400, Qian Cai wrote:
> The commit 5342e7093ff2 ("firmware: Factor out the paged buffer handling
> code") introduced a few compilation warnings when
> CONFIG_FW_LOADER_USER_HELPER=n due to fw_grow_paged_buf() and
> fw_grow_paged_buf() are only used in
> drivers/base/firmware_loader/fallback.c, and the later will only be
> built if CONFIG_FW_LOADER_USER_HELPER=y.
> 
> In file included from drivers/base/firmware_loader/main.c:41:
> drivers/base/firmware_loader/firmware.h:145:12: warning:
> 'fw_map_paged_buf' defined but not used [-Wunused-function]
>  static int fw_map_paged_buf(struct fw_priv *fw_priv) { return -ENXIO; }
>             ^~~~~~~~~~~~~~~~
> drivers/base/firmware_loader/firmware.h:144:12: warning:
> 'fw_grow_paged_buf' defined but not used [-Wunused-function]
>  static int fw_grow_paged_buf(struct fw_priv *fw_priv, int pages_needed)
> { return -ENXIO; }
> 
> Fix it by removing those unused functions all together when
> CONFIG_FW_LOADER_USER_HELPER=n.
> 
> Fixes: 5342e7093ff2 ("firmware: Factor out the paged buffer handling code")
> Signed-off-by: Qian Cai <cai@lca.pw>
> ---
>  drivers/base/firmware_loader/firmware.h | 2 --
>  1 file changed, 2 deletions(-)
> 
> diff --git a/drivers/base/firmware_loader/firmware.h b/drivers/base/firmware_loader/firmware.h
> index 842e63f19f22..e74117bf8587 100644
> --- a/drivers/base/firmware_loader/firmware.h
> +++ b/drivers/base/firmware_loader/firmware.h
> @@ -141,8 +141,6 @@ int assign_fw(struct firmware *fw, struct device *device,
>  int fw_map_paged_buf(struct fw_priv *fw_priv);
>  #else
>  static inline void fw_free_paged_buf(struct fw_priv *fw_priv) {}
> -static int fw_grow_paged_buf(struct fw_priv *fw_priv, int pages_needed) { return -ENXIO; }
> -static int fw_map_paged_buf(struct fw_priv *fw_priv) { return -ENXIO; }
>  #endif
>  
>  #endif /* __FIRMWARE_LOADER_H */
> -- 
> 1.8.3.1
> 

Is this still needed with 5.3-rc2?  If so, please rebase and resend as
it does not apply to there.

thanks,

greg k-h
