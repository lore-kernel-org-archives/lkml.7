Return-Path: <SRS0=JAXG=U7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DDBDCC06510
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Jul 2019 17:28:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9042C2173E
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Jul 2019 17:28:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore-com.20150623.gappssmtp.com header.i=@paul-moore-com.20150623.gappssmtp.com header.b="lz/WdCza"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726824AbfGBR2r (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Jul 2019 13:28:47 -0400
Received: from mail-lf1-f65.google.com ([209.85.167.65]:34759 "EHLO
        mail-lf1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726193AbfGBR2r (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Jul 2019 13:28:47 -0400
Received: by mail-lf1-f65.google.com with SMTP id b29so2035183lfq.1
        for <linux-kernel@vger.kernel.org>; Tue, 02 Jul 2019 10:28:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:from:date:message-id:subject:to:cc;
        bh=ESbvDEOdDN7N8DWL7d5n/EnOhVPr3X8R6VtdhGwRNQs=;
        b=lz/WdCzaZCnTbIbCuxpcV//e9TGNlh1GfKTw5RvdcDSkmJ6Dj78ko6p+cWWq0ZfArv
         b19JtebtGJImHC+u26CDonFRrWM42EGJR+i8qj/AwJaPvV8gfq6E2uxxIA+9SDc5Itm4
         xsvQ4VScX+i3WZtr0dXxkwZLuwA6xK/Nd70QR7POFURuTUyz10+1HEQs0Vp/QszcAKxH
         DZ1eEadO2vawg7hnJ2QN4lBXbpEpjM37CNzl6Mz/oyRHNoypBiz0Jsig530yPtd7lEsQ
         2hefryuBVodP3YGjE9FoyJqAkY+mRVEfh5zTALbvGCZM/zFcnZyTJYrxejReHxhOpzxT
         ncTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=ESbvDEOdDN7N8DWL7d5n/EnOhVPr3X8R6VtdhGwRNQs=;
        b=iQFVS1BuitmfLImvFoFXg3CGlnoBX0uyDGOzx9+Miqd7m3w1VjG3oN8t+Ykr7FOtmP
         CHAD2l91bKvB6XTAihsRf4uEeOIwv/R8EY6homFU3qMbDjgxOR7u/ct0QtYI5E5g/z5h
         y8WzH5LygTQ9UAjvukud1IW2ODxLEXPEyKaeM7EJGuXw9hkSLLLQNOEhmZ1ZUqFBdWxE
         c/PxTjmqZ55lY3IvtuwhcSks/HL5FRzpgY4k2mwrEWllCwXWxe0oAi1BabivdpdOw530
         kDm1Y7DrKuyWfhcBeQgzEuwAz5VXmrvyF6uT4nRjdbqAKzR9F84RQ3YcA5HU0ery3cnx
         0rmw==
X-Gm-Message-State: APjAAAV1SFTE6Od6MzcyE0lzMO7w1CJYV/6rFBrAfNLmcSmBsqETOU9t
        DiNP11H6ggr8h1iqfPakMeVJVDTXhQ9bTX4fELxtu3ibS4gZ
X-Google-Smtp-Source: APXvYqxl+hOO7NlDSd2NcPfDAxUqaJXo35Dg2EkyAhR8Wt+Mp/lkrTHU5Fea4EB9KnqRfSC0rFeY5SbDGBFVCJ1EV0w=
X-Received: by 2002:ac2:4109:: with SMTP id b9mr13868455lfi.31.1562088524511;
 Tue, 02 Jul 2019 10:28:44 -0700 (PDT)
MIME-Version: 1.0
From:   Paul Moore <paul@paul-moore.com>
Date:   Tue, 2 Jul 2019 13:28:33 -0400
Message-ID: <CAHC9VhQ7md3PmUkzv8DNL-RTrq_4r2sRzGjwwaT0ZS-CPOxGBw@mail.gmail.com>
Subject: [GIT PULL] Audit patches for v5.3
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-audit@redhat.com, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

This PR is a bit early, but with some vacation time coming up I wanted
to send this out now just in case the remote Internet Gods decide not
to smile on me once the merge window opens.  The patchset for v5.3 is
pretty minor this time, the highlights include:

- When the audit daemon is sent a signal, ensure we deliver
information about the sender even when syscall auditing is not
enabled/supported.

- Add the ability to filter audit records based on network address family.

- Tighten the audit field filtering restrictions on string based fields.

- Cleanup the audit field filtering verification code.

- Remove a few BUG() calls from the audit code.

Please pull this once the merge window opens,
-Paul

--
The following changes since commit a188339ca5a396acc588e5851ed7e19f66b0ebd9:

 Linux 5.2-rc1 (2019-05-19 15:47:09 -0700)

are available in the Git repository at:

 git://git.kernel.org/pub/scm/linux/kernel/git/pcmoore/audit.git
   tags/audit-pr-20190702

for you to fetch changes up to 839d05e413856bd686a33b59294d4e8238169320:

 audit: remove the BUG() calls in the audit rule comparison functions
   (2019-05-30 12:53:42 -0400)

----------------------------------------------------------------
audit/stable-5.3 PR 20190702

----------------------------------------------------------------
Paul Moore (1):
     audit: remove the BUG() calls in the audit rule comparison functions

Richard Guy Briggs (4):
     audit: deliver signal_info regarless of syscall
     audit: re-structure audit field valid checks
     audit: add saddr_fam filter field
     audit: enforce op for string fields

include/linux/audit.h      |  9 +++++++
include/uapi/linux/audit.h |  1 +
kernel/audit.c             | 27 +++++++++++++++++++++
kernel/audit.h             |  8 ++++--
kernel/auditfilter.c       | 62 ++++++++++++++++++++++++++---------------
kernel/auditsc.c           | 42 +++++++++++++++++---------------
kernel/signal.c            |  2 +-
7 files changed, 105 insertions(+), 46 deletions(-)

-- 
paul moore
www.paul-moore.com
