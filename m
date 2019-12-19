Return-Path: <SRS0=nnGO=2J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_2
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ACD31C2D0D1
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Dec 2019 21:04:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 87D3024679
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Dec 2019 21:04:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727205AbfLSVE0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 19 Dec 2019 16:04:26 -0500
Received: from mail.kernel.org ([198.145.29.99]:54802 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726880AbfLSVE0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Dec 2019 16:04:26 -0500
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D608D24672;
        Thu, 19 Dec 2019 21:04:23 +0000 (UTC)
Date:   Thu, 19 Dec 2019 16:04:22 -0500
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Kirill Tkhai <ktkhai@virtuozzo.com>
Cc:     "mingo@redhat.com" <mingo@redhat.com>,
        "peterz@infradead.org" <peterz@infradead.org>,
        LKML <linux-kernel@vger.kernel.org>,
        "juri.lelli@redhat.com" <juri.lelli@redhat.com>,
        "vincent.guittot@linaro.org" <vincent.guittot@linaro.org>,
        "dietmar.eggemann@arm.com" <dietmar.eggemann@arm.com>,
        "bsegall@google.com" <bsegall@google.com>,
        Mel Gorman <mgorman@suse.de>
Subject: Re: [PATCH v3] sched: Micro optimization in pick_next_task() and in
 check_preempt_curr()
Message-ID: <20191219160422.4eb28a2e@gandalf.local.home>
In-Reply-To: <47a00e0e-69c0-2a2f-6ae1-1a8ec9b01ede@virtuozzo.com>
References: <20191219113517.65617a7b@gandalf.local.home>
        <47a00e0e-69c0-2a2f-6ae1-1a8ec9b01ede@virtuozzo.com>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 19 Dec 2019 20:12:15 +0000
Kirill Tkhai <ktkhai@virtuozzo.com> wrote:

> This introduces an optimization based on xxx_sched_class addresses
> in two hot scheduler functions: pick_next_task() and check_preempt_curr().
> 
> It is possible to compare pointers to sched classes to check, which
> of them has a higher priority, instead of current iterations using
> for_each_class().
> 
> One more result of the patch is that size of object file becomes a little
> less (excluding added BUG_ON(), which goes in __init section):
> 
> $size kernel/sched/core.o
>          text     data      bss	    dec	    hex	filename
> before:  66446    18957	    676	  86079	  1503f	kernel/sched/core.o
> after:   66398    18957	    676	  86031	  1500f	kernel/sched/core.o
> 
> Signed-off-by: Kirill Tkhai <ktkhai@virtuozzo.com>

Care to resend, not as a mime image?

-- Steve


> Content-Type: text/plain; charset="utf-8"
> Content-ID: <C1D028DDF0B4064595B78514E3E235C5@eurprd08.prod.outlook.com>
> Content-Transfer-Encoding: base64
> MIME-Version: 1.0
> X-OriginatorOrg: virtuozzo.com
> X-MS-Exchange-CrossTenant-Network-Message-Id: 63724e70-f5a2-4d04-bbaa-08d784bfbdf9
> X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Dec 2019 20:12:16.0672
>  (UTC)
> X-MS-Exchange-CrossTenant-fromentityheader: Hosted
> X-MS-Exchange-CrossTenant-id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
> X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
> X-MS-Exchange-CrossTenant-userprincipalname: wYML0eHmbgTBU2jD+X1IMNyAYqtN3rJ3EgoGfPJQcQ2Wqq2KJfyClc/7Q5BfozgXMC5ZM7OdiAJShPtJE7UvuA==
> X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR08MB3343
> 
> VGhpcyBpbnRyb2R1Y2VzIGFuIG9wdGltaXphdGlvbiBiYXNlZCBvbiB4eHhfc2NoZWRfY2xhc3Mg
> YWRkcmVzc2VzDQppbiB0d28gaG90IHNjaGVkdWxlciBmdW5jdGlvbnM6IHBpY2tfbmV4dF90YXNr
> KCkgYW5kIGNoZWNrX3ByZWVtcHRfY3VycigpLg0KDQpJdCBpcyBwb3NzaWJsZSB0byBjb21wYXJl
> IHBvaW50ZXJzIHRvIHNjaGVkIGNsYXNzZXMgdG8gY2hlY2ssIHdoaWNoDQpvZiB0aGVtIGhhcyBh
> IGhpZ2hlciBwcmlvcml0eSwgaW5zdGVhZCBvZiBjdXJyZW50IGl0ZXJhdGlvbnMgdXNpbmcNCmZv
> cl9lYWNoX2NsYXNzKCkuDQoNCk9uZSBtb3JlIHJlc3VsdCBvZiB0aGUgcGF0Y2ggaXMgdGhhdCBz
> aXplIG9mIG9iamVjdCBmaWxlIGJlY29tZXMgYSBsaXR0bGUNCmxlc3MgKGV4Y2x1ZGluZyBhZGRl
> ZCBCVUdfT04oKSwgd2hpY2ggZ29lcyBpbiBfX2luaXQgc2VjdGlvbik6DQoNCiRzaXplIGtlcm5l
> bC9zY2hlZC9jb3JlLm8NCiAgICAgICAgIHRleHQgICAgIGRhdGEgICAgICBic3MJICAgIGRlYwkg
> ICAgaGV4CWZpbGVuYW1lDQpiZWZvcmU6ICA2NjQ0NiAgICAxODk1NwkgICAgNjc2CSAgODYwNzkJ
> ICAxNTAzZglrZXJuZWwvc2NoZWQvY29yZS5vDQphZnRlcjogICA2NjM5OCAgICAxODk1NwkgICAg
> Njc2CSAgODYwMzEJICAxNTAwZglrZXJuZWwvc2NoZWQvY29yZS5vDQoNClNpZ25lZC1vZmYtYnk6
> IEtpcmlsbCBUa2hhaSA8a3RraGFpQHZpcnR1b3p6by5jb20+DQotLS0NCiBrZXJuZWwvc2NoZWQv
> Y29yZS5jIHwgICAyNCArKysrKysrKystLS0tLS0tLS0tLS0tLS0NCiAxIGZpbGUgY2hhbmdlZCwg
> OSBpbnNlcnRpb25zKCspLCAxNSBkZWxldGlvbnMoLSkNCg0KZGlmZiAtLWdpdCBhL2tlcm5lbC9z
> Y2hlZC9jb3JlLmMgYi9rZXJuZWwvc2NoZWQvY29yZS5jDQppbmRleCAxNTUwOGMyMDJiZjUuLmJl
> ZmRkNzE1OGIyNyAxMDA2NDQNCi0tLSBhL2tlcm5lbC9zY2hlZC9jb3JlLmMNCisrKyBiL2tlcm5l
> bC9zY2hlZC9jb3JlLmMNCkBAIC0xNDE2LDIwICsxNDE2LDEwIEBAIHN0YXRpYyBpbmxpbmUgdm9p
> ZCBjaGVja19jbGFzc19jaGFuZ2VkKHN0cnVjdCBycSAqcnEsIHN0cnVjdCB0YXNrX3N0cnVjdCAq
> cCwNCiANCiB2b2lkIGNoZWNrX3ByZWVtcHRfY3VycihzdHJ1Y3QgcnEgKnJxLCBzdHJ1Y3QgdGFz
> a19zdHJ1Y3QgKnAsIGludCBmbGFncykNCiB7DQotCWNvbnN0IHN0cnVjdCBzY2hlZF9jbGFzcyAq
> Y2xhc3M7DQotDQotCWlmIChwLT5zY2hlZF9jbGFzcyA9PSBycS0+Y3Vyci0+c2NoZWRfY2xhc3Mp
> IHsNCisJaWYgKHAtPnNjaGVkX2NsYXNzID09IHJxLT5jdXJyLT5zY2hlZF9jbGFzcykNCiAJCXJx
> LT5jdXJyLT5zY2hlZF9jbGFzcy0+Y2hlY2tfcHJlZW1wdF9jdXJyKHJxLCBwLCBmbGFncyk7DQot
> CX0gZWxzZSB7DQotCQlmb3JfZWFjaF9jbGFzcyhjbGFzcykgew0KLQkJCWlmIChjbGFzcyA9PSBy
> cS0+Y3Vyci0+c2NoZWRfY2xhc3MpDQotCQkJCWJyZWFrOw0KLQkJCWlmIChjbGFzcyA9PSBwLT5z
> Y2hlZF9jbGFzcykgew0KLQkJCQlyZXNjaGVkX2N1cnIocnEpOw0KLQkJCQlicmVhazsNCi0JCQl9
> DQotCQl9DQotCX0NCisJZWxzZSBpZiAocC0+c2NoZWRfY2xhc3MgPiBycS0+Y3Vyci0+c2NoZWRf
> Y2xhc3MpDQorCQlyZXNjaGVkX2N1cnIocnEpOw0KIA0KIAkvKg0KIAkgKiBBIHF1ZXVlIGV2ZW50
> IGhhcyBvY2N1cnJlZCwgYW5kIHdlJ3JlIGdvaW5nIHRvIHNjaGVkdWxlLiAgSW4NCkBAIC0zOTE0
> LDggKzM5MDQsNyBAQCBwaWNrX25leHRfdGFzayhzdHJ1Y3QgcnEgKnJxLCBzdHJ1Y3QgdGFza19z
> dHJ1Y3QgKnByZXYsIHN0cnVjdCBycV9mbGFncyAqcmYpDQogCSAqIGhpZ2hlciBzY2hlZHVsaW5n
> IGNsYXNzLCBiZWNhdXNlIG90aGVyd2lzZSB0aG9zZSBsb29zZSB0aGUNCiAJICogb3Bwb3J0dW5p
> dHkgdG8gcHVsbCBpbiBtb3JlIHdvcmsgZnJvbSBvdGhlciBDUFVzLg0KIAkgKi8NCi0JaWYgKGxp
> a2VseSgocHJldi0+c2NoZWRfY2xhc3MgPT0gJmlkbGVfc2NoZWRfY2xhc3MgfHwNCi0JCSAgICBw
> cmV2LT5zY2hlZF9jbGFzcyA9PSAmZmFpcl9zY2hlZF9jbGFzcykgJiYNCisJaWYgKGxpa2VseShw
> cmV2LT5zY2hlZF9jbGFzcyA8PSAmZmFpcl9zY2hlZF9jbGFzcyAmJg0KIAkJICAgcnEtPm5yX3J1
> bm5pbmcgPT0gcnEtPmNmcy5oX25yX3J1bm5pbmcpKSB7DQogDQogCQlwID0gcGlja19uZXh0X3Rh
> c2tfZmFpcihycSwgcHJldiwgcmYpOw0KQEAgLTY1NjksNiArNjU1OCwxMSBAQCB2b2lkIF9faW5p
> dCBzY2hlZF9pbml0KHZvaWQpDQogCXVuc2lnbmVkIGxvbmcgcHRyID0gMDsNCiAJaW50IGk7DQog
> DQorCUJVR19PTigmaWRsZV9zY2hlZF9jbGFzcyA+ICZmYWlyX3NjaGVkX2NsYXNzIHx8DQorCQkm
> ZmFpcl9zY2hlZF9jbGFzcyA+ICZydF9zY2hlZF9jbGFzcyB8fA0KKwkJJnJ0X3NjaGVkX2NsYXNz
> ID4gJmRsX3NjaGVkX2NsYXNzIHx8DQorCQkmZGxfc2NoZWRfY2xhc3MgPiAmc3RvcF9zY2hlZF9j
> bGFzcyk7DQorDQogCXdhaXRfYml0X2luaXQoKTsNCiANCiAjaWZkZWYgQ09ORklHX0ZBSVJfR1JP
> VVBfU0NIRUQNCg0K
