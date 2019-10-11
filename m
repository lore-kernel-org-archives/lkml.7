Return-Path: <SRS0=Osat=YE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ECC16C47404
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Oct 2019 21:05:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BF6402190F
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Oct 2019 21:05:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1570827940;
	bh=oJc1X89tpRHyKi1CNkA/D1rl1b34r4jD3MHwMA5XjPY=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=NKSuCOkbcx5foFeSEY7c4rVgcZYmVmiiLu09umhM1wdiu4aOUbMgsBpkJjEe/009Y
	 zHgczb4fCdXanZyEmAzFdjBoe2wP/msA8oXYh8G26rzGrVehmsxCGBEMDIk5/LUp7j
	 X4OFg8FC8267AzLexau2ZX0L4wS8JKTwJItBtXlY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729058AbfJKVFj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 11 Oct 2019 17:05:39 -0400
Received: from mail.kernel.org ([198.145.29.99]:53852 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726843AbfJKVFj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Oct 2019 17:05:39 -0400
Received: from localhost.localdomain (c-73-231-172-41.hsd1.ca.comcast.net [73.231.172.41])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id EBAE42084C;
        Fri, 11 Oct 2019 21:05:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1570827937;
        bh=oJc1X89tpRHyKi1CNkA/D1rl1b34r4jD3MHwMA5XjPY=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=PTnQVk9lD19i0LW7/ld2yTtL8v4PB1KeBjsnmj2FL2IKHs6XpXkFoSIUUpyvlHl1i
         BZRYJKAcxCIpcU4ee3pLQXhxn0ynNWGw4kC1Tyv7wK4pUW6lm861lV4CqX2UaWBGnL
         RZgBb6dLBfMBKZ9XTWwcNwHsth/2MdLvzFufExxc=
Date:   Fri, 11 Oct 2019 14:05:36 -0700
From:   Andrew Morton <akpm@linux-foundation.org>
To:     David Gow <davidgow@google.com>
Cc:     shuah@kernel.org, brendanhiggins@google.com, keescook@chromium.org,
        linux-kselftest@vger.kernel.org, kunit-dev@googlegroups.com,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH linux-kselftest/test v2] lib/list-test: add a test for
 the 'list' doubly linked list
Message-Id: <20191011140536.03c3e25500b31ddcfa0f542b@linux-foundation.org>
In-Reply-To: <20191010185631.26541-1-davidgow@google.com>
References: <20191010185631.26541-1-davidgow@google.com>
X-Mailer: Sylpheed 3.5.1 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 10 Oct 2019 11:56:31 -0700 David Gow <davidgow@google.com> wrote:

> Add a KUnit test for the kernel doubly linked list implementation in
> include/linux/list.h
> 
> Each test case (list_test_x) is focused on testing the behaviour of the
> list function/macro 'x'. None of the tests pass invalid lists to these
> macros, and so should behave identically with DEBUG_LIST enabled and
> disabled.
> 
> Note that, at present, it only tests the list_ types (not the
> singly-linked hlist_), and does not yet test all of the
> list_for_each_entry* macros (and some related things like
> list_prepare_entry).

<looks at kunit>

Given that everything runs at late_initcall time, shouldn't everything
be __init, __initdata etc so all the code and data doesn't hang around
for ever?

