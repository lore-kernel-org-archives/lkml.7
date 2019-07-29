Return-Path: <SRS0=K9bG=V2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4D5DFC433FF
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jul 2019 14:54:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 200A72054F
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jul 2019 14:54:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=brauner.io header.i=@brauner.io header.b="CXfoye8P"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728684AbfG2OyN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 29 Jul 2019 10:54:13 -0400
Received: from mail-io1-f67.google.com ([209.85.166.67]:41857 "EHLO
        mail-io1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726197AbfG2OyM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Jul 2019 10:54:12 -0400
Received: by mail-io1-f67.google.com with SMTP id j5so116482889ioj.8
        for <linux-kernel@vger.kernel.org>; Mon, 29 Jul 2019 07:54:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=brauner.io; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=CbcFasXRs6Q74mapSNu5x1SKgIy5eGtlSI7L4N2Lods=;
        b=CXfoye8Pdzp7J2mVhI3180iIaSeGw1qThtognGOELxFYcijNrAvvXFx9vjukuWh+1+
         BFJD1ysvRTVYRo+8efiKY6SsUEGiEtiNMsXSGEGEdned2l6RntHpR4sSvwPFCahq0FYK
         KISP+N/oKHc4o6vIw8547M7O50eDjxDxy/S6+0N//kgSZEq1lQ6ArlzN/is463BAkheM
         1CqE1Dsapd0rCRZ/UkzYRmwnRzXHAE2Mcut/FMlr6Es/8H4C1IgwT8GtCy6V6jqyJUV4
         nL8JwtU63HzNXjUqIuYfmYGMRwUXd5MsGpzWIjEh0Zsx6dgmTjZ6U9k9Qzl46veV3/uX
         cLXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=CbcFasXRs6Q74mapSNu5x1SKgIy5eGtlSI7L4N2Lods=;
        b=XFWS0wBwF0bz9bE3BKnAqKPkG1HbEFoARqSuqPDZEpKr8e9XOU0UVg0clVnF5ua9Rb
         TEIkMCRXyFyqZd9RqOZckK0FoDym7VSt788LMZfr5KhoAw2H+O+gzODPdHnBROt+3VqZ
         3zY4SARnI/IldXW/SXG8dfwdmuYtbk/m+UvYn6gO69Ba8l0fGXnx3JvvXNzMsrcSfHRX
         ddLu+CUyTipKct0+K3fgfK3ljHt97+hslwSZNJP4lQtTiS4pRIPo1eFLrPSXgSeSpW8Y
         pnIG1LEdA6H7aTtjRkHgKltISpSYD6bRS5tuk0CILhtnSkNU5SKaAca15XIXYytiJ8V8
         1aYg==
X-Gm-Message-State: APjAAAWTb+PbUsxmPqhGHBMgN+MEy2LEBoEE/i/EOpMtGh1aB8diC9cu
        KMPGxmv65P8/svYXrV+CDGs=
X-Google-Smtp-Source: APXvYqz/xLLmzzwvYt9ZuWv99pATMaOsHNF7q2MgBnomCBQYVO6oB/5s4HDRhoaJ3giaBNT3ALbkKA==
X-Received: by 2002:a02:ac03:: with SMTP id a3mr117002554jao.132.1564412051832;
        Mon, 29 Jul 2019 07:54:11 -0700 (PDT)
Received: from brauner.io ([162.223.5.124])
        by smtp.gmail.com with ESMTPSA id j14sm52530376ioa.78.2019.07.29.07.54.10
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Mon, 29 Jul 2019 07:54:11 -0700 (PDT)
Date:   Mon, 29 Jul 2019 16:54:10 +0200
From:   Christian Brauner <christian@brauner.io>
To:     Oleg Nesterov <oleg@redhat.com>
Cc:     linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
        arnd@arndb.de, ebiederm@xmission.com, keescook@chromium.org,
        joel@joelfernandes.org, tglx@linutronix.de, tj@kernel.org,
        dhowells@redhat.com, jannh@google.com, luto@kernel.org,
        akpm@linux-foundation.org, cyphar@cyphar.com,
        viro@zeniv.linux.org.uk, kernel-team@android.com
Subject: Re: [PATCH v3 1/2] pidfd: add P_PIDFD to waitid()
Message-ID: <20190729145408.ro2loxchmbtfk6h6@brauner.io>
References: <20190727222229.6516-1-christian@brauner.io>
 <20190727222229.6516-2-christian@brauner.io>
 <20190729142744.GA11349@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20190729142744.GA11349@redhat.com>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 29, 2019 at 04:27:44PM +0200, Oleg Nesterov wrote:
> On 07/28, Christian Brauner wrote:
> >
> > +static struct pid *pidfd_get_pid(unsigned int fd)
> > +{
> > +	struct fd f;
> > +	struct pid *pid;
> > +
> > +	f = fdget(fd);
> > +	if (!f.file)
> > +		return ERR_PTR(-EBADF);
> > +
> > +	pid = pidfd_pid(f.file);
> > +	if (!IS_ERR(pid))
> > +		get_pid(pid);
> > +
> > +	fdput(f);
> > +	return pid;
> > +}
> 
> Agreed, this looks better than the previous version.
> 
> FWIW,
> 
> Reviewed-by: Oleg Nesterov <oleg@redhat.com>

Thanks Oleg!
Christian
