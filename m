Return-Path: <SRS0=4nbc=R5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7FEF0C43381
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Mar 2019 16:15:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4C33A20863
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Mar 2019 16:15:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=brauner.io header.i=@brauner.io header.b="XdjsaQvn"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731573AbfCZQPg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Mar 2019 12:15:36 -0400
Received: from mail-ed1-f65.google.com ([209.85.208.65]:40083 "EHLO
        mail-ed1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732119AbfCZQPe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Mar 2019 12:15:34 -0400
Received: by mail-ed1-f65.google.com with SMTP id h22so11282802edw.7
        for <linux-kernel@vger.kernel.org>; Tue, 26 Mar 2019 09:15:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=brauner.io; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=stMZSrcLpSkOMBILhdqDOLfW9MtN6O+g6RIWKTXvR5w=;
        b=XdjsaQvnHpT6UT5zjksyACB4rbG4UMsycywQawujdUIyuZ1lf22Fa5fC8mQasBupA8
         9G2ueaxKnEUa77xC0hO4jePLzFSmb5fAk6L3jVBLBQhSu3/7QscEqkk6lsCasFE9QmhF
         Um0y5O15aZB5hzFrGbK+a9An6d15bCgaYYsMEMWUxUtfs5RoJ1OvSjIsodOr43/3vFHU
         LursHwHhzlbkz0+TPqVh1MLsm9SxDvgmebMoeMoqXtzWA+psKrg1Lq+vdrrO2TassssA
         tD14SIzGJ3laVgyqjQ9g0XV57YL5IdZHsar7xPwCu7FtSWN8YfqbOREaJjnB2N1TeNSD
         tcKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=stMZSrcLpSkOMBILhdqDOLfW9MtN6O+g6RIWKTXvR5w=;
        b=M0D7J9F53DervN/5b8Ixw2mr5zdqYST5QqrzuXxWWSdbfoSSZsot8pknABwlN9q9mm
         l71u9obpKuLrPYdqoj+RwtkKevp5b2uXv+GgTzDJhWZ2SISo6Z2Vj69R9ZnH4pudJJzB
         31xvDldk6tSABlQjlOwaKHExn9Rmc0a6L8qObpOu9Bo+AafL5YVL4LP6rOKPi5gSBQFn
         cJEexiGU6B30mp1uBVQPwgSD/HpzOmJZkpQ5W46cGfJuB5EEh8apZrhooc+p5lKrJug3
         C3t4TaJpnNLHmn+5NN2PBKCTn4oyphUIy+9rOp+EDYsqLSotYI7mt4a3tCi8329Soo9l
         8rLg==
X-Gm-Message-State: APjAAAVW3EdK0sCBG+2Ti/FTOGyF0CMhWRNSY1jA8wRsPghJjuQG5eXJ
        w1J7Wl9f3DwLQ6FZhdjAC2jWGA==
X-Google-Smtp-Source: APXvYqxCdjkcjarUczael9LfXfLGwCrazjNIjDL/5u3jlEBAS0fhwJVJ06nE4K5H6dCjvv8g8NHnpg==
X-Received: by 2002:a50:eac8:: with SMTP id u8mr2881336edp.125.1553616932738;
        Tue, 26 Mar 2019 09:15:32 -0700 (PDT)
Received: from brauner.io (x59cc895e.dyn.telefonica.de. [89.204.137.94])
        by smtp.gmail.com with ESMTPSA id e4sm6748873edm.86.2019.03.26.09.15.30
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Tue, 26 Mar 2019 09:15:32 -0700 (PDT)
Date:   Tue, 26 Mar 2019 17:15:30 +0100
From:   Christian Brauner <christian@brauner.io>
To:     Joel Fernandes <joel@joelfernandes.org>
Cc:     Jann Horn <jannh@google.com>, Andy Lutomirski <luto@kernel.org>,
        Konstantin Khlebnikov <khlebnikov@yandex-team.ru>,
        David Howells <dhowells@redhat.com>,
        "Serge E. Hallyn" <serge@hallyn.com>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        Linux API <linux-api@vger.kernel.org>,
        kernel list <linux-kernel@vger.kernel.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Kees Cook <keescook@chromium.org>,
        Alexey Dobriyan <adobriyan@gmail.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Michael Kerrisk-manpages <mtk.manpages@gmail.com>,
        bl0pbl33p@gmail.com, "Dmitry V. Levin" <ldv@altlinux.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Oleg Nesterov <oleg@redhat.com>,
        Nagarathnam Muthusamy <nagarathnam.muthusamy@oracle.com>,
        cyphar@cyphar.com, Al Viro <viro@zeniv.linux.org.uk>,
        Daniel Colascione <dancol@google.com>
Subject: Re: [PATCH 2/4] pid: add pidctl()
Message-ID: <20190326161528.lhtxdsbkxdodoogt@brauner.io>
References: <20190325162052.28987-1-christian@brauner.io>
 <20190325162052.28987-3-christian@brauner.io>
 <CAG48ez24xPM4f7ty=8k5p6_gVWd-bEUSxca5Ngy5svHgarhz+w@mail.gmail.com>
 <20190326160729.GA76870@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20190326160729.GA76870@google.com>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> Agreed, I also was going to say the same, about the flags.

Please review the updated version I just sent out.

Christian
