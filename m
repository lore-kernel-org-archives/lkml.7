Return-Path: <SRS0=Z4g5=TY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EE9EAC072B5
	for <linux-kernel@archiver.kernel.org>; Fri, 24 May 2019 18:14:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C4C0021773
	for <linux-kernel@archiver.kernel.org>; Fri, 24 May 2019 18:14:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1558721662;
	bh=Z5yIdYPBr2uYptiD3xTtbNFREEjI6EGuFwwuNPRJeVw=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=rE7kAc798RmTW8gblPntftnnsbSBQpDJcRZYBXq7VOMQWZTvISIxX5zAOZnFm3XyO
	 NKFjkPzHNaM93SO/1fup7jJxx+1S1w4H/WdnkMigAFjgCkskTlijsbK27hR/cgCCDo
	 kZ6xEFjxN2gaxBAi4UCGy8S5/TZC3sCQkmh1Wv+c=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732009AbfEXSOV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 24 May 2019 14:14:21 -0400
Received: from mail-lj1-f171.google.com ([209.85.208.171]:41989 "EHLO
        mail-lj1-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726869AbfEXSOV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 May 2019 14:14:21 -0400
Received: by mail-lj1-f171.google.com with SMTP id 188so9440682ljf.9
        for <linux-kernel@vger.kernel.org>; Fri, 24 May 2019 11:14:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=bIjvbQLlIrvH0GkOrRU/ujQeMT7aIpjmBN8uZ5WVxIs=;
        b=gINgXP+G8oc/A47aczfcZ3q8Xw/DOlT3ExOsPCRSvhzO5Hx1kKfI0jnLCCsZ70oryh
         K3Zbnh7yXImgAN2CawESNUxJYm++7llqA8GQ4i0/Fla/GnTeNrREJ84KnXop8G3eB3BW
         28GEEEzt4NWKXsuTLK6vHm2DcD9FVDAQ4iQiU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=bIjvbQLlIrvH0GkOrRU/ujQeMT7aIpjmBN8uZ5WVxIs=;
        b=nZLl0b3NVU8robX4bXjMsm2IwJZ/sbyhajQbmJj+gsHugyo3ivsPvE0PWHqHlsYW9M
         BfZ8IIiRm0pUvN44Rp3BJ6I/WCDtrBf8Qy1av9pecC5TS0iEKC4LifQkjTMNFCMxTzeD
         UGR+Wj3cotbJGl7UqsK/VJBzrggd7Szh3U3n69kmNG1n1sE0yvR8/qyoVWRNHkueFuxX
         yXUwel3k9bCbI0IIwgwUf/rEOvlayo6sEn0cYMZnXFRRJKu7oYe9KowUny+3gAHE6hZ6
         DSWm6OwM+6LQYajJJjK0CFSjCH9HsEqYFrKkuYO7ahgCgGCynonxaXBnu3ZfXfB9nxMM
         DQGw==
X-Gm-Message-State: APjAAAV2X6Q7eOKqa53MembT1YHjaUMCk1zi0TgCgKZMngwE3lPvtlut
        X8bp8avUt3RWzjwvpJIJleuPogr/wNY=
X-Google-Smtp-Source: APXvYqzt25F1HxPA+VK06/isHs2Comqjne3raM4zijdKl/5GtMi+zsK4nvDsf3lG3E/lX3363lSNxQ==
X-Received: by 2002:a2e:7411:: with SMTP id p17mr6009408ljc.24.1558721659207;
        Fri, 24 May 2019 11:14:19 -0700 (PDT)
Received: from mail-lj1-f176.google.com (mail-lj1-f176.google.com. [209.85.208.176])
        by smtp.gmail.com with ESMTPSA id v14sm740281lfb.50.2019.05.24.11.14.18
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 24 May 2019 11:14:18 -0700 (PDT)
Received: by mail-lj1-f176.google.com with SMTP id q62so9456563ljq.7
        for <linux-kernel@vger.kernel.org>; Fri, 24 May 2019 11:14:18 -0700 (PDT)
X-Received: by 2002:a2e:9ad1:: with SMTP id p17mr18691595ljj.147.1558721657957;
 Fri, 24 May 2019 11:14:17 -0700 (PDT)
MIME-Version: 1.0
References: <20190524174357.GC9120@fuggles.cambridge.arm.com>
In-Reply-To: <20190524174357.GC9120@fuggles.cambridge.arm.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Fri, 24 May 2019 11:14:02 -0700
X-Gmail-Original-Message-ID: <CAHk-=wijeJ5OjswsUkm0Fns=0kd7kgRo98uPsJE3HQfwP5mBRA@mail.gmail.com>
Message-ID: <CAHk-=wijeJ5OjswsUkm0Fns=0kd7kgRo98uPsJE3HQfwP5mBRA@mail.gmail.com>
Subject: Re: [GIT PULL] arm64: Second round of fixes for -rc2
To:     Will Deacon <will.deacon@arm.com>
Cc:     Linux List Kernel Mailing <linux-kernel@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Only tangentially relevant to this pull request:

On Fri, May 24, 2019 at 10:44 AM Will Deacon <will.deacon@arm.com> wrote:
>
> - Add workaround for Cortex-A76 CPU erratum #1463225
> - Handle Cortex-A76/Neoverse-N1 erratum #1418040 w/ existing workaround

could you perhaps talk to somebody inside ARM about making the errata
documentation publicly available?

I'm not sure why it seems to want an account at arm.com, and as a
result some pretty fundamental development tools ("let me google
that") don't work.

                 Linus
