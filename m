Return-Path: <SRS0=o7UO=TL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 282BFC04AB1
	for <linux-kernel@archiver.kernel.org>; Sat, 11 May 2019 17:49:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 001A72183F
	for <linux-kernel@archiver.kernel.org>; Sat, 11 May 2019 17:49:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=brauner.io header.i=@brauner.io header.b="RFt36aKW"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726260AbfEKRs7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 11 May 2019 13:48:59 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:46874 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726121AbfEKRs7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 11 May 2019 13:48:59 -0400
Received: by mail-pf1-f194.google.com with SMTP id y11so4903851pfm.13
        for <linux-kernel@vger.kernel.org>; Sat, 11 May 2019 10:48:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=brauner.io; s=google;
        h=date:user-agent:in-reply-to:references:mime-version
         :content-transfer-encoding:subject:to:cc:from:message-id;
        bh=P4y88h0juv/wSdSJ+5tYBt22omcjz7XQLON95qdiSUs=;
        b=RFt36aKWzpvo0FHSxCMxH0MRXX/4bwWQVo9yhWfBqmD/Gmcl/Qspvke8IM4iMCDkLw
         cYMJQnRF4KleONc2nVeG53KfTjPQdB8eXF08CT9E2UEv0GJkyHzVt3nvPidolKI1C2fv
         CNNzthL42YeTTJbhoYAmHlRi4qc5nM9AEiqrWQ3ieuRscYJab+2nRNKf4GBnzAAm8WE3
         hz/Lz0cuatbQBVxD/cFF+YI8ALATseC5tWTFIwWDV66DRAoKAXDbzftCQ26+NYzpJ3Zh
         hzpJPLfmck7XRJt5tU2kCyp0fF1y4r/vbdq1tLppsV5yE+VOA1RcLQKEuznbXWAQ7Kv0
         1Ceg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:user-agent:in-reply-to:references
         :mime-version:content-transfer-encoding:subject:to:cc:from
         :message-id;
        bh=P4y88h0juv/wSdSJ+5tYBt22omcjz7XQLON95qdiSUs=;
        b=oR8BMplDNJf722KJyA5j3yQUXHu/TSuB8xOMjxzavvKA7eW6WfV9OshpfiBlT/+bQ9
         KOS+RYIbw2bJXy+abIEJ3JXcqozAjYws4MMY7tkf648Y2QNf+JBuheageCAZkkOJ4leQ
         dy9Z/Q9hiw06YqA15ry56QU1e/1v7xM2qbMLg7BLdWt0Wuq3CNFRiQ/kP42qKfi1QVTM
         GkP2RkVhtr0SrrEZcSO4SKNRQa3AMM7rERPM25s5brcqkPAyq1tqJkvhIhTX1i49G6jk
         0iL9wNbgmduzVA57sIPDNLLTlxfnmpjTO1aBuhtKHOIVDBSZSemguORxdejLukWv6Fo3
         mizw==
X-Gm-Message-State: APjAAAVt0xt1t9VCHszr95n2phWrPJtw/GaxG2gio5/T/MoLlu9XwHip
        5GfqampUW83/QGqhhos3WJZiCQ==
X-Google-Smtp-Source: APXvYqxM9wGNf6ooBA7Hi+m5FSX/PWzUkqapgRlWwOaMAo+Z5saYjd0/lmwrSD+F/NGnNfOtkZIvZQ==
X-Received: by 2002:a65:60cd:: with SMTP id r13mr7213542pgv.58.1557596938251;
        Sat, 11 May 2019 10:48:58 -0700 (PDT)
