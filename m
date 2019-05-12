Return-Path: <SRS0=t4ha=TM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E3E52C04A6B
	for <linux-kernel@archiver.kernel.org>; Sun, 12 May 2019 10:51:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B47FB20C01
	for <linux-kernel@archiver.kernel.org>; Sun, 12 May 2019 10:51:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1557658270;
	bh=YBMHdCN5YlmAEwYJnIWMC90f2fh1HucmevIcoGnC4d0=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=qUkNch28AGi/OT2YcBnLWlN9MQHuu83KYPqryt1xA1g9LzVZ3ikq1K0Y0o+Tc0E1l
	 AXmrGPnigKcK49MN/RBQpfesR75YMQ4wRZp88xZKvbutEAaSMNhUJRnyWGHNYYy2aD
	 yUUOQe2aVtwBioe8zA0KgLp1G0fxXHnQEm6mu3o0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726691AbfELKvJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 12 May 2019 06:51:09 -0400
Received: from mail-lj1-f193.google.com ([209.85.208.193]:35882 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726375AbfELKvJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 12 May 2019 06:51:09 -0400
Received: by mail-lj1-f193.google.com with SMTP id z1so8510999ljb.3
        for <linux-kernel@vger.kernel.org>; Sun, 12 May 2019 03:51:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=EBbnEnlSGI+YZhytxcBPyDwhUUf9hqUjJsyebbdCrcw=;
        b=Bwee6W/aqjF3RtU9Pd++GRfF0phoAIMfmTwaL+3Nu8NDs6Et4DPm/F1C0PX7+IyOUI
         fj41FT6ceV5M+P7SetVJPMyYDB7uFUcFKruvefh1bd2kvdataPMuobAmTp0v5Vb33/n5
         WE2FQvUPk2ZhdYv1biJYsS7ilv3mBt2dX5GKU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=EBbnEnlSGI+YZhytxcBPyDwhUUf9hqUjJsyebbdCrcw=;
        b=E1gtHE97UI/btrCJ0ZlD8+Gx/H29+e23a835VCV0VqN7sQjdJoD6J+B7ayV6JrIhXh
         symnBoAWSzwceMhRHsr4d8+xHpaHE/cx2qe6CsF6q5YUGav5pBCEZtLvbKdsfS+3qOtD
         moJxEcH4jjwCBcxz2/Xk2Lsn4Gp5B3Xa1UUkUEkEVGHq3RQveUZGsOOlyXpQerGu7nlv
         TBkf7udEKTHIDBo1PGU9KDWsJxzrxWo4HQHOIOGEXCufjC0R02TZcQjCq7YAp1239zUQ
         ZTR2MpGyRxOH2IDQPGOCmaJ8sw/swXkDSE6uu1dHSW0HuNTA6CYmbqUuDrVmaovJluPi
         i0mQ==
X-Gm-Message-State: APjAAAUBQywZPdRtwZjMALhw9MsGrKrFMXt/OmGvKxHESc9WPPgBEpto
        6HlTblr2pYnisTz8lMKbIBYqK2K0EJU=
X-Google-Smtp-Source: APXvYqwcPvj2z+tEM66MYXyt5p+KRDOOf+EgVgfzsZ1/K+Kq1eA0LN9vE+o+ZBubeJZRbBILqHrw1w==
X-Received: by 2002:a2e:980f:: with SMTP id a15mr10767269ljj.131.1557658266499;
        Sun, 12 May 2019 03:51:06 -0700 (PDT)
Received: from mail-lf1-f50.google.com (mail-lf1-f50.google.com. [209.85.167.50])
        by smtp.gmail.com with ESMTPSA id k10sm2536822ljh.86.2019.05.12.03.51.06
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 12 May 2019 03:51:06 -0700 (PDT)
Received: by mail-lf1-f50.google.com with SMTP id y19so6995169lfy.5
        for <linux-kernel@vger.kernel.org>; Sun, 12 May 2019 03:51:06 -0700 (PDT)
X-Received: by 2002:a19:ca02:: with SMTP id a2mr10604583lfg.88.1557657862375;
 Sun, 12 May 2019 03:44:22 -0700 (PDT)
MIME-Version: 1.0
References: <20190506165439.9155-1-cyphar@cyphar.com> <20190506165439.9155-6-cyphar@cyphar.com>
 <CAG48ez0-CiODf6UBHWTaog97prx=VAd3HgHvEjdGNz344m1xKw@mail.gmail.com>
 <20190506191735.nmzf7kwfh7b6e2tf@yavin> <20190510204141.GB253532@google.com>
 <CALCETrW2nn=omqJb4p+m-BDsCOhg+YZQ3ELd4BdhODV3G44gfA@mail.gmail.com>
 <20190510225527.GA59914@google.com> <C60DC580-854D-478D-AF23-5F29FB7C3E50@amacapital.net>
 <CAHk-=wh1JJD_RabMaFfinsAQp1vHGJOQ1rKqihafY=r7yHc8sQ@mail.gmail.com>
 <CALCETrUOj=4VWp=B=QT0BQ8X_Ds_b+pt68oDwfjGb+K0StXmWA@mail.gmail.com>
 <CAHk-=wg3+3GfHsHdB4o78jNiPh_5ShrzxBuTN-Y8EZfiFMhCvw@mail.gmail.com> <9CD2B97D-A6BD-43BE-9040-B410D996A195@amacapital.net>
In-Reply-To: <9CD2B97D-A6BD-43BE-9040-B410D996A195@amacapital.net>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Sun, 12 May 2019 06:44:06 -0400
X-Gmail-Original-Message-ID: <CAHk-=wh3dT7=SMjvSZreXSu36Cg7gsfSipLhfTz5ioDKXV5uHg@mail.gmail.com>
Message-ID: <CAHk-=wh3dT7=SMjvSZreXSu36Cg7gsfSipLhfTz5ioDKXV5uHg@mail.gmail.com>
Subject: Re: [PATCH v6 5/6] binfmt_*: scope path resolution of interpreters
To:     Andy Lutomirski <luto@amacapital.net>
Cc:     Andrew Lutomirski <luto@kernel.org>, Jann Horn <jannh@google.com>,
        Aleksa Sarai <cyphar@cyphar.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Jeff Layton <jlayton@kernel.org>,
        "J. Bruce Fields" <bfields@fieldses.org>,
        Arnd Bergmann <arnd@arndb.de>,
        David Howells <dhowells@redhat.com>,
        Eric Biederman <ebiederm@xmission.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        Christian Brauner <christian@brauner.io>,
        Tycho Andersen <tycho@tycho.ws>,
        David Drysdale <drysdale@google.com>,
        Chanho Min <chanho.min@lge.com>,
        Oleg Nesterov <oleg@redhat.com>, Aleksa Sarai <asarai@suse.de>,
        Linux Containers <containers@lists.linux-foundation.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Linux API <linux-api@vger.kernel.org>,
        kernel list <linux-kernel@vger.kernel.org>,
        linux-arch <linux-arch@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, May 11, 2019 at 7:37 PM Andy Lutomirski <luto@amacapital.net> wrote:
>
> I bet this will break something that already exists. An execveat() flag to turn off /proc/self/exe would do the trick, though.

Thinking more about it, I suspect it is (once again) wrong to let the
thing that does the execve() control that bit.

Generally, the less we allow people to affect the lifetime and
environment of a suid executable, the better off we are.

But maybe we could limit /proc/*/exe to at least not honor suid'ness
of the target? Or does chrome/runc depend on that too?

             Linus
