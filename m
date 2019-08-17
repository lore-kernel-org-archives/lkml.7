Return-Path: <SRS0=F9vw=WN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2AA31C3A59B
	for <linux-kernel@archiver.kernel.org>; Sat, 17 Aug 2019 07:16:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E70C62173B
	for <linux-kernel@archiver.kernel.org>; Sat, 17 Aug 2019 07:16:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1566026174;
	bh=CE4AEJvu5Hekiw/HsMR351wf16SY1xY2kqztonk4go4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=f8gk1LhHA53vMoidQDyXpXUNff0fCNiXBE6/KKLlthM7zWhV4Ula3/X/8ixKaVZhJ
	 GSXEaMRGwDafzbzYG9SniUZXxEWpo0nn8cuC2lpoU8KhHIr18CVBAx7JA0y0T+ReWo
	 KbQGaqSgMofTL36FsbcaUMXPzqJj8MP9T0MdYbcw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726002AbfHQHP4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 17 Aug 2019 03:15:56 -0400
Received: from mail.kernel.org ([198.145.29.99]:53194 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725267AbfHQHPz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 17 Aug 2019 03:15:55 -0400
Received: from localhost (unknown [171.76.122.58])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id CB55720880;
        Sat, 17 Aug 2019 07:15:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1566026154;
        bh=CE4AEJvu5Hekiw/HsMR351wf16SY1xY2kqztonk4go4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=bnEjnPLgiNNg4bURqzWsb9i5145OE7C6QHYiRcq9EdT0yPJ8vUQtjv10TeCB+SrMz
         2rE6kZ56/Y8k+9yaDfDXB9ztHZALG5d+HI4LAKcrt8x8PGUGZD6gtmaUpy5xLa9qTA
         1K8U3xu2c9cLnkmq15mkyDvWfsOQVY9VuCz7d3bU=
Date:   Sat, 17 Aug 2019 12:44:40 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Cc:     syzbot <syzbot+6593c6b8c8b66a07cd98@syzkaller.appspotmail.com>,
        alsa-devel@alsa-project.org, bp@alien8.de,
        gregkh@linuxfoundation.org, hpa@zytor.com,
        linux-kernel@vger.kernel.org, mingo@redhat.com, nstange@suse.de,
        pierre-louis.bossart@linux.intel.com, sanyog.r.kale@intel.com,
        syzkaller-bugs@googlegroups.com, tglx@linutronix.de,
        x86@kernel.org, yakui.zhao@intel.com
Subject: Re: INFO: rcu detected stall in __do_softirq
Message-ID: <20190817071440.GD12733@vkoul-mobl.Dlink>
References: <000000000000b4126c059030cfb6@google.com>
 <63c0dc1e-323d-d46e-2d4a-b5b6d6916042@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <63c0dc1e-323d-d46e-2d4a-b5b6d6916042@linaro.org>
User-Agent: Mutt/1.11.3 (2019-02-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 16-08-19, 09:55, Srinivas Kandagatla wrote:
> 
> 
> On 16/08/2019 01:10, syzbot wrote:
> > syzbot has bisected this bug to:
> > 
> > commit 2aeac95d1a4cc85aae57ab842d5c3340df0f817f
> > Author: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
> > Date:   Tue Jun 11 10:40:41 2019 +0000
> > 
> >      soundwire: add module_sdw_driver helper macro
> 
> Not sure how adding a macro with no users triggers this rcu stall.

And config used doesn't have soundwire set :D
> 
> BTW this was in mainline since rc1.

This is caused by something else!

> 
> --srini
> 
> > 
> > bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=114b45ee600000
> > start commit:   882e8691 Add linux-next specific files for 20190801
> > git tree:       linux-next
> > final crash:    https://syzkaller.appspot.com/x/report.txt?x=134b45ee600000
> > console output: https://syzkaller.appspot.com/x/log.txt?x=154b45ee600000
> > kernel config:  https://syzkaller.appspot.com/x/.config?x=466b331af3f34e94
> > dashboard link:
> > https://syzkaller.appspot.com/bug?extid=6593c6b8c8b66a07cd98
> > syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=16b216b2600000
> > 
> > Reported-by: syzbot+6593c6b8c8b66a07cd98@syzkaller.appspotmail.com
> > Fixes: 2aeac95d1a4c ("soundwire: add module_sdw_driver helper macro")
> > 
> > For information about bisection process see:
> > https://goo.gl/tpsmEJ#bisection

-- 
~Vinod
