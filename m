Return-Path: <SRS0=+gZy=2O=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CC0D4C2D0D2
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Dec 2019 06:38:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A1716206B7
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Dec 2019 06:38:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="sNTmKKz7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726184AbfLXGis (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 24 Dec 2019 01:38:48 -0500
Received: from mail-qt1-f193.google.com ([209.85.160.193]:40739 "EHLO
        mail-qt1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726043AbfLXGis (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Dec 2019 01:38:48 -0500
Received: by mail-qt1-f193.google.com with SMTP id e6so17419707qtq.7;
        Mon, 23 Dec 2019 22:38:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=+8SgjfTKtbI/OsvUe4mDJhPn/RjOhvVH4HFrW8MrWgU=;
        b=sNTmKKz7flm2ceZzkOzoqOS5wQkriTkJx8gt7PxuNX5V+6hxXlo1Ye1Na6xFLRf0JX
         s1TrQvfXI7hriHQegYNCMgFkXI0NogCAAh8+PjaCRlK8+PXMoBl5/tE17Ccz+ZaVxARj
         Nay1eYH1hlPPOBC0AWZ/HGxZq10sF5e4MHoJ+Ofd8j8WHyYERQFgxUxkqUtQg5eRMdcx
         oE3LoGlhJRxIf3InQFIyzGJJFf/DixZD3eV1A8eAAJjgQOJ5UUxsE9kQkKaYIQp6KB+J
         T1+jqhzYlGB36JUm8D33o81McLlDJyZuL2xPEjXOPgX9hq4ehMLCvMx6J1jXno1Dg1z9
         GyeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=+8SgjfTKtbI/OsvUe4mDJhPn/RjOhvVH4HFrW8MrWgU=;
        b=VfFDlf+ewWYraFqQAZuWRYuQYMJodZLcOJdjJL85Wr2XgN2CNQYZ0PL8zbP+tVDFb4
         971sHlBocZRYUUVgzooSPpcahiPLHYs6xDSqnDMhoLpKGVqjyU//LlSBFg1ZNPe337Hs
         m4nOGWrjoLvm83SPdyW3YljuYz8BzL0xuIx75HXv8EInzSiOSnESNHnVPa5vQd+KDtrj
         lGl3K21+pQ+uSzU/ZcXMFyvScadEWHmxqhqsdmNbE6+1KkJ3DXbgulzP1gkQEQkc6Oyp
         5k8Ui2TRoD3FfF/05sweA7eQguDXLjF6298Vdf1IvyABuxhO8XgcNSsO4ZUyR6J71+FJ
         IGLQ==
X-Gm-Message-State: APjAAAV76ei0Zh1GDo4CWN8mmPyIjmohjcup7RooLzEnIsD6H5e0yJ++
        jz2INwWgW/veGmeNYXyx5+VBY3MMT6vu5Ea5isE=
X-Google-Smtp-Source: APXvYqzNKApi9fGOk0dJj8+JFyxqumG+OcAs4M2DFo3CrQOrjqhe//xgMkubxtcvWNsOnIkuFcBkbp712JaE+YsZQiY=
X-Received: by 2002:ac8:4050:: with SMTP id j16mr25335033qtl.171.1577169526952;
 Mon, 23 Dec 2019 22:38:46 -0800 (PST)
MIME-Version: 1.0
References: <20191220154208.15895-1-kpsingh@chromium.org> <20191220154208.15895-11-kpsingh@chromium.org>
In-Reply-To: <20191220154208.15895-11-kpsingh@chromium.org>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Mon, 23 Dec 2019 22:38:36 -0800
Message-ID: <CAEf4BzYLk4ozotVnFnhgahML+mnurqWUVtKOt3fDpAMghqGVLQ@mail.gmail.com>
Subject: Re: [PATCH bpf-next v1 10/13] bpf: lsm: Handle attachment of the same program
To:     KP Singh <kpsingh@chromium.org>
Cc:     open list <linux-kernel@vger.kernel.org>,
        bpf <bpf@vger.kernel.org>, linux-security-module@vger.kernel.org,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        James Morris <jmorris@namei.org>,
        Kees Cook <keescook@chromium.org>,
        Thomas Garnier <thgarnie@chromium.org>,
        Michael Halcrow <mhalcrow@google.com>,
        Paul Turner <pjt@google.com>,
        Brendan Gregg <brendan.d.gregg@gmail.com>,
        Jann Horn <jannh@google.com>,
        Matthew Garrett <mjg59@google.com>,
        Christian Brauner <christian@brauner.io>,
        =?UTF-8?B?TWlja2HDq2wgU2FsYcO8bg==?= <mic@digikod.net>,
        Florent Revest <revest@chromium.org>,
        Brendan Jackman <jackmanb@chromium.org>,
        Martin KaFai Lau <kafai@fb.com>,
        Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
        "Serge E. Hallyn" <serge@hallyn.com>,
        Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        Stanislav Fomichev <sdf@google.com>,
        Quentin Monnet <quentin.monnet@netronome.com>,
        Andrey Ignatov <rdna@fb.com>, Joe Stringer <joe@wand.net.nz>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 20, 2019 at 7:42 AM KP Singh <kpsingh@chromium.org> wrote:
>
> From: KP Singh <kpsingh@google.com>
>
> Allow userspace to attach a newer version of a program without having
> duplicates of the same program.
>
> If BPF_F_ALLOW_OVERRIDE is passed, the attachment logic compares the
> name of the new program to the names of existing attached programs. The
> names are only compared till a "__" (or '\0', if there is no "__"). If
> a successful match is found, the existing program is replaced with the
> newer attachment.
>
> ./loader Attaches "env_dumper__v1" followed by "env_dumper__v2"
> to the bprm_check_security hook..
>
> ./loader
> ./loader
>
> Before:
>
>   cat /sys/kernel/security/bpf/process_execution
>   env_dumper__v1
>   env_dumper__v2
>
> After:
>
>   cat /sys/kernel/security/bpf/process_execution
>   env_dumper__v2
>
> Signed-off-by: KP Singh <kpsingh@google.com>
> ---


Andrey Ignatov just posted patch set few days ago solving similar
problem for cgroup BPF programs. His approach was to actually also
specify FD of BPF program to be replaced. This seems like a more
reliable way than doing this based on name only. Please take a look at
that patch and see if same approach can work for your use case.

>  security/bpf/ops.c | 57 +++++++++++++++++++++++++++++++++++++++++++++-
>  1 file changed, 56 insertions(+), 1 deletion(-)
>

[...]
