Return-Path: <SRS0=uTOJ=ST=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E9443C282DA
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Apr 2019 13:19:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B28EC21773
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Apr 2019 13:19:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=brauner.io header.i=@brauner.io header.b="NFy0S3u0"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732239AbfDQNTL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Apr 2019 09:19:11 -0400
Received: from mail-wm1-f66.google.com ([209.85.128.66]:50789 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726800AbfDQNTK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Apr 2019 09:19:10 -0400
Received: by mail-wm1-f66.google.com with SMTP id z11so3397665wmi.0
        for <linux-kernel@vger.kernel.org>; Wed, 17 Apr 2019 06:19:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=brauner.io; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=7F7DCmP2tde48eewP0Rk9izLFMPxgwDcHtzV9LfLsMY=;
        b=NFy0S3u0DQtOms/NC+Eh3ihaFzd07JakF29+Y5+YeDZIEU3YZboi+ezuCtpCoRys0f
         CDnIFklR6Oi5tPo8NdqZpBz4m22656cct7zNyxV23UONjaJx2KD5uUcj/FCN7OUjz9At
         I3cem7erzN2OHcKPpNFKYIXyFEyziL7oO+3BiBAkiM2uTSM9EDUBpgv6zclv0XYgtdsN
         8zy9BtL7qiwuyuNYcOZ4cc2ZYefhbQrMCGKaR7P7WBF8VXCuG8eftJti+Y8esf1Y9ODB
         //LBjA3TnRTg2vHsGZkVc/XloiDeatwMSYPl9RKFXQFZcYh6xyRDzDm6LOeOvg3Np3vQ
         ddWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=7F7DCmP2tde48eewP0Rk9izLFMPxgwDcHtzV9LfLsMY=;
        b=L1dzQySqmfNPdhNRsIq5Mnzccw/0m35B6MfcennJX7IMM8CQA79nuI+VikSfdVsM6w
         vVU/da2cdSxTf2DWIvH/nki/uHzVMsFSqreBUCV+Nuo1NlNPQojNUMQM2EWSriw20sRo
         f8/r4VQHPvQo5Uza7GlQZsfG4DuPdI9kMsaxidclRVlqCVkPNL0nriS93vBNzsK93eOc
         9sZ/MNC6T26IX5YkTio5bJmFq3gAN+pPvILRdVQ75ukwfTEPBe7cgj8LC0yne8l9oOzN
         zUsJgppfGOXI83D0QNpUrPoYROS1d4MppuCKqQfDYsjCRK9VXIJNISEcPB4OOjEG4D28
         aWPQ==
X-Gm-Message-State: APjAAAXEFsoWFbwyALTQffLbBSJ+9fo5cyquWXipYE/lJRvIRvzStLRD
        DBTT2wdadQyy/k06mbIHeQ7hOw==
X-Google-Smtp-Source: APXvYqzyb8wuN378uwP8El+tWOW0kE3einm6jG7KmeoKoPVDAQRLOQbpJDxelB8cybOBWe+2YXVaYA==
X-Received: by 2002:a1c:4602:: with SMTP id t2mr32764202wma.120.1555507149222;
        Wed, 17 Apr 2019 06:19:09 -0700 (PDT)
Received: from brauner.io ([185.197.132.10])
        by smtp.gmail.com with ESMTPSA id k15sm2454310wrl.91.2019.04.17.06.19.08
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Wed, 17 Apr 2019 06:19:08 -0700 (PDT)
Date:   Wed, 17 Apr 2019 15:19:06 +0200
From:   Christian Brauner <christian@brauner.io>
To:     Oleg Nesterov <oleg@redhat.com>
Cc:     Jann Horn <jannh@google.com>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] signal: don't silently convert SI_USER signals to
 non-current pidfd
Message-ID: <20190417131904.qjkv2xuenhcsz36l@brauner.io>
References: <20190330021232.191205-1-jannh@google.com>
 <20190408131315.GA24111@redhat.com>
 <20190417130336.i55vmf3x6cby2mvi@brauner.io>
 <20190417131602.GE32622@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20190417131602.GE32622@redhat.com>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 17, 2019 at 03:16:03PM +0200, Oleg Nesterov wrote:
> On 04/17, Christian Brauner wrote:
> >
> > On Mon, Apr 08, 2019 at 03:13:16PM +0200, Oleg Nesterov wrote:
> > >
> > > but perhaps it should always fail, even if task_pid(current) == pid.
> > >
> > > sys_rt_sigqueueinfo() allows to send any siginfo to yourself, but this is only needed
> > > for checkpoint/restart.
> >
> > Yes, that's why this was added. I would leave it in exactly because of
> > checkpoint/restart.
> 
> I don't understand...
> 
> c/r doesn't need this "feature" in pidfd_send_signal(), so it can be removed.
> But,

Just out of curiosity: in what sense? They don't need it since they have
other ways of doing this or they *can't* use it for some other reason
I'm not seeing?

Christian
