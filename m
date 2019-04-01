Return-Path: <SRS0=/BGd=SD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DCE15C43381
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Apr 2019 18:06:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AB58C20880
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Apr 2019 18:06:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1554141960;
	bh=spU2CR+J9WzZcMMkNIFcFuiNzBVUrzvOxEq+9UVGKPc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=pvDaxOT+xVVdZq2vbl8ALl8MTrbkSjY62FKBrbzFAa5kKyMfmsrzU/T4OhW7h5WrT
	 hXYq4QIkZNNBumLuHvwh0qA6uZnODz1uAJ8JsouLn3nIdgThywIl6BU/IyFaab+GPq
	 pbxCrztn4NehQF/N1LiZsR2k/GnbkvX0tZxRlxxM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730256AbfDASF7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Apr 2019 14:05:59 -0400
Received: from mail.kernel.org ([198.145.29.99]:35216 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728907AbfDARNE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Apr 2019 13:13:04 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A7A9020883;
        Mon,  1 Apr 2019 17:13:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1554138783;
        bh=spU2CR+J9WzZcMMkNIFcFuiNzBVUrzvOxEq+9UVGKPc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=lZEvwl93GVu1Ar9e6sEsJRcs+grwSN6jkSS4n36opPgjZzwvvRqwE0WtOW0P1OL9X
         5MaOwbVD6hYENVa8KKgAglO/g9sJGa1r+sc2aKHlMIph7+zjSohjvICwnto6d/cioX
         fhAYsnrFzThhP+naGrtajCQMRP2qpeyBwTszZI6M=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Marcel Holtmann <marcel@holtmann.org>,
        Johan Hedberg <johan.hedberg@intel.com>
Subject: [PATCH 4.19 002/134] Bluetooth: Verify that l2cap_get_conf_opt provides large enough buffer
Date:   Mon,  1 Apr 2019 19:00:38 +0200
Message-Id: <20190401170044.456489926@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190401170044.243719205@linuxfoundation.org>
References: <20190401170044.243719205@linuxfoundation.org>
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

4.19-stable review patch.  If anyone has any objections, please let me know.

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
@@ -3336,6 +3336,8 @@ static int l2cap_parse_conf_req(struct l
 
 	while (len >= L2CAP_CONF_OPT_SIZE) {
 		len -= l2cap_get_conf_opt(&req, &type, &olen, &val);
+		if (len < 0)
+			break;
 
 		hint  = type & L2CAP_CONF_HINT;
 		type &= L2CAP_CONF_MASK;
@@ -3554,6 +3556,8 @@ static int l2cap_parse_conf_rsp(struct l
 
 	while (len >= L2CAP_CONF_OPT_SIZE) {
 		len -= l2cap_get_conf_opt(&rsp, &type, &olen, &val);
+		if (len < 0)
+			break;
 
 		switch (type) {
 		case L2CAP_CONF_MTU:
@@ -3739,6 +3743,8 @@ static void l2cap_conf_rfc_get(struct l2
 
 	while (len >= L2CAP_CONF_OPT_SIZE) {
 		len -= l2cap_get_conf_opt(&rsp, &type, &olen, &val);
+		if (len < 0)
+			break;
 
 		switch (type) {
 		case L2CAP_CONF_RFC:


