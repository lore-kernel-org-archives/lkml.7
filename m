Return-Path: <SRS0=19dG=ZH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 60A63C43141
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Nov 2019 10:16:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2F74820718
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Nov 2019 10:16:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1573813019;
	bh=L31Kfs1iCtI5iVDCuelWcjeMJ55bO+AtIuo4wI7qu9U=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=CcdyNGWHbKdkkQ944Mnq3wf+xMgPMfvsuqER9hzDnYZZ+LTI9QNA4kpQ+4WRaGW6Z
	 xXjuzOw9CJ77XMcpCuP2GH0cPz+5gcpETY57m9aGr0O3QeUPp5xFmVKBE6DPxHmOQY
	 TaLV71rBZolDF/fCRWScf/YBdI7J2YmW+R0ka3+Y=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727402AbfKOKQ6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 Nov 2019 05:16:58 -0500
Received: from mail-ot1-f66.google.com ([209.85.210.66]:36460 "EHLO
        mail-ot1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727036AbfKOKQ6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Nov 2019 05:16:58 -0500
Received: by mail-ot1-f66.google.com with SMTP id f10so7594560oto.3;
        Fri, 15 Nov 2019 02:16:57 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=L31Kfs1iCtI5iVDCuelWcjeMJ55bO+AtIuo4wI7qu9U=;
        b=B3sScFr8xItN+PCAKQAeRtJPGIG/pfOvxOmeRw2G6qAdfPkZj8qMwOJpELvgThUmt4
         2aSkHajUnXFEAqLNao9XP/fVdop+7zeBwAJI8ZC9cPsEcG1XqO5j6ppGIP6XcK/L5RsS
         hxdYR6nGSdtTUw+9HzQZItpH682WZn78HDdnRAmIE6St8Z0PbfyT6gtJgpxTuOB6+MjD
         qT2gVoHP+BjEv/CSFGO5Yhwz9cGOVInHzLVuPXwLDaBqgu6HtJ9+Q7YtunJQwv/xAV79
         wrQOVqj2xGvt9mvF4DSs+Qxtg4qfULjfH6wfzs2msdd/pvbG5OZ6kODKCi/lN9hHxsIv
         rY6w==
X-Gm-Message-State: APjAAAX3Vh4Xq/5l8/47MG55cxH8ZTiueF0Btt4y/sjgAFwAF6X7A7/d
        F2GKQ+hKzVRqJpVUFSn78h6Id/NuNEVOsUwuMWc=
X-Google-Smtp-Source: APXvYqxZ/bAtMq18l9mpuCAsg44KJyrcgmnqVoIIx4Mk+o7r4aPh25WzgicKYS/aWkTqw5pQAng03Fta3Cmam/OYkEQ=
X-Received: by 2002:a9d:590f:: with SMTP id t15mr10089371oth.118.1573813017367;
 Fri, 15 Nov 2019 02:16:57 -0800 (PST)
MIME-Version: 1.0
References: <1573041302-4904-1-git-send-email-zhenzhong.duan@oracle.com>
 <1573041302-4904-2-git-send-email-zhenzhong.duan@oracle.com> <2090510.mhlLnX9yIq@kreacher>
In-Reply-To: <2090510.mhlLnX9yIq@kreacher>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Fri, 15 Nov 2019 11:16:46 +0100
Message-ID: <CAJZ5v0i4b0hvGjSjSpBnZ-huJZGi3FmN1z5NVc_4V6CForaLfA@mail.gmail.com>
Subject: Re: [PATCH RESEND v2 1/4] cpuidle-haltpoll: ensure grow start value
 is nonzero
To:     Zhenzhong Duan <zhenzhong.duan@oracle.com>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Paolo Bonzini <pbonzini@redhat.com>,
        =?UTF-8?B?UmFkaW0gS3LEjW3DocWZ?= <rkrcmar@redhat.com>,
        Rafael Wysocki <rafael.j.wysocki@intel.com>,
        Joao Martins <joao.m.martins@oracle.com>,
        Marcelo Tosatti <mtosatti@redhat.com>,
        kvm-devel <kvm@vger.kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 15, 2019 at 11:06 AM Rafael J. Wysocki <rjw@rjwysocki.net> wrote:
>
> On Wednesday, November 6, 2019 12:54:59 PM CET Zhenzhong Duan wrote:
> > dev->poll_limit_ns could be zeroed in certain cases (e.g. by
> > guest_halt_poll_ns = 0). If guest_halt_poll_grow_start is zero,
> > dev->poll_limit_ns will never be bigger than zero.
>
> Given that haltpoll_enable_device() sets dev->poll_limit_ns = 0 to start with,
> I don't think that the statement above is correct.

Scratch this, I misread it.
