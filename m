Return-Path: <SRS0=w+Kb=XL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FSL_HELO_FAKE,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 58C98C49ED7
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Sep 2019 13:31:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2C82320644
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Sep 2019 13:31:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1568640675;
	bh=2yE/gvVkU6cnERn6w2l4YKwqDGcYlSukLzAXUhIFlxE=;
	h=Date:From:To:Cc:Subject:List-ID:From;
	b=0AUeuREQPMptrkRIkMExjD88NL5Wh64tWjTqj3UMEeYJLzcqnH2ZmWxL5U/eTp3yU
	 6MdRDd/CkUrKx9hjebeI3gSiS3dDSRsr12qGGSByXpnDJKaamljK97PEkPth+MkuC7
	 OZLT9Zb4WWZpjmiUR0BZcGVTY3+JQin4Eg1lVYzE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387505AbfIPNbO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 16 Sep 2019 09:31:14 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:37547 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727899AbfIPNbN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Sep 2019 09:31:13 -0400
Received: by mail-wr1-f68.google.com with SMTP id i1so38327123wro.4
        for <linux-kernel@vger.kernel.org>; Mon, 16 Sep 2019 06:31:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=o0TxXG7lNuQ2xBLe8wTfn7BMxyDCwy4ihx0s4bVOqlM=;
        b=KpwTZaBrg1cNhvn1igtrWTXovrN3KWpYTvSVDEGPH2cHEQ7zyb4O3qWE7iJeFDsfAr
         4QjWHJB3B99bGbpaasWa6LVUIHRr3Kq5w9uZmSJc7gsPL/w5PoLAF8VP4PxKzNOd2tIg
         LUj/3ejWDAaFbXQ4PxMjknjJ+Fq0B+GxcDRxE/Jqa7rICKsJi1L6gK/kzCGE8mISOgy6
         C19KlOsFBuZuMjW3JGwalzhYonxuBNwfrD2r4W3t2GTpGz1cZ5g1jhBK6QPQdopPFXsd
         fZma4Xe2kXaPxDOMbKYMn6PKCNilPZiP+6tSo9HwuehMcbf5fVFXKHj1fXU1+h2w2oGx
         teFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :mime-version:content-disposition:user-agent;
        bh=o0TxXG7lNuQ2xBLe8wTfn7BMxyDCwy4ihx0s4bVOqlM=;
        b=TYTM0ijuEoqSU7t/H7aM0GRsLXSi985w7JgHuvnOK3rgYz63Qhb8Agmb5XVq1G8Oha
         mWIKea6xgNwcooXMVLe8o7MoNpR/kT55HcspxWQ7pbAbrcmi8POmzYnqPtjQp/SV7bx4
         1JuUpjjwo2BFJzVbz96hZ6o9T5sK0A4OdVB9Ut3Idgev/HpJAIr9fY7ug4y/WozIjHxq
         rq1e7WggWQxGGgZH0zXduu5VdXXqzMHt5v6e6qQFO0BV5xKYzHguLXeEMf6+JrviW9mj
         Humn31To5lI6MWLDZSROULXAE5/xZ+3/cY72Q8wn9bKVwhHj/Xkb/en0kY6gZ7RZl/4D
         wv9A==
X-Gm-Message-State: APjAAAXZKctwWaeqDzUJBs339+mUko4Mrc9+Vuo6Id20CGUDZ+M33n4N
        hBHdBl1d4VLo4IDT8MjlgzLNcjyf
X-Google-Smtp-Source: APXvYqwCx9m/PpirD0Ir3BobUO7NLiH7aayaPAU2gvrmZf94uCL57XI5jxlfNnyeTM/jMsOKmr7L8g==
X-Received: by 2002:adf:fc0e:: with SMTP id i14mr20482902wrr.302.1568640671592;
        Mon, 16 Sep 2019 06:31:11 -0700 (PDT)
Received: from gmail.com (2E8B0CD5.catv.pool.telekom.hu. [46.139.12.213])
        by smtp.gmail.com with ESMTPSA id r18sm15471781wme.48.2019.09.16.06.31.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Sep 2019 06:31:11 -0700 (PDT)
Date:   Mon, 16 Sep 2019 15:31:09 +0200
From:   Ingo Molnar <mingo@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
        Borislav Petkov <bp@alien8.de>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: [GIT PULL] x86/platform changes for v5.4
Message-ID: <20190916133109.GA111962@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Linus,

Please pull the latest x86-platform-for-linus git tree from:

   git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git x86-platform-for-linus

   # HEAD: 864b23f0169d5bff677e8443a7a90dfd6b090afc x86/platform/uv: Fix kmalloc() NULL check routine

The biggest change is the rework of the intel/iosf_mbi locking code which 
used a few non-standard locking patterns, to make it work under lockdep.

 Thanks,

	Ingo

------------------>
Austin Kim (1):
      x86/platform/uv: Fix kmalloc() NULL check routine

Hans de Goede (1):
      x86/platform/intel/iosf_mbi Rewrite locking


 arch/x86/platform/intel/iosf_mbi.c | 100 +++++++++++++++++++++++--------------
 arch/x86/platform/uv/tlb_uv.c      |   4 +-
 2 files changed, 64 insertions(+), 40 deletions(-)

