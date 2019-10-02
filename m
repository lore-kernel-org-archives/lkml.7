Return-Path: <SRS0=zem1=X3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_2 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 21077C352AA
	for <linux-kernel@archiver.kernel.org>; Wed,  2 Oct 2019 13:44:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E691221D80
	for <linux-kernel@archiver.kernel.org>; Wed,  2 Oct 2019 13:44:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1570023887;
	bh=zA+AYhrj9aXpEMcW3P8M3dbKuhpK8rG/+7sTtACGh1I=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=p6cY6wYRjOdN478LSOr+xzJYxMB7cg9JXohnwN10Z5JoqhzlKtgfZmtsAvels7fk6
	 FKrMfqYlzMYwJQHMknqOTEZunDd2JkBbwDH/LZ59PT+Uo+xxGC4a2iMD0cEoHXA7kT
	 riD6C3wbSFb4MUc6hbZ2m7ttLLyiFwrKfsSZMiSA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727718AbfJBNoq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 2 Oct 2019 09:44:46 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:48438 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726492AbfJBNoq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Oct 2019 09:44:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Subject:Cc:To:
        From:Date:Sender:Reply-To:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=xvj+11lLnkJM8CvHPURkxK9HVEjGs17opaGu5jJQ14Q=; b=moVyqFuqlDsZz38XFIA1knRoG
        g+IW7F1j+brTqMQrrCRrAE1jJ+JLTjapA2ruZuZDWMRBtnf6bKoRbNhNPvsFDr2f/yO3lwr0/CH8d
        F56MKpHP/Q/rD9hS0hEXmtqCsVmrOfJoyQkNQC4Ed+T4vzAj4nDr8EHDusKUAkiYeQ9HHqXg9QQIf
        s0MMtc+7O5nkDu8jNBACsXE+wP/GPBsoOoKc/KVX5EMZFlworje8e+qXa3OPF1L58ijSLoDfOnzE8
        P88XJJwmHxrx1FiHdWq8nwkFuUR6sOlmQbgWz0Vws9BPnlht4TxSG+arzZU5G8OP8ZjQ2HO1dNDdH
        XutO9PNEQ==;
Received: from 177.157.127.95.dynamic.adsl.gvt.net.br ([177.157.127.95] helo=coco.lan)
        by bombadil.infradead.org with esmtpsa (Exim 4.92.2 #3 (Red Hat Linux))
        id 1iFevq-00056S-GY; Wed, 02 Oct 2019 13:44:42 +0000
Date:   Wed, 2 Oct 2019 10:44:38 -0300
From:   Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
To:     Jeremy MAURO <jeremy.mauro@gmail.com>
Cc:     j.mauro@criteo.com, Jonathan Corbet <corbet@lwn.net>,
        linux-doc@vger.kernel.org (open list:DOCUMENTATION SCRIPTS),
        linux-kernel@vger.kernel.org (open list)
Subject: Re: [PATCH v2 1/2] scripts/sphinx-pre-install: allow checking for
 multiple missing files
Message-ID: <20191002104438.1131e911@coco.lan>
In-Reply-To: <20191002133340.10854-1-j.mauro@criteo.com>
References: <20191002073526.228fc7e1@coco.lan>
        <20191002133340.10854-1-j.mauro@criteo.com>
X-Mailer: Claws Mail 3.17.4 (GTK+ 2.24.32; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Wed,  2 Oct 2019 15:33:39 +0200
Jeremy MAURO <jeremy.mauro@gmail.com> escreveu:

> The current implementation take a simple file as first argument, this
> change allows to take a list as a first argument.
> 
> Some file could have a different path according distribution version
> 
> Signed-off-by: Jeremy MAURO <j.mauro@criteo.com>

Reviewed-by: Mauro Carvalho Chehab <mchehab+samsung@kernel.org>

> ---
> Changes in v2:
> - Change the commit message
> 
>  scripts/sphinx-pre-install | 20 +++++++++++---------
>  1 file changed, 11 insertions(+), 9 deletions(-)
> 
> diff --git a/scripts/sphinx-pre-install b/scripts/sphinx-pre-install
> index 3b638c0e1a4f..b5077ae63a4b 100755
> --- a/scripts/sphinx-pre-install
> +++ b/scripts/sphinx-pre-install
> @@ -124,11 +124,13 @@ sub add_package($$)
>  
>  sub check_missing_file($$$)
>  {
> -	my $file = shift;
> +	my $files = shift;
>  	my $package = shift;
>  	my $is_optional = shift;
>  
> -	return if(-e $file);
> +	for (@$files) {
> +		return if(-e $_);
> +	}
>  
>  	add_package($package, $is_optional);
>  }
> @@ -343,10 +345,10 @@ sub give_debian_hints()
>  	);
>  
>  	if ($pdf) {
> -		check_missing_file("/usr/share/fonts/truetype/dejavu/DejaVuSans.ttf",
> +		check_missing_file(["/usr/share/fonts/truetype/dejavu/DejaVuSans.ttf"],
>  				   "fonts-dejavu", 2);
>  
> -		check_missing_file("/usr/share/fonts/noto-cjk/NotoSansCJK-Regular.ttc",
> +		check_missing_file(["/usr/share/fonts/noto-cjk/NotoSansCJK-Regular.ttc"],
>  				   "fonts-noto-cjk", 2);
>  	}
>  
> @@ -413,7 +415,7 @@ sub give_redhat_hints()
>  	}
>  
>  	if ($pdf) {
> -		check_missing_file("/usr/share/fonts/google-noto-cjk/NotoSansCJK-Regular.ttc",
> +		check_missing_file(["/usr/share/fonts/google-noto-cjk/NotoSansCJK-Regular.ttc"],
>  				   "google-noto-sans-cjk-ttc-fonts", 2);
>  	}
>  
> @@ -498,7 +500,7 @@ sub give_mageia_hints()
>  	$map{"latexmk"} = "texlive-collection-basic";
>  
>  	if ($pdf) {
> -		check_missing_file("/usr/share/fonts/google-noto-cjk/NotoSansCJK-Regular.ttc",
> +		check_missing_file(["/usr/share/fonts/google-noto-cjk/NotoSansCJK-Regular.ttc"],
>  				   "google-noto-sans-cjk-ttc-fonts", 2);
>  	}
>  
> @@ -528,7 +530,7 @@ sub give_arch_linux_hints()
>  	check_pacman_missing(\@archlinux_tex_pkgs, 2) if ($pdf);
>  
>  	if ($pdf) {
> -		check_missing_file("/usr/share/fonts/noto-cjk/NotoSansCJK-Regular.ttc",
> +		check_missing_file(["/usr/share/fonts/noto-cjk/NotoSansCJK-Regular.ttc"],
>  				   "noto-fonts-cjk", 2);
>  	}
>  
> @@ -549,11 +551,11 @@ sub give_gentoo_hints()
>  		"rsvg-convert"		=> "gnome-base/librsvg",
>  	);
>  
> -	check_missing_file("/usr/share/fonts/dejavu/DejaVuSans.ttf",
> +	check_missing_file(["/usr/share/fonts/dejavu/DejaVuSans.ttf"],
>  			   "media-fonts/dejavu", 2) if ($pdf);
>  
>  	if ($pdf) {
> -		check_missing_file("/usr/share/fonts/noto-cjk/NotoSansCJKsc-Regular.otf",
> +		check_missing_file(["/usr/share/fonts/noto-cjk/NotoSansCJKsc-Regular.otf"],
>  				   "media-fonts/noto-cjk", 2);
>  	}
>  



Thanks,
Mauro
