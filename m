Return-Path: <SRS0=6YJq=VW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5A345C76190
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Jul 2019 23:28:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2E0E421852
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Jul 2019 23:28:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="HQmc7Fxe"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727021AbfGYX2e (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Jul 2019 19:28:34 -0400
Received: from mail-pl1-f194.google.com ([209.85.214.194]:45882 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726870AbfGYX2e (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Jul 2019 19:28:34 -0400
Received: by mail-pl1-f194.google.com with SMTP id y8so23996410plr.12
        for <linux-kernel@vger.kernel.org>; Thu, 25 Jul 2019 16:28:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=M3rqORVkqBiODjKEMrIyrwxQVBfmP7LQCVwVFz/rCkM=;
        b=HQmc7FxeDA3d2FsEzSxitr3nsdIOetT67kgNAii5UPpvX7fy3Pjspmgx2/L8s/udWN
         48C3ZZVKnipawiHGa/P9T8sMkAUG6Gx5NDyKNreq2hjqUIEa1w9S6XHpNRxuoIfmn0np
         hoV24HNckvAfPIUGbRv1+dig8Iv/+MjMPENcU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=M3rqORVkqBiODjKEMrIyrwxQVBfmP7LQCVwVFz/rCkM=;
        b=TxZErb4qsoVv7qoj3UKp/BC4kW7D7fJKa0gIB/Ufwbi9JNyshBfg/lRCFsq60i196Y
         aNGUuiUq5HG/Ux1uJy4LHm89TBEGZjFc3Q5zfECCp1me7bvGHkCE4mhQhlNVuDwue2ZA
         TC8D2kYo+Bondse3tf+kIFltjNlLTOY/GzGfJ8hLrPLmRr8kP3yubOHRyPr/wWLkEt8d
         HaxSh8P4Io/u5XlWVZJefvh1l02OiamBy3S57dxRdJ2VRjy0WOu+I9Igamuls6d4U5vB
         9v+q1QRYaVGfNb0u2DHdgukuzVykY3OGa2Y4hJ4gy2q8jbO8sdS0oA88Nf8WoVDWFR9F
         F7Mw==
X-Gm-Message-State: APjAAAXhIZVJELfOxDtnJVOTC29iEaCSS5rHdcn2NrsUqGsCAu5Gipl+
        8iMoZpjvkIm9vXp2rKq+USANNoSGhGI=
X-Google-Smtp-Source: APXvYqz7bMqVPHEDovV+s45euU5I00RSWdblm4ISMBy7OUzPsKoXZiQqFFAcALMOYCpvfrg5xwiWzg==
X-Received: by 2002:a17:902:3103:: with SMTP id w3mr94989186plb.84.1564097313473;
        Thu, 25 Jul 2019 16:28:33 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id bo20sm37941048pjb.23.2019.07.25.16.28.32
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 25 Jul 2019 16:28:32 -0700 (PDT)
Date:   Thu, 25 Jul 2019 16:28:31 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Joe Perches <joe@perches.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Borislav Petkov <bp@alien8.de>, hpa@zytor.com,
        tglx@linutronix.de, mingo@kernel.org, gustavo@embeddedor.com,
        torvalds@linux-foundation.org, acme@kernel.org,
        kan.liang@linux.intel.com, namhyung@kernel.org, jolsa@redhat.com,
        linux-kernel@vger.kernel.org, alexander.shishkin@linux.intel.com,
        linux-tip-commits@vger.kernel.org
Subject: Re: [tip:perf/urgent] perf/x86/intel: Mark expected switch
 fall-throughs
Message-ID: <201907251627.5DA61CB@keescook>
References: <20190624161913.GA32270@embeddedor>
 <tip-289a2d22b5b611d85030795802a710e9f520df29@git.kernel.org>
 <20190725170613.GC27348@nazgul.tnic>
 <20190725173521.GM31381@hirez.programming.kicks-ass.net>
 <ad5ec66830b502d68e6d3c814706b52490418f0f.camel@perches.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ad5ec66830b502d68e6d3c814706b52490418f0f.camel@perches.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 25, 2019 at 04:18:56PM -0700, Joe Perches wrote:
> On Thu, 2019-07-25 at 19:35 +0200, Peter Zijlstra wrote:
> > Seriously though; I detest these patches and we really, as in _really_
> > should have done that attribute thing.
> 
> At least it'll be fairly easy to convert to something
> sensible later.
> 
> Variants of the equivalent of:
> 
> s@/* fallthrough */@fallthrough;@
> 
> with some trivial whitespace reformatting will read
> _much_ better.
> 
> It's pretty scriptable.

Yup; that's been my perspective. First let's finish markings (so so
close right now), then we can do the next phase.

-- 
Kees Cook
