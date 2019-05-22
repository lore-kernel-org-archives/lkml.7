Return-Path: <SRS0=sxVn=TW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CDAACC46470
	for <linux-kernel@archiver.kernel.org>; Wed, 22 May 2019 01:31:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9DFA12184B
	for <linux-kernel@archiver.kernel.org>; Wed, 22 May 2019 01:31:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="uUj7rxDs"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728155AbfEVBbJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 21 May 2019 21:31:09 -0400
Received: from mail-pl1-f194.google.com ([209.85.214.194]:38998 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727466AbfEVBbI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 May 2019 21:31:08 -0400
Received: by mail-pl1-f194.google.com with SMTP id g9so218360plm.6;
        Tue, 21 May 2019 18:31:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=voUaM+nc1xC7tzT8JvXDKzgRzz3E9tMoIw6zseuol2c=;
        b=uUj7rxDsVWUpN4VAP5HovKKg4zzF2wBTlBz8lDNC/E163XeAIvmc3k29dt/98Igsd3
         KYOrWtcobBBu5VvmsiLfMRymXVcK7fd5QHxPaDhOZwWhpUo5g1tEXaxMoOrU5g3X+N/V
         HAtI+Z0y08f0uHme1V6P8InYk/Y6rblP9mkaiOI0BzVtqKsCzuDOqvtOwQHKL+fcpXJa
         5rqRNf7Nk7aOzzz0KLyiDj03VKguAKmet4YAf3B9CzHU4DKNwNgC0eFZAe/G1sDaAHtw
         +n+wuMf1cncDnslLHyUQSXRnOcFQbrYJ7NGRKYNr4fo8wMXaNM758yoGfbj6+rzBlQ06
         B/sg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=voUaM+nc1xC7tzT8JvXDKzgRzz3E9tMoIw6zseuol2c=;
        b=dtOAJ+EZxTaw7Q4fTCy1VtTA9MOaZ4+KU1LvL4PZ9V45wdPjIx2+gC8P1mbqYyXSxo
         8vlUNe016Xa903rnFKtyhnEm4vNDle1TDFhNPr13E4qsireSQ3v4/R6QYEjmj407XSxT
         /LC1DbEf4ySYx3th9zScZeRnbYDMylYx7ndiPfpS5unBY1MKBQT5FjtVxNa0B2JSz1fp
         y+AK4/px/56MpNnEYTGxhKVQQc2iJYBGPW6cCnalUCYRl0Ms85juMZmteUp91G/Kosed
         7FxYYB+x2xYQsMkIWFBFxpTw4KSlqNoPh7LeXDru6Eby8mqqTwz11qGmWV3Zb9MRajqm
         M+DA==
X-Gm-Message-State: APjAAAU3SH1zmyiZNmgByFwT3khb9Dl3Xg/U9ha/QHikJV15PH65EDR8
        OQUcIhDviugxk4688OdhEz6qajIEuAE=
X-Google-Smtp-Source: APXvYqzBPBvvTt5Sj3WyNDdZjxmHUnwOS5vpNpyXnQESGkJFhCWIAV63UqgOD5saCJuBOvY1npDXzA==
X-Received: by 2002:a17:902:e683:: with SMTP id cn3mr64170053plb.86.1558488667451;
        Tue, 21 May 2019 18:31:07 -0700 (PDT)
Received: from localhost.lan (c-24-22-235-96.hsd1.wa.comcast.net. [24.22.235.96])
        by smtp.gmail.com with ESMTPSA id e184sm31781787pfa.169.2019.05.21.18.31.06
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 21 May 2019 18:31:06 -0700 (PDT)
From:   Andrey Smirnov <andrew.smirnov@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Cc:     Andrey Smirnov <andrew.smirnov@gmail.com>,
        "Pierre-Loup A . Griffais" <pgriffais@valvesoftware.com>,
        Florian Dollinger <dollinger.florian@gmx.de>,
        Marcel Holtmann <marcel@holtmann.org>,
        Johan Hedberg <johan.hedberg@gmail.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2] Bluetooth: Retry configure request if result is L2CAP_CONF_UNKNOWN
Date:   Tue, 21 May 2019 18:30:45 -0700
Message-Id: <20190522013045.21678-1-andrew.smirnov@gmail.com>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Due to:

 * Current implementation of l2cap_config_rsp() dropping BT
   connection if sender of configuration response replied with unknown
   option failure (Result=0x0003/L2CAP_CONF_UNKNOWN)

 * Current implementation of l2cap_build_conf_req() adding
   L2CAP_CONF_RFC(0x04) option to initial configure request sent by
   the Linux host.

