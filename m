Return-Path: <SRS0=K9bG=V2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5FBF4C7618E
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jul 2019 19:51:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 300B221655
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jul 2019 19:51:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ragnatech-se.20150623.gappssmtp.com header.i=@ragnatech-se.20150623.gappssmtp.com header.b="kQ7u2Z5D"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2403876AbfG2Tvj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 29 Jul 2019 15:51:39 -0400
Received: from mail-lj1-f194.google.com ([209.85.208.194]:40420 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390587AbfG2Tvg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Jul 2019 15:51:36 -0400
Received: by mail-lj1-f194.google.com with SMTP id m8so26160688lji.7
        for <linux-kernel@vger.kernel.org>; Mon, 29 Jul 2019 12:51:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ragnatech-se.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=El7Ib0jTQtxwv9EQk3d/9hKJrGZteddjh0+HIjhP2fo=;
        b=kQ7u2Z5De3ynsZA4y1P68rxHq30RnVHHlC09c4hOT6vJoDwyIv6DSwaSTbaVAM92Pv
         1TahDbRIHgs/SWIeE6HzY6g9xHQ51ZQ5zZYicb15lxBgunoQ/egqY4zSsFVzcZvsJ9z6
         /jkH3fkKht0WAtOabiND7dhBWBZLBAmy/ckrfV3RVnvJEODoamQy182/Y1NfIbPyZbd/
         1ZUE+uEJRDrgK63qsJzjL0eMxk9Gtdfdtrp+7Ny0zciaIr0gjghMGsvkVFZhTqlbo46e
         jnp85j0bXEkkyE7GICxMVSEZitxSjBtcaBUblR9nc6GmO5npRlHqhqNnxh44LsNKm9OO
         VePA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=El7Ib0jTQtxwv9EQk3d/9hKJrGZteddjh0+HIjhP2fo=;
        b=kARBh3RWHzVVrcKJnnYXfIeWro8MyuJVGawQRnTnarFxdrUm9v4bRAtk2QZ41muYeJ
         vPr4DNf99BVEnS56KEjY3lepv0qCHAfu6XjSteHbunCa5UJ+7lKzFKye66qCTOnG+uqu
         /YSDaytI6Ny9c03GrlL+EpqM6qCblBThsxYA8Aj0lAQS/4t4aaaDA0z4YyISvudQ8UPH
         HLga87IbkOOxaOWHpcpViNHfuiBldCSpmlEMp/+3nmpGkgoGmR3pK6PPjIJdrugxhFw0
         cQR13p9sYjshuKY77QEE6RJIOzJCtJgaBs7ojbLiClx0FvMD5IValzLwyrwtb+Ue6Bf4
         JCxw==
X-Gm-Message-State: APjAAAWpG21fF7u/lD/hVor4Bb5z5RUQ6UA+yztxXLoXrbCads7YyaqR
        Q3p8exTlT95YQttw20GTgopg7YzG
X-Google-Smtp-Source: APXvYqwmerTp9GT9ypUFcw81F3w6Ua2ebUM6nBiNjoQILyLAd8+1+ULuFfpyzKPNNcwa9HX4Oh8pTw==
X-Received: by 2002:a2e:9048:: with SMTP id n8mr12228496ljg.37.1564429895116;
        Mon, 29 Jul 2019 12:51:35 -0700 (PDT)
Received: from localhost (customer-145-14-112-32.stosn.net. [145.14.112.32])
        by smtp.gmail.com with ESMTPSA id y12sm12077703lfy.36.2019.07.29.12.51.34
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Mon, 29 Jul 2019 12:51:34 -0700 (PDT)
Date:   Mon, 29 Jul 2019 21:51:34 +0200
From:   Niklas =?iso-8859-1?Q?S=F6derlund?= 
        <niklas.soderlund@ragnatech.se>
To:     Geert Uytterhoeven <geert+renesas@glider.be>,
        Simon Horman <horms@verge.net.au>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Magnus Damm <magnus.damm@gmail.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Kevin Hilman <khilman@kernel.org>,
        Olof Johansson <olof@lixom.net>,
        linux-renesas-soc@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] MAINTAINERS: Add Geert as Renesas SoC Co-Maintainer
Message-ID: <20190729195134.GF3186@bigcity.dyn.berto.se>
References: <20190729175658.13672-1-geert+renesas@glider.be>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20190729175658.13672-1-geert+renesas@glider.be>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Geert, Simon,

On 2019-07-29 19:56:58 +0200, Geert Uytterhoeven wrote:
> At the end of the v5.3 upstream kernel development cycle, Simon will be
> stepping down from his role as Renesas SoC maintainer.  Starting with
> the v5.4 development cycle, Geert is taking over this role.

I would like to thank Simon for his good humor and support in all my 
interactions with him as a maintainer. And wish Geert the best of luck 
picking up the baton, not that you need it I know you will be just as 
fun to work with.

> 
> Add Geert as a co-maintainer, and add his git repository and branch.
> 
> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>

Reviewed-by: Niklas Söderlund <niklas.soderlund+renesas@ragnatech.se>

> ---
> Stephen: Can you please add my branch to linux-next, after Simon's
> 	 branch, which may still receive fixes for v5.3?
> 
> 	 Thanks!
> ---
>  MAINTAINERS | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 6426db5198f05377..6de667021591fb52 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -2155,10 +2155,12 @@ F:	Documentation/devicetree/bindings/arm/realtek.txt
>  
>  ARM/RENESAS ARM64 ARCHITECTURE
>  M:	Simon Horman <horms@verge.net.au>
> +M:	Geert Uytterhoeven <geert+renesas@glider.be>
>  M:	Magnus Damm <magnus.damm@gmail.com>
>  L:	linux-renesas-soc@vger.kernel.org
>  Q:	http://patchwork.kernel.org/project/linux-renesas-soc/list/
>  T:	git git://git.kernel.org/pub/scm/linux/kernel/git/horms/renesas.git next
> +T:	git git://git.kernel.org/pub/scm/linux/kernel/git/geert/renesas-devel.git next
>  S:	Supported
>  F:	arch/arm64/boot/dts/renesas/
>  F:	Documentation/devicetree/bindings/arm/renesas.yaml
> @@ -2269,10 +2271,12 @@ F:	drivers/media/platform/s5p-mfc/
>  
>  ARM/SHMOBILE ARM ARCHITECTURE
>  M:	Simon Horman <horms@verge.net.au>
> +M:	Geert Uytterhoeven <geert+renesas@glider.be>
>  M:	Magnus Damm <magnus.damm@gmail.com>
>  L:	linux-renesas-soc@vger.kernel.org
>  Q:	http://patchwork.kernel.org/project/linux-renesas-soc/list/
>  T:	git git://git.kernel.org/pub/scm/linux/kernel/git/horms/renesas.git next
> +T:	git git://git.kernel.org/pub/scm/linux/kernel/git/geert/renesas-devel.git next
>  S:	Supported
>  F:	arch/arm/boot/dts/emev2*
>  F:	arch/arm/boot/dts/gr-peach*
> -- 
> 2.17.1
> 

-- 
Regards,
Niklas Söderlund
