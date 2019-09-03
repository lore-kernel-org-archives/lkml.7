Return-Path: <SRS0=TDKO=W6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1C161C3A5A2
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Sep 2019 19:44:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E07A2208E4
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Sep 2019 19:44:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fSaKc5Pr"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726651AbfICToa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 3 Sep 2019 15:44:30 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:36398 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725990AbfICTo3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Sep 2019 15:44:29 -0400
Received: by mail-wm1-f65.google.com with SMTP id p13so836246wmh.1
        for <linux-kernel@vger.kernel.org>; Tue, 03 Sep 2019 12:44:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=kRB0D+vfmEb8X1AX8Kdvfr8cXSx6BXMei0Gz311XGxY=;
        b=fSaKc5PrDtlNO+rW1ZPAiqAtggW9GUzEh4rQO8Y7HeP2EDTq+rPsFJP74ccSCaC7jt
         vtCWqYBj8jJWxYhDSpc99P/RO6vakWQ3/y8OFolwKf54HyjqcVkbZpyduanvcnTlVsTX
         WPH22gNGSINs/7ytjA3bFGQdwWmixIVAtK+jeLFNT7gErbT6B/nXhTKM5Fiq04lztEUE
         0duKKBQ5m1bUHBFycwE/TG7k/AD8pOb1Ehje60aDUVnpPSWPbB8KH+TsIiKrd0PntgDV
         bjHF7aiMZKO9wjFvS4Y6ryuJYPE/W5amp5WgRd7ELUIFtlLKMIfaoL1CmIGA0wn1YNof
         ko8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to;
        bh=kRB0D+vfmEb8X1AX8Kdvfr8cXSx6BXMei0Gz311XGxY=;
        b=CAd/WpHD1W9TRR4BaIYpfPB3qDwSmLomhEW/85L58CxHJGhiZernCCklDUIxB2JkEr
         mN1nfuKgxc8iNZ33AUGDLE0XCsg27Ir1mdRHsuaapdyROuWfSFA8TMqsYdr8HOZpi5T8
         TSRuGjWQB+qzOIV5vhqLg74kuPAvSaJdqKOgoAYJyMhvGKyml/T4zlqBSDNQty3jwlBW
         uMWDU/ohKfBSlKUOKWpftj+hLKmzf9qsEKU1EJpuNd3TICA0P/KpLONCcDC+xWIhrS9l
         6l0QnUnGd1eDB0V4qeNq6UbyURPgQGu2idBej84SYRI+KKdgMfRFEO7m4746m+epmraC
         MPLw==
X-Gm-Message-State: APjAAAUFpl0puXeUDt8sNpkI3j8BbeN89scRSYX4/l5vHUCwLmgOR0tD
        CMh7rAE+DW3JEGPS+Z0udEiJIqMTglE8yQ==
X-Google-Smtp-Source: APXvYqyV77ZE1mTCHCut4DQ/pMDRTkyVUXsVWbhjxupFaUdpeqISQNROKEZNslwR7keFRTQYeFWUSA==
X-Received: by 2002:a1c:80d0:: with SMTP id b199mr1229383wmd.102.1567539868033;
        Tue, 03 Sep 2019 12:44:28 -0700 (PDT)
Received: from rocinante (ip5b4096c3.dynamic.kabel-deutschland.de. [91.64.150.195])
        by smtp.gmail.com with ESMTPSA id n2sm14201089wro.52.2019.09.03.12.44.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Sep 2019 12:44:27 -0700 (PDT)
Date:   Tue, 3 Sep 2019 21:44:26 +0200
From:   Krzysztof Wilczynski <kw@linux.com>
To:     Guo Ren <guoren@kernel.org>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] csky: Move static keyword to the front of declaration
Message-ID: <20190903194424.GA23890@rocinante>
References: <20190903113651.3862-1-kw@linux.com>
 <CAJF2gTT-woTmWe4aqOLUemK6agTRHxXqWKoOAxeJ8XPiAJ+UzQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAJF2gTT-woTmWe4aqOLUemK6agTRHxXqWKoOAxeJ8XPiAJ+UzQ@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Guo,

Thank you for the feedback!

[...]
> You may also modify others'
[...]

That work is on-going, and patches are being sent out to address other
warnings of this nature to the respective maintainers. :)

Krzysztof
