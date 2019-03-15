Return-Path: <SRS0=8sqo=RS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B905AC4360F
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Mar 2019 21:50:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 85F2D2085A
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Mar 2019 21:50:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726763AbfCOVus (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 Mar 2019 17:50:48 -0400
Received: from mx1.redhat.com ([209.132.183.28]:38880 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725959AbfCOVur (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Mar 2019 17:50:47 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 607E120B01;
        Fri, 15 Mar 2019 21:50:47 +0000 (UTC)
Received: from colo-mx.corp.redhat.com (colo-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.21])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 3F1275D6A6;
        Fri, 15 Mar 2019 21:50:47 +0000 (UTC)
Received: from zmail17.collab.prod.int.phx2.redhat.com (zmail17.collab.prod.int.phx2.redhat.com [10.5.83.19])
        by colo-mx.corp.redhat.com (Postfix) with ESMTP id 039FC4A460;
        Fri, 15 Mar 2019 21:50:46 +0000 (UTC)
Date:   Fri, 15 Mar 2019 17:50:46 -0400 (EDT)
From:   Ivan Vecera <ivecera@redhat.com>
To:     Stanislav Fomichev <sdf@fomichev.me>
Cc:     netdev@vger.kernel.org, Shuah Khan <shuah@kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Martin KaFai Lau <kafai@fb.com>,
        Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>,
        "open list:BPF (Safe dynamic programs and tools)" 
        <bpf@vger.kernel.org>, open list <linux-kernel@vger.kernel.org>
Message-ID: <1595006055.9467881.1552686646726.JavaMail.zimbra@redhat.com>
In-Reply-To: <20190315205652.GD5481@mini-arch.hsd1.ca.comcast.net>
References: <20190315200414.32346-1-ivecera@redhat.com> <20190315200847.GC5481@mini-arch.hsd1.ca.comcast.net> <2dcdc11c-4d04-4b0e-ddb7-04d969d04651@redhat.com> <20190315205652.GD5481@mini-arch.hsd1.ca.comcast.net>
Subject: Re: [PATCH net-next] selftests: bpf: modify urandom_read and link
 it non-statically
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
X-Originating-IP: [188.244.50.158, 10.4.196.22, 10.5.100.50, 10.4.195.27]
Thread-Topic: selftests: bpf: modify urandom_read and link it non-statically
Thread-Index: 8ouH4th4W02vJUN2Ljh3x8PAlDjAWw==
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.30]); Fri, 15 Mar 2019 21:50:47 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


----- Stanislav Fomichev <sdf@fomichev.me> wrote:
> On 03/15, Ivan Vecera wrote:
> > On 15. 03. 19 21:08, Stanislav Fomichev wrote:
> > > On 03/15, Ivan Vecera wrote:
> > > > After some experiences I found that urandom_read does not need to be
> > > > linked statically. When the 'read' syscall call is moved to separate
> > > > non-inlined function then bpf_get_stackid() is able to find
> > > > the executable in stack trace and extract its build_id from it.
> > > But why? Do you have some problems with it being linked statically?
> > > 
> > Dependency... you don't need to install static glibc to compile the bpf
> > samples. Shared libc is available everytime.
> Oh, the distros that do -devel _and_ -static packages :-)
> 
> So your patch essentially adds a call, that leaves a trace on the stack
> with our build-id. I guess that works as well.

Without that additional call this does not work and build_id selftest fails.

I.
