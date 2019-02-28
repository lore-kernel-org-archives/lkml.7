Return-Path: <SRS0=g5d9=RD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6F7CCC43381
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Feb 2019 23:33:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4400820830
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Feb 2019 23:33:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732847AbfB1XdL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Feb 2019 18:33:11 -0500
Received: from mail-pf1-f194.google.com ([209.85.210.194]:41520 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725955AbfB1XdL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Feb 2019 18:33:11 -0500
Received: by mail-pf1-f194.google.com with SMTP id d25so10467325pfn.8;
        Thu, 28 Feb 2019 15:33:11 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=qxbAgDrhTMrGO19Is5jXgpmLBZWR7yKX1z36F+HA7Gc=;
        b=BJMrVuJEK6+1ukXRyJhrMxlBpzumu/3vcWObk7m8YsO7s3k8yNF1S6qbXDsVji/tHK
         5cdMF1jBiEd6MQmXNDDbuU1/6mb8MuayAhCQYB/0RuS2WZp6QzzafhQ4mDAregyHzRCU
         tVofUR1mSh01lhV8Rtcy3nh/amPMUhQEq+GP3VIpuo6PQ9R3vsHLXH9vG8fLl0zzWVBu
         kcPct1Km77Fs95ON0zt5TjhWG/BJY30qKxAcmLgMXNQ9NUuEQ513Ad0qAaeUbir5Ww/0
         KHwjhzec/Rt+DNn9yDouEFNxRlRUpWdB0nnhX9NDr89jTHC06ffiCto429fmHm3T7Ebz
         0Ffw==
X-Gm-Message-State: AHQUAuagEftJegAYq5Pl64gczjyT+KeDjNw1n1c2PcVUP6psY1rtVCeF
        XXsltgXYbFYjb0W3iD8Abpg=
X-Google-Smtp-Source: AHgI3IbACP7OjI/bIMQgmJEQ4n2EtSmaWCL3uu+GhOI+vw4I3cLoCcJTGJobRQWKqxGnOL1PKdArLA==
X-Received: by 2002:a62:1212:: with SMTP id a18mr2253485pfj.177.1551396790595;
        Thu, 28 Feb 2019 15:33:10 -0800 (PST)
Received: from ?IPv6:2620:15c:2cd:203:5cdc:422c:7b28:ebb5? ([2620:15c:2cd:203:5cdc:422c:7b28:ebb5])
        by smtp.gmail.com with ESMTPSA id s6sm41676104pgm.90.2019.02.28.15.33.09
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 28 Feb 2019 15:33:09 -0800 (PST)
Message-ID: <1551396788.31902.213.camel@acm.org>
Subject: Re: [PATCH] cxgb4: fix undefined behavior in mem.c
From:   Bart Van Assche <bvanassche@acm.org>
To:     Shaobo He <shaobo@cs.utah.edu>, linux-rdma@vger.kernel.org
Cc:     Steve Wise <swise@chelsio.com>, Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        open list <linux-kernel@vger.kernel.org>
Date:   Thu, 28 Feb 2019 15:33:08 -0800
In-Reply-To: <abf425b1-19ba-9cf5-8288-87ac0dbf6ac7@cs.utah.edu>
References: <1551393519-96595-1-git-send-email-shaobo@cs.utah.edu>
         <1551394596.31902.209.camel@acm.org>
         <abf425b1-19ba-9cf5-8288-87ac0dbf6ac7@cs.utah.edu>
Content-Type: text/plain; charset="UTF-7"
X-Mailer: Evolution 3.26.2-1 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2019-02-28 at 16:18 -0700, Shaobo He wrote:
+AD4 I can't afford a pdf version of the C standard. So I looked at the draft version 
+AD4 used in the link I put in the commit message. It says (in 6.2.4:2),
+AD4 
+AD4 +AGAAYABg
+AD4 The lifetime of an object is the portion of program execution during which 
+AD4 storage is guaranteed to be reserved for it. An object exists, has a constant 
+AD4 address, and retains its last-stored value throughout its lifetime. If an object 
+AD4 is referred to outside of its lifetime, the behavior is undefined. The value of 
+AD4 a pointer becomes indeterminate when the object it points to (or just past) 
+AD4 reaches the end of its lifetime.
+AD4 +AGAAYABg
+AD4 I couldn't find the definition of lifetime over a dynamically allocated object 
+AD4 in the draft of C standard. I refer to this link 
+AD4 (https://en.cppreference.com/w/c/language/lifetime) which suggests that the 
+AD4 lifetime of an allocated object ends after the deallocation function is called 
+AD4 upon it.
+AD4 
+AD4 I think maybe the more problematic issue is that the value of a freed pointer is 
+AD4 intermediate.

In another section of the same draft I found the following:

J.2 Undefined behavior +AFs ... +AF0 The value of a pointer that refers to space
deallocated by a call to the free or realloc function is used (7.22.3).

Since the C standard explicitly refers to free() and realloc(), does that
mean that that statement about undefined behavior does not apply to munmap()
(for user space code) nor to kfree() (for kernel code)?

Bart.
