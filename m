Return-Path: <SRS0=PjNn=RI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D8053C4360F
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Mar 2019 22:17:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3C4E620643
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Mar 2019 22:17:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore-com.20150623.gappssmtp.com header.i=@paul-moore-com.20150623.gappssmtp.com header.b="jnz0IGkD"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728294AbfCEWRs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 5 Mar 2019 17:17:48 -0500
Received: from mail-lf1-f66.google.com ([209.85.167.66]:43550 "EHLO
        mail-lf1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728220AbfCEWRo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Mar 2019 17:17:44 -0500
Received: by mail-lf1-f66.google.com with SMTP id p73so6768132lfe.10
        for <linux-kernel@vger.kernel.org>; Tue, 05 Mar 2019 14:17:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:from:date:message-id:subject:to:cc;
        bh=gycZSpHeEzm9Bb+y6ZInD4EPay3X1lr+WOAbT2jGc3w=;
        b=jnz0IGkDAH3EbUDaoZRjIOIEFDuv5NkUhJiEvdccT9ZFXoGek84jVvPWz62nB56xzt
         u7jWaFQPXkmeXoHX3aJIwIoOl3odyEtLJ7AOWwB/Qe7xgOX/e9csreQ1Ix9r5lgjVlV+
         nELWXUq0Fb/BnX925sGYRn2GzV082ZO5evwAZFpw0pA9m8VusSmeW+TIlClYT3qZUV8/
         2PHujH5ycFO4yAihsmEmumLXVtdtq23UAGVLJXnzt0VRMO6llxqMPiBNT+SW76QFLaZR
         3YaoNBpMTvSN+lGWpW2AHN28OOqBqmS//AM4tYP8YnRRVdpo9/wDjrpO8GdKvmstBJup
         5Zhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=gycZSpHeEzm9Bb+y6ZInD4EPay3X1lr+WOAbT2jGc3w=;
        b=lSzwfKo3DGZxUnV0uL0A0yqhXui2e8KanqQan3KHicFArOZ7DZrZlVssMj907sDTiZ
         HhcRzl+39WwG+/gZW/zdA5AHu4iOZNLp8lXxH8yyYteOlM2bTRVsVausGaUHlWHCS3kz
         JbwrADCkpDqf7hUBDmbeoKLx6GGpNyXJgT/hm7BEpWn9teL3HsPXGelM/93iPio3/IVx
         3NSu921PAVsmMY0ghyYFKrZVHN6GFI9KA7/uHX8+OqqdM2ktyCXihHFZiqRprFrhbN5L
         QtOaLFb7dUb/ghbE31tE9n/R/AVIh45JQvgyrb27UDIwmuRXIYlb9wZUDB/vEXXYoZwg
         GdUQ==
X-Gm-Message-State: APjAAAW69KBxYnOc2RdqcT/X8Nt4QO0CXA19qXccXZhZis//P7dNAiEU
        mf3K7Liy9VT+/KE1YtWy5w9qnmHfvJCTV1PWe1ZE
X-Google-Smtp-Source: APXvYqz+rQBVNGS/1z9Vj6Y6ApudFtOTIYLDjwQEImtklgp7JGieOFj+YbzWRUPkHSuW+sDikWUng7YJe8jq6KrE5Ek=
X-Received: by 2002:ac2:55b2:: with SMTP id y18mr2020169lfg.72.1551824261666;
 Tue, 05 Mar 2019 14:17:41 -0800 (PST)
MIME-Version: 1.0
From:   Paul Moore <paul@paul-moore.com>
Date:   Tue, 5 Mar 2019 17:17:30 -0500
Message-ID: <CAHC9VhRbDONFkYe5J2KtFSRdKcz5Z3vdJFuiZCi_EQiJHFaNtA@mail.gmail.com>
Subject: [GIT PULL] SELinux patches for v5.1
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     selinux@vger.kernel.org, linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

Nine SELinux patches for v5.1, all bug fixes.  As far as I'm
concerned, nothing really jumps out as risky or special to me, but
each commit has a decent description so you can judge for yourself.
As usual, everything passes the selinux-testsuite; please merge for
v5.1.

Thanks,
-Paul

--
The following changes since commit bfeffd155283772bbe78c6a05dec7c0128ee500c:

 Linux 5.0-rc1 (2019-01-06 17:08:20 -0800)

are available in the Git repository at:

 git://git.kernel.org/pub/scm/linux/kernel/git/pcmoore/selinux.git
   tags/selinux-pr-20190305

for you to fetch changes up to 45189a1998e00f6375ebd49d1e18161acddd73de:

 selinux: fix avc audit messages (2019-02-05 12:34:33 -0500)

----------------------------------------------------------------
selinux/stable-5.1 PR 20190305

----------------------------------------------------------------
Ondrej Mosnacek (6):
     selinux: never allow relabeling on context mounts
     selinux: do not override context on context mounts
     selinux: inline some AVC functions used only once
     selinux: replace some BUG_ON()s with a WARN_ON()
     selinux: log invalid contexts in AVCs
     selinux: replace BUG_ONs with WARN_ONs in avc.c

Stephen Smalley (3):
     selinux: avoid silent denials in permissive mode under RCU walk
     selinux: stop passing MAY_NOT_BLOCK to the AVC upon follow_link
     selinux: fix avc audit messages

security/selinux/avc.c              | 199 +++++++++++++++++-------------------
security/selinux/hooks.c            |  58 ++++++++---
security/selinux/include/avc.h      |   6 +-
security/selinux/include/security.h |   3 +
security/selinux/ss/services.c      |  37 ++++++-
5 files changed, 176 insertions(+), 127 deletions(-)

-- 
paul moore
www.paul-moore.com
