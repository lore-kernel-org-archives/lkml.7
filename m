Return-Path: <SRS0=K9bG=V2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FSL_HELO_FAKE,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1,USER_IN_DEF_DKIM_WL autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 75E88C7618B
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jul 2019 16:45:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4CB15206A2
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jul 2019 16:45:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="c/T89pkw"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728169AbfG2Qpv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 29 Jul 2019 12:45:51 -0400
Received: from mail-pl1-f194.google.com ([209.85.214.194]:46527 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727488AbfG2Qpv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Jul 2019 12:45:51 -0400
Received: by mail-pl1-f194.google.com with SMTP id c2so27703586plz.13
        for <linux-kernel@vger.kernel.org>; Mon, 29 Jul 2019 09:45:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=pAIl7l5xV9a61+zwFKixB9aQRDsJsbV90e9I/piolA4=;
        b=c/T89pkwIUj69b0jSIkbiOwuu/NDAXXwoyH2e+hkNbC9KBow0X0s40uzOd3jHqdmoO
         vQBK8QdLYbyHbIls9D1bDHbOrYU59y2ItiNmwb4onsM0SJKt694uU7eIbRS1ARauPJ6l
         EXDVjXhCJ1BH2uj6/k4ssjiIYxLAcEEpqZVbJq1ylD7ksMpnPhnYDjLCz7MAXfxXDtyR
         FYny1flcGh2KgqQt4T+ISe8rKRmbGoDYJLUTi8yJPFfMdL7xY3ftN23S4R0MlfE//X1p
         ZsRwq29gL+sEgQVxujFtLh/VgYkvMj3KNcrBmr0TGagCTKIV1SKl2VTFokmorSZxQzw5
         zE2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=pAIl7l5xV9a61+zwFKixB9aQRDsJsbV90e9I/piolA4=;
        b=UO6ea2JPZc18s04X2YoEoksUfQfDJ8bvIcYrVB+PmQi0TIotY11XpERnW1mHFu6/6s
         WyX6q+phCuz7xO9OSj56ToRROPHl+ml0+cCOVtEMZjAJ3XOd2udQV0L6/bT5UCiTEpJA
         Bv18/HjlVJG8auHT+0W46mOMpF7QXGOFcxVp86ObAP0NXaOmFs1+XcTmTvNYOyNA7iZw
         kuhN0Ry9uzhAYxZDaKBqeadFru2PGXX7hcrbaJw83Cc7g2cZsiR+LNZMgzBeOHmsmLcb
         W/pw3BZnDbv1IMctiDPWPSVPyEISbPKNdcXMOr0cY3pNgJHSg/cavHHzkpbDrrC2q37g
         ltrw==
X-Gm-Message-State: APjAAAVZzeRYY+1PHDWpKmgEb+FvBIammFW+yUR77tLyWVCA/oPrO46q
        amMvptNXvHE0i3TDs996P0H4DM8svUo=
X-Google-Smtp-Source: APXvYqx5ZLMjmF15SkXNW0DbwzjiKDEXLYhvkONIz+FlVQTYTQqrbiLFTStlfnWNGr881m5FHXOPzA==
X-Received: by 2002:a17:902:23:: with SMTP id 32mr24198236pla.34.1564418749725;
        Mon, 29 Jul 2019 09:45:49 -0700 (PDT)
Received: from google.com ([2620:0:1008:1101:3355:2f1d:dbad:b153])
        by smtp.gmail.com with ESMTPSA id o13sm64761916pje.28.2019.07.29.09.45.48
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Mon, 29 Jul 2019 09:45:49 -0700 (PDT)
Date:   Mon, 29 Jul 2019 09:45:45 -0700
From:   Tom Roeder <tmroeder@google.com>
To:     Masahiro Yamada <yamada.masahiro@socionext.com>
Cc:     linux-kbuild@vger.kernel.org,
        Nick Desaulniers <ndesaulniers@google.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] gen_compile_commands: lower the entry count threshold
Message-ID: <20190729164545.GA200478@google.com>
References: <20190727030110.17208-1-yamada.masahiro@socionext.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190727030110.17208-1-yamada.masahiro@socionext.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jul 27, 2019 at 12:01:10PM +0900, Masahiro Yamada wrote:
> Running gen_compile_commands.py after building with allnoconfig
> gave this:
> 
> $ ./scripts/gen_compile_commands.py
> WARNING: Found 449 entries. Have you compiled the kernel?

Thanks for catching this! I should have tried with allnoconfig when I
originally did this, but I didn't think of it.

> 
> Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
Reviewed-by: Tom Roeder <tmroeder@google.com>

> ---
> 
>  scripts/gen_compile_commands.py | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/scripts/gen_compile_commands.py b/scripts/gen_compile_commands.py
> index 7915823b92a5..c458696ef3a7 100755
> --- a/scripts/gen_compile_commands.py
> +++ b/scripts/gen_compile_commands.py
> @@ -21,9 +21,9 @@ _LINE_PATTERN = r'^cmd_[^ ]*\.o := (.* )([^ ]*\.c)$'
>  _VALID_LOG_LEVELS = ['DEBUG', 'INFO', 'WARNING', 'ERROR', 'CRITICAL']
>  
>  # A kernel build generally has over 2000 entries in its compile_commands.json
> -# database. If this code finds 500 or fewer, then warn the user that they might
> +# database. If this code finds 300 or fewer, then warn the user that they might
>  # not have all the .cmd files, and they might need to compile the kernel.
> -_LOW_COUNT_THRESHOLD = 500
> +_LOW_COUNT_THRESHOLD = 300
>  
>  
>  def parse_arguments():
> -- 
> 2.17.1
> 
