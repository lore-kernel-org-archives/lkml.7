Return-Path: <SRS0=kpxk=YC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2ACBCC47404
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Oct 2019 09:45:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F06B3206BB
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Oct 2019 09:45:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20150623.gappssmtp.com header.i=@resnulli-us.20150623.gappssmtp.com header.b="JJe2jqU2"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730506AbfJIJp4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 9 Oct 2019 05:45:56 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:39882 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730307AbfJIJp4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Oct 2019 05:45:56 -0400
Received: by mail-wm1-f65.google.com with SMTP id v17so1783344wml.4
        for <linux-kernel@vger.kernel.org>; Wed, 09 Oct 2019 02:45:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=RHVkSYR5RquLwrpVzf7I2dWQllEqVftQflifjBnbz1E=;
        b=JJe2jqU2S+CKuztPnv0ykR08Bjm1s68l1w9lGP6zPFYgsVI/Fdm//Sl7Fi6VNziZpx
         rBNKgq6zjxSyK609LGFaYjjzorI4rt+ZjN7HewzTWn7qlOxOyh2rEGv1Baxifh08A0RG
         LeJzlpmb7fEBJAYmdGVAPZqnrGITiPiAzsx4yJJ2IfHBb8v8jHB0FGWi7nVqBB94TYfP
         n0mSn7vPGhOnZ8PEzP9YTQFP51RHZxa+/w7OJVR8aYwiGxyPIyV6CGeWzpZVuTWGWtyN
         G1Hf67i/75Wr/UPgV5WHUHaIAnJOC3j581RVGhAewvKtJ74MqPjgDtUz3/PEOqIh191f
         1v6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=RHVkSYR5RquLwrpVzf7I2dWQllEqVftQflifjBnbz1E=;
        b=oDOA4r2lcKxRzqDEWw6isjqq7jAzpO05Wbh/fYzhETS/+JuXEKxGkWMJcfY8dgOqFB
         e7XYvQ+0mOLbvqZcVb3rn8d/pD+yx3WArdZqefeUQGNdhfJypXN5vw/+0itCmAsILkNo
         3yYzkEMMvJD3/59pn181mdBavb2bvy0R8xuhvjUJjSfKXoIat+wI+NdNZD5GkE+AAhfy
         paAKIK6awvAV0C++ZV85yNlEBOH4ms8gMPymoPxaXISgY9UBazh2xql+QLMnXYL0ihmU
         htOsMKYqCNnslvj27+AksdxuvEWg4qB9H5xiQv6k/5guroDmk0sPO6MwHlPT/9Vcrjy3
         UBUA==
X-Gm-Message-State: APjAAAVnlpZ+rJ3a5mbqkcemrlxuACvWeCnrq1WCDsd57sU6yLfCxnWy
        /3Ujla8nLKB3o/8k7lMYqovCJg==
X-Google-Smtp-Source: APXvYqzsvr1dz4+2xl5bk+wISm0X0EvvHDmzevR5lrZW93luRs/Hvq75me3QPgKyCEDXLBRk6x5PCA==
X-Received: by 2002:a05:600c:253:: with SMTP id 19mr1747840wmj.158.1570614354208;
        Wed, 09 Oct 2019 02:45:54 -0700 (PDT)
Received: from localhost (ip-213-220-235-50.net.upcbroadband.cz. [213.220.235.50])
        by smtp.gmail.com with ESMTPSA id c6sm1897846wrm.71.2019.10.09.02.45.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Oct 2019 02:45:53 -0700 (PDT)
Date:   Wed, 9 Oct 2019 11:45:53 +0200
From:   Jiri Pirko <jiri@resnulli.us>
To:     syzbot <syzbot+d2a8670576fa63d18623@syzkaller.appspotmail.com>
Cc:     davem@davemloft.net, jiri@mellanox.com, jon.maloy@ericsson.com,
        linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
        syzkaller-bugs@googlegroups.com,
        tipc-discussion@lists.sourceforge.net, ying.xue@windriver.com
Subject: Re: KASAN: use-after-free Read in tipc_nl_node_dump_monitor_peer
Message-ID: <20191009094553.GG2326@nanopsycho>
References: <0000000000003dc9ba059475614f@google.com>
 <0000000000003bdc5f059476d153@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0000000000003bdc5f059476d153@google.com>
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Wed, Oct 09, 2019 at 11:22:00AM CEST, syzbot+d2a8670576fa63d18623@syzkaller.appspotmail.com wrote:
>syzbot has bisected this bug to:
>
>commit 057af70713445fad2459aa348c9c2c4ecf7db938
>Author: Jiri Pirko <jiri@mellanox.com>
>Date:   Sat Oct 5 18:04:39 2019 +0000
>
>    net: tipc: have genetlink code to parse the attrs during dumpit
>
>bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=14ac08e7600000
>start commit:   f9867b51 netdevsim: fix spelling mistake "forbidded" -> "f..
>git tree:       net-next
>final crash:    https://syzkaller.appspot.com/x/report.txt?x=16ac08e7600000
>console output: https://syzkaller.appspot.com/x/log.txt?x=12ac08e7600000
>kernel config:  https://syzkaller.appspot.com/x/.config?x=d9be300620399522
>dashboard link: https://syzkaller.appspot.com/bug?extid=d2a8670576fa63d18623
>syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=16d3e04f600000
>C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=13a76593600000
>
>Reported-by: syzbot+d2a8670576fa63d18623@syzkaller.appspotmail.com
>Fixes: 057af7071344 ("net: tipc: have genetlink code to parse the attrs
>during dumpit")
>
>For information about bisection process see: https://goo.gl/tpsmEJ#bisection

#syz fix: net: genetlink: always allocate separate attrs for dumpit ops

