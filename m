Return-Path: <SRS0=4nbc=R5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BD0CEC43381
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Mar 2019 06:33:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8C3B720857
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Mar 2019 06:33:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1553582018;
	bh=dPA42YVZxSXX/fT8QUEQInK8VgpeukuQ1KLTF7nHVus=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=WEijjTAwRUzYEEHVzQHOyntNeak8dTscZ6yC+mKoNITYoBOdLJVgkyU+qJkGQpnSt
	 pZpyRZpWl8r2n5qct1PMKjOZElbBfwkn6h7IYMpk3yF467EIqm/QjcXJDQC759YBVn
	 Mp20nT8DVKwqa0vN1ZR6VmzYnpEH91d/ULVPImQ8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731705AbfCZGdh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Mar 2019 02:33:37 -0400
Received: from mail.kernel.org ([198.145.29.99]:43426 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731179AbfCZGdf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Mar 2019 02:33:35 -0400
Received: from localhost (unknown [104.132.152.111])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id AED3B20863;
        Tue, 26 Mar 2019 06:33:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1553582014;
        bh=dPA42YVZxSXX/fT8QUEQInK8VgpeukuQ1KLTF7nHVus=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=DtXqqb9evF7CyfjPiuqG8gTOYDt5HfNpRLPXofk7O10JuMJFKz9fsz+AW1iwwH08y
         61vlP2SpbXfyvfQSl5ihGIt5x76ANANu9nsg3xzehbegIIfX2/PSBW8OONzBBBW6aL
         4ghlFPmJeKWi2phYUQ7cK4Rhz4ySJGt22E+W49GE=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Ilya Dryomov <idryomov@gmail.com>,
        Jason Dillaman <dillaman@redhat.com>
Subject: [PATCH 4.14 04/41] libceph: wait for latest osdmap in ceph_monc_blacklist_add()
Date:   Tue, 26 Mar 2019 15:29:41 +0900
Message-Id: <20190326042650.110752369@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190326042649.889479098@linuxfoundation.org>
References: <20190326042649.889479098@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Ilya Dryomov <idryomov@gmail.com>

commit bb229bbb3bf63d23128e851a1f3b85c083178fa1 upstream.

Because map updates are distributed lazily, an OSD may not know about
the new blacklist for quite some time after "osd blacklist add" command
is completed.  This makes it possible for a blacklisted but still alive
client to overwrite a post-blacklist update, resulting in data
corruption.

Waiting for latest osdmap in ceph_monc_blacklist_add() and thus using
the post-blacklist epoch for all post-blacklist requests ensures that
all such requests "wait" for the blacklist to come into force on their
respective OSDs.

Cc: stable@vger.kernel.org
Fixes: 6305a3b41515 ("libceph: support for blacklisting clients")
Signed-off-by: Ilya Dryomov <idryomov@gmail.com>
Reviewed-by: Jason Dillaman <dillaman@redhat.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 include/linux/ceph/libceph.h |    2 ++
 net/ceph/ceph_common.c       |   18 +++++++++++++++++-
 net/ceph/mon_client.c        |    9 +++++++++
 3 files changed, 28 insertions(+), 1 deletion(-)

--- a/include/linux/ceph/libceph.h
+++ b/include/linux/ceph/libceph.h
@@ -291,6 +291,8 @@ extern void ceph_destroy_client(struct c
 extern int __ceph_open_session(struct ceph_client *client,
 			       unsigned long started);
 extern int ceph_open_session(struct ceph_client *client);
+int ceph_wait_for_latest_osdmap(struct ceph_client *client,
+				unsigned long timeout);
 
 /* pagevec.c */
 extern void ceph_release_page_vector(struct page **pages, int num_pages);
--- a/net/ceph/ceph_common.c
+++ b/net/ceph/ceph_common.c
@@ -720,7 +720,6 @@ int __ceph_open_session(struct ceph_clie
 }
 EXPORT_SYMBOL(__ceph_open_session);
 
-
 int ceph_open_session(struct ceph_client *client)
 {
 	int ret;
@@ -736,6 +735,23 @@ int ceph_open_session(struct ceph_client
 }
 EXPORT_SYMBOL(ceph_open_session);
 
+int ceph_wait_for_latest_osdmap(struct ceph_client *client,
+				unsigned long timeout)
+{
+	u64 newest_epoch;
+	int ret;
+
+	ret = ceph_monc_get_version(&client->monc, "osdmap", &newest_epoch);
+	if (ret)
+		return ret;
+
+	if (client->osdc.osdmap->epoch >= newest_epoch)
+		return 0;
+
+	ceph_osdc_maybe_request_map(&client->osdc);
+	return ceph_monc_wait_osdmap(&client->monc, newest_epoch, timeout);
+}
+EXPORT_SYMBOL(ceph_wait_for_latest_osdmap);
 
 static int __init init_ceph_lib(void)
 {
--- a/net/ceph/mon_client.c
+++ b/net/ceph/mon_client.c
@@ -922,6 +922,15 @@ int ceph_monc_blacklist_add(struct ceph_
 	mutex_unlock(&monc->mutex);
 
 	ret = wait_generic_request(req);
+	if (!ret)
+		/*
+		 * Make sure we have the osdmap that includes the blacklist
+		 * entry.  This is needed to ensure that the OSDs pick up the
+		 * new blacklist before processing any future requests from
+		 * this client.
+		 */
+		ret = ceph_wait_for_latest_osdmap(monc->client, 0);
+
 out:
 	put_generic_request(req);
 	return ret;


