Return-Path: <SRS0=oArh=RZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0C6FAC10F03
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 21:00:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D1839218E2
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 21:00:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore-com.20150623.gappssmtp.com header.i=@paul-moore-com.20150623.gappssmtp.com header.b="ReSYeo31"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727440AbfCVVA1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Mar 2019 17:00:27 -0400
Received: from mail-lf1-f68.google.com ([209.85.167.68]:33096 "EHLO
        mail-lf1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727257AbfCVVA0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Mar 2019 17:00:26 -0400
Received: by mail-lf1-f68.google.com with SMTP id v14so2392570lfi.0
        for <linux-kernel@vger.kernel.org>; Fri, 22 Mar 2019 14:00:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=xesfvnWVsg/9/PXwC0eVTIqIu5vGbA1eVuSI7sXVqfw=;
        b=ReSYeo3180DnCeRRHkk0CXg/c8QCzpV8LtUqTQ1YDKWQ0ZOGGIgII8o0W05BIEbPkK
         sc5M2CNyQcZVbkrc7jx1n+0pErnPmCDvb1nFeywvgDwiUKAIMljQ1gXdZydWfXmv2NFi
         nX71VgcB9/k8RiiWr2ztLzvokoKoIqe76n28fSKyjS7RPbcCkLHLeCPsNnOcFWcQiN/T
         rqO5g/pl+/QrgI6lCawdwIwZgjFUAIsE2/5+TCTmnP54U+UnLm+583AgFQ4Kc5QFtBSE
         zYvNNTCOrYfV4xql/cnkttGqDcctAeJ5y1b0inV+0hIT66tnYXf6Wz+uzdTei0YKfJ70
         Kv0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=xesfvnWVsg/9/PXwC0eVTIqIu5vGbA1eVuSI7sXVqfw=;
        b=rVU6fGG64gAT+vm+rBRJDZ7NgQo6yeerK5Eh6prLW7aHB57ydzn2GuNrStNO1sl2Wr
         IBA1655R9ju3QwXGx35xLlZdmUXepURKxYBwuswriXl7Hz7/Jhe6PgfUF8I8A9klrewE
         sFRN/DSxheeSquHzIhQf0m0r5EZRdDyLx26v+CAFK0/D4158ezJ2vDZyD/7w0xL20/7e
         l8Fxita/lrG3ojBxyVfmR7SCXthnwYP80gYpPH8B957jJ8zxwxQVSKD2NA9Oa7/lhycF
         K9EH0iKfrDk9noYYwDM1JPdJT8OD42GZDsN/O1mP3EpTi5yWTk72n37PIzgpmEDwI1Ee
         deRA==
X-Gm-Message-State: APjAAAVESyBpZL2asHSPDvMLnOjh8hVv9g0e7A4SnM7lOMNCxEN/byd6
        r8poyBSCCuWcRrNZgdvlm5yXTA0W3WXzeumFXH3X
X-Google-Smtp-Source: APXvYqwG9s+C8iGPa7B7a+B130/stSpD9x4v1+mjJEg7AEGvUQeqdcv2glXLHjzu4VOXWCSbuu1gn6+T20On8NLc0GI=
X-Received: by 2002:ac2:42da:: with SMTP id n26mr5536525lfl.91.1553288424695;
 Fri, 22 Mar 2019 14:00:24 -0700 (PDT)
MIME-Version: 1.0
References: <20190322141414.496017-1-arnd@arndb.de> <CAHC9VhQuSQr7+y1z3SmY=3s608zYo3JXhF3m_jUWXAo8i8swgw@mail.gmail.com>
 <CAK8P3a0EF-T7fySTCDBAFftWTKXPTBcCzj7afcVTP=_pemQdug@mail.gmail.com>
In-Reply-To: <CAK8P3a0EF-T7fySTCDBAFftWTKXPTBcCzj7afcVTP=_pemQdug@mail.gmail.com>
From:   Paul Moore <paul@paul-moore.com>
Date:   Fri, 22 Mar 2019 17:00:13 -0400
Message-ID: <CAHC9VhQ2DbH1=xQWfPxjhqC-86pYuo5sXXNJnOtSOsfZrrMeaQ@mail.gmail.com>
Subject: Re: [PATCH] selinux: avoid uninitialized variable warning
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     Stephen Smalley <sds@tycho.nsa.gov>,
        Eric Paris <eparis@parisplace.org>,
        clang-built-linux@googlegroups.com,
        Nick Desaulniers <ndesaulniers@google.com>,
        Nathan Chancellor <natechancellor@gmail.com>,
        selinux@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 22, 2019 at 4:35 PM Arnd Bergmann <arnd@arndb.de> wrote:
> On Fri, Mar 22, 2019 at 9:15 PM Paul Moore <paul@paul-moore.com> wrote:
> > On Fri, Mar 22, 2019 at 10:14 AM Arnd Bergmann <arnd@arndb.de> wrote:
>
> > Hi Arnd,
> >
> > Thanks for pointing this out and providing a fix.  I think you're
> > right in that the should be pretty harmless, but I also agree that we
> > should fix it; some thoughts on the patch below ...
> >
> > > diff --git a/security/selinux/netlabel.c b/security/selinux/netlabel.c
> > > index 186e727b737b..d0e549d4f486 100644
> > > --- a/security/selinux/netlabel.c
> > > +++ b/security/selinux/netlabel.c
> > > @@ -288,7 +288,6 @@ int selinux_netlbl_sctp_assoc_request(struct sctp_endpoint *ep,
> > >         int rc;
> > >         struct netlbl_lsm_secattr secattr;
> > >         struct sk_security_struct *sksec = ep->base.sk->sk_security;
> > > -       struct sockaddr *addr;
> > >         struct sockaddr_in addr4;
> > >  #if IS_ENABLED(CONFIG_IPV6)
> > >         struct sockaddr_in6 addr6;
> > > @@ -310,16 +309,15 @@ int selinux_netlbl_sctp_assoc_request(struct sctp_endpoint *ep,
> > >         if (ip_hdr(skb)->version == 4) {
> > >                 addr4.sin_family = AF_INET;
> > >                 addr4.sin_addr.s_addr = ip_hdr(skb)->saddr;
> > > -               addr = (struct sockaddr *)&addr4;
> > > +               rc = netlbl_conn_setattr(ep->base.sk, (void*)&addr4, &secattr);
> > >  #if IS_ENABLED(CONFIG_IPV6)
> > >         } else {
> > >                 addr6.sin6_family = AF_INET6;
> > >                 addr6.sin6_addr = ipv6_hdr(skb)->saddr;
> > > -               addr = (struct sockaddr *)&addr6;
> > > +               rc = netlbl_conn_setattr(ep->base.sk, (void*)&addr6, &secattr);
> > >  #endif
> >
> > While we are hardening the code a bit, I'm thinking we should probably
> > refactor this if-else a bit, some pseudo code for example:
> >
> >     if (ip_hdr == 4) {
> >       rc = netlbl_conn_setattr();
> >   #if CONFIG_IPV6
> >     } else if (ip_hdr == 6) {
> >       rc = netlbl_conn_setattr();
> >   #endif
> >     } else {
> >       rc = -EAFNOSUPPORT;
> >     }
> >
> > Thoughts?
> >
>
> Seems fine. We could go a step further and use IS_ENABLED()
> as C code here to get rid of the two #ifdef checks as well, like
>
>         if (ip_hdr(skb)->version == 4 ) {
>                 addr4.sin_family = AF_INET;
>                 addr4.sin_addr.s_addr = ip_hdr(skb)->saddr;
>                 rc = netlbl_conn_setattr(ep->base.sk, &addr4, &secattr);
>         } else if (IS_ENABLED(CONFIG_IPV6) && ip_hdr(skb)->version == 6) {
>                 addr6.sin6_family = AF_INET6;
>                 addr6.sin6_addr = ipv6_hdr(skb)->saddr;
>                 rc = netlbl_conn_setattr(ep->base.sk, &addr6, &secattr);
>         } else {
>                rc = -EAFNOSUPPORT;
>         }

Looks good to me.  Can you send a revised patch?

-- 
paul moore
www.paul-moore.com
