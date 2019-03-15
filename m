Return-Path: <SRS0=8sqo=RS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1C72EC43381
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Mar 2019 17:00:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E41B4218A1
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Mar 2019 17:00:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729689AbfCORAM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 Mar 2019 13:00:12 -0400
Received: from mx.sdf.org ([205.166.94.20]:61792 "EHLO mx.sdf.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729611AbfCORAM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Mar 2019 13:00:12 -0400
Received: from sdf.org (IDENT:lkml@sdf.lonestar.org [205.166.94.16])
        by mx.sdf.org (8.15.2/8.14.5) with ESMTPS id x2FGxk8i025703
        (using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256 bits) verified NO);
        Fri, 15 Mar 2019 16:59:46 GMT
Received: (from lkml@localhost)
        by sdf.org (8.15.2/8.12.8/Submit) id x2FGxi3R012970;
        Fri, 15 Mar 2019 16:59:44 GMT
Date:   Fri, 15 Mar 2019 16:59:44 GMT
From:   George Spelvin <lkml@sdf.org>
Message-Id: <201903151659.x2FGxi3R012970@sdf.org>
To:     geert@linux-m68k.org, lkml@sdf.org
Subject: Re: [PATCH 4/5] lib/list_sort: Simplify and remove MAX_LIST_LENGTH_BITS
Cc:     akpm@linux-foundation.org, andriy.shevchenko@linux.intel.com,
        daniel.wagner@siemens.com, dchinner@redhat.com,
        don.mullis@gmail.com, linux-kernel@vger.kernel.org,
        linux@rasmusvillemoes.dk, st5pub@yandex.ru
In-Reply-To: <CAMuHMdVgmb8eZ7bD+jye8DG7cQRywvVmwo_XNJ00f198pDcwxQ@mail.gmail.com>
References: <cover.1552097842.git.lkml@sdf.org>,
    <dd447448384883bd42c41f0de6a83430b6435dc1.1552097842.git.lkml@sdf.org>,
    <20190314091041.GU9224@smile.fi.intel.com>,
    <201903150433.x2F4X9oT024601@sdf.org>,
    <CAMuHMdVF6pQ_-vidvtAyacOHw8WsJp4esu7o7o9DoR_GLahnzA@mail.gmail.com>,
    <201903151023.x2FANDVY013031@sdf.org>,
    <CAMuHMdVgmb8eZ7bD+jye8DG7cQRywvVmwo_XNJ00f198pDcwxQ@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 15 Mar 2019 at 13:57:05 +0100, Geert Uytterhoeven wrote:
> On Fri, Mar 15, 2019 at 11:23 AM George Spelvin <lkml@sdf.org> wrote:
>> On Fri, 15 Mar 2019 at 09:20:58 +0100, Geert Uytterhoeven wrote:
>>> On Fri, Mar 15, 2019 at 5:33 AM George Spelvin <lkml@sdf.org> wrote:
>>>> One question I should ask everyone: should "count" be 32 or 64 bits
>>>> on 64-bit machines?  That would let x86 save a few REX bytes.  (815
>>>> vs. 813 byte code, if anyone cares.)
>>>>
>>>> Allegedy ARM can save a few pJ by gating the high 32
>>>> bits of the ALU.
>>>>
>>>> Most other 64-bit processors would prefer 64-bit operations as
>>>> it saves masking operations.
> 
> So just make it unsigned int, unconditionally.

As I wrote originally (and quoted above), other 64-bit machines don't
have 32-bit operations and prefer 64-bit operations because they don't
require masking.  x86 (for historical compatibiity) and ARM (for power
saving) are the ones that come to mind.

I'm trying to present the case to spur discussion, but it realy is
a *question* I'm asking about whether to do that, not a suggestion
phrased as a question.
