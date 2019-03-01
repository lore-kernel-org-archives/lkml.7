Return-Path: <SRS0=6SCO=RE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 699C3C43381
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Mar 2019 15:13:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 385AE2084F
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Mar 2019 15:13:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cts3nS3u"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388285AbfCAPNv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 1 Mar 2019 10:13:51 -0500
Received: from mail-wm1-f67.google.com ([209.85.128.67]:53504 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727492AbfCAPNu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Mar 2019 10:13:50 -0500
Received: by mail-wm1-f67.google.com with SMTP id e74so12764664wmg.3;
        Fri, 01 Mar 2019 07:13:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=cc:subject:to:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=K3Isvv8hTu7iJX76+NvlWBMtpiA6Y3SF11XP84p6PB4=;
        b=cts3nS3uJzFEVZSBGntVTiRLPZoDw9sDCZhtVSp9CMkkLkLWa+CoQLrHmSBGHkDWhL
         SpdRq6IzfcxCxYfhgJ6j76UpfF0iPIEjx0pWfN5oKODnMB6piMP62y9m8YdRW5Msj71a
         gmaHTUF7KTbP7t792+is2adgVRKWuPv7y9bc0bGmWw+4nSHukg5N1yqP1CT4+KM+RKeD
         zzuXq7/5NFbcdjzKEdHXoGNEMrGV5zqbRTduhA4aYORUTNjw2D0RPXLSoYqkAiRxa7LR
         Lg56raWlGcD1YTPaOpuqX6eGwDIeT9WQoLWSjMoo6/DiyWJh3vKCfuWjx/FSuO7VvjS7
         MRpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:cc:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=K3Isvv8hTu7iJX76+NvlWBMtpiA6Y3SF11XP84p6PB4=;
        b=QIxHwGLb/1aEyNO5pxou40Ahf8T5xp02WAR1uQtzO+Wic0ZkhZ9+4AQmVluVQDUmdN
         yvaSxGOmbwNzWSFe/vnkKm+DVV7aoD0eO0u+FZyYnKbWE/R02yRYXCnNIJf0IU5RCE2M
         5fsbrHf2Ap7jOR3sbHayH80sDN2HmLChTGeNzR5Ttha90aJBqRtaf7K+x3L+wwE39He1
         DA9EbvEfNYqnan8Hzq/jREoEGXuVCwi1jSSY9NJX4X1ybFxB7LdQWdiaCW261N8mDg0t
         +HeMUId4/aBiM149hftX6k58Rvbxn6m4np9v1OikeJvYxQJtUavD+uJGlpi+ziNYK3Z+
         AoZg==
X-Gm-Message-State: AHQUAuaUOKdtIQWQ6uKZkeAyslKnA08ia83CpUlfsDiL56nUBVS6lPCv
        Z3hPbAY0VK/as9biGwc9zbA=
X-Google-Smtp-Source: APXvYqzZYkBTKv8qCwS1sjmMSmAbdUGTA7TJpCX0EhhtlajZ7xGLmv/se5d5pd1+z0L6MpSDz6XnvA==
X-Received: by 2002:a1c:4c1a:: with SMTP id z26mr3583245wmf.139.1551453228005;
        Fri, 01 Mar 2019 07:13:48 -0800 (PST)
Received: from [10.0.21.20] ([95.157.63.22])
        by smtp.gmail.com with ESMTPSA id z14sm21430738wrv.91.2019.03.01.07.13.47
        (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
        Fri, 01 Mar 2019 07:13:47 -0800 (PST)
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
 <e7a5abd9-f7b7-e077-221a-4c3ef7b818df@gmail.com>
 <20190301145341.GD7413@cisco>
From:   "Michael Kerrisk (man-pages)" <mtk.manpages@gmail.com>
Message-ID: <7a101bfc-b045-35f8-aa3f-a18ecc896fc8@gmail.com>
Date:   Fri, 1 Mar 2019 16:13:46 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.1
MIME-Version: 1.0
In-Reply-To: <20190301145341.GD7413@cisco>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 3/1/19 3:53 PM, Tycho Andersen wrote:
> On Thu, Feb 28, 2019 at 02:25:55PM +0100, Michael Kerrisk (man-pages) wrote:
>>> 7. The monitoring process can use the information in the
>>>    'struct seccomp_notif' to make a determination about the
>>>    system call being made by the target process. This
>>>    structure includes a 'data' field that is the same
>>>    'struct seccomp_data' that is passed to a BPF filter.
>>>
>>>    In addition, the monitoring process may make use of other 
>>>    information that is available from user space. For example, 
>>>    it may inspect the memory of the target process (whose PID
>>>    is provided in the 'struct seccomp_notif') using
>>>    /proc/PID/mem, which includes inspecting the values
>>>    pointed to by system call arguments (whose location is
>>>    available 'seccomp_notif.data.args). However, when using
>>>    the target process PID in this way, one must guard against
>>>    PID re-use race conditions using the seccomp()
>>>    SECCOMP_IOCTL_NOTIF_ID_VALID operation.
>>>
>>> 8. Having arrived at a decision about the target process's
>>>    system call, the monitoring process can inform the kernel
>>>    of its decision using the operation
>>>
>>>        ioctl(listenfd, SECCOMP_IOCTL_NOTIF_SEND, respptr)
>>>
>>>    where the third argument is a pointer to a
>>>    'struct seccomp_notif_resp'. [Some more details
>>>    needed here, but I still don't yet understand fully
>>>    the semantics of the 'error' and 'val' fields.]
>>
>> So clearly, I misunderstood these last two steps.
>>
>> (7) is something like: discover information in userspace
>> as required; perform userspace actions if appropriate
>> (perhaps doing the system call operation "on behalf of" the
>> target process).
>>
>>
>> (8) is something like:
>>    set 'error' and 'val' to return info to the target process:
>>     * error != 0 ==> make it look like the syscall failed,
>>       with 'errno' set to that value

That piece should be amended:
error < 0 ==> make it look like syscall failed.
error > 0 ==> make it look like the syscall succeeded 
       and returned 'error'

Is that really supposed to happen?

>>     * error == 0 ==> make it look like the syscall succeeded 
>>       and returned 'val'

Thanks,

Michael


-- 
Michael Kerrisk
Linux man-pages maintainer; http://www.kernel.org/doc/man-pages/
Linux/UNIX System Programming Training: http://man7.org/training/
