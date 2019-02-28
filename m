Return-Path: <SRS0=g5d9=RD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1C401C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Feb 2019 13:26:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D95BA20C01
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Feb 2019 13:26:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="qK8WjVso"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732974AbfB1N0E (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Feb 2019 08:26:04 -0500
Received: from mail-wr1-f67.google.com ([209.85.221.67]:36118 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732143AbfB1N0A (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Feb 2019 08:26:00 -0500
Received: by mail-wr1-f67.google.com with SMTP id o17so21972322wrw.3;
        Thu, 28 Feb 2019 05:25:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=cc:subject:to:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=U0ez6pA4iB0pqG+CBmbvNhiiGJ1LYyk7Fn0cT+9YFOs=;
        b=qK8WjVso3l2NLBYQIJWGmgHfSsryWyRVShB3hTrYl3iLkU3A/IUkXw4O2rZdJMl9l/
         P3rpk+UJigDJqitA4JC58c5SEZsIT70dDRRnyXIK/ZGsFK1ZSEWNj4YFiIseoW85YZGx
         JUIhWOenKt+bbkmQyB3pF6rVE6c7kP8lzZznljqFaKA+6zftf+inhtjhKLUbNedHWyky
         jTULc7De2OpW+nz5jJxllxnDfRu6mpgXXDeafNPtdGiWRs1nMB894J796Elh4UQGo91A
         cWH/yjeMC6r8gJd6XC5iSx2wXEpnJ6io/0t4QeewEJCxYzNyADKjOkucUvlsnuxZ2Ocb
         owbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:cc:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=U0ez6pA4iB0pqG+CBmbvNhiiGJ1LYyk7Fn0cT+9YFOs=;
        b=kd1jrDAyz/9gVXrkMqR+jYuhj9QvI3MtoxQwNCPjpEtxlRwWcOFNi4+rs7vHOghVkW
         4zfJAdMe2aoDRaYjcOSW2GsyIhwp2NYut3jhy8AOVJwDD1FpDq8RMkfMFr8sjdZvGTcL
         oAdWzg0RT5cR+tbVnoCPzknz9sQxZ6OwxU5PQCNFRWZYYiXRzf1OFqB1rk0Ed9t8OSQ9
         zXKSZQsCWBcFrkldwCM+/NwO2Bg3CqUWZ1K8eGeJefuHyK2a7LvmH3vByS9x3nyjz7YX
         +y/npCRoUw6lpn94mUQQex5fUpQe1eZedOzP/KSKnXJnWDpFmrPkjPKTOscOAZDM2FPp
         tXqw==
X-Gm-Message-State: APjAAAX9o0aA15DXwxgvNUaLv+NWfGI50av305L1h00ttWDu5/5++2Wz
        vYAMcy+Y8btU4PWDyUNSteE=
X-Google-Smtp-Source: APXvYqwqQwmcKDHsLsbK/bdVbk17dFV7LJ7RxFCZsVRA4xtOnMHvVIhCjRnGM9UVeDrXVjeZXUiNCw==
X-Received: by 2002:adf:e80c:: with SMTP id o12mr6120550wrm.114.1551360357814;
        Thu, 28 Feb 2019 05:25:57 -0800 (PST)
Received: from [10.0.21.20] ([95.157.63.22])
        by smtp.gmail.com with ESMTPSA id u8sm24978737wrp.55.2019.02.28.05.25.55
        (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
        Thu, 28 Feb 2019 05:25:56 -0800 (PST)
Cc:     mtk.manpages@gmail.com, linux-man@vger.kernel.org,
        Kees Cook <keescook@chromium.org>,
        Linux API <linux-api@vger.kernel.org>,
        lkml <linux-kernel@vger.kernel.org>,
        Andy Lutomirski <luto@amacapital.net>,
        Jann Horn <jann@thejh.net>, Oleg Nesterov <oleg@redhat.com>,
        Christian Brauner <christian@brauner.io>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        Containers <containers@lists.linux-foundation.org>,
        Aleksa Sarai <asarai@suse.de>,
        Tyler Hicks <tyhicks@canonical.com>,
        Akihiro Suda <suda.akihiro@lab.ntt.co.jp>
Subject: Re: [PATCH 2/2] seccomp.2: document userspace notification
To:     Tycho Andersen <tycho@tycho.ws>,
        "Serge E. Hallyn" <serge@hallyn.com>
References: <20181213001106.15268-1-tycho@tycho.ws>
 <20181213001106.15268-3-tycho@tycho.ws>
 <2cea5fec-e73e-5749-18af-15c35a4bd23c@gmail.com>
From:   "Michael Kerrisk (man-pages)" <mtk.manpages@gmail.com>
Message-ID: <e7a5abd9-f7b7-e077-221a-4c3ef7b818df@gmail.com>
Date:   Thu, 28 Feb 2019 14:25:55 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.1
MIME-Version: 1.0
In-Reply-To: <2cea5fec-e73e-5749-18af-15c35a4bd23c@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> 7. The monitoring process can use the information in the
>    'struct seccomp_notif' to make a determination about the
>    system call being made by the target process. This
>    structure includes a 'data' field that is the same
>    'struct seccomp_data' that is passed to a BPF filter.
> 
>    In addition, the monitoring process may make use of other 
>    information that is available from user space. For example, 
>    it may inspect the memory of the target process (whose PID
>    is provided in the 'struct seccomp_notif') using
>    /proc/PID/mem, which includes inspecting the values
>    pointed to by system call arguments (whose location is
>    available 'seccomp_notif.data.args). However, when using
>    the target process PID in this way, one must guard against
>    PID re-use race conditions using the seccomp()
>    SECCOMP_IOCTL_NOTIF_ID_VALID operation.
> 
> 8. Having arrived at a decision about the target process's
>    system call, the monitoring process can inform the kernel
>    of its decision using the operation
> 
>        ioctl(listenfd, SECCOMP_IOCTL_NOTIF_SEND, respptr)
> 
>    where the third argument is a pointer to a
>    'struct seccomp_notif_resp'. [Some more details
>    needed here, but I still don't yet understand fully
>    the semantics of the 'error' and 'val' fields.]

So clearly, I misunderstood these last two steps.

(7) is something like: discover information in userspace
as required; perform userspace actions if appropriate
(perhaps doing the system call operation "on behalf of" the
target process).


(8) is something like:
   set 'error' and 'val' to return info to the target process:
    * error != 0 ==> make it look like the syscall failed,
      with 'errno' set to that value
    * error == 0 ==> make it look like the syscall succeeded 
      and returned 'val'

Right?

Cheers,

Michael

-- 
Michael Kerrisk
Linux man-pages maintainer; http://www.kernel.org/doc/man-pages/
Linux/UNIX System Programming Training: http://man7.org/training/
