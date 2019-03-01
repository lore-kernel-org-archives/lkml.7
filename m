Return-Path: <SRS0=6SCO=RE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1EB27C43381
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Mar 2019 14:53:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DC13320851
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Mar 2019 14:53:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=tycho-ws.20150623.gappssmtp.com header.i=@tycho-ws.20150623.gappssmtp.com header.b="NtMM4BuX"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388936AbfCAOxq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 1 Mar 2019 09:53:46 -0500
Received: from mail-pg1-f193.google.com ([209.85.215.193]:42640 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388894AbfCAOxp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Mar 2019 09:53:45 -0500
Received: by mail-pg1-f193.google.com with SMTP id b2so11557626pgl.9
        for <linux-kernel@vger.kernel.org>; Fri, 01 Mar 2019 06:53:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tycho-ws.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=2NCNDzjIcVY2rYuh6d/4cyK6U/CBx5FFhf0iLZq9gKQ=;
        b=NtMM4BuXwoY2fUJAoT15nHQhytu27YTjmXdb2LiHmatybi/0jpsy/wvjwEhk4g9bzS
         wFN10V54d6eORENpaVhlXqYHbdePxwDKrejJAan7RKnGzfBasT06P79FyN78rBiqecr5
         Ubp89mL80zPvLgCxvj78pGQXzbqASdkwOZQAUybHoY6eRDNf/5SBfxmQqd5liEtR49KJ
         PPVoHMLrsOrR5oXmkJh5sQzUX4K4q1P00RIGLp7wxtMI/9b1LbDmM+YQzCRo6OKzAXV1
         l08GKi6SgMiqtlgI3t7qSkJQUb4IMHRPAxSzifdKRG+S+W1hOWf7QYzR2vvVDad4XRqy
         q2HA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=2NCNDzjIcVY2rYuh6d/4cyK6U/CBx5FFhf0iLZq9gKQ=;
        b=ErbC0u2PM1NsfQnlr7rCkU+GNpgsQe25Hd39OvzGgQ9/zsTKe6zRQ0Cbp67m9/v3KU
         4DdaVN0NJCDz4yaiMwHBvSq18dxpQjIUHriuX7QaAHISZ4QAbGoXQfkALh+17f23bNYe
         DowMFTGe6tGO0n8jMdRnhSMstJ09gU0U1eHjNOeagsLfAJDLuXr59yPvOg7AF7y44IFH
         TgWPJEEDaQHqrBLy009uPAuF38Eu667+5yfaIn3U1RF+xJq/aGOlfxEn5MqgNSi5l7t2
         JieyjaQIrFDZWvk6wO8RYk+5YdAS9yFnWpvj2YoPBasIvr0oGtucrx4ZN4uZuZhOTZr2
         EFZA==
X-Gm-Message-State: APjAAAXL3CnWP325fSt2hnD8IslWO+JYj8R44a21RBWLZNjpKRQl589H
        +gTxNYwCVNQZckhQh84yifYUTQ==
X-Google-Smtp-Source: APXvYqxl2iZsn6//J0wrG/3ybvbgDGkMYanAeLzu2sf6kvGIiJxjJafW+KP6+YAJjf31kxBrhwYDeg==
X-Received: by 2002:a65:60d8:: with SMTP id r24mr5211842pgv.6.1551452024075;
        Fri, 01 Mar 2019 06:53:44 -0800 (PST)
Received: from cisco ([2601:282:901:dd7b:316c:2a55:1ab5:9f1c])
        by smtp.gmail.com with ESMTPSA id l12sm26584812pgk.40.2019.03.01.06.53.42
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 01 Mar 2019 06:53:43 -0800 (PST)
Date:   Fri, 1 Mar 2019 07:53:41 -0700
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
Message-ID: <20190301145341.GD7413@cisco>
References: <20181213001106.15268-1-tycho@tycho.ws>
 <20181213001106.15268-3-tycho@tycho.ws>
 <2cea5fec-e73e-5749-18af-15c35a4bd23c@gmail.com>
 <e7a5abd9-f7b7-e077-221a-4c3ef7b818df@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e7a5abd9-f7b7-e077-221a-4c3ef7b818df@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 28, 2019 at 02:25:55PM +0100, Michael Kerrisk (man-pages) wrote:
> > 7. The monitoring process can use the information in the
> >    'struct seccomp_notif' to make a determination about the
> >    system call being made by the target process. This
> >    structure includes a 'data' field that is the same
> >    'struct seccomp_data' that is passed to a BPF filter.
> > 
> >    In addition, the monitoring process may make use of other 
> >    information that is available from user space. For example, 
> >    it may inspect the memory of the target process (whose PID
> >    is provided in the 'struct seccomp_notif') using
> >    /proc/PID/mem, which includes inspecting the values
> >    pointed to by system call arguments (whose location is
> >    available 'seccomp_notif.data.args). However, when using
> >    the target process PID in this way, one must guard against
> >    PID re-use race conditions using the seccomp()
> >    SECCOMP_IOCTL_NOTIF_ID_VALID operation.
> > 
> > 8. Having arrived at a decision about the target process's
> >    system call, the monitoring process can inform the kernel
> >    of its decision using the operation
> > 
> >        ioctl(listenfd, SECCOMP_IOCTL_NOTIF_SEND, respptr)
> > 
> >    where the third argument is a pointer to a
> >    'struct seccomp_notif_resp'. [Some more details
> >    needed here, but I still don't yet understand fully
> >    the semantics of the 'error' and 'val' fields.]
> 
> So clearly, I misunderstood these last two steps.
> 
> (7) is something like: discover information in userspace
> as required; perform userspace actions if appropriate
> (perhaps doing the system call operation "on behalf of" the
> target process).
> 
> 
> (8) is something like:
>    set 'error' and 'val' to return info to the target process:
>     * error != 0 ==> make it look like the syscall failed,
>       with 'errno' set to that value
>     * error == 0 ==> make it look like the syscall succeeded 
>       and returned 'val'
> 
> Right?

Yep, exactly.

Tycho