Received: from [25.171.29.203] ([172.56.30.186])
        by smtp.gmail.com with ESMTPSA id f5sm4212739pfn.161.2019.05.11.10.48.56
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 11 May 2019 10:48:57 -0700 (PDT)
Date:   Sat, 11 May 2019 19:48:47 +0200
User-Agent: K-9 Mail for Android
In-Reply-To: <CAHk-=wgo-X9pDbVf8khfDsgEKn3wSvLJkB890OxHL+42Hosypw@mail.gmail.com>
References: <20190506165439.9155-1-cyphar@cyphar.com> <20190506165439.9155-6-cyphar@cyphar.com> <CAG48ez0-CiODf6UBHWTaog97prx=VAd3HgHvEjdGNz344m1xKw@mail.gmail.com> <20190506191735.nmzf7kwfh7b6e2tf@yavin> <20190510204141.GB253532@google.com> <CALCETrW2nn=omqJb4p+m-BDsCOhg+YZQ3ELd4BdhODV3G44gfA@mail.gmail.com> <20190510225527.GA59914@google.com> <C60DC580-854D-478D-AF23-5F29FB7C3E50@amacapital.net> <CAHk-=wh1JJD_RabMaFfinsAQp1vHGJOQ1rKqihafY=r7yHc8sQ@mail.gmail.com> <CAHk-=whOL-NBso8X5S8s597yZEOMBoU8chkMFVTi8b-ff2qARg@mail.gmail.com> <20190511173113.qhqmv5q5f74povix@yavin> <CAHk-=wgo-X9pDbVf8khfDsgEKn3wSvLJkB890OxHL+42Hosypw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH v6 5/6] binfmt_*: scope path resolution of interpreters
To:     Linus Torvalds <torvalds@linux-foundation.org>,
        Aleksa Sarai <cyphar@cyphar.com>
CC:     Andy Lutomirski <luto@amacapital.net>,
        Jann Horn <jannh@google.com>,
        Andy Lutomirski <luto@kernel.org>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Jeff Layton <jlayton@kernel.org>,
        "J. Bruce Fields" <bfields@fieldses.org>,
        Arnd Bergmann <arnd@arndb.de>,
        David Howells <dhowells@redhat.com>,
        Eric Biederman <ebiederm@xmission.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        Tycho Andersen <tycho@tycho.ws>,
        David Drysdale <drysdale@google.com>,
        Chanho Min <chanho.min@lge.com>,
        Oleg Nesterov <oleg@redhat.com>, Aleksa Sarai <asarai@suse.de>,
        Linux Containers <containers@lists.linux-foundation.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Linux API <linux-api@vger.kernel.org>,
        kernel list <linux-kernel@vger.kernel.org>,
        linux-arch <linux-arch@vger.kernel.org>
From:   Christian Brauner <christian@brauner.io>
Message-ID: <3DFB2DAE-C66F-427D-BF0A-EB31DC590B4D@brauner.io>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On May 11, 2019 7:43:44 PM GMT+02:00, Linus Torvalds <torvalds@linux-founda=
tion=2Eorg> wrote:
>On Sat, May 11, 2019 at 1:31 PM Aleksa Sarai <cyphar@cyphar=2Ecom> wrote:
>>
>> Yup, I've dropped the patch for the next version=2E (To be honest, I'm
>not
>> sure why I included any of the other flags -- the only one that
>would've
>> been necessary to deal with CVE-2019-5736 was AT_NO_MAGICLINKS=2E)
>
>I do wonder if we could try to just set AT_NO_MAGICLINKS
>unconditionally for execve() (and certainly for the suid case)=2E
>
>I'd rather try to do these things across the board, than have "suid
>binaries are treated specially" if at all possible=2E
>
>The main use case for having /proc/<pid>/exe thing is for finding open
>file descriptors, and for 'ps' kind of use, or to find the startup
>directory when people don't populate the execve() environment fully
>(ie "readlink(/proc/self/exe)" is afaik pretty common=2E
>
>Sadly, googling for
>
>    execve /proc/self/exe
>
>does actually find hits, including one that implies that chrome does
>exactly that=2E  So it might not be possible=2E
>
>Somewhat odd, but it does just confirm the whole "users will at some
>point do everything in their power to use every odd special case,
>intended or not"=2E
>
>                  Linus

Sadly I have to admit that we are using this=2E
Also, execveat on glibc is implemented via
/proc/self/fd/<nr> on kernels that do not
have a proper execveat=2E
See fexecve=2E=2E=2E

Christian
