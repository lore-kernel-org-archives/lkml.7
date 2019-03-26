Return-Path: <SRS0=4nbc=R5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6386AC43381
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Mar 2019 17:17:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2AEEA2082F
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Mar 2019 17:17:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=brauner.io header.i=@brauner.io header.b="TbroYrT8"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731957AbfCZRRH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Mar 2019 13:17:07 -0400
Received: from mail-ed1-f66.google.com ([209.85.208.66]:47047 "EHLO
        mail-ed1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729633AbfCZRRH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Mar 2019 13:17:07 -0400
Received: by mail-ed1-f66.google.com with SMTP id d1so11457596edd.13
        for <linux-kernel@vger.kernel.org>; Tue, 26 Mar 2019 10:17:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=brauner.io; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=S3F54Rgg9SdqVCR1fYYGPlXK/bVADAmZHm3IpnaLymA=;
        b=TbroYrT8xIZO0TU0QMuRdqYZhCY1Sttgp5riHE3Qx6oXhmu6XgGbeiZF0szYWl8011
         4LIPdCQqQwU8ryd4qjL9YLSUOG+oD6NjRFPWDg/vjJ2vbyClGsb6q9mkZns1V2RYGryY
         s08vImwACudrXZ4A7x9qM6YSAhxbpfQjcoPUQRko2gxcHEZKnIH22zHwgySAc5ccD7Th
         GAJeztcAnJO6ZKJbPVUqEbmxOl0hDWR4cOb5diW+GZYcQYb95VhZY1YYFHQNQl3FoZkS
         6Ulx1ngi5yLTn9mbvYxI2/ITa8TBXHMHFmuaqP8LWJ6YbfHZ4t8rK7r6qpuEs5OEmoZx
         zJYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=S3F54Rgg9SdqVCR1fYYGPlXK/bVADAmZHm3IpnaLymA=;
        b=NnhGnnTVtsRqfa3BPV60FQjvtPElFXwn7zp0ABA6+2C53ifS+mnECbgDGpqXduImr+
         BIlkYbofU5OalCmopen5E+TwY3RsU77wm/PVru/gAJ9aXVfDCcMkOnbxY4NuuhayJgSd
         R5//I72kDVaoV5HDfeSMLI5BPPw4LTABdJZ1SRLZIvCt0IgphLiizpZUSBZS1MtynoTS
         elbD3tealnFLy+wMoRDPSL/9fRKjsD9d8Eb6zLek0nOxbt2W+C3K0r0pHcPeAMeqhkFx
         07X4aV0z3RJFOxCStCbOCO7yPK3MmjwN0R1/O2VZTVM/ktXM7JZn8OLzegEKPoYz3NuH
         1pAw==
X-Gm-Message-State: APjAAAWvzmmCGs2IJHltyREZoeJ4M7L0Bo8HOiaduh35oFkRM01SgxEL
        U7+LPERkWeXdjTBYbr/+zvoujg==
X-Google-Smtp-Source: APXvYqy4/4+5qhGiPRV5xiBMHvMcbye/BOedE+3WBCkMYInZFey8ukmjhTa9X1qwCu5iq6oflk0vwg==
X-Received: by 2002:a17:906:f0f:: with SMTP id z15mr18500745eji.125.1553620625820;
        Tue, 26 Mar 2019 10:17:05 -0700 (PDT)
Received: from brauner.io (x59cc895e.dyn.telefonica.de. [89.204.137.94])
        by smtp.gmail.com with ESMTPSA id d20sm6599741eda.82.2019.03.26.10.17.03
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Tue, 26 Mar 2019 10:17:05 -0700 (PDT)
Date:   Tue, 26 Mar 2019 18:17:03 +0100
From:   Christian Brauner <christian@brauner.io>
To:     Joel Fernandes <joel@joelfernandes.org>
Cc:     jannh@google.com, khlebnikov@yandex-team.ru, luto@kernel.org,
        dhowells@redhat.com, serge@hallyn.com, ebiederm@xmission.com,
        linux-api@vger.kernel.org, linux-kernel@vger.kernel.org,
        arnd@arndb.de, keescook@chromium.org, adobriyan@gmail.com,
        tglx@linutronix.de, mtk.manpages@gmail.com, bl0pbl33p@gmail.com,
        ldv@altlinux.org, akpm@linux-foundation.org, oleg@redhat.com,
        nagarathnam.muthusamy@oracle.com, cyphar@cyphar.com,
        viro@zeniv.linux.org.uk, dancol@google.com
Subject: Re: [PATCH v1 2/4] pid: add pidctl()
Message-ID: <20190326171702.smehtebw4e656ehl@brauner.io>
References: <20190326155513.26964-1-christian@brauner.io>
 <20190326155513.26964-3-christian@brauner.io>
 <20190326170601.GA101741@google.com>
 <20190326170827.p2wlwsscf5u6f3i7@brauner.io>
 <20190326171525.GA116974@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20190326171525.GA116974@google.com>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 26, 2019 at 01:15:25PM -0400, Joel Fernandes wrote:
> On Tue, Mar 26, 2019 at 06:08:28PM +0100, Christian Brauner wrote:
> [snip]
> > > > +	struct pid *struct_pid;
> > > > +	pid_t result;
> > > > +
> > > > +	if (flags)
> > > > +		return -EINVAL;
> > > > +
> > > > +	switch (cmd) {
> > > > +	case PIDCMD_QUERY_PID:
> > > > +		break;
> > > > +	case PIDCMD_QUERY_PIDNS:
> > > > +		if (pid)
> > > > +			return -EINVAL;
> > > > +		break;
> > > > +	case PIDCMD_GET_PIDFD:
> > > > +		break;
> > > > +	default:
> > > > +		return -EOPNOTSUPP;
> > > > +	}
> > > > +
> > > > +	source_ns = get_pid_ns_by_fd(source);
> > > > +	if (IS_ERR(source_ns))
> > > > +		return PTR_ERR(source_ns);
> > > > +
> > > > +	target_ns = get_pid_ns_by_fd(target);
> > > > +	if (IS_ERR(target_ns)) {
> > > > +		put_pid_ns(source_ns);
> > > > +		return PTR_ERR(target_ns);
> > > > +	}
> > > > +
> > > > +	if (cmd == PIDCMD_QUERY_PIDNS) {
> > > > +		result = pidns_related(source_ns, target_ns);
> > > > +	} else {
> > > > +		rcu_read_lock();
> > > > +		struct_pid = get_pid(find_pid_ns(pid, source_ns));
> > > > +		rcu_read_unlock();
> > > > +
> > > > +		if (struct_pid)
> > > > +			result = pid_nr_ns(struct_pid, target_ns);
> > > > +		else
> > > > +			result = -ESRCH;
> > > > +
> > > > +		if (cmd == PIDCMD_GET_PIDFD && (result > 0))
> > > > +			result = pidfd_create_fd(struct_pid, O_CLOEXEC);
> > > 
> > > pidfd_create_fd already does put_pid on errors..
> > 
> > it also takes its own reference
> > 
> > > 
> > > > +
> > > > +		if (!result)
> > > > +			result = -ENOENT;
> > > > +
> > > > +		put_pid(struct_pid);
> > > 
> > > so on error you would put_pid twice which seems odd..  I would suggest, don't
> > > release the pid ref from within pidfd_create_fd, release the ref from the
> > > caller. Speaking of which, I added to my list to convert the pid->count to
> > > refcount_t at some point :)
> > 
> > as i said, pidfd_create_fd takes its own reference
> 
> Oh. That was easy to miss. Fair enough. I take that comment back.
> 
> Please also reply to the other comments I posted, thanks. Generally on LKML,
> I have seen there is an expectation to reply to all reviewer's review
> comments even if you agree with them. This helps keep the review going
> smoothly. Just my 2 cents.

I tend to do it in multiple mails depending on whether or not I need to
think about a comment or not.
