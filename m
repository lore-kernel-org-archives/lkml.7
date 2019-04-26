Return-Path: <SRS0=fl2C=S4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 84846C43219
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Apr 2019 16:43:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5221D20679
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Apr 2019 16:43:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1556297036;
	bh=mvUb9ZSZWgdYxXHt/CpJcsWJeMg6zQykOHgj/ODJwSk=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=YfY2neK2Co30G8f+wR18jvXZSfcHQR9M/+Tf7PeGuBVCCdNyRVaiylQOnzb9ubNhA
	 CV5HXg9qlnEux/YQjbVhVE71ArvV/A7+rOLJ2aYxOoi5kHC6QBLBwZMgiLW7M/IUK9
	 /9jSycMiyJ/75wu3KXEnQ/8om6l1wwXUFkhj2/QY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726729AbfDZQny (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 26 Apr 2019 12:43:54 -0400
Received: from mail-lj1-f193.google.com ([209.85.208.193]:38061 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726167AbfDZQnx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Apr 2019 12:43:53 -0400
Received: by mail-lj1-f193.google.com with SMTP id p14so3518292ljg.5
        for <linux-kernel@vger.kernel.org>; Fri, 26 Apr 2019 09:43:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=NQ4pwnB7Gi2SaJOEJi/tsg8rqZwSXwG+dT+r4Td327M=;
        b=TSkkXqR1Kis8jeXvngapWxcHR6vw5qwT6u/7ftvmLaC5Nr4gZbmEi+Xl5vRqm6i9gp
         xGkuWEL1HC9v2XofT8kjkx8tGOgprlUnRUEHZ7vABqt60hTN5feaDKtndq5C6Ac67Ekn
         t5ppIo3xgn6K1H9w/CZGn35CVM/AWO/WJp4JY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=NQ4pwnB7Gi2SaJOEJi/tsg8rqZwSXwG+dT+r4Td327M=;
        b=P4ZKAIcV7B3Ss/OlbSh7DgQkdb712BnesBor1oMdufDzZrbxnXRgComaMYnKw2U6fI
         JFsKmA3caB+CIfCTXzHRe6MY9dQpxNM3jabRQU2xC4rZLxZbmbhFD1bCuqICuQmfNkMI
         7WT/5hdMorwwFG4z8dJ1nW4i3lE+PkgGV+HeXav+tKKH9VeK9ODg72XK7xNqbsx8yN+i
         x7c+mTEhF9SWAiJBqJgUK2kY0ojHGUSSyxytE3y6BWJ+pE+fu7bi6pyJO+wqXZ6E3ho2
         K97GwD8RzGlVTK/E2eC8NmMOgoYrW8y2O7l5l4gxqQZx78MpBNSVdMh6SpSs2Lj9J6gn
         /zJw==
X-Gm-Message-State: APjAAAU78NrTEszVYm26WNVZD0h3RG0qQYcMt6bwsA+9syQkcIofLsH6
        a1oJdmKSQXqmabWAJ2F4+CsBHQOVF+g=
X-Google-Smtp-Source: APXvYqwe094LNWBiEdgX7mN0xO9RPRqmYHawdNxxKloTiADjt1o4UZwpmv9imc5pWhzQonEifSGIpQ==
X-Received: by 2002:a2e:9a91:: with SMTP id p17mr23700079lji.127.1556297031340;
        Fri, 26 Apr 2019 09:43:51 -0700 (PDT)
Received: from mail-lj1-f171.google.com (mail-lj1-f171.google.com. [209.85.208.171])
        by smtp.gmail.com with ESMTPSA id q18sm4663619lfm.81.2019.04.26.09.43.50
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 26 Apr 2019 09:43:50 -0700 (PDT)
Received: by mail-lj1-f171.google.com with SMTP id h16so3474113ljg.11
        for <linux-kernel@vger.kernel.org>; Fri, 26 Apr 2019 09:43:50 -0700 (PDT)
X-Received: by 2002:a2e:960b:: with SMTP id v11mr24974175ljh.135.1556297029832;
 Fri, 26 Apr 2019 09:43:49 -0700 (PDT)
MIME-Version: 1.0
References: <20190425174739.27604-1-idryomov@gmail.com> <CAHk-=wgPBx9xPWY7obK60=RTnOF3Ln0j9XkhYbekML=Fi3bFXg@mail.gmail.com>
 <342ef35feb1110197108068d10e518742823a210.camel@kernel.org>
 <20190425200941.GW2217@ZenIV.linux.org.uk> <86674e79e9f24e81feda75bc3c0dd4215604ffa5.camel@kernel.org>
 <CAHk-=wiaZoELovfo4gkfxB0zi6k5pQJNkmSRsEoWYr_z-oupiQ@mail.gmail.com>
In-Reply-To: <CAHk-=wiaZoELovfo4gkfxB0zi6k5pQJNkmSRsEoWYr_z-oupiQ@mail.gmail.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Fri, 26 Apr 2019 09:43:33 -0700
X-Gmail-Original-Message-ID: <CAHk-=wj2h5XWt1+NuVdiBPmzQMrZHxs6zLkKquU1OvpxBGNS7w@mail.gmail.com>
Message-ID: <CAHk-=wj2h5XWt1+NuVdiBPmzQMrZHxs6zLkKquU1OvpxBGNS7w@mail.gmail.com>
Subject: Re: [GIT PULL] Ceph fixes for 5.1-rc7
To:     Jeff Layton <jlayton@kernel.org>
Cc:     Al Viro <viro@zeniv.linux.org.uk>,
        Ilya Dryomov <idryomov@gmail.com>, ceph-devel@vger.kernel.org,
        Linux List Kernel Mailing <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 26, 2019 at 9:36 AM Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> On Fri, Apr 26, 2019 at 9:25 AM Jeff Layton <jlayton@kernel.org> wrote:
> >
> > Is it really ok to union the count and rcu_head there?
>
> It should be fine, because the rcu_count should only ever be used once
                                     ^^^^^

that should be 'head' of course.

              Linus "duh" Torvalds
