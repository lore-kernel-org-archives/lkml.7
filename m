Return-Path: <SRS0=KmSF=VS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BDB30C76195
	for <linux-kernel@archiver.kernel.org>; Sun, 21 Jul 2019 21:09:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 929E82085A
	for <linux-kernel@archiver.kernel.org>; Sun, 21 Jul 2019 21:09:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="hOxpb6w1"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726749AbfGUVJG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 21 Jul 2019 17:09:06 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:36938 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726674AbfGUVJF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 21 Jul 2019 17:09:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=m+ymzWwJthSyMsIrAZa5UVM+lb+OeBZIRhgzMglbtss=; b=hOxpb6w1+7znVOU/LYcc4TCsi
        AU34x9DctQ72CdFA2SbXaxcS1FbGoIVqML8MnXJToxuML6SZi8848XN5DS9AVL0Z9wQgsUK2KRVeI
        Wz7K+4anU/cZMplgZTFu8tTBeFDdLQlK+4EzYTlmpy18b/zeZMWzGbE65oBnEfAvV8IKyijqNY5Kz
        B1UEaYbbU2KZci/M3mW5svS0g1vE2DZjApbLyiTi9LrqIkXtIvvBRXC3Hu/WKpOP6J4pBN/jLFKkT
        nwP8xiN5kn2rcd2USEhk/o97boU6FKRBx8S2WJNurFZKhP65CJgPUJfkVoDYo/kddkcDF3S5fnxNx
        q3ODFsGGQ==;
Received: from willy by bombadil.infradead.org with local (Exim 4.92 #3 (Red Hat Linux))
        id 1hpJ4P-00031q-HE; Sun, 21 Jul 2019 21:08:37 +0000
Date:   Sun, 21 Jul 2019 14:08:37 -0700
From:   Matthew Wilcox <willy@infradead.org>
To:     "Paul E. McKenney" <paulmck@linux.ibm.com>
Cc:     "Michael S. Tsirkin" <mst@redhat.com>, aarcange@redhat.com,
        akpm@linux-foundation.org, christian@brauner.io,
        davem@davemloft.net, ebiederm@xmission.com,
        elena.reshetova@intel.com, guro@fb.com, hch@infradead.org,
        james.bottomley@hansenpartnership.com, jasowang@redhat.com,
        jglisse@redhat.com, keescook@chromium.org, ldv@altlinux.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, linux-parisc@vger.kernel.org,
        luto@amacapital.net, mhocko@suse.com, mingo@kernel.org,
        namit@vmware.com, peterz@infradead.org,
        syzkaller-bugs@googlegroups.com, viro@zeniv.linux.org.uk,
        wad@chromium.org
Subject: Re: RFC: call_rcu_outstanding (was Re: WARNING in __mmdrop)
Message-ID: <20190721210837.GC363@bombadil.infradead.org>
References: <0000000000008dd6bb058e006938@google.com>
 <000000000000964b0d058e1a0483@google.com>
 <20190721044615-mutt-send-email-mst@kernel.org>
 <20190721081933-mutt-send-email-mst@kernel.org>
 <20190721131725.GR14271@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190721131725.GR14271@linux.ibm.com>
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jul 21, 2019 at 06:17:25AM -0700, Paul E. McKenney wrote:
> Also, the overhead is important.  For example, as far as I know,
> current RCU gracefully handles close(open(...)) in a tight userspace
> loop.  But there might be trouble due to tight userspace loops around
> lighter-weight operations.

I thought you believed that RCU was antifragile, in that it would scale
better as it was used more heavily?

Would it make sense to have call_rcu() check to see if there are many
outstanding requests on this CPU and if so process them before returning?
That would ensure that frequent callers usually ended up doing their
own processing.
