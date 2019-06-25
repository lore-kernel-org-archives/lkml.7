Return-Path: <SRS0=/s9R=UY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B2EFAC48BD4
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Jun 2019 09:39:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 88337214DA
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Jun 2019 09:39:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731617AbfFYJj1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 25 Jun 2019 05:39:27 -0400
Received: from www62.your-server.de ([213.133.104.62]:38364 "EHLO
        www62.your-server.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728860AbfFYJj1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Jun 2019 05:39:27 -0400
Received: from [78.46.172.3] (helo=sslproxy06.your-server.de)
        by www62.your-server.de with esmtpsa (TLSv1.2:DHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.89_1)
        (envelope-from <daniel@iogearbox.net>)
        id 1hfhvB-000680-8l; Tue, 25 Jun 2019 11:39:25 +0200
Received: from [178.199.41.31] (helo=linux.home)
        by sslproxy06.your-server.de with esmtpsa (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.89)
        (envelope-from <daniel@iogearbox.net>)
        id 1hfhvB-000NFN-1B; Tue, 25 Jun 2019 11:39:25 +0200
Subject: Re: bpf: test_verifier: sanitation: alu with different scalars
To:     Yauheni Kaliuta <yauheni.kaliuta@redhat.com>
Cc:     linux-kernel@vger.kernel.org, Jiri Olsa <jolsa@redhat.com>,
        Jiri Benc <jbenc@redhat.com>
References: <xunytvceoyob.fsf@redhat.com>
From:   Daniel Borkmann <daniel@iogearbox.net>
Message-ID: <f703360d-57c5-4858-e308-1e378a9cc0dc@iogearbox.net>
Date:   Tue, 25 Jun 2019 11:39:24 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.3.0
MIME-Version: 1.0
In-Reply-To: <xunytvceoyob.fsf@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Authenticated-Sender: daniel@iogearbox.net
X-Virus-Scanned: Clear (ClamAV 0.100.3/25491/Tue Jun 25 10:02:48 2019)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 06/25/2019 10:29 AM, Yauheni Kaliuta wrote:
> Hi!
> 
> I'm wondering, how the sanitaion tests (#903 5.2-rc6 for example)
> are supposed to work on BE arches:
> 
> {
> 	"sanitation: alu with different scalars 1",
> 	.insns = {
> 	BPF_MOV64_IMM(BPF_REG_0, 1),
> 	BPF_LD_MAP_FD(BPF_REG_ARG1, 0),
> 	BPF_MOV64_REG(BPF_REG_ARG2, BPF_REG_FP),
> 	BPF_ALU64_IMM(BPF_ADD, BPF_REG_ARG2, -16),
> 	BPF_ST_MEM(BPF_DW, BPF_REG_FP, -16, 0),
> 	BPF_EMIT_CALL(BPF_FUNC_map_lookup_elem),
> 	BPF_JMP_IMM(BPF_JNE, BPF_REG_0, 0, 1),
> 	BPF_EXIT_INSN(),
> 	BPF_LDX_MEM(BPF_B, BPF_REG_1, BPF_REG_0, 0),
> 
> reads one byte 0 on BE and 28 on LE (from ->index) since
> 
> 	struct test_val {
> 		unsigned int index;
> 		int foo[MAX_ENTRIES];
> 	};
> 
>         struct test_val value = {
> 		.index = (6 + 1) * sizeof(int),
> 		.foo[6] = 0xabcdef12,
> 	};
> 
> 	BPF_JMP_IMM(BPF_JEQ, BPF_REG_1, 0, 3),
> 
> So different branches are taken depending of the endianness.
> 
> 	BPF_MOV64_IMM(BPF_REG_2, 0),
> 	BPF_MOV64_IMM(BPF_REG_3, 0x100000),
> 	BPF_JMP_A(2),
> 	BPF_MOV64_IMM(BPF_REG_2, 42),
> 	BPF_MOV64_IMM(BPF_REG_3, 0x100001),
> 	BPF_ALU64_REG(BPF_ADD, BPF_REG_2, BPF_REG_3),
> 	BPF_MOV64_REG(BPF_REG_0, BPF_REG_2),
> 	BPF_EXIT_INSN(),
> 	},
> 	.fixup_map_array_48b = { 1 },
> 	.result = ACCEPT,
> 	.retval = 0x100000,
> },

Let me get my hands on a s390x box later today and get back to you.

Thanks,
Daniel
