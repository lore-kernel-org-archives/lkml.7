Return-Path: <SRS0=vnTL=2H=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 524D9C43603
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Dec 2019 14:15:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 270C721739
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Dec 2019 14:15:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=citrix.com header.i=@citrix.com header.b="bBIh7z6x"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728874AbfLQOPl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 17 Dec 2019 09:15:41 -0500
Received: from esa2.hc3370-68.iphmx.com ([216.71.145.153]:49040 "EHLO
        esa2.hc3370-68.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728661AbfLQOPj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Dec 2019 09:15:39 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=citrix.com; s=securemail; t=1576592139;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version;
  bh=BCebZje1JdGYax7/evCubLel44DqnREiV6HOFXN0mVg=;
  b=bBIh7z6xktk8ZaBv3ABEHRHNcenTwhgGX3sEBSGAjrI1ZK1ApnZG7BLI
   ATQCjX/xHdR5p13T8wXz8Ugkh+cZynirHKJF9tWxszVMCikRpF7aFawFJ
   ToCDKsNtfCQHywnOjA+7AK5ESWPTVwHA+NGQBJi+EO0WAsTdEV6gu2x2o
   c=;
Authentication-Results: esa2.hc3370-68.iphmx.com; dkim=none (message not signed) header.i=none; spf=None smtp.pra=sergey.dyasli@citrix.com; spf=Pass smtp.mailfrom=sergey.dyasli@citrix.com; spf=None smtp.helo=postmaster@mail.citrix.com
Received-SPF: None (esa2.hc3370-68.iphmx.com: no sender
  authenticity information available from domain of
  sergey.dyasli@citrix.com) identity=pra;
  client-ip=162.221.158.21; receiver=esa2.hc3370-68.iphmx.com;
  envelope-from="sergey.dyasli@citrix.com";
  x-sender="sergey.dyasli@citrix.com";
  x-conformance=sidf_compatible
Received-SPF: Pass (esa2.hc3370-68.iphmx.com: domain of
  sergey.dyasli@citrix.com designates 162.221.158.21 as
  permitted sender) identity=mailfrom;
  client-ip=162.221.158.21; receiver=esa2.hc3370-68.iphmx.com;
  envelope-from="sergey.dyasli@citrix.com";
  x-sender="sergey.dyasli@citrix.com";
  x-conformance=sidf_compatible; x-record-type="v=spf1";
  x-record-text="v=spf1 ip4:209.167.231.154 ip4:178.63.86.133
  ip4:195.66.111.40/30 ip4:85.115.9.32/28 ip4:199.102.83.4
  ip4:192.28.146.160 ip4:192.28.146.107 ip4:216.52.6.88
  ip4:216.52.6.188 ip4:162.221.158.21 ip4:162.221.156.83
  ip4:168.245.78.127 ~all"
Received-SPF: None (esa2.hc3370-68.iphmx.com: no sender
  authenticity information available from domain of
  postmaster@mail.citrix.com) identity=helo;
  client-ip=162.221.158.21; receiver=esa2.hc3370-68.iphmx.com;
  envelope-from="sergey.dyasli@citrix.com";
  x-sender="postmaster@mail.citrix.com";
  x-conformance=sidf_compatible
IronPort-SDR: OnwOB8MZFY2HS+S16GgpO2BJod5tklhela04K9EMRgoIVuY+Bz+fAliKtL764jlR3H7RnoDJP5
 fTRq9lM3PDOKpdhp351Sx3ptSDf6L1I2NYsKWNenDJGdSeotvZGp0NsZRrnoPNJ5IxRWhRvnSi
 x+PQgPTxbwiBlbCJ1h7yiOikObwD2yYLF+VrinHQVCXiVJ9buTQh7F+F8yTJb02QNMymHBvwH9
 xIfi1VXB6pmA92ICsMD0NODPSViQqpwUzeGxlvOMCK+g4weQE2drcJL+lPJMlMuvIAOZaWdity
 8+w=
X-SBRS: 2.7
X-MesageID: 9817030
X-Ironport-Server: esa2.hc3370-68.iphmx.com
X-Remote-IP: 162.221.158.21
X-Policy: $RELAYED
X-IronPort-AV: E=Sophos;i="5.69,325,1571716800"; 
   d="scan'208";a="9817030"
From:   Sergey Dyasli <sergey.dyasli@citrix.com>
To:     <xen-devel@lists.xen.org>, <kasan-dev@googlegroups.com>,
        <linux-kernel@vger.kernel.org>
CC:     Andrey Ryabinin <aryabinin@virtuozzo.com>,
        Alexander Potapenko <glider@google.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        Juergen Gross <jgross@suse.com>,
        "Stefano Stabellini" <sstabellini@kernel.org>,
        George Dunlap <george.dunlap@citrix.com>,
        Ross Lagerwall <ross.lagerwall@citrix.com>,
        Sergey Dyasli <sergey.dyasli@citrix.com>
Subject: [RFC PATCH 2/3] xen: teach KASAN about grant tables
Date:   Tue, 17 Dec 2019 14:08:03 +0000
Message-ID: <20191217140804.27364-3-sergey.dyasli@citrix.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20191217140804.27364-1-sergey.dyasli@citrix.com>
References: <20191217140804.27364-1-sergey.dyasli@citrix.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Ross Lagerwall <ross.lagerwall@citrix.com>

Otherwise it produces lots of false positives.

Signed-off-by: Ross Lagerwall <ross.lagerwall@citrix.com>
Signed-off-by: Sergey Dyasli <sergey.dyasli@citrix.com>
---
 drivers/xen/grant-table.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/xen/grant-table.c b/drivers/xen/grant-table.c
index 49b381e104ef..0f844c14d5b9 100644
--- a/drivers/xen/grant-table.c
+++ b/drivers/xen/grant-table.c
@@ -1049,6 +1049,7 @@ int gnttab_map_refs(struct gnttab_map_grant_ref *map_ops,
 			foreign = xen_page_foreign(pages[i]);
 			foreign->domid = map_ops[i].dom;
 			foreign->gref = map_ops[i].ref;
+			kasan_alloc_pages(pages[i], 0);
 			break;
 		}
 
@@ -1085,8 +1086,10 @@ int gnttab_unmap_refs(struct gnttab_unmap_grant_ref *unmap_ops,
 	if (ret)
 		return ret;
 
-	for (i = 0; i < count; i++)
+	for (i = 0; i < count; i++) {
 		ClearPageForeign(pages[i]);
+		kasan_free_pages(pages[i], 0);
+	}
 
 	return clear_foreign_p2m_mapping(unmap_ops, kunmap_ops, pages, count);
 }
-- 
2.17.1

