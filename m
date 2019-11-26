Return-Path: <SRS0=8t7v=ZS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A1A0FC432C0
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Nov 2019 23:49:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 483C72071E
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Nov 2019 23:49:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1574812141;
	bh=i2L0bR/kDgZX6z+eG//gkWv8nGUDS67q4AE5fTzmhfw=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=oMjizShMTbZs0sLRwyvy3FZUPq9oRjwJWNB0Y6iNldYah+zkF6kBTu62RWfiwHQ8L
	 ztc4ebaEZZeYEBI+LP03NUpEyOfg8zOESgJ1X9ru11H8MWevKe5qS8fmNY7CarwkI3
	 Lm3DMyiVYu6upXT5xqEcCeNUR9nkWk9ImrBz7+EI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727010AbfKZXtA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Nov 2019 18:49:00 -0500
Received: from mail.kernel.org ([198.145.29.99]:51044 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726380AbfKZXtA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Nov 2019 18:49:00 -0500
Received: from devnote2 (NE2965lan1.rev.em-net.ne.jp [210.141.244.193])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6EEF42064B;
        Tue, 26 Nov 2019 23:48:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1574812139;
        bh=i2L0bR/kDgZX6z+eG//gkWv8nGUDS67q4AE5fTzmhfw=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=kMRBYqhB8KjEVupBr+kf0qGsdqthnZiTG53IjrfIi283+Otu7lnQ0yBqI508Fjq0N
         VZyacmB9g1/tImTu0Cn00Xx9lJLZmnyt3bdYzt5lmiTak2k2Ei5Fx3DDV+QZx6EGs1
         Clj0psSAc6QOfmQ9EFQRdcRl5PdYssMIcmoA7DvI=
Date:   Wed, 27 Nov 2019 08:48:54 +0900
From:   Masami Hiramatsu <mhiramat@kernel.org>
To:     Masami Hiramatsu <mhiramat@kernel.org>
Cc:     Steven Rostedt <rostedt@goodmis.org>,
        Peter Zijlstra <peterz@infradead.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org, bristot@redhat.com,
        jbaron@akamai.com, torvalds@linux-foundation.org,
        tglx@linutronix.de, mingo@kernel.org, namit@vmware.com,
        hpa@zytor.com, luto@kernel.org, ard.biesheuvel@linaro.org,
        jpoimboe@redhat.com, jeyu@kernel.org, alexei.starovoitov@gmail.com
Subject: Re: [PATCH -v5 00/17] Rewrite x86/ftrace to use text_poke (and
 more)
Message-Id: <20191127084854.55ce1916e4f6d372f9731ed4@kernel.org>
In-Reply-To: <20191126185809.91574fb8eb02f3b2dd3af863@kernel.org>
References: <20191111131252.921588318@infradead.org>
        <20191125125534.2aaaccf00c38a9a25dee623a@kernel.org>
        <20191125123245.5ae9cb60@gandalf.local.home>
        <20191126091104.5e0cdc61e3b143fae4ed4cfd@kernel.org>
        <20191126175812.c6e0cd1249422989007c91fe@kernel.org>
        <20191126185809.91574fb8eb02f3b2dd3af863@kernel.org>
X-Mailer: Sylpheed 3.5.1 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 26 Nov 2019 18:58:09 +0900
Masami Hiramatsu <mhiramat@kernel.org> wrote:
> I applied following patch, but it seems not enough. While disabling 256 kprobes,
> system was frozen (no BUG message).

Aah, this is another bug in optprobe. I'll send a series for fix these bugs.

Thank you,

-- 
Masami Hiramatsu <mhiramat@kernel.org>
