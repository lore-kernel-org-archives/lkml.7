Return-Path: <SRS0=6SCO=RE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7454CC43381
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Mar 2019 15:16:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4348F20851
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Mar 2019 15:16:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kQYj6tZu"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388448AbfCAPQc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 1 Mar 2019 10:16:32 -0500
Received: from mail-wr1-f65.google.com ([209.85.221.65]:38081 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726195AbfCAPQb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Mar 2019 10:16:31 -0500
Received: by mail-wr1-f65.google.com with SMTP id g12so14203150wrm.5;
        Fri, 01 Mar 2019 07:16:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=cc:subject:to:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=9kcnOCfI78glGSw7tQuJgFxcnNqgYzSbsdWUFrOfOhA=;
        b=kQYj6tZuk1xFgt/9Ja6YVpgADxtw4p7UTbyIGnsbMZiwJpGoXPCit6cFqQSEGbomBf
         FX/Ih4gXwUqBknxWVtno1A4WoGnd4jx+kBPi3ES0EA7ipJ+7StZ7qjfl3sSs6S0+zMlo
         2/eJrwaW4/oftIk8tP1S/MTKoiz/72WqMYINwY9nCsKj2dO+T/aJbE0E5yuJ0PTL38MG
         NIyCRlEjWwcIPN8cJ4GzFpfIBUd84azw7i6F+56IbzycHjEQA/r+6Bd3gY+tHMTdihlB
         U0+cRxGQiPP16gXi12FyiaVtmZVRyklCBzsutlCxmGvAaIii4Pnh2S7SZaZ+qFZxtNJB
         +Z0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:cc:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=9kcnOCfI78glGSw7tQuJgFxcnNqgYzSbsdWUFrOfOhA=;
        b=fFO+hsssYrFJ884L1bC8As0TyppWBe+eoYV90+nmwKFfxWrzbEDgLBN7PTowS+exsA
         UFBirDt0HV1wdocfMkaMgDBrbUxFckC4yfdOr9mXOdmWwCqbuItpjsyKSmAfXKjafCpm
         U1NWnvXBq5pum1qrpkMDALrvcq3eAUFOKEpYn37XSce3DyGqZ8rGobopracLjTq4klDY
         5IWymFo4ZxYFDV31ZrSH5Ro+hJta8mYEHlj4ka/9kujfSmcTl4VNFW8VKim/E2WM8J6E
         Vltr38yz3WA3wVvBSygV/yFvB8rokgx3zo1Ke3Ku4NUkJx0FqyIvwN100qWd24Pv1df/
         ccRw==
X-Gm-Message-State: APjAAAX909lhbiH0zrf3dTP9DVMpXGsyHdxUjXAEvBf5LcHmYHc11Wn2
        Hr2EEJNIsiAFzyNMceVh9Eg=
X-Google-Smtp-Source: APXvYqz0Ky8nEcNfyUbhbXpbBfbd/KShk6hqB8+cfH9z6T0KT06IFTuPy+2+8t6jpd57r9IPSJ6IHg==
X-Received: by 2002:a5d:6843:: with SMTP id o3mr3749740wrw.165.1551453389831;
        Fri, 01 Mar 2019 07:16:29 -0800 (PST)
Received: from [10.0.21.20] ([95.157.63.22])
        by smtp.gmail.com with ESMTPSA id 93sm66240299wrh.15.2019.03.01.07.16.28
        (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
        Fri, 01 Mar 2019 07:16:28 -0800 (PST)
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
From:   "Michael Kerrisk (man-pages)" <mtk.manpages@gmail.com>
Message-ID: <052d73e2-c786-a760-f03a-a07b5772de5a@gmail.com>
Date:   Fri, 1 Mar 2019 16:16:27 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.1
MIME-Version: 1.0
In-Reply-To: <20190301145310.GC7413@cisco>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Tycho,

On 3/1/19 3:53 PM, Tycho Andersen wrote:
> On Thu, Feb 28, 2019 at 01:52:19PM +0100, Michael Kerrisk (man-pages) wrote:
>>> +a notification will be sent to this fd. See "Userspace Notification" below for
>>
>> s/fd/file descriptor/ throughout please.
> 
> Will do.
> 
>>> +more details.
>>
>> I think the description here could be better worded as something like:
>>
>>     SECCOMP_FILTER_FLAG_NEW_LISTENER
>>         Register a new filter, as usual, but on success return a
>>         new file descriptor that provides user-space notifications.
>>         When the filter returns SECCOMP_RET_USER_NOTIF, a notification
>>         will be provided via this file descriptor. The close-on-exec
>>         flag is automatically set on the new file descriptor. ...
>>
>>>  .RE
>>>  .TP
>>>  .BR SECCOMP_GET_ACTION_AVAIL " (since Linux 4.14)"
>>> @@ -606,6 +613,17 @@ file.
>>>  .TP
>>>  .BR SECCOMP_RET_ALLOW
>>>  This value results in the system call being executed.
>>> +.TP
>>> +.BR SECCOMP_RET_USER_NOTIF " (since Linux 4.21)"
>>
>> Please see the start of this hanging list in the manual page.
>> Can you confirm that SECCOMP_RET_USER_NOTIF really is the lowest
>> in the precedence order of all of the filter return values?
> 
> Oh, no, I didn't realize it was in a particular order. I'll switch it.

Just for my immediate education (I'm experimenting right now),
where/how does it fit in the precedence order?


Thanks,

Michael

-- 
Michael Kerrisk
Linux man-pages maintainer; http://www.kernel.org/doc/man-pages/
Linux/UNIX System Programming Training: http://man7.org/training/
