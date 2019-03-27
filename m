Return-Path: <SRS0=95/N=R6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 595D2C43381
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Mar 2019 18:40:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2C11F2070B
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Mar 2019 18:40:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1553712014;
	bh=+LUJOanJkJEyf+PV3rcDyKZwDUVat3Ztex4oi0PKwjw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=cbewxNut7lvuIHMvXcyniSy9N800tybCgYEAX+t3+SqQTYvGhFvbxTOVMF47a2j+G
	 XfTpTzXT3cCJY6waW2hXYbgxMDFb53gAB3qe/37F6Qtmbg3M+SsKcYDw2OpObLAKai
	 GfFpcsVDESjqyhAIxhiRB7IVSFAePHhtvMuxaUjE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2403985AbfC0SkM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Mar 2019 14:40:12 -0400
Received: from mail.kernel.org ([198.145.29.99]:41192 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2391050AbfC0SW7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Mar 2019 14:22:59 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id AD6BF20651;
        Wed, 27 Mar 2019 18:22:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1553710978;
        bh=+LUJOanJkJEyf+PV3rcDyKZwDUVat3Ztex4oi0PKwjw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Tc0//F8k3V/lyH/wwBJqM/JOs1ajYeoUbEPAGb5hyTeL2s2nAxYSHHkaIQQNXZI8f
         4pTmwijb7ekoqAIbn5HX8KK7owP/FAZ9X65aDVuumD3nPTfs1cZVKhi72Uu1JV98bJ
         sG2U0jL06ydLbxf/lXaTd5faSBfFEefts0dhCFTo=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Marcel Holtmann <marcel@holtmann.org>,
        Johan Hedberg <johan.hedberg@intel.com>,
        Sasha Levin <sashal@kernel.org>,
        linux-bluetooth@vger.kernel.org, netdev@vger.kernel.org
Subject: [PATCH AUTOSEL 4.9 73/87] Bluetooth: Verify that l2cap_get_conf_opt provides large enough buffer
Date:   Wed, 27 Mar 2019 14:20:26 -0400
Message-Id: <20190327182040.17444-73-sashal@kernel.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20190327182040.17444-1-sashal@kernel.org>
References: <20190327182040.17444-1-sashal@kernel.org>
MIME-Version: 1.0
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Marcel Holtmann <marcel@holtmann.org>

[ Upstream commit 7c9cbd0b5e38a1672fcd137894ace3b042dfbf69 ]

The function l2cap_get_conf_opt will return L2CAP_CONF_OPT_SIZE + opt->len
as length value. The opt->len however is in control over the remote user
and can be used by an attacker to gain access beyond the bounds of the
actual packet.

To prevent any potential leak of heap memory, it is enough to check that
the resulting len calculation after calling l2cap_get_conf_opt is not
below zero. A well formed packet will always return >= 0 here and will
end with the length value being zero after the last option has been
parsed. In case of malformed packets messing with the opt->len field the
length value will become negative. If that is the case, then just abort
and ignore the option.

In case an attacker uses a too short opt->len value, then garbage will
be parsed, but that is protected by the unknown option handling and also
the option parameter size checks.

Signed-off-by: Marcel Holtmann <marcel@holtmann.org>
Reviewed-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Johan Hedberg <johan.hedberg@intel.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/bluetooth/l2cap_core.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/net/bluetooth/l2cap_core.c b/net/bluetooth/l2cap_core.c
index 1fc23cb4a3e0..bf7a2846a85f 100644
--- a/net/bluetooth/l2cap_core.c
+++ b/net/bluetooth/l2cap_core.c
@@ -3326,6 +3326,8 @@ static int l2cap_parse_conf_req(struct l2cap_chan *chan, void *data, size_t data
 
 	while (len >= L2CAP_CONF_OPT_SIZE) {
 		len -= l2cap_get_conf_opt(&req, &type, &olen, &val);
+		if (len < 0)
+			break;
 
 		hint  = type & L2CAP_CONF_HINT;
 		type &= L2CAP_CONF_MASK;
@@ -3537,6 +3539,8 @@ static int l2cap_parse_conf_rsp(struct l2cap_chan *chan, void *rsp, int len,
 
 	while (len >= L2CAP_CONF_OPT_SIZE) {
 		len -= l2cap_get_conf_opt(&rsp, &type, &olen, &val);
+		if (len < 0)
+			break;
 
 		switch (type) {
 		case L2CAP_CONF_MTU:
@@ -3717,6 +3721,8 @@ static void l2cap_conf_rfc_get(struct l2cap_chan *chan, void *rsp, int len)
 
 	while (len >= L2CAP_CONF_OPT_SIZE) {
 		len -= l2cap_get_conf_opt(&rsp, &type, &olen, &val);
+		if (len < 0)
+			break;
 
 		switch (type) {
 		case L2CAP_CONF_RFC:
-- 
2.19.1

