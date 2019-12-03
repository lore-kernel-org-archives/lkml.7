Return-Path: <SRS0=Tfva=ZZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3120EC432C0
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Dec 2019 22:38:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0164A207DD
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Dec 2019 22:38:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1575412684;
	bh=3MNQJ8h/QNCVQM0lJNWt4aerH/FjCtoGLkxPP7BRwOw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=GBAH4z7Ln0CLVhg5aDP59vHr5ySHURXHq71/62cGBq76AURbqNZq4rwLCXmzNK+FH
	 htm39ePZGnXlhDMDw16POnexlvRlKA3ThrkVsieun+by5aPpztKcQfBOcSG9Tr1RdY
	 B3urgtJccg5Ncafx1/oKAThacuyy4uCx/SB6rt/s=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727893AbfLCWiC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 3 Dec 2019 17:38:02 -0500
Received: from mail.kernel.org ([198.145.29.99]:46666 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727866AbfLCWiB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Dec 2019 17:38:01 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E2BD220848;
        Tue,  3 Dec 2019 22:37:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1575412680;
        bh=3MNQJ8h/QNCVQM0lJNWt4aerH/FjCtoGLkxPP7BRwOw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=jW8xd6Tlr9RcsN3g4L6RZHMQ0uLzx30qoHc86FrTVKX6EK2+gvGp+Kvjx+mG8m1d+
         pszFCQfs7aA+MAl2bQBB6tgaNQsEUWmbz++FFEU5Rze8fIOLRbrDJzvaK0snwG3ymN
         Y8xs0lojXPAZrgwAhbtFfz/ZKA180LkScdahERUs=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Qi Jun Ding <qding@redhat.com>,
        Paolo Abeni <pabeni@redhat.com>,
        "David S. Miller" <davem@davemloft.net>
Subject: [PATCH 5.4 23/46] openvswitch: fix flow command message size
Date:   Tue,  3 Dec 2019 23:35:43 +0100
Message-Id: <20191203212737.988432826@linuxfoundation.org>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <20191203212705.175425505@linuxfoundation.org>
References: <20191203212705.175425505@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Paolo Abeni <pabeni@redhat.com>

[ Upstream commit 4e81c0b3fa93d07653e2415fa71656b080a112fd ]

When user-space sets the OVS_UFID_F_OMIT_* flags, and the relevant
flow has no UFID, we can exceed the computed size, as
ovs_nla_put_identifier() will always dump an OVS_FLOW_ATTR_KEY
attribute.
Take the above in account when computing the flow command message
size.

Fixes: 74ed7ab9264c ("openvswitch: Add support for unique flow IDs.")
Reported-by: Qi Jun Ding <qding@redhat.com>
Signed-off-by: Paolo Abeni <pabeni@redhat.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 net/openvswitch/datapath.c |    6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

--- a/net/openvswitch/datapath.c
+++ b/net/openvswitch/datapath.c
@@ -704,9 +704,13 @@ static size_t ovs_flow_cmd_msg_size(cons
 {
 	size_t len = NLMSG_ALIGN(sizeof(struct ovs_header));
 
-	/* OVS_FLOW_ATTR_UFID */
+	/* OVS_FLOW_ATTR_UFID, or unmasked flow key as fallback
+	 * see ovs_nla_put_identifier()
+	 */
 	if (sfid && ovs_identifier_is_ufid(sfid))
 		len += nla_total_size(sfid->ufid_len);
+	else
+		len += nla_total_size(ovs_key_attr_size());
 
 	/* OVS_FLOW_ATTR_KEY */
 	if (!sfid || should_fill_key(sfid, ufid_flags))


