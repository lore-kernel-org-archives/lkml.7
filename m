Return-Path: <SRS0=vL1f=RL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A9258C43381
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Mar 2019 00:08:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 75F602081B
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Mar 2019 00:08:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726285AbfCHAI2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 Mar 2019 19:08:28 -0500
Received: from mail-pf1-f193.google.com ([209.85.210.193]:41772 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726237AbfCHAI1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Mar 2019 19:08:27 -0500
Received: by mail-pf1-f193.google.com with SMTP id d25so12714455pfn.8;
        Thu, 07 Mar 2019 16:08:26 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=JEowhzuLKg+UteJUN64pHS3amY8GXi8lZqaXHsWj2I4=;
        b=tCnvdh/wYO5dMkJRYPERdiMeIQ2L91JmUTkNKvIzNDrh794mH09DSB2VatONn7XOcq
         pRPFSEFc3TXNlRidX96KDOU1UMSMwy0t8txEcWGrcwPT1B3LpgiS/ZnEGFkd/VMy0BVw
         Wm4SjxIQAgBliJGk8BE7k/xwk7XuBAfEgEW3nUA7lORYn9+hfKKQHKaQGSYlvQnDI3yR
         m9Spu0m942e1omcbvAV8/7JKxfbMTOxoo3ARoEDyx8LVaF6e1BPtNwPCltpwLTfJXNR2
         0S7Op9So1ISdswo21Cit7R6d7ieJnBfTLSx1LGyQnhofR4nINTIxWSN/uszp0SBfW7/J
         64nw==
X-Gm-Message-State: APjAAAV8NuspEK49L9Uhd8sDcRnJdQDD92S584YHqiALUq+/J2z6ez6T
        ozjPj+UeeXBVDK57HY0mV3TWWlXmJNg=
X-Google-Smtp-Source: APXvYqzWOHCikaeunaor508/ooVrHYwnbYYgDi2l/FB9+gZe+knvDzE21RxLp66LpRJFbQCGBMHngw==
X-Received: by 2002:a63:4924:: with SMTP id w36mr13575879pga.227.1552003705989;
        Thu, 07 Mar 2019 16:08:25 -0800 (PST)
Received: from ?IPv6:2620:15c:2cd:203:5cdc:422c:7b28:ebb5? ([2620:15c:2cd:203:5cdc:422c:7b28:ebb5])
        by smtp.gmail.com with ESMTPSA id h184sm16542440pfc.78.2019.03.07.16.08.24
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 07 Mar 2019 16:08:24 -0800 (PST)
Message-ID: <1552003703.45180.17.camel@acm.org>
Subject: Re: [PATCH] Avoid that check_shl_overflow() triggers a compiler
 warning when building with W=1
From:   Bart Van Assche <bvanassche@acm.org>
To:     Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Jason Gunthorpe <jgg@mellanox.com>
Cc:     Kees Cook <keescook@chromium.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
        Leon Romanovsky <leonro@mellanox.com>
Date:   Thu, 07 Mar 2019 16:08:23 -0800
In-Reply-To: <2c122567-d14b-7867-9230-67f570c13d15@rasmusvillemoes.dk>
References: <20190307010153.81157-1-bvanassche@acm.org>
         <20190307012417.GU1758@mellanox.com>
         <8a5bd9ae-ebfe-687c-2868-d0f2a610d1e0@acm.org>
         <2c122567-d14b-7867-9230-67f570c13d15@rasmusvillemoes.dk>
Content-Type: text/plain; charset="UTF-7"
X-Mailer: Evolution 3.26.2-1 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2019-03-07 at 08:18 +-0100, Rasmus Villemoes wrote:
+AD4 On 07/03/2019 03.14, Bart Van Assche wrote:
+AD4 +AD4 On 3/6/19 5:24 PM, Jason Gunthorpe wrote:
+AD4 +AD4 +AD4 +AD4 
+AD4 +AD4 +AD4 +AD4 diff --git a/include/linux/overflow.h b/include/linux/overflow.h
+AD4 +AD4 +AD4 +AD4 index 40b48e2133cb..8afe0c0ada6f 100644
+AD4 +AD4 +AD4 +AD4 +-+-+- b/include/linux/overflow.h
+AD4 +AD4 +AD4 +AD4 +AEAAQA -202,6 +-202,24 +AEAAQA
+AD4 +AD4 +AD4 +AD4     +ACM-endif /+ACo COMPILER+AF8-HAS+AF8-GENERIC+AF8-BUILTIN+AF8-OVERFLOW +ACo-/
+AD4 +AD4 +AD4 +AD4   +-/+ACo
+AD4 +AD4 +AD4 +AD4 +- +ACo Evaluate a +AD4APQ 0 without triggering a compiler warning if the type
+AD4 +AD4 +AD4 +AD4 of a
+AD4 +AD4 +AD4 +AD4 +- +ACo is an unsigned type.
+AD4 +AD4 +AD4 +AD4 +- +ACo-/
+AD4 +AD4 +AD4 +AD4 +-+ACM-define is+AF8-positive(a) (+AHs                    +AFw
+AD4 
+AD4 is+AF8-non+AF8-negative, please+ACE positive means +AD4 0. And perhaps it's better to
+AD4 move these utility macros closer to the top of the file, together with
+AD4 the other type/range helpers.

Hi Rasmus,

Thank you for the feedback. But according to what I found online opinions
about whether or not zero is a positive number seem to vary. From
https://en.wikipedia.org/wiki/Sign+AF8(mathematics):

Terminology for signs

When 0 is said to be neither positive nor negative, the following phrases
may be used to refer to the sign of a number:
+ACo A number is positive if it is greater than zero.
+ACo A number is negative if it is less than zero.
+ACo A number is non-negative if it is greater than or equal to zero.
+ACo A number is non-positive if it is less than or equal to zero.

When 0 is said to be both positive and negative, modified phrases are used
to refer to the sign of a number:
+ACo A number is strictly positive if it is greater than zero.
+ACo A number is strictly negative if it is less than zero.
+ACo A number is positive if it is greater than or equal to zero.
+ACo A number is negative if it is less than or equal to zero.

Bart.
