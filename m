Return-Path: <SRS0=LniW=ZY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6F195C432C0
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Dec 2019 02:24:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3E9DC2146E
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Dec 2019 02:24:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1575253483;
	bh=bCX0zLHnRAYKwu7QjN9Wg2R3BkNbHuG8UU52n0LnOyY=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=LSAczFDgNDZeWXYOLXizkvCi+EXFo/GX6s1YbxRSK30yCIBk6mSC9tdQIuWB/XgY1
	 giiq534TrKNbd3WzF0bWXp3s7NdZdz3Yvlw1/P2ZN080Am1/1DTqxFZfNXqwy0vXao
	 GGwFbmbYlsmYKxXTc0Ld4bng9KbmbP4sueazZYGM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727378AbfLBCYm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 1 Dec 2019 21:24:42 -0500
Received: from mail.kernel.org ([198.145.29.99]:58228 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727285AbfLBCYm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 1 Dec 2019 21:24:42 -0500
Received: from devnote (NE2965lan1.rev.em-net.ne.jp [210.141.244.193])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 366E720833;
        Mon,  2 Dec 2019 02:24:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1575253481;
        bh=bCX0zLHnRAYKwu7QjN9Wg2R3BkNbHuG8UU52n0LnOyY=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=wY1eP/G6XCEBWo2esoz0bpaBpVcbJ7JNs6DjR5T1KSAMXzhPEDD/j7ZDlm2tL1rxk
         ay8nBxsUKj+DKIuVOEryFmfxeAM+5y9P5XOJEcTG8xjqpcwa9cFHxwgKXSzgGYhGiJ
         EHhcg33opZ1+HsljQX96NlD+1kcnE3UBYVwEPxO0=
Date:   Mon, 2 Dec 2019 11:24:37 +0900
From:   Masami Hiramatsu <mhiramat@kernel.org>
To:     Anders Roxell <anders.roxell@linaro.org>
Cc:     paulmck@kernel.org, joel@joelfernandes.org,
        "Naveen N . Rao" <naveen.n.rao@linux.ibm.com>,
        Anil S Keshavamurthy <anil.s.keshavamurthy@intel.com>,
        David Miller <davem@davemloft.net>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: next-20191122: qemu arm64: WARNING: suspicious RCU usage
Message-Id: <20191202112437.b7dc520eeea0690623263ad5@kernel.org>
In-Reply-To: <CADYN=9LGeAzBtgZOwA4ro+KnXp=1J1i7h3Sne6BqHvaf4Z6byA@mail.gmail.com>
References: <CADYN=9LGeAzBtgZOwA4ro+KnXp=1J1i7h3Sne6BqHvaf4Z6byA@mail.gmail.com>
X-Mailer: Sylpheed 3.5.1 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

Sorry for replying so late.

On Fri, 22 Nov 2019 22:43:56 +0100
Anders Roxell <anders.roxell@linaro.org> wrote:

> Hi,
> 
> I'm seeing the following warning when I'm booting an arm64 allmodconfig
> kernel [1] on linux-next; tag next-20191122, is this anything you've seen
> before ?
> 
> The code seems to have introduced a long time ago and the warning was
> added recently 28875945ba98 ("rcu: Add support for consolidated-RCU
> reader checking").

I've never seen this but the warning itself is justified.

struct kprobe *get_kprobe(void *addr)
{
        struct hlist_head *head;
        struct kprobe *p;

        head = &kprobe_table[hash_ptr(addr, KPROBE_HASH_BITS)];
        hlist_for_each_entry_rcu(p, head, hlist) {  <---- this cause the warning
                if (p->addr == addr)
                        return p;
        }

        return NULL;
}

The kprobe_table itself is protected by kprobe_mutex OR rcu.
If the caller locks the kprobe_mutex, we can safely access the hash
table, this is what the register_kprobe does. If not, the caller must
disable preemption, this happens when a kprobe (breakpoint) is hit.

Thus, the kernel itself is safe, but it should be fixed.

Thank you,

-- 
Masami Hiramatsu <mhiramat@kernel.org>
