Return-Path: <SRS0=fl2C=S4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 982B0C43219
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Apr 2019 02:27:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7BB9820878
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Apr 2019 02:27:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1556245669;
	bh=jdnPgtVs1C7Z0docuk2r1gPzE9n6mSF71oX0ndFdESU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=ukop1QUPwShbozwM1RkLhnGNbXL/Ic5MorhQ59mc/rbmSQ3xGRmjLislPGLZEbmBB
	 xqKx8j9UC/PN8DjgQPZOlgqn/SCpEbEH7evmlO07piHfVnRbxF1zlXxkx7D8jEqIuN
	 SKFyttv1fubCYsZ5FZQUBFI6hZuRIPXzGiUmeYSk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729185AbfDZC1s (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Apr 2019 22:27:48 -0400
Received: from new1-smtp.messagingengine.com ([66.111.4.221]:34151 "EHLO
        new1-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726893AbfDZC1r (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Apr 2019 22:27:47 -0400
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailnew.nyi.internal (Postfix) with ESMTP id 4704A1117A;
        Thu, 25 Apr 2019 22:27:46 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute3.internal (MEProxy); Thu, 25 Apr 2019 22:27:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:date:from
        :in-reply-to:message-id:mime-version:references:subject:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm2; bh=QQkx/gI38BRanILmeGSHvkh1ypHOhw/OGbmPVvX1nTs=; b=qXdtKMep
        7JDjQV5xD/FEs7OSSrFz1KGr5mwvWUhM3f/Cxf7Ky9JhusqXXfdim9UkH3SQ9HqC
        kxlvNUvKjNyi+TNmoY8Yc9bkosj91gHOsHBNPlJY3zuRlodq+5y4ioLMiGtNBIIS
        4cNadJCqn3IsZrqN1R8ssXsMHkHyRQp3pcpUSvSVDRxbkkX+dLFN9KqGFhJ4yPQi
        iWYK5Bid1+T10xKSE+56r6ieyGlPjSJfE3EfYHop169CUyfS44r79XHi2O1vRfLQ
        bM37OjrmD8Iqa8wg7XgHy5q6fB/6DXbejbk7fByMyWorBviIFlrzmqgxOKgL42Uo
        eeI8GS6eTZpviA==
X-ME-Sender: <xms:omzCXHmol7zeCWJCB-AsvpeLSVcndbRrCKxJyLuQOIfyRdCEeXzPzA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduuddrheehgdehlecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpefhvffufffkofgjfhgggfestdekredtredttdenucfhrhhomhepfdfvohgsihhn
    ucevrdcujfgrrhguihhnghdfuceothhosghinheskhgvrhhnvghlrdhorhhgqeenucfkph
    epuddvgedrudeiledrudehledrvddutdenucfrrghrrghmpehmrghilhhfrhhomhepthho
    sghinheskhgvrhhnvghlrdhorhhgnecuvehluhhsthgvrhfuihiivgepfe
X-ME-Proxy: <xmx:omzCXOpFMBNDQ_xdNyKdWBg1yL_-yINraJ_bz9NtsDB_CzbKy5jspg>
    <xmx:omzCXGtgYzzyFg0PwBNVPwYexP2_L2ZuDxvAp09cC-024vmiIRchtQ>
    <xmx:omzCXDGLbh8TRAYvcgwl1xkYwejd5c9zPCZeI2BSa99HDTbwuHID6w>
    <xmx:omzCXBrmZLT5pe-fbeJGMsKBIE2LmwfhOdM_kq0cKN_dBhyXOlodLA>
Received: from eros.localdomain (124-169-159-210.dyn.iinet.net.au [124.169.159.210])
        by mail.messagingengine.com (Postfix) with ESMTPA id B7D3C103D5;
        Thu, 25 Apr 2019 22:27:40 -0400 (EDT)
From:   "Tobin C. Harding" <tobin@kernel.org>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     "Tobin C. Harding" <tobin@kernel.org>,
        Jesper Dangaard Brouer <brouer@redhat.com>,
        Pekka Enberg <penberg@iki.fi>,
        Vlastimil Babka <vbabka@suse.cz>,
        Christoph Lameter <cl@linux.com>,
        David Rientjes <rientjes@google.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Tejun Heo <tj@kernel.org>, Qian Cai <cai@lca.pw>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Mel Gorman <mgorman@techsingularity.net>,
        Alexander Duyck <alexander.duyck@gmail.com>,
        Michal Hocko <mhocko@kernel.org>,
        Brendan Gregg <brendan.d.gregg@gmail.com>, linux-mm@kvack.org,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 4/4] tools/vm/slabinfo: Add sorting info to help menu
Date:   Fri, 26 Apr 2019 12:26:22 +1000
Message-Id: <20190426022622.4089-5-tobin@kernel.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190426022622.4089-1-tobin@kernel.org>
References: <20190426022622.4089-1-tobin@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Passing more than one sorting option has undefined behaviour.

Add an explicit statement as such to the help menu, this also has the
advantage of highlighting all the sorting options.

Signed-off-by: Tobin C. Harding <tobin@kernel.org>
---
 tools/vm/slabinfo.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/tools/vm/slabinfo.c b/tools/vm/slabinfo.c
index 469ff6157986..68092d15e12b 100644
--- a/tools/vm/slabinfo.c
+++ b/tools/vm/slabinfo.c
@@ -148,6 +148,8 @@ static void usage(void)
 		"    p | P              Poisoning\n"
 		"    u | U              Tracking\n"
 		"    t | T              Tracing\n"
+
+		"\nSorting options (--Loss, --Size, --Partial) are mutually exclusive\n"
 	);
 }
 
-- 
2.21.0

