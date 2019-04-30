Return-Path: <SRS0=DLm5=TA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 26B8BC43219
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Apr 2019 00:16:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EBA4921670
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Apr 2019 00:16:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1556583384;
	bh=0diGOuz1eXcEq1b4fAPvG+fvHAaUyKsQ2Z5JdRLfCCk=;
	h=From:To:Cc:Subject:Date:List-ID:From;
	b=YAnmxqq0V3/5aOgiE/lxmSqD4tCZfIqY2cMCD+VebhqxWpOLXorv3WaIeYN4XJ5Ch
	 qmPQ8ZAe4Ck1em7q5FerQKIEq/eopkHr0Zx2aiGFYEhcn0DqhbIBJ0H1thKrOh1XW2
	 ys6u8UEMnC9vbzRBwdZM7luoH4Zuh0FUOG7QTEJw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729656AbfD3AQW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 29 Apr 2019 20:16:22 -0400
Received: from out1-smtp.messagingengine.com ([66.111.4.25]:33143 "EHLO
        out1-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729063AbfD3AQW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Apr 2019 20:16:22 -0400
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailout.nyi.internal (Postfix) with ESMTP id 548ED210DB;
        Mon, 29 Apr 2019 20:16:21 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute3.internal (MEProxy); Mon, 29 Apr 2019 20:16:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:date:from
        :message-id:mime-version:subject:to:x-me-proxy:x-me-proxy
        :x-me-sender:x-me-sender:x-sasl-enc; s=fm2; bh=SpRv4EhOicGuYK+sS
        gs1qqUdE6bQfBtbLtwFlugdKc4=; b=58Fr1HaN+9mbt1dBhMK1OMRNtwLBxJrRr
        Q2iC1J5FHkh4BcsKp6y0ZNxyaMku5UDLr2zoLVFQ/CmNDAgLIYZMjxCJ01mkNLQV
        sEU0VA9iamxqAWBQ+ya+wBCRwkNr/U3qGGRhmTkJT85QMDPVML8OQ3cedDpWkgZx
        gMu8MPxmT/zzaP1CmSdaepj8m2rDyyXIjFeYajlxdsbKhL1ZM6cM+p1iIxA+3Kag
        bBmTj2LTedk1al8zQ11rFtJv7Cbq3BOkqX2e/iXfjM0NtPlG1kCQa44lO+IVraI9
        OvY0vp3g97RY3WZtMVL6UK5fS0fp4+XPlI62pCG3BCWlPtoRzhzBA==
X-ME-Sender: <xms:1JPHXKHxFcAMA2DeOe2l9B_VEskRUXTRYaan5EnytdaKwe7zNGQh5w>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduuddrieefgdefgecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpefhvffufffkofgggfestdekredtredttdenucfhrhhomhepfdfvohgsihhnucev
    rdcujfgrrhguihhnghdfuceothhosghinheskhgvrhhnvghlrdhorhhgqeenucfkphepud
    dvuddrgeegrddvfedtrddukeeknecurfgrrhgrmhepmhgrihhlfhhrohhmpehtohgsihhn
    sehkvghrnhgvlhdrohhrghenucevlhhushhtvghrufhiiigvpedt
X-ME-Proxy: <xmx:1JPHXFk6mut6-l2g-zBmoWdZwfYYNll_MxovTeMnvHNxhBBjeNL5kw>
    <xmx:1JPHXJlpS3Yx6W7d_LXrbcDV15UQp7sN8Fui1fppqDWLmOyA4cRcuw>
    <xmx:1JPHXKWLpnD5RcSQn9k7AQhbZ5Q2VFV46MQokdPkeXfrA9XGpsq_jw>
    <xmx:1ZPHXKsbzkAlS6Q2mcSYxoji1YbmFKX6koNs6ZW05icQ5kPrR2rwqg>
Received: from eros.localdomain (ppp121-44-230-188.bras2.syd2.internode.on.net [121.44.230.188])
        by mail.messagingengine.com (Postfix) with ESMTPA id EB32C103C9;
        Mon, 29 Apr 2019 20:16:16 -0400 (EDT)
From:   "Tobin C. Harding" <tobin@kernel.org>
To:     Josh Poimboeuf <jpoimboe@redhat.com>,
        Jiri Kosina <jikos@kernel.org>,
        Miroslav Benes <mbenes@suse.cz>, Petr Mladek <pmladek@suse.com>
Cc:     "Tobin C. Harding" <tobin@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Joe Lawrence <joe.lawrence@redhat.com>,
        live-patching@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 0/2] livepatch: Fix usage of kobject_init_and_add()
Date:   Tue, 30 Apr 2019 10:15:32 +1000
Message-Id: <20190430001534.26246-1-tobin@kernel.org>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Currently there are a few places in kernel/livepatch/ which do not
correctly use kobject_init_and_add().

An error return from kobject_init_and_add() requires a call to
kobject_put().

The cleanup function after a successful call to kobject_init_and_add()
is kobject_del(). 

This set is part of an effort to check/fix all callsites of
kobject_init_and_add().


This set fixes all callsites under kernel/livepatch/


thanks,
Tobin.


Tobin C. Harding (2):
  livepatch: Fix kobject memleak
  livepatch: Use correct kobject cleanup function

 kernel/livepatch/core.c | 20 ++++++++++++--------
 1 file changed, 12 insertions(+), 8 deletions(-)

-- 
2.21.0

