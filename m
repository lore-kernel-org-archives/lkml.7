Return-Path: <SRS0=uTOJ=ST=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 70582C282DC
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Apr 2019 14:28:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3B88A206BA
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Apr 2019 14:28:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=brauner.io header.i=@brauner.io header.b="FQAEV9ms"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732532AbfDQO2R (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Apr 2019 10:28:17 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:42552 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732007AbfDQO2R (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Apr 2019 10:28:17 -0400
Received: by mail-wr1-f66.google.com with SMTP id g3so32209956wrx.9
        for <linux-kernel@vger.kernel.org>; Wed, 17 Apr 2019 07:28:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=brauner.io; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=myZ37/9z3JypB4LZEGXSfGyXVUihNhtA+LVPyOXuBtc=;
        b=FQAEV9msxnTjXk9pXHHfA4ph6xCAdYTyn9h8zbTx5NaT42m7cfqtj5Q9ASsVoaBROu
         hEThsOy3RIaccwf2w793SvQza5L7pHI0RngqOdOvJAJIiKBizSRdgxUieH0sEgbNsYJ/
         VI0DGmtAf1OwHsn4Wv+iiWyv1yTrwqa+skPXo4t4lq//e9mbhGYsSBCtpdl6pBXfAG1w
         p3NIRbZGuRdeK4cjCtUrQMG9HAnqKhAaB0jY2B/GfYPZqKBl/QcWx3mYEgpH4Ig3LWyt
         cV8XDjNid5p0Iq6yJfgwGM7yaC4sjuiIyvOfmq29YCg1W87KEsSvdL5xEDIlr53yqYoa
         yhcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=myZ37/9z3JypB4LZEGXSfGyXVUihNhtA+LVPyOXuBtc=;
        b=MWwiJKNgCgP3el7ek0A+euU1mZhIIX3ZvywemJI/D9rkq5yfvjL0iMcieF/2QmAu0J
         YWIjx0M4ajX36qF0qTw/aoaZkcpTgMewOSLvqB30ej4zDWKeazE3PNnGnJT91XBTPHE5
         ZiYUf01gOq0/Eai7Zo+Skr25bXXqb3G6t75m+D2UIsYSGEVXUjAlkg31npjIiP5XdQo6
         Y90JjlhCpsTCs5S5BKgXlNmouvgA3kju5pOGz7UF9O2e5DZEQl9gGI2e2i9jpCeA7di5
         D3QvF4TcLy0WaiFw1grJ7QfASoK7LH9FuIl+5qLRbMMgYOYherhjiDKS0dK10GAQKOg5
         2IPw==
X-Gm-Message-State: APjAAAUKecS/FvuTJiBMIjSEkpG/uod0fiR75BAXXaxuD52teZCUKZjf
        gnIqfesZD1zvuPNKVEnjLakZng==
X-Google-Smtp-Source: APXvYqz6M/HT3Y+e0fx7dzCO+csjkrdNeV4kUMnJrvMnRvBMyH4y8KbEgSBiXL50Ym9PP34uAqWSTQ==
X-Received: by 2002:a5d:52ce:: with SMTP id r14mr3220619wrv.224.1555511295324;
        Wed, 17 Apr 2019 07:28:15 -0700 (PDT)
Received: from brauner.io ([185.197.132.10])
        by smtp.gmail.com with ESMTPSA id o1sm3388052wmh.47.2019.04.17.07.28.13
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Wed, 17 Apr 2019 07:28:14 -0700 (PDT)
Date:   Wed, 17 Apr 2019 16:28:12 +0200
From:   Christian Brauner <christian@brauner.io>
To:     Oleg Nesterov <oleg@redhat.com>
Cc:     torvalds@linux-foundation.org, viro@zeniv.linux.org.uk,
        jannh@google.com, dhowells@redhat.com, linux-api@vger.kernel.org,
        linux-kernel@vger.kernel.org, serge@hallyn.com, luto@kernel.org,
        arnd@arndb.de, ebiederm@xmission.com, keescook@chromium.org,
        tglx@linutronix.de, mtk.manpages@gmail.com,
        akpm@linux-foundation.org, cyphar@cyphar.com,
        joel@joelfernandes.org, dancol@google.com
Subject: Re: [PATCH v1 2/4] clone: add CLONE_PIDFD
Message-ID: <20190417142811.dq75bzkubtaixdyr@brauner.io>
References: <20190416170233.10208-1-christian@brauner.io>
 <20190416170233.10208-3-christian@brauner.io>
 <20190417142253.GH32622@redhat.com>
 <20190417142551.lhufsdffqrih3jsp@brauner.io>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20190417142551.lhufsdffqrih3jsp@brauner.io>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 17, 2019 at 04:25:51PM +0200, Christian Brauner wrote:
> On Wed, Apr 17, 2019 at 04:22:54PM +0200, Oleg Nesterov wrote:
> > On 04/16, Christian Brauner wrote:
> > >
> > > +	if (clone_flags & CLONE_PIDFD) {
> > > +		retval = pidfd_create(pid, &pidfdf);
> > > +		if (retval < 0)
> > > +			goto bad_fork_free_pid;
> > > +		pidfd = retval;
> > > +	}
> > 
> > ...
> > 
> > > +	if (clone_flags & CLONE_PIDFD) {
> > > +		fd_install(pidfd, pidfdf);
> > > +		put_user(pidfd, parent_tidptr);
> > 
> > put_user() can fail, I don't think this error should be silently ignored,

Fwiw, the same is currently done for PARENT_SETTID which seems odd as
well...