devices that do no recongninze L2CAP_CONF_RFC, such as Xbox One S
controllers, will get stuck in endless connect -> configure ->
disconnect loop, never connect and be generaly unusable.

To avoid this problem add code to do the following:

 1. Parse the body of response L2CAP_CONF_UNKNOWN and, in case of
    unsupported option being RFC, clear L2CAP_FEAT_ERTM and
    L2CAP_FEAT_STREAMING from connection's feature mask (in order to
    prevent RFC option from being added going forward)

 2. Retry configuration step the same way it's done for
    L2CAP_CONF_UNACCEPT

Signed-off-by: Andrey Smirnov <andrew.smirnov@gmail.com>
Cc: Pierre-Loup A. Griffais <pgriffais@valvesoftware.com>
Cc: Florian Dollinger <dollinger.florian@gmx.de>
Cc: Marcel Holtmann <marcel@holtmann.org>
Cc: Johan Hedberg <johan.hedberg@gmail.com>
Cc: linux-bluetooth@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
---

Changes since [v1]:

   - Patch simplified to simply clear L2CAP_FEAT_ERTM |
     L2CAP_FEAT_STREAMING from feat_mask when device flags RFC options
     as unknown

[v1] lore.kernel.org/r/20190208025828.30901-1-andrew.smirnov@gmail.com

 net/bluetooth/l2cap_core.c | 59 ++++++++++++++++++++++++++++++++++++++
 1 file changed, 59 insertions(+)

diff --git a/net/bluetooth/l2cap_core.c b/net/bluetooth/l2cap_core.c
index b53acd6c9a3d..d5d682679128 100644
--- a/net/bluetooth/l2cap_core.c
+++ b/net/bluetooth/l2cap_core.c
@@ -4185,6 +4185,50 @@ static inline int l2cap_config_req(struct l2cap_conn *conn,
 	return err;
 }
 
+static inline int l2cap_config_rsp_unknown(struct l2cap_conn *conn,
+					   struct l2cap_chan *chan,
+					   const u8 *data,
+					   int len)
+{
+	int o;
+	char req[64];
+
+	if (!len || len > sizeof(req) -  sizeof(struct l2cap_conf_req))
+		return -ECONNRESET;
+
+	while (len--) {
+		const u8 option_type = *data++;
+
+		BT_DBG("chan %p, unknown option type: %u", chan,  option_type);
+
+		/* "...Hints shall not be included in the Response and
+		 * shall not be the sole cause for rejecting the
+		 * Request.."
+		 */
+		if (option_type & L2CAP_CONF_HINT)
+			return -ECONNRESET;
+
+		switch (option_type) {
+		case L2CAP_CONF_RFC:
+			/* Clearing the following feature should
+			 * prevent RFC option from being added next
+			 * connection attempt
+			 */
+			conn->feat_mask &= ~(L2CAP_FEAT_ERTM |
+					     L2CAP_FEAT_STREAMING);
+			break;
+		default:
+			return -ECONNRESET;
+		}
+	}
+
+	len = l2cap_build_conf_req(chan, req, sizeof(req));
+	l2cap_send_cmd(conn, l2cap_get_ident(conn), L2CAP_CONF_REQ, len, req);
+	chan->num_conf_req++;
+
+	return 0;
+}
+
 static inline int l2cap_config_rsp(struct l2cap_conn *conn,
 				   struct l2cap_cmd_hdr *cmd, u16 cmd_len,
 				   u8 *data)
@@ -4240,6 +4284,21 @@ static inline int l2cap_config_rsp(struct l2cap_conn *conn,
 		}
 		goto done;
 
+	case L2CAP_CONF_UNKNOWN:
+		if (chan->num_conf_rsp <= L2CAP_CONF_MAX_CONF_RSP) {
+			if (l2cap_config_rsp_unknown(conn, chan, rsp->data,
+						     len) < 0) {
+				l2cap_send_disconn_req(chan, ECONNRESET);
+				goto done;
+			}
+			break;
+		}
+		/* Once, chan->num_conf_rsp goes above
+		 * L2CAP_CONF_MAX_CONF_RSP we want to go down all the
+		 * way to default label (just like L2CAP_CONF_UNACCEPT
+		 * below)
+		 */
+		/* fall through */
 	case L2CAP_CONF_UNACCEPT:
 		if (chan->num_conf_rsp <= L2CAP_CONF_MAX_CONF_RSP) {
 			char req[64];
-- 
2.21.0

