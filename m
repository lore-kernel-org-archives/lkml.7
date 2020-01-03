Return-Path: <SRS0=3Pgh=2Y=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 12029C2D0CE
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Jan 2020 04:50:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D25CA21D7D
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Jan 2020 04:50:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=mg.codeaurora.org header.i=@mg.codeaurora.org header.b="PmUa24L+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727274AbgACEue (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 2 Jan 2020 23:50:34 -0500
Received: from mail25.static.mailgun.info ([104.130.122.25]:54958 "EHLO
        mail25.static.mailgun.info" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726219AbgACEud (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Jan 2020 23:50:33 -0500
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1578027032; h=Content-Transfer-Encoding: MIME-Version:
 Message-Id: Date: Subject: Cc: To: From: Sender;
 bh=3O3z8sSXJg5C8+VeHnJlGt4zQEiKjMdI7knVylfri4w=; b=PmUa24L+BnFNh9ACYitotp/L4tqvSKsm1NNSKehS167MlEIvlbDBleaBiP0k6s/qPk4L4WfN
 cbHwiYqUhzoOah8tNCSqOMu8fcpXxR8cGy6EnkqGg7PkHlSBL9u0AFqJVJu4NMTGMqncK5Oz
 U6meBxuvITqLmPVuJNNqyS6dAN0=
X-Mailgun-Sending-Ip: 104.130.122.25
X-Mailgun-Sid: WyI0MWYwYSIsICJsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnIiwgImJlOWU0YSJd
Received: from smtp.codeaurora.org (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171])
 by mxa.mailgun.org with ESMTP id 5e0ec817.7fb374764a08-smtp-out-n03;
 Fri, 03 Jan 2020 04:50:31 -0000 (UTC)
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id BFD56C447A3; Fri,  3 Jan 2020 04:50:31 +0000 (UTC)
Received: from wgong-HP-Z240-SFF-Workstation.qca.qualcomm.com (unknown [180.166.53.21])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: wgong)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id C188CC447A2;
        Fri,  3 Jan 2020 04:50:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org C188CC447A2
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=none smtp.mailfrom=wgong@codeaurora.org
From:   Wen Gong <wgong@codeaurora.org>
To:     davem@davemloft.net
Cc:     netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        ath11k@lists.infradead.org
Subject: [PATCH v2] net: qrtr: fix len of skb_put_padto in qrtr_node_enqueue
Date:   Fri,  3 Jan 2020 12:50:16 +0800
Message-Id: <20200103045016.12459-1-wgong@codeaurora.org>
X-Mailer: git-send-email 2.23.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Carl Huang <cjhuang@codeaurora.org>

The len used for skb_put_padto is wrong, it need to add len of hdr.

In qrtr_node_enqueue, local variable size_t len is assign with
skb->len, then skb_push(skb, sizeof(*hdr)) will add skb->len with
sizeof(*hdr), so local variable size_t len is not same with skb->len
after skb_push(skb, sizeof(*hdr)).

Then the purpose of skb_put_padto(skb, ALIGN(len, 4)) is to add add
pad to the end of the skb's data if skb->len is not aligned to 4, but
unfortunately it use len instead of skb->len, at this line, skb->len
is 32 bytes(sizeof(*hdr)) more than len, for example, len is 3 bytes,
then skb->len is 35 bytes(3 + 32), and ALIGN(len, 4) is 4 bytes, so
__skb_put_padto will do nothing after check size(35) < len(4), the
correct value should be 36(sizeof(*hdr) + ALIGN(len, 4) = 32 + 4),
then __skb_put_padto will pass check size(35) < len(36) and add 1 byte
to the end of skb's data, then logic is correct.

function of skb_push:
void *skb_push(struct sk_buff *skb, unsigned int len)
{
	skb->data -= len;
	skb->len  += len;
	if (unlikely(skb->data < skb->head))
		skb_under_panic(skb, len, __builtin_return_address(0));
	return skb->data;
}

function of skb_put_padto
static inline int skb_put_padto(struct sk_buff *skb, unsigned int len)
{
	return __skb_put_padto(skb, len, true);
}

function of __skb_put_padto
static inline int __skb_put_padto(struct sk_buff *skb, unsigned int len,
				  bool free_on_error)
{
	unsigned int size = skb->len;

	if (unlikely(size < len)) {
		len -= size;
		if (__skb_pad(skb, len, free_on_error))
			return -ENOMEM;
		__skb_put(skb, len);
	}
	return 0;
}

Signed-off-by: Carl Huang <cjhuang@codeaurora.org>
Signed-off-by: Wen Gong <wgong@codeaurora.org>
---
v2: change description
 net/qrtr/qrtr.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/qrtr/qrtr.c b/net/qrtr/qrtr.c
index 88f98f27ad88..3d24d45be5f4 100644
--- a/net/qrtr/qrtr.c
+++ b/net/qrtr/qrtr.c
@@ -196,7 +196,7 @@ static int qrtr_node_enqueue(struct qrtr_node *node, struct sk_buff *skb,
 	hdr->size = cpu_to_le32(len);
 	hdr->confirm_rx = 0;
 
-	skb_put_padto(skb, ALIGN(len, 4));
+	skb_put_padto(skb, ALIGN(len, 4) + sizeof(*hdr));
 
 	mutex_lock(&node->ep_lock);
 	if (node->ep)
-- 
2.23.0
