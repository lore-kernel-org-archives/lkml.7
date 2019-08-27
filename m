Return-Path: <SRS0=qJmF=WX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B5A05C3A5A3
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Aug 2019 08:04:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8BED82173E
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Aug 2019 08:04:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1566893095;
	bh=Qw77gmRiSKJzRYk3kAqM2t382LGrq//S+kz8qBIaXEM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=fJjgk0wtJD/uGerIIlWzfuidoqqWzKzsY/Yfz04AjEw5zMZNlnx791jIz3rtAZ1Yk
	 iyFmIp3X2vcfARSWANUjAc0u98XCUg04Ye3VmOZtevn4PsmZMW1NRMNSJo0UYj6I5c
	 tpwaYH7TEV83+StcXU4LrxY/BtnJk3LA5tl6daqE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732664AbfH0IEy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 27 Aug 2019 04:04:54 -0400
Received: from mail.kernel.org ([198.145.29.99]:34456 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732640AbfH0IEv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Aug 2019 04:04:51 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2F082206BF;
        Tue, 27 Aug 2019 08:04:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1566893090;
        bh=Qw77gmRiSKJzRYk3kAqM2t382LGrq//S+kz8qBIaXEM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=2I64tZ9r4BIZCv6CZV70vjZdyPsyw9Vdz+am+w2nnCWsJxBW2HgiASuD9FEBjYXgF
         JxoIL36yZ3tWa0annxRyZUgsL4JeMGDEdCpan+6JZwqAHho5MRyIwJ5Gw9uOsFNsIS
         AHfNNYN5g9wtEjRoRKALfj0V/4JWW15JReL9LGss=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Jerry Lee <leisurelysw24@gmail.com>,
        Ilya Dryomov <idryomov@gmail.com>,
        Jeff Layton <jlayton@kernel.org>
Subject: [PATCH 5.2 118/162] libceph: fix PG split vs OSD (re)connect race
Date:   Tue, 27 Aug 2019 09:50:46 +0200
Message-Id: <20190827072742.543963345@linuxfoundation.org>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20190827072738.093683223@linuxfoundation.org>
References: <20190827072738.093683223@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Ilya Dryomov <idryomov@gmail.com>

commit a561372405cf6bc6f14239b3a9e57bb39f2788b0 upstream.

We can't rely on ->peer_features in calc_target() because it may be
called both when the OSD session is established and open and when it's
not.  ->peer_features is not valid unless the OSD session is open.  If
this happens on a PG split (pg_num increase), that could mean we don't
resend a request that should have been resent, hanging the client
indefinitely.

In userspace this was fixed by looking at require_osd_release and
get_xinfo[osd].features fields of the osdmap.  However these fields
belong to the OSD section of the osdmap, which the kernel doesn't
decode (only the client section is decoded).

Instead, let's drop this feature check.  It effectively checks for
luminous, so only pre-luminous OSDs would be affected in that on a PG
split the kernel might resend a request that should not have been
resent.  Duplicates can occur in other scenarios, so both sides should
already be prepared for them: see dup/replay logic on the OSD side and
retry_attempt check on the client side.

Cc: stable@vger.kernel.org
Fixes: 7de030d6b10a ("libceph: resend on PG splits if OSD has RESEND_ON_SPLIT")
Link: https://tracker.ceph.com/issues/41162
Reported-by: Jerry Lee <leisurelysw24@gmail.com>
Signed-off-by: Ilya Dryomov <idryomov@gmail.com>
Tested-by: Jerry Lee <leisurelysw24@gmail.com>
Reviewed-by: Jeff Layton <jlayton@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 net/ceph/osd_client.c |    9 ++++-----
 1 file changed, 4 insertions(+), 5 deletions(-)

--- a/net/ceph/osd_client.c
+++ b/net/ceph/osd_client.c
@@ -1504,7 +1504,7 @@ static enum calc_target_result calc_targ
 	struct ceph_osds up, acting;
 	bool force_resend = false;
 	bool unpaused = false;
-	bool legacy_change;
+	bool legacy_change = false;
 	bool split = false;
 	bool sort_bitwise = ceph_osdmap_flag(osdc, CEPH_OSDMAP_SORTBITWISE);
 	bool recovery_deletes = ceph_osdmap_flag(osdc,
@@ -1592,15 +1592,14 @@ static enum calc_target_result calc_targ
 		t->osd = acting.primary;
 	}
 
-	if (unpaused || legacy_change || force_resend ||
-	    (split && con && CEPH_HAVE_FEATURE(con->peer_features,
-					       RESEND_ON_SPLIT)))
+	if (unpaused || legacy_change || force_resend || split)
 		ct_res = CALC_TARGET_NEED_RESEND;
 	else
 		ct_res = CALC_TARGET_NO_ACTION;
 
 out:
-	dout("%s t %p -> ct_res %d osd %d\n", __func__, t, ct_res, t->osd);
+	dout("%s t %p -> %d%d%d%d ct_res %d osd%d\n", __func__, t, unpaused,
+	     legacy_change, force_resend, split, ct_res, t->osd);
 	return ct_res;
 }
 


