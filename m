Return-Path: <SRS0=J4ZE=RP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8EDC9C10F00
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Mar 2019 14:17:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 66B962177E
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Mar 2019 14:17:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726814AbfCLORy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Mar 2019 10:17:54 -0400
Received: from mx2.suse.de ([195.135.220.15]:57704 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726671AbfCLORy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Mar 2019 10:17:54 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id A6765B642;
        Tue, 12 Mar 2019 14:17:52 +0000 (UTC)
From:   Vlastimil Babka <vbabka@suse.cz>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Jann Horn <jannh@google.com>, Michal Hocko <mhocko@kernel.org>,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        linux-api@vger.kernel.org, Vlastimil Babka <vbabka@suse.cz>,
        Andy Lutomirski <luto@amacapital.net>,
        Cyril Hrubis <chrubis@suse.cz>, Daniel Gruss <daniel@gruss.cc>,
        Dave Chinner <david@fromorbit.com>,
        Dominique Martinet <asmadeus@codewreck.org>,
        Jiri Kosina <jikos@kernel.org>, Jiri Kosina <jkosina@suse.cz>,
        Josh Snyder <joshs@netflix.com>,
        Kevin Easton <kevin@guarana.org>,
        "Kirill A. Shutemov" <kirill@shutemov.name>,
        Matthew Wilcox <willy@infradead.org>,
        Michal Hocko <mhocko@suse.com>, Tejun Heo <tj@kernel.org>
Subject: [PATCH v2 0/2] prevent mincore() page cache leaks
Date:   Tue, 12 Mar 2019 15:17:06 +0100
Message-Id: <20190312141708.6652-1-vbabka@suse.cz>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190130124420.1834-1-vbabka@suse.cz>
References: <20190130124420.1834-1-vbabka@suse.cz>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Here's a new version of the mincore() patches, with feedback from Andrew Morton
applied. The IOCB_NOWAIT patch was dropped since David Chinner pointed out it's
incomplete. We definitely want the first patch, while for the second Linus
said:

  I think that's fine, and probably the right thing to do, but I also
  suspect that nobody actually cares ;(

Whether or not somebody cares, we should hear of no breakage. If somebody does
care after all, without second patch we might hear of breakage, so I would
suggest applying it. It's not that complicated after all (famous last words?)


Jiri Kosina (1):
  mm/mincore: make mincore() more conservative

Vlastimil Babka (1):
  mm/mincore: provide mapped status when cached status is not allowed

 mm/mincore.c | 80 ++++++++++++++++++++++++++++++++++++++++++++--------
 1 file changed, 68 insertions(+), 12 deletions(-)

-- 
2.20.1

