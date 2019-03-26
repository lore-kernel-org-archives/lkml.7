Return-Path: <SRS0=4nbc=R5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0D4C4C43381
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Mar 2019 00:00:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D0AED20848
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Mar 2019 00:00:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730500AbfCZAAg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Mar 2019 20:00:36 -0400
Received: from www62.your-server.de ([213.133.104.62]:38492 "EHLO
        www62.your-server.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730239AbfCZAAf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Mar 2019 20:00:35 -0400
Received: from [78.46.172.3] (helo=sslproxy06.your-server.de)
        by www62.your-server.de with esmtpsa (TLSv1.2:DHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.89_1)
        (envelope-from <daniel@iogearbox.net>)
        id 1h8ZW2-0003dX-5P; Tue, 26 Mar 2019 01:00:30 +0100
Received: from [178.197.248.24] (helo=linux.home)
        by sslproxy06.your-server.de with esmtpsa (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.89)
        (envelope-from <daniel@iogearbox.net>)
        id 1h8ZW1-000CGW-Uz; Tue, 26 Mar 2019 01:00:30 +0100
Subject: Re: [PATCH 23/27] bpf: Restrict kernel image access functions when
 the kernel is locked down
To:     Stephen Hemminger <stephen@networkplumber.org>,
        Matthew Garrett <matthewgarrett@google.com>
Cc:     jmorris@namei.org, linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org, dhowells@redhat.com,
        Alexei Starovoitov <alexei.starovoitov@gmail.com>,
        netdev@vger.kernel.org, Chun-Yi Lee <jlee@suse.com>,
        Kees Cook <keescook@chromium.org>,
        Andy Lutomirski <luto@amacapital.net>,
        Will Drewry <wad@chromium.org>
References: <20190325220954.29054-1-matthewgarrett@google.com>
 <20190325220954.29054-24-matthewgarrett@google.com>
 <20190325164221.5d8687bd@shemminger-XPS-13-9360>
From:   Daniel Borkmann <daniel@iogearbox.net>
Message-ID: <1cfa7345-c807-db76-f50a-ea3ba70f07b2@iogearbox.net>
Date:   Tue, 26 Mar 2019 01:00:29 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.3.0
MIME-Version: 1.0
In-Reply-To: <20190325164221.5d8687bd@shemminger-XPS-13-9360>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Authenticated-Sender: daniel@iogearbox.net
X-Virus-Scanned: Clear (ClamAV 0.100.2/25399/Mon Mar 25 08:46:48 2019)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 03/26/2019 12:42 AM, Stephen Hemminger wrote:
> On Mon, 25 Mar 2019 15:09:50 -0700
> Matthew Garrett <matthewgarrett@google.com> wrote:
> 
>> From: David Howells <dhowells@redhat.com>
>>
>> There are some bpf functions can be used to read kernel memory:
>> bpf_probe_read, bpf_probe_write_user and bpf_trace_printk.  These allow
>> private keys in kernel memory (e.g. the hibernation image signing key) to
>> be read by an eBPF program and kernel memory to be altered without
>> restriction.

I'm not sure where 'kernel memory to be altered without restriction' comes
from, but it's definitely a wrong statement.

>> Completely prohibit the use of BPF when the kernel is locked down.

In which scenarios will the lock-down mode be used? Mostly niche? I'm asking
as this would otherwise break a lot of existing stuff ... I'd prefer you find
a better solution to this than this straight -EPERM rejection.

>> Suggested-by: Alexei Starovoitov <alexei.starovoitov@gmail.com>
>> Signed-off-by: David Howells <dhowells@redhat.com>
>> cc: netdev@vger.kernel.org
>> cc: Chun-Yi Lee <jlee@suse.com>
>> cc: Alexei Starovoitov <alexei.starovoitov@gmail.com>
>> Cc: Daniel Borkmann <daniel@iogearbox.net>
>> Signed-off-by: Matthew Garrett <matthewgarrett@google.com>
> 
> Wouldn't this mean that Seccomp won't work in locked down mode?
> 

