Return-Path: <SRS0=sufd=TK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3BBDEC04A6B
	for <linux-kernel@archiver.kernel.org>; Fri, 10 May 2019 19:15:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 03238217D6
	for <linux-kernel@archiver.kernel.org>; Fri, 10 May 2019 19:15:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=brauner.io header.i=@brauner.io header.b="WmR4NJ19"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727779AbfEJTPB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 10 May 2019 15:15:01 -0400
Received: from mail-ed1-f65.google.com ([209.85.208.65]:34429 "EHLO
        mail-ed1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727535AbfEJTPB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 May 2019 15:15:01 -0400
Received: by mail-ed1-f65.google.com with SMTP id p27so6508132eda.1
        for <linux-kernel@vger.kernel.org>; Fri, 10 May 2019 12:14:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=brauner.io; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=gxKl3BIFmedVIufcJg7QXfHwTA6F1zxgdwp4F7hTM4o=;
        b=WmR4NJ19vFcU/yr7Qnq/hyDWw+r55IJ+aUyqVcm9SdDwzj+AcYjc8Of8p5AFGHL252
         ZzP2s/9evMzfji3Pl/N005Wrk+Caeoy2QPCFkbo1HHr2wMztngtVQwB/SpE3WCV0L6Pb
         sWAeqdUjfORvlfnssbqyxcunrCRY2/zgcHoBFBqfkMZdvmydhyJULNSNT9ckf0UJxw/A
         r2sjPDHgcgleIhJ4uGRdOSBtHp6zW4rvUw3sV7Yuskl4IVMoLpqvDK8PEyS+AjtuLihv
         NMebNl/i6Us92h4r4W7TNPBxwpT06n3y2yVd+hcwTA+u356ix3dg5s4oKpC0ivXZP86l
         V85w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=gxKl3BIFmedVIufcJg7QXfHwTA6F1zxgdwp4F7hTM4o=;
        b=XU9mb2pyibf/rcv/YguUXhm2f8E7Nd5XwqaMRPW0XniNtaoh9uwDXhNa2jQlNW4LTu
         H+uvOhryjmnGUzziYzFawdll1M4ZD+d6QcwPH9o3oojnIjQP7pTHzhwUfbhFuOc/QYZv
         KD3ByjvFICL7U15fANwn/jkLI0SNQRev0PL2dOlY6gwIZ4b5aeuIAXLSiWGXt7FetFIC
         MMAsoQRG9GoJG9/SF+E5vFyEkt3nTRnl+MLZs1qDbluMGdrCuqZuF/iK/MmplgAOUaAH
         aRd6HnkqFAA5h+Zrm3zLP/kPkcJOJvlbJrMo/Wmr2dpyG6YScaKcCi0cD39K1oeTP3IE
         Ot6g==
X-Gm-Message-State: APjAAAX8Pf36KWTb5YbJmi+udbIce1GxH9PD8EKVvKvxrWNb1ZUaHQmZ
        ooPoVmHz+YkH+qB9XO4pQPy0FQ==
X-Google-Smtp-Source: APXvYqyDMFa/nHqOJcb/5ukeJmGiFc4HFwPthvNi2vfw6cALKo4zIYlHoeZ8/MGunqdZ+D9QvIKOrw==
X-Received: by 2002:aa7:da8f:: with SMTP id q15mr11714938eds.54.1557515699296;
        Fri, 10 May 2019 12:14:59 -0700 (PDT)
Received: from brauner.io ([212.91.227.56])
        by smtp.gmail.com with ESMTPSA id i45sm1671806eda.67.2019.05.10.12.14.57
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Fri, 10 May 2019 12:14:58 -0700 (PDT)
Date:   Fri, 10 May 2019 21:14:57 +0200
From:   Christian Brauner <christian@brauner.io>
To:     Oleg Nesterov <oleg@redhat.com>
Cc:     jannh@google.com, viro@zeniv.linux.org.uk,
        torvalds@linux-foundation.org, linux-kernel@vger.kernel.org,
        akpm@linux-foundation.org, arnd@arndb.de, arunks@codeaurora.org,
        cyphar@cyphar.com, dhowells@redhat.com, ebiederm@xmission.com,
        elena.reshetova@intel.com, guro@fb.com, keescook@chromium.org,
        luto@amacapital.net, luto@kernel.org, mhocko@suse.com,
        mingo@kernel.org, mtk.manpages@gmail.com, namit@vmware.com,
        peterz@infradead.org, riel@surriel.com, shakeelb@google.com,
        syzkaller-bugs@googlegroups.com, tglx@linutronix.de,
        wad@chromium.org,
        syzbot+3286e58549edc479faae@syzkaller.appspotmail.com
Subject: Re: [PATCH] fork: do not release lock that wasn't taken
Message-ID: <20190510191456.3gqfoyloezedn3ju@brauner.io>
References: <20190510104913.27143-1-christian@brauner.io>
 <20190510153647.GB21421@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20190510153647.GB21421@redhat.com>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 10, 2019 at 05:36:47PM +0200, Oleg Nesterov wrote:
> On 05/10, Christian Brauner wrote:
> >
> > @@ -2102,7 +2102,7 @@ static __latent_entropy struct task_struct *copy_process(
> >  	 */
> >  	retval = cgroup_can_fork(p);
> >  	if (retval)
> > -		goto bad_fork_put_pidfd;
> > +		goto bad_fork_cgroup_threadgroup_change_end;
> >
> >  	/*
> >  	 * From this point on we must avoid any synchronous user-space
> > @@ -2217,11 +2217,12 @@ static __latent_entropy struct task_struct *copy_process(
> >  	spin_unlock(&current->sighand->siglock);
> >  	write_unlock_irq(&tasklist_lock);
> >  	cgroup_cancel_fork(p);
> > +bad_fork_cgroup_threadgroup_change_end:
> > +	cgroup_threadgroup_change_end(current);
> >  bad_fork_put_pidfd:
> >  	if (clone_flags & CLONE_PIDFD)
> >  		ksys_close(pidfd);
> >  bad_fork_free_pid:
> > -	cgroup_threadgroup_change_end(current);
> >  	if (pid != &init_struct_pid)
> >  		free_pid(pid);
> >  bad_fork_cleanup_thread:
> 
> Reviewed-by: Oleg Nesterov <oleg@redhat.com>

Thanks for the quick review, Oleg! :)
Christian
