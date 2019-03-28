Return-Path: <SRS0=Qu8K=R7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CC242C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Mar 2019 10:00:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A67462173C
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Mar 2019 10:00:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727194AbfC1KAt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Mar 2019 06:00:49 -0400
Received: from mx.sdf.org ([205.166.94.20]:62365 "EHLO mx.sdf.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727106AbfC1KAn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Mar 2019 06:00:43 -0400
Received: from sdf.org (IDENT:lkml@sdf.lonestar.org [205.166.94.16])
        by mx.sdf.org (8.15.2/8.14.5) with ESMTPS id x2SA0RKB000884
        (using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256 bits) verified NO);
        Thu, 28 Mar 2019 10:00:28 GMT
Received: (from lkml@localhost)
        by sdf.org (8.15.2/8.12.8/Submit) id x2SA0RcA017002;
        Thu, 28 Mar 2019 10:00:27 GMT
Date:   Thu, 28 Mar 2019 10:00:27 GMT
From:   George Spelvin <lkml@sdf.org>
Message-Id: <201903281000.x2SA0RcA017002@sdf.org>
To:     linux-kernel@vger.kernel.org, lkml@sdf.org, tytso@mit.edu
Subject: Re: [RFC PATCH v2] random: add get_random_max() function
Cc:     Jason@zx2c4.com
In-Reply-To: <201903270655.x2R6tDjo020894@sdf.org>
References: <201903241244.x2OCiL8P011277@sdf.org>,
    <201903270655.x2R6tDjo020894@sdf.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

By the way, I just noticed that my fallback get_random_max64()
algorithm (if there's no __int128 type) is completely broken and
will need rewriting.

It would work if I rejected and regenerated the high half
if the low half were out of range, but that's not what it does.

The worst case is a range of 0x10000001, where it would return
0x10000000 half the time.

Needs rethinking to find something as simple as possible.
I'm sure I can come up with something, but I'm not averse to
suggestions if anyone has any.

(If I had a reliably fast clz/fls, that would open some
possibilities, but sigh...)
