Return-Path: <SRS0=/BGd=SD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1F47BC43381
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Apr 2019 17:37:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E3E272070B
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Apr 2019 17:37:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1554140249;
	bh=2mQtYfpnLi8lXhDMeFK4oKWrNbLAuSeN9rEgRHUZhHE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=rLfmWTBBaHUkdtONfrXgReHAZncynd+VVT1fVlUv8Dfp2YEa8aH+8Wwc7VTBMyAch
	 u0+MC8kTIiH04DS8f56J8obbCE/mrpyBL30E1ZduYHcc8LcdIzzPsJbQ8SU2R9Fh7I
	 hQe5chTA5K66won80tHjUVwhFfWGahhE7w4kH3cs=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388176AbfDARh1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Apr 2019 13:37:27 -0400
Received: from mail.kernel.org ([198.145.29.99]:49928 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728997AbfDARhY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Apr 2019 13:37:24 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 17CA82070B;
        Mon,  1 Apr 2019 17:37:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1554140243;
        bh=2mQtYfpnLi8lXhDMeFK4oKWrNbLAuSeN9rEgRHUZhHE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=eu1Yw9FiRdkZ97au9Zr1QKLY14hEYpNm5u/Z2zHKyZ9x43edNuFk7Xw85UXZMdJ79
         PpSNOz4ZMEMkRA7iXKKv0NUJ6El7HwEzNsJ6izr0QkbF5yqK6Yw4ee8g0AKev06s6W
         z5ML7imVUMhjkJ2mPhbyU1A2tqo/RgDFAqkK8iVU=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Marcel Holtmann <marcel@holtmann.org>,
        Johan Hedberg <johan.hedberg@intel.com>
Subject: [PATCH 3.18 09/50] Bluetooth: Verify that l2cap_get_conf_opt provides large enough buffer
Date:   Mon,  1 Apr 2019 19:02:52 +0200
Message-Id: <20190401170042.048342863@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190401170041.257273804@linuxfoundation.org>
References: <20190401170041.257273804@linuxfoundation.org>
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

3.18-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Marcel Holtmann <marcel@holtmann.org>

commit 7c9cbd0b5e38a1672fcd137894ace3b042dfbf69 upstream.

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
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 net/bluetooth/l2cap_core.c |    6 ++++++
 1 file changed, 6 insertions(+)

--- a/net/bluetooth/l2cap_core.c
+++ b/net/bluetooth/l2cap_core.c
@@ -3290,6 +3290,8 @@ static int l2cap_parse_conf_req(struct l
 
 	while (len >= L2CAP_CONF_OPT_SIZE) {
 		len -= l2cap_get_conf_opt(&req, &type, &olen, &val);
+		if (len < 0)
+			break;
 
 		hint  = type & L2CAP_CONF_HINT;
 		type &= L2CAP_CONF_MASK;
@@ -3508,6 +3510,8 @@ static int l2cap_parse_conf_rsp(struct l
 
 	while (len >= L2CAP_CONF_OPT_SIZE) {
 		len -= l2cap_get_conf_opt(&rsp, &type, &olen, &val);
+		if (len < 0)
+			break;
 
 		switch (type) {
 		case L2CAP_CONF_MTU:
@@ -3693,6 +3697,8 @@ static void l2cap_conf_rfc_get(struct l2
 
 	while (len >= L2CAP_CONF_OPT_SIZE) {
 		len -= l2cap_get_conf_opt(&rsp, &type, &olen, &val);
+		if (len < 0)
+			break;
 
 		switch (type) {
 		case L2CAP_CONF_RFC:


