Return-Path: <SRS0=z8wE=YA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3531BECE58C
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Oct 2019 14:19:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 096B8206BB
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Oct 2019 14:19:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728427AbfJGOTW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 7 Oct 2019 10:19:22 -0400
Received: from mx1.redhat.com ([209.132.183.28]:41722 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726334AbfJGOTV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Oct 2019 10:19:21 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 7BCF73025785;
        Mon,  7 Oct 2019 14:19:21 +0000 (UTC)
Received: from redhat.com (ovpn-124-31.rdu2.redhat.com [10.10.124.31])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id E3F315D9C9;
        Mon,  7 Oct 2019 14:19:20 +0000 (UTC)
Date:   Mon, 7 Oct 2019 10:19:19 -0400
From:   Jerome Glisse <jglisse@redhat.com>
To:     Thomas =?iso-8859-1?Q?Hellstr=F6m_=28VMware=29?= 
        <thomas_os@shipmail.org>
Cc:     "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "Kirill A. Shutemov" <kirill@shutemov.name>
Subject: Re: hmm pud-entry callback locking?
Message-ID: <20191007141919.GA3222@redhat.com>
References: <4d25d751-d03a-29c6-950b-cafe8d201784@shipmail.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <4d25d751-d03a-29c6-950b-cafe8d201784@shipmail.org>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.44]); Mon, 07 Oct 2019 14:19:21 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Oct 05, 2019 at 02:29:40PM +0200, Thomas Hellström (VMware) wrote:
> Hi, Jerome,
> 
> I was asked by Kirill to try to unify the pagewalk pud_entry and pmd_entry
> callbacks. The only user of the pagewalk pud-entry is currently hmm.
> 
> But the pagewalk code call pud_entry only for huge puds with the page-table
> lock held, whereas the hmm callback appears to assume it gets called
> unconditionally without the page-table lock held?
> 
> Could you shed some light into this?

I think in my mind they were already unified :) I think easiest thing is
to remove the hmm pud walker, this is not a big deal this will break huge
pud for now, we can re-add this to hmm once you unified them.

Cheers,
Jérôme
