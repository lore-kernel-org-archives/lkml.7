Return-Path: <SRS0=6SCO=RE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5126AC43381
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Mar 2019 15:19:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1FC8420851
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Mar 2019 15:19:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=tycho-ws.20150623.gappssmtp.com header.i=@tycho-ws.20150623.gappssmtp.com header.b="PdxNjBZD"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388527AbfCAPTm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 1 Mar 2019 10:19:42 -0500
Received: from mail-pg1-f194.google.com ([209.85.215.194]:42966 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387677AbfCAPTm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Mar 2019 10:19:42 -0500
Received: by mail-pg1-f194.google.com with SMTP id b2so11589676pgl.9
        for <linux-kernel@vger.kernel.org>; Fri, 01 Mar 2019 07:19:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tycho-ws.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=eTwJVeOcTohNa1JlK+xxe/12Q1BA3LxS8y0YAVDj8eY=;
        b=PdxNjBZDkFD709vPStIgA0/K0FiSNZq2KcOx30IwbGCuyMlrG9pDrzMFFdzEEOmcJN
         Og1sul/bAIQw0kWWF3j1CFnaYLyDEq5Mw+PY8/3jrKWG1Fgk1SEudNIgMqE56HYyCQ7t
         CB6bfBbZf094lXAC5qjw9HswB/M0lOBBKmRnYcD/IV19IfNksRg9ANgxKsgLr1UFssYt
         05+7xwxPzY8c+C/stPFb8r5O0VJ74dZ9FZGQNFcpQVsBtmBlwLsBMvnctEdPw5tOtmvN
         yMQ22eC87nvttw5BXZbHmGQ981JRJK5wat4jhamsS5lGmHJpxh4qzC99P28gDUBTRViB
         WEDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=eTwJVeOcTohNa1JlK+xxe/12Q1BA3LxS8y0YAVDj8eY=;
        b=mz6KwF1NpFT+vlvLYId4t+6zDGIR9B9lQF6NIRGS85C7ZrOYIJWyX3feItg5nDlx/9
         CkOCbWLvOeXYPr+X+wJp+I6HnbleMIHve1nWtpoTTdLNFNv5BmHJpk4+vulrqJ2t59sf
         LGIjpv2DIw/AIK0MVbxPHaLm8d6CmINeMDKY6NKR0dIAEG2RYMEszgE+sGZM38/hi2w6
         4G8r2vKyUldmCpUdjY2jiUI1zwiR7sJ80npGpmFClyB72UGirXYShfOAZz0RvToTsR8c
         J1/9zncYUJcWwaRhEUhZEz8/J9kxuj7PgDLpM7o2PnlXk1eLz7+tcbp132Vr0FAQopJG
         QGEQ==
X-Gm-Message-State: AHQUAua/oOY3pv+qvbDWh+G0cRv35lhbMCPz/DHKaK5wWWtYTrlQ89Xv
        akNFE1dBNOKkUXTuqBa7KUWowg==
X-Google-Smtp-Source: AHgI3IZqtXlLKRi2VQ8WoLDXxhjE1H3lV8Xy5Sd8wNeOI+91ZSMQY9+0UsFWlhTNc8++A2eFALUPRg==
X-Received: by 2002:a62:398d:: with SMTP id u13mr6058928pfj.32.1551453580317;
        Fri, 01 Mar 2019 07:19:40 -0800 (PST)
Received: from cisco ([2601:282:901:dd7b:316c:2a55:1ab5:9f1c])
        by smtp.gmail.com with ESMTPSA id l28sm28560712pfi.186.2019.03.01.07.19.38
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 01 Mar 2019 07:19:39 -0800 (PST)
Date:   Fri, 1 Mar 2019 08:19:37 -0700
From:   Tycho Andersen <tycho@tycho.ws>
To:     "Michael Kerrisk (man-pages)" <mtk.manpages@gmail.com>
Cc:     "Serge E. Hallyn" <serge@hallyn.com>, linux-man@vger.kernel.org,
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
Message-ID: <20190301151937.GE7413@cisco>
References: <20181213001106.15268-1-tycho@tycho.ws>
 <20181213001106.15268-3-tycho@tycho.ws>
 <2cea5fec-e73e-5749-18af-15c35a4bd23c@gmail.com>
 <20190301145310.GC7413@cisco>
 <052d73e2-c786-a760-f03a-a07b5772de5a@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <052d73e2-c786-a760-f03a-a07b5772de5a@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 01, 2019 at 04:16:27PM +0100, Michael Kerrisk (man-pages) wrote:
> Hello Tycho,
> 
> On 3/1/19 3:53 PM, Tycho Andersen wrote:
> > On Thu, Feb 28, 2019 at 01:52:19PM +0100, Michael Kerrisk (man-pages) wrote:
> >>> +a notification will be sent to this fd. See "Userspace Notification" below for
> >>
> >> s/fd/file descriptor/ throughout please.
> > 
> > Will do.
> > 
> >>> +more details.
> >>
> >> I think the description here could be better worded as something like:
> >>
> >>     SECCOMP_FILTER_FLAG_NEW_LISTENER
> >>         Register a new filter, as usual, but on success return a
> >>         new file descriptor that provides user-space notifications.
> >>         When the filter returns SECCOMP_RET_USER_NOTIF, a notification
> >>         will be provided via this file descriptor. The close-on-exec
> >>         flag is automatically set on the new file descriptor. ...
> >>
> >>>  .RE
> >>>  .TP
> >>>  .BR SECCOMP_GET_ACTION_AVAIL " (since Linux 4.14)"
> >>> @@ -606,6 +613,17 @@ file.
> >>>  .TP
> >>>  .BR SECCOMP_RET_ALLOW
> >>>  This value results in the system call being executed.
> >>> +.TP
> >>> +.BR SECCOMP_RET_USER_NOTIF " (since Linux 4.21)"
> >>
> >> Please see the start of this hanging list in the manual page.
> >> Can you confirm that SECCOMP_RET_USER_NOTIF really is the lowest
> >> in the precedence order of all of the filter return values?
> > 
> > Oh, no, I didn't realize it was in a particular order. I'll switch it.
> 
> Just for my immediate education (I'm experimenting right now),
> where/how does it fit in the precedence order?

In between RET_ERRNO and RET_TRACE; see include/uapi/linux/seccomp.h
for details.

Tycho
