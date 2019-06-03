Return-Path: <SRS0=cV2B=UC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5E487C28CC7
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Jun 2019 09:10:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3885D27E2B
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Jun 2019 09:10:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1559553011;
	bh=N1GD6wogL0wc3ROCjL0Tr4+i1aVNnoY969QvokdKYgw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=EginV8HnzsCJkSWrZUbaYX3zPgWvHWiUyfWvpkFIUFdrSwo0pVdkpn+e2e3iuqQJZ
	 xV47U7K6mU+tYcTo3lZmldhK8KOMXCE5DSFiYFUeQHXWDiYW8FA8Es4kDOKJ/bP5oB
	 c37Kq2j1FJvx/QFSR7Om0uuE92e4l2gLOMyGYur0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728056AbfFCJKK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Jun 2019 05:10:10 -0400
Received: from mail.kernel.org ([198.145.29.99]:54304 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727893AbfFCJKI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Jun 2019 05:10:08 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 15A1027E30;
        Mon,  3 Jun 2019 09:10:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1559553007;
        bh=N1GD6wogL0wc3ROCjL0Tr4+i1aVNnoY969QvokdKYgw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=sZQY2RCG2HpoGG6bzeMzSFID/9FyI5xCfTFYnf9xwxJKskvfFNd+XkbZRzMw9pbs1
         PDgQfTFgte1M8LRwsmJX1AnTMRWKUoZwn9EnVuYF3HazyYST29BtB5roG2GcxNheNC
         zmPW8STL+AxleIjDKTAUpDTOtNdZhUqS84rIKB88=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Chris Packham <chris.packham@alliedtelesis.co.nz>,
        "David S. Miller" <davem@davemloft.net>
Subject: [PATCH 4.19 19/32] tipc: Avoid copying bytes beyond the supplied data
Date:   Mon,  3 Jun 2019 11:08:13 +0200
Message-Id: <20190603090313.753666374@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190603090308.472021390@linuxfoundation.org>
References: <20190603090308.472021390@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Chris Packham <chris.packham@alliedtelesis.co.nz>

TLV_SET is called with a data pointer and a len parameter that tells us
how many bytes are pointed to by data. When invoking memcpy() we need
to careful to only copy len bytes.

Previously we would copy TLV_LENGTH(len) bytes which would copy an extra
4 bytes past the end of the data pointer which newer GCC versions
complain about.

 In file included from test.c:17:
 In function 'TLV_SET',
     inlined from 'test' at test.c:186:5:
 /usr/include/linux/tipc_config.h:317:3:
 warning: 'memcpy' forming offset [33, 36] is out of the bounds [0, 32]
 of object 'bearer_name' with type 'char[32]' [-Warray-bounds]
     memcpy(TLV_DATA(tlv_ptr), data, tlv_len);
     ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
 test.c: In function 'test':
 test.c::161:10: note:
 'bearer_name' declared here
     char bearer_name[TIPC_MAX_BEARER_NAME];
          ^~~~~~~~~~~

We still want to ensure any padding bytes at the end are initialised, do
this with a explicit memset() rather than copy bytes past the end of
data. Apply the same logic to TCM_SET.

Signed-off-by: Chris Packham <chris.packham@alliedtelesis.co.nz>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 include/uapi/linux/tipc_config.h |   10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

--- a/include/uapi/linux/tipc_config.h
+++ b/include/uapi/linux/tipc_config.h
@@ -307,8 +307,10 @@ static inline int TLV_SET(void *tlv, __u
 	tlv_ptr = (struct tlv_desc *)tlv;
 	tlv_ptr->tlv_type = htons(type);
 	tlv_ptr->tlv_len  = htons(tlv_len);
-	if (len && data)
-		memcpy(TLV_DATA(tlv_ptr), data, tlv_len);
+	if (len && data) {
+		memcpy(TLV_DATA(tlv_ptr), data, len);
+		memset(TLV_DATA(tlv_ptr) + len, 0, TLV_SPACE(len) - tlv_len);
+	}
 	return TLV_SPACE(len);
 }
 
@@ -405,8 +407,10 @@ static inline int TCM_SET(void *msg, __u
 	tcm_hdr->tcm_len   = htonl(msg_len);
 	tcm_hdr->tcm_type  = htons(cmd);
 	tcm_hdr->tcm_flags = htons(flags);
-	if (data_len && data)
+	if (data_len && data) {
 		memcpy(TCM_DATA(msg), data, data_len);
+		memset(TCM_DATA(msg) + data_len, 0, TCM_SPACE(data_len) - msg_len);
+	}
 	return TCM_SPACE(data_len);
 }
 


