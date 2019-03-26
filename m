Return-Path: <SRS0=4nbc=R5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C1A3FC43381
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Mar 2019 17:15:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8CE9A20823
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Mar 2019 17:15:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=joelfernandes.org header.i=@joelfernandes.org header.b="Zm11OzLu"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731755AbfCZRP3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Mar 2019 13:15:29 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:38391 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726175AbfCZRP2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Mar 2019 13:15:28 -0400
Received: by mail-pf1-f194.google.com with SMTP id 10so8376948pfo.5
        for <linux-kernel@vger.kernel.org>; Tue, 26 Mar 2019 10:15:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=p96jIXYeeeI34an2saRyEyS40uoEYuJOG5iesySK25Q=;
        b=Zm11OzLuyJa/8SjNzJD529d00LzQsRcYj+HrxbHKU/p2UFP7rtyM0eaud1G54+OpHr
         vJsH275SucCzezp8Ysy3hYqift9d0as4trCocTEdmhgtsFMPFtjPh1z3qeF/JpbFIwcf
         HYjZCSKOPRfaydIyCOJdIuEvXegUti6lnFPWw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=p96jIXYeeeI34an2saRyEyS40uoEYuJOG5iesySK25Q=;
        b=BymYq52nd4qST+iPzg7sEfQUmVI4JU0oRbF67ABIMq3JJ0uSK9IgWTkOoELVONBre/
         ChCnx8WOF40yoezVB7TQ1P/ZjuyX6QshpUe5mc8tJzKWLARmRCSDls0IarSU1B/rvrnW
         s5xR5cBnpVq17aEkiVfiewyaS7fG208mAONRhXeyuq4bLY+sNe1Dy9VYh5Ej6cKFU2+Q
         MFHr8C8mfjom3SwWHMTuwJTSj42jDTUD5/6lcf9hboyeKEMGoT4BLd4NmdabQLjSo8VF
         2tgDUPVpYgh7ieNDFVTqp+JvQDHyKWFWv3DAj7y1ZTbPQgcFTXG7oJD3q4UKsrHH3nW8
         WUCQ==
X-Gm-Message-State: APjAAAXF3iWwiXktjfDbSoa/Zw1THCTLV/Is3VMLK9kUoXerMjyxda2W
        D3bRdyZfGIDfo/NZj5PwaJJM49S77Pk=
X-Google-Smtp-Source: APXvYqyAOjTl65o17HyVxxQmssCtgxBdUrYArIEdft6cV/+4MLI2qeE/i1Sw7U6rIm3jDcvsG/ssXg==
X-Received: by 2002:a63:441b:: with SMTP id r27mr28942511pga.36.1553620528162;
        Tue, 26 Mar 2019 10:15:28 -0700 (PDT)
Received: from localhost ([2620:15c:6:12:9c46:e0da:efbf:69cc])
        by smtp.gmail.com with ESMTPSA id s15sm23842636pga.71.2019.03.26.10.15.26
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 26 Mar 2019 10:15:26 -0700 (PDT)
Date:   Tue, 26 Mar 2019 13:15:25 -0400
From:   Joel Fernandes <joel@joelfernandes.org>
To:     Christian Brauner <christian@brauner.io>
Cc:     jannh@google.com, khlebnikov@yandex-team.ru, luto@kernel.org,
        dhowells@redhat.com, serge@hallyn.com, ebiederm@xmission.com,
        linux-api@vger.kernel.org, linux-kernel@vger.kernel.org,
        arnd@arndb.de, keescook@chromium.org, adobriyan@gmail.com,
        tglx@linutronix.de, mtk.manpages@gmail.com, bl0pbl33p@gmail.com,
        ldv@altlinux.org, akpm@linux-foundation.org, oleg@redhat.com,
        nagarathnam.muthusamy@oracle.com, cyphar@cyphar.com,
        viro@zeniv.linux.org.uk, dancol@google.com
Subject: Re: [PATCH v1 2/4] pid: add pidctl()
Message-ID: <20190326171525.GA116974@google.com>
References: <20190326155513.26964-1-christian@brauner.io>
 <20190326155513.26964-3-christian@brauner.io>
 <20190326170601.GA101741@google.com>
 <20190326170827.p2wlwsscf5u6f3i7@brauner.io>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190326170827.p2wlwsscf5u6f3i7@brauner.io>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 26, 2019 at 06:08:28PM +0100, Christian Brauner wrote:
[snip]
> > > +	struct pid *struct_pid;
> > > +	pid_t result;
> > > +
> > > +	if (flags)
> > > +		return -EINVAL;
> > > +
> > > +	switch (cmd) {
> > > +	case PIDCMD_QUERY_PID:
> > > +		break;
> > > +	case PIDCMD_QUERY_PIDNS:
> > > +		if (pid)
> > > +			return -EINVAL;
> > > +		break;
> > > +	case PIDCMD_GET_PIDFD:
> > > +		break;
> > > +	default:
> > > +		return -EOPNOTSUPP;
> > > +	}
> > > +
> > > +	source_ns = get_pid_ns_by_fd(source);
> > > +	if (IS_ERR(source_ns))
> > > +		return PTR_ERR(source_ns);
> > > +
> > > +	target_ns = get_pid_ns_by_fd(target);
> > > +	if (IS_ERR(target_ns)) {
> > > +		put_pid_ns(source_ns);
> > > +		return PTR_ERR(target_ns);
> > > +	}
> > > +
> > > +	if (cmd == PIDCMD_QUERY_PIDNS) {
> > > +		result = pidns_related(source_ns, target_ns);
> > > +	} else {
> > > +		rcu_read_lock();
> > > +		struct_pid = get_pid(find_pid_ns(pid, source_ns));
> > > +		rcu_read_unlock();
> > > +
> > > +		if (struct_pid)
> > > +			result = pid_nr_ns(struct_pid, target_ns);
> > > +		else
> > > +			result = -ESRCH;
> > > +
> > > +		if (cmd == PIDCMD_GET_PIDFD && (result > 0))
> > > +			result = pidfd_create_fd(struct_pid, O_CLOEXEC);
> > 
> > pidfd_create_fd already does put_pid on errors..
> 
> it also takes its own reference
> 
> > 
> > > +
> > > +		if (!result)
> > > +			result = -ENOENT;
> > > +
> > > +		put_pid(struct_pid);
> > 
> > so on error you would put_pid twice which seems odd..  I would suggest, don't
> > release the pid ref from within pidfd_create_fd, release the ref from the
> > caller. Speaking of which, I added to my list to convert the pid->count to
> > refcount_t at some point :)
> 
> as i said, pidfd_create_fd takes its own reference

Oh. That was easy to miss. Fair enough. I take that comment back.

Please also reply to the other comments I posted, thanks. Generally on LKML,
I have seen there is an expectation to reply to all reviewer's review
comments even if you agree with them. This helps keep the review going
smoothly. Just my 2 cents.

thanks,

 - Joel

