Return-Path: <SRS0=/BGd=SD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0C0CFC43381
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Apr 2019 18:03:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C25AB2084B
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Apr 2019 18:03:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1554141836;
	bh=g5S571D0XlVs5waVO/adpfUT/DT0KW+uhR6SOWklHA0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=CYJ7exDG2XwqN1gMV7yTqVzhYUU+CxyPPcFkyNEamHDsptGRoTAaWdePcxk1teeG/
	 AbmYXn0VB+oi/ifDPldtUhE6obSXdWWFKzhpf95qChyJG4qkeyFSI2fvOCZvsdiMlB
	 Wh8i1De2rXsZda2Ak926jmCVNMOI0rx//E8pr7AQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731126AbfDASDz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Apr 2019 14:03:55 -0400
Received: from mail.kernel.org ([198.145.29.99]:37004 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730657AbfDAROC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Apr 2019 13:14:02 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0611B205F4;
        Mon,  1 Apr 2019 17:03:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1554138240;
        bh=g5S571D0XlVs5waVO/adpfUT/DT0KW+uhR6SOWklHA0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=I89jHeCGY6+hyztAn5DFtvd2BSqnIMfde63jdJ4AB4YQvn9sBcJ5z7zkKmQV7NsNQ
         sW0QXsw4j8gRNY5oikYrvoFOQqEFe9FLqTfcRXkT43Rm3FAxqJGsmuWUKKOl1pJlqO
         ANMKaAqyY7zjQU658nyK5SVOUcrC41EFNo5viwDg=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Marcel Holtmann <marcel@holtmann.org>,
        Johan Hedberg <johan.hedberg@intel.com>
Subject: [PATCH 5.0 001/146] Bluetooth: Check L2CAP option sizes returned from l2cap_get_conf_opt
Date:   Mon,  1 Apr 2019 19:00:13 +0200
Message-Id: <20190401170048.558277980@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190401170048.449559024@linuxfoundation.org>
References: <20190401170048.449559024@linuxfoundation.org>
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

5.0-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Marcel Holtmann <marcel@holtmann.org>

commit af3d5d1c87664a4f150fcf3534c6567cb19909b0 upstream.

When doing option parsing for standard type values of 1, 2 or 4 octets,
the value is converted directly into a variable instead of a pointer. To
avoid being tricked into being a pointer, check that for these option
types that sizes actually match. In L2CAP every option is fixed size and
thus it is prudent anyway to ensure that the remote side sends us the
right option size along with option paramters.

If the option size is not matching the option type, then that option is
silently ignored. It is a protocol violation and instead of trying to
give the remote attacker any further hints just pretend that option is
not present and proceed with the default values. Implementation
following the specification and its qualification procedures will always
use the correct size and thus not being impacted here.

To keep the code readable and consistent accross all options, a few
cosmetic changes were also required.

Signed-off-by: Marcel Holtmann <marcel@holtmann.org>
Reviewed-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Johan Hedberg <johan.hedberg@intel.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 net/bluetooth/l2cap_core.c |   77 ++++++++++++++++++++++++++-------------------
 1 file changed, 46 insertions(+), 31 deletions(-)

--- a/net/bluetooth/l2cap_core.c
+++ b/net/bluetooth/l2cap_core.c
@@ -3343,10 +3343,14 @@ static int l2cap_parse_conf_req(struct l
 
 		switch (type) {
 		case L2CAP_CONF_MTU:
+			if (olen != 2)
+				break;
 			mtu = val;
 			break;
 
 		case L2CAP_CONF_FLUSH_TO:
+			if (olen != 2)
+				break;
 			chan->flush_to = val;
 			break;
 
@@ -3354,26 +3358,30 @@ static int l2cap_parse_conf_req(struct l
 			break;
 
 		case L2CAP_CONF_RFC:
-			if (olen == sizeof(rfc))
-				memcpy(&rfc, (void *) val, olen);
+			if (olen != sizeof(rfc))
+				break;
+			memcpy(&rfc, (void *) val, olen);
 			break;
 
 		case L2CAP_CONF_FCS:
+			if (olen != 1)
+				break;
 			if (val == L2CAP_FCS_NONE)
 				set_bit(CONF_RECV_NO_FCS, &chan->conf_state);
 			break;
 
 		case L2CAP_CONF_EFS:
-			if (olen == sizeof(efs)) {
-				remote_efs = 1;
-				memcpy(&efs, (void *) val, olen);
-			}
+			if (olen != sizeof(efs))
+				break;
+			remote_efs = 1;
+			memcpy(&efs, (void *) val, olen);
 			break;
 
 		case L2CAP_CONF_EWS:
+			if (olen != 2)
+				break;
 			if (!(chan->conn->local_fixed_chan & L2CAP_FC_A2MP))
 				return -ECONNREFUSED;
-
 			set_bit(FLAG_EXT_CTRL, &chan->flags);
 			set_bit(CONF_EWS_RECV, &chan->conf_state);
 			chan->tx_win_max = L2CAP_DEFAULT_EXT_WINDOW;
@@ -3383,7 +3391,6 @@ static int l2cap_parse_conf_req(struct l
 		default:
 			if (hint)
 				break;
-
 			result = L2CAP_CONF_UNKNOWN;
 			*((u8 *) ptr++) = type;
 			break;
@@ -3551,55 +3558,60 @@ static int l2cap_parse_conf_rsp(struct l
 
 		switch (type) {
 		case L2CAP_CONF_MTU:
+			if (olen != 2)
+				break;
 			if (val < L2CAP_DEFAULT_MIN_MTU) {
 				*result = L2CAP_CONF_UNACCEPT;
 				chan->imtu = L2CAP_DEFAULT_MIN_MTU;
 			} else
 				chan->imtu = val;
-			l2cap_add_conf_opt(&ptr, L2CAP_CONF_MTU, 2, chan->imtu, endptr - ptr);
+			l2cap_add_conf_opt(&ptr, L2CAP_CONF_MTU, 2, chan->imtu,
+					   endptr - ptr);
 			break;
 
 		case L2CAP_CONF_FLUSH_TO:
+			if (olen != 2)
+				break;
 			chan->flush_to = val;
-			l2cap_add_conf_opt(&ptr, L2CAP_CONF_FLUSH_TO,
-					   2, chan->flush_to, endptr - ptr);
+			l2cap_add_conf_opt(&ptr, L2CAP_CONF_FLUSH_TO, 2,
+					   chan->flush_to, endptr - ptr);
 			break;
 
 		case L2CAP_CONF_RFC:
-			if (olen == sizeof(rfc))
-				memcpy(&rfc, (void *)val, olen);
-
+			if (olen != sizeof(rfc))
+				break;
+			memcpy(&rfc, (void *)val, olen);
 			if (test_bit(CONF_STATE2_DEVICE, &chan->conf_state) &&
 			    rfc.mode != chan->mode)
 				return -ECONNREFUSED;
-
 			chan->fcs = 0;
-
-			l2cap_add_conf_opt(&ptr, L2CAP_CONF_RFC,
-					   sizeof(rfc), (unsigned long) &rfc, endptr - ptr);
+			l2cap_add_conf_opt(&ptr, L2CAP_CONF_RFC, sizeof(rfc),
+					   (unsigned long) &rfc, endptr - ptr);
 			break;
 
 		case L2CAP_CONF_EWS:
+			if (olen != 2)
+				break;
 			chan->ack_win = min_t(u16, val, chan->ack_win);
 			l2cap_add_conf_opt(&ptr, L2CAP_CONF_EWS, 2,
 					   chan->tx_win, endptr - ptr);
 			break;
 
 		case L2CAP_CONF_EFS:
-			if (olen == sizeof(efs)) {
-				memcpy(&efs, (void *)val, olen);
-
-				if (chan->local_stype != L2CAP_SERV_NOTRAFIC &&
-				    efs.stype != L2CAP_SERV_NOTRAFIC &&
-				    efs.stype != chan->local_stype)
-					return -ECONNREFUSED;
-
-				l2cap_add_conf_opt(&ptr, L2CAP_CONF_EFS, sizeof(efs),
-						   (unsigned long) &efs, endptr - ptr);
-			}
+			if (olen != sizeof(efs))
+				break;
+			memcpy(&efs, (void *)val, olen);
+			if (chan->local_stype != L2CAP_SERV_NOTRAFIC &&
+			    efs.stype != L2CAP_SERV_NOTRAFIC &&
+			    efs.stype != chan->local_stype)
+				return -ECONNREFUSED;
+			l2cap_add_conf_opt(&ptr, L2CAP_CONF_EFS, sizeof(efs),
+					   (unsigned long) &efs, endptr - ptr);
 			break;
 
 		case L2CAP_CONF_FCS:
+			if (olen != 1)
+				break;
 			if (*result == L2CAP_CONF_PENDING)
 				if (val == L2CAP_FCS_NONE)
 					set_bit(CONF_RECV_NO_FCS,
@@ -3731,10 +3743,13 @@ static void l2cap_conf_rfc_get(struct l2
 
 		switch (type) {
 		case L2CAP_CONF_RFC:
-			if (olen == sizeof(rfc))
-				memcpy(&rfc, (void *)val, olen);
+			if (olen != sizeof(rfc))
+				break;
+			memcpy(&rfc, (void *)val, olen);
 			break;
 		case L2CAP_CONF_EWS:
+			if (olen != 2)
+				break;
 			txwin_ext = val;
 			break;
 		}


