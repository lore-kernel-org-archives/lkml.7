Return-Path: <SRS0=N68d=SK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 842A1C10F13
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Apr 2019 18:08:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5AE0220870
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Apr 2019 18:08:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="HRZYZDKD"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729244AbfDHSI2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Apr 2019 14:08:28 -0400
Received: from mail-pl1-f196.google.com ([209.85.214.196]:42284 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725983AbfDHSI2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Apr 2019 14:08:28 -0400
Received: by mail-pl1-f196.google.com with SMTP id cv12so7770981plb.9
        for <linux-kernel@vger.kernel.org>; Mon, 08 Apr 2019 11:08:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=6rooXMDx733C5jOZV0HDJGU0vPGbQdWxeSk9HuXBbx4=;
        b=HRZYZDKDfXK5tUiWAX/wWOVIZxw1yj3uaOhsMKPNlAYpnNEsZF0Ig+kBhxnHzgSOW8
         vrsb8nkhq7HOd9Af/7DgR0F6e+Hlvq/qpLyNpLoG5PRnCLMpJyvG8SOHMrGzO8ozTSfz
         sbVSsk6WaoDPdf8Svi0kFukrWICk6bTEfKGjAvmlol//D3EuYmJ8UjSOakz2WDpHtsDw
         avxV0aAbT6s+9VvWICs3H4S7QEf9Xv36+d8Paa0Eo3rCOZ9pzZw6bbUQvuhloAFIs+uc
         ippaOtK9gz33mFuyz+xayvv91ZFzY5B+ct3UjuOXERl7LgCVp8SM75PAL174g08XGn0w
         Kn+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=6rooXMDx733C5jOZV0HDJGU0vPGbQdWxeSk9HuXBbx4=;
        b=b37uewHM7rnr/9/Xe+J3BBpkWJNO6s+ic6LabcGjE0CzPLF7GZwlyw71/QGIiy6YE+
         bf5VHRsj+fOOVBuDdMbtCWWKkaAreGXEPeEDAU37xwQ4JCnK0bOFZMp80dAYlzLxCzpT
         pLCOcRS7npxOwF8Qrr+k7EOOFKH5mngxDkXfSVcCmyg53vrGpuCFuGZ2G28MHUCxbwUz
         G3KofnX+fMDN+4BMsPCUT9tfiBYI87mqy4CcLafdTwq3UFZ+DnY/G3Yn34aE0HlQPbzn
         olMCrqNGXUbPYCcva5cbAjArkNbHKPgKjs/mz75DeiuzjxRPkMLmuQeH1L6/Nl4FiKBA
         GB6Q==
X-Gm-Message-State: APjAAAWc/1ulUHOrYgHboHJvx+JADWEJDfKWtN963chlF/hCUEUfxPsN
        evfcgjf9215Uk3may2bNXjP32bbpf198/WJjcx5cbA==
X-Google-Smtp-Source: APXvYqzH9ZLofJ/eiR/IarF6xRJ0GP/OSTVeaGgW0jclwehLUjzUharpyVUQYnQwNuod71QbuTS1RXQZ8cpWoLj0s+c=
X-Received: by 2002:a17:902:7044:: with SMTP id h4mr31818040plt.274.1554746907239;
 Mon, 08 Apr 2019 11:08:27 -0700 (PDT)
MIME-Version: 1.0
References: <20190407022558.65489-1-trong@android.com>
In-Reply-To: <20190407022558.65489-1-trong@android.com>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Mon, 8 Apr 2019 11:08:16 -0700
Message-ID: <CAKwvOdmBa-Ckk4wnp4OEPNdxeYSxEhzddykuWWGG1Wi6JEGDwA@mail.gmail.com>
Subject: Re: [PATCH] module: add stub for within_module
To:     Tri Vo <trong@android.com>, Jessica Yu <jeyu@kernel.org>,
        Matthew Wilcox <willy@infradead.org>,
        Randy Dunlap <rdunlap@infradead.org>
Cc:     Peter Oberparleiter <oberpar@linux.ibm.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Greg Hackmann <ghackmann@android.com>,
        Linux Memory Management List <linux-mm@kvack.org>,
        kbuild-all@01.org, kbuild test robot <lkp@intel.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Petri Gynther <pgynther@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Apr 6, 2019 at 7:26 PM Tri Vo <trong@android.com> wrote:
>
> Provide a stub for within_module() when CONFIG_MODULES is not set. This
> is needed to build CONFIG_GCOV_KERNEL.
>
> Fixes: 8c3d220cb6b5 ("gcov: clang support")

The above commit got backed out of the -mm tree, due to the issue this
patch addresses, so not sure it provides the correct context for the
patch.  Maybe that line in the commit message should be dropped?

> Suggested-by: Matthew Wilcox <willy@infradead.org>
> Reported-by: Randy Dunlap <rdunlap@infradead.org>
> Reported-by: kbuild test robot <lkp@intel.com>
> Link: https://marc.info/?l=linux-mm&m=155384681109231&w=2
> Signed-off-by: Tri Vo <trong@android.com>
> ---
>  include/linux/module.h | 5 +++++
>  1 file changed, 5 insertions(+)
>
> diff --git a/include/linux/module.h b/include/linux/module.h
> index 5bf5dcd91009..47190ebb70bf 100644
> --- a/include/linux/module.h
> +++ b/include/linux/module.h
> @@ -709,6 +709,11 @@ static inline bool is_module_text_address(unsigned long addr)
>         return false;
>  }
>
> +static inline bool within_module(unsigned long addr, const struct module *mod)
> +{
> +       return false;
> +}
> +

Do folks think that similar stubs for within_module_core and
within_module_init should be added, while we're here?

It looks like kernel/trace/ftrace.c uses them, but has proper
CONFIG_MODULE guards.

>  /* Get/put a kernel symbol (calls should be symmetric) */
>  #define symbol_get(x) ({ extern typeof(x) x __attribute__((weak)); &(x); })
>  #define symbol_put(x) do { } while (0)
> --
> 2.21.0.392.gf8f6787159e-goog
>


-- 
Thanks,
~Nick Desaulniers
