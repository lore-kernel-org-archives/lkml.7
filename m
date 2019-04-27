Return-Path: <SRS0=SjSX=S5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 041A8C43218
	for <linux-kernel@archiver.kernel.org>; Sat, 27 Apr 2019 15:15:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C7999206A3
	for <linux-kernel@archiver.kernel.org>; Sat, 27 Apr 2019 15:15:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727832AbfD0PPx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 27 Apr 2019 11:15:53 -0400
Received: from shadbolt.e.decadent.org.uk ([88.96.1.126]:33190 "EHLO
        shadbolt.e.decadent.org.uk" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727387AbfD0PPX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 27 Apr 2019 11:15:23 -0400
Received: from [192.168.4.242] (helo=deadeye)
        by shadbolt.decadent.org.uk with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <ben@decadent.org.uk>)
        id 1hKP2t-0000zL-BE; Sat, 27 Apr 2019 16:15:19 +0100
Received: from ben by deadeye with local (Exim 4.92)
        (envelope-from <ben@decadent.org.uk>)
        id 1hKP2o-0004eK-0L; Sat, 27 Apr 2019 16:15:14 +0100
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From:   Ben Hutchings <ben@decadent.org.uk>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
CC:     akpm@linux-foundation.org, Denis Kirjanov <kda@linux-powerpc.org>,
        "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>,
        "Marcel Holtmann" <marcel@holtmann.org>,
        "Johan Hedberg" <johan.hedberg@intel.com>
Date:   Sat, 27 Apr 2019 16:13:09 +0100
Message-ID: <lsq.1556377989.890299368@decadent.org.uk>
X-Mailer: LinuxStableQueue (scripts by bwh)
X-Patchwork-Hint: ignore
Subject: [PATCH 3.16 188/202] Bluetooth: Check L2CAP option sizes returned
 from l2cap_get_conf_opt
In-Reply-To: <lsq.1556377988.384060557@decadent.org.uk>
X-SA-Exim-Connect-IP: 192.168.4.242
X-SA-Exim-Mail-From: ben@decadent.org.uk
X-SA-Exim-Scanned: No (on shadbolt.decadent.org.uk); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

3.16.66-rc1 review patch.  If anyone has any objections, please let me know.

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
[bwh: Backported to 3.16: adjust context]
Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
---
 net/bluetooth/l2cap_core.c | 77 +++++++++++++++++++++++---------------
 1 file changed, 46 insertions(+), 31 deletions(-)

--- a/net/bluetooth/l2cap_core.c
+++ b/net/bluetooth/l2cap_core.c
@@ -3330,10 +3330,14 @@ static int l2cap_parse_conf_req(struct l
 
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
 
@@ -3341,26 +3345,30 @@ static int l2cap_parse_conf_req(struct l
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
 			if (!chan->conn->hs_enabled)
 				return -ECONNREFUSED;
-
 			set_bit(FLAG_EXT_CTRL, &chan->flags);
 			set_bit(CONF_EWS_RECV, &chan->conf_state);
 			chan->tx_win_max = L2CAP_DEFAULT_EXT_WINDOW;
@@ -3370,7 +3378,6 @@ static int l2cap_parse_conf_req(struct l
 		default:
 			if (hint)
 				break;
-
 			result = L2CAP_CONF_UNKNOWN;
 			*((u8 *) ptr++) = type;
 			break;
@@ -3540,55 +3547,60 @@ static int l2cap_parse_conf_rsp(struct l
 
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
@@ -3722,10 +3734,13 @@ static void l2cap_conf_rfc_get(struct l2
 
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

