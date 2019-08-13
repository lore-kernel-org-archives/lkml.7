Return-Path: <SRS0=Ecng=WJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BC45EC433FF
	for <linux-kernel@archiver.kernel.org>; Tue, 13 Aug 2019 16:52:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8B29F20663
	for <linux-kernel@archiver.kernel.org>; Tue, 13 Aug 2019 16:52:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="XgpQDDJM"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727582AbfHMQwA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 13 Aug 2019 12:52:00 -0400
Received: from mail-ot1-f68.google.com ([209.85.210.68]:43219 "EHLO
        mail-ot1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726810AbfHMQv7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Aug 2019 12:51:59 -0400
Received: by mail-ot1-f68.google.com with SMTP id e12so30842531otp.10
        for <linux-kernel@vger.kernel.org>; Tue, 13 Aug 2019 09:51:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google;
        h=date:from:to:cc:subject:in-reply-to:message-id:references
         :user-agent:mime-version;
        bh=uC6dDZKAip16b+mn3qV8AFtyarHS2Wtjrk4sIs9wXF4=;
        b=XgpQDDJMv+/ruzPLaeBUwtQGSgQA4L3nxrBQ917gPpnuR6cUFXgim3kBcEa/w5jutY
         1I9/+H2KPKPtxKPxy/8FlBxrLF+MmPmdZbuhYc8EDkrwdyqA6hVQoM95f8HcbpUpb1Qx
         hZTvovsZfKBhDBxViQTvA8wfBcIFktwAJqiyuK92QW91ND+gAjrkFS95swU6Mb77+JJT
         dWsfs+8qZJV00w+zYAJRBgLNShd42ftbjk5b5cCzZ2Wio/qFC7MchhHVkiLc0/4EM54U
         4yszi7PJ41btEdlzVWQp+FYSYj7QgFW35VAqKh4gbuBkIL4TFcY3xDlkKtl0imc5VzCp
         WJbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:in-reply-to:message-id
         :references:user-agent:mime-version;
        bh=uC6dDZKAip16b+mn3qV8AFtyarHS2Wtjrk4sIs9wXF4=;
        b=GbdmvphzU0HQbRaYHNTRx6YSdGUx+WIdGkO7Ls5zuWx8LezM98F3DTekgWeEtwG/u9
         KOs5HYI+6Xh+ktu9W2FfXdh4CNwNfnDfkY3CXcgxdkVP+PcZWdH99kwXi+UQYofMAfnk
         9u4m+ljcx2aWn/b3tC/V/4FNnicn5NKizRjKGA2JxaK3ujtvl+TGDj9dIz06QMJBb7Iw
         Q4FijvvLlAMhJm6uauVJfUi0wZfWTq+lJd0OBHVJq7FXCjuPjZVtHoFhb5fdFxvHBfzI
         awwtqI1CYrxKoNdv1R6SfusNnMIPziyTwlZt3PNOw3E6W6XrlTThSVAwksLkRatFW87O
         +C5A==
X-Gm-Message-State: APjAAAWPrEG2b/CZgV0oFFLbeowScms6T3sqWhMmtwU3XsfkK/5yzRUt
        oZN7cQdDghwUdNXkGq84Ix9UxCPmNyQ=
X-Google-Smtp-Source: APXvYqwPHBJM6jvKxBo1VW6csfTWhlFi+l+kj3B6joswy7ZnX59kuzbPWX+o7X/YHb6OhVNwnoh/Yw==
X-Received: by 2002:a5d:9747:: with SMTP id c7mr8146194ioo.244.1565715118854;
        Tue, 13 Aug 2019 09:51:58 -0700 (PDT)
Received: from localhost (c-73-95-159-87.hsd1.co.comcast.net. [73.95.159.87])
        by smtp.gmail.com with ESMTPSA id e26sm85862802iod.10.2019.08.13.09.51.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Aug 2019 09:51:58 -0700 (PDT)
Date:   Tue, 13 Aug 2019 09:51:56 -0700 (PDT)
From:   Paul Walmsley <paul.walmsley@sifive.com>
X-X-Sender: paulw@viisi.sifive.com
To:     Christoph Hellwig <hch@lst.de>
cc:     Palmer Dabbelt <palmer@sifive.com>,
        Damien Le Moal <damien.lemoal@wdc.com>,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        Atish Patra <atish.patra@wdc.com>
Subject: Re: [PATCH 02/15] riscv: use CSR_SATP instead of the legacy sptbr
 name in switch_mm
In-Reply-To: <20190813164257.GA10019@lst.de>
Message-ID: <alpine.DEB.2.21.9999.1908130951250.30024@viisi.sifive.com>
References: <20190813154747.24256-1-hch@lst.de> <20190813154747.24256-3-hch@lst.de> <alpine.DEB.2.21.9999.1908130935310.30024@viisi.sifive.com> <20190813164257.GA10019@lst.de>
User-Agent: Alpine 2.21.9999 (DEB 301 2018-08-15)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 13 Aug 2019, Christoph Hellwig wrote:

> On Tue, Aug 13, 2019 at 09:36:23AM -0700, Paul Walmsley wrote:
> > On Tue, 13 Aug 2019, Christoph Hellwig wrote:
> > 
> > > Switch to our own constant for the satp register instead of using
> > > the old name from a legacy version of the privileged spec.
> > > 
> > > Signed-off-by: Christoph Hellwig <hch@lst.de>
> > > Reviewed-by: Atish Patra <atish.patra@wdc.com>
> > 
> > Didn't you want us to replace this with Bin Meng's patch?
> > 
> > https://lore.kernel.org/linux-riscv/20190807151316.GB16432@infradead.org/
> > 
> > If so, probably best just to drop this one and state a dependency.
> 
> Either way is fine with me.  But until you have a branch with
> either one applied I'm going to keep resending my patch, as random
> dependencies on uncommitted patches don't work.

If you're going to resend a patch, it's better to resend the other one 
that you've explicitly endorsed in favor of your own.


- Paul
