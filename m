Return-Path: <SRS0=PjNn=RI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CCE85C43381
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Mar 2019 17:27:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9960020661
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Mar 2019 17:27:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1551806858;
	bh=6EehNyW1yG8bvJ/Ya1ADludhyDeXFdpRa6lUQxUcTxA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=pxP3+G6RcZophhm4rWQDehJvXV6qm9jDQlbT0wPGKTgnI9ZCsCYuZAXe1nsaMT+vZ
	 kDALCKyl2JtCEcEOXtdq5REYchGm00PM1cqSZH9qUzfq9/zAzEM0m+KetS6hmX917y
	 6NP9oEU8hf+1siomPDVBoKQhN9iew70RMCeRa8nM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728169AbfCER1h (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 5 Mar 2019 12:27:37 -0500
Received: from mail-yw1-f67.google.com ([209.85.161.67]:42397 "EHLO
        mail-yw1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727334AbfCER1g (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Mar 2019 12:27:36 -0500
Received: by mail-yw1-f67.google.com with SMTP id v201so7572661ywa.9;
        Tue, 05 Mar 2019 09:27:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=mNi2wcs42w6UeX4ek2kNcWvb2MWYPhhWXQr+BTcHWzA=;
        b=WGvmDns+blbuyso53uWHKhRtDGSCgonJqeV/qv36MQf+5wzAILLS9xN/7V1A5oKJYC
         5p2rYbnI4yHmrwWtXSCzWvVUjtSsgAk1eZUUcKbS3rJO0Bpeb22uLSBw3duLCHZTcc9d
         VyIkNTGwR7bzeBkNy66nBFRpn2AQzDpNvkjKGdKTDBM9NAiA8b5sjPmjIFOdK370b7tB
         O7OmjnWOa2zPniVkNA/bUUFr+WTIktjJiaO2YksyzzTjxaoutu1ToFUOngyifduCGHqi
         umCHTuczoamZ7P4KTFESx8p6VeI3ZGh3TOAGrPl2SvLVfWxCaIhCm/85udUMsIcaYnKh
         wV4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=mNi2wcs42w6UeX4ek2kNcWvb2MWYPhhWXQr+BTcHWzA=;
        b=KpbguuTnMZHNyEjymVpV0xs6CSHGNd+COM8Sj+1kFjm4XApVBrh6fYFEz86zSjR+sr
         +BY+6uMtBL7jPBDNXKCMJnOH9Ar5+8QTQmDfAq2C4Fus8XVmCUD4XjwV9a31pN8aN4ZF
         tWKJ6+tFlm2+FmqkyMQDyiqtTqKXgb631ZjXrobB1VWDlOp/Q5HOryG/yIeZBqJq9ZPU
         KT/zaxdNQT086tFDpAfa9g0tY62JHYfUymxFVQj/upU24gcZdwvB2kJLwYelGLDcRzIu
         rA+kwoaSnq1V9Y+uLyuJbqpvic6g15CZm+8BzUMcC/xclAPWwqaScW4fu4QD40w2A8rm
         8jgw==
X-Gm-Message-State: APjAAAWprz7hCLIxGEOK+FHevlPybUC45t1o/gCy2UYCP8RwjRYxskLX
        r1IuTkrwi0oG1maxv4niHD4=
X-Google-Smtp-Source: APXvYqyeKr78a4dEfjAAMr0jp5YtITHKYQ96ml729Nmp/eeJKDy+vpvLfcWUGNI/0Uwf6CNYOz9Teg==
X-Received: by 2002:a0d:e105:: with SMTP id k5mr1883870ywe.196.1551806855057;
        Tue, 05 Mar 2019 09:27:35 -0800 (PST)
Received: from localhost ([2620:10d:c091:200::1676])
        by smtp.gmail.com with ESMTPSA id w127sm1858621ywf.97.2019.03.05.09.27.33
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 05 Mar 2019 09:27:34 -0800 (PST)
Date:   Tue, 5 Mar 2019 09:27:32 -0800
From:   Tejun Heo <tj@kernel.org>
To:     Oleg Nesterov <oleg@redhat.com>
Cc:     Roman Gushchin <guro@fb.com>, Roman Gushchin <guroan@gmail.com>,
        Kernel Team <Kernel-team@fb.com>,
        "cgroups@vger.kernel.org" <cgroups@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v8 0/7] freezer for cgroup v2
Message-ID: <20190305172711.GE50184@devbig004.ftw2.facebook.com>
References: <20190219220252.4906-1-guro@fb.com>
 <20190220143748.GA9477@redhat.com>
 <20190220220020.GA16335@castle.DHCP.thefacebook.com>
 <20190221162923.GA26064@redhat.com>
 <20190221173422.GY50184@devbig004.ftw2.facebook.com>
 <20190222163441.GA5596@redhat.com>
 <20190222181740.GZ50184@devbig004.ftw2.facebook.com>
 <20190225155725.GA8096@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190225155725.GA8096@redhat.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello, Oleg.

Sorry about the delay.

On Mon, Feb 25, 2019 at 04:57:25PM +0100, Oleg Nesterov wrote:
> > As long as the task is
> > guaranteed to be trapped by signal stop afterwards (and they are), we
> > likely can use them the same way.  The only thing to be careful about
> > would be ensuring that we don't end up flipping group level frozen
> > state inbetween.  Would something like that work?
> 
> I have no idea because I do not understand what exactly do you mean ;)

Heh, sorry about that.  What I meant was that we can consider a task
which is blocked in vfork wait as already frozen and that if we do so
we need to be careful so that frozen state doesn't do a flip between
vfork wait ending and the task getting parked again in a jobctl stop.

> However. Thinking more about this, I am not sure my concerns were valid.
> Yes, cg freezer can "hang" if it races with vfork(). But probably we should
> blame vfork(), not freezer.

I think we'd need to cover that ground regardless of where blame lies.
It's weird if freezing doesn't complete cuz one of the tasks messed up
while vforking.

> The problem is, even ^Z can "hang" if the foreground process does vfork()
> and the new child stops before exit/exec. Now I recall that I even tried
> to make a patch to fix this using ERESTART_RESTARTBLOCK, but had some nasty
> problems with blocked signals...

Ugh... yeah, these wait non-interruptible wait sites which can be
exposed to userspace are nasty.  They end up adding a unique wait
state visible to userspace which comes with a bunch of corner cases.

> de_thread() should use freezable_schedule() in TASK_KILLABLE too. Currently
> it doesn't, but only because we have other (much more serious) problems with
> cred_guard_mutex/exec. However, this is is fine wrt cg freezer, other threads
> can't be frozen exactly because it is killable.
> 
> Anything else does freezer_do_not_count() in TASK_KILLABLE and waits for
> another freezable process?

Can't find any.  Hopefully, that was it?

> So it seems I have to take my words back, perhaps we can forget about
> freezable_schedule/etc.

I think it'd be great to be able to handle these if at all possible.

Thanks.

-- 
tejun
