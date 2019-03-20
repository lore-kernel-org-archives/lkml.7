Return-Path: <SRS0=4Jrr=RX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A4EEAC43381
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Mar 2019 19:42:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7B9E220857
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Mar 2019 19:42:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=joelfernandes.org header.i=@joelfernandes.org header.b="HXQgE8zf"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727490AbfCTTmV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Mar 2019 15:42:21 -0400
Received: from mail-qk1-f193.google.com ([209.85.222.193]:33346 "EHLO
        mail-qk1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726093AbfCTTmU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Mar 2019 15:42:20 -0400
Received: by mail-qk1-f193.google.com with SMTP id k189so9653183qkc.0
        for <linux-kernel@vger.kernel.org>; Wed, 20 Mar 2019 12:42:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=VbrnenGSNs7Bb+kAyHYWxxdHjU+QoptUXg7QX+PaZ/Y=;
        b=HXQgE8zfQxOptIu1OfFHgkh1M4Y85bpzO+ebVd4rPpXL49zCno2cViFhK0erMuRplB
         bceo3+yUwbJNYNi49nF27k4owhMHCyk+Ozc9aAnPDIr+8dvvikp+w6dkudHZ7QibukjG
         of1vSuPT4BErfsZIRPRxCHT+QKbxBxYZQ7KQI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=VbrnenGSNs7Bb+kAyHYWxxdHjU+QoptUXg7QX+PaZ/Y=;
        b=l8H5W83ZhbVTp6QoONxtQzn3iw1l64uffqAnOoLI1T0VfJ1aKHkZwE5oDN/L6HUk3V
         ndXlOmHf3FPJziRJd++nZlduk1xIHKcM8oq7aBq8FZS/M+JkKZPjeO9ZCGej8YrF0k1h
         AIWNJBn5gSRwANEJq7+QYHNmEXmpk85eqm+465i9484ZEw/xO012EulB9eI/lKFEG+0W
         rbUNZ+n3ndeidx3zXX8d3Uz2oaOd4dEByBXWrJIUoQMLggAlUPG6gKDxHV/gcJg/LkD5
         ZLCwtkpJFG8IifzNq7yeC49OGLP2QL4/WosP2zEny4ubYm/bEaHAtZE9T/ecxwv5osPc
         ypHw==
X-Gm-Message-State: APjAAAUBO/Lzmh8yNhjMEvnRpNTN+vy+JD3Fq+m4+nlOdD9m/NcXSXUT
        WKDjeWJxn3P2UXHEXYIiF3KmIw==
X-Google-Smtp-Source: APXvYqwcB37vMB2GCE52Uua6m/iA9pSMhkqnSfm0d418ctJ/k3gXQolJrEwPE58AnsbdheKSey46zw==
X-Received: by 2002:a37:6510:: with SMTP id z16mr7531586qkb.341.1553110939836;
        Wed, 20 Mar 2019 12:42:19 -0700 (PDT)
Received: from localhost ([2620:0:1004:1100:cca9:fccc:8667:9bdc])
        by smtp.gmail.com with ESMTPSA id r64sm1481783qkc.27.2019.03.20.12.42.18
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 20 Mar 2019 12:42:18 -0700 (PDT)
Date:   Wed, 20 Mar 2019 15:42:18 -0400
From:   Joel Fernandes <joel@joelfernandes.org>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org, qais.yousef@arm.com,
        dietmar.eggemann@arm.com, linux@manojrajarao.com, ast@kernel.org,
        atishp04@gmail.com, dancol@google.com,
        Dan Williams <dan.j.williams@intel.com>,
        gregkh@linuxfoundation.org, Guenter Roeck <groeck@chromium.org>,
        Jonathan Corbet <corbet@lwn.net>, karim.yaghmour@opersys.com,
        Kees Cook <keescook@chromium.org>, kernel-team@android.com,
        linux-doc@vger.kernel.org, linux-kselftest@vger.kernel.org,
        linux-trace-devel@vger.kernel.org,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        mhiramat@kernel.org, rdunlap@infradead.org, rostedt@goodmis.org,
        Shuah Khan <shuah@kernel.org>, yhs@fb.com
Subject: Re: [PATCH v5 1/3] Provide in-kernel headers to make extending
 kernel easier
Message-ID: <20190320194218.GA80310@google.com>
References: <20190320163116.39275-1-joel@joelfernandes.org>
 <20190320113111.d68a7c71c2c163bbc7d5f6aa@linux-foundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190320113111.d68a7c71c2c163bbc7d5f6aa@linux-foundation.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 20, 2019 at 11:31:11AM -0700, Andrew Morton wrote:
> On Wed, 20 Mar 2019 12:31:14 -0400 "Joel Fernandes (Google)" <joel@joelfernandes.org> wrote:
> 
> > Introduce in-kernel headers and other artifacts which are made available
> > as an archive through proc (/proc/kheaders.tar.xz file).
> 
> Lazyass here hasn't been following the recent review discussion and is
> going to try cheating.  Are there significant outstanding concerns now,
> or are we good to go?

Looks to me like it is pretty solid. v4->v5 was just cosmetic changes,
rebasing etc. Unless Masahiro has any other concerns, it could be a
linux-next candidate. I tested it quite heavily, but would be nice to get
some linux-next testing as well.

thanks,

 - Joel

