Return-Path: <SRS0=EIds=SH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 92D24C282CE
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Apr 2019 21:56:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 62AB7206BA
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Apr 2019 21:56:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726545AbfDEV4t (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 5 Apr 2019 17:56:49 -0400
Received: from kich.slackware.pl ([193.218.152.244]:40830 "EHLO
        kich.slackware.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726124AbfDEV4s (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Apr 2019 17:56:48 -0400
X-Greylist: delayed 405 seconds by postgrey-1.27 at vger.kernel.org; Fri, 05 Apr 2019 17:56:47 EDT
Received: from kich.toxcorp.com (kich.toxcorp.com [193.218.152.244])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: shasta@toxcorp.com)
        by kich.slackware.pl (Postfix) with ESMTPSA id B9DF1C2
        for <linux-kernel@vger.kernel.org>; Fri,  5 Apr 2019 23:50:01 +0200 (CEST)
Date:   Fri, 5 Apr 2019 23:50:01 +0200 (CEST)
From:   Jakub Jankowski <shasta@toxcorp.com>
To:     linux-kernel@vger.kernel.org
Subject: get_mm_cmdline and userspace (Perl) changing argv0
Message-ID: <alpine.LNX.2.21.1904052326230.3249@kich.toxcorp.com>
User-Agent: Alpine 2.21 (LNX 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; format=flowed; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Starting with 4.18 we noticed changing own commandline in Perl by setting 
$0 leads to (a bit) surprising results.

As long as we're setting $0 to something longer than the initial argv0, 
everything works (almost) as expected: reading from /proc/$$/cmdline 
yields what we set $0 to, followed by a single NULL byte.

However, when setting $0 to something shorter, doing the same yields what 
we set $0 to, then a single NULL byte, then thousands (depending on the 
size of the environment) of ' ' (0x20), and then a single NULL.

$ for i in $(seq 1 10); do
    perl -e '$0 = "1234567890"x'"$i"'; print `cat /proc/$$/cmdline`;' | wc -c;
   done
3291
3291
3291
3291
3291
3291
71
81
91
101
$

This leads to weird output of commands like "ps axufww", where a 
daemonized Perl script that had changed its $0 shows up as a long, mostly 
empty line on the process list.

We've seen this on both Perl 5.20 and 5.28, and Perl's code handling 
changes to $0 hasn't really changed since: 
https://perl5.git.perl.org/perl.git/blob/HEAD:/mg.c#l2673

Reverting commit 5ab8271899658042fabc5ae7e6a99066a210bc0e ("fs/proc: 
simplify and clarify get_mm_cmdline() function") in kernel, however, seems 
to restore previous behavior (no NULL byte at the end):

$ for i in $(seq 1 10); do
    perl -e '$0 = "1234567890"x'"$i"'; print `cat /proc/$$/cmdline`;' | wc -c;
   done
10
20
30
40
50
60
70
80
90
100
$

Has anybody else seen / been bothered by this?



Regards,
  Jakub.

-- 
Jakub Jankowski|shasta@toxcorp.com|https://toxcorp.com/
GPG: FCBF F03D 9ADB B768 8B92 BB52 0341 9037 A875 942D
