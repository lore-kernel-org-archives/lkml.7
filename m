Return-Path: <SRS0=8sqo=RS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 44DD2C43381
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Mar 2019 20:14:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1DCF621871
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Mar 2019 20:14:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726860AbfCOUOr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 Mar 2019 16:14:47 -0400
Received: from mx1.redhat.com ([209.132.183.28]:38782 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726097AbfCOUOq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Mar 2019 16:14:46 -0400
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 490F11E317;
        Fri, 15 Mar 2019 20:14:46 +0000 (UTC)
Received: from [10.40.204.143] (ovpn-204-143.brq.redhat.com [10.40.204.143])
        by smtp.corp.redhat.com (Postfix) with ESMTP id EDD7E1001DD4;
        Fri, 15 Mar 2019 20:14:43 +0000 (UTC)
Subject: Re: [PATCH net-next] selftests: bpf: modify urandom_read and link it
 non-statically
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
References: <20190315200414.32346-1-ivecera@redhat.com>
 <20190315200847.GC5481@mini-arch.hsd1.ca.comcast.net>
From:   Ivan Vecera <ivecera@redhat.com>
Message-ID: <2dcdc11c-4d04-4b0e-ddb7-04d969d04651@redhat.com>
Date:   Fri, 15 Mar 2019 21:14:43 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.3
MIME-Version: 1.0
In-Reply-To: <20190315200847.GC5481@mini-arch.hsd1.ca.comcast.net>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.30]); Fri, 15 Mar 2019 20:14:46 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 15. 03. 19 21:08, Stanislav Fomichev wrote:
> On 03/15, Ivan Vecera wrote:
>> After some experiences I found that urandom_read does not need to be
>> linked statically. When the 'read' syscall call is moved to separate
>> non-inlined function then bpf_get_stackid() is able to find
>> the executable in stack trace and extract its build_id from it.
> But why? Do you have some problems with it being linked statically?
> 
Dependency... you don't need to install static glibc to compile the bpf samples. 
Shared libc is available everytime.

Ivan
