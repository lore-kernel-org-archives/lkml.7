Return-Path: <SRS0=BZT9=SS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 546AEC10F13
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Apr 2019 10:03:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 21C3620857
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Apr 2019 10:03:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=netronome-com.20150623.gappssmtp.com header.i=@netronome-com.20150623.gappssmtp.com header.b="Nti0bOcb"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728901AbfDPKDd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Apr 2019 06:03:33 -0400
Received: from mail-it1-f196.google.com ([209.85.166.196]:40210 "EHLO
        mail-it1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727087AbfDPKDd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Apr 2019 06:03:33 -0400
Received: by mail-it1-f196.google.com with SMTP id k64so7929849itb.5
        for <linux-kernel@vger.kernel.org>; Tue, 16 Apr 2019 03:03:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=netronome-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=yhDtyQoSJ3tyg8z89rzj2+Qc8h2/+Tz132ENxHsAGdE=;
        b=Nti0bOcbL31zRtOhWbkpHxeWOog55S5O5zLCJ880KLzmfm9zvYTUWPvtHflyUNfZQX
         qhcZ5FjGQscWnvL0nLgrjaFE/U7A5b22vpXDImD7pWiL+naYUT9K0DXR8u/oin3jT20/
         GhW1t5EnRQ1aQEdvVEeeZrdamnwP7WmzyajxEVZIiieNY7LQiSZv8h4ethXp7EBWHmMw
         pnSx2ANQbU+WxvEXsCcpCuHKA64quo0ZFpgLtO3Wp2hu8uklVcOXwyjdA6/ozdbHW41c
         d0LS2oSqRCcUwIrcZ0G9sZ6bLWnEDYzwBaIcVEKNedIio14ps2ujrDlPpriPUL7F88p9
         10tg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=yhDtyQoSJ3tyg8z89rzj2+Qc8h2/+Tz132ENxHsAGdE=;
        b=nR/CrCS7w+5mNydQj01j3kjmcPdsFiuDfONWT24Y5heH5uDruF+w8xddF/jX7jvI2d
         23kwJRbye1UUVQF98OjB01MxIt/ItMmbSjvSV6LqotEFiHC3j+jpT3q12b1mbul4oQ6N
         lMlWRZpP196xg7aSTgmCF6RDvI0jb6sSMkuQfVSrMK0y4TlhVltUzu2gC/0sCjIk7W9/
         tMf1XIowuytLKCCzFVyOj9yJKdNwmWAuAa5/pvjyhX+1nhH8VEo/dI6Zoh7FMKyvU3KG
         9GtS5tAwacYYaOUxRlsGTNlv+lo/Rxwq+lD0v+GVEp1Rxc7+DV43c3h8yXOYLR2FfeiF
         Orgg==
X-Gm-Message-State: APjAAAXqZ0TiOr/4lLAN3ONEJ9yXZV2wb4X7Ztmnrdr4qb//CLiLX5/R
        mezb7oTjHrwCaVKbK/CWVroHR05SokAB9LJPkqFKhA==
X-Google-Smtp-Source: APXvYqwHg1H9Doq5OEug4pM1RWS08Zi73Ae7fAxCCqBqmHdN4BA/9FhkUYQzsl93EhJiZTlsj3fpW3/JEA0QhVLipC0=
X-Received: by 2002:a24:694b:: with SMTP id e72mr30897020itc.48.1555409012556;
 Tue, 16 Apr 2019 03:03:32 -0700 (PDT)
MIME-Version: 1.0
References: <20190416112039.25136d0b@canb.auug.org.au>
In-Reply-To: <20190416112039.25136d0b@canb.auug.org.au>
From:   John Hurley <john.hurley@netronome.com>
Date:   Tue, 16 Apr 2019 11:03:21 +0100
Message-ID: <CAK+XE=m+0NMxbRSTa05n0wJU3EuF=oVwA9aCirs2Dq3AcO7bjw@mail.gmail.com>
Subject: Re: linux-next: build warning after merge of the net-next tree
To:     Stephen Rothwell <sfr@canb.auug.org.au>
Cc:     David Miller <davem@davemloft.net>,
        Networking <netdev@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Simon Horman <simon.horman@netronome.com>,
        "Gustavo A. R. Silva" <gustavo@embeddedor.com>,
        Kees Cook <keescook@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 16, 2019 at 2:21 AM Stephen Rothwell <sfr@canb.auug.org.au> wrote:
>
> Hi all,
>
> After merging the net-next tree, today's linux-next build (x86_64
> allmodconfig) produced this warning:
>
> drivers/net/ethernet/netronome/nfp/flower/offload.c: In function 'nfp_flower_copy_pre_actions':
> drivers/net/ethernet/netronome/nfp/flower/offload.c:630:7: warning: this statement may fall through [-Wimplicit-fallthrough=]
>     if (tunnel_act)
>        ^
> drivers/net/ethernet/netronome/nfp/flower/offload.c:632:3: note: here
>    case NFP_FL_ACTION_OPCODE_PRE_LAG:
>    ^~~~
>
> Introduced by commit
>
>   1c6952ca587d ("nfp: flower: generate merge flow rule")
>
> I get this warning because I am building with -Wimplicit-fallthrough
> in attempt to catch new additions early.  The gcc warning can be turned
> off by adding a /* fall through */ comment at the point the fall through
> happens (assuming that the fall through is intentional).
>

Hi Stephen,
Thanks for flagging this.
The fall through is intentional.
I'll submit a fix for the warning.
John

> --
> Cheers,
> Stephen Rothwell
