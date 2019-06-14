Return-Path: <SRS0=TKbG=UN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4ECC5C31E44
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Jun 2019 03:40:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 27B8621473
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Jun 2019 03:40:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725846AbfFNDj4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Jun 2019 23:39:56 -0400
Received: from namei.org ([65.99.196.166]:39088 "EHLO namei.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725616AbfFNDj4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Jun 2019 23:39:56 -0400
Received: from localhost (localhost [127.0.0.1])
        by namei.org (8.14.4/8.14.4) with ESMTP id x5E3cr1f007713;
        Fri, 14 Jun 2019 03:38:53 GMT
Date:   Fri, 14 Jun 2019 13:38:53 +1000 (AEST)
From:   James Morris <jmorris@namei.org>
To:     Igor Lubashev <ilubashe@akamai.com>
cc:     Serge Hallyn <serge@hallyn.com>,
        linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org, David Howells <dhowells@redhat.com>,
        Al Viro <viro@ftp.linux.org.uk>
Subject: Re: [RFC PATCH 0/1] security: add SECURE_KEEP_FSUID to preserve
 fsuid/fsgid across execve
In-Reply-To: <1560473087-27754-1-git-send-email-ilubashe@akamai.com>
Message-ID: <alpine.LRH.2.21.1906141338350.7150@namei.org>
References: <1560473087-27754-1-git-send-email-ilubashe@akamai.com>
User-Agent: Alpine 2.21 (LRH 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

[Adding David and Al]


On Thu, 13 Jun 2019, Igor Lubashev wrote:

> I've posted this in March but received no response. Reposting.
> 
> This patch introduces SECURE_KEEP_FSUID to allow fsuid/fsgid to be
> preserved across execve. It is currently impossible to execve a
> program such that effective and filesystem uid differ.
> 
> The need for this functionality arose from a desire to allow certain
> non-privileged users to run perf. To do this, we install perf without
> set-uid-root and have a set-uid-root wrapper decide who is allowed to
> run perf (and with what arguments).
> 
> The wrapper must execve perf with real and effective root uid, because
> perf and KASLR require this. However, that presently resets fsuid to
> root, giving the user ability to read and overwrite any file owned by
> root (perf report -i, perf record -o). Also, perf record will create
> perf.data that cannot be deleted by the user.
> 
> We cannot reset /proc/sys/kernel/perf_event_paranoid to a permissive
> level, since we must be selective which users have the permissions.
> 
> Of course, we could fix our problem by a patch to perf to allow
> passing a username on the command line and having perf execute
> setfsuid before opening files. However, perf is not the only program
> that uses kernel features that require root uid/euid, so a general
> solution that does not involve updating all such programs seems
> warranted.
> 
> I will update man pages, if this patch is deemed a good idea.
> 
> Igor Lubashev (1):
>   security: add SECURE_KEEP_FSUID to preserve fsuid/fsgid across execve
> 
>  include/uapi/linux/securebits.h | 10 +++++++++-
>  security/commoncap.c            |  9 +++++++--
>  2 files changed, 16 insertions(+), 3 deletions(-)
> 
> 

-- 
James Morris
<jmorris@namei.org>

