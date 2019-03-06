Return-Path: <SRS0=vY9Y=RJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A1561C43381
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Mar 2019 23:23:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6401F20663
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Mar 2019 23:23:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1551914621;
	bh=/LpXLhCOxpP91hU6mP5dYfjUibdKDxuy1Uctlh/xS1A=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=iS2oWSC9HA9Pw7a+HXlcw6zASvDRw3LkOO6whP1QrWPSXRCql3NmFO9BBmmxmnV2a
	 XV/MiVGSwENgn+M7dSdr1doaOoeahl6I7/OknNldg3AJDAtPIJ8QqmB+Nq5MG6LTtp
	 5W/v3QIAm/qmz2UWKFmswui2UQXI+gDogjF9bcg8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726285AbfCFXXk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 6 Mar 2019 18:23:40 -0500
Received: from mail.linuxfoundation.org ([140.211.169.12]:33596 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725747AbfCFXXk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Mar 2019 18:23:40 -0500
Received: from akpm3.svl.corp.google.com (unknown [104.133.8.65])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id CD598737C;
        Wed,  6 Mar 2019 23:23:38 +0000 (UTC)
Date:   Wed, 6 Mar 2019 15:23:37 -0800
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Jiri Kosina <jikos@kernel.org>
Cc:     Vlastimil Babka <vbabka@suse.cz>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        linux-api@vger.kernel.org, Peter Zijlstra <peterz@infradead.org>,
        Greg KH <gregkh@linuxfoundation.org>,
        Jann Horn <jannh@google.com>,
        Andy Lutomirski <luto@amacapital.net>,
        Cyril Hrubis <chrubis@suse.cz>, Daniel Gruss <daniel@gruss.cc>,
        Dave Chinner <david@fromorbit.com>,
        Dominique Martinet <asmadeus@codewreck.org>,
        Kevin Easton <kevin@guarana.org>,
        "Kirill A. Shutemov" <kirill@shutemov.name>,
        Matthew Wilcox <willy@infradead.org>, Tejun Heo <tj@kernel.org>
Subject: Re: [PATCH 0/3] mincore() and IOCB_NOWAIT adjustments
Message-Id: <20190306152337.e06cbc530fbfbcfcfe0dc37c@linux-foundation.org>
In-Reply-To: <nycvar.YFH.7.76.1903062342020.19912@cbobk.fhfr.pm>
References: <nycvar.YFH.7.76.1901051817390.16954@cbobk.fhfr.pm>
        <20190130124420.1834-1-vbabka@suse.cz>
        <nycvar.YFH.7.76.1903061310170.19912@cbobk.fhfr.pm>
        <20190306143547.c686225447822beaf3b6e139@linux-foundation.org>
        <nycvar.YFH.7.76.1903062342020.19912@cbobk.fhfr.pm>
X-Mailer: Sylpheed 3.6.0 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 6 Mar 2019 23:48:03 +0100 (CET) Jiri Kosina <jikos@kernel.org> wrote:

> 3/3 is actually waiting for your decision, see
> 
> 	https://lore.kernel.org/lkml/20190212063643.GL15609@dhcp22.suse.cz/

I pity anyone who tried to understand this code by reading this code. 
Can we please get some careful commentary in there explaining what is
going on, and why things are thus?

I guess the [3/3] change makes sense, although it's unclear whether
anyone really needs it?  5.0 was released with 574823bfab8 ("Change
mincore() to count "mapped" pages rather than "cached" pages") so we'll
have a release cycle to somewhat determine how much impact 574823bfab8
has on users.  How about I queue up [3/3] and we reevaluate its
desirability in a couple of months?



