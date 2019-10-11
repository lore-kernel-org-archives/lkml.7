Return-Path: <SRS0=Osat=YE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_2 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8297CECE58D
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Oct 2019 21:32:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 56718206CD
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Oct 2019 21:32:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lca.pw header.i=@lca.pw header.b="CPWmZcCt"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728996AbfJKVcu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 11 Oct 2019 17:32:50 -0400
Received: from mail-qt1-f175.google.com ([209.85.160.175]:38469 "EHLO
        mail-qt1-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726843AbfJKVct (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Oct 2019 17:32:49 -0400
Received: by mail-qt1-f175.google.com with SMTP id j31so15924970qta.5
        for <linux-kernel@vger.kernel.org>; Fri, 11 Oct 2019 14:32:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lca.pw; s=google;
        h=message-id:subject:from:to:cc:date:mime-version
         :content-transfer-encoding;
        bh=zjHrVEkh/YVtLs3egsKv3KDVrdQjiHSUSIsKjPxA+7U=;
        b=CPWmZcCtBiFFoLIUosDrpaTvTrN5NthRx3OufdfwE4W20DrJolmCTjLoFLFAbUsxzC
         ON0o7NeN8z7DUHFpGu3i9M9vvy//eJPN7x3cognAyZpe9I7E8bDl8g6uGxTnDb6CTn4n
         PQAgHvghMyGGNUy3F7742cGbJxC8NX4Dnx61g1H3UlSy6pj2Wl7GRiKM0vbLVcBylgJS
         KvA/fhYGtwCLr1GF6w2TjPsleIVh4wddPmzTYy8r3CphZk4OxihIN079+QWBZuh0uFU1
         RIqo1n5RrggJlp/c43UzJF4rATTl/gHyhZuURc/AaqNNJIXkd6kRYw8o5jc/SSHUTY+K
         y88A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:mime-version
         :content-transfer-encoding;
        bh=zjHrVEkh/YVtLs3egsKv3KDVrdQjiHSUSIsKjPxA+7U=;
        b=U3RR44MYLZIFZm+exkDLKiPVkeMITJ6YmbYjAqaKPAxcOc6iNJ3k9kk8QMwiYi3NfE
         0fCcBrJB/Zt80ZAOlqdmlShiKATRExSduDsKmXwhipaWALomzr5NHTFepXf3jpisK8h0
         JzpTI70++sz70DaY9SKJXKvp3unK6RO0V3jDOYs3PPkfBkEQcpCQybd7OZLOnPLn//zB
         V0ZeCaKs8mUaYo0uiSFYMbY5YruH+tkWuPpQymaL1Lwe7w9bpVjTNG9V9H6JAd6DVaTX
         us8XewMgPKKy0T2fV0kpVcndJ2RZQZSFpk4sHVM/xntdfh2koa9saMFxqdau+C/Egz8G
         iyfw==
X-Gm-Message-State: APjAAAWjZUOOw0+TH7K0H6w/uj8/2uf/kxMgjdr3xTXX8qfVSlCmPFXE
        uzOwjo49HlB6j5erk0BPWN2EJA==
X-Google-Smtp-Source: APXvYqzIPIRfcmkYvr6Oi5fs8oZ5wfbmCQ03HFEoOqu7kX30Xj96HR9Ph7LfTyh1wPzCuCJqvchNQw==
X-Received: by 2002:a0c:fde4:: with SMTP id m4mr8399463qvu.163.1570829567240;
        Fri, 11 Oct 2019 14:32:47 -0700 (PDT)
Received: from dhcp-41-57.bos.redhat.com (nat-pool-bos-t.redhat.com. [66.187.233.206])
        by smtp.gmail.com with ESMTPSA id 4sm4785293qtf.87.2019.10.11.14.32.45
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 11 Oct 2019 14:32:46 -0700 (PDT)
Message-ID: <1570829564.5937.36.camel@lca.pw>
Subject: memory offline infinite loop after soft offline
From:   Qian Cai <cai@lca.pw>
To:     Naoya Horiguchi <n-horiguchi@ah.jp.nec.com>
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        David Hildenbrand <david@redhat.com>,
        Michal Hocko <mhocko@kernel.org>,
        Mike Kravetz <mike.kravetz@oracle.com>
Date:   Fri, 11 Oct 2019 17:32:44 -0400
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.22.6 (3.22.6-10.el7) 
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

# /opt/ltp/runtest/bin/move_pages12
move_pages12.c:263: INFO: Free RAM 258988928 kB
move_pages12.c:281: INFO: Increasing 2048kB hugepages pool on node 0 to 4
move_pages12.c:291: INFO: Increasing 2048kB hugepages pool on node 8 to 4
move_pages12.c:207: INFO: Allocating and freeing 4 hugepages on node 0
move_pages12.c:207: INFO: Allocating and freeing 4 hugepages on node 8
move_pages12.c:197: PASS: Bug not reproduced
move_pages12.c:197: PASS: Bug not reproduced

for mem in $(ls -d /sys/devices/system/memory/memory*); do
        echo offline > $mem/state
        echo online > $mem/state
done

That LTP move_pages12 test will first madvise(MADV_SOFT_OFFLINE) for a range.
Then, one of "echo offline" will trigger an infinite loop in __offline_pages()
here,

		/* check again */
		ret = walk_system_ram_range(start_pfn, end_pfn - start_pfn,
					    NULL, check_pages_isolated_cb);
	} while (ret);

because check_pages_isolated_cb() always return -EBUSY from
test_pages_isolated(),


	pfn = __test_page_isolated_in_pageblock(start_pfn, end_pfn,
						skip_hwpoisoned_pages);
        ...
        return pfn < end_pfn ? -EBUSY : 0;

The root cause is in __test_page_isolated_in_pageblock() where "pfn" is always
less than "end_pfn" because the associated page is not a PageBuddy.

	while (pfn < end_pfn) {
	...
		else
			break;

	return pfn;

Adding a dump_page() for that pfn shows,

[  101.665160][ T8885] pfn = 77501, end_pfn = 78000
[  101.665245][ T8885] page:c00c000001dd4040 refcount:0 mapcount:0
mapping:0000000000000000 index:0x0
[  101.665329][ T8885] flags: 0x3fffc000000000()
[  101.665391][ T8885] raw: 003fffc000000000 0000000000000000 ffffffff01dd0500
0000000000000000
[  101.665498][ T8885] raw: 0000000000000000 0000000000000000 00000000ffffffff
0000000000000000
[  101.665588][ T8885] page dumped because: soft_offline
[  101.665639][ T8885] page_owner tracks the page as freed
[  101.665697][ T8885] page last allocated via order 5, migratetype Movable,
gfp_mask
0x346cca(GFP_HIGHUSER_MOVABLE|__GFP_NOWARN|__GFP_RETRY_MAYFAIL|__GFP_COMP|__GFP_
THISNODE)
[  101.665924][ T8885]  prep_new_page+0x3c0/0x440
[  101.665962][ T8885]  get_page_from_freelist+0x2568/0x2bb0
[  101.666059][ T8885]  __alloc_pages_nodemask+0x1b4/0x670
[  101.666115][ T8885]  alloc_fresh_huge_page+0x244/0x6e0
[  101.666183][ T8885]  alloc_migrate_huge_page+0x30/0x70
[  101.666254][ T8885]  alloc_new_node_page+0xc4/0x380
[  101.666325][ T8885]  migrate_pages+0x3b4/0x19e0
[  101.666375][ T8885]  do_move_pages_to_node.isra.29.part.30+0x44/0xa0
[  101.666464][ T8885]  kernel_move_pages+0x498/0xfc0
[  101.666520][ T8885]  sys_move_pages+0x28/0x40
[  101.666643][ T8885]  system_call+0x5c/0x68
[  101.666665][ T8885] page last free stack trace:
[  101.666704][ T8885]  __free_pages_ok+0xa4c/0xd40
[  101.666773][ T8885]  update_and_free_page+0x2dc/0x5b0
[  101.666821][ T8885]  free_huge_page+0x2dc/0x740
[  101.666875][ T8885]  __put_compound_page+0x64/0xc0
[  101.666926][ T8885]  putback_active_hugepage+0x228/0x390
[  101.666990][ T8885]  migrate_pages+0xa78/0x19e0
[  101.667048][ T8885]  soft_offline_page+0x314/0x1050
[  101.667117][ T8885]  sys_madvise+0x1068/0x1080
[  101.667185][ T8885]  system_call+0x5c/0x68
