Return-Path: <SRS0=G0tX=VI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 261A9C31E41
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Jul 2019 17:07:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F32BB21537
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Jul 2019 17:07:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1562864862;
	bh=qPkVmYk3A9TPP0SwRw+m20d8TNwY50bShhzMBCl7dT4=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=uVqS1If8d9jg19esYj3loHQquCLJwiS3faRM+f1dJWqGNaczS30Cke+oLY587U0Ua
	 wGEd7Ld7JolJloSra8nawxYf627iWi76tjl1lCw7frrvEhx4+xmUV9VCOrFht3Cdsw
	 lX8tgBG7FQ3tPc2GdnlJgSOqWkZ+731LZRH7fDRE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728845AbfGKRHk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 11 Jul 2019 13:07:40 -0400
Received: from mail-lj1-f193.google.com ([209.85.208.193]:35865 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726213AbfGKRHk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Jul 2019 13:07:40 -0400
Received: by mail-lj1-f193.google.com with SMTP id i21so6541297ljj.3
        for <linux-kernel@vger.kernel.org>; Thu, 11 Jul 2019 10:07:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=GmsM4rcAyqRmAgN7blbW8gwoy8S9te43rhm58w9v33o=;
        b=SkSpsFg2+drWvcG0Nk80SPYN6DHF2p5nwZ5uYWyaFd4ho/itNExezNV+wlYumB7OUo
         AZ8CIqzbymtTlVeYV3C73n55FbCqBuMajfNV9lStamc3as5kA/G0PBduIsCYYWOm2w55
         rdSM4YnG+chaMIpj5Xu3L9qinXRgTE3ovDAyU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=GmsM4rcAyqRmAgN7blbW8gwoy8S9te43rhm58w9v33o=;
        b=nwHJi9SMxWIW03Bobo7j33rwJkwT/kVZ03Q84DMnt5pbHKGwrhRGRH600kh07LYNBD
         pDvw6yJCB4vNX2tqcY3mPhvfZPgsYklMnLEWH3rb0SoJShnAtlA+/q3Rr5UR2stCaO9y
         SOzfaV8s3ax6Z0lfgyPmbvooy8ds0fyYI/8ucYifMAR6vUrjxuQbrp4+YoUJ3+k+0df6
         3Qrt3JS3kDP95VcgKNs3WHhqQ0DP4Sf5Temt4dmg+ughGTdTbDStE762y+UHSKlrNOqL
         VCCZg7hc2YDEu0KLcVIBeiwJFMXl+j++FpssfECC7tAVlexOkZDZF9ts7a8KLkJhaMKx
         RDhA==
X-Gm-Message-State: APjAAAW/Un82HDQxwWju/dtN6bmkhlrBmeHBqo4tR740JeTQbUVX7L4M
        7BR1Zqs4Pm6AUm3mwsTiZxr2BLw8owc=
X-Google-Smtp-Source: APXvYqx5mYvL8HHqBfvLpSCnjGKr0uo1bpkPtwsT93rcLd+KxDVWOiyrAe27+T4ibXBRRUv0/LlDWA==
X-Received: by 2002:a2e:9192:: with SMTP id f18mr3184675ljg.52.1562864858249;
        Thu, 11 Jul 2019 10:07:38 -0700 (PDT)
Received: from mail-lj1-f181.google.com (mail-lj1-f181.google.com. [209.85.208.181])
        by smtp.gmail.com with ESMTPSA id 63sm1083808ljs.84.2019.07.11.10.07.37
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
        Thu, 11 Jul 2019 10:07:37 -0700 (PDT)
Received: by mail-lj1-f181.google.com with SMTP id i21so6541211ljj.3
        for <linux-kernel@vger.kernel.org>; Thu, 11 Jul 2019 10:07:37 -0700 (PDT)
X-Received: by 2002:a2e:9b83:: with SMTP id z3mr3081430lji.84.1562864856938;
 Thu, 11 Jul 2019 10:07:36 -0700 (PDT)
MIME-Version: 1.0
References: <20190708150042.11590-1-christian@brauner.io> <CAHk-=wg0jcyTO+iXgP-CpNwvJ4mTCcg3ts8dLj3R5nbbonkpyQ@mail.gmail.com>
 <20190711053428.ofapcx7nn5xkyru4@brauner.io> <20190711134552.jvahfwhvaxykbgfl@brauner.io>
In-Reply-To: <20190711134552.jvahfwhvaxykbgfl@brauner.io>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Thu, 11 Jul 2019 10:07:20 -0700
X-Gmail-Original-Message-ID: <CAHk-=wincfPnFxQyiFDJLpNH3gNfUgabeAygN6D3dKXHHaqqjg@mail.gmail.com>
Message-ID: <CAHk-=wincfPnFxQyiFDJLpNH3gNfUgabeAygN6D3dKXHHaqqjg@mail.gmail.com>
Subject: Re: [GIT PULL] clone3 for v5.3
To:     Christian Brauner <christian@brauner.io>
Cc:     Linux List Kernel Mailing <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 11, 2019 at 6:45 AM Christian Brauner <christian@brauner.io> wrote:
>
> Just in case you prefer pulling from a __rebased__ tree. I prepared one.

No, I'd much rather just resolve the conflict.  I just wanted to know
what the deal was with the number confusion.

I'll make it use 435, we can sort out openat2 and close_range() when
those happen.

                  Linus
