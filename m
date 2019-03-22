Return-Path: <SRS0=oArh=RZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8919AC4360F
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 20:15:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 57B1A218E2
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 20:15:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore-com.20150623.gappssmtp.com header.i=@paul-moore-com.20150623.gappssmtp.com header.b="M3cLj51x"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727455AbfCVUPZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Mar 2019 16:15:25 -0400
Received: from mail-lf1-f65.google.com ([209.85.167.65]:44189 "EHLO
        mail-lf1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726091AbfCVUPY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Mar 2019 16:15:24 -0400
Received: by mail-lf1-f65.google.com with SMTP id u9so2202796lfe.11
        for <linux-kernel@vger.kernel.org>; Fri, 22 Mar 2019 13:15:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=7WpPq2hKy/eNksQA15j3lPcjWfiZXOzco+vJ7Dg1GgI=;
        b=M3cLj51xYb38Z9IxbVnMJw6f+IGDTr7tSudkXvteN3W0vMx4oLv7TpZ6zesd4bFvcU
         pr80WdfISolHhOSOxdiKWawaHtpzVldnWYH8uugiklp+hU/AA+Pm2L7zR/2hUTKYGNQo
         cU2YWydAQuv+5+PVP/JUt4jx04lpgpejUm++nBTLFGCqRva0E6IhC8YOOc5vRBHD90Tz
         g9a+TGn8aIkvfsAw7kWFEG46L1xLQpK6FjsFkd8xa61LMc6bO02br1cEuMkcmSvtiHJv
         zQb4sek1F9VVZZJyS4428cR9wL1jPflK2DOct+HwDwGO+xMsYOM8NVPOgs4zxl0fmUSx
         uKXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=7WpPq2hKy/eNksQA15j3lPcjWfiZXOzco+vJ7Dg1GgI=;
        b=kEL4+SZ+o4FJuad/XrVTTKEbkRX8up8Os9ygT+s1TtHhyRZVMJZlzTccB1jEBLbHRh
         e0AxSNTWM5CZPA4SPxboHDLmG6v6XNOTPc/PnaFjd0Lleo+hA5mGn5vou7Gw9xVpnz7L
         DVm285KsXK4bo6573s8I03Q4/I6S6trJLkIxfQQxKouEMaTZruO0UAUBVYLOBNRkeXsy
         Ge1IP9JL7W89GMAr+ZwUKCuo+g6Y6G80okbaxO4ozVbtmlvCl0sReuPndH6KNFrsgAjp
         lZHLhBQHGKSam0VYnKpObIndLrBjHJFHphondDbPsHvOdzW9DL+dJK4HfYMftWZSR0/6
         dBXw==
X-Gm-Message-State: APjAAAWEH89n68T4a/GOUh1TNXbOhj++cdqKd9MFhNfMaf0GWFQ6JD6R
        6xCF3T2XG+Ui4KnM/LjSgmmj5CX5YRxQi17sMJVQ
X-Google-Smtp-Source: APXvYqytzpxVVW1e6sMr9FLNSXE5C0PLI06p/4Wnq6LU87q/XmFZQXamatFU2n6V19NW9ljYnIwYsNaNN6iI4mJpfm8=
X-Received: by 2002:a19:ee11:: with SMTP id g17mr5929557lfb.117.1553285722058;
 Fri, 22 Mar 2019 13:15:22 -0700 (PDT)
MIME-Version: 1.0
References: <20190322141414.496017-1-arnd@arndb.de>
In-Reply-To: <20190322141414.496017-1-arnd@arndb.de>
From:   Paul Moore <paul@paul-moore.com>
Date:   Fri, 22 Mar 2019 16:15:09 -0400
Message-ID: <CAHC9VhQuSQr7+y1z3SmY=3s608zYo3JXhF3m_jUWXAo8i8swgw@mail.gmail.com>
Subject: Re: [PATCH] selinux: avoid uninitialized variable warning
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     Stephen Smalley <sds@tycho.nsa.gov>,
        Eric Paris <eparis@parisplace.org>,
        clang-built-linux@googlegroups.com,
        Nick Desaulniers <ndesaulniers@google.com>,
        Nathan Chancellor <natechancellor@gmail.com>,
        selinux@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 22, 2019 at 10:14 AM Arnd Bergmann <arnd@arndb.de> wrote:
> clang correctly points out a code path that would lead
> to an uninitialized variable use:
>
> security/selinux/netlabel.c:310:6: error: variable 'addr' is used uninitialized whenever 'if' condition is false
>       [-Werror,-Wsometimes-uninitialized]
>         if (ip_hdr(skb)->version == 4) {
>             ^~~~~~~~~~~~~~~~~~~~~~~~~
> security/selinux/netlabel.c:322:40: note: uninitialized use occurs here
>         rc = netlbl_conn_setattr(ep->base.sk, addr, &secattr);
>                                               ^~~~
> security/selinux/netlabel.c:310:2: note: remove the 'if' if its condition is always true
>         if (ip_hdr(skb)->version == 4) {
>         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> security/selinux/netlabel.c:291:23: note: initialize the variable 'addr' to silence this warning
>         struct sockaddr *addr;
>                              ^
>                               = NULL
> 1 error generated.
>
> This is probably harmless since we should not see ipv6 packets
> of CONFIG_IPV6 is disabled, but it's better to rearrange the code
> so this cannot happen.
>
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> ---
>  security/selinux/netlabel.c | 6 ++----
>  1 file changed, 2 insertions(+), 4 deletions(-)

Hi Arnd,

Thanks for pointing this out and providing a fix.  I think you're
right in that the should be pretty harmless, but I also agree that we
should fix it; some thoughts on the patch below ...

> diff --git a/security/selinux/netlabel.c b/security/selinux/netlabel.c
> index 186e727b737b..d0e549d4f486 100644
> --- a/security/selinux/netlabel.c
> +++ b/security/selinux/netlabel.c
> @@ -288,7 +288,6 @@ int selinux_netlbl_sctp_assoc_request(struct sctp_endpoint *ep,
>         int rc;
>         struct netlbl_lsm_secattr secattr;
>         struct sk_security_struct *sksec = ep->base.sk->sk_security;
> -       struct sockaddr *addr;
>         struct sockaddr_in addr4;
>  #if IS_ENABLED(CONFIG_IPV6)
>         struct sockaddr_in6 addr6;
> @@ -310,16 +309,15 @@ int selinux_netlbl_sctp_assoc_request(struct sctp_endpoint *ep,
>         if (ip_hdr(skb)->version == 4) {
>                 addr4.sin_family = AF_INET;
>                 addr4.sin_addr.s_addr = ip_hdr(skb)->saddr;
> -               addr = (struct sockaddr *)&addr4;
> +               rc = netlbl_conn_setattr(ep->base.sk, (void*)&addr4, &secattr);
>  #if IS_ENABLED(CONFIG_IPV6)
>         } else {
>                 addr6.sin6_family = AF_INET6;
>                 addr6.sin6_addr = ipv6_hdr(skb)->saddr;
> -               addr = (struct sockaddr *)&addr6;
> +               rc = netlbl_conn_setattr(ep->base.sk, (void*)&addr6, &secattr);
>  #endif

While we are hardening the code a bit, I'm thinking we should probably
refactor this if-else a bit, some pseudo code for example:

    if (ip_hdr == 4) {
      rc = netlbl_conn_setattr();
  #if CONFIG_IPV6
    } else if (ip_hdr == 6) {
      rc = netlbl_conn_setattr();
  #endif
    } else {
      rc = -EAFNOSUPPORT;
    }

Thoughts?

>         }
>
> -       rc = netlbl_conn_setattr(ep->base.sk, addr, &secattr);
>         if (rc == 0)
>                 sksec->nlbl_state = NLBL_LABELED;
>
> --
> 2.20.0
>

-- 
paul moore
www.paul-moore.com
