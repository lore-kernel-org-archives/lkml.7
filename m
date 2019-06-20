Return-Path: <SRS0=KBKa=UT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3B3ADC43613
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Jun 2019 12:17:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F30A12080D
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Jun 2019 12:17:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1561033064;
	bh=4HHw+Qp9H8V6fIHDzF9H81gSOxHTNJsMIKqmfY8FN5U=;
	h=Date:From:To:Cc:Subject:List-ID:From;
	b=ie116C58WDWmctC0dDA98lA4WfQMj+4YbL93Cc9YuIEltsJ9IUjBK8A9aXzcSN44Y
	 tD13yqEo0vslo77H8Zh8taxCD0HqH3xnmeSTZv/nCQniEl+LihoHCuiUAewKYZIHJq
	 61tkxOEmXZTL4gQGWf8tsJ663AKCy+m6+pR9nAwc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731807AbfFTMRm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Jun 2019 08:17:42 -0400
Received: from mail.kernel.org ([198.145.29.99]:43844 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730886AbfFTMRm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Jun 2019 08:17:42 -0400
Received: from devnote2 (NE2965lan1.rev.em-net.ne.jp [210.141.244.193])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6C4732080C;
        Thu, 20 Jun 2019 12:17:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1561033061;
        bh=4HHw+Qp9H8V6fIHDzF9H81gSOxHTNJsMIKqmfY8FN5U=;
        h=Date:From:To:Cc:Subject:From;
        b=wWnIlZri2kxT/nVZV5on/30xs5MxQPQKduIZbSz+ZVepm9GPxHfB+ByXIoEp7twuA
         Gw0iqjZ7/1r7svIJ4PFNskjJDTa5Lm6YrYpyGIkGZF3BrHbnef7COwAnqg2u0rPkPV
         S13vc9/seZPKRGMkLHjOKNGZQV8GXBjy20WLrZDI=
Date:   Thu, 20 Jun 2019 21:17:37 +0900
From:   Masami Hiramatsu <mhiramat@kernel.org>
To:     Tom Zanussi <tom.zanussi@linux.intel.com>
Cc:     linux-kernel@vger.kernel.org, Steven Rostedt <rostedt@goodmis.org>
Subject: No invalid histogram error
Message-Id: <20190620211737.993b09619af1fc58222549b4@kernel.org>
X-Mailer: Sylpheed 3.5.1 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Tom,

I'm trying to use histogram on a synthetic event, but faced an odd situation.

There is a synthetic event, which has foo and bar.

/sys/kernel/debug/tracing # cat synthetic_events 
testevent	int foo; int bar

And when I tried to add hist on trigger, both foo and bar can be used as below.

/sys/kernel/debug/tracing # echo "hist:keys=bar" > events/synthetic/testevent/trigger 
/sys/kernel/debug/tracing # echo "hist:keys=foo" > events/synthetic/testevent/trigger 

And, when I missed to specify the sort key, it failed

/sys/kernel/debug/tracing # echo "hist:keys=foo:sort=bar" > events/synthetic/testevent/trigger 
sh: write error: Invalid argument

But no error on error_log file.

/sys/kernel/debug/tracing # cat error_log 
/sys/kernel/debug/tracing #

Could you add some error message? What about below?

[ 5422.134656] hist:synthetic:testevent: error: Sort key must be one of keys.
  Command: keys=foo;sort=bar
                               ^

Thank you,


-- 
Masami Hiramatsu <mhiramat@kernel.org>
