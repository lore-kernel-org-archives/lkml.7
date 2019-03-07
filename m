Return-Path: <SRS0=uyI7=RK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C6845C43381
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Mar 2019 17:43:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9A1452064A
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Mar 2019 17:43:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="hKpCKfkM"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726420AbfCGRnl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 Mar 2019 12:43:41 -0500
Received: from mail-vk1-f195.google.com ([209.85.221.195]:35535 "EHLO
        mail-vk1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726307AbfCGRnk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Mar 2019 12:43:40 -0500
Received: by mail-vk1-f195.google.com with SMTP id l136so3918708vke.2
        for <linux-kernel@vger.kernel.org>; Thu, 07 Mar 2019 09:43:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=JHry6dhslx2GQxhF8l2skqCf/87do0ohQJE5cSZtzQ8=;
        b=hKpCKfkMltmWFGLG4NtZdcyMdFFi1sBp/kJKK5bl1LIiXCfGQf9ZLGB7DX0oTsWV8v
         IECnZk29iu+lFRIZonNZhGe8JXF7Z4sTM2IQN9pHAap7bTw9ggAM6RCFrtAzBGRksKB+
         ugyQzNJKNdaDQRrJ+SF4dYtOs8R38k+26oaf0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=JHry6dhslx2GQxhF8l2skqCf/87do0ohQJE5cSZtzQ8=;
        b=Ag1ots5vBJ6o3GxHYOqzyccNAxzNxmM8odF9XjzjUJyDAeU+97RNUc4Ih7/ZhgbWnK
         0yvxNg+PQuIPZu6k1O7KdN/KJUelbD6BM3f+1yYmcwvsZxCT6rkqbq3AC/hE/qfOzmLG
         cdUdfG1cleaPNhjbE/JThi2JiiLUngttFmnHTb5CQ8kUqEHmDkVRU+FjyCrbtMs0uxU1
         npskATPXa2Qwrrq08OsvpOglfEK8YC/QLxFgQbl6lkBlWp0szhFnBA9trgMTS9TyZAOk
         MWL7Hj6ZczuT/ovyJqYzvC9hERjXJ7ZDLzlyhOekZ1j1RbAjExxjslg8tGE3wP6NYE/O
         VDRg==
X-Gm-Message-State: APjAAAWuFJSCVYQFphJ8EnQRpCFNN+n3r79Sbkh88DwQPhILESpMyaYm
        x/aDgdXszuhi7JFJo+smr9o6xa5mfl4=
X-Google-Smtp-Source: APXvYqxHAFQchdLOfpSeO9iNloWzvv/1jc7F/Ha7zDo6lnpVLEeEEK3Wq94MKApR+8Zy4X2CxwjRuw==
X-Received: by 2002:a1f:2acb:: with SMTP id q194mr6736917vkq.92.1551980618572;
        Thu, 07 Mar 2019 09:43:38 -0800 (PST)
Received: from mail-vs1-f45.google.com (mail-vs1-f45.google.com. [209.85.217.45])
        by smtp.gmail.com with ESMTPSA id x8sm3490700vkc.36.2019.03.07.09.43.36
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 07 Mar 2019 09:43:37 -0800 (PST)
Received: by mail-vs1-f45.google.com with SMTP id y19so5007604vsc.4
        for <linux-kernel@vger.kernel.org>; Thu, 07 Mar 2019 09:43:36 -0800 (PST)
X-Received: by 2002:a67:6983:: with SMTP id e125mr7355378vsc.222.1551980616476;
 Thu, 07 Mar 2019 09:43:36 -0800 (PST)
MIME-Version: 1.0
References: <20190306110549.7628-1-elena.reshetova@intel.com>
In-Reply-To: <20190306110549.7628-1-elena.reshetova@intel.com>
From:   Kees Cook <keescook@chromium.org>
Date:   Thu, 7 Mar 2019 09:43:25 -0800
X-Gmail-Original-Message-ID: <CAGXu5jJQNdKpU8tSfiWt74aodL5w471unZGzq9RevGd+-wm=wQ@mail.gmail.com>
Message-ID: <CAGXu5jJQNdKpU8tSfiWt74aodL5w471unZGzq9RevGd+-wm=wQ@mail.gmail.com>
Subject: Re: [PATCH 0/3] creds/cgroups/ns_proxy refcount_t conversions
To:     Elena Reshetova <elena.reshetova@intel.com>
Cc:     "Eric W. Biederman" <ebiederm@xmission.com>, serue@us.ibm.com,
        Peter Zijlstra <peterz@infradead.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 6, 2019 at 3:05 AM Elena Reshetova
<elena.reshetova@intel.com> wrote:
>
> I would like to reopen ages-old discussion on these conversions now.
> Eric had objections against them in past, namely on not providing enough
> security for reference counters (but we still argue it is better
> than overflowing atomic_t and resulting use-after-free).
> However now, refcount_t has been successfully used in kernel in many places,
> helped to detect bugs and mistakes in logic of refcounters.
> We have converted most of core kernel reference counters by now and these
> 3 are pretty core ones, so it would be really great to have them covered
> also.
>
> The patches are fully independent and can be cherry-picked and
> discussed separately. More information about each conversion in each patch
> separately.

These look good to me. Perhaps they can go via -mm, maybe with Eric
and/or Peter's ack/review? I'd really like to get these done so we can
get closer to finishing the refcount_t conversions...

Thanks!

-Kees

>
> Elena Reshetova (3):
>   nsproxy: convert nsproxy.count to refcount_t
>   groups: convert group_info.usage to refcount_t
>   creds: convert cred.usage to refcount_t
>
>  include/linux/cred.h    | 15 +++++++-------
>  include/linux/nsproxy.h |  6 +++---
>  kernel/cred.c           | 44 ++++++++++++++++++++---------------------
>  kernel/groups.c         |  2 +-
>  kernel/nsproxy.c        |  6 +++---
>  net/sunrpc/auth.c       |  2 +-
>  6 files changed, 38 insertions(+), 37 deletions(-)
>
> --
> 2.17.1
>


-- 
Kees Cook
