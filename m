Return-Path: <SRS0=31nU=WT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 53BD4C3A5A2
	for <linux-kernel@archiver.kernel.org>; Fri, 23 Aug 2019 13:07:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1CC2621848
	for <linux-kernel@archiver.kernel.org>; Fri, 23 Aug 2019 13:07:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="C0eLfp/C"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404516AbfHWNHc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 23 Aug 2019 09:07:32 -0400
Received: from mail-qk1-f194.google.com ([209.85.222.194]:45199 "EHLO
        mail-qk1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727894AbfHWNHb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Aug 2019 09:07:31 -0400
Received: by mail-qk1-f194.google.com with SMTP id m2so8065963qki.12
        for <linux-kernel@vger.kernel.org>; Fri, 23 Aug 2019 06:07:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=KOC9snNl1/HE//4pIB9X4Lz5leylyyb6K3ySSXx/F0M=;
        b=C0eLfp/Cz7+CtLdljKjWY/17aOuqAP/hDqtTOANOnesIHCl93MDR3U31e4vWXlFo6a
         K7sZ7lShLJOeaQ63Md92m3d4T0XEEOHWcju6WBY0lhQqQXgHU1k/FDcmU+lancgvIusf
         Z8QOelSAqcd19KEwqGoPppVkSKjCEBHUMm9H5HzwhMTd2gCvTOrENIN1G16D2NYendVb
         +bVKYlENXIUC+ASqbeX1EYpL6C8cKId3Cu8IW85Jff8NbSsziD/nOItZaJg9GvaPK78o
         IOT3uY4AZCGcVeMODI0KgfNHIL9oo+/vhmacfNig0gohtuF3UaHcZjRkdDKiadSykP9r
         8CEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=KOC9snNl1/HE//4pIB9X4Lz5leylyyb6K3ySSXx/F0M=;
        b=Vi65jy8obsOEpgUZQy+0JL0OgK49jHxGxJDqbobAUvBY2yQNcQsNkSg+IXGZObjFRJ
         XNFFRe2ewq9R8/OFdAgFUmR02no2aA1Wwt9sg3nVxGxD/drcjGqHMXr8Xim1hoaTkjQK
         iDuAvPmPJUuwGdhz5MIsnK6CLkwkx5wbCwtCHVIIDbne05+DJiOWJL7KlyK/YyNXLqTH
         CccO9CuAsVgODPdwVUeIHPdnr03SgKUMEP594Brn9HqE7Vv2kWj1mBFqyh07P/2ndAm3
         ik5X79UR283ipek4P0iXPBO6YRqyAKIz0Ybgz82DSVCblhKeOH4/0GsnURyXBnFdF16Y
         ir+g==
X-Gm-Message-State: APjAAAUfJmRukQa/0DXrB0AsIbaoIfScrCL9lvllMnLUv1rRWs13JiQd
        0z/Um/scvezXHeB2w4fxw4Q=
X-Google-Smtp-Source: APXvYqyGjVO0066toGbBSQT+OMQaAyXkubKQjL9+9ER0IB2tHh6jKSsnwtxvyX5J/P5w3HdiktQBfA==
X-Received: by 2002:a37:9bc4:: with SMTP id d187mr3889498qke.150.1566565650583;
        Fri, 23 Aug 2019 06:07:30 -0700 (PDT)
Received: from quaco.ghostprotocols.net ([179.97.35.50])
        by smtp.gmail.com with ESMTPSA id x28sm1449535qtk.8.2019.08.23.06.07.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Aug 2019 06:07:29 -0700 (PDT)
From:   Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>
X-Google-Original-From: Arnaldo Carvalho de Melo <acme@kernel.org>
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id C2F4640340; Fri, 23 Aug 2019 10:07:27 -0300 (-03)
Date:   Fri, 23 Aug 2019 10:07:27 -0300
To:     Benjamin Peterson <benjamin@python.org>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] perf trace beauty ioctl: fix off-by-one error in table
Message-ID: <20190823130727.GA10333@kernel.org>
References: <20190823033625.18814-1-benjamin@python.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190823033625.18814-1-benjamin@python.org>
X-Url:  http://acmel.wordpress.com
User-Agent: Mutt/1.12.0 (2019-05-25)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Thu, Aug 22, 2019 at 08:36:25PM -0700, Benjamin Peterson escreveu:
> While tracing a program that calls isatty(3), I noticed that strace reported
> TCGETS for the request argument of the underlying ioctl(2) syscall while perf
> trace reported TCSETS. strace is corrrect. The bug in perf was due to the tty
> ioctl beauty table starting at 0x5400 rather than 0x5401.

Applied, thanks a lot!

- Arnaldo
 
> Fixes: 1cc47f2d46206d67285aea0ca7e8450af571da13 ("perf trace beauty ioctl: Improve 'cmd' beautifier")
> Signed-off-by: Benjamin Peterson <benjamin@python.org>
> ---
>  tools/perf/trace/beauty/ioctl.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/tools/perf/trace/beauty/ioctl.c b/tools/perf/trace/beauty/ioctl.c
> index 52242fa4072b..e19eb6ea361d 100644
> --- a/tools/perf/trace/beauty/ioctl.c
> +++ b/tools/perf/trace/beauty/ioctl.c
> @@ -21,7 +21,7 @@
>  static size_t ioctl__scnprintf_tty_cmd(int nr, int dir, char *bf, size_t size)
>  {
>  	static const char *ioctl_tty_cmd[] = {
> -	"TCGETS", "TCSETS", "TCSETSW", "TCSETSF", "TCGETA", "TCSETA", "TCSETAW",
> +	[_IOC_NR(TCGETS)] = "TCGETS", "TCSETS", "TCSETSW", "TCSETSF", "TCGETA", "TCSETA", "TCSETAW",
>  	"TCSETAF", "TCSBRK", "TCXONC", "TCFLSH", "TIOCEXCL", "TIOCNXCL", "TIOCSCTTY",
>  	"TIOCGPGRP", "TIOCSPGRP", "TIOCOUTQ", "TIOCSTI", "TIOCGWINSZ", "TIOCSWINSZ",
>  	"TIOCMGET", "TIOCMBIS", "TIOCMBIC", "TIOCMSET", "TIOCGSOFTCAR", "TIOCSSOFTCAR",
> -- 
> 2.20.1

-- 

- Arnaldo
