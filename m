Return-Path: <SRS0=uTOJ=ST=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 35680C282DA
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Apr 2019 14:11:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0180B206BA
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Apr 2019 14:11:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=brauner.io header.i=@brauner.io header.b="MqHiVmP0"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732433AbfDQOLt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Apr 2019 10:11:49 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:40063 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732306AbfDQOLs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Apr 2019 10:11:48 -0400
Received: by mail-wr1-f67.google.com with SMTP id h4so32174740wre.7
        for <linux-kernel@vger.kernel.org>; Wed, 17 Apr 2019 07:11:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=brauner.io; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=GULFxHwqyAV9kpsq187lwfIVbAtO+Q4/JzWiX8uyBFA=;
        b=MqHiVmP0Xcdy6SmGvEIWqmMLIbI2mPGlzxNmEv/4PZKWO6cIqSi+bLeFBX+YiFnwM9
         4vmtLmYN4D7SwS9+2B+RNzuEX/8MwtwUZ0dqTBiCtoTAClKvK8EWhgVIjYfGgKWZPDeZ
         hd1h+tgsArsnZnG7aNgAmSx41tsKdTgZXRqsU46JPIWbyt+LAHqSoystYtiZGQC085fR
         eogd4/WrSk5mbTAyqteaPXrKWEfYyqdOF3ntMNXR5wxtC3mdes0XsWJAgAB7ZpiXBZNT
         Uq16Jxhuqvl/uNy8jXYPpcHEqI1nwpWNUv0sOthaufw49U3eCqvWjWdEdbDV1bOoGfAU
         VKdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=GULFxHwqyAV9kpsq187lwfIVbAtO+Q4/JzWiX8uyBFA=;
        b=PiJNWXZ6qrmaNULfMRKwZMThmyvW9GcIxbyu9zTbpkN45/zc/54+LmdKGhHF9f8s61
         q6NC7UFmDWX5CsyWlDAXhr22/S4ZqewUVjdYxgOszVchi3JC/TcyWhSVdiKLXyD3gI87
         7mqQ+YYpR2A3X/XoPV5P+nwLDt2Cmnq0jpuKK6TBhYEDoGQ+JfEmLsBFKPkmB5x9ogaA
         mSraSHQhjTFewH97tY3U+74IVhqDzSe7ING5QclXcJ+oPeLG498NsUFy9N2056g5Fw80
         IB6aicFQ3/CixmqwQcNK8Dea71TR1BlxrvPs+eCiIio6/rV41J7PhIGXwRwUzwSU6dJU
         rijA==
X-Gm-Message-State: APjAAAWeSMdvRfwqTSX2V80JSowDiGmD7U9BfJTy14ox9QDrCqLaEw0K
        T/Kyu25k5itdqDkVSTE7iLhO4g==
X-Google-Smtp-Source: APXvYqx1EM0JXdxGvua/SCzYuSOMqSNPyzF32CWCAvCE+49wfkROUuMItsKXz7quAHMx3wAwrd16Ww==
X-Received: by 2002:a5d:538d:: with SMTP id d13mr58665857wrv.45.1555510306847;
        Wed, 17 Apr 2019 07:11:46 -0700 (PDT)
Received: from brauner.io ([185.197.132.10])
        by smtp.gmail.com with ESMTPSA id y127sm3345752wmg.29.2019.04.17.07.11.45
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Wed, 17 Apr 2019 07:11:46 -0700 (PDT)
Date:   Wed, 17 Apr 2019 16:11:44 +0200
From:   Christian Brauner <christian@brauner.io>
To:     Oleg Nesterov <oleg@redhat.com>
Cc:     torvalds@linux-foundation.org, viro@zeniv.linux.org.uk,
        jannh@google.com, dhowells@redhat.com, linux-api@vger.kernel.org,
        linux-kernel@vger.kernel.org, serge@hallyn.com, luto@kernel.org,
        arnd@arndb.de, ebiederm@xmission.com, keescook@chromium.org,
        tglx@linutronix.de, mtk.manpages@gmail.com,
        akpm@linux-foundation.org, cyphar@cyphar.com,
        joel@joelfernandes.org, dancol@google.com
Subject: Re: [PATCH v1 3/4] signal: support CLONE_PIDFD with pidfd_send_signal
Message-ID: <20190417141144.k2kmg7hd7pdpywyw@brauner.io>
References: <20190416170233.10208-1-christian@brauner.io>
 <20190416170233.10208-4-christian@brauner.io>
 <20190417140106.GG32622@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20190417140106.GG32622@redhat.com>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 17, 2019 at 04:01:06PM +0200, Oleg Nesterov wrote:
> On 04/16, Christian Brauner wrote:
> >
> > @@ -3581,12 +3588,12 @@ SYSCALL_DEFINE4(pidfd_send_signal, int, pidfd, int, sig,
> >  	if (flags)
> >  		return -EINVAL;
> >
> > -	f = fdget_raw(pidfd);
> > +	f = fdget(pidfd);
> 
> could you explain this change?
> 
> I am just curious, I don't understand why should we disallow O_PATH and how
> this connects to this patch.

Sending a signal through a pidfd is considered to be on a par with a
"write" to that pidfd.
Additionally, we use the fops associated with the fd to detect whether
it is actually a pidfd or not. This is not possible with O_PATH since
f_ops will be set to dummy fops. So we already correctly error out since
we detect that it is an O_PATH before fdget_raw(). This just takes the
opportunity to fix it.

Christian
