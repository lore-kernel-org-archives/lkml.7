Return-Path: <SRS0=P610=TX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_NEOMUTT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 33095C282DE
	for <linux-kernel@archiver.kernel.org>; Thu, 23 May 2019 08:05:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F1D3E20862
	for <linux-kernel@archiver.kernel.org>; Thu, 23 May 2019 08:05:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729588AbfEWIFK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 23 May 2019 04:05:10 -0400
Received: from mail-wm1-f67.google.com ([209.85.128.67]:52576 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726310AbfEWIFK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 May 2019 04:05:10 -0400
Received: by mail-wm1-f67.google.com with SMTP id y3so4756925wmm.2
        for <linux-kernel@vger.kernel.org>; Thu, 23 May 2019 01:05:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=LkPnFtYpyLkj70RFjcw8TCN+fI+dWnCKWpxfIn/z7iU=;
        b=jBMXbjzLUm/ywo5MXxUL6bjgTvJIaxGOHsY8ma/M9i07AJTQ2Jkll6t5FktnsRIm8O
         eUEyn173etmXR/RFgdaybt4KtAYWnRyrt/UlH/dd7Vpkj5S9h6kCYz6lTq/7QnKAsJUZ
         Nh8qi/iHHCFCuA6Y798VHEKYI3mP05lfgHzEnYhw5x8iE4OBcUqHM0r9uHu/fwDOUPya
         hbkS3QhP+8fOGcpBRIJ2bi9M4IPpfcuK8rAzSH9xaCddVM2n6aQqAHsJAEjUROvDJ1V8
         eCOP0+sNqrGp893cnd1Ck4DAHKFS7zlaPhzLCjBplxAjR7pYgFAPfHbE4n9qcM9qU0dV
         wqzw==
X-Gm-Message-State: APjAAAUqNqdEcGsq5K3F0x672K3+zmI5sNYQFsFxIxUvCuslwGuBYiG9
        anwlOOCPg7E038wO+bwY4Kbn
X-Google-Smtp-Source: APXvYqxITmMxSX8uME9UdPACUAgC7iQj9jnQEo6XGQeTkpXlqJwcuGF4Z5vNg0khkQCg+bTy4sed0w==
X-Received: by 2002:a1c:ba87:: with SMTP id k129mr10775600wmf.132.1558598707627;
        Thu, 23 May 2019 01:05:07 -0700 (PDT)
Received: from localhost (cpc111743-lutn13-2-0-cust844.9-3.cable.virginm.net. [82.17.115.77])
        by smtp.gmail.com with ESMTPSA id k63sm9304944wmf.35.2019.05.23.01.05.06
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 23 May 2019 01:05:06 -0700 (PDT)
Date:   Thu, 23 May 2019 09:05:06 +0100
From:   Aaron Tomlin <atomlin@redhat.com>
To:     Matteo Croce <mcroce@redhat.com>
Cc:     LKML <linux-kernel@vger.kernel.org>, linux-fsdevel@vger.kernel.org,
        Kees Cook <keescook@chromium.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Matthew Wilcox <willy@infradead.org>
Subject: Re: [PATCH v5] proc/sysctl: add shared variables for range check
Message-ID: <20190523080506.imvtj5ve2iwatdbn@atomlin.usersys.com>
References: <20190430180111.10688-1-mcroce@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20190430180111.10688-1-mcroce@redhat.com>
X-PGP-Key: http://pgp.mit.edu/pks/lookup?search=atomlin%40redhat.com
X-PGP-Fingerprint: 7906 84EB FA8A 9638 8D1E  6E9B E2DE 9658 19CC 77D6
User-Agent: NeoMutt/20180716-1637-ee8449
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue 2019-04-30 20:01 +0200, Matteo Croce wrote:
> In the sysctl code the proc_dointvec_minmax() function is often used to
> validate the user supplied value between an allowed range. This function
> uses the extra1 and extra2 members from struct ctl_table as minimum and
> maximum allowed value.
> 
> On sysctl handler declaration, in every source file there are some readonly
> variables containing just an integer which address is assigned to the
> extra1 and extra2 members, so the sysctl range is enforced.
> 
> The special values 0, 1 and INT_MAX are very often used as range boundary,
> leading duplication of variables like zero=0, one=1, int_max=INT_MAX in
> different source files:
> 
>     $ git grep -E '\.extra[12].*&(zero|one|int_max)\b' |wc -l
>     248
> 
> Add a const int array containing the most commonly used values,
> some macros to refer more easily to the correct array member,
> and use them instead of creating a local one for every object file.
> 
> This is the bloat-o-meter output comparing the old and new binary
> compiled with the default Fedora config:
> 
>     # scripts/bloat-o-meter -d vmlinux.o.old vmlinux.o
>     add/remove: 2/2 grow/shrink: 0/2 up/down: 24/-188 (-164)
>     Data                                         old     new   delta
>     sysctl_vals                                    -      12     +12
>     __kstrtab_sysctl_vals                          -      12     +12
>     max                                           14      10      -4
>     int_max                                       16       -     -16
>     one                                           68       -     -68
>     zero                                         128      28    -100
>     Total: Before=20583249, After=20583085, chg -0.00%
> 
> Signed-off-by: Matteo Croce <mcroce@redhat.com>
> ---

Nice idea.

Reviewed-by: Aaron Tomlin <atomlin@redhat.com>

-- 
Aaron Tomlin
