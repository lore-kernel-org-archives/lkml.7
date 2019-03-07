Return-Path: <SRS0=uyI7=RK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7BAE0C4360F
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Mar 2019 22:36:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 47FE020851
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Mar 2019 22:36:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="lvKjlozg"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726311AbfCGWgh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 Mar 2019 17:36:37 -0500
Received: from mail-it1-f193.google.com ([209.85.166.193]:51117 "EHLO
        mail-it1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726259AbfCGWgh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Mar 2019 17:36:37 -0500
Received: by mail-it1-f193.google.com with SMTP id m137so18020301ita.0
        for <linux-kernel@vger.kernel.org>; Thu, 07 Mar 2019 14:36:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=X6nxDQFHxpNbXFm8Y/cwjnATm2ycJfRd0D5pP1bP8Ik=;
        b=lvKjlozgztXmnRsOTijdJgw971xlH1PYGmJYZdddS/5B8hoFTm+9gYfR0mYekhva6P
         4Q2pXrUvJBmgoENAeT1PI69iDN14W1flh9EjYUNF9Uh0Yu3wsIrGlL0hUfrvo4LN3Wkw
         otGJW/APungtXa6SZSLW7ZmCEoZiVfCTtz2tWEMYmQ4iGp/5OGNDNOPN3ErUv5/+2UzN
         MGZE1Q3KuhyEYHeApjm4Yaia3nHC+RCt/aFBILA87Eaamzp7yOu69YoLkcFLxOHtDZKR
         Dt1AnXS6PdExhMe2M/MpYGGuaGmE1TXjhOJWOmIs0crp6sv7XHv9f+upS5vnSLPCynzS
         uKqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=X6nxDQFHxpNbXFm8Y/cwjnATm2ycJfRd0D5pP1bP8Ik=;
        b=dSiSay1/FmLQGLxg3ufVMH3VT3XI7E06gEosiM7VX6hRnp/bRj2aS5cqJRC/KxhsIh
         7pZsGbRZiJyUnOzltyQ3VNranxzJUgcIZ3CZVInjamSWPBIMARBDJ2frYh9Jum2oMEl/
         c5l+EaSuLg2Xu5AsakOiGU0nZRnzkNwNXCoRr1cJmoe9z8SNsZY/l/qRNziGNzqaQfhj
         8JRNLb3rbCD/enh2OJdEd0TRXfjiXNZ5SW30kpWCSEZO7UEyhYLWwpiDjzcoR+4uPYms
         mXme1JdOPUGPsbaVF/QsTRi6tv9MHCGdwDpOakGZr6RWIlqcdBnIK1jfFSjMBySfzjmM
         0I9w==
X-Gm-Message-State: APjAAAUZnSMKcuUYZ0/JbQNm7Op4jZtBgYsrj1zIFF8dsR+9ffJM6f6O
        cyBBCjrDWha+jU6UEZPvaUylRb5Jw4IX6bwQP++ZvQQLS68=
X-Google-Smtp-Source: APXvYqyB71lDqVb0ANLF3ihHkdNYztDFl08cUqd3QcRW6s6g0WgYk596OjNWgxFCs+Y2c1BhIKy5CNe1FLnVskjb9PA=
X-Received: by 2002:a24:2c48:: with SMTP id i69mr7060219iti.161.1551998195904;
 Thu, 07 Mar 2019 14:36:35 -0800 (PST)
MIME-Version: 1.0
References: <1550060279-8624-1-git-send-email-zohar@linux.ibm.com>
 <CACdnJuuPyL3Qo4jAiJDQvUF9Ctch6Yo2bKezEuQ2KaM5ZZ1vqw@mail.gmail.com> <1551998075.31706.455.camel@linux.ibm.com>
In-Reply-To: <1551998075.31706.455.camel@linux.ibm.com>
From:   Matthew Garrett <mjg59@google.com>
Date:   Thu, 7 Mar 2019 14:36:25 -0800
Message-ID: <CACdnJuus7zZWDfJHu+nckn+t-FkRerh7vzX2eh=1nGsbX=kbgw@mail.gmail.com>
Subject: Re: [PATCH v2] x86/ima: require signed kernel modules
To:     Mimi Zohar <zohar@linux.ibm.com>
Cc:     linux-integrity <linux-integrity@vger.kernel.org>,
        LSM List <linux-security-module@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Jessica Yu <jeyu@kernel.org>,
        Luis Chamberlain <mcgrof@kernel.org>,
        David Howells <dhowells@redhat.com>,
        Seth Forshee <seth.forshee@canonical.com>,
        "Bruno E . O . Meneguele" <bmeneg@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 7, 2019 at 2:34 PM Mimi Zohar <zohar@linux.ibm.com> wrote:
>
> On Thu, 2019-03-07 at 14:27 -0800, Matthew Garrett wrote:
> > On Wed, Feb 13, 2019 at 4:18 AM Mimi Zohar <zohar@linux.ibm.com> wrote:
> > > -       if (IS_ENABLED(CONFIG_IMA_ARCH_POLICY) && arch_ima_get_secureboot())
> > > +       if (IS_ENABLED(CONFIG_IMA_ARCH_POLICY) && arch_ima_get_secureboot()) {
> > > +               if (IS_ENABLED(CONFIG_MODULE_SIG))
> > > +                       set_module_sig_enforced();
> > >                 return sb_arch_rules;
> >
> > Linus previously pushed back on having the lockdown features
> > automatically enabled on secure boot systems. Why are we doing the
> > same in IMA?
>
> IMA-appraisal is extending the "secure boot" concept to the running
> system.

Right, but how is this different to what Linus was objecting to?
