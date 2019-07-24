Return-Path: <SRS0=3iFO=VV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D4BFBC76186
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Jul 2019 17:51:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ABDB521951
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Jul 2019 17:51:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=brauner.io header.i=@brauner.io header.b="faPCG4Ic"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728011AbfGXRvA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Jul 2019 13:51:00 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:45582 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726593AbfGXRu7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Jul 2019 13:50:59 -0400
Received: by mail-pg1-f193.google.com with SMTP id o13so21575767pgp.12
        for <linux-kernel@vger.kernel.org>; Wed, 24 Jul 2019 10:50:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=brauner.io; s=google;
        h=date:user-agent:in-reply-to:references:mime-version
         :content-transfer-encoding:subject:to:cc:from:message-id;
        bh=U7Eune/8zAVuopEZ4znflpHQloi7i3WwOpZdcTKXAtw=;
        b=faPCG4Icu73tPWhaSKzXXleFM7v0RLQHzpXK/9FqsRtHV0YhT3JkTFBxhJj2JJxhhB
         R9RCz243EE3JuAt02JRiSSB05PPozCsJKBtgo6U+6x5Z4Cz8ELDXDEHPVWIyVstUlVrA
         htyhbg7aqrxS9yjqRZrRRUwvLxTpYaSz1R0xFM5U+G9K8z5snfQTAwkKU4/W5XGznxqh
         2LHp/0rNA8hgzJa6tU4s/MkGpa9tfC+ze3UvF2seaWqaKRE9eKAODH22jiBmtEgmyht/
         dDU5YoU4GgpMl7YTrQ/6inaURuM79fg23ZHvxyghB109WVgs/oBVk9/ZkhaFhQpReg1G
         CMcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:user-agent:in-reply-to:references
         :mime-version:content-transfer-encoding:subject:to:cc:from
         :message-id;
        bh=U7Eune/8zAVuopEZ4znflpHQloi7i3WwOpZdcTKXAtw=;
        b=Z/6d+EIFn3iqDAQ3ChIDdoYo3CsbNwz33LrHBuZtqInOSH5XPcqFmqiNTd4fpaV2l/
         zZN3s9DfpHDuM7EuGMGaG3s2REffeyzlr4+Sj+hWmANpL+2vh423d9Zx3HohwyHcKlEc
         5IHHDLDXcEI0SmFnTtOvQTMd+ep148nAsmaXlKokCJ8kPB7aEWSkjVJY4DTuXw8BQQ5M
         X/xxXDItlk0ykLeaKQOiN4lZMT1DoRbamPptf5158RosaQ1iKDbv9EDFcUEgm5ykldvj
         34wG0+evEOWG7cQOn5ydI2DmFsoE12es2Z5iXVM/BmgR29aJ75Yvr8EnY4VWReRHHTAb
         BcVA==
X-Gm-Message-State: APjAAAXxe550NkpbHjggHO6Zex81FdC8D6I5IHJ+PgCScWgdCaFkgOPV
        2YHbZhjrN84HWRHhb8xZGGI=
X-Google-Smtp-Source: APXvYqxYg1bPHXo/qNgG9lWQv3PEC9/yMJxShLI9EEzdd+wYcoYvNKFNT8Z6ZwfJZpGtXPRFW4Z6jQ==
X-Received: by 2002:a63:5945:: with SMTP id j5mr82124622pgm.452.1563990658681;
        Wed, 24 Jul 2019 10:50:58 -0700 (PDT)
Received: from [25.171.251.59] ([172.58.27.54])
        by smtp.gmail.com with ESMTPSA id i6sm50042071pgi.40.2019.07.24.10.50.56
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 24 Jul 2019 10:50:57 -0700 (PDT)
Date:   Wed, 24 Jul 2019 19:50:49 +0200
User-Agent: K-9 Mail for Android
In-Reply-To: <CAHk-=whZPKzbPQftNGFB=iaSZGTSXNkhUASWF2V53MwB+A4zAQ@mail.gmail.com>
References: <20190724144651.28272-1-christian@brauner.io> <20190724144651.28272-3-christian@brauner.io> <CAHk-=whZPKzbPQftNGFB=iaSZGTSXNkhUASWF2V53MwB+A4zAQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH 2/5] pidfd: add pidfd_wait()
To:     Linus Torvalds <torvalds@linux-foundation.org>
CC:     Linux List Kernel Mailing <linux-kernel@vger.kernel.org>,
        Oleg Nesterov <oleg@redhat.com>, Arnd Bergmann <arnd@arndb.de>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        Kees Cook <keescook@chromium.org>,
        Joel Fernandes <joel@joelfernandes.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Tejun Heo <tj@kernel.org>, David Howells <dhowells@redhat.com>,
        Jann Horn <jannh@google.com>,
        Andrew Lutomirski <luto@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Aleksa Sarai <cyphar@cyphar.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Android Kernel Team <kernel-team@android.com>,
        Linux API <linux-api@vger.kernel.org>
From:   Christian Brauner <christian@brauner.io>
Message-ID: <95CD0533-576F-4B3A-8E80-D3D89967EE2C@brauner.io>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On July 24, 2019 7:45:38 PM GMT+02:00, Linus Torvalds <torvalds@linux-found=
ation=2Eorg> wrote:
>On Wed, Jul 24, 2019 at 7:47 AM Christian Brauner
><christian@brauner=2Eio> wrote:
>>
>> This adds the pidfd_wait() syscall=2E
>
>I despise this patch=2E
>
>Why can't this just be a new P_PIDFD flag, and then use
>"waitid(P_PIDFD, pidfd, =2E=2E=2E);"
>
>Yes, yes, yes, I realize that "pidfd" is of type "int", and waitid()
>takes an argument of type pid_t, but it's the same type in the end,
>and it does seem like the whole *point* of "waitid()" is that
>"idtype_t idtype" which tells you what kind of ID you're passing it=2E
>
>               Linus

Well in that case we could add P_PIDFD=2E
But then I would like to _only_ enable it for waitid()=2E How's that sound=
?

Christian
