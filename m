Return-Path: <SRS0=95/N=R6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7CE45C43381
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Mar 2019 20:59:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 389BC2075E
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Mar 2019 20:59:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=brauner.io header.i=@brauner.io header.b="ZtcGsIgv"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727998AbfC0U7b (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Mar 2019 16:59:31 -0400
Received: from mail-ed1-f68.google.com ([209.85.208.68]:34512 "EHLO
        mail-ed1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727140AbfC0U7b (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Mar 2019 16:59:31 -0400
Received: by mail-ed1-f68.google.com with SMTP id x14so12677106eds.1
        for <linux-kernel@vger.kernel.org>; Wed, 27 Mar 2019 13:59:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=brauner.io; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=OeI4W9JlV4SVcrFa9MWmlQWcVLr0MimpAtfwIEQmS1k=;
        b=ZtcGsIgvnocv5H4TZ1ndzA335T9lWZoyYuKyKBzTFZmchqqkAMa9xrd0LJW/d74KIp
         NvsruNlYJiRnb7JNJeSI5g+4Bs2U4jhfNoJb+buVWQSN4hPx2Vzmu6La8skMD2mWtN0W
         Tu00fYrhS51aadbAkHJnsx6EqkR0OWe9qDCSuWOkz38JTbOWFqDc9O/MNQaQLeCfwrdV
         HUGqD7j5PQ74Rl3L5ZoD/YYGQTDCqeNubBvD1UHjg6Kc7kWfHx5n+i2pvvhENHzie9R7
         WLtYBw8rsoixNdhKsLHGEEt2ijHV7Wq2TANurcOr2jbJA+80MJVgfFM67F1LFocWZdN4
         Cmqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=OeI4W9JlV4SVcrFa9MWmlQWcVLr0MimpAtfwIEQmS1k=;
        b=DgAtaCoBhVf8gn8aw5HkkM0uZPlxjmObknsqZRKjSHhq2xt+/gi5Spvf9fbJtdhjSJ
         xqMCAWIFAE8w9gQnG+arM22+zxfVD2ubAGDUtJk4SKG0Y1qclEedI3Iu3VrAcqTh3WB5
         EG9Vp9l8/QawI+PvixiRd/z+JJ/9XCYTg3xLdTVsSd943FrA1kdNruiUut8G1c7EEoLa
         oLcAJy6kRQXwZQ87gvYQg2NRdsar9FI/o7n8Du4o3+9irpzJbzOuWLqa8/OR1kApU961
         h/aG10aER7YUIm3EwxidjIy/EzfZ1E0291L3bolOp+DnCp4Y/26N+A6oRYoBMuV5CnJR
         Cnyg==
X-Gm-Message-State: APjAAAVxaaz+Q6W4CcWIYdISkjmrisBONEHnPANHcVn3KdfYOyqM2MuF
        5evY/r2BqwijaSpezzkP4Oe0UA==
X-Google-Smtp-Source: APXvYqwTuy0kn8K4ftPSXPiS1rZplft9SPvcC1LmKR96bhbzEt63WRMlPWswp30pfljf6g+WZjkE6A==
X-Received: by 2002:aa7:c803:: with SMTP id a3mr15914920edt.39.1553720369528;
        Wed, 27 Mar 2019 13:59:29 -0700 (PDT)
Received: from brauner.io ([2a02:8109:b6bf:d24a:b136:35b0:7c8c:280a])
        by smtp.gmail.com with ESMTPSA id j3sm523360ejv.22.2019.03.27.13.59.25
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Wed, 27 Mar 2019 13:59:29 -0700 (PDT)
Date:   Wed, 27 Mar 2019 21:59:23 +0100
From:   Christian Brauner <christian@brauner.io>
To:     Yann Droneaud <ydroneaud@opteya.com>
Cc:     jannh@google.com, khlebnikov@yandex-team.ru, luto@kernel.org,
        dhowells@redhat.com, serge@hallyn.com, ebiederm@xmission.com,
        linux-api@vger.kernel.org, linux-kernel@vger.kernel.org,
        arnd@arndb.de, keescook@chromium.org, adobriyan@gmail.com,
        tglx@linutronix.de, mtk.manpages@gmail.com, bl0pbl33p@gmail.com,
        ldv@altlinux.org, akpm@linux-foundation.org, oleg@redhat.com,
        nagarathnam.muthusamy@oracle.com, cyphar@cyphar.com,
        viro@zeniv.linux.org.uk, joel@joelfernandes.org, dancol@google.com
Subject: Re: [PATCH 2/4] pid: add pidfd_open()
Message-ID: <20190327205922.ajkkylqft6tp5cf7@brauner.io>
References: <20190327162147.23198-1-christian@brauner.io>
 <20190327162147.23198-3-christian@brauner.io>
 <9254286c02dbe883c14e38ed2af0022d36b17355.camel@opteya.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <9254286c02dbe883c14e38ed2af0022d36b17355.camel@opteya.com>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 27, 2019 at 06:21:24PM +0100, Yann Droneaud wrote:
> Le mercredi 27 mars 2019 à 17:21 +0100, Christian Brauner a écrit :
> 
> > diff --git a/kernel/pid.c b/kernel/pid.c
> > index 20881598bdfa..c9e24e726aba 100644
> > --- a/kernel/pid.c
> > +++ b/kernel/pid.c
> > @@ -26,8 +26,10 @@
> > +SYSCALL_DEFINE4(pidfd_open, pid_t, pid, int, procfd, int, pidfd,
> > unsigned int,
> > +		flags)
> > +{
> > +	long fd = -EINVAL;
> > +
> > +	if (flags & ~(PIDFD_TO_PROCFD | PROCFD_TO_PIDFD))
> > +		return -EINVAL;
> > +
> > +	if (!flags) {
> > +		struct pid *pidfd_pid;
> > +
> > +		if (pid <= 0)
> > +			return -EINVAL;
> > +
> > +		if (procfd != -1 || pidfd != -1)
> > +			return -EINVAL;
> > +
> > +		rcu_read_lock();
> > +		pidfd_pid = get_pid(find_pid_ns(pid, task_active_pid_ns(current)));
> > +		rcu_read_unlock();
> > +
> > +		fd = pidfd_create_fd(pidfd_pid, O_CLOEXEC);
> > +		put_pid(pidfd_pid);
> > +	} else if (flags & PIDFD_TO_PROCFD) {
> 
> [...]
> 
> > +	} else if (flags & PROCFD_TO_PIDFD) {
> > +		if (flags & ~PROCFD_TO_PIDFD)
> > +			return -EINVAL;
> > +
> > +		if (pid != -1)
> > +			return -EINVAL;
> > +
> > +		if (pidfd >= 0)
> > 
> 
> I think it can be stricter with:
> 
>                 if (pidfd != -1)

Yes.

> 
> (and match the check done for flag == 0).
> 
> Regards.
> 
> -- 
> Yann Droneaud
> OPTEYA
> 
> 
