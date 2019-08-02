Return-Path: <SRS0=qq9d=V6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B912BC32750
	for <linux-kernel@archiver.kernel.org>; Fri,  2 Aug 2019 13:51:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8B0C520679
	for <linux-kernel@archiver.kernel.org>; Fri,  2 Aug 2019 13:51:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=brauner.io header.i=@brauner.io header.b="DKCSwf33"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2436562AbfHBNu7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 2 Aug 2019 09:50:59 -0400
Received: from mail-io1-f68.google.com ([209.85.166.68]:39021 "EHLO
        mail-io1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731873AbfHBNu6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Aug 2019 09:50:58 -0400
Received: by mail-io1-f68.google.com with SMTP id f4so152346432ioh.6
        for <linux-kernel@vger.kernel.org>; Fri, 02 Aug 2019 06:50:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=brauner.io; s=google;
        h=from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=dkJDCou/R5noAf5MeI28VyIZL6uuN+JWyULKfcfVJQk=;
        b=DKCSwf33Jdiifj3e9fyaq1g4dBUIVSNbu/WHTxUTyI5/gr3Y35HBmQLapbEXgN5MEd
         d6CxrACrxA7ifPECr72j7CWNT/slyj+z9q20ihfkxzH/xJwLq7OhiNNvs3mzynRYkehw
         OhN3DvMjmKsThCwK50nKxSpv1ysQbLKjpeOOHsSyATRp4crTneLslH+r0xNi4TmkDcHm
         VRuDYN08ynwGJYYXDAcD0ZivALAo4t5vDWynYjWnfT2VuGdv7rDYTd5mlU45NCsCCTbq
         cYw1USo/okxtt9iGTesc7B78o4jADBclrxv2Q9UlQ2eIsKC0DDUk39vgslTS+bRq9cxL
         +txw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=dkJDCou/R5noAf5MeI28VyIZL6uuN+JWyULKfcfVJQk=;
        b=sPZ6maQatQLD5jS++ZJxu0CIODhp1mfBcUnFU7oQCqNGm67RI9SjM+sVTsejj+H28U
         1YFYD1Fo+NsEAwXqdKrc06h7o37wsNA4EabBd9H4WR2J2VLFVMH4SHIUGFvLwJmCt+eu
         duyUryj6DTzNWpkjws8u/gJlMJg4gUhx0/qYhc5PUwpXz5oqwwqt/hcxBTn7mej6Os/+
         ES0BzmJcQiIc+gp9kPDCd1v+wEOUy7/avhB0jpIj38P2F+e8lSrltgIc/K8P/wRseaf7
         aMQdqvWANmYPE+vDalFBfGIldz77cdQyHz8+rDv2k9JqcZ+cI2xeb43bEYMhX+vgnb7G
         ErpQ==
X-Gm-Message-State: APjAAAWSQLrqkP1uG4Gmelz3DcWlzGFJqPWcBYpD+ALNpQNkqF5IA7eM
        PM/JpHsHM3ObeowP+pbOZx0=
X-Google-Smtp-Source: APXvYqzjb5nxhcfzZ3SkrrnTbaY3MrrIYkFBplygLAaZlgFPdEwZSaAEvWe0H3oi6p2+A7Vtp+ZLdQ==
X-Received: by 2002:a02:6a22:: with SMTP id l34mr142361772jac.126.1564753857639;
        Fri, 02 Aug 2019 06:50:57 -0700 (PDT)
Received: from brauner.io ([162.223.5.78])
        by smtp.gmail.com with ESMTPSA id v3sm57439131iom.53.2019.08.02.06.50.55
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Fri, 02 Aug 2019 06:50:57 -0700 (PDT)
From:   Christian Brauner <christian@brauner.io>
X-Google-Original-From: Christian Brauner <christian.brauner@ubuntu.com>
Date:   Fri, 2 Aug 2019 15:50:54 +0200
To:     Oleg Nesterov <oleg@redhat.com>
Cc:     Christian Brauner <christian@brauner.io>,
        Adrian Reber <areber@redhat.com>,
        Eric Biederman <ebiederm@xmission.com>,
        Pavel Emelianov <xemul@virtuozzo.com>,
        Jann Horn <jannh@google.com>,
        Dmitry Safonov <0x7f454c46@gmail.com>,
        linux-kernel@vger.kernel.org, Andrei Vagin <avagin@gmail.com>,
        Mike Rapoport <rppt@linux.ibm.com>,
        Radostin Stoyanov <rstoyanov1@gmail.com>
Subject: Re: [PATCH v2 1/2] fork: extend clone3() to support CLONE_SET_TID
Message-ID: <20190802135050.fx3tbynztmxbmqik@brauner.io>
References: <20190731161223.2928-1-areber@redhat.com>
 <20190802131943.hkvcssv74j25xmmt@brauner.io>
 <20190802133001.GE20111@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20190802133001.GE20111@redhat.com>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 02, 2019 at 03:30:01PM +0200, Oleg Nesterov wrote:
> On 08/02, Christian Brauner wrote:
> >
> > On Wed, Jul 31, 2019 at 06:12:22PM +0200, Adrian Reber wrote:
> > > The main motivation to add CLONE_SET_TID to clone3() is CRIU.
> > >
> > > To restore a process with the same PID/TID CRIU currently uses
> > > /proc/sys/kernel/ns_last_pid. It writes the desired (PID - 1) to
> > > ns_last_pid and then (quickly) does a clone(). This works most of the
> > > time, but it is racy. It is also slow as it requires multiple syscalls.
> >
> > Can you elaborate how this is racy, please. Afaict, CRIU will always
> > usually restore in a new pid namespace that it controls, right?
> 
> Why? No. For example you can checkpoint (not sure this is correct word)
> a single process in your namespace, then (try to restore) it. 
> 
> > What is
> > the exact race?
> 
> something else in the same namespace can fork() right after criu writes
> the pid-for-restore into ns_last_pid.

Ok, that makes sense. :)
My CRIU userspace knowledge is sporadic, so I'm not sure how exactly it
restores process trees in pid namespaces and what workloads this would
especially help with.
