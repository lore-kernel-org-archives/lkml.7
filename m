Return-Path: <SRS0=6SCO=RE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 97B4EC43381
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Mar 2019 16:02:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 636902084F
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Mar 2019 16:02:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JZ+cCuJB"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388853AbfCAQCK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 1 Mar 2019 11:02:10 -0500
Received: from mail-wr1-f68.google.com ([209.85.221.68]:44348 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727952AbfCAQCJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Mar 2019 11:02:09 -0500
Received: by mail-wr1-f68.google.com with SMTP id w2so26407783wrt.11;
        Fri, 01 Mar 2019 08:02:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=cc:subject:to:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=4qGxi4SaV2REVLKTbdm/fNyCfrhQuijzmsRw86fYTTA=;
        b=JZ+cCuJBW90N+50Sa1YL6p+ALduV2fAVxXrxYgnwi7FDZiy1Acf/6mIOKdVYvnX3h0
         DdGpiF+ul1D8I9AwZpTjKZI5ztf7YHbTk4xVbzdo4ogaxOetzFtmIeNrKfVoqwisilBT
         NofwTpovgODK0ib1KOgtFueXH2YdKY4b5JXlGx/FPUT1Y8kLo8SKXbBDM3Ql8moypa20
         u+D0/REYN9HyDkwaj/0cMQ2XzXfrI/Lqe4aHmF0T9LpVDvuQdt5Ki/v2XEYvCaCAMAMj
         XBH0XAQfnQxuLPF0OEr41p/PC5IyDKpM7YXGcYV5WdgJama0NXstZ4+Cmbdk/xfFh0AL
         fhlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:cc:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=4qGxi4SaV2REVLKTbdm/fNyCfrhQuijzmsRw86fYTTA=;
        b=O54BTNSRnXuone8giL4Bi0wToXUTkEyBVIUXnf3w6cSq6fx/gdjqAksVOJayhXnuJT
         PI4mElhJf7r0i8HFyBLzuV/Phtoh1E7imf4R5AKryLvKZdSNaj32pY6koSRfr/1Vspgu
         9jMl9zcSvfzvVBxCxXYFV//MLZoWIyuROaJoPB5hXO99PR6QOYLJqzgccd5Bv1gV3kaG
         h+PSEz7dSRtVzndpPeiLR7X05oP3i6ws/96q9Hcc/v6RWQ7F1R1qQb5kDxJH3D2Girqt
         icZu2IB15X6JO3fB6lDj1vZC+PjU3ef+luC0w5sL7fFoDlvMy8zH/06GxdRuE/Tu+qpu
         NqPQ==
X-Gm-Message-State: APjAAAW0i1EomUXG5eZK0e+nlYG7uHbXzmxao5DeMNxbbtTjzp01leaW
        gqORvxLrZSAVGRp9OXnybwk=
X-Google-Smtp-Source: APXvYqzf4htlyb4XlUiH2P/jazi2zX+YqnmtNA7LEaKMUuMgrPXaQDJXKLG08y/0+wbxdw0rMwXO+g==
X-Received: by 2002:a5d:6288:: with SMTP id k8mr4196983wru.173.1551456127502;
        Fri, 01 Mar 2019 08:02:07 -0800 (PST)
Received: from [10.0.21.20] ([95.157.63.22])
        by smtp.gmail.com with ESMTPSA id s3sm30553761wrt.81.2019.03.01.08.02.06
        (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
        Fri, 01 Mar 2019 08:02:06 -0800 (PST)
Cc:     mtk.manpages@gmail.com, "Serge E. Hallyn" <serge@hallyn.com>,
        linux-man@vger.kernel.org, Kees Cook <keescook@chromium.org>,
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
To:     Tycho Andersen <tycho@tycho.ws>
References: <20181213001106.15268-1-tycho@tycho.ws>
 <20181213001106.15268-3-tycho@tycho.ws>
 <2cea5fec-e73e-5749-18af-15c35a4bd23c@gmail.com>
 <20190301145310.GC7413@cisco>
 <052d73e2-c786-a760-f03a-a07b5772de5a@gmail.com>
 <20190301151937.GE7413@cisco>
From:   "Michael Kerrisk (man-pages)" <mtk.manpages@gmail.com>
Message-ID: <20ff6d08-d9ac-06d3-5702-d7de3cc17685@gmail.com>
Date:   Fri, 1 Mar 2019 17:02:05 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.1
MIME-Version: 1.0
In-Reply-To: <20190301151937.GE7413@cisco>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 3/1/19 4:19 PM, Tycho Andersen wrote:
> On Fri, Mar 01, 2019 at 04:16:27PM +0100, Michael Kerrisk (man-pages) wrote:
>> Hello Tycho,
>>
>> On 3/1/19 3:53 PM, Tycho Andersen wrote:
>>> On Thu, Feb 28, 2019 at 01:52:19PM +0100, Michael Kerrisk (man-pages) wrote:
>>>>> +a notification will be sent to this fd. See "Userspace Notification" below for
>>>>
>>>> s/fd/file descriptor/ throughout please.
>>>
>>> Will do.
>>>
>>>>> +more details.
>>>>
>>>> I think the description here could be better worded as something like:
>>>>
>>>>     SECCOMP_FILTER_FLAG_NEW_LISTENER
>>>>         Register a new filter, as usual, but on success return a
>>>>         new file descriptor that provides user-space notifications.
>>>>         When the filter returns SECCOMP_RET_USER_NOTIF, a notification
>>>>         will be provided via this file descriptor. The close-on-exec
>>>>         flag is automatically set on the new file descriptor. ...
>>>>
>>>>>  .RE
>>>>>  .TP
>>>>>  .BR SECCOMP_GET_ACTION_AVAIL " (since Linux 4.14)"
>>>>> @@ -606,6 +613,17 @@ file.
>>>>>  .TP
>>>>>  .BR SECCOMP_RET_ALLOW
>>>>>  This value results in the system call being executed.
>>>>> +.TP
>>>>> +.BR SECCOMP_RET_USER_NOTIF " (since Linux 4.21)"
>>>>
>>>> Please see the start of this hanging list in the manual page.
>>>> Can you confirm that SECCOMP_RET_USER_NOTIF really is the lowest
>>>> in the precedence order of all of the filter return values?
>>>
>>> Oh, no, I didn't realize it was in a particular order. I'll switch it.
>>
>> Just for my immediate education (I'm experimenting right now),
>> where/how does it fit in the precedence order?
> 
> In between RET_ERRNO and RET_TRACE; see include/uapi/linux/seccomp.h
> for details.

Confirmed by experiment :-).

Cheers,

Michael


-- 
Michael Kerrisk
Linux man-pages maintainer; http://www.kernel.org/doc/man-pages/
Linux/UNIX System Programming Training: http://man7.org/training/
