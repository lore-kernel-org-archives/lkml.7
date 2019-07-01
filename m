Return-Path: <SRS0=3QRk=U6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 37ABDC0650E
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Jul 2019 14:14:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 10D4321721
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Jul 2019 14:14:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=joelfernandes.org header.i=@joelfernandes.org header.b="P0m+0Pg5"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729454AbfGAOOG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Jul 2019 10:14:06 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:37919 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726076AbfGAOOG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Jul 2019 10:14:06 -0400
Received: by mail-pf1-f196.google.com with SMTP id y15so6662897pfn.5
        for <linux-kernel@vger.kernel.org>; Mon, 01 Jul 2019 07:14:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=YINPfktv7kA/rIjO+Od90qPPmCseH3mnLZRR1IdPF7U=;
        b=P0m+0Pg5zUKQchHletu/G/Y+dNejGuQsWLqu87B4A6eMz/sjyy81hitHFOR6fXzhPz
         AMN5nlo6Uy6MMzsJaLz8vgHnGDnk+5OwHIB/wFbp5UlRcnXkTQap8n1x6/809h8GnhKJ
         4W1Ny7IBkYis2w/3iZ1w5tLUKuOdOoRUjJPI8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=YINPfktv7kA/rIjO+Od90qPPmCseH3mnLZRR1IdPF7U=;
        b=nxi3O+UnfMJOOIoZ54KdeRjXcB5FDIhESKXRK/VcNAzpi8HmTnxAPpAfhAHCtsX2xv
         dG4Xie059WYMUR5wUQSYBkZ1B2MBQuHhdq32fGVHz2o39prVXjz2QnHtPtcl5hf3STMb
         rbKw/YDVyUj0C7g1xYraazLplWGjz+kJwqpY1/+XKBd/C/+2PYSPPU0OKI2yxZgihigA
         3sbWFVkpeO+2MPWZkSdCHNfQg6cdYkH+sopBMnlZqLMj+3JbaSVmyA9IxaooVtC/hUL/
         IDEYqhXZBiBMIlGMYC8b6FIccd0JVwX988SnWuZNvKlEL+dzfxHked2a4AgKtudmI9ho
         RXwQ==
X-Gm-Message-State: APjAAAXwv07Mw1oCfqheOOmupgQxXY3Q2wdpKUTdXCKP111P6/o/87Ra
        oQvDkMuDI08xW0EygRh47EHDDw==
X-Google-Smtp-Source: APXvYqyj27gOPZDN0GjUTiTvjHFulxKrQi1/lS6qeYFZf+9M3Eo6w5AY65wlDwexnpHe3Y9i+UCHXA==
X-Received: by 2002:a17:90a:d681:: with SMTP id x1mr30838291pju.13.1561990445430;
        Mon, 01 Jul 2019 07:14:05 -0700 (PDT)
Received: from localhost ([2620:15c:6:12:9c46:e0da:efbf:69cc])
        by smtp.gmail.com with ESMTPSA id a16sm16528335pfd.68.2019.07.01.07.14.04
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Mon, 01 Jul 2019 07:14:04 -0700 (PDT)
Date:   Mon, 1 Jul 2019 10:14:03 -0400
From:   Joel Fernandes <joel@joelfernandes.org>
To:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc:     linux-kernel@vger.kernel.org,
        Josh Triplett <josh@joshtriplett.org>, kernel-team@android.com,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        linux-kselftest@vger.kernel.org,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        "Paul E. McKenney" <paulmck@linux.ibm.com>, rcu@vger.kernel.org,
        Shuah Khan <shuah@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>, dvyukov@google.com
Subject: Re: [RFC 3/3] Revert "rcutorture: Tweak kvm options"
Message-ID: <20190701141403.GA246562@google.com>
References: <20190701040415.219001-1-joel@joelfernandes.org>
 <20190701040415.219001-3-joel@joelfernandes.org>
 <20190701122358.nzebpuunp6o5jxhx@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190701122358.nzebpuunp6o5jxhx@linutronix.de>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 01, 2019 at 02:23:58PM +0200, Sebastian Andrzej Siewior wrote:
> On 2019-07-01 00:04:15 [-0400], Joel Fernandes (Google) wrote:
> > This reverts commit a6fda6dab93c2c06ef4b8cb4b9258df6674d2438 which
> > causes kvm.sh to not run on my machines. The qemu-system-x86_64 command
> > runs but does nothing.
> 
> Nope. I would like to know *why* you need 'noapic' to work. Is it a
> brand new or old qemu-system-x86_64?

I did not have time to debug yesterday and I posted this particular revert as
an 'RFC' just to make aware of this problem.

I spent some more time just now, it looks like this has nothing to do with
'noapic' and appears to be a problem on debian distros with the e1000e NIC.
May be this NIC was added to the virtual hardware because of -machine in the
patch?

Any if I add the following to the qemu command that kvm.sh runs, it works again:
-net nic,model=e1000

Without it I get:
 qemu-system-x86_64: Initialization of device e1000e failed: failed to find romfile "efi-e1000e.rom"

Seems to be mentioned here:
https://bugs.launchpad.net/ubuntu/+source/ipxe/+bug/1737211

And in syzkaller as well:
https://github.com/google/syzkaller/blob/master/vm/qemu/qemu.go#L88

Adding Dmitry who is syzkaller owner for any thoughts as well.

I'm happy to write a patch to set the nic model as e1000 and send it out if
we agree this solution is good enough.

 - Joel

