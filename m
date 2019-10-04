Return-Path: <SRS0=OvUS=X5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 808AAC4360C
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Oct 2019 16:55:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5840320862
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Oct 2019 16:55:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1570208107;
	bh=MYlohjmEipOc9BPpyskZU2ZRfxEYyGFuRuRsg4Lxnuk=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=qSZz6anOqGGbzENYznrMiJTL7VaNc+MqyF+4p8ByztaQfi82N5uqOuAHLdQKjHOa/
	 6HsmnDuOdSJYyekr3W92lTA3lHyAJRfvYJdSOG50iB0QewM2m9OnTM2YNCGjxDqrJm
	 M/KxaCRuun5BEaIA4JX0L9FWaJ4/Fb6BcbDUvLJo=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730018AbfJDQzG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 4 Oct 2019 12:55:06 -0400
Received: from mail-lf1-f66.google.com ([209.85.167.66]:34171 "EHLO
        mail-lf1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727647AbfJDQzG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Oct 2019 12:55:06 -0400
Received: by mail-lf1-f66.google.com with SMTP id r22so4984460lfm.1
        for <linux-kernel@vger.kernel.org>; Fri, 04 Oct 2019 09:55:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=FrJ0zFRu4R4V+3PxeCLcufXSv3jjR/ayM3x6nxe14uQ=;
        b=Zr8CCOYrhLwg2IJlYUbmrLBubB+LAs47+X7FsJcUYinv3ZCNzplia9GI/omGn9Nnwp
         J95JxEkcdRGDKXb7Lva3O/y0uDib1iXfQ6DVEjqeNehpofny7rhAXvDak088Hh6+0CCm
         WepPxEeusU+YGFBek4shM+8Ydjq7N1s7i0Vtg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=FrJ0zFRu4R4V+3PxeCLcufXSv3jjR/ayM3x6nxe14uQ=;
        b=SbunJqqy075/vtiWSCiMBu9dO7lUS5xXEESE8HnGOV1qFdVWCQthCN1hPxsAbPMQHP
         s2GdqjrZD5HbliBs9pooMQzvBcpti7FKPjeEnGg7IMdW8Mn7N1cT0V4k2QuKMbCT6yYF
         0MBaJCwrcwG2WC2nlApnGDsyRo6wqhOfJiArG73nfKhTUb30mx9neXPBm7m8roCQL97k
         hmkiFR8o0mqKLW3Dhe+lmEPdDvT6p+xv4aFSX9gx8bnDdKAGU6xue/X34UX+sL4wvU5b
         y1/caWDEX3mkohw9xWCnXCpeW4T6Fxr/LXHYwt3V/vZqqyncQcJg1/lBgTh1bW/o5weo
         aqmw==
X-Gm-Message-State: APjAAAWmhw8rpmdeXm792pka7j1XrfK5jnhlRV0Q5UCLITsw+L6kIS8s
        tOQJkl97IaYv+YCFbQTcs4r/Sei4ZaA=
X-Google-Smtp-Source: APXvYqz5o0Dma6ZkFjMsQl6C4d51rvKm8uXX92DMLPsy44iOLGADk2HbHGe20sm10Xg6tBSImM9+fQ==
X-Received: by 2002:ac2:5463:: with SMTP id e3mr9442307lfn.117.1570208102334;
        Fri, 04 Oct 2019 09:55:02 -0700 (PDT)
Received: from mail-lj1-f174.google.com (mail-lj1-f174.google.com. [209.85.208.174])
        by smtp.gmail.com with ESMTPSA id u21sm1488057lje.92.2019.10.04.09.55.01
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 04 Oct 2019 09:55:01 -0700 (PDT)
Received: by mail-lj1-f174.google.com with SMTP id v24so7222712ljj.3
        for <linux-kernel@vger.kernel.org>; Fri, 04 Oct 2019 09:55:01 -0700 (PDT)
X-Received: by 2002:a2e:9241:: with SMTP id v1mr10287406ljg.148.1570208100900;
 Fri, 04 Oct 2019 09:55:00 -0700 (PDT)
MIME-Version: 1.0
References: <20191004140503.9817-1-christian.brauner@ubuntu.com>
 <20191004142748.GG26530@ZenIV.linux.org.uk> <CAHk-=wih7tK-PoRTSUXgarpgR-WA8kN_voiMynQr8eysvPPgfA@mail.gmail.com>
In-Reply-To: <CAHk-=wih7tK-PoRTSUXgarpgR-WA8kN_voiMynQr8eysvPPgfA@mail.gmail.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Fri, 4 Oct 2019 09:54:44 -0700
X-Gmail-Original-Message-ID: <CAHk-=whZUbznC+sdnFz6B5F7E7+ywZgx025u0kEnFk3S_7gFQA@mail.gmail.com>
Message-ID: <CAHk-=whZUbznC+sdnFz6B5F7E7+ywZgx025u0kEnFk3S_7gFQA@mail.gmail.com>
Subject: Re: [PATCH] devpts: Fix NULL pointer dereference in dcache_readdir()
To:     Al Viro <viro@zeniv.linux.org.uk>
Cc:     Christian Brauner <christian.brauner@ubuntu.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Will Deacon <will@kernel.org>,
        Kate Stewart <kstewart@linuxfoundation.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Amir Goldstein <amir73il@gmail.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Varad Gautam <vrd@amazon.de>, stable <stable@vger.kernel.org>,
        Jan Glauber <jglauber@marvell.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 4, 2019 at 9:52 AM Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> Dang, I thought this already got merged. But we only discussed it
> extensively and I guess it got delayed by all the discussions about
> possible fixes for the d_lock contention.

Side note: I'm not all _that_ worried about the d_lock contention
thing, simply because the regression report was from an artificial
benchmark, and it was on a 144-core machine.

Compared to the Oops, it's not really a thing.

            Linus
