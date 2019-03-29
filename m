Return-Path: <SRS0=SA5R=SA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 33125C43381
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Mar 2019 04:12:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F0466206C0
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Mar 2019 04:12:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726030AbfC2EMg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 29 Mar 2019 00:12:36 -0400
Received: from mx.sdf.org ([205.166.94.20]:64723 "EHLO mx.sdf.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725830AbfC2EMg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Mar 2019 00:12:36 -0400
Received: from sdf.org (IDENT:lkml@sdf.lonestar.org [205.166.94.16])
        by mx.sdf.org (8.15.2/8.14.5) with ESMTPS id x2T4AEZC011474
        (using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256 bits) verified NO);
        Fri, 29 Mar 2019 04:10:14 GMT
Received: (from lkml@localhost)
        by sdf.org (8.15.2/8.12.8/Submit) id x2T4ACjG014546;
        Fri, 29 Mar 2019 04:10:12 GMT
Date:   Fri, 29 Mar 2019 04:10:12 GMT
From:   George Spelvin <lkml@sdf.org>
Message-Id: <201903290410.x2T4ACjG014546@sdf.org>
To:     akpm@linux-foundation.org, lkml@sdf.org, lkp@intel.com,
        sfr@canb.auug.org.au
Subject: Re: [RESEND PATCH v2 4/5] lib/list_sort: Simplify and remove MAX_LIST_LENGTH_BITS
Cc:     andriy.shevchenko@linux.intel.com, daniel.wagner@siemens.com,
        dchinner@redhat.com, don.mullis@gmail.com, geert@linux-m68k.org,
        kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux@rasmusvillemoes.dk, st5pub@yandex.ru
In-Reply-To: <20190328150851.5d261d1a72e2ca86a1c141c0@linux-foundation.org>
References: <cover.1552704200.git.lkml@sdf.org>,
    <f63c410e0ff76009c9b58e01027e751ff7fdb749.1552704200.git.lkml@sdf.org>,
    <20190328150851.5d261d1a72e2ca86a1c141c0@linux-foundation.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Than you all for the build warning report.

The warning produced by gcc versions 4.9, 7.3, 8.1, whatever version
Stephen Rothwell is running, is:
lib/list_sort.c:17:36: warning: __pure__ attribute ignored [-Wattributes]

The relevant code is:
10: /*
11:  * By declaring the compare function with the __pure attribute, we give
12:  * the compiler more opportunity to optimize.  Ideally, we'd use this in
13:  * the prototype of list_sort(), but that would involve a lot of churn
14:  * at all call sites, so just cast the function pointer passed in.
15:  */
16: typedef int __pure __attribute__((nonnull(2,3))) (*cmp_func)(void *,
17: 		struct list_head const *, struct list_head const *);

As the comment says, the purpose of the __pure attribute is to tell
the compiler that, after a call via a function pointer of this
type, memory is not clobbered and it is not necessary to reload
any cached list pointers.

This is, of course, purely optional and may be deleted harmlessly.
I just checked, and that makes no difference at all to gcc-8 code
generation, so there's no point messing with #ifdef.

There are only two questions: how to update the comment, and how
to submit the fix. I'm thinking of
/*
 * A more accurate type for comparison functions.  Ideally, we'd use
 * this in the prototype of list_sort(), but that would involve a lot of
 * churn at all call sites, so just cast the function pointer passed in.
 *
 * This could also include __pure to give the compiler more opportunity
 * to optimize, but that elicits an "attribute ignored" warning on
 * GCC <= 8.1, and doesn't change GCC 8.3's code generation at all,
 * so it's omitted.
 */

How to submit the fix: Andrew, do you prefer a replacement patch
or a small fix patch?  I'll assume the latter and send it in a few
minutes.
