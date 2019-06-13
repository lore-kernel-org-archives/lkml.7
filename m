Return-Path: <SRS0=5wok=UM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 766ECC31E45
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Jun 2019 15:16:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4A4AF21743
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Jun 2019 15:16:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=semihalf-com.20150623.gappssmtp.com header.i=@semihalf-com.20150623.gappssmtp.com header.b="iCcOgYbW"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387703AbfFMPQN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Jun 2019 11:16:13 -0400
Received: from mail-vs1-f52.google.com ([209.85.217.52]:46522 "EHLO
        mail-vs1-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732214AbfFMNXx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Jun 2019 09:23:53 -0400
Received: by mail-vs1-f52.google.com with SMTP id l125so12572842vsl.13
        for <linux-kernel@vger.kernel.org>; Thu, 13 Jun 2019 06:23:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=semihalf-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=IpdX1rIhn/1Lk8TZ4g/8IVbNpyTArq72nZxCv7jiCEo=;
        b=iCcOgYbWClI74T8LsWilhPOboTshwxc7nWtBvvK8Z7ywJ/r+FATaJHnGW4MyMnvh4y
         jUk7j+7+CY44jsMrY3m5tGIRuT67dJ6MwiEBmUW2puE+7W8OGkW6NyYnJjz8Wfu57MF9
         tr5iFsez+1s52JVknUcrrcublDgoBc03Sv0dTTzYZMicYz6pQjqYUb82KCRNuG9SRLtl
         2RSzBD+X98xoNhqjtPtg/L4mDXicIA6OpG3eJwUST9rSNzXbmMyWUp6pNf0wiZvKnwW2
         DvxHyhE6zon70y/pcwFSJAFmGr/DEXc5Zp7XyutonkaJmcBVo1bJp1otzRo6lOT0Qrwm
         6izA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=IpdX1rIhn/1Lk8TZ4g/8IVbNpyTArq72nZxCv7jiCEo=;
        b=XCkvMmC+DruCaaBuVU+VreJEQgKRrZgxbG7o8eEjbA2nkjKSbsZvgzXGiYFdGJGR0J
         xuLxurPDz4wPD9u2tZDUxAODUxckObwzP3R2vcj2RuEIetKT9wn76XgFYWXmzvRHUFGB
         iuYwLLpn2Jytm/+bCAZ4cFPyn+RdZlA3oj6/7qy9lf/HTHpbIq10MgqkZXvcB1X1Yf5O
         hFMuvsbvIn8OEjw9RPboDhDLO0g63Kz5bAI0Ob+IvBWqnvAa39l+/gwI29X0eSRI5P4u
         xe6Tca5f1njJLP594c/z3auoRNlrYKk0row6XrE8nYr5Ved58/6GoPIE2/4Tc0cJAdkg
         n+Pw==
X-Gm-Message-State: APjAAAXtp6Spu28+zeStgYM1gFEEvxds5kvaDx+R5GN9ljkoQEMdKdJc
        xvxy1rX46Fi+pDo1lsoZmWNDeeuv8zqKZsNQNR5n+A==
X-Google-Smtp-Source: APXvYqwN8czoMioCoFYKKJ0HxRg3Skkt2+83tzAgsp1qG20DYQ44UvNFXUtP89dTXn1ua69Avn0x1vk4+P+YzCnp5ek=
X-Received: by 2002:a67:f795:: with SMTP id j21mr996812vso.226.1560432232846;
 Thu, 13 Jun 2019 06:23:52 -0700 (PDT)
MIME-Version: 1.0
References: <20190611125904.1013-1-cai@lca.pw> <CAK8P3a1rK79aj38H0i9vnzeycv6YZ0iUhBFz4giAFc7COTnmWQ@mail.gmail.com>
 <CABLO=+kZnpBm8W9MmSkSf=18R5fLMFe65+_YWw1-of46B+B1dA@mail.gmail.com> <CAK8P3a1xhaxBc+N=VXRDZyjUQ+W+=fkeDTUcZqeorsyDCTewZg@mail.gmail.com>
In-Reply-To: <CAK8P3a1xhaxBc+N=VXRDZyjUQ+W+=fkeDTUcZqeorsyDCTewZg@mail.gmail.com>
From:   Bartosz Szczepanek <bsz@semihalf.com>
Date:   Thu, 13 Jun 2019 15:23:42 +0200
Message-ID: <CABLO=+kNiyLZ5gcSLwGtrXPpnWjutLpaAgE8D0rWGLmkJ15PtA@mail.gmail.com>
Subject: Re: [PATCH -next] efi/tpm: fix a compilation warning
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     Qian Cai <cai@lca.pw>, Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Matthew Garrett <mjg59@google.com>,
        linux-efi <linux-efi@vger.kernel.org>,
        Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 13, 2019 at 2:40 PM Arnd Bergmann <arnd@arndb.de> wrote:
>
> Would it be correct to change that to 'false' then (or completely remove
> the additional remap, given that the other two callers pass false
> already) and pass final_tbl?

The problem is that we don't know the final_tbl size before running
tpm2_calc_event_log_size on it, so we cannot map it's entire content.
Only table header is mapped at the beginning.

After size of entire table is calculated it can be mapped as a whole
and no additional remap is needed, hence the calls with do_mapping =
false.
