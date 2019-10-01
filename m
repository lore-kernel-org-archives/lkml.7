Return-Path: <SRS0=YRFP=X2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9EDDEC352AA
	for <linux-kernel@archiver.kernel.org>; Tue,  1 Oct 2019 09:01:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7B75121872
	for <linux-kernel@archiver.kernel.org>; Tue,  1 Oct 2019 09:01:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733160AbfJAJB5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 1 Oct 2019 05:01:57 -0400
Received: from mx1.redhat.com ([209.132.183.28]:48750 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729787AbfJAJB5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Oct 2019 05:01:57 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 82117C04DBCD;
        Tue,  1 Oct 2019 09:01:57 +0000 (UTC)
Received: from t460s.redhat.com (ovpn-117-182.ams2.redhat.com [10.36.117.182])
        by smtp.corp.redhat.com (Postfix) with ESMTP id CCCAD611DE;
        Tue,  1 Oct 2019 09:01:52 +0000 (UTC)
From:   David Hildenbrand <david@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     linux-mm@kvack.org, xen-devel@lists.xenproject.org,
        David Hildenbrand <david@redhat.com>
Subject: [PATCH v1 0/3] xen/balloon: PG_offline cleanups
Date:   Tue,  1 Oct 2019 11:01:49 +0200
Message-Id: <20191001090152.1770-1-david@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.32]); Tue, 01 Oct 2019 09:01:57 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Some cleanups based on top of:
    [PATCH v1] xen/balloon: Set pages PageOffline() in balloon_add_region()

Make the PG_offline less error prone, by simply setting PG_offline when
they enter the page list and clearing PG_offline when they leave the
page list.

Only compile-tested.

David Hildenbrand (3):
  xen/balloon: Drop __balloon_append()
  xen/balloon: Mark pages PG_offline in balloon_append()
  xen/balloon: Clear PG_offline in balloon_retrieve()

 drivers/xen/balloon.c | 25 +++++++------------------
 1 file changed, 7 insertions(+), 18 deletions(-)

-- 
2.21.0

