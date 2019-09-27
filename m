Return-Path: <SRS0=WTd2=XW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FSL_HELO_FAKE,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1,USER_IN_DEF_DKIM_WL autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6F5ACC4360C
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Sep 2019 12:15:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 428DF20673
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Sep 2019 12:15:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="JPHXQFqJ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727451AbfI0MPD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 27 Sep 2019 08:15:03 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:45649 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725992AbfI0MPD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Sep 2019 08:15:03 -0400
Received: by mail-wr1-f68.google.com with SMTP id r5so2440117wrm.12
        for <linux-kernel@vger.kernel.org>; Fri, 27 Sep 2019 05:15:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=RxdYgn61HX6a7e2eevkhCujf5ZyNeC8QPK2+w9BEZ7k=;
        b=JPHXQFqJj47D5Fjd64grPSgNF8t78AawpFdU5Fh2PcJ7OFJ0juLG+nc57AWXaawGSm
         XQyJnKPC87T/9XBngVDwhS8Oycud741WiHaj5nakZ5wS111aMsaTscuj8cBO8jL7bzNH
         zTsR5KWYvJnAWn+KkyaIZWmfhzcwYS2uwBtLfqmigpVyeKLxyrqlnmYAcOH4vhJm9a8h
         YxmdgQWRWDGM3mC7lysmSItmgGSu4X7XWF5wKH5YD6J43Br8GwicDQXyfwJea5UF98kt
         BLwaUJBfDw0CjOBlso+TzItzhZmNUSrJE6c1Q23Ah+ycp3wnwvJB7zia4Ji+6e70Tx7R
         lAaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=RxdYgn61HX6a7e2eevkhCujf5ZyNeC8QPK2+w9BEZ7k=;
        b=cp+RCuLyC/B3NCXQh+cNq6ggZ9I3XGmNUSG85tYYTM0Cz2udB9a5sI70+dFttHxPpM
         KpmmaqhhSipLChyLalPstLDLNVHIPh2SwR7b6Q/NRIFDv9KXR3Y0B8+5+9wUPKf3+W8N
         R/RPAbyrdfCn07eEk68+TxbKNwLPrhL4G7eJesSO29HiMohFPwzB8cJYvH4+wQQPQHLf
         D7sB/WiOF81Kc2wGyG2wp7JGqg1ULOcqBgzaizOixOK+GchMjYAw5o3F43MnKpe25Trk
         YZW26RKllr+0HX3EOPKYR+WMMX+9OMcJUTsyy67uhpGewms/a3AqCJvEe68QaKlHFjyH
         tYAA==
X-Gm-Message-State: APjAAAUScYihOhqDOOeord81V67bCw3UhFXAlGhRF3NdADQ3FX8w69XF
        Lk16aOBHeXskLWxXZsYx2zwjpw==
X-Google-Smtp-Source: APXvYqwcePL60TOI9qQkJnY2W5H8K999fdxhk/wCVp+tkDye94PsEGsW6qFqKt27dGWUcdNPa3RZ9w==
X-Received: by 2002:adf:db83:: with SMTP id u3mr706271wri.36.1569586500509;
        Fri, 27 Sep 2019 05:15:00 -0700 (PDT)
Received: from google.com ([2a00:79e0:d:210:e8f7:125b:61e9:733d])
        by smtp.gmail.com with ESMTPSA id i73sm10987175wmg.33.2019.09.27.05.14.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Sep 2019 05:14:59 -0700 (PDT)
Date:   Fri, 27 Sep 2019 13:14:57 +0100
From:   Matthias Maennich <maennich@google.com>
To:     Masahiro Yamada <yamada.masahiro@socionext.com>
Cc:     Jessica Yu <jeyu@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Joel Fernandes <joel@joelfernandes.org>,
        Martijn Coenen <maco@android.com>,
        Will Deacon <will.deacon@arm.com>,
        Will Deacon <will@kernel.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/7] module: rename __kstrtab_ns_* to __kstrtabns_* to
 avoid symbol conflict
Message-ID: <20190927121457.GC259443@google.com>
References: <20190927093603.9140-1-yamada.masahiro@socionext.com>
 <20190927093603.9140-4-yamada.masahiro@socionext.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20190927093603.9140-4-yamada.masahiro@socionext.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 27, 2019 at 06:35:59PM +0900, Masahiro Yamada wrote:
>The module namespace produces __strtab_ns_<sym> symbols to store
>namespace strings, but it does not guarantee the name uniqueness.
>This is a potential problem because we have exported symbols staring
>with "ns_".
>
>For example, kernel/capability.c exports the following symbols:
>
>  EXPORT_SYMBOL(ns_capable);
>  EXPORT_SYMBOL(capable);
>
>Assume a situation where those are converted as follows:
>
>  EXPORT_SYMBOL_NS(ns_capable, some_namespace);
>  EXPORT_SYMBOL_NS(capable, some_namespace);
>
>The former expands to "__kstrtab_ns_capable" and "__kstrtab_ns_ns_capable",
>and the latter to "__kstrtab_capable" and "__kstrtab_ns_capable".
>Then, we have the duplication for "__kstrtab_ns_capable".
>
>To ensure the uniqueness, rename "__kstrtab_ns_*" to "__kstrtabns_*".

Again, thanks for catching this!

Reviewed-by: Matthias Maennich <maennich@google.com>

Cheers,
Matthias
>Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
>---
>
> include/linux/export.h | 6 +++---
> 1 file changed, 3 insertions(+), 3 deletions(-)
>
>diff --git a/include/linux/export.h b/include/linux/export.h
>index 0695d4e847d9..621158ecd2e2 100644
>--- a/include/linux/export.h
>+++ b/include/linux/export.h
>@@ -55,7 +55,7 @@ extern struct module __this_module;
> 	    "__ksymtab_" #ns NS_SEPARATOR #sym ":		\n"	\
> 	    "	.long	" #sym "- .				\n"	\
> 	    "	.long	__kstrtab_" #sym "- .			\n"	\
>-	    "	.long	__kstrtab_ns_" #sym "- .		\n"	\
>+	    "	.long	__kstrtabns_" #sym "- .			\n"	\
> 	    "	.previous					\n")
>
> #define __KSYMTAB_ENTRY(sym, sec)					\
>@@ -79,7 +79,7 @@ struct kernel_symbol {
> 	asm("__ksymtab_" #ns NS_SEPARATOR #sym)				\
> 	__attribute__((section("___ksymtab" sec "+" #sym), used))	\
> 	__aligned(sizeof(void *))					\
>-	= { (unsigned long)&sym, __kstrtab_##sym, __kstrtab_ns_##sym }
>+	= { (unsigned long)&sym, __kstrtab_##sym, __kstrtabns_##sym }
>
> #define __KSYMTAB_ENTRY(sym, sec)					\
> 	static const struct kernel_symbol __ksymtab_##sym		\
>@@ -112,7 +112,7 @@ struct kernel_symbol {
> /* For every exported symbol, place a struct in the __ksymtab section */
> #define ___EXPORT_SYMBOL_NS(sym, sec, ns)				\
> 	___export_symbol_common(sym, sec);				\
>-	static const char __kstrtab_ns_##sym[]				\
>+	static const char __kstrtabns_##sym[]				\
> 	__attribute__((section("__ksymtab_strings"), used, aligned(1)))	\
> 	= #ns;								\
> 	__KSYMTAB_ENTRY_NS(sym, sec, ns)
>-- 
>2.17.1
>
