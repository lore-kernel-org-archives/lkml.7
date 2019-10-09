Return-Path: <SRS0=kpxk=YC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A6B91ECE58C
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Oct 2019 18:35:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 84F1721848
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Oct 2019 18:35:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731442AbfJISff (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 9 Oct 2019 14:35:35 -0400
Received: from www17.your-server.de ([213.133.104.17]:49446 "EHLO
        www17.your-server.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731144AbfJISfe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Oct 2019 14:35:34 -0400
Received: from sslproxy01.your-server.de ([88.198.220.130])
        by www17.your-server.de with esmtpsa (TLSv1.2:DHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.89_1)
        (envelope-from <thomas@m3y3r.de>)
        id 1iIGo8-0003dQ-9e; Wed, 09 Oct 2019 20:35:32 +0200
Received: from [2a02:908:4c22:ec00:8ad5:993:4cda:a89f] (helo=localhost.localdomain)
        by sslproxy01.your-server.de with esmtpsa (TLSv1.2:DHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.89)
        (envelope-from <thomas@m3y3r.de>)
        id 1iIGo7-0008Ma-Ve; Wed, 09 Oct 2019 20:35:32 +0200
From:   Thomas Meyer <thomas@m3y3r.de>
To:     Rasmus Villemoes <linux@rasmusvillemoes.dk>
Cc:     linux-kernel@vger.kernel.org
Subject: Re: [PATCH] kernel/groups.c: use bsearch library function
References: <20191007192632.29535-1-thomas@m3y3r.de>
        <60e43953-a7f9-c52e-150c-74059d1b377b@rasmusvillemoes.dk>
Date:   Wed, 09 Oct 2019 20:35:29 +0200
In-Reply-To: <60e43953-a7f9-c52e-150c-74059d1b377b@rasmusvillemoes.dk> (Rasmus
        Villemoes's message of "Wed, 9 Oct 2019 09:46:21 +0200")
Message-ID: <875zkxydfy.fsf@m3y3r.de>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Authenticated-Sender: thomas@m3y3r.de
X-Virus-Scanned: Clear (ClamAV 0.101.4/25597/Wed Oct  9 10:39:14 2019)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Rasmus Villemoes <linux@rasmusvillemoes.dk> writes:

> On 07/10/2019 21.26, Thomas Meyer wrote:
>> commit b7b2562f7252 ("kernel/groups.c: use sort library function")
>> introduced the sort library function.
>> also use the bsearch library function instead of open-coding the binary
>> search.

Hi,

> Yes, but please note the difference between sorting the group_info and
> searching it: The former is done quite rarely - the setgroups syscall is
> used roughly once per login-session.
>
> But the searching of that structure is done more or less every time a
> user accesses a file not owned by that user (e.g., any time a normal
> user accesses anything in /usr) - at least if I'm reading
> acl_permission_check() right.
>
> So using a callback-based interface, especially in a post-spectre world,
> may have a somewhat large performance impact.

okay, so the code is duplicated for performance reasons? nothing a
compiler can inline, I guess.

so what about a comment instead:

diff --git a/kernel/groups.c b/kernel/groups.c
index daae2f2dc6d4f..46b5d4cd53c2e 100644
--- a/kernel/groups.c
+++ b/kernel/groups.c
@@ -93,7 +93,7 @@ void groups_sort(struct group_info *group_info)
 }
 EXPORT_SYMBOL(groups_sort);
 
-/* a simple bsearch */
+/* duplicate code from lib/bsearch.c for performance reasons */
 int groups_search(const struct group_info *group_info, kgid_t grp)
 {
        unsigned int left, right;


Mfg
thomas
