Return-Path: <SRS0=SZ1Q=SM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DD98CC10F11
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Apr 2019 18:57:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B761B2077C
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Apr 2019 18:57:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726588AbfDJS5j (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 10 Apr 2019 14:57:39 -0400
Received: from mail-qt1-f194.google.com ([209.85.160.194]:36604 "EHLO
        mail-qt1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725981AbfDJS5i (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Apr 2019 14:57:38 -0400
Received: by mail-qt1-f194.google.com with SMTP id s15so4202513qtn.3;
        Wed, 10 Apr 2019 11:57:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=c7pJEAL+FpS1hEYkJeywmp4z9jpwm432Los5WBYEtHI=;
        b=LLaMY5XppX2Qa5lby6QWeljF/IbMJwHG1iiRmsUky8bVeAMX+FTns/ldGJ8TXGwZe0
         2QR2EOuNLDMFB+OdIi1N1ZgbtmrjZOEHM83FR2kqiiPJxa7+ciOidK3OKDiYE23PPZIc
         1tU2VPtYoBf7MbZolAbcM1mTP9TNi0GFdYQwYfndzJ/pu6SeAyhRv1BkgEEFb9uFXEjj
         LM4wbjJbJERaBZ+c4o8vqjmu4PjlEhhG9mXVccwdmd7aPekTAnIGXjjz45WvKeJzzy/n
         W6cw7MnEnl6PE6cXvOAiea4/qmgL0gezGDeBUHvSPnaLUKmbnP46qd85CH1FZRYpr55G
         a30g==
X-Gm-Message-State: APjAAAVf9aPTR7C6dgO0R5HliOTalMt4DJzb29bU50J5YOJZpx+5Lo0E
        njB6vwz/2vVNEQIijZkbrR5/ooIgLetxxOhSYO8=
X-Google-Smtp-Source: APXvYqxG18t+7PgEK25vAm9gJmpIipBr/KW8D4w4fXr/fhW7YRKXN/bcohuIYkP7l1UIQNzwUiCB7CNbRVQjUHJIu4w=
X-Received: by 2002:ac8:1a0b:: with SMTP id v11mr39108131qtj.171.1554922657884;
 Wed, 10 Apr 2019 11:57:37 -0700 (PDT)
MIME-Version: 1.0
References: <20190408212648.2407234-1-arnd@arndb.de> <20190408212648.2407234-5-arnd@arndb.de>
 <8875e0b6-00b4-884d-fd6a-a5a144543559@linux.ibm.com> <20190410175946.0e6d2b00@mschwideX1>
In-Reply-To: <20190410175946.0e6d2b00@mschwideX1>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Wed, 10 Apr 2019 20:57:21 +0200
Message-ID: <CAK8P3a1-1axfWq5Y1pK9XORMdsbmZyq75p+V5Do71hNRowct+g@mail.gmail.com>
Subject: Re: [PATCH 05/12] s390: zcrypt: initialize variables before_use
To:     Martin Schwidefsky <schwidefsky@de.ibm.com>
Cc:     Harald Freudenberger <freude@linux.ibm.com>,
        Heiko Carstens <heiko.carstens@de.ibm.com>,
        clang-built-linux@googlegroups.com,
        Nick Desaulniers <ndesaulniers@google.com>,
        Nathan Chancellor <natechancellor@gmail.com>,
        linux-s390 <linux-s390@vger.kernel.org>,
        Ingo Franzki <ifranzki@de.ibm.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 10, 2019 at 5:59 PM Martin Schwidefsky
<schwidefsky@de.ibm.com> wrote:
> On Tue, 9 Apr 2019 11:54:30 +0200 Harald Freudenberger <freude@linux.ibm.com> wrote:
> > On 08.04.19 23:26, Arnd Bergmann wrote:
> > >             }
> > Thanks Arnd, but as Nathan already wrote, I'd prefer to have the
> > variable initialized with 0 instead of -1.
> > If you agree with this, I'll rewrite the patch and apply it to our
> > internal git and it will appear at kernel org with the next s390 code merge then.
>
> Do we agreement on func_coed=0 for this one ?

Yes, I think that was the consensus.

       Arnd
