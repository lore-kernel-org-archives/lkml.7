Return-Path: <SRS0=2mSC=W2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_2 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C7791C3A5A4
	for <linux-kernel@archiver.kernel.org>; Fri, 30 Aug 2019 15:25:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9D6AC23407
	for <linux-kernel@archiver.kernel.org>; Fri, 30 Aug 2019 15:25:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lca.pw header.i=@lca.pw header.b="j+V6+/Z8"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728232AbfH3PZc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 30 Aug 2019 11:25:32 -0400
Received: from mail-qk1-f195.google.com ([209.85.222.195]:44499 "EHLO
        mail-qk1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727938AbfH3PZc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Aug 2019 11:25:32 -0400
Received: by mail-qk1-f195.google.com with SMTP id i78so5007514qke.11
        for <linux-kernel@vger.kernel.org>; Fri, 30 Aug 2019 08:25:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lca.pw; s=google;
        h=message-id:subject:from:to:cc:date:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=uAGNj/k9sxhyWPF4gW8v9ANxItk70JmBhK3Bz890W+M=;
        b=j+V6+/Z819VI1YZCoOnBj/oMDBF8SifHtR2Py7Q6rcAn92pGtORGovoGCON3Xa0lEX
         mxAwlsSE96mMR4c61G9G8QRLocu2g29Ge8DsiPpZhLQtBn5g7rnvG1bZS0vRFyLLpUTi
         KFDkNrI8kkq2QeMA60xq6RRi5XmiTP6vF7tokvFja6/cKXod0up2/W3LB6o9eFp4H/yY
         LJ6JRhF31aQpNRTjiSXK9uHJasLwOO4iLkUiazLH6+SWDJCh1fQVNiKgaHLXlY6vO7W/
         cdjf95wdC7m+IpXiXMrUqxD3WZVng2GUkXt8H/YEuy8WtKiRq/pMEFgtNh71FTkAJy5g
         TwQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=uAGNj/k9sxhyWPF4gW8v9ANxItk70JmBhK3Bz890W+M=;
        b=cA3v8wCyiDjKAiz//WlcSH5oJsKSqTZW9ehffLLvndwhsxZ4oFjwcbF094M2WQ/zUG
         qSUcgsl/DmBraMYxH5Q6YQBVJOvCt8eCx9iYSKVYPttleLNMoNV4ioXfVrOXV8gL4dbB
         12kxQFLhY0BAdOfNYDzHPeMAWCJEiE5ced2e4e/c5mq3iDxekn4tFG3JzKZKkbRzg4Fn
         Ifwjz74tAuP86r8gI7EjNPsOBtyUMOov2uBw5v/c+R4dajbJ1i4GRjzZRXmf8jLH9R4B
         zLECOSD+FkMB7xe0/huBDw+UrjlVqz9D7sOR1xZX3WdSEOe6R3NaENMz8BoIr/ygoj/s
         iPdA==
X-Gm-Message-State: APjAAAVbMlLfePD+SzDKFCdrv4n1DKbRc0GxORal7MpLmQjl+6QhqpUI
        XFrMAAYGbtKeTK4hRHu5u/yTAQ==
X-Google-Smtp-Source: APXvYqw0EhdXHc1wpLtFj5TejUK0OxSVjZ2aoiu/qaTO83bFRR+7CanolrCjPltbXW/VvIZh7EuyQg==
X-Received: by 2002:a37:4d0c:: with SMTP id a12mr15819201qkb.214.1567178731214;
        Fri, 30 Aug 2019 08:25:31 -0700 (PDT)
Received: from dhcp-41-57.bos.redhat.com (nat-pool-bos-t.redhat.com. [66.187.233.206])
        by smtp.gmail.com with ESMTPSA id l8sm3559996qti.65.2019.08.30.08.25.30
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 30 Aug 2019 08:25:30 -0700 (PDT)
Message-ID: <1567178728.5576.32.camel@lca.pw>
Subject: Re: [PATCH] net/skbuff: silence warnings under memory pressure
From:   Qian Cai <cai@lca.pw>
To:     Eric Dumazet <eric.dumazet@gmail.com>, davem@davemloft.net
Cc:     netdev@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Date:   Fri, 30 Aug 2019 11:25:28 -0400
In-Reply-To: <6109dab4-4061-8fee-96ac-320adf94e130@gmail.com>
References: <1567177025-11016-1-git-send-email-cai@lca.pw>
         <6109dab4-4061-8fee-96ac-320adf94e130@gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.22.6 (3.22.6-10.el7) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2019-08-30 at 17:11 +0200, Eric Dumazet wrote:
> 
> On 8/30/19 4:57 PM, Qian Cai wrote:
> > When running heavy memory pressure workloads, the system is throwing
> > endless warnings below due to the allocation could fail from
> > __build_skb(), and the volume of this call could be huge which may
> > generate a lot of serial console output and cosumes all CPUs as
> > warn_alloc() could be expensive by calling dump_stack() and then
> > show_mem().
> > 
> > Fix it by silencing the warning in this call site. Also, it seems
> > unnecessary to even print a warning at all if the allocation failed in
> > __build_skb(), as it may just retransmit the packet and retry.
> > 
> 
> Same patches are showing up there and there from time to time.
> 
> Why is this particular spot interesting, against all others not adding
> __GFP_NOWARN ?
> 
> Are we going to have hundred of patches adding __GFP_NOWARN at various points,
> or should we get something generic to not flood the syslog in case of memory
> pressure ?
> 

From my testing which uses LTP oom* tests. There are only 3 places need to be
patched. The other two are in IOMMU code for both Intel and AMD. The place is
particular interesting because it could cause the system with floating serial
console output for days without making progress in OOM. I suppose it ends up in
a looping condition that warn_alloc() would end up generating more calls into
__build_skb() via ksoftirqd.
