Return-Path: <SRS0=vY9Y=RJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EF870C43381
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Mar 2019 12:50:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BCBE320652
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Mar 2019 12:50:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SoLDLYxh"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730206AbfCFMup (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 6 Mar 2019 07:50:45 -0500
Received: from mail-qt1-f194.google.com ([209.85.160.194]:37319 "EHLO
        mail-qt1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726317AbfCFMun (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Mar 2019 07:50:43 -0500
Received: by mail-qt1-f194.google.com with SMTP id a48so12615407qtb.4
        for <linux-kernel@vger.kernel.org>; Wed, 06 Mar 2019 04:50:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=4JG/rQJ8BdDl62UuvJ4KApYdSjBq2amnKleC7pgFETk=;
        b=SoLDLYxhvlhSwL3ysuNIQjxf4BUoWXOJByIU8DOV9VSgF5X4uI40IUTsnEs3oWqjh1
         Z3ObmyHTYiT+1Yo4Hkx+EbAYklLhwOCfI88sFC4DrFVdyQV1QwxXmG+M23Pdx5r3sdDA
         Mrg6+JY8E11FmoWoOLGdO24IfvAh5OlTTzuxdNOsXbsaG4AVdnAkMikRoQyvKZvucASn
         VxkZgdzVfSQTQ5VjqKh5qHRM+EMxBINQvCCOBxEV7EVkr4AV/nrsIMdVwIRv4lR+d4Wd
         JhUglM2xotytzuNyLr6osw7ZEm6FogA9UcslfwQv15ZNSuPFdgZH0LCGl2Sz9sCfiKrU
         5qMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=4JG/rQJ8BdDl62UuvJ4KApYdSjBq2amnKleC7pgFETk=;
        b=WqVvgjQbZXN0jaJl5dPhwe/FLVLwdBD0rj/J64nieMFKjGBZTVRfR4gs7vSEZGSbD6
         zYa8iT6dv3UMlZv7p0OyS3zVX1Sb+8Ibk7Y2HRsIkL/9/Hz7eIJSztkrrf1BNaP6i016
         42YlZUNE/lMoTHVeEqCCNe2P2lI41oRuOOsFlfAGcl3bFMBNb9GNkn0tq6CWnrjOjINA
         e+8BmD0gY/88DOSskMebWM48QrF2JarlTW/4rLkEdpoPXXh3yvZUskzdhiC0NW1KBfPT
         RvzkXC2u0zmPy52pNITw23qXAtLZK4tLCaE6DEHQPBxdZhN/6bjVLSj+ZLrzTcBy7pxh
         3xig==
X-Gm-Message-State: APjAAAVvB7ZRlnr5YwSt+MjCk1UI2boKi6x7XtAZg0aEOU2dPq4vzE0K
        Emwv7qwYYvMId5D4kIUnqis=
X-Google-Smtp-Source: APXvYqxV+eLyU/GqoN3jCHDp3dhud/P++rYOmu+QfxdaOp4jTKgWzYF6Mv/PHi6lQn1hU38p9dps0g==
X-Received: by 2002:a0c:d4ab:: with SMTP id u40mr6228292qvh.30.1551876642347;
        Wed, 06 Mar 2019 04:50:42 -0800 (PST)
Received: from quaco.ghostprotocols.net ([179.97.35.11])
        by smtp.gmail.com with ESMTPSA id y11sm1185272qky.2.2019.03.06.04.50.40
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 06 Mar 2019 04:50:40 -0800 (PST)
From:   Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>
X-Google-Original-From: Arnaldo Carvalho de Melo <acme@kernel.org>
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 5294A4039C; Wed,  6 Mar 2019 09:50:37 -0300 (-03)
Date:   Wed, 6 Mar 2019 09:50:37 -0300
To:     Yang Wei <albin_yang@163.com>
Cc:     linux-kernel@vger.kernel.org, peterz@infradead.org,
        mingo@redhat.com, alexander.shishkin@linux.intel.com,
        jolsa@redhat.com, namhyung@kernel.org, yang.wei9@zte.com.cn
Subject: Re: [PATCH] perf clang: fix semicolon code style issue
Message-ID: <20190306125037.GA30734@kernel.org>
References: <1551710174-3349-1-git-send-email-albin_yang@163.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1551710174-3349-1-git-send-email-albin_yang@163.com>
X-Url:  http://acmel.wordpress.com
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Mon, Mar 04, 2019 at 10:36:14PM +0800, Yang Wei escreveu:
> From: Yang Wei <yang.wei9@zte.com.cn>
> 
> Delete a superfluous semicolon in getBPFObjectFromModule().
> 
> Signed-off-by: Yang Wei <yang.wei9@zte.com.cn>
> ---
>  tools/perf/util/c++/clang.cpp | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/tools/perf/util/c++/clang.cpp b/tools/perf/util/c++/clang.cpp
> index 39c0004..fc361c3 100644
> --- a/tools/perf/util/c++/clang.cpp
> +++ b/tools/perf/util/c++/clang.cpp
> @@ -156,7 +156,7 @@ getBPFObjectFromModule(llvm::Module *Module)
>  #endif
>  	if (NotAdded) {
>  		llvm::errs() << "TargetMachine can't emit a file of this type\n";
> -		return std::unique_ptr<llvm::SmallVectorImpl<char>>(nullptr);;
> +		return std::unique_ptr<llvm::SmallVectorImpl<char>>(nullptr);
>  	}
>  	PM.run(*Module);

Thanks, applied.

- Arnaldo
