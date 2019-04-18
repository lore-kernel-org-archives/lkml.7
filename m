Return-Path: <SRS0=NWWL=SU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A3BB6C10F0E
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Apr 2019 17:26:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5A0B7206B6
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Apr 2019 17:26:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=brauner.io header.i=@brauner.io header.b="c2fGamRC"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389915AbfDRR0w (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 18 Apr 2019 13:26:52 -0400
Received: from mail-ed1-f66.google.com ([209.85.208.66]:46371 "EHLO
        mail-ed1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389767AbfDRR0u (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Apr 2019 13:26:50 -0400
Received: by mail-ed1-f66.google.com with SMTP id d1so2415985edd.13
        for <linux-kernel@vger.kernel.org>; Thu, 18 Apr 2019 10:26:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=brauner.io; s=google;
        h=date:user-agent:in-reply-to:references:mime-version
         :content-transfer-encoding:subject:to:cc:from:message-id;
        bh=NNIz2rWXRFeMJNEEzz8NY8UQcGyCTKeyrd+3gfsfP1w=;
        b=c2fGamRCT/B1XrBkr+lT3cq1C78QuynaAiO3bygxnEa6bev81gMj3SiTJ3fFEm+vkM
         xSQsLDp+wXrT1IDHICdlY6lSpOZrvDyRB3zzBFRsnLbcQ0pTxmvK00XRpfOtr4i6vZgN
         SDzByNNsJqWhAbWDYI9vzM4TTY0t66PJS3AsKjdYXAWxjTCv/SQ/wToNu6Vr/VVQhXZ8
         nUgMUsOE4RF4+wTmFhbPz8pYpwwR+f3kczcmL7wUFGkHBmStro4n1qfqDqWSzdkYbVh8
         jXjwrUGBsW8/hiKugciMvjTz4gzJPy2tXM57EU8sZAPW8xle7VcUhLMCiXBAYhSk7gWo
         BvoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:user-agent:in-reply-to:references
         :mime-version:content-transfer-encoding:subject:to:cc:from
         :message-id;
        bh=NNIz2rWXRFeMJNEEzz8NY8UQcGyCTKeyrd+3gfsfP1w=;
        b=DYWwGXJWK2CLlVw1otpYfZy/i2eoumzM4J47YyhXxn5oue/qXjYZrw4aMr2jsPcEJ1
         25KKHeupkVmT30iZS4wwglIPurGCs5WnxzwCZyveghfaWVxBfTUne0Z2tdBeUzlkD4Sg
         Yaw9kOp6pHYKvDI7IqKYXU9aHTrTpTEW+hmKVv0aQMrGdTaQ6yXklYOGhZiOMbBmXv9b
         VgvMbc5sXl0uGg2H+CND+sTxkMatBA78IubVlS+0t67RYmYLiHvK6ptFayJ77d2p8EIz
         4fC38mf+qy18DIVyZ8COF0KdaLbfzADO6cMSJyEeXy34Y2bBNy2iXtPXjP4mvo70W5LV
         Brww==
X-Gm-Message-State: APjAAAXjc3VQ4/hXdWqnL83F/dA2aREGpMk8hpl9MOvNTq9ekYa01Ou0
        EWCtCrKOHMXixj/7KHG6AITHKw==
X-Google-Smtp-Source: APXvYqzibrbd/MMhUlHx75An2IdjV9PIp5dEkqI/tgFr0eJo0XR03CmWwxcJlkR1nvFrhEdDR9YMpQ==
X-Received: by 2002:a17:906:c793:: with SMTP id cw19mr51621145ejb.86.1555608409096;
        Thu, 18 Apr 2019 10:26:49 -0700 (PDT)
Received: from HUAWEI-nova-2-351a175292c.fritz.box ([212.91.227.56])
        by smtp.gmail.com with ESMTPSA id z3sm484874eja.32.2019.04.18.10.26.48
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 18 Apr 2019 10:26:48 -0700 (PDT)
Date:   Thu, 18 Apr 2019 19:26:44 +0200
User-Agent: K-9 Mail for Android
In-Reply-To: <CAG48ez2Q0t2-rZz8wmGeih=NigYL-CT3+E6NgiPT0AkOQAUPMQ@mail.gmail.com>
References: <20190411175043.31207-1-joel@joelfernandes.org> <20190416120430.GA15437@redhat.com> <20190416192051.GA184889@google.com> <20190417130940.GC32622@redhat.com> <CAG48ez2Q0t2-rZz8wmGeih=NigYL-CT3+E6NgiPT0AkOQAUPMQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH RFC 1/2] Add polling support to pidfd
To:     Jann Horn <jannh@google.com>, Oleg Nesterov <oleg@redhat.com>,
        Joel Fernandes <joel@joelfernandes.org>,
        Florian Weimer <fweimer@redhat.com>
CC:     kernel list <linux-kernel@vger.kernel.org>,
        Andy Lutomirski <luto@amacapital.net>,
        Steven Rostedt <rostedt@goodmis.org>,
        Daniel Colascione <dancol@google.com>,
        Suren Baghdasaryan <surenb@google.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Alexey Dobriyan <adobriyan@gmail.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Andrei Vagin <avagin@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Arnd Bergmann <arnd@arndb.de>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        Kees Cook <keescook@chromium.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        linux-kselftest@vger.kernel.org, Michal Hocko <mhocko@suse.com>,
        Nadav Amit <namit@vmware.com>, Serge Hallyn <serge@hallyn.com>,
        Shuah Khan <shuah@kernel.org>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Taehee Yoo <ap420073@gmail.com>, Tejun Heo <tj@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        kernel-team <kernel-team@android.com>,
        Tycho Andersen <tycho@tycho.ws>
From:   Christian Brauner <christian@brauner.io>
Message-ID: <CEB62F51-E8BF-4EFB-B438-8AF76633FF00@brauner.io>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On April 18, 2019 7:23:38 PM GMT+02:00, Jann Horn <jannh@google=2Ecom> wrot=
e:
>On Wed, Apr 17, 2019 at 3:09 PM Oleg Nesterov <oleg@redhat=2Ecom> wrote:
>> On 04/16, Joel Fernandes wrote:
>> > On Tue, Apr 16, 2019 at 02:04:31PM +0200, Oleg Nesterov wrote:
>> > >
>> > > Could you explain when it should return POLLIN? When the whole
>process exits?
>> >
>> > It returns POLLIN when the task is dead or doesn't exist anymore,
>or when it
>> > is in a zombie state and there's no other thread in the thread
>group=2E
>>
>> IOW, when the whole thread group exits, so it can't be used to
>monitor sub-threads=2E
>>
>> just in case=2E=2E=2E speaking of this patch it doesn't modify
>proc_tid_base_operations,
>> so you can't poll("/proc/sub-thread-tid") anyway, but iiuc you are
>going to use
>> the anonymous file returned by CLONE_PIDFD ?
>
>I don't think procfs works that way=2E /proc/sub-thread-tid has
>proc_tgid_base_operations despite not being a thread group leader=2E
>(Yes, that's kinda weird=2E) AFAICS the WARN_ON_ONCE() in this code can
>be hit trivially, and then the code will misbehave=2E
>
>@Joel: I think you'll have to either rewrite this to explicitly bail
>out if you're dealing with a thread group leader, or make the code
>work for threads, too=2E

The latter case probably being preferred if this API is supposed to be use=
able for thread management in userspace=2E
