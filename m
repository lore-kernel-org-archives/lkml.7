Return-Path: <SRS0=WRlz=SV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 54D2EC282DA
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Apr 2019 20:05:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1DEB82171F
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Apr 2019 20:05:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=brauner.io header.i=@brauner.io header.b="OB3pUf1/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728067AbfDSUF0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 19 Apr 2019 16:05:26 -0400
Received: from mail-ed1-f65.google.com ([209.85.208.65]:43746 "EHLO
        mail-ed1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727257AbfDSUFZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Apr 2019 16:05:25 -0400
Received: by mail-ed1-f65.google.com with SMTP id j20so5190077edq.10
        for <linux-kernel@vger.kernel.org>; Fri, 19 Apr 2019 13:05:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=brauner.io; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=uMdaKPc6cbmPDw/jUyHOfSfDi0qYkd194AEPiu2Adh4=;
        b=OB3pUf1/IjU+fbPfRKZ+PzGkWVCwabAQsUtlhgji50EdjkMcBtaU/CEURF/BpHsBiY
         U+gg4XsP0TDw0vRcb6QAen8xvdsHGA1XXbgjm+TCIhizn5Az8ysU2gQn1TWXciffXIYQ
         PTDEixP+wFh9vRUye+47m8bZ+iq+8Qo0mWWsdHD1yVmQaxXJ2Rj7fOHAbzbdABp4Se8c
         jENyk2w736rJcA90Y7Xhy+3wzGKMirN+jhsGvIGRvXn4CX0nyxoU/SnuReciGNXc9NPO
         cqFOncWj2lU25EwM1JWlkQbqi+Yl0efPwZpwfskVuEk4ok4BoOyD6u8R0qTDrrXhMU/A
         nNxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=uMdaKPc6cbmPDw/jUyHOfSfDi0qYkd194AEPiu2Adh4=;
        b=ZRrhfgxL09w/+FDfiKZQjt1rfe8/BFb3nkrRMu8rBa8V+hhrbmouyS94/JKMA5IeeS
         GVsS8CtGVT+JWhTKldEwJIZwXBhXphdgF/GgGYw9kcct+e+xtx589ARCKwLzf/9WYMrf
         sDc+YIzfMfU9Sq+Oqe1KBDTdXdCNP1Xyrci8akIcowLz7hmv2w+uqpdpgpH+l5WaLZpP
         KCZK7iyFlqjcZe4Y+7jCdNoAPaxcDg3ptKIQ0V4u0qQ95cRdNXt5CBA9VwuRAYsUql6W
         yDbXcemoBE+isHhdmAtbmDsKj38fh+vPjeOPE/td2+sdRvLpMvBhWfdYNAzBRgOrqRk2
         jwug==
X-Gm-Message-State: APjAAAUtKvjEf4yF6obi1vh55VqqcVwMAtlGYEed6LTaZMBUA+QeMZzL
        OF5LcYX2+AjLYZleoWGxKt+TbQ==
X-Google-Smtp-Source: APXvYqx/FSd0DBeVUOXP9xqiYwOqjhniIXB+Jwy5q/xxGFy5dnYqXOHKKsFdCvwY32Vlc/8ITzTWzg==
X-Received: by 2002:a17:906:960a:: with SMTP id s10mr2847284ejx.141.1555704323695;
        Fri, 19 Apr 2019 13:05:23 -0700 (PDT)
Received: from brauner.io ([212.91.227.56])
        by smtp.gmail.com with ESMTPSA id l20sm975261ejb.30.2019.04.19.13.05.22
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Fri, 19 Apr 2019 13:05:23 -0700 (PDT)
Date:   Fri, 19 Apr 2019 22:05:22 +0200
From:   Christian Brauner <christian@brauner.io>
To:     torvalds@linux-foundation.org, viro@zeniv.linux.org.uk,
        jannh@google.com, dhowells@redhat.com, oleg@redhat.com,
        linux-api@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     serge@hallyn.com, luto@kernel.org, arnd@arndb.de,
        ebiederm@xmission.com, keescook@chromium.org, tglx@linutronix.de,
        mtk.manpages@gmail.com, akpm@linux-foundation.org,
        cyphar@cyphar.com, joel@joelfernandes.org, dancol@google.com,
        Jann Horn <jann@thejh.net>
Subject: Re: [PATCH v3 0/4] clone: add CLONE_PIDFD
Message-ID: <20190419200521.5pr66nsdj3i7liip@brauner.io>
References: <20190419120904.27502-1-christian@brauner.io>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20190419120904.27502-1-christian@brauner.io>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 19, 2019 at 02:09:00PM +0200, Christian Brauner wrote:
> Hey,
> 
> /* v3 summary */
> After a brief discussion we decided to block CLONE_PIDFD with
> CLONE_THREAD for now.  Not because it is not possible but because we
> don't have a use-case yet and blocking it makes the initial work for
> pidfd polling easier.  However, it is possible to simply flick the
> switch later.

I have moved v3 into my for-next branch which means it should show up in
linux-next for some testing soon. All versions of the CLONE_PIDFD
patches are on top of v5.1-rc4.

Thanks!
Christian
