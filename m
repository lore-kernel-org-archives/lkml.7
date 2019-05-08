Return-Path: <SRS0=J8hU=TI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DB564C04A6B
	for <linux-kernel@archiver.kernel.org>; Wed,  8 May 2019 18:06:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AF8CD216C4
	for <linux-kernel@archiver.kernel.org>; Wed,  8 May 2019 18:06:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1557338818;
	bh=+WARn8KDgoN5IMWkgoAFzDg6McPbfQdHYfT0sLVSM60=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=C+n3XUxBoAhxGLxxKnFm+qNZ81L2p5++uMAR0ZJbom1OKOWdlDBo+YpO21c16M42R
	 vIbxx8jPNWAiUUUzLi1NmV/knQ9r/1bOnnV406xJeGGuDfjJpH9/hUAtbK4sWzusm6
	 w8E135MOBAObzYchHgRb/yoOChBEfc2oKrsSQDo8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727685AbfEHSG5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 8 May 2019 14:06:57 -0400
Received: from mail-lj1-f194.google.com ([209.85.208.194]:33532 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727297AbfEHSG5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 May 2019 14:06:57 -0400
Received: by mail-lj1-f194.google.com with SMTP id f23so18321400ljc.0
        for <linux-kernel@vger.kernel.org>; Wed, 08 May 2019 11:06:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=StoLT6n6x/EKa+hOFwd7tcX3z/oXXRB4YXDAJE+FJf8=;
        b=iG3v/2Xz0X6FPhx3ghsSHLQ7s2hwg6UZbig1Km6XbMOm/asgx9ExfslkY8xiL4OWXn
         nl5Hn5H6q6hqen8+G8rBXsn2EVgxIWl/sg6iseQ1OgevPMnlviQYImLiwUFaHqS77uoK
         DmlKY4PWyFEatSNxK4wxrdFlUyPKxAyudc2EY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=StoLT6n6x/EKa+hOFwd7tcX3z/oXXRB4YXDAJE+FJf8=;
        b=ALiPBrFZCFHKaoTrlls3aNHfkyseQl1tVdDPS81AaUbc1RewmVS7TQpYWqFN5rLJ+c
         caOW4aECSbY2NZI/2C4lg4zZuaFpm3+5WloV1xx/IBv8twLc+mb0U96T2vHxqATPev+e
         XsCmmBaYluxaoXUe7HS6jNQX8hgSeyZvSuNagYCLLcoWajAxnZ8tb4u0f7zTDX5LU+yQ
         QeOVqB7HeE77v8mjDJoQr5xUovGNUQEtnRGLbu5CdqNoL5lwCe1GLOb6cZfPUAcJvRRa
         u+QvcLIh4OBjV4h8U91lN8lLak9ZK0aaTdBknoozxtF7ZdEvMU5ctYxKKsVZDW+MEBS2
         Xk9A==
X-Gm-Message-State: APjAAAVlKEQvy0lOh3JB1JIAaszCVD+kYEmkcAseBRvpPhtD5+ZOWAgr
        4ZtnIjR3NcNg3VSEwkksF1nPVeKhDs4=
X-Google-Smtp-Source: APXvYqxiYbKWV1dQLOO3m0IzWva4UX8PNk1LMIJqx8S2VJrxZ8VWErDPIkyLbdD1lXhcrGn+Xs1scg==
X-Received: by 2002:a2e:74f:: with SMTP id i15mr1891435ljd.156.1557338814778;
        Wed, 08 May 2019 11:06:54 -0700 (PDT)
Received: from mail-lj1-f175.google.com (mail-lj1-f175.google.com. [209.85.208.175])
        by smtp.gmail.com with ESMTPSA id g66sm3368713lje.88.2019.05.08.11.06.53
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 08 May 2019 11:06:53 -0700 (PDT)
Received: by mail-lj1-f175.google.com with SMTP id r76so7219693lja.12
        for <linux-kernel@vger.kernel.org>; Wed, 08 May 2019 11:06:53 -0700 (PDT)
X-Received: by 2002:a2e:801a:: with SMTP id j26mr12588727ljg.2.1557338813410;
 Wed, 08 May 2019 11:06:53 -0700 (PDT)
MIME-Version: 1.0
References: <CAHc6FU5Yd9EVju+kY8228n-Ccm7F2ZBRJUbesT-HYsy2YjKc_w@mail.gmail.com>
 <CAHk-=wj_L9d8P0Kmtb5f4wudm=KGZ5z0ijJ-NxTY-CcNcNDP5A@mail.gmail.com>
In-Reply-To: <CAHk-=wj_L9d8P0Kmtb5f4wudm=KGZ5z0ijJ-NxTY-CcNcNDP5A@mail.gmail.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Wed, 8 May 2019 11:06:37 -0700
X-Gmail-Original-Message-ID: <CAHk-=whbrADQrEezs=-t0QsKw-qaVU_2s2DqxLAkcczxc62SLQ@mail.gmail.com>
Message-ID: <CAHk-=whbrADQrEezs=-t0QsKw-qaVU_2s2DqxLAkcczxc62SLQ@mail.gmail.com>
Subject: Re: GFS2: Pull Request
To:     Andreas Gruenbacher <agruenba@redhat.com>
Cc:     cluster-devel <cluster-devel@redhat.com>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 8, 2019 at 10:55 AM Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> See what I'm saying? You would ask me to pull the un-merged state, but
> then say "I noticed a few merge conflicts when I did my test merge,
> and this is what I did" kind of aside.

Side note: this is more important if you know of a merge issue that
doesn't cause a conflict, and that I won't see in my simple build
tests.

For example, in this case, the merge issue doesn't cause a conflict
(because it's a totally new user of bio_for_each_segment_all() and the
syntax changed in another branch), but I see it trivially when I do a
test build, since the compiler spews out lots of warnings, and so I
can trivially fix it up (and you _mentioning_ the issue gives me the
heads up that you knew about it and what it's all about).

But if it's other architectures, or only happens under special config
options etc, I might not have seen the merge issue at all. And then
it's really good if the maintainer talks about it and shows that yes,
the maintainer knows what he's doing.

Now I'm in the situation where I have actually done the merge the way
I *like* doing them, and without your superfluous merge commit. But if
I use my merge, I'll lose the signature from your tag, because you
signed *your* merge that I didn't actually want to use at all.

See? Your "helpful" merge actually caused me extra work, and made me
have to pick one of two *worse* situations than if you had just tagged
your own development tree. Either my tree has a extra pointless merge
commit, or my tree lacks your signature on your work.

I'll just undo my pull, and delay it all in the hope that you'll just
send me a new signed tag of the non-merged state.

                   Linus
