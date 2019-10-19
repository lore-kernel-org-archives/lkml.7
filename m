Return-Path: <SRS0=/uHP=YM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A6E9BCA9EAC
	for <linux-kernel@archiver.kernel.org>; Sat, 19 Oct 2019 17:49:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7BBEE222BD
	for <linux-kernel@archiver.kernel.org>; Sat, 19 Oct 2019 17:49:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Axjl9NCq"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726191AbfJSRtL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 19 Oct 2019 13:49:11 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:44923 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726049AbfJSRtL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 19 Oct 2019 13:49:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1571507349;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=vZdwEj7cPSAel4SZdlpSMvftLlMkdlo96xYd1wqGr2Y=;
        b=Axjl9NCqdGrkxf9hu2cZ7nwq0BRXzMBy+2OBAoGjNQUCRoCD8hs2d/EGuWrLknTja6QOx2
        +ugkKrXZv0J+LIfKrKlsKbwHU0j7v19aUxTf+9BqBUywOlCMHi/BnzoOU0u6+H+Eklu6wP
        0MP2D9pQUGk+h36lqu97X8kbvtrxd1k=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-224-AjFTUP5VNkKdsxK9GMRXKQ-1; Sat, 19 Oct 2019 13:49:05 -0400
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id F20F480183D;
        Sat, 19 Oct 2019 17:49:03 +0000 (UTC)
Received: from krava (ovpn-204-36.brq.redhat.com [10.40.204.36])
        by smtp.corp.redhat.com (Postfix) with SMTP id 507E01001B00;
        Sat, 19 Oct 2019 17:49:01 +0000 (UTC)
Date:   Sat, 19 Oct 2019 19:49:00 +0200
From:   Jiri Olsa <jolsa@redhat.com>
To:     Steve MacLean <steve.maclean@linux.microsoft.com>
Cc:     Steve MacLean <Steve.MacLean@microsoft.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Stephane Eranian <eranian@google.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH RESEND] perf inject --jit: Remove //anon mmap events
Message-ID: <20191019174900.GC12782@krava>
References: <1571336600-21843-1-git-send-email-steve.maclean@linux.microsoft.com>
MIME-Version: 1.0
In-Reply-To: <1571336600-21843-1-git-send-email-steve.maclean@linux.microsoft.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-MC-Unique: AjFTUP5VNkKdsxK9GMRXKQ-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=WINDOWS-1252
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 17, 2019 at 11:23:20AM -0700, Steve MacLean wrote:
> From: Steve MacLean <Steve.MacLean@Microsoft.com>
>=20
> While a JIT is jitting code it will eventually need to commit more pages =
and
> change these pages to executable permissions.
>=20
> Typically the JIT will want these colocated to minimize branch displaceme=
nts.
>=20
> The kernel will coalesce these anonymous mapping with identical permissio=
ns
> before sending an MMAP event for the new pages. This means the mmap event=
 for
> the new pages will include the older pages.
>=20
> These anonymous mmap events will obscure the jitdump injected pseudo even=
ts.
> This means that the jitdump generated symbols, machine code, debugging in=
fo,
> and unwind info will no longer be used.
>=20
> Observations:
>=20
> When a process emits a jit dump marker and a jitdump file, the perf-xxx.m=
ap
> file represents inferior information which has been superceded by the
> jitdump jit-xxx.dump file.
>=20
> Further the '//anon*' mmap events are only required for the legacy
> perf-xxx.map mapping.
>=20
> Summary:
>=20
> Add rbtree to track which pids have sucessfully injected a jitdump file.
>=20
> During "perf inject --jit", discard "//anon*" mmap events for any pid whi=
ch
> has sucessfully processed a jitdump file.
>=20
> Committer testing:
>=20
> // jitdump case
> perf record <app with jitdump>
> perf inject --jit --input perf.data --output perfjit.data
>=20
> // verify mmap "//anon" events present initially
> perf script --input perf.data --show-mmap-events | grep '//anon'
> // verify mmap "//anon" events removed
> perf script --input perfjit.data --show-mmap-events | grep '//anon'
>=20
> // no jitdump case
> perf record <app without jitdump>
> perf inject --jit --input perf.data --output perfjit.data
>=20
> // verify mmap "//anon" events present initially
> perf script --input perf.data --show-mmap-events | grep '//anon'
> // verify mmap "//anon" events not removed
> perf script --input perfjit.data --show-mmap-events | grep '//anon'
>=20
> Repro:
>=20
> This issue was discovered while testing the initial CoreCLR jitdump
> implementation. https://github.com/dotnet/coreclr/pull/26897.

I posted some questions for previous version in here,
but can't find answers:
  https://lore.kernel.org/lkml/20191003105716.GB23291@krava/

thanks,
jirka

