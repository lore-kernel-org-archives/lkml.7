Return-Path: <SRS0=bmbz=XS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DA980C4CED0
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Sep 2019 20:22:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AD22120673
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Sep 2019 20:22:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="s4GyijsL"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2502544AbfIWUWN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 23 Sep 2019 16:22:13 -0400
Received: from mail-wm1-f66.google.com ([209.85.128.66]:33016 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728647AbfIWUWN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Sep 2019 16:22:13 -0400
Received: by mail-wm1-f66.google.com with SMTP id r17so50931wme.0;
        Mon, 23 Sep 2019 13:22:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=cc:subject:to:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=AYy1SxaxNlLfi/ihAwbDE6Bgnd03ZoPRDeMGU9hdEXc=;
        b=s4GyijsLVUnVAtTZHORN7XzGL55i2+vScAOrb/xW9hKJriE2DtslNpMXn0oHzbKeRY
         rSzsn32IYGpgaml3PDxHcp+8MoBD0gbBFQ4sSLkQW3X156GU5nz048r8dTQQFVpE8UMA
         STnuk2nrc+8ljpRRezOQJNsbyItF+7KCYNLnXUxVGym5IFCUk1byckG3RqPorQ/WAC6t
         YI5vtKzN9zqSpMA/FNmVnwHMiwHV1cipgwfNAYktrkkoa1E+v65GEqp2siNIz7jlyBLU
         599u90WspFtIAsnqPXBBXYrwqMKvcZtaT44oKAoI934vUWklBEaAd9dxLCP26W8PcsV8
         z6Bw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:cc:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=AYy1SxaxNlLfi/ihAwbDE6Bgnd03ZoPRDeMGU9hdEXc=;
        b=T+vz7S0Ywq6gbpmaDynQjKfMY55Frt1Dupu90YSSaLuSM6EitEtWc3B1Uv8dI3VJSR
         SPZkrtUKhZdfGTJ98DqRHd8w4Ktn89IZHaW5ComZXKUkeQFCVC2KetIcZfRpKIaWkDQ6
         Iv56ql8g3kRDshnBQ6yrvQMPlDyYWZogY2dOMSU2O/p4nCSCb5+6gKv4wQzjdoADoLgk
         yxasvVSQiwuIQ0pUbzB/hHZ47rLfoAHVBXQxIahRebVxM8VEUx3Htpram52/zi2Iv/Ol
         1w/QKaUJituleqcaj3fdFuDpAwK8o1XUSPXUrIYyYkuO/Ox/Zdi/q1GlP92ypHy/Pkyq
         ydsQ==
X-Gm-Message-State: APjAAAUYt1G8WcTht4VO2JphRyOZu2RN3CNyimlflxWj50Lw7mc4F2W+
        rUmiROlgwVI1xah58uzyFtI=
X-Google-Smtp-Source: APXvYqyH2Ivw1PQV1W+QzBI9YDvcV98zQ24uQmVGk91vItb63MgErpPOYzpaprd+k+cFMxvHSMOgSw==
X-Received: by 2002:a1c:c506:: with SMTP id v6mr951553wmf.160.1569270130682;
        Mon, 23 Sep 2019 13:22:10 -0700 (PDT)
Received: from ?IPv6:2001:a61:243d:bf01:c49e:ef23:e680:96b1? ([2001:a61:243d:bf01:c49e:ef23:e680:96b1])
        by smtp.gmail.com with ESMTPSA id t123sm16183574wma.40.2019.09.23.13.22.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 23 Sep 2019 13:22:10 -0700 (PDT)
Cc:     mtk.manpages@gmail.com, Christian Brauner <christian@brauner.io>,
        Jann Horn <jannh@google.com>,
        Daniel Colascione <dancol@google.com>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        Joel Fernandes <joel@joelfernandes.org>,
        Linux API <linux-api@vger.kernel.org>,
        lkml <linux-kernel@vger.kernel.org>,
        linux-man <linux-man@vger.kernel.org>,
        Oleg Nesterov <oleg@redhat.com>
Subject: Re: For review: pidfd_open(2) manual page
To:     Christian Brauner <christian.brauner@ubuntu.com>,
        Florian Weimer <fw@deneb.enyo.de>
References: <90399dee-53d8-a82c-3871-9ec8f94601ce@gmail.com>
 <87tv939td6.fsf@mid.deneb.enyo.de>
 <20190923144711.ssbrg6bdquhewo7q@wittgenstein>
From:   "Michael Kerrisk (man-pages)" <mtk.manpages@gmail.com>
Message-ID: <41e5ddd9-6935-7743-46aa-080d9a08a8bd@gmail.com>
Date:   Mon, 23 Sep 2019 22:22:07 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190923144711.ssbrg6bdquhewo7q@wittgenstein>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Christian,

On 9/23/19 4:47 PM, Christian Brauner wrote:
> On Mon, Sep 23, 2019 at 12:53:09PM +0200, Florian Weimer wrote:
>> * Michael Kerrisk:
>>
>>> SYNOPSIS
>>>        int pidfd_open(pid_t pid, unsigned int flags);
>>
>> Should this mention <sys/types.h> for pid_t?
>>
>>> ERRORS
>>>        EINVAL flags is not 0.
>>>
>>>        EINVAL pid is not valid.
>>>
>>>        ESRCH  The process specified by pid does not exist.
>>
>> Presumably, EMFILE and ENFILE are also possible errors, and so is
>> ENOMEM.
> 
> So, error codes that could surface are:
> EMFILE: too many open files
> ENODEV: the anon inode filesystem is not available in this kernel (unlikely)
> ENOMEM: not enough memory (to allocate the backing struct file)
> ENFILE: you're over the max_files limit which can be set through proc
> 
> I think that should be it.

Thanks. I've added those.
>>>        A  PID  file descriptor can be monitored using poll(2), select(2),
>>>        and epoll(7).  When the process that it refers to terminates,  the
>>>        file descriptor indicates as readable.  Note, however, that in the
>>>        current implementation, nothing can be read from the file descrip‐
>>>        tor.
>>
>> “is indicated as readable” or “becomes readable”?  Will reading block?
>>
>>>        The  pidfd_open()  system call is the preferred way of obtaining a
>>>        PID file descriptor.  The alternative is to obtain a file descrip‐
>>>        tor by opening a /proc/[pid] directory.  However, the latter tech‐
>>>        nique is possible only if the proc(5) file system is mounted; fur‐
>>>        thermore,  the  file  descriptor  obtained in this way is not pol‐
>>>        lable.
>>
>> One question is whether the glibc wrapper should fall back back to the
>> /proc subdirectory if it is not available.  Probably not.
> 
> No, that would not be transparent to userspace. Especially because both
> fds differ in what can be done with them.
> 
>>
>>>        static
>>>        int pidfd_open(pid_t pid, unsigned int flags)
>>>        {
>>>            return syscall(__NR_pidfd_open, pid, flags);
>>>        }
>>
>> Please call this function something else (not pidfd_open), so that the
>> example continues to work if glibc provides the system call wrapper.
> 
> Agreed!

See my reply to Florian. (So far, I didn't change anything here.)

Thanks,

Michael



-- 
Michael Kerrisk
Linux man-pages maintainer; http://www.kernel.org/doc/man-pages/
Linux/UNIX System Programming Training: http://man7.org/training/
