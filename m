Return-Path: <SRS0=OzJr=YZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3B625CA9ECF
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Nov 2019 14:45:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0727421835
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Nov 2019 14:45:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=cmpxchg-org.20150623.gappssmtp.com header.i=@cmpxchg-org.20150623.gappssmtp.com header.b="rak1UdTK"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727427AbfKAOpp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 1 Nov 2019 10:45:45 -0400
Received: from mail-qt1-f195.google.com ([209.85.160.195]:45339 "EHLO
        mail-qt1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727027AbfKAOpo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Nov 2019 10:45:44 -0400
Received: by mail-qt1-f195.google.com with SMTP id x21so13152995qto.12
        for <linux-kernel@vger.kernel.org>; Fri, 01 Nov 2019 07:45:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=LZCWc31JbQup46mMGhgcePz/DKEu83nRcaKlxz0M1jA=;
        b=rak1UdTKjdXl/zlJlBJ/kQrrFtcFehWyyU0y8OnNXTn50FzcEjIJMQOYIBmCw3wgBv
         M0+WfKaDiw79cAa73mTLnmrBSloKYmCNwD+JCV2I2ggyP5tJTxZdvra5mX+cpcfRr5C/
         DmFwLQvlcZfPF135SEUV8S2/Kzgf2HMatwwp+RsBzhBKyYPNuf7O3nEbCxC6adOrxDRU
         CZ2WwvEOn5b5QymFWpQNBzzLuFBQ220URoMquKw2RQ0aZ6JyGYava298qsGg0MO0X4fW
         smtEW+gfvrm5T1tFeRrGTdfLUV5oXyFLNtFAQGsdbVFG9XAwdf1fO7H+UHH7xrtDV6KL
         SnrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=LZCWc31JbQup46mMGhgcePz/DKEu83nRcaKlxz0M1jA=;
        b=Y3bjt00rwhLFDUFH2pBmw1BdPOyrGlC8UeI/fxCissK4L1GFkn8+6yajoGLkvnica4
         YikpCVnBoH5xqjLmlVvnQX1SNGuT5s7cHOKIJd5FCgR8lnDNq8Duy6iYjaCKhIP2+9o5
         mDkPxDzYgUHNrAskYrls9iPyfsq4fRWt+bxCmNS7L+7MF/AZQzzVdVUAr1t9fLvo1eO0
         XsyXj51uSNS7DgoBBCytfNGVFsBzd7z/dvm0Y7WcXox9RhdK7AhqBmJxCoHrCgUpA4l3
         PCQMJvE7ASuM/gE6d7CYkmScwqknZSmGIXABg0VCPUKZKZO+ft2lRWC+DFI1mAo9cyBJ
         0UJQ==
X-Gm-Message-State: APjAAAVfJIGTrbntflzoZojHZ8zbu3S3p3gAmUaLprg4lo5wWOgzUx9C
        p3CUuY7q7Cvj1fbQ82B6kavVSA==
X-Google-Smtp-Source: APXvYqzcURMngGFdoa699OwPdXUeg4D6sDMyO6d3bUY+B6ZBaWp3YgpbvJaCF+QNuJpUxJssDXbeZQ==
X-Received: by 2002:ac8:6757:: with SMTP id n23mr376349qtp.345.1572619542663;
        Fri, 01 Nov 2019 07:45:42 -0700 (PDT)
Received: from localhost (70.44.39.90.res-cmts.bus.ptd.net. [70.44.39.90])
        by smtp.gmail.com with ESMTPSA id 19sm3976066qkg.89.2019.11.01.07.45.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 Nov 2019 07:45:41 -0700 (PDT)
Date:   Fri, 1 Nov 2019 10:45:40 -0400
From:   Johannes Weiner <hannes@cmpxchg.org>
To:     Chris Down <chris@chrisdown.name>
Cc:     Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, kernel-team@fb.com
Subject: Re: [PATCH] kernel: sysctl: make drop_caches write-only
Message-ID: <20191101144540.GA12808@cmpxchg.org>
References: <20191031221602.9375-1-hannes@cmpxchg.org>
 <20191031162825.a545a5d4d8567368501769bd@linux-foundation.org>
 <20191101110901.GB690103@chrisdown.name>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191101110901.GB690103@chrisdown.name>
User-Agent: Mutt/1.12.2 (2019-09-21)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 01, 2019 at 11:09:01AM +0000, Chris Down wrote:
> Hm, not sure why my client didn't show this reply.
> 
> Andrew Morton writes:
> > Risk: some (odd) userspace code will break.  Fixable by manually chmodding
> > it back again.
> 
> The only scenario I can construct in my head is that someone has built
> something to watch drop_caches for modification, but we already have the
> kmsg output for that.
> 
> > Reward: very little.
> > 
> > Is the reward worth the risk?
> 
> There is evidence that this has already caused confusion[0] for many,
> judging by the number of views and votes. I think the reward is higher than
> stated here, since it makes the intent and lack of persistent API in the API
> clearer, and less likely to cause confusion in future.
> 
> 0: https://unix.stackexchange.com/q/17936/10762

Yes, I should have mentioned this in the changelog, but:

While mitigating a VM problem at scale in our fleet, there was
confusion about whether writing to this file will permanently switch
the kernel into a non-caching mode. This influences the decision
making in a tense situation, where tens of people are trying to fix
tens of thousands of affected machines: Do we need a rollback
strategy? What are the performance implications of operating in a
non-caching state for several days? It also caused confusion when the
kernel team said we may need to write the file several times to make
sure it's effective ("But it already reads back 3?").
