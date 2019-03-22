Return-Path: <SRS0=oArh=RZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 652B0C43381
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 02:39:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2AF9E218FC
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 02:39:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RgLIpzE4"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727497AbfCVCjo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Mar 2019 22:39:44 -0400
Received: from mail-lf1-f67.google.com ([209.85.167.67]:33309 "EHLO
        mail-lf1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727162AbfCVCjo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Mar 2019 22:39:44 -0400
Received: by mail-lf1-f67.google.com with SMTP id v14so408002lfi.0;
        Thu, 21 Mar 2019 19:39:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=pwD2RVsTxKa166T4kF+VoEuutBIKfhZxp4PVbEWn8wM=;
        b=RgLIpzE4Rzbw90POerCf3ia0RQ/T5FNj317Gk0v3nSnmrgMQo4ZWziTGOcVjCvUY6a
         FIPsIXOT9b1M9AewoQWQrJff1ttW+IO/kJJDMi6jqz31ge/oYpCgfLQUxq0C1DgXGqkS
         XPcRNxWSCaMH5kGuhEpWICFYn/NeUVLUIs0cdUZKm6Ta3Tjt0vw4Hmdr+zGvazFI+dnP
         Fdc93TO+VAx0FRv0LCpDkC1crooT4sPdTAKG9qiX9uE17hg37+YXMbzvWDS/QZ+qw/20
         GBX6Ka6bXNnmFkwma9cvhqFLLvKsjq6YbIvrXD48gv+ARb/ZO0FHkFIxSNN4SIz7uNBd
         Gv0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=pwD2RVsTxKa166T4kF+VoEuutBIKfhZxp4PVbEWn8wM=;
        b=M3XLkZJRsdkQ7s2VyQOyPSQf5aCrkErNPFwI5F+7VGvWB1RvdGC922f7lSg9A+xpC5
         JA4hv0zB6ASR3pqWu02GgsOs3bFg9MNbQh6mJMDWHDGSGXI16uxwnau3nD/3FsbOpfEa
         qbptLqKwIPOEssCnSsHiJ6L/ZXW9EOJ7i3NTzShb3aFhHuQAlH1ewvEhiPjGCoo2hboB
         ttqDREthEP8xFLtKqIZN5f4SXnTtGpzZddf4SSH/QoM7NC5bJxjIPEjdL1XFH5/F2QCd
         bj6ceV8iLiVmkhie7HT1MmvZQIHGDQkAjk1KRJO+Qhsvhi3e5jd/FfTmJvDHAC6qLkxH
         3lKw==
X-Gm-Message-State: APjAAAUwzQUm1EGKEi3q3z0/MwSJI24GgSBnGZf1dTFz7XGtXGRuEmzY
        wuZtmSAHc+9nl/V1iwbAKUbPw93qDBHM5p5DnslKsQ==
X-Google-Smtp-Source: APXvYqxSKxWM8/oA/8waV3x419LVmQh9cUX2H/hLzrUnhS/nr+ExMkCKUD+BpdAeit2gMClGMTapQ2/AFcaPzXqMReA=
X-Received: by 2002:a19:40c8:: with SMTP id n191mr3730734lfa.22.1553222381597;
 Thu, 21 Mar 2019 19:39:41 -0700 (PDT)
MIME-Version: 1.0
References: <20190315200414.32346-1-ivecera@redhat.com>
In-Reply-To: <20190315200414.32346-1-ivecera@redhat.com>
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date:   Thu, 21 Mar 2019 19:39:30 -0700
Message-ID: <CAADnVQKBWXNzbDwAveUwgoBQe8TuHqTSH049JZmC9aBtnPGMhA@mail.gmail.com>
Subject: Re: [PATCH net-next] selftests: bpf: modify urandom_read and link it non-statically
To:     Ivan Vecera <ivecera@redhat.com>
Cc:     Network Development <netdev@vger.kernel.org>,
        Shuah Khan <shuah@kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Martin KaFai Lau <kafai@fb.com>,
        Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>,
        "open list:BPF (Safe dynamic programs and tools)" 
        <bpf@vger.kernel.org>, open list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 15, 2019 at 1:04 PM Ivan Vecera <ivecera@redhat.com> wrote:
>
> After some experiences I found that urandom_read does not need to be
> linked statically. When the 'read' syscall call is moved to separate
> non-inlined function then bpf_get_stackid() is able to find
> the executable in stack trace and extract its build_id from it.
>
> Signed-off-by: Ivan Vecera <ivecera@redhat.com>

Applied. Thanks
