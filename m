Return-Path: <SRS0=fSNO=YI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 212BDECE588
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Oct 2019 11:29:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 00A7921928
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Oct 2019 11:29:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727520AbfJOL3P (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 15 Oct 2019 07:29:15 -0400
Received: from mail3-relais-sop.national.inria.fr ([192.134.164.104]:27113
        "EHLO mail3-relais-sop.national.inria.fr" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726430AbfJOL3O (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Oct 2019 07:29:14 -0400
X-IronPort-AV: E=Sophos;i="5.67,299,1566856800"; 
   d="scan'208";a="322762634"
Received: from portablejulia.rsr.lip6.fr ([132.227.76.63])
  by mail3-relais-sop.national.inria.fr with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 15 Oct 2019 13:29:12 +0200
Date:   Tue, 15 Oct 2019 13:29:12 +0200 (CEST)
From:   Julia Lawall <julia.lawall@lip6.fr>
X-X-Sender: julia@hadrien
To:     Wambui Karuga <wambui.karugax@gmail.com>
cc:     outreachy-kernel@googlegroups.com, gregkh@linuxfoundation.org,
        devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org
Subject: Re: [Outreachy kernel] [PATCH] staging: rtl8723bs: remove casts to
 pointers in kfree
In-Reply-To: <20191015112637.20824-1-wambui.karugax@gmail.com>
Message-ID: <alpine.DEB.2.21.1910151328500.2818@hadrien>
References: <20191015112637.20824-1-wambui.karugax@gmail.com>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On Tue, 15 Oct 2019, Wambui Karuga wrote:

> Remove unnecessary casts in pointer types passed to kfree.
>
> Signed-off-by: Wambui Karuga <wambui.karugax@gmail.com>

Acked-by: Julia Lawall <julia.lawall@lip6.fr>

> ---
>  drivers/staging/rtl8723bs/core/rtw_mlme.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/staging/rtl8723bs/core/rtw_mlme.c b/drivers/staging/rtl8723bs/core/rtw_mlme.c
> index 3030ae5b6b6d..71fcb466019a 100644
> --- a/drivers/staging/rtl8723bs/core/rtw_mlme.c
> +++ b/drivers/staging/rtl8723bs/core/rtw_mlme.c
> @@ -2155,7 +2155,7 @@ sint rtw_set_auth(struct adapter *adapter, struct security_priv *psecuritypriv)
>
>  	psetauthparm = rtw_zmalloc(sizeof(struct setauth_parm));
>  	if (!psetauthparm) {
> -		kfree((unsigned char *)pcmd);
> +		kfree(pcmd);
>  		res = _FAIL;
>  		goto exit;
>  	}
> @@ -2238,7 +2238,7 @@ sint rtw_set_key(struct adapter *adapter, struct security_priv *psecuritypriv, s
>  	if (enqueue) {
>  		pcmd = rtw_zmalloc(sizeof(struct cmd_obj));
>  		if (!pcmd) {
> -			kfree((unsigned char *)psetkeyparm);
> +			kfree(psetkeyparm);
>  			res = _FAIL;  /* try again */
>  			goto exit;
>  		}
> --
> 2.23.0
>
> --
> You received this message because you are subscribed to the Google Groups "outreachy-kernel" group.
> To unsubscribe from this group and stop receiving emails from it, send an email to outreachy-kernel+unsubscribe@googlegroups.com.
> To view this discussion on the web visit https://groups.google.com/d/msgid/outreachy-kernel/20191015112637.20824-1-wambui.karugax%40gmail.com.
>
