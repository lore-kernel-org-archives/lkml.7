Return-Path: <SRS0=WcLH=XI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1E0E0C4CEC7
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Sep 2019 13:23:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E26AC20717
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Sep 2019 13:23:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1568381011;
	bh=Zop4+s4luVAimXt+InNTc/XmzvttpS21f21hxI/OF6I=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=DTYftpkVD39UxaQ3xJX4l8U9Q+DEFgeh2KGw2vFoFuBGI/FVjAmqA5l/cjZ3CzNfj
	 5GVg8zpP7xlBSn9hf3c4b5jHcX0jqMv7032+VPBHA7OzYiFlHC+3D69fpuJw/JLyol
	 dI+rlb4qfrx93IdR6ZppXu4hJOy0nhusvasBJJn8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390767AbfIMNVN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 13 Sep 2019 09:21:13 -0400
Received: from mail.kernel.org ([198.145.29.99]:50644 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2390755AbfIMNVK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Sep 2019 09:21:10 -0400
Received: from localhost (unknown [104.132.45.99])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2C930214DA;
        Fri, 13 Sep 2019 13:21:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1568380869;
        bh=Zop4+s4luVAimXt+InNTc/XmzvttpS21f21hxI/OF6I=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Y2fiHs07SZOusPQUubc9hgC+uyrAEVNAa5nUkrZxwPB31IOAOSSMMxrIoNc3rqZ4T
         ZepcUCWeKN4WD0VbNRK+VXQ88C0qNOg6ib3Kwo+y8inrh49df+W75k0Sbo1JzBhdeO
         mDOIbXORkzRdef3+9wwP3svqmcU1/v6WYZmE4kZI=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        syzbot+355cab184197dbbfa384@syzkaller.appspotmail.com,
        Sven Eckelmann <sven@narfation.org>,
        Antonio Quartulli <a@unstable.cc>,
        Simon Wunderlich <sw@simonwunderlich.de>
Subject: [PATCH 5.2 17/37] batman-adv: Only read OGM tvlv_len after buffer len check
Date:   Fri, 13 Sep 2019 14:07:22 +0100
Message-Id: <20190913130518.242128562@linuxfoundation.org>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20190913130510.727515099@linuxfoundation.org>
References: <20190913130510.727515099@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Sven Eckelmann <sven@narfation.org>

commit a15d56a60760aa9dbe26343b9a0ac5228f35d445 upstream.

Multiple batadv_ogm_packet can be stored in an skbuff. The functions
batadv_iv_ogm_send_to_if()/batadv_iv_ogm_receive() use
batadv_iv_ogm_aggr_packet() to check if there is another additional
batadv_ogm_packet in the skb or not before they continue processing the
packet.

The length for such an OGM is BATADV_OGM_HLEN +
batadv_ogm_packet->tvlv_len. The check must first check that at least
BATADV_OGM_HLEN bytes are available before it accesses tvlv_len (which is
part of the header. Otherwise it might try read outside of the currently
available skbuff to get the content of tvlv_len.

Fixes: ef26157747d4 ("batman-adv: tvlv - basic infrastructure")
Reported-by: syzbot+355cab184197dbbfa384@syzkaller.appspotmail.com
Signed-off-by: Sven Eckelmann <sven@narfation.org>
Acked-by: Antonio Quartulli <a@unstable.cc>
Signed-off-by: Simon Wunderlich <sw@simonwunderlich.de>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 net/batman-adv/bat_iv_ogm.c |   20 +++++++++++++-------
 1 file changed, 13 insertions(+), 7 deletions(-)

--- a/net/batman-adv/bat_iv_ogm.c
+++ b/net/batman-adv/bat_iv_ogm.c
@@ -277,17 +277,23 @@ static u8 batadv_hop_penalty(u8 tq, cons
  * batadv_iv_ogm_aggr_packet() - checks if there is another OGM attached
  * @buff_pos: current position in the skb
  * @packet_len: total length of the skb
- * @tvlv_len: tvlv length of the previously considered OGM
+ * @ogm_packet: potential OGM in buffer
  *
  * Return: true if there is enough space for another OGM, false otherwise.
  */
-static bool batadv_iv_ogm_aggr_packet(int buff_pos, int packet_len,
-				      __be16 tvlv_len)
+static bool
+batadv_iv_ogm_aggr_packet(int buff_pos, int packet_len,
+			  const struct batadv_ogm_packet *ogm_packet)
 {
 	int next_buff_pos = 0;
 
-	next_buff_pos += buff_pos + BATADV_OGM_HLEN;
-	next_buff_pos += ntohs(tvlv_len);
+	/* check if there is enough space for the header */
+	next_buff_pos += buff_pos + sizeof(*ogm_packet);
+	if (next_buff_pos > packet_len)
+		return false;
+
+	/* check if there is enough space for the optional TVLV */
+	next_buff_pos += ntohs(ogm_packet->tvlv_len);
 
 	return (next_buff_pos <= packet_len) &&
 	       (next_buff_pos <= BATADV_MAX_AGGREGATION_BYTES);
@@ -315,7 +321,7 @@ static void batadv_iv_ogm_send_to_if(str
 
 	/* adjust all flags and log packets */
 	while (batadv_iv_ogm_aggr_packet(buff_pos, forw_packet->packet_len,
-					 batadv_ogm_packet->tvlv_len)) {
+					 batadv_ogm_packet)) {
 		/* we might have aggregated direct link packets with an
 		 * ordinary base packet
 		 */
@@ -1704,7 +1710,7 @@ static int batadv_iv_ogm_receive(struct
 
 	/* unpack the aggregated packets and process them one by one */
 	while (batadv_iv_ogm_aggr_packet(ogm_offset, skb_headlen(skb),
-					 ogm_packet->tvlv_len)) {
+					 ogm_packet)) {
 		batadv_iv_ogm_process(skb, ogm_offset, if_incoming);
 
 		ogm_offset += BATADV_OGM_HLEN;


