Return-Path: <SRS0=TKbG=UN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DFC91C31E4B
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Jun 2019 20:57:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A9C99217F9
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Jun 2019 20:57:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="X0jCDx7F"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726993AbfFNU5p (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Jun 2019 16:57:45 -0400
Received: from mail-pl1-f195.google.com ([209.85.214.195]:40568 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725809AbfFNU5n (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Jun 2019 16:57:43 -0400
Received: by mail-pl1-f195.google.com with SMTP id a93so1471018pla.7
        for <linux-kernel@vger.kernel.org>; Fri, 14 Jun 2019 13:57:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Crq0nDZF9tOeX0bWwwm0JRIq5ybVrhhnr25YAZ6ufIk=;
        b=X0jCDx7F0SrYSQdEhdgb8qtSIoOnS+O7rIM5pCHI2fzNeLRWb108SwXatySqbdvLpu
         31wimHCq0BfcZCJIuWKv72X85SwLepwhMHxfqweuLbERfguUyRKocQW8zk+uteukHNJJ
         qYg7rZeaw8z2Nq9dskFhmlQWvR64rxNvdGmqqOIgm5WjjET3HzwOk4D7Px/2kN+IdBMH
         nT/IyyZbK7+X0ShOX+WB4iH4XGr+dZjq7477rgnyrCOYUAsjN8thUGBFtvJAA2P87JJA
         p5ntvIPO26V2ikr3/Qn3nEpT3oRhNTYmOL5QJvq17c5XUSfrQ28D81lxnUgl0FCa7AXm
         pgrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Crq0nDZF9tOeX0bWwwm0JRIq5ybVrhhnr25YAZ6ufIk=;
        b=N97CDEXvOjmf/RFd7QHBgTivvWTGzGpW7VfP4bAY3Dh0kHjCkRUrk9yw3gB4IsDzGm
         tAZGuXgkxdeEC8gAGLj7B5DPDDA0XDJWDKMKZA2IW/MQFI+SnL359Fxa5gzjg13wikwV
         seAU/YQ/miSqXEqFtLlG+Eom34syUI5keuduP1TJs+il3BY8hN83eQgvYfQD9tdYuNDU
         4EmFDmqw2dtZm8QfgStoX7ONDkLBel1CpLy1cLnaNqSGc3qmWbwiD+ekEy8k85x6W9ia
         Rm4S2LuNYII1w8WemwMFtFCSKgjtpaZk5erlXttwe/wWbLGjXe4XSNjuQUPz+DwE1PkK
         8EhQ==
X-Gm-Message-State: APjAAAUlnAcGOS5ECGviZ+Y9Wl6XVgitKALcpppZBKLvQV8BuD9DxqM6
        Kk0MH8vJpcCOfDjxdLbF3UVV9h679dRyJYymW0bS3g==
X-Google-Smtp-Source: APXvYqwc12Gjg3q9skOSADw86B+Ig7PVBJGMfmcIkBRi2fZRrjHVaP8V/as5dS2/3dv3WOPL1q50QL9DYJC3q6qfCg8=
X-Received: by 2002:a17:902:b696:: with SMTP id c22mr91154189pls.119.1560545862866;
 Fri, 14 Jun 2019 13:57:42 -0700 (PDT)
MIME-Version: 1.0
References: <20190614171713.89262-1-nhuck@google.com> <CAKwvOd=jFYn=7NGPD8UDx3_g30qD+40bCjzmWJJSzmb6pNUusQ@mail.gmail.com>
In-Reply-To: <CAKwvOd=jFYn=7NGPD8UDx3_g30qD+40bCjzmWJJSzmb6pNUusQ@mail.gmail.com>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Fri, 14 Jun 2019 13:57:31 -0700
Message-ID: <CAKwvOdnrvfthPcmnducqyOpbkFAQq+25eDXgehf_aWMAG=7CRg@mail.gmail.com>
Subject: Re: [PATCH] wl18xx: Fix Wunused-const-variable
To:     Nathan Huckleberry <nhuck@google.com>, eliad@wizery.com,
        arik@wizery.com
Cc:     Kalle Valo <kvalo@codeaurora.org>,
        "David S. Miller" <davem@davemloft.net>,
        linux-wireless@vger.kernel.org, netdev@vger.kernel.org,
        LKML <linux-kernel@vger.kernel.org>,
        clang-built-linux <clang-built-linux@googlegroups.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 14, 2019 at 1:54 PM Nick Desaulniers
<ndesaulniers@google.com> wrote:
> Looking at drivers/net/wireless/ti/wl18xx/main.c, there 4 globally
> declared `struct ieee80211_iface_limit` but as your patch notes, only
> 2 are used.  The thing is, their uses are in a `struct
> ieee80211_iface_limit []`.

Sorry, that's not quite right; it's not a  `struct
ieee80211_iface_limit []` but a `struct ieee80211_iface_combination
[]`.  No idea what other values we'd put to add these limits to the
array.
-- 
Thanks,
~Nick Desaulniers
