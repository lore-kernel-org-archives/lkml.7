Return-Path: <SRS0=yZjE=R4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A773EC43381
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Mar 2019 17:06:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7FEC22087C
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Mar 2019 17:06:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729855AbfCYRGn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Mar 2019 13:06:43 -0400
Received: from mail-pg1-f169.google.com ([209.85.215.169]:41084 "EHLO
        mail-pg1-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725788AbfCYRGm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Mar 2019 13:06:42 -0400
Received: by mail-pg1-f169.google.com with SMTP id f6so2751406pgs.8
        for <linux-kernel@vger.kernel.org>; Mon, 25 Mar 2019 10:06:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:date:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=fWhNXj7mjR8mFLQV/1Glm1I/PJqTr/Gcv0wbi/sDLNM=;
        b=c9UA1ORguWq3mlMEZ0x4D71Zn2p+M1875ngiNHUdkmu0vVHwY/xSAlBvwAI2A9QMcg
         u2glEdtkWHYNyfVfCWyn3tZQMDX68Y5QKvRDqtqdgji0fTxcvFS3BXro+ufFD2irFHex
         M+o4YOwra/540sK5b5lUtdm/3AH34Qs3dBAo/rXv5HIuPPhmFm7hruXcNnGx6TPojEjV
         yFOhFshyoyOQNEONP+RnZ1K5DwLsHG1Hx59zJys2DfLFUKDzEPaSwE6jA3K+neXvVzgz
         7XN/CS+o5rm7tlXCu4XtLT0Z21nHSEvl5OS7F7s6dqjZszMM5ObGwglwds1uYPycmR5b
         vbKg==
X-Gm-Message-State: APjAAAVbpQaI7CjVj2wWX4VCSLJtjTwOrnqs5dTcZ7DeJUIYJEjyfWzi
        skommPGQIGRkEgef4Jkl1eTAQQ1Uoj8=
X-Google-Smtp-Source: APXvYqzj0AbalQUUhtSKk1yS3Oo3kPyPa8EoNHu2oHfyaju342nH2NSIBuQzCLCKPP6ZDwtGWjmo8Q==
X-Received: by 2002:a65:5b44:: with SMTP id y4mr7010965pgr.446.1553533602174;
        Mon, 25 Mar 2019 10:06:42 -0700 (PDT)
Received: from ?IPv6:2620:15c:2cd:203:5cdc:422c:7b28:ebb5? ([2620:15c:2cd:203:5cdc:422c:7b28:ebb5])
        by smtp.gmail.com with ESMTPSA id k10sm25977930pgj.11.2019.03.25.10.06.40
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 25 Mar 2019 10:06:41 -0700 (PDT)
Message-ID: <1553533600.118779.12.camel@acm.org>
Subject: Re: "cat /proc/lockdep" after "rmmod <some module>" when
 !debug_locks will crash the system
From:   Bart Van Assche <bvanassche@acm.org>
To:     shenghui <shhuiw@foxmail.com>, peterz@infradead.org,
        mingo@redhat.com, will.deacon@arm.com, linux-kernel@vger.kernel.org
Date:   Mon, 25 Mar 2019 10:06:40 -0700
In-Reply-To: <5c98a345.1c69fb81.21300.0be5SMTPIN_ADDED_BROKEN@mx.google.com>
References: <5c98a345.1c69fb81.21300.0be5SMTPIN_ADDED_BROKEN@mx.google.com>
Content-Type: text/plain; charset="UTF-7"
X-Mailer: Evolution 3.26.2-1 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2019-03-25 at 17:45 +-0800, shenghui wrote:
+AD4 I installed virtualbox-5.2.24 on my system (x86 32) and on bootup I got some warning:
+AD4 ---------------------
+AD4 1251 +AFs   42.640869+AF0 DEBUG+AF8-LOCKS+AF8-WARN+AF8-ON(+ACE-current-+AD4-hardirqs+AF8-enabled)
+AD4 1252 +AFs   42.640880+AF0 WARNING: CPU: 0 PID: 841 at kernel/locking/lockdep.c:4132 check+AF8-flags.part.45+-0x9e/0x190
+AD4 ...

Hi Shenghui,

That warning should have been followed by a call trace. Please share that
call trace.

Thanks,

Bart.
