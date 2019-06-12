Return-Path: <SRS0=n7Fw=UL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 45271C31E46
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Jun 2019 20:56:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1F3FA208C2
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Jun 2019 20:56:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390472AbfFLU4Z (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Jun 2019 16:56:25 -0400
Received: from mx1.redhat.com ([209.132.183.28]:34280 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388338AbfFLU4Z (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Jun 2019 16:56:25 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id BBB9D309703F;
        Wed, 12 Jun 2019 20:56:19 +0000 (UTC)
Received: from sandy.ghostprotocols.net (ovpn-112-23.phx2.redhat.com [10.3.112.23])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 4791C5F9A7;
        Wed, 12 Jun 2019 20:56:17 +0000 (UTC)
Received: by sandy.ghostprotocols.net (Postfix, from userid 1000)
        id F28D6115; Wed, 12 Jun 2019 17:56:11 -0300 (BRT)
Date:   Wed, 12 Jun 2019 17:56:11 -0300
From:   Arnaldo Carvalho de Melo <acme@redhat.com>
To:     Laura Abbott <labbott@redhat.com>
Cc:     Jiri Olsa <jolsa@kernel.org>,
        Stephane Eranian <eranian@google.com>,
        Florian Weimer <fweimer@redhat.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: perf build failure with newer glibc headers
Message-ID: <20190612205611.GA2149@redhat.com>
References: <4c0a4264-7142-2e6d-540d-aa354700e0bb@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <4c0a4264-7142-2e6d-540d-aa354700e0bb@redhat.com>
X-Url:  http://acmel.wordpress.com
User-Agent: Mutt/1.5.20 (2009-12-10)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.43]); Wed, 12 Jun 2019 20:56:24 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Wed, Jun 12, 2019 at 03:23:12PM -0400, Laura Abbott escreveu:
> Hi,
> 
> While doing some build experiments, I found a compile failure with perf and jvmti:
> 
> BUILDSTDERR:   gcc -Wp,-MD,./.xsk.o.d -Wp,-MT,xsk.o -O2 -g -pipe -Wall -Werror=format-security -Wp,-D_FORTIFY_SOURCE=2 -Wp,-D_GLIBCXX_ASSERTIONS -fexceptions -fstack-protector-strong -grecord-gcc-jvmti/jvmti_agent.c:48:21: error: static declaration of 'gettid' follows non-static declaration
> BUILDSTDERR:    48 | static inline pid_t gettid(void)
> BUILDSTDERR:       |                     ^~~~~~
> BUILDSTDERR: In file included from /usr/include/unistd.h:1170,
> BUILDSTDERR:                  from jvmti/jvmti_agent.c:33:
> BUILDSTDERR: /usr/include/bits/unistd_ext.h:40:16: note: previous declaration of 'gettid' was here
> BUILDSTDERR:    40 | extern __pid_t gettid (void) __THROW;
> BUILDSTDERR:       |                ^~~~~~
> 
> 
> This is with the newer glibc headers that came into Fedora earlier this week
> (glibc-2.29.9000-27.fc31)  It looks like the newer headers now define gettid
> so the in file gettid no longer works. Note this was a custom build with
> jvmti enabled as regular Fedora doesn't have it enabled which is why this
> wasn't reported elsewhere.
> 
> I don't know enough about either the glibc headers or perf to make a suggestion
> on how to fix this but I'm happy to test.

Bummer, I haven't noticed this because my fedora:rawhide perf build test
container wasn't building the jvmti code:

Makefile.config:925: No openjdk development package found, please install JDK package, e.g. openjdk-8-jdk, java-1.8.0-openjdk-devel

i.e.:

[perfbuilder@c0326e8b6511 perf]$ cat /tmp/build/perf/feature/test-jvmti.make.output 
test-jvmti.c:2:10: fatal error: jvmti.h: No such file or directory
    2 | #include <jvmti.h>
      |          ^~~~~~~~~
compilation terminated.
[perfbuilder@c0326e8b6511 perf]$

Installing it I get:

[root@2d7fe307ad20 perf]# rpm -qa | grep openjdk
java-1.8.0-openjdk-1.8.0.212.b04-4.fc31.x86_64
java-1.8.0-openjdk-headless-1.8.0.212.b04-4.fc31.x86_64
java-1.8.0-openjdk-devel-1.8.0.212.b04-4.fc31.x86_64
[root@2d7fe307ad20 perf]# cat
/tmp/build/perf/feature/test-jvmti.make.output 
[root@2d7fe307ad20 perf]# ls -la /tmp/build/perf/feature/test-jvmti.bin 
-rwxr-xr-x. 1 root root 21592 Jun 12 20:48
/tmp/build/perf/feature/test-jvmti.bin
[root@2d7fe307ad20 perf]# 

And reproduce the problem you reported:

jvmti/jvmti_agent.c:48:21: error: static declaration of ‘gettid’ follows
non-static declaration
   48 | static inline pid_t gettid(void)
      |                     ^~~~~~
In file included from /usr/include/unistd.h:1170,
                 from jvmti/jvmti_agent.c:33:

So, we'll have to have a feature test, that defines some HAVE_GETTID
that then ifdefs out our inline copy, working on it.

Thanks for the report!

- Arnaldo
