Return-Path: <SRS0=rNeM=SR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1AEF7C10F0E
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Apr 2019 16:17:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DBAEC206B6
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Apr 2019 16:17:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1555345051;
	bh=RBOuUaNTslk8PJVfzLMqQgbbyYndZuNwRslgGOMB8W0=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=EkEBIpj8K9esDaeL+HazDZEhZhVGch+V7sM/yCImobkKX4MkYPRUL7RiWCRHxiziP
	 zdGT9MYsNkWKfqaEAt4m+76sg15QF41KbWKyx6r6HMMzSSLq6os8kZPNkFeKqNA7zz
	 JD3yX0Mr1u+FkqlqJbKWHwnKlCT3Um4RZ0eV75qQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727793AbfDOQRa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 15 Apr 2019 12:17:30 -0400
Received: from mail-lj1-f175.google.com ([209.85.208.175]:40909 "EHLO
        mail-lj1-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726034AbfDOQRa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Apr 2019 12:17:30 -0400
Received: by mail-lj1-f175.google.com with SMTP id q66so1138633ljq.7
        for <linux-kernel@vger.kernel.org>; Mon, 15 Apr 2019 09:17:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=bIPBn1U+SX8uD02iY/mmWBCji2/lm4uOVe9yraoEo7o=;
        b=Rc7qx6n5VTgrZU3031/RnX2VNuY4cSqBXxxLOtf8sa4GGy81UrF6cIh23W8HCjbplk
         eei3JXRMEKl88UBMcF12ggFhbCViCFtKDRzEbath5Yr0VuirMta8TVNm5ksL/lQZkU9L
         gDNJ1M+ReVvsXKP7zNx4xxobRNztNHRC10AkI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=bIPBn1U+SX8uD02iY/mmWBCji2/lm4uOVe9yraoEo7o=;
        b=HVRoerkEU0EeshCIMXAaJzF7QVYzEkjOEBiC3bGWqY/5MbddBa9GmRD0ZYF6VGs10W
         lYilkFpblIfmS9dOplU0+bV3O8q3AdUNSvmn7U0oxxTj2VUpOXLD5IKrexKwLLWXT28a
         AqDSrk7dUWzEPUHn45DicqWqHhZxS/nqWht81YQo1UleGy6r7Szr29uDByvMnxPsweTA
         6TL4Z2aPEmKek7uvtzB5/UQds4U71/H1iGzKcabjT9nHw7s55bY7fvmTNnA60Wgk14G5
         iwiodAc1DVno7lgu7fFmUxvAMoZ6lf2Pg2MawwWjWqJsOfGpDjpT2n6h84aq8cgdbCT0
         QILA==
X-Gm-Message-State: APjAAAXQqMIa8zet4kJ9Gy5mOgCBA7UrWlVgpaQfr4wFyLOAb7jVFL2a
        6ytf+2HzZgdLWFDA4jAdX1IE5D9YKwY=
X-Google-Smtp-Source: APXvYqxOinj38jtZawtLtXZTiPWYcERbimd8vqp2ZFraNtPCTiSuy8QCUKm4pUK1u+mZz38JdApSHg==
X-Received: by 2002:a2e:9b48:: with SMTP id o8mr24360483ljj.51.1555345047689;
        Mon, 15 Apr 2019 09:17:27 -0700 (PDT)
Received: from mail-lj1-f180.google.com (mail-lj1-f180.google.com. [209.85.208.180])
        by smtp.gmail.com with ESMTPSA id 77sm10069814ljc.69.2019.04.15.09.17.26
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 15 Apr 2019 09:17:26 -0700 (PDT)
Received: by mail-lj1-f180.google.com with SMTP id f18so16222484lja.10
        for <linux-kernel@vger.kernel.org>; Mon, 15 Apr 2019 09:17:26 -0700 (PDT)
X-Received: by 2002:a2e:88c1:: with SMTP id a1mr14718777ljk.78.1555345046432;
 Mon, 15 Apr 2019 09:17:26 -0700 (PDT)
MIME-Version: 1.0
References: <CAHk-=wjvcuyCQGnfOhooaL1H4H63qXO=xgo+9yncSOG=eK+kbA@mail.gmail.com>
 <20190415051919.GA31481@infradead.org>
In-Reply-To: <20190415051919.GA31481@infradead.org>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Mon, 15 Apr 2019 09:17:10 -0700
X-Gmail-Original-Message-ID: <CAHk-=wj7jgMOVFW0tiU-X+zhg6+Rn7mEBTej+f26rV3zXezOSA@mail.gmail.com>
Message-ID: <CAHk-=wj7jgMOVFW0tiU-X+zhg6+Rn7mEBTej+f26rV3zXezOSA@mail.gmail.com>
Subject: Re: Linux 5.1-rc5
To:     Christoph Hellwig <hch@infradead.org>
Cc:     Linux List Kernel Mailing <linux-kernel@vger.kernel.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        linuxppc-dev@lists.ozlabs.org,
        Martin Schwidefsky <schwidefsky@de.ibm.com>,
        linux-s390 <linux-s390@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Apr 14, 2019 at 10:19 PM Christoph Hellwig <hch@infradead.org> wrote:
>
> Can we please have the page refcount overflow fixes out on the list
> for review, even if it is after the fact?

They were actually on a list for review long before the fact, but it
was the security mailing list. The issue actually got discussed back
in January along with early versions of the patches, but then we
dropped the ball because it just wasn't on anybody's radar and it got
resurrected late March. Willy wrote a rather bigger patch-series, and
review of that is what then resulted in those commits. So they may
look recent, but that's just because the original patches got
seriously edited down and rewritten.

That said, powerpc and s390 should at least look at maybe adding a
check for the page ref in their gup paths too. Powerpc has the special
gup_hugepte() case, and s390 has its own version of gup entirely. I
was actually hoping the s390 guys would look at using the generic gup
code.

I ruthlessly also entirely ignored MIPS, SH and sparc, since they seem
largely irrelevant, partly since even theoretically this whole issue
needs a _lot_ of memory.

Michael, Martin, see commit 6b3a70773630 ("Merge branch 'page-refs'
(page ref overflow)"). You may or may not really care.

                 Linus
