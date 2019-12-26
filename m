Return-Path: <SRS0=rArk=2Q=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E5692C2D0DA
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Dec 2019 14:34:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C00CE20740
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Dec 2019 14:34:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726453AbfLZOeN convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 26 Dec 2019 09:34:13 -0500
Received: from mail-pg1-f195.google.com ([209.85.215.195]:44451 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726074AbfLZOeN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Dec 2019 09:34:13 -0500
Received: by mail-pg1-f195.google.com with SMTP id x7so12928771pgl.11
        for <linux-kernel@vger.kernel.org>; Thu, 26 Dec 2019 06:34:13 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:user-agent:in-reply-to:references
         :mime-version:content-transfer-encoding:subject:to:cc:from
         :message-id;
        bh=tH9yVEH69roRLXZbFqwNHzCYz2hyQgh/keaKpLa4NYw=;
        b=OBwdGiyQxMKIhhLtEdKvG/pYouXt4zcidn5HnWM94/6GNFniJSXhHhSiVD+N9F8gM9
         qu8pD2XHzhhEZ75fFNcAF4e91h5p8AJjZlBwGOFmwQ7m4tJYuzpsfklAqmeuN0rtvJnK
         mzjIrFf6saR8YEz/K16LIN018icwkQ2kF+q1NmSM2p0SETFu4tumk4+BVN4paw9eMHZC
         tV9v/sch95BkHSB+hA9K9Sc+urIOqN+48VZrDUhIaf//3kBwa9YnmW8/q26EbeS8HJ9E
         gcVJ1impu2vWgoUMFRuDrkDACLKAIWSFbct8uWSQk8J/PiAMB1iHPpL1Xd3Gnavn2Usl
         Zvgg==
X-Gm-Message-State: APjAAAVcZr5Yj3pxNJGoTinPZyi9c0JhQai6KSouCekIxpwlnwV+tRA4
        QnRXAtBBMY3auAwsPvA/kjWN/w==
X-Google-Smtp-Source: APXvYqy2DOFvQDYyy57f2OzZyRH9kGQ8+OGGXcXdwwdb3R8vCD6k8z3TI+QuoL3NTLvmO3iXBzrX9Q==
X-Received: by 2002:a63:e042:: with SMTP id n2mr50353885pgj.308.1577370852755;
        Thu, 26 Dec 2019 06:34:12 -0800 (PST)
Received: from [192.168.43.52] ([172.58.30.175])
        by smtp.gmail.com with ESMTPSA id b2sm11031962pjq.3.2019.12.26.06.34.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 26 Dec 2019 06:34:11 -0800 (PST)
Date:   Thu, 26 Dec 2019 15:34:02 +0100
User-Agent: K-9 Mail for Android
In-Reply-To: <20191226143229.sbopynwut2hhsiwn@yavin.dot.cyphar.com>
References: <20191225214530.GA27780@ircssh-2.c.rugged-nimbus-611.internal> <20191226115245.usf7z5dkui7ndp4w@wittgenstein> <20191226143229.sbopynwut2hhsiwn@yavin.dot.cyphar.com>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 8BIT
Subject: Re: [PATCH] seccomp: Check flags on seccomp_notif is unset
To:     Aleksa Sarai <cyphar@cyphar.com>
CC:     Sargun Dhillon <sargun@sargun.me>, linux-kernel@vger.kernel.org,
        linux-api@vger.kernel.org, tycho@tycho.ws, jannh@google.com,
        keescook@chromium.org
From:   Christian Brauner <christian.brauner@ubuntu.com>
Message-ID: <57C06925-0CC6-4251-AD57-8FF1BC28F049@ubuntu.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On December 26, 2019 3:32:29 PM GMT+01:00, Aleksa Sarai <cyphar@cyphar.com> wrote:
>On 2019-12-26, Christian Brauner <christian.brauner@ubuntu.com> wrote:
>> On Wed, Dec 25, 2019 at 09:45:33PM +0000, Sargun Dhillon wrote:
>> > This patch is a small change in enforcement of the uapi for
>> > SECCOMP_IOCTL_NOTIF_RECV ioctl. Specificaly, the datastructure
>which is
>> > passed (seccomp_notif), has a flags member. Previously that could
>be
>> > set to a nonsense value, and we would ignore it. This ensures that
>> > no flags are set.
>> > 
>> > Signed-off-by: Sargun Dhillon <sargun@sargun.me>
>> > Cc: Kees Cook <keescook@chromium.org>
>> 
>> I'm fine with this since we soon want to make use of the flag
>argument
>> when we add a flag to get a pidfd from the seccomp notifier on
>receive.
>> The major users I could identify already pass in seccomp_notif with
>all
>> fields set to 0. If we really break users we can always revert; this
>> seems very unlikely to me though.
>> 
>> One more question below, otherwise:
>> 
>> Reviewed-by: Christian Brauner <christian.brauner@ubuntu.com>
>> 
>> > ---
>> >  kernel/seccomp.c | 7 +++++++
>> >  1 file changed, 7 insertions(+)
>> > 
>> > diff --git a/kernel/seccomp.c b/kernel/seccomp.c
>> > index 12d2227e5786..455925557490 100644
>> > --- a/kernel/seccomp.c
>> > +++ b/kernel/seccomp.c
>> > @@ -1026,6 +1026,13 @@ static long seccomp_notify_recv(struct
>seccomp_filter *filter,
>> >  	struct seccomp_notif unotif;
>> >  	ssize_t ret;
>> >  
>> > +	if (copy_from_user(&unotif, buf, sizeof(unotif)))
>> > +		return -EFAULT;
>> > +
>> > +	/* flags is reserved right now, make sure it's unset */
>> > +	if (unotif.flags)
>> > +		return -EINVAL;
>> > +
>> 
>> Might it make sense to use
>> 
>> 	err = copy_struct_from_user(&unotif, sizeof(unotif), buf,
>sizeof(unotif));
>> 	if (err)
>> 		return err;
>> 
>> This way we check that the whole struct is 0 and report an error as
>soon
>> as one of the members is non-zero. That's more drastic but it'd
>ensure
>> that other fields can be used in the future for whatever purposes.
>> It would also let us get rid of the memset() below. 
>
>Given that this isn't an extensible struct, it would be simpler to just
>do
>check_zeroed_user() -- copy_struct_from_user() is overkill. That would
>also remove the need for any copy_from_user()s and the memset can be
>dropped by just doing
>
>  struct seccomp_notif unotif = {};
>
>> >  	memset(&unotif, 0, sizeof(unotif));
>> >  
>> >  	ret = down_interruptible(&filter->notif->request);
>> > -- 
>> > 2.20.1
>> > 

It is an extensible struct. That's why we have notifier size checking built in.
