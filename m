Return-Path: <SRS0=NWWL=SU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5C873C10F0E
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Apr 2019 14:15:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2B24B20675
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Apr 2019 14:15:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=brauner.io header.i=@brauner.io header.b="Dedyquf6"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389235AbfDROPT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 18 Apr 2019 10:15:19 -0400
Received: from mail-ot1-f67.google.com ([209.85.210.67]:41435 "EHLO
        mail-ot1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388097AbfDROPS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Apr 2019 10:15:18 -0400
Received: by mail-ot1-f67.google.com with SMTP id 64so1817128otb.8
        for <linux-kernel@vger.kernel.org>; Thu, 18 Apr 2019 07:15:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=brauner.io; s=google;
        h=date:user-agent:in-reply-to:references:mime-version
         :content-transfer-encoding:subject:to:cc:from:message-id;
        bh=OpcwINqCHiCizXEC5PYTe8NNATg22kIzx73i7H3Mtyk=;
        b=Dedyquf6jjev9r77yLhWq5E2JW3SaaOuKMaaWaJTV88uEPQbsKSyUwJ8uA4PGo7OME
         8X6c5seXW1q3Apu4cFRj507XLWXIFO2zYvowPgUYfaL4MiplGVm5B1ENHS+wUuO4JRhx
         SQTCvM7lUT+sKrSvI3fAB5l/5m1YSDqMPNOI0QHKUMKZMvNAoGu1HtDZS+nugXAlQz40
         BohyOU4mWzZfaDLoP1nW69D45IB+7TcFGqLF5/DWAswq5yzTnup9u7AC7Ta9AF71Kinn
         PDDj060f0qiQ0ZTiYieiJCCCc+X5ByfZtntvI0OBkihdr33Qkm2ZSFbjr6zodCkS6dGd
         lHKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:user-agent:in-reply-to:references
         :mime-version:content-transfer-encoding:subject:to:cc:from
         :message-id;
        bh=OpcwINqCHiCizXEC5PYTe8NNATg22kIzx73i7H3Mtyk=;
        b=TVV1UKzCXvkqLVkeMfIFRPN7vQsrPJQVdMsPA2fRCGLWcTq9PgGAcZ93j0zlbfSVMb
         +qm4pdw5MNNri2C8fy5dEXJaxz2QcqieHKeyEH5g3nY5A8CCu+hTmlTdWJHgkiho9Hf/
         Qf8Cg56bVRdOxcSEpwXhI48dmf2W1FFRMhfZiniKqoSvRUKPQQYqCm1hwH0ALBFLo32j
         rimWO85hVyLD3AttVTtbTexL5pfDvpiT37OBzKHeHas2+89nle3WuHyq4D8g8wlZqqW+
         LH8fo23Qg0WCBjWsxDQMxxFr69Qsq2PPLODVoq4JkfwnJEYyDnX5puhaZW8As3CiqIjH
         9bIQ==
X-Gm-Message-State: APjAAAVKdQgPeZtp/PLPWLpPHZM//ltBPkgydtMjk/kCMreWblBvjllg
        ZOFNIl35+PoEQ67tHn3mZGeBCQ==
X-Google-Smtp-Source: APXvYqyiYx8USkgdShxGgxee9Uftr7pRpLVumFsj143x2+qomDClYy63zKJ2KvDs749xqlCFJ8U8qQ==
X-Received: by 2002:a9d:3983:: with SMTP id y3mr59020744otb.32.1555596918013;
        Thu, 18 Apr 2019 07:15:18 -0700 (PDT)
Received: from [26.82.237.254] ([172.56.7.76])
        by smtp.gmail.com with ESMTPSA id m21sm852393otj.48.2019.04.18.07.15.16
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 18 Apr 2019 07:15:17 -0700 (PDT)
Date:   Thu, 18 Apr 2019 16:15:07 +0200
User-Agent: K-9 Mail for Android
In-Reply-To: <20190418141019.GD13701@redhat.com>
References: <20190418101841.4476-1-christian@brauner.io> <20190418101841.4476-3-christian@brauner.io> <20190418131206.GB13701@redhat.com> <20190418132822.untjt7erfvbbiz7a@brauner.io> <20190418141019.GD13701@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH v2 2/5] clone: add CLONE_PIDFD
To:     Oleg Nesterov <oleg@redhat.com>
CC:     torvalds@linux-foundation.org, viro@zeniv.linux.org.uk,
        jannh@google.com, dhowells@redhat.com, linux-api@vger.kernel.org,
        linux-kernel@vger.kernel.org, serge@hallyn.com, luto@kernel.org,
        arnd@arndb.de, ebiederm@xmission.com, keescook@chromium.org,
        tglx@linutronix.de, mtk.manpages@gmail.com,
        akpm@linux-foundation.org, cyphar@cyphar.com,
        joel@joelfernandes.org, dancol@google.com
From:   Christian Brauner <christian@brauner.io>
Message-ID: <A186BAC7-898A-4860-921D-1E2B638E8D52@brauner.io>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On April 18, 2019 4:10:20 PM GMT+02:00, Oleg Nesterov <oleg@redhat=2Ecom> w=
rote:
>On 04/18, Christian Brauner wrote:
>>
>> On Thu, Apr 18, 2019 at 03:12:07PM +0200, Oleg Nesterov wrote:
>> > Should we allow CLONE_THREAD | CLONE_PIDFD ?
>>
>> I think so, yes=2E I have thought about this=2E
>
>OK, I won't insist=2E But let me explain why did I ask=2E
>
>> Yes, due to CLONE_FILES |
>> CLONE_VM you'd necessarily hand the pidfd to the child but threads
>are
>> no security boundary in the first place=2E
>
>No, no, I am not not worried about security=2E CLONE_PARENT | CLONE_PIDFD
>looks more problematic to me, but I see nothing dangerous
>security-wise=2E=2E
>
>I agree that CLONE_THREAD | CLONE_PIDFD may be usefule, but I am not
>sure
>we should allow this from the very begining, until we have a "real"
>use-case=2E
>
>IIUC, we are going to make it pollable soon=2E OK, but
>proc_tgid_base_poll()
>(which should be turned into pidfd_poll) simply can't work if
>pid_task() is
>not a group leader=2E poll(pidfd) will hang forever if pidfd was created
>by
>CLONE_THREAD | CLONE_PIDFD=2E
>
>Sure, we can (should?) improve pidfd_poll() but this will need more
>nasty
>changes in the core kernel code=2E Do we really need/want this? Right now
>it
>is not clear to me=2E Instead, we can simply disallow
>CLONE_THREAD|CLONE_PIDFD
>until we decide that yes, we want to poll sub-threads=2E

If you think that makes the polling work simpler for Joel then for sure=2E
And yes, I have argued for "disable until someone needs it" often before s=
o I can't really argue the other way around here=2E :)
I'll send an updated version soon=2E

Christian

>
>But again, I am fine with CLONE_THREAD | CLONE_PIDFD=2E
>
>Oleg=2E

