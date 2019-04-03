Return-Path: <SRS0=7x1k=SF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E2478C4360F
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Apr 2019 14:15:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A9B3E2084C
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Apr 2019 14:15:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="WLMqsNwB"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726404AbfDCOPE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 3 Apr 2019 10:15:04 -0400
Received: from mail-yb1-f194.google.com ([209.85.219.194]:46529 "EHLO
        mail-yb1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726084AbfDCOPE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Apr 2019 10:15:04 -0400
Received: by mail-yb1-f194.google.com with SMTP id u15so1806505ybj.13
        for <linux-kernel@vger.kernel.org>; Wed, 03 Apr 2019 07:15:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=pUNm8FbE9mgPJ18ACUFv10ogYAla06jt3nWb68IMWG0=;
        b=WLMqsNwB/T7ldwcjJF2eOa+O4OkR52t6uCiSVfi4dE/Ki7G1kfPyeMhAIfB5GHk8e1
         zKGYa04GxVTyW0LKbHmKprU77dFFgkAYLCrQEEiz8qQkvJpatdqPZstp4FcYgeCpEpAA
         bTWIccSxFKnyJgP5znkPXrf7VYbvjHb6+6MC3jej0WMTtEip+v11zlJxX9Df37LlsLoL
         iKtlt9ZoWpMfWnjHD160itYIorNuK09gfL2n3z+2EW2GVDQGANj6xW24sauSAyeSj8jr
         kjg6LR43bKnTCWiInTF8SC6wVLruk9QQDPtUcQwftRql1akmdevqu3xiYLTQTzZ4JSpA
         GOPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=pUNm8FbE9mgPJ18ACUFv10ogYAla06jt3nWb68IMWG0=;
        b=Cub+fNZx0yzZKOVNoESwaMJOtEQz2IWix7IVAtnHUxPKL5MkYWa5ANabdQ+l+dG61z
         BS/uw2uOv+HbPGSOmZsEkNUWnty9JYpoj9RGoV88f+KgpfRXFZqvy73I9tZDCvJb4Ay9
         vLZQHgq1Woe60VnHqTArVii5+oi5Q8UBQbm2V6SuOQsT7cSSDKTUAeVNv3llmr0td92a
         U7iZQzYCE37OtRnsDYXvTtuapJGVYhbTCfAxXWdqHwcxDO6OCQ0SV4nFBQFLUiyUKsdi
         erarBrKNd6/FblBt2V7t+WM50oZi+p2QJfmbyNKxEdvpsBqV9SK6WKAmg8o2BPpLCswP
         AuGw==
X-Gm-Message-State: APjAAAWBEoCcejkeTDzYa2tMNPErZqTkrC+VNMRFmd9h7h3FmJTtwDo8
        r9kiOHT+5vpz5z1KtAmJ9hdT2uxhdXp1P7P0usraxQ==
X-Google-Smtp-Source: APXvYqxUhlDGoJqNraYB3pdOi4X92Pp4oFDEyOxDdWE8at5/OEQzlkqhTtZywbMjhQbTyy/BR8rsILCX917sYXH1hjQ=
X-Received: by 2002:a25:1254:: with SMTP id 81mr69050ybs.237.1554300902929;
 Wed, 03 Apr 2019 07:15:02 -0700 (PDT)
MIME-Version: 1.0
References: <20190403134915.6616-1-olivier.tilmans@nokia-bell-labs.com>
In-Reply-To: <20190403134915.6616-1-olivier.tilmans@nokia-bell-labs.com>
From:   Eric Dumazet <edumazet@google.com>
Date:   Wed, 3 Apr 2019 07:14:51 -0700
Message-ID: <CANn89iJzTNjnABOxELHJG8Ub8-Oj0GzubvdN17scRfoegTNWbg@mail.gmail.com>
Subject: Re: [PATCH net-next] tcp: Accept ECT on SYN in the presence of RFC8311
To:     "Tilmans, Olivier (Nokia - BE/Antwerp)" 
        <olivier.tilmans@nokia-bell-labs.com>
Cc:     Bob Briscoe <research@bobbriscoe.net>,
        "De Schepper, Koen (Nokia - BE/Antwerp)" 
        <koen.de_schepper@nokia-bell-labs.com>,
        "David S. Miller" <davem@davemloft.net>,
        Alexey Kuznetsov <kuznet@ms2.inr.ac.ru>,
        Hideaki YOSHIFUJI <yoshfuji@linux-ipv6.org>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 3, 2019 at 6:49 AM Tilmans, Olivier (Nokia - BE/Antwerp)
<olivier.tilmans@nokia-bell-labs.com> wrote:
>
> Linux currently disable ECN for incoming connections when the SYN
> requests ECN and the IP header has ECT(0)/ECT(1) set, as some
> networks were reportedly mangling the ToS byte, hence could later
> trigger false congestion notifications.
>
> RFC8311 =C2=A74.3 relaxes RFC3168's requirements such that ECT can be set
> one TCP control packets (including SYNs). The main benefit of this
> is the decreased probability of losing a SYN in a congested
> ECN-capable network (i.e., it avoids the initial 1s timeout).
> Additionally, this allows the development of newer TCP extensions,
> such as AccECN.
>
> This patch relaxes the previous check, by enabling ECN on incoming
> connections using SYN+ECT if at least one bit of the reserved flags
> of the TCP header is set. Such bit would indicate that the sender of
> the SYN is using a newer TCP feature than what the host implements,
> such as AccECN, and is thus implementing RFC8311. This enables
> end-hosts not supporting such extensions to still negociate ECN, and

nit : negotiate

> to have some of the benefits of using ECN on control packets.
>
> Signed-off-by: Olivier Tilmans <olivier.tilmans@nokia-bell-labs.com>
> Suggested-by: Bob Briscoe <research@bobbriscoe.net>
> Cc: Koen De Schepper <koen.de_schepper@nokia-bell-labs.com>
> ---


LGTM,  thank you.

Signed-off-by: Eric Dumazet <edumazet@google.com>
