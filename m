Return-Path: <SRS0=HHJ+=YV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BFCBDCA9EC0
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Oct 2019 12:28:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 93CBA208C0
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Oct 2019 12:28:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1572265680;
	bh=Dy4kNkqAc5FB3Uxpoin/0kwgXwhVB0Cp5tDuaZ5XN0I=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=LkeFyz31x/8In/ZbcquDxF0fZqHa6+9kkz6ExAnQSxFcaapfY9BRSV4hkI4Ao7jDA
	 tORZXqbpgNhohdA+9cwlxSHsZYR4K9HiEv8bufcdC+qeNvw2+l7q6fzo5y9CSdErkP
	 Ahg6Z57pA2ueukOmWvqquugZxrJLpTQWelQotpUo=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389059AbfJ1M17 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 28 Oct 2019 08:27:59 -0400
Received: from mail-lf1-f65.google.com ([209.85.167.65]:40376 "EHLO
        mail-lf1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727451AbfJ1M17 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Oct 2019 08:27:59 -0400
Received: by mail-lf1-f65.google.com with SMTP id f4so1648434lfk.7
        for <linux-kernel@vger.kernel.org>; Mon, 28 Oct 2019 05:27:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=lGx03eBCF/ZR/TJOysj+IjW5mFyYp/9PThI32ukvUbA=;
        b=TlTg/tPa+Cb2+B62nozWpbPUhV8ULgTksO+p1fl72Kr55S79U99txmRCJ60LBlWifg
         3f15B172AD36UWaHBr3vrgBAc9IpQ2hR+Y793XsAT5c3FmiBK+BJ3mLyHFGO7kplB+ms
         x7VgD3i+NS30ikRDRUeMZ55lKRiyMQEhf4pU8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=lGx03eBCF/ZR/TJOysj+IjW5mFyYp/9PThI32ukvUbA=;
        b=p38Z0W25EypdpZOyvUlDjYnllUxNWVv4aoBEPN9ZF91LOYaobx8S6F/swX2tQL57RD
         RX8aUcjoZSS7egWCXDa5wu7FRbV4XiKOZmss3M7OoSSv0xVYEogRjNrr3GfxryUPrsf8
         cPbIs2eMglKq4iOJx2ppzbODvDwEI6ZL24XSyqWVxmnfqBpIkCJPT8bJj8OwneAGtzEU
         C7wglMztXSd84EZnbUleOpG79cO2zd5jSdMzWYn/Mmi0OzyQQN2+ouT+x8OQr3C6/Idk
         i24otYL+v5opz2gpz9/5GHURUmub1Kwff8JL2pA50va6Akk/cUqnDJizbZatJeGBCZr7
         jckg==
X-Gm-Message-State: APjAAAXahifQ63gUhQf6cK9SbirvijSViJJEYf9E+buSKWk/PE15KZod
        gHXt+s6OoEthsXcxHIvBhGDg+GZQsGQ1DA==
X-Google-Smtp-Source: APXvYqxw5z+G6SP3WexCa4LZ7XJC9/YWv2kZd0YZfAgN+mAV/wjiJ4vJOZRTsYV5Fh/d3x6y4DBD2w==
X-Received: by 2002:ac2:5b42:: with SMTP id i2mr11478590lfp.164.1572265676379;
        Mon, 28 Oct 2019 05:27:56 -0700 (PDT)
Received: from mail-lj1-f179.google.com (mail-lj1-f179.google.com. [209.85.208.179])
        by smtp.gmail.com with ESMTPSA id e14sm5243773ljb.75.2019.10.28.05.27.48
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 28 Oct 2019 05:27:50 -0700 (PDT)
Received: by mail-lj1-f179.google.com with SMTP id u22so11115043lji.7
        for <linux-kernel@vger.kernel.org>; Mon, 28 Oct 2019 05:27:48 -0700 (PDT)
X-Received: by 2002:a05:651c:154:: with SMTP id c20mr4826222ljd.1.1572265668380;
 Mon, 28 Oct 2019 05:27:48 -0700 (PDT)
MIME-Version: 1.0
References: <157225848971.557.16257813537984792761.stgit@buzz>
In-Reply-To: <157225848971.557.16257813537984792761.stgit@buzz>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Mon, 28 Oct 2019 13:27:32 +0100
X-Gmail-Original-Message-ID: <CAHk-=wiCDPd1ivoU5BJBMSt5cmKnX0XFWiinfegyknfoipif0g@mail.gmail.com>
Message-ID: <CAHk-=wiCDPd1ivoU5BJBMSt5cmKnX0XFWiinfegyknfoipif0g@mail.gmail.com>
Subject: Re: [PATCH RFC] fs/fcntl: add fcntl F_GET_RSS
To:     Konstantin Khlebnikov <khlebnikov@yandex-team.ru>
Cc:     linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Linux-MM <linux-mm@kvack.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux API <linux-api@vger.kernel.org>,
        Michal Hocko <mhocko@suse.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Roman Gushchin <guro@fb.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 28, 2019 at 11:28 AM Konstantin Khlebnikov
<khlebnikov@yandex-team.ru> wrote:
>
> This implements fcntl() for getting amount of resident memory in cache.
> Kernel already maintains counter for each inode, this patch just exposes
> it into userspace. Returned size is in kilobytes like values in procfs.

This doesn't actually explain why anybody would want it, and what the
usage scenario is.

             Linus
