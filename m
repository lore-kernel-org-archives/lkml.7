Return-Path: <SRS0=4nbc=R5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 91FF7C43381
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Mar 2019 18:47:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 62FD0206DF
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Mar 2019 18:47:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=joelfernandes.org header.i=@joelfernandes.org header.b="juYc8dxx"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732608AbfCZSrv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Mar 2019 14:47:51 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:42679 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732424AbfCZSru (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Mar 2019 14:47:50 -0400
Received: by mail-pg1-f193.google.com with SMTP id p6so8672431pgh.9
        for <linux-kernel@vger.kernel.org>; Tue, 26 Mar 2019 11:47:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=evtkEUyvRrRjvFyaDDCUAHLJNhiHLTjq1BGqSD9rLwE=;
        b=juYc8dxxUea//n1Hd389Y6XXw+JRdzgr6KWfi60d+DVMR+DwBBe+z3gszu3y06evB3
         WJOFyWghHGeAOMNJrtGutkBgy1uHss0qo2dTi0hFtZ2inaYHd3JfyEip29EgOcR/6hwU
         +zYrLtHbZFt4gY9FtHAUxBOfPpszIPdqGJme0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=evtkEUyvRrRjvFyaDDCUAHLJNhiHLTjq1BGqSD9rLwE=;
        b=pnaNza4BxdqaKbJrq10LSKghxY/NZ6CYdwhY/SC2zxFBgKF6UZ+u3KuV3Ut7wkq1Rk
         O3mPgKrEGAymdHE68b9fZmKPkMLsefkhxN0coBlIVAvztXmuroKn3Ymue2lxDOrwk1ey
         WGCAd1UV15Siso4TaIGLOA1bN2bojR6mhx4UJQOc8y7neMvVoqHJ3IfwGPonuG9h1OIv
         PfUndUUpipzr87lKiI98zuShCjMNcAq7Sv7Fsmu2WjOfAlmKp9hBx55VDHgQ+PfAh2RK
         IdcosG+ajE8ZB333Rfq7H2oAFAxRhfpVu6ajdgXqZ+Bs98jIeZIrfqKO//ZWRvgLa2+G
         lrhw==
X-Gm-Message-State: APjAAAXnSFcoR7bRjF+/8Gn3ecmNCnJezo+GM0pfdanJsq440GkCti8p
        sjcA4YHoxjvZVi7zaesT/ugpBg==
X-Google-Smtp-Source: APXvYqyEoC2fqTG5JDBN/Kja9LTVyZjLvNEYN3IQI47StYgmia+Hm9XtnWeVbHj9K5vvUfFm6Rt1vQ==
X-Received: by 2002:a65:6489:: with SMTP id e9mr15178068pgv.364.1553626070089;
        Tue, 26 Mar 2019 11:47:50 -0700 (PDT)
Received: from localhost ([2620:15c:6:12:9c46:e0da:efbf:69cc])
        by smtp.gmail.com with ESMTPSA id i126sm27983052pfc.101.2019.03.26.11.47.48
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 26 Mar 2019 11:47:49 -0700 (PDT)
Date:   Tue, 26 Mar 2019 14:47:47 -0400
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
Message-ID: <20190326184747.GB114492@google.com>
References: <20190326155513.26964-1-christian@brauner.io>
 <20190326155513.26964-3-christian@brauner.io>
 <20190326170601.GA101741@google.com>
 <20190326172231.daa5a53lxf6nz6jn@brauner.io>
 <20190326181012.GA138478@google.com>
 <20190326181929.eypk2hzprdltcrqd@brauner.io>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190326181929.eypk2hzprdltcrqd@brauner.io>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 26, 2019 at 07:19:30PM +0100, Christian Brauner wrote:
[snip]
> > > > I am actually supportive of Daniel's view that by combining too many
> > > > arguments into a single syscall, becomes confusing and sometimes some
> > > > arguments have to be forced to 0 in the single shoe-horned syscall. Like you
> > > 
> > > There's a difference between an ioctl() and say seccomp() which this is
> > > close to:
> > > int seccomp(unsigned int operation, unsigned int flags, void *args);
> > > The point is that the functionality is closely related not just randomly
> > > unrelated stuff. But as I said I'm more than willing to compromise.
> > 
> > Sounds great, yeah whatever makes sense.
> 
> In case I haven't said this enough: I really appreciate the discussion
> and in general the help on this. That probably sometimes gets lost in
> mails sometimes. :)

I appreciate you saying that and thanks for the work on this :)

 - Joel

