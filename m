Return-Path: <SRS0=HQPa=VE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,GAPPY_SUBJECT,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BEC78C48BE1
	for <linux-kernel@archiver.kernel.org>; Sun,  7 Jul 2019 15:41:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9831E20830
	for <linux-kernel@archiver.kernel.org>; Sun,  7 Jul 2019 15:41:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="er0xymwp"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727059AbfGGPkz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 7 Jul 2019 11:40:55 -0400
Received: from mail-io1-f67.google.com ([209.85.166.67]:34803 "EHLO
        mail-io1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725901AbfGGPkz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 7 Jul 2019 11:40:55 -0400
Received: by mail-io1-f67.google.com with SMTP id k8so29421351iot.1;
        Sun, 07 Jul 2019 08:40:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=qwHbQTuFE2kUikky3tbT6iwWg4yYSI3KMwntAKoTe4o=;
        b=er0xymwpwDu18o30aSZDPXm6ih4bYYK56Lsn0PBrEBsI2+GkfvJ0DLnQK2RVcNhiay
         +D/JD05yJ/wS8a98UDAA7JmIXiaidvPOMnU2vGyMoKdb1jtHeCtBC3kmXqU8R3Q228vG
         68XGAd7WFcd9HF8yqcBoPhLbNT6Ry5i5f0EVkcB7o8FeikeNs/fXuQT4mDrR8/glCN+Y
         olzFtTyNcreomoJ0mN7e/JWRCYVoCfOG9fLdGpi1ajzyeGmzLMEJxRge1NuGQzdqnECA
         z47rAAdunWBGIzPrvt8O+hq21Hog6XykpUYRgPx2NN9dX9m4ijMVEhbxacAQadi+J3vO
         uUqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=qwHbQTuFE2kUikky3tbT6iwWg4yYSI3KMwntAKoTe4o=;
        b=JFRU1J/fUNhR9L+52JhQEpKkjnhiIVLifXrfvBxd1Qb0FN+48glRLcTl4/0H3fvWM7
         I01dsV7j8YeqnPoWQtPtghd3UI72XEBtB0upMwrW2wrhSHC6FxYLODXdLpOh4nU8Mg7j
         YOzteNWiLeytCxNIHzqPC46CJsKhWdquI5C5CwbJbVcoqC/ObxfizkIhf5Qsk9cNz3BG
         xhLSUxdzvqGpbCoM1kOPykUJ76Gachj8eF3FN9JZgdG9iWKatfKiIk+ftEFHRxwvmmqD
         FyRFHOd9bjmEqM+EAIutD7MXucl2OvSJ/tZGZ+qRFKDxcfdbWYsPbEVBEMNtCmkrKQ2r
         GsbA==
X-Gm-Message-State: APjAAAW85MF13WpGIFkIyLMMoqgUe01rz74gvDeSFzC7aGuPyclQ4H9j
        xARHg8Z1j7j3MyrQRl0rfPq53UxCpKbsQ8wCjIuRsdSXDB+Tzw==
X-Google-Smtp-Source: APXvYqzuxGF7GLEefBfbdxPUSlLxOABw/jdkNTyIlCf5RzRx9gAPfKtK85ODjRIpvEtMUdMrKQuPQCx7Np6eky+RxpY=
X-Received: by 2002:a5d:8347:: with SMTP id q7mr13181248ior.277.1562514054357;
 Sun, 07 Jul 2019 08:40:54 -0700 (PDT)
MIME-Version: 1.0
References: <1562410493-8661-1-git-send-email-s.mesoraca16@gmail.com> <alpine.LRH.2.21.1907061814390.24897@namei.org>
In-Reply-To: <alpine.LRH.2.21.1907061814390.24897@namei.org>
From:   Salvatore Mesoraca <s.mesoraca16@gmail.com>
Date:   Sun, 7 Jul 2019 17:40:43 +0200
Message-ID: <CAJHCu1KPkzREqq0pGJ6Wp4CKHkA0Eeaj2vcGViE+B0192tFWFw@mail.gmail.com>
Subject: Re: [PATCH v5 00/12] S.A.R.A. a new stacked LSM
To:     James Morris <jmorris@namei.org>
Cc:     linux-kernel@vger.kernel.org,
        Kernel Hardening <kernel-hardening@lists.openwall.com>,
        linux-mm@kvack.org, linux-security-module@vger.kernel.org,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Brad Spengler <spender@grsecurity.net>,
        Casey Schaufler <casey@schaufler-ca.com>,
        Christoph Hellwig <hch@infradead.org>,
        Jann Horn <jannh@google.com>,
        Kees Cook <keescook@chromium.org>,
        PaX Team <pageexec@freemail.hu>,
        "Serge E. Hallyn" <serge@hallyn.com>,
        Thomas Gleixner <tglx@linutronix.de>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

James Morris <jmorris@namei.org> wrote:
>
> On Sat, 6 Jul 2019, Salvatore Mesoraca wrote:
>
> > S.A.R.A. (S.A.R.A. is Another Recursive Acronym) is a stacked Linux
>
> Please make this just SARA. Nobody wants to read or type S.A.R.A.

Agreed.
Thank you for your suggestion.
