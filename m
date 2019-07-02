Return-Path: <SRS0=JAXG=U7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.5 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C1F8AC5B57D
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Jul 2019 06:33:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8E1C220881
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Jul 2019 06:33:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fQfcYMrC"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726105AbfGBGd3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Jul 2019 02:33:29 -0400
Received: from mail-ed1-f66.google.com ([209.85.208.66]:33435 "EHLO
        mail-ed1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725775AbfGBGd2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Jul 2019 02:33:28 -0400
Received: by mail-ed1-f66.google.com with SMTP id i11so26198650edq.0
        for <linux-kernel@vger.kernel.org>; Mon, 01 Jul 2019 23:33:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=vrhZMISchd7sGxny8Pn79m9lKufOLYxEQC7IHi63Z/c=;
        b=fQfcYMrC6VDwfZ9himAq9txAiRt6kNpb0+/EE6ct41lHlo8f5zjugS4PFSWqnl9tUm
         lTCLyoVfGYV2GUaBgln6FPNi6hjKpAP1W28dy7GaZKscLCpR8hDeDTndl3FK/mo1HL8E
         K7qsXVyOfrdow4xPaXeeNpzHkwd8AQR1UdtP0UJiBRZzEZbvVYlsvDephgwmGBgZUL3d
         Yay3g1AD9P4RVpSXUU0k8Vj6MxwRgmKrJv8HEdP6i3voxtYqUpAEWSP9VGpR3PYAWQDA
         EFbjJLUTowIX/yzL6w8NJg1cwQ2Aiz9FsRy4nqCzcmJYXf1TXYSL2maRKv3iiYJkWhPv
         IoCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=vrhZMISchd7sGxny8Pn79m9lKufOLYxEQC7IHi63Z/c=;
        b=ubigT/1zL9Whbbe+/nSVeaJf2UIU3q1U1f44ePGaH0XO4iXbJJydOZtiIDMIq05Zzh
         dGS4zlmJultku2jZOd43OriTx5ZCLrhONByax2Inc+4fNS7Rzi0rwft/wFXw57C42Tvw
         b2ZKob3dzuRgfXxCu9vS7GStogk/l1gckJPMxU7jxaF2Ypv1D12RXuTOUCgwXydp5vNg
         ceoveP1MwpjyIZ34gs81AIv7uZzvwjYH5Pzx94vDfqJIbn+arZLr7klKNJCLFGnBCLkR
         ySUPL3fs2BzQ2e5SDhplQKuFxkcZRRvX3qdt+pDQXxPozvdl0WP0D5AgpJ3XIepa7GLy
         S1Jg==
X-Gm-Message-State: APjAAAXs6OKPUt3nJXT9s6sVZamTMNjvKcMz9j7QU9/v3VGg4cxYYCCr
        6YnVoK8TPKR/jYTARhdWkUnFkxFAuLQ=
X-Google-Smtp-Source: APXvYqw9f0FqKoC6XDyCJtiRq5TNEDPexmu5lcp1MfQ+SKaZfvxyiRrHv/3vuVP+F+PUzPfxfL7Xuw==
X-Received: by 2002:a05:6402:8c3:: with SMTP id d3mr25619075edz.183.1562049206767;
        Mon, 01 Jul 2019 23:33:26 -0700 (PDT)
Received: from archlinux-epyc ([2a01:4f9:2b:2b15::2])
        by smtp.gmail.com with ESMTPSA id z22sm4365499edz.6.2019.07.01.23.33.25
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Mon, 01 Jul 2019 23:33:25 -0700 (PDT)
Date:   Mon, 1 Jul 2019 23:33:23 -0700
From:   Nathan Chancellor <natechancellor@gmail.com>
To:     Joel Stanley <joel@jms.id.au>
Cc:     Jeremy Kerr <jk@ozlabs.org>,
        Alistar Popple <alistair@popple.id.au>,
        Eddie James <eajames@linux.ibm.com>,
        linux-fsi@lists.ozlabs.org, linux-kernel@vger.kernel.org,
        openbmc@lists.ozlabs.org
Subject: Re: [PATCH] MAINTAINERS: Add FSI subsystem
Message-ID: <20190702063323.GA53677@archlinux-epyc>
References: <20190702043706.15069-1-joel@jms.id.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190702043706.15069-1-joel@jms.id.au>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Joel,

On Tue, Jul 02, 2019 at 02:07:05PM +0930, Joel Stanley wrote:
> The subsystem was merged some time ago but we did not have a maintainers
> entry.
> 
> Signed-off-by: Joel Stanley <joel@jms.id.au>
> ---
>  MAINTAINERS | 13 +++++++++++++
>  1 file changed, 13 insertions(+)
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 01a52fc964da..2a5df9c20ecb 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -6498,6 +6498,19 @@ F:	fs/crypto/
>  F:	include/linux/fscrypt*.h
>  F:	Documentation/filesystems/fscrypt.rst
>  
> +FSI SUBSYSTEM
> +M:	Jeremy Kerr <jk@ozlabs.org>
> +M:	Joel Stanley <joel@jms.id.au>
> +R:	Alistar Popple <alistair@popple.id.au>
> +R:	Eddie James <eajames@linux.ibm.com>
> +L:	linux-fsi@lists.ozlabs.org
> +T:	git git://git.kernel.org/pub/scm/joel/fsi.git

Just a drive by review, this link does not work, seems it should be:

git://git.kernel.org/pub/scm/linux/kernel/git/joel/fsi.git

Cheers,
Nathan

> +Q:	http://patchwork.ozlabs.org/project/linux-fsi/list/
> +S:	Supported
> +F:	drivers/fsi/
> +F:	include/linux/fsi*.h
> +F:	include/trace/events/fsi*.h
> +
>  FSI-ATTACHED I2C DRIVER
>  M:	Eddie James <eajames@linux.ibm.com>
>  L:	linux-i2c@vger.kernel.org
> -- 
> 2.20.1
> 
