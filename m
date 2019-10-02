Return-Path: <SRS0=zem1=X3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 23F2EC35280
	for <linux-kernel@archiver.kernel.org>; Wed,  2 Oct 2019 03:42:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E58FB2086A
	for <linux-kernel@archiver.kernel.org>; Wed,  2 Oct 2019 03:42:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="qFyG9DZQ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729836AbfJBDmp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 1 Oct 2019 23:42:45 -0400
Received: from mail-lf1-f68.google.com ([209.85.167.68]:43040 "EHLO
        mail-lf1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729544AbfJBDmo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Oct 2019 23:42:44 -0400
Received: by mail-lf1-f68.google.com with SMTP id u3so11556270lfl.10;
        Tue, 01 Oct 2019 20:42:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=q94dRKz4b2ujZyKh9SewW/ndsUtNsYD4cEorXSz3XVw=;
        b=qFyG9DZQ7twICwXXtyaC33AGqD2ZcSCuLMQxI8xqX4oec3Qwc3VyjHiGEt8L/DTZJi
         HiqtYc+86a8ki6XHnCf0TSMpx7IlX3PD1ipdOrtkVSI55L/Y/SR2e/pvewiwbVINhhHa
         swRyAgh6ISWbnd2LhAK3/kDfPa8HEib9KcR8V2/b0M/1hLIVA3SiwptWp7EkEPczyojB
         z7vXDINXU9rhOo+NbF2vo82ZkYm84zmyIxQ59zJE3Qbva9aWipwjT8zSTY+R8LYBA5jD
         i3ijX/Fj/Pv5H0LXiweDAmp+H7HK/Dc3L1H4nTanQk5V2MFRuaZxSHR+Zwwc3thJ3L2b
         0sCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=q94dRKz4b2ujZyKh9SewW/ndsUtNsYD4cEorXSz3XVw=;
        b=e87LEWFIfxeUfS7Q2oD/A/bramwqeUbpta9Pr3iFg4meLFIleCbTGxVIt5KJ45+87Y
         B6/lS+cPye1TUxkNqh3huebLj5z782qFNvSfqnO1teJ/75GeNlXbkg/sUIwNVuEyZi0q
         mplCQZrVAZ1rEHN6EvliS9ppOQO84CiqFfmRJDXjZiiGnPqh14eEiWWdhE/6H0R2qnVb
         0AmlTxI/t4ZF7+QzBguhD4idNK/wmInraZ2DUkO1KNIFk46zQe2UBTJCCnZQx6BSNGLo
         i4Y9stF0ljl5/D9wsJyHc6MNi2Ul9Mvma7pYxI9fYWDfCyjJGWEXUjbWMSg2OEUfEPoE
         T68g==
X-Gm-Message-State: APjAAAXSP/JbJZYSD/YWO8uG3EXn3CcuXUqWP0o0v2dqKZXTGfJbj7vg
        np+fK29uau7sE2MZ9+ck+PI1DjfTwbP8NLVMnQg=
X-Google-Smtp-Source: APXvYqyCQssuItLz9aYH+PDanYdN1gv8cCFPj0Upq+xJKeo7vnQlfhGfWPhMzayMe9UaPZ09ZW5jNHb3jIddpn6fdJ8=
X-Received: by 2002:a19:2d19:: with SMTP id k25mr700605lfj.76.1569987762302;
 Tue, 01 Oct 2019 20:42:42 -0700 (PDT)
MIME-Version: 1.0
References: <20191001173728.149786-1-brianvv@google.com> <20191001173728.149786-3-brianvv@google.com>
 <CAEf4BzYxs6Ace8s64ML3pA9H4y0vgdWv_vDF57oy3i-O_G7c-g@mail.gmail.com>
In-Reply-To: <CAEf4BzYxs6Ace8s64ML3pA9H4y0vgdWv_vDF57oy3i-O_G7c-g@mail.gmail.com>
From:   Brian Vazquez <brianvv.kernel@gmail.com>
Date:   Tue, 1 Oct 2019 20:42:30 -0700
Message-ID: <CABCgpaWbPN+2vSNdynHtmDxrgGbyzHa_D-y4-X8hLrQYbhTx=A@mail.gmail.com>
Subject: Re: [PATCH bpf 2/2] selftests/bpf: test_progs: don't leak server_fd
 in test_sockopt_inherit
To:     Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc:     Brian Vazquez <brianvv@google.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        "David S . Miller" <davem@davemloft.net>,
        Stanislav Fomichev <sdf@google.com>,
        open list <linux-kernel@vger.kernel.org>,
        Networking <netdev@vger.kernel.org>, bpf <bpf@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Thanks for reviewing the patches Andrii!

Although Daniel fixed them and applied them correctly.

On Tue, Oct 1, 2019 at 8:20 PM Andrii Nakryiko
<andrii.nakryiko@gmail.com> wrote:
>
> On Tue, Oct 1, 2019 at 10:40 AM Brian Vazquez <brianvv@google.com> wrote:
> >
>
> I don't think there is a need to add "test_progs:" to subject, "
> test_sockopt_inherit" is specific enough ;)
>
> > server_fd needs to be close if pthread can't be created.
>
> typo: closed
>
> >
> > Fixes: e3e02e1d9c24 ("selftests/bpf: test_progs: convert test_sockopt_inherit")
> > Cc: Stanislav Fomichev <sdf@google.com>
> > Signed-off-by: Brian Vazquez <brianvv@google.com>
> > ---
>
> Acked-by: Andrii Nakryiko <andriin@fb.com>
>
> >  tools/testing/selftests/bpf/prog_tests/sockopt_inherit.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/tools/testing/selftests/bpf/prog_tests/sockopt_inherit.c b/tools/testing/selftests/bpf/prog_tests/sockopt_inherit.c
> > index 6cbeea7b4bf16..8547ecbdc61ff 100644
> > --- a/tools/testing/selftests/bpf/prog_tests/sockopt_inherit.c
> > +++ b/tools/testing/selftests/bpf/prog_tests/sockopt_inherit.c
> > @@ -195,7 +195,7 @@ static void run_test(int cgroup_fd)
> >
> >         if (CHECK_FAIL(pthread_create(&tid, NULL, server_thread,
> >                                       (void *)&server_fd)))
> > -               goto close_bpf_object;
> > +               goto close_server_fd;
> >
> >         pthread_mutex_lock(&server_started_mtx);
> >         pthread_cond_wait(&server_started, &server_started_mtx);
> > --
> > 2.23.0.444.g18eeb5a265-goog
> >
