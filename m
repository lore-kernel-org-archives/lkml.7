Return-Path: <SRS0=19dG=ZH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B3343C43215
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Nov 2019 18:52:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 842C920732
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Nov 2019 18:52:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1573843937;
	bh=TPSsKExv2E/ILyO8yyaTxD1roGSowlAIsexEt5+jRw8=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=Jy59Y/Wpk42DQ97FjEhVQQTbMqxzHPtjYqSG507UlNi+w5z3CNiIbZgpLHZf0zE8u
	 44LQUt/dD7I1ll70eD74piqr82SH69N4Q4ouekiLPO5yLzM0xDweelDWcCrwlse3Mi
	 rva18hp2Gke1C6bCMulYqaYfIKPYQUyo0z20QWlY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726894AbfKOSwQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 Nov 2019 13:52:16 -0500
Received: from mail-lj1-f196.google.com ([209.85.208.196]:34062 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726365AbfKOSwP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Nov 2019 13:52:15 -0500
Received: by mail-lj1-f196.google.com with SMTP id 139so11780196ljf.1
        for <linux-kernel@vger.kernel.org>; Fri, 15 Nov 2019 10:52:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=M4xtaCr8bksk7hZhv5KKTwu+2iaD2qyURktvDZXazkc=;
        b=egY2spLHGrR8gGG3xgZthsV14T8zMUbAEU8nKs0WE79SJJeYlT6diMl1apCO7hfIfO
         tSqtul8DRPTMZKBrjOt/ltN4StE8fYapzmVL9CihIAD7zosIaWJTZpUQeSumxCyfstuN
         J7W82IwYXTpcy8GJO0MisBQrqCmUiCr69scXk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=M4xtaCr8bksk7hZhv5KKTwu+2iaD2qyURktvDZXazkc=;
        b=Gcl/D243i/Sjr74YciKVVjQ7y8hcUuaibYcNk7cWnbNwNxAqV4CUfJqDvY54597spQ
         mG/61KQd6z/rpG6xrrf+E12STW/DeJa2WFGTQGFxD1Lxrao/QEQxxLFTQwV5LRJw180K
         mJLUy//hYsDa/CB71pTaaoXx/EVvZLMwvQpux+cd/47G9MxVJFRi+SD0GSCa4Va1HWHB
         5pm9iI9ExA6BJqRybXIMQOOkPGjDe9ZjKsbU+ngf9MpyF1P/TpGHmogA+kcAUlHd3MI2
         DTK3nrKj7GDm4kGP0ExmGbyqU2UQjDqtm/tgGaCh9b5mce1jGh77dVemAWTL/hUeV52v
         U5Hw==
X-Gm-Message-State: APjAAAV5qmnYrHldRnyGS+DpQzv+ejsSB/EXu132K7/MFIMZpH2Tlo0x
        WIhRXR44LKr3K+/K9eMq8T08w27hfoM=
X-Google-Smtp-Source: APXvYqy28zSMVYa2aSJx0hqiieXiEMcu/XWVpeq41sltalJxWhUNeMa9ZLHLsFVoACVTIe8sMP6Mbg==
X-Received: by 2002:a2e:3009:: with SMTP id w9mr2887949ljw.74.1573843932807;
        Fri, 15 Nov 2019 10:52:12 -0800 (PST)
Received: from mail-lj1-f180.google.com (mail-lj1-f180.google.com. [209.85.208.180])
        by smtp.gmail.com with ESMTPSA id l21sm4255725lji.46.2019.11.15.10.52.11
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 15 Nov 2019 10:52:11 -0800 (PST)
Received: by mail-lj1-f180.google.com with SMTP id e9so11731149ljp.13
        for <linux-kernel@vger.kernel.org>; Fri, 15 Nov 2019 10:52:11 -0800 (PST)
X-Received: by 2002:a2e:9a8f:: with SMTP id p15mr12453823lji.148.1573843931177;
 Fri, 15 Nov 2019 10:52:11 -0800 (PST)
MIME-Version: 1.0
References: <157375686331.16781.5317786612607603165.stgit@warthog.procyon.org.uk>
In-Reply-To: <157375686331.16781.5317786612607603165.stgit@warthog.procyon.org.uk>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Fri, 15 Nov 2019 10:51:55 -0800
X-Gmail-Original-Message-ID: <CAHk-=wgJMHz=vsvMLGb8q3ECk5odJkO5Sp438+rs6r30FUbP0A@mail.gmail.com>
Message-ID: <CAHk-=wgJMHz=vsvMLGb8q3ECk5odJkO5Sp438+rs6r30FUbP0A@mail.gmail.com>
Subject: Re: [PATCH] afs: Fix race in commit bulk status fetch
To:     David Howells <dhowells@redhat.com>
Cc:     Marc Dionne <marc.dionne@auristor.com>,
        linux-afs@lists.infradead.org,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 14, 2019 at 10:41 AM David Howells <dhowells@redhat.com> wrote:
>
> Fix this by skipping the update if the inode is being created as the
> creator will presumably set up the inode with the same information.

Applied,

          Linus
