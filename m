Return-Path: <SRS0=KwB+=SC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9CD0FC43381
	for <linux-kernel@archiver.kernel.org>; Sun, 31 Mar 2019 18:54:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 668522085A
	for <linux-kernel@archiver.kernel.org>; Sun, 31 Mar 2019 18:54:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eGFh8QCz"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731408AbfCaSyd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 31 Mar 2019 14:54:33 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:43121 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731241AbfCaSyd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 31 Mar 2019 14:54:33 -0400
Received: by mail-wr1-f68.google.com with SMTP id k17so8997273wrx.10;
        Sun, 31 Mar 2019 11:54:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=k4zmjLa5pUtNjh7nU6esv0bdB+m+QC6+6cV1rXq5tkc=;
        b=eGFh8QCzBzeTwbhqC+Yc+HUjmbmauTvV/XPzqluXJAjjqSemvuBtC1gQJjmm9IhfuN
         BDo+mSio7+5Mxg2lCsaLxCHPPYAd9u2wqArT1GC9jh+HPgxFjzq9QD/Be5Vw7ck1h3uq
         JWoRBgZw/4HZm9R+qbgiC27x24yWjoAi+DPVp2xNiEKrrG8niskuct8hQDtPlYwZxEji
         cQ3zr4kghtbcpNoeUzpGt2I2YvxAzobEuNiEk5btAhqcUxViNJhqBy5X8EpZvXirKPCH
         zkGQ5BeVTDMjsiXFnzZHpScVtOuCo+0uldvw8KFZG9ImIdvyCY3gGbF1XbmrnqSk/9+R
         l3vA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=k4zmjLa5pUtNjh7nU6esv0bdB+m+QC6+6cV1rXq5tkc=;
        b=rgm/QZa4Kl4iPjCxmuRkuwpOwcEM0v/c1kKppKkMxUG/yab/wKolOKWyPCpmc2i/sf
         JlGF62Zoz9DsHGn8YnzLsiwaFA8gQdHDGP0c4RL2Rv0rJrvCcoO9BjVsz9v1AR6C++3W
         uB6rmq+XVFGieTBBfXGD6+pkFCWK69Rs02koVMhqui4fscfVUOVITSyAKFRPkh8NOsUZ
         6y9wgNzLOx8RmMR+Z9GCyjCwWryrEEdwbUWWGt2xiKTMRNcV6Fkx5QENpILPv83bk946
         CHS5v4VVzmm5Bf19saZzVG+P4qOBbjLmwJ3hPZnFaZnckqt/gJYvcswYwBUxiuwGLy62
         XfTg==
X-Gm-Message-State: APjAAAVWjUklmjb3uutQcIz7sF+ZIhwVKJzz5DLJz5FaFx2ZlrMbAN2U
        r+vgHZpyYVrVMJNuTZTxTOldeokhIlY=
X-Google-Smtp-Source: APXvYqz3/HF3hVfgLz1n+pTUyunsMelCLRz4C+auXNUpVOarkN8ckRpd3AMkrVHxe0EIzSpBoqYiVg==
X-Received: by 2002:adf:dc8e:: with SMTP id r14mr39423000wrj.118.1554058471368;
        Sun, 31 Mar 2019 11:54:31 -0700 (PDT)
Received: from debian (cpc101300-bagu16-2-0-cust362.1-3.cable.virginm.net. [86.21.41.107])
        by smtp.gmail.com with ESMTPSA id x14sm8757924wmj.3.2019.03.31.11.54.30
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 31 Mar 2019 11:54:30 -0700 (PDT)
Date:   Sun, 31 Mar 2019 19:54:28 +0100
From:   Sudip Mukherjee <sudipm.mukherjee@gmail.com>
To:     Yifeng Li <tomli@tomli.me>
Cc:     Teddy Wang <teddy.wang@siliconmotion.com>,
        linux-kernel@vger.kernel.org,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        linux-fbdev@vger.kernel.org, dri-devel@lists.freedesktop.org
Subject: Re: [PATCH v2 5/7] Documentation: fb: sm712fb: add information
 mainly about 2D.
Message-ID: <20190331185428.mpqbaq32cmm7izfv@debian>
References: <20190322051759.15007-1-tomli@tomli.me>
 <20190322051759.15007-6-tomli@tomli.me>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190322051759.15007-6-tomli@tomli.me>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 22, 2019 at 01:17:57PM +0800, Yifeng Li wrote:
> This commits add information about 32-bit color, 2D acceleration,
> as well as adding additional, general information about the hardware
> and many existing problems of the sm712fb driver.
> 
> Signed-off-by: Yifeng Li <tomli@tomli.me>
> ---
>  Documentation/fb/sm712fb.txt | 123 +++++++++++++++++++++++++++++++----
>  1 file changed, 110 insertions(+), 13 deletions(-)
> 
> diff --git a/Documentation/fb/sm712fb.txt b/Documentation/fb/sm712fb.txt
> index c388442edf51..906b48aa40e4 100644
> --- a/Documentation/fb/sm712fb.txt
> +++ b/Documentation/fb/sm712fb.txt
> @@ -1,31 +1,128 @@
>  What is sm712fb?
>  =================
>  
> -This is a graphics framebuffer driver for Silicon Motion SM712 based processors.
> +"sm712fb" is a graphics framebuffer driver for Silicon Motion SM710 (LynxEM),
> +SM712 (LynxEM+), and SM720 (Lynx3DM, Lynx3DM+, aka. LynxEM4+) series of
> +video controllers. This series of video controller is a legacy from ~1998,
> +and was used on many classic, "prehistoric" laptops from 1998-2004, such as
> +IBM Thinkpad S30 and 240X. It was also used on some servers, industrial
> +computers, x86 and non-x86 embedded devices where only basic graphics was
> +needed.

I think this is wrong. Loongson 3A Notebook was released around 2011-2012
and had SM712.

> +
> +Notably, Lemote YeeLoong 8089, a MIPS laptop based on the Chinese Loongson

<snip>

> +	* More VGA modes.
>  	* dual-head support
> +	* hardware cursor support
> +
> +The first feature is planned to be implemented soon, but the maintainer
> +does not receive any monetary or hardware support from any company or OEMs,
> +and he has to purchase a test platform personally. The 1998's hardware
> +still costs 200 USD+, so don't expected an ETA. If you have a Big-Endian
> +platform and willing to help testing, please contact the maintainer, thanks!

I am not sure why will you want to mention about monetary or hardware
support. Maintainers are supposed to work voluntarily.

> +
> +Other VGA modes, dual-head, or hardware cursor support should be possible to
> +implement, but parts of the code must be rewritten, and there's little demand
> +for them on this legacy (retro?) platform, so there's no plan to implement them.
> +If you have a genuine need for them, please contact the maintainers.

If there is any need for new features then I think the plan should be to
make a drm driver.

> +
> +Maintainers
> +================
> +
> +This driver is maintained by
> +
> +	* Tom Li <tomli@tomli.me>

??
I didn't know this. MAINTAINERS file doesnot say so.

> +	* Sudip Mukherjee <sudipm.mukherjee@gmail.com>
> +	* Teddy Wang <teddy.wang@siliconmotion.com>
> +
> +Tom Li was the last contributor of this driver who implemented 2D acceleration,
> +and is the main author of this documentation, please send any bug reports or
> +requests to Tom, but don't forget to CC other maintainers as well to make everyone
> +be informed.

There is a MAINTAINERS file to list the maintainers. There is no need to
add that in documentation.

--
Regards
Sudip
