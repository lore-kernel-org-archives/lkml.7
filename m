Return-Path: <SRS0=7x1k=SF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2D9E4C4360F
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Apr 2019 21:15:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E6BF5206B8
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Apr 2019 21:15:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726561AbfDCVPd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 3 Apr 2019 17:15:33 -0400
Received: from mail-pg1-f195.google.com ([209.85.215.195]:40972 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726399AbfDCVPb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Apr 2019 17:15:31 -0400
Received: by mail-pg1-f195.google.com with SMTP id f6so92792pgs.8
        for <linux-kernel@vger.kernel.org>; Wed, 03 Apr 2019 14:15:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=rsUhMy1aa1C9AMHH6cuLScGC4ceAnFrP5FDqqZF1zv8=;
        b=Ny2hIwNOBEgkvML9b4+rtRy7s97LnQTa/PMlpisPfz9IBnYtTZM+HZizR9WXGUUpet
         ET/pSuKgTLgR7JNbUkze7YSdthwRHD95II8Zf//Rk9cgYfRSahUExMbSyBH38RRRpJ+C
         FFnliQ1z+kV9LkpB1/NbmvgIW0Vsqt5TIGnI3tn44432n4pWHuKCVNL3TUAJVMoZJs2C
         VmWrfoG5HavtdefZs/vJCIyAPlbQJwhbgpBSG+pimwTiA3LyDYWQwcqK0I8ZMxHZNEBr
         Ap/TgzKS1sUuW1Oz/6KJbcWZkOEwxfYJPg/vpN8KojoZX3H+IVrWv3/AA2a7bzAbi7mV
         UPaA==
X-Gm-Message-State: APjAAAVVOfKlID4hqKLkwQ7x7BoLdDQC6QQj1u4Mn5LJXJLhE/gjbxdT
        4Xm00v0Vu7+TCE1N5VyIehY=
X-Google-Smtp-Source: APXvYqx2nSUTAM4BwsQfAounZswJT5IyMQIj5nrYNbpnNw+x8BvSlSsTYCjUCRJSe+R/nneAh/k2bA==
X-Received: by 2002:a63:fc5a:: with SMTP id r26mr1788878pgk.97.1554326130920;
        Wed, 03 Apr 2019 14:15:30 -0700 (PDT)
Received: from ?IPv6:2620:15c:2cd:203:5cdc:422c:7b28:ebb5? ([2620:15c:2cd:203:5cdc:422c:7b28:ebb5])
        by smtp.gmail.com with ESMTPSA id a3sm30239060pfn.182.2019.04.03.14.15.29
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 03 Apr 2019 14:15:30 -0700 (PDT)
Message-ID: <1554326129.118779.234.camel@acm.org>
Subject: Re: [PATCH] locking/lockdep: Zap lock classes even with lock
 debugging disabled
From:   Bart Van Assche <bvanassche@acm.org>
To:     Will Deacon <will.deacon@arm.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel@vger.kernel.org, Waiman Long <longman@redhat.com>,
        shenghui <shhuiw@foxmail.com>
Date:   Wed, 03 Apr 2019 14:15:29 -0700
In-Reply-To: <20190403124410.GE16362@fuggles.cambridge.arm.com>
References: <20190326195912.43316-1-bvanassche@acm.org>
         <20190403124410.GE16362@fuggles.cambridge.arm.com>
Content-Type: text/plain; charset="UTF-7"
X-Mailer: Evolution 3.26.2-1 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2019-04-03 at 13:44 +-0100, Will Deacon wrote:
+AD4 +AD4 --- a/kernel/locking/lockdep.c
+AD4 +AD4 +-+-+- b/kernel/locking/lockdep.c
+AD4 +AD4 +AEAAQA -4689,8 +-4689,7 +AEAAQA static void free+AF8-zapped+AF8-rcu(struct rcu+AF8-head +ACo-ch)
+AD4 +AD4  		return+ADs
+AD4 +AD4  
+AD4 +AD4  	raw+AF8-local+AF8-irq+AF8-save(flags)+ADs
+AD4 +AD4 -	if (+ACE-graph+AF8-lock())
+AD4 +AD4 -		goto out+AF8-irq+ADs
+AD4 +AD4 +-	arch+AF8-spin+AF8-lock(+ACY-lockdep+AF8-lock)+ADs
+AD4 
+AD4 This also throws out the recursion counting. Is that ok?

Apparently not, as the build bot just figured out. I will restore recursion
counting. See also
https://lore.kernel.org/lkml/5ca4ea66.eVtXtf5CmqRjP7xF+ACU-25lkp+AEA-intel.com/.

Bart.
