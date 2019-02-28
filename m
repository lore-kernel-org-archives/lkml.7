Return-Path: <SRS0=g5d9=RD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 92F8AC43381
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Feb 2019 12:52:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4B7102171F
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Feb 2019 12:52:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="a/yDnY8G"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731816AbfB1MwZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Feb 2019 07:52:25 -0500
Received: from mail-wr1-f67.google.com ([209.85.221.67]:38301 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730792AbfB1MwY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Feb 2019 07:52:24 -0500
Received: by mail-wr1-f67.google.com with SMTP id g12so9751296wrm.5;
        Thu, 28 Feb 2019 04:52:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=cc:subject:to:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=CjsIU+/PvuTp3BBpB7kgHhiJ/qiNsQNrIL9yi/fnFh4=;
        b=a/yDnY8G60voN4KEjWm7fbD6Iy9e/CbG4nSlbaHHRpKdoNeaSwYwis3tLzOCBTxC56
         Moe8DIOJuegunDVwe7ZHN+a+S+9f/s49y9GuBPOj4K1zWEF4aq+cAh8bT0r96mnAVvSU
         i3tdP4kYNLosaMchn85mH+VJLtSNcL/t6kyWfPWHDw5Vk3GXI6+nyeF6U5BjLhtLLA5s
         xFf7Xam3IabEBMsBDAeC2p3AYoFjMowuFw/SzzAnCGQoBmrziCjUd+nb89R9hhROIyPi
         ObaOJ7+eWSfkiwKgIptkhPXhBSgxuAdEp8oDFjhzkjWARlOVDf/14r4am/MkSqDeiBj0
         kVKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:cc:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=CjsIU+/PvuTp3BBpB7kgHhiJ/qiNsQNrIL9yi/fnFh4=;
        b=FO4C1fev9g4br7I7rbaJ34J91WkY7Rcw3BAph8/JVOSC/YeAR6MorOaZooxL8kRks5
         5HREwGyxgMhB6jb/3+cMaETmGs930zvaAGa301wNHeFXDKRWpbbtHM1v9GYnwBtP07Tw
         WGP2xYfxiIjj4JP1/RQpSSlSPiCUX4ZCwrbNRQLdW1QPgB9gsClgVIbysznHN0tB+UWa
         f4oZuarAaSlEoJrxxSYNfxaW3lpYWMT4MpCwJ3BSdzqBfT0xQI1fWeh9g70O54SsZ98u
         DrVHfym+9OWoSvaimva0hTESqsdhXhWv+BFz/ZMM0I28X0F1QguitPJbSXkqk+YD5B/j
         N5hQ==
X-Gm-Message-State: APjAAAVdGaXrNQDQwCRj034ShuzTim6hQtYieSvv8Z0NSPBkR3bLMBUa
        RIxx3DFl1FvWJffoifza1CQ=
X-Google-Smtp-Source: APXvYqzTPEV5nxqZ8Mlx6jKQVqdPjvWeD1YRJxkUA0hxoQAebHCT4ufKfoHYLak687MEqeG0yPp+Wg==
X-Received: by 2002:adf:e3d1:: with SMTP id k17mr6126973wrm.143.1551358341366;
        Thu, 28 Feb 2019 04:52:21 -0800 (PST)
Received: from [10.0.21.20] ([95.157.63.22])
        by smtp.gmail.com with ESMTPSA id m16sm17484542wro.78.2019.02.28.04.52.20
        (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
        Thu, 28 Feb 2019 04:52:20 -0800 (PST)
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
From:   "Michael Kerrisk (man-pages)" <mtk.manpages@gmail.com>
Message-ID: <2cea5fec-e73e-5749-18af-15c35a4bd23c@gmail.com>
Date:   Thu, 28 Feb 2019 13:52:19 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.1
MIME-Version: 1.0
In-Reply-To: <20181213001106.15268-3-tycho@tycho.ws>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

[widening CC to the same scope as the code patches]

Hello Tycho,

Sorry for the late response on this. Could you amend/rebase your patches
in light of the below please.

And anyone's comment on my "big picture" text  at the foot of this
mail would be very welcome.

On 12/13/18 1:11 AM, Tycho Andersen wrote:
> Here's some documentation on how to use the userspace notification. I tried
> to mention the biggest TOCTOU gotcha, but the pointer to the sample is
> really the best thing, 

Cough! No, the "best thing" really is a good sample program *and* really
good documentation :-).

> as it has actual code and many comments about what's
> going on.
> 
> Signed-off-by: Tycho Andersen <tycho@tycho.ws>
> CC: Kees Cook <keescook@chromium.org>
> ---
>  man2/seccomp.2 | 85 +++++++++++++++++++++++++++++++++++++++++++++++++-
>  1 file changed, 84 insertions(+), 1 deletion(-)
> 
> diff --git a/man2/seccomp.2 b/man2/seccomp.2
> index d69187783..fef8914bf 100644
> --- a/man2/seccomp.2
> +++ b/man2/seccomp.2
> @@ -228,6 +228,13 @@ An administrator may override this filter flag by preventing specific
>  actions from being logged via the
>  .IR /proc/sys/kernel/seccomp/actions_logged
>  file.
> +.TP
> +.BR SECCOMP_FILTER_FLAG_NEW_LISTENER " (since Linux 4.21)"
> +With this flag, a new userspace notification fd is returned on success. When
> +this filter returns
> +.BR SECCOMP_RET_USER_NOTIF
> +a notification will be sent to this fd. See "Userspace Notification" below for

s/fd/file descriptor/ throughout please.

> +more details.

I think the description here could be better worded as something like:

    SECCOMP_FILTER_FLAG_NEW_LISTENER
        Register a new filter, as usual, but on success return a
        new file descriptor that provides user-space notifications.
        When the filter returns SECCOMP_RET_USER_NOTIF, a notification
        will be provided via this file descriptor. The close-on-exec
        flag is automatically set on the new file descriptor. ...

>  .RE
>  .TP
>  .BR SECCOMP_GET_ACTION_AVAIL " (since Linux 4.14)"
> @@ -606,6 +613,17 @@ file.
>  .TP
>  .BR SECCOMP_RET_ALLOW
>  This value results in the system call being executed.
> +.TP
> +.BR SECCOMP_RET_USER_NOTIF " (since Linux 4.21)"

Please see the start of this hanging list in the manual page.
Can you confirm that SECCOMP_RET_USER_NOTIF really is the lowest
in the precedence order of all of the filter return values?

> +Forwards the syscall to an attached listener in userspace to allow userspace to

s/syscall/system call throughout please.

> +decide what to do with the syscall. If there is no attached listener (either
> +because the filter was not installed with the
> +.BR SECCOMP_FILTER_FLAG_NEW_LISTENER
> +or because the fd was closed), the filter returns
> +.BR ENOSYS
> +similar to what happens when a filter returns
> +.BR SECCOMP_RET_TRACE
> +and there is no tracer. See "Userspace Notification" below for more details.
>  .PP
>  If an action value other than one of the above is specified,
>  then the filter action is treated as either
> @@ -693,10 +711,75 @@ Otherwise, if kernel auditing is enabled and the process is being audited
>  the action is logged.
>  .IP *
>  Otherwise, the action is not logged.
> +.SS Userspace Notification
> +Interactin userspace notification functionality in seccomp is primarily done
> +via file descriptor. 

That sentence is somewhat garbled. Even if I correct the typo, 
I still don't really understand it. Could you try again?
(Or, take a look at my "big picture" text at the foot of this mail.)

> This file descriptor can be obtained by passing
> +.BR SECCOMP_FILTER_FLAG_NEW_LISTENER
> +as a filter flag when installing a new filter.
> +.PP
> +Once an fd is obtained, userspace can wait for events using
> +.BR poll ()

and presumably select() and epoll?

What kind of notification event do poll(2)/epoll(7)/select(2) provide?
It looks to be POLLIN/EPOLLIN/readable. Is that correct?
These details should be noted here. More generally, my assumption
is that you can use poll(2)/epoll(7)/select(2) to find out about the
availability of an event, and then use SECCOMP_IOCTL_NOTIF_RECV
to read that event. Correct? The text needs to be more explicit on
this.

> +or
> +.BR ioctl ().
> +The supported
> +.BR ioctl ()
> +operations on a notification fd are:
> +.TP
> +.BR SECCOMP_IOCTL_NOTIF_RECV
> +The argument to this command should be a pointer to a struct seccomp_notif:
> +.IP
> +.in +4n
> +.EX
> +struct seccomp_notif {
> +    __u64 id;
> +    __u32 pid;
> +    __u32 flags;
> +    struct seccomp_data data;
> +};
> +.EE
> +.in
> +.IP
> +The id field is a filter-unique id for this syscall, and should be supplied in
> +the response. It can additionally be used in
> +.BR SECCOMP_IOCTL_ID_VALID
> +to test whether or not the request is still alive. The pid here is the pid of
> +the task as visible from the listener's pid namespace. If the pid is not
> +visible, it is 0. Flags is unused right now. 

So, is 'flags' explicitly zeroed by the kernel? the manual page should note
this.

> struct seccomp_data is the same
> +data that would be passed to a filter running in the kernel.

What are the semantics if multiple monitoring processes are employing
SECCOMP_IOCTL_NOTIF_RECV? Does only one of them get awoken? (Which one?)
Or do they all get woken up and get a 'struct seccomp_notif'? The semantics
should be detailed here.

> +.TP
> +.BR SECCOMP_IOCTL_NOTIF_SEND
> +The argument to this command should be a pointer to a struct seccomp_notif_resp:
> +.IP
> +.in +4n
> +.EX
> +struct seccomp_notif_resp {
> +    __u64 id;
> +    __s64 val;
> +    __s32 error;
> +    __u32 flags;
> +};
> +.EE
> +.in
> +.IP
> +The id should be the id from struct seccomp_notif; if error is non-zero, it is
> +used as the return value, otherwise val is. Flags must be 0 right now.

There really isn't enough detail here to help the reader understand. What
is the purpose of 'error' vs 'val'? In particular, I'm assuming that the
monitoring process has (at least) two choices with respect to the system 
call being made by the target process:

(1) Cause the system call to fail with an error.
(2) Allow the system call to proceed.

How are 'error' and 'val' used in these two cases?
Are there more than these two cases? How else is 'val' used?

Also, what happens if the monitoring process does a SECCOMP_IOCTL_NOTIF_RECV,
but does not subsequently do a SECCOMP_IOCTL_NOTIF_SEND? This should be
detailed in the manual page.

What are the semantics if multiple monitoring processes are employing
SECCOMP_IOCTL_NOTIF_SEND? An error for all but the first? The semantics
should be detailed here. 

> +.TP
> +.BR SECCOMP_IOCTL_NOTIF_ID_VALID
> +The argument to this command is just the id to be tested. There is a pid reuse
> +issue where a task may make a syscall, die, its pid get re-used, and the
> +listener may operate on the wrong pid. So the process for handling modifying a
> +pid's state in some way would be to open the pid's resources (/proc/pid/mem or
> +similar), do this call to verify that the id is still valid, and then use the
> +resource. See the sample below for more detail.
> +.PP
> +A complete example is available in the kernel tree at
> +.IR samples/seccomp/user-trap.c .
>  .SH RETURN VALUE
>  On success,
>  .BR seccomp ()
> -returns 0.
> +returns 0, unless
> +.BR SECCOMP_FILTER_FLAG_NEW_LISTENER
> +was specified, in which case it returns the fd number for the new listener fd.
>  On error, if
>  .BR SECCOMP_FILTER_FLAG_TSYNC
>  was used,

More generally though, I'm struggling with this patch because "the 
big picture" is lacking. Here's my estimate of what I think that
picture is:

[[
Instead of having the seccomp() filter decision being made
within the filter itself, it is possible to pass off the
decision making to a (different) user-space process that
makes the decision. This is done using the following steps.

1. The "target process" (i.e., process that will
   establish a seccomp filter) and the process that will make
   decisions about system calls ("the monitoring process")
   establish a connection using a UNIX domain socket. This
   socket will subsequently be used to exchange a file
   descriptor.

2. The "target process" establishes a seccomp BPF filter in the
   usual manner, but with two notable differences:

   * The seccomp() 'flags' argument includes the flag
     SECCOMP_FILTER_FLAG_NEW_LISTENER. Consequently, the return 
     value  of a successful seccomp() call is a new "listening"
     file descriptor that can be used for monitoring.
   * In cases where it is needed, the BPF filter returns the
     special action SECCOMP_RET_USER_NOTIF. This return value
     will trigger a notification event.
     
3. The "target process" passes the "listening file descriptor"
   to the "monitoring process" via the UNIX domain socket.

4. The target process then performs its workload, which includes
   system calls that will be controlled by the BPF filter.
   Whenever one of these system calls causes the BPF filter to
   return SECCOMP_RET_USER_NOTIF, a notification event is
   generated on the listening file descriptor.

5. The monitoring process will receive notification events
   on the listening file descriptor. These events are returned
   as structures of type 'seccomp_notif'. Because this structure
   and its size may evolve over kernel version, the monitoring
   process must first determine the size of this structure using
   the seccomp() SECCOMP_GET_NOTIF_SIZES operation, which
   returns a structure of type 'seccomp_notif_sizes'. The
   monitoring process allocates a buffer of size
   'seccomp_notif_sizes.seccomp_notif' bytes to receive 
   monitoring events. In addition,the monitoring process
   allocates another buffer of size 
   'seccomp_notif_sizes.seccomp_notif_resp' bytes for the
   response (a 'struct seccomp_notif_resp') that it will
   provide to the kernel in order to advise how the system
   call being made by the target process shall be treated.

6. The monitoring process can now repeatedly monitor the
   listening file descriptor.

   When a SECCOMP_RET_USER_NOTIF-triggered event occurs,
   the file descriptor will test as readable for 
   poll(2)/epoll(7)/select(2). The call

       ioctl(listenfd, SECCOMP_IOCTL_NOTIF_RECV, reqptr)

   can be used to read info on the event; this operation
   blocks until an event is available. It populates
   the 'struct seccomp_notif' pointed to by the third
   argument with information about the system call
   that is being attempted by the target process.
   
7. The monitoring process can use the information in the
   'struct seccomp_notif' to make a determination about the
   system call being made by the target process. This
   structure includes a 'data' field that is the same
   'struct seccomp_data' that is passed to a BPF filter.

   In addition, the monitoring process may make use of other 
   information that is available from user space. For example, 
   it may inspect the memory of the target process (whose PID
   is provided in the 'struct seccomp_notif') using
   /proc/PID/mem, which includes inspecting the values
   pointed to by system call arguments (whose location is
   available 'seccomp_notif.data.args). However, when using
   the target process PID in this way, one must guard against
   PID re-use race conditions using the seccomp()
   SECCOMP_IOCTL_NOTIF_ID_VALID operation.

8. Having arrived at a decision about the target process's
   system call, the monitoring process can inform the kernel
   of its decision using the operation

       ioctl(listenfd, SECCOMP_IOCTL_NOTIF_SEND, respptr)

   where the third argument is a pointer to a
   'struct seccomp_notif_resp'. [Some more details
   needed here, but I still don't yet understand fully
   the semantics of the 'error' and 'val' fields.]

I'd like to include text along the above lines at the start of
the "Userspace Notification" section. Could you take a look at
the above and let me know any errors, improved terminology, or
other improvements generally. I'll then work that text into
the page.

Thanks,

Michael

-- 
Michael Kerrisk
Linux man-pages maintainer; http://www.kernel.org/doc/man-pages/
Linux/UNIX System Programming Training: http://man7.org/training/
