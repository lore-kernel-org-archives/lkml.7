Return-Path: <SRS0=Y9JJ=T2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,T_DKIMWL_WL_HIGH autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 88A1BC28CBF
	for <linux-kernel@archiver.kernel.org>; Sun, 26 May 2019 20:49:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5FDF32075E
	for <linux-kernel@archiver.kernel.org>; Sun, 26 May 2019 20:49:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1558903778;
	bh=sUOwnOdEE0jz59BMmNZppuyhvfl7Fxz8XluSR/W26lY=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=Cx+HsRLXGnDSB+BXpcBsgj10QIx4l3WkTkDTpWn6mNswDd4XgaZIYYmpb904lA+46
	 2XaKRtIszbA2Tg+KosIAPpbmlODTNBrEWowFPJeuuELSNbEkCLvUsA2CvGTGHkF3uN
	 GoohKPyFhqbDCnZm922YkedsYmUwoAea+9+mWGaU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726276AbfEZUth (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 26 May 2019 16:49:37 -0400
Received: from mail-lf1-f46.google.com ([209.85.167.46]:39682 "EHLO
        mail-lf1-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725827AbfEZUth (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 26 May 2019 16:49:37 -0400
Received: by mail-lf1-f46.google.com with SMTP id f1so10579297lfl.6
        for <linux-kernel@vger.kernel.org>; Sun, 26 May 2019 13:49:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=IJg/yCjfVM3Ozhpb5ZCNN4WebegqjDbfI7FMAeP5e48=;
        b=GD3ZVbCtAZQtaJFSDPqrCMmGJBcOkN8aadPzlAK4DlrCkWV1mtFgYPxuS4XgVoIFNB
         07DttpIS7YSA6RHknmleBz7ZadImeyD5hn2YsmsOhxL1gJeJcYNAfteCCxReSzZW5Sy7
         HXffCAFYiq7pFrgWGoGWbWSP6Y+fjHTJprbE0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=IJg/yCjfVM3Ozhpb5ZCNN4WebegqjDbfI7FMAeP5e48=;
        b=bJ24pBRsEfIsWHezbD62Z/pSGUslDRKC5I7QI4ecEov2KG2L1+ll6Pr/tALRtQLUSV
         wqNNT1FO7fx78DSLxlBiLK5d46VnDe4FHrMXNDOyp2PxuLYowJzQCX3Nx0JN0Tko5/jK
         FdA3luaDgZX8MICRFEgtEl8A0uL8R59kHc+RE9D56OmtHTL/7JX20pFFQBsGLyPJlawx
         Pq9yPBCz6Pwr9hY8xNOUQaB7yO6nye5y2a4DOgFvswrUdsaZG0ZwdzoSkilI1UR60Os4
         ip08m6DraN32wa0XY/wTL8lVRRYEH7YGI1l7uQrIiGYqvBLZS/uJqu9lFJGRf7Hw5Wek
         Sw6A==
X-Gm-Message-State: APjAAAXpiY7Co44hINiSjjpvMc9PcAm91rZxg+UGSnQgwSfYqNkd+qug
        chFDRoB8bWEO+8K+VqgumCPSx4bNuao=
X-Google-Smtp-Source: APXvYqxBo0MqNerB/5bSupuiUIDzJUu975cHC1s38sSeRKYM27Kf9lq1iGxl+URXHxnh/vVBlUW7nw==
X-Received: by 2002:a19:8116:: with SMTP id c22mr1363358lfd.111.1558903774248;
        Sun, 26 May 2019 13:49:34 -0700 (PDT)
Received: from mail-lf1-f52.google.com (mail-lf1-f52.google.com. [209.85.167.52])
        by smtp.gmail.com with ESMTPSA id j19sm1033420lfb.84.2019.05.26.13.49.33
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 26 May 2019 13:49:33 -0700 (PDT)
Received: by mail-lf1-f52.google.com with SMTP id m15so9976102lfh.4
        for <linux-kernel@vger.kernel.org>; Sun, 26 May 2019 13:49:33 -0700 (PDT)
X-Received: by 2002:a19:521a:: with SMTP id m26mr10136807lfb.134.1558903772902;
 Sun, 26 May 2019 13:49:32 -0700 (PDT)
MIME-Version: 1.0
References: <1558864555-53503-1-git-send-email-pbonzini@redhat.com>
 <CAHk-=wi3YcO4JTpkeENETz3fqf3DeKc7-tvXwqPmVcq-pgKg5g@mail.gmail.com> <2d55fd2a-afbf-1b7c-ca82-8bffaa18e0d0@redhat.com>
In-Reply-To: <2d55fd2a-afbf-1b7c-ca82-8bffaa18e0d0@redhat.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Sun, 26 May 2019 13:49:16 -0700
X-Gmail-Original-Message-ID: <CAHk-=wgzKzAwS=_ySikL1f=Gr62YXL_WXGh82wZKMOvzJ9+2VA@mail.gmail.com>
Message-ID: <CAHk-=wgzKzAwS=_ySikL1f=Gr62YXL_WXGh82wZKMOvzJ9+2VA@mail.gmail.com>
Subject: Re: [GIT PULL] KVM changes for Linux 5.2-rc2
To:     Paolo Bonzini <pbonzini@redhat.com>,
        Junio Hamano C <gitster@pobox.com>
Cc:     Linux List Kernel Mailing <linux-kernel@vger.kernel.org>,
        =?UTF-8?B?UmFkaW0gS3LEjW3DocWZ?= <rkrcmar@redhat.com>,
        KVM list <kvm@vger.kernel.org>,
        Git List Mailing <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, May 26, 2019 at 10:53 AM Paolo Bonzini <pbonzini@redhat.com> wrote:
>
> The interesting thing is that not only git will treat lightweight tags
> like, well, tags:

Yeah, that's very much by design - lightweight tags are very
comvenient for local temporary stuff where you don't want signing etc
(think automated test infrastructure, or just local reminders).

> In addition, because I _locally_ had a tag object that
> pointed to the same commit and had the same name, git-request-pull
> included my local tag's message in its output!  I wonder if this could
> be considered a bug.

Yeah, I think git request-pull should at least *warn* about the tag
not being the same object locally as in the remote you're asking me to
pull.

Are you sure you didn't get a warning, and just missed it? But adding
Junio and the Git list just as a possible heads-up for this in case
git request-pull really only compares the object the tag points to,
rather than the SHA1 of the tag itself.

             Linus
