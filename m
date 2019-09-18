Return-Path: <SRS0=HfRD=XN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1C700C4CEC9
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Sep 2019 19:03:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E6FB2222C6
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Sep 2019 19:03:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1568833423;
	bh=MVIkVs+UxQG8k163I4kCBuRT8zMWpUxjkZoWM4RnpiY=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=F7WLBqXGESDq0mhjYxF+oekGRMDusILLdu/yVnQTnhQVQBRTnNfFoae13GfpzYeTu
	 JRcULucSp1Tuqr7nxDZit14+Jc2KZWGb1Xpi1QQ9WXKkArl2aJ+6mcKVz/2yH3ic/d
	 Ys52mXnb6t7bjbTTphe5+94BoeV/cQGlvAumBv+g=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388901AbfIRTDm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 18 Sep 2019 15:03:42 -0400
Received: from mail-lf1-f67.google.com ([209.85.167.67]:38461 "EHLO
        mail-lf1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725899AbfIRTDl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Sep 2019 15:03:41 -0400
Received: by mail-lf1-f67.google.com with SMTP id u28so471108lfc.5
        for <linux-kernel@vger.kernel.org>; Wed, 18 Sep 2019 12:03:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=FIxcmAv8Po+czY66H7vvvtaXyWmCwGyyWI4O3j01+mA=;
        b=EsmVEzq19JVOk1cxULtjZcJs4Iioe/J/ot0dhBe+67+Wr5xqdgNOOOV43ylIRXSwPW
         RWYcYMVP0sfHCohLpBDidM7I6SBijQg1LVQ/B/7pSoAc+t/JKz6Z5HSOR4oP8Q04+rwA
         ANqiISTCEEC4qcWcXT0n988u0ONPsMOZrgrd0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=FIxcmAv8Po+czY66H7vvvtaXyWmCwGyyWI4O3j01+mA=;
        b=UAMD/HY4CtwSCCzsS8jpzHaeiMmw8WoSTBcVAsmxTwyKIqSEVM/Wg0NXxM9TfZjrGT
         nV7ibNuwbt2/u+JkByTEv7RuzwL9+BpLS3sOn18wj3zPUjN1jN+RmNGrRmt7cdqvErqR
         qRqtwVfjq79+wNfyj33nBm1A8LGQD/MZQY6J9L+iBCeyFjMtekqrOJGIFXj9F+er995I
         sEd5qzndBOSbCHOitTy/fcLk9KNEAn8g4ma0UV9g7jvJvrjHEv6PFG47VyLdEM+rKN03
         c55Mpz4aOGG0blbNS0/Jnoh/ZhW5dRTP/hfieuE76/6rQ4iqQhVxuwBgFj2ZzNEeSJvZ
         cSZg==
X-Gm-Message-State: APjAAAWh/ycMpcbtVS6jcxj72BA+KJhpGYlRVZDv9eiMD25nlTKxm46G
        nrD/AGzI4hdDmcNundSAYNCqZyG6oj4=
X-Google-Smtp-Source: APXvYqxBettAUpqFmgvV8LvNVZiuylgOx0yFFKgPNTypiYmeqgWPfpHV9ptxydOQEp2gw2veVg2JFA==
X-Received: by 2002:a19:ee02:: with SMTP id g2mr2886896lfb.113.1568833419573;
        Wed, 18 Sep 2019 12:03:39 -0700 (PDT)
Received: from mail-lj1-f182.google.com (mail-lj1-f182.google.com. [209.85.208.182])
        by smtp.gmail.com with ESMTPSA id o18sm1128114lfb.25.2019.09.18.12.03.34
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 18 Sep 2019 12:03:39 -0700 (PDT)
Received: by mail-lj1-f182.google.com with SMTP id l21so1041606lje.4
        for <linux-kernel@vger.kernel.org>; Wed, 18 Sep 2019 12:03:34 -0700 (PDT)
X-Received: by 2002:a2e:8943:: with SMTP id b3mr3094106ljk.165.1568833413723;
 Wed, 18 Sep 2019 12:03:33 -0700 (PDT)
MIME-Version: 1.0
References: <20190918170952.GT2596@sirena.co.uk> <20190918185257.GC1933777@kroah.com>
In-Reply-To: <20190918185257.GC1933777@kroah.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Wed, 18 Sep 2019 12:03:17 -0700
X-Gmail-Original-Message-ID: <CAHk-=whreYmsU_AQtzDS5gd3yamYJ72gBo+YekYSyJLPQ1Qo-A@mail.gmail.com>
Message-ID: <CAHk-=whreYmsU_AQtzDS5gd3yamYJ72gBo+YekYSyJLPQ1Qo-A@mail.gmail.com>
Subject: Re: linux-next: build failure after merge of the driver-core tree
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     Mark Brown <broonie@kernel.org>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Wolfram Sang <wsa@the-dreams.de>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        linux-i2c@vger.kernel.org,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 18, 2019 at 11:53 AM Greg KH <gregkh@linuxfoundation.org> wrote:
>
> On Wed, Sep 18, 2019 at 06:09:52PM +0100, Mark Brown wrote:
> >
> > After merging the driver-core tree, today's linux-next build
> > for arm64 allmodconfig failed like this:
>
> Wait, I thought Linus said this fixup was now resolved.  What went
> wrong?

I think this is purely a linux-next build failure.

I do full allmodconfig builds between each merge I do, and what
happened is that as part of the LED merge, I removed the
no-longer-used 'i2c_acpi_find_match_adapter()' to resolve that build
warning.

Then linux-next presumably merged my tree with the driver-core tree,
and that re-instated the use of i2c_acpi_find_match_adapter() - which
was now gone.

But when *I* merged the driver-core tree, I did the merge fixup
correctly to actually re-instate not only the use, but also re-instate
the removed function that now had a use again.

> Linus, should I submit a fix for this?

My tree should be fine, and I really think this is just a temporary
linux-next effect from the above. I think linux-next only handled the
actual syntactic conflicts, not the semantic conflict of "function had
been removed to avoid build error from previous merge, and needed to
be brought back"

Knock wood.

              Linus
