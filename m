Return-Path: <SRS0=uTOJ=ST=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1E8F1C282DA
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Apr 2019 14:25:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E0FEB20872
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Apr 2019 14:25:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=brauner.io header.i=@brauner.io header.b="R5I8S7u4"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732496AbfDQOZ5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Apr 2019 10:25:57 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:51964 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730209AbfDQOZ4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Apr 2019 10:25:56 -0400
Received: by mail-wm1-f68.google.com with SMTP id 4so3646928wmf.1
        for <linux-kernel@vger.kernel.org>; Wed, 17 Apr 2019 07:25:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=brauner.io; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=SBRtaGtGdfO2nPrbZYAfnuDGqgX/CkdQttxJ5nNNDx0=;
        b=R5I8S7u4B7fhcZYOXQD2GcqMko7BWx5L55UGtcuHezlzUx8lhmqmiVtlr+m/kCMyG7
         10c0M7wKKpoevxZ9Bymg9j9NXwY5ldHHnwfyTpvtapSaW4TIkry0KFCl2L0T50lhBbxP
         wN9kmuSo+vkLk5OXMKeHH3QhtzM0WkI9NdoAEQc3rrTS3StFKHaCFxe4AViAYny/wwY6
         P8klVDu5AnGXFxbNXKzmEACZoIfuM6AgE1G59hR4zNFjQv+vccjDAl54sXS/ryVmGnpF
         iXou37b17n1dvk/gm4+AqhpYmoVTOdBaD5FJSLP0WQ/290+N/NDTjZlqYgytHBh5/y7E
         U3zw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=SBRtaGtGdfO2nPrbZYAfnuDGqgX/CkdQttxJ5nNNDx0=;
        b=IIIIkXh3fsDIW8P1BBQ2zCXIkO+6Jv8YOoQLXrVo7ewxcNgDPo5ngGtpS31gNhf8bo
         xHkI42NNYY8og2T5m+Hl6zyh0S88r04FhxjjgQ0LXpw1ZEUOD2/REs7BTnkKBqkhJvdd
         /gGL6SMYUuST+TYSr2R8ygY6/pN4OS3jgRFyuH2JW/KRUuN5o/wgWZ6T/AdmR3ZguC/r
         mibwmu3OrJA0GEhsw6VJx4QbsImZmASYFUi11BJ/XDMOlz6sHAnwNlLpwWMGCfVldxT3
         2FcPz3DmRHiuUWf6N7uuZmyb9FJoQhr1aj7/9MTDeltbZ4y42f+1y2m9/Av5V5W/sv8P
         jbnA==
X-Gm-Message-State: APjAAAUeONkET8RD7+ZnkbTuBxcXgfRQbrSAfMQwavcBZQmV9c3nmik+
        dTo8yVdGXyh3KHopGy9l1LZZvw==
X-Google-Smtp-Source: APXvYqwO9oQ4jn9grtw56F/rrjOqpKcMIU2JyGyu+VCmoWsZz9sO57EGc7wH8dA2nBnuxXcyR+/XXA==
X-Received: by 2002:a1c:4105:: with SMTP id o5mr29588506wma.35.1555511154794;
        Wed, 17 Apr 2019 07:25:54 -0700 (PDT)
Received: from brauner.io ([185.197.132.10])
        by smtp.gmail.com with ESMTPSA id y1sm154548713wrd.34.2019.04.17.07.25.53
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Wed, 17 Apr 2019 07:25:54 -0700 (PDT)
Date:   Wed, 17 Apr 2019 16:25:52 +0200
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
Message-ID: <20190417142551.lhufsdffqrih3jsp@brauner.io>
References: <20190416170233.10208-1-christian@brauner.io>
 <20190416170233.10208-3-christian@brauner.io>
 <20190417142253.GH32622@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20190417142253.GH32622@redhat.com>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 17, 2019 at 04:22:54PM +0200, Oleg Nesterov wrote:
> On 04/16, Christian Brauner wrote:
> >
> > +	if (clone_flags & CLONE_PIDFD) {
> > +		retval = pidfd_create(pid, &pidfdf);
> > +		if (retval < 0)
> > +			goto bad_fork_free_pid;
> > +		pidfd = retval;
> > +	}
> 
> ...
> 
> > +	if (clone_flags & CLONE_PIDFD) {
> > +		fd_install(pidfd, pidfdf);
> > +		put_user(pidfd, parent_tidptr);
> 
> put_user() can fail, I don't think this error should be silently ignored,

Yes, you're right, sorry.

> this can lead to the hard-to-trigger/debug problems.
> 
> Why can't we do put_user-with-check along with pidfd_create() above?

Yes, I'll take a look where it makes sense and respin.

Christian
