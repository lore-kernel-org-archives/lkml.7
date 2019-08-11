Return-Path: <SRS0=XJun=WH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 87300C433FF
	for <linux-kernel@archiver.kernel.org>; Sun, 11 Aug 2019 23:07:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1F87A20818
	for <linux-kernel@archiver.kernel.org>; Sun, 11 Aug 2019 23:07:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=brennan.io header.i=stephen@brennan.io header.b="hvDNbhIN"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726668AbfHKXH3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 11 Aug 2019 19:07:29 -0400
Received: from sender4-of-o55.zoho.com ([136.143.188.55]:21566 "EHLO
        sender4-of-o55.zoho.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725730AbfHKXH1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 11 Aug 2019 19:07:27 -0400
X-Greylist: delayed 903 seconds by postgrey-1.27 at vger.kernel.org; Sun, 11 Aug 2019 19:07:20 EDT
ARC-Seal: i=1; a=rsa-sha256; t=1565563932; cv=none; 
        d=zoho.com; s=zohoarc; 
        b=KtwQ7S400YftPsSEoeHDjEdPiOSjFjnT0MZp3JVsJCd4J83yGt8FS3WIQ5uT4I9ojb7HKPFREOJnuKyl1jH4K0u95FaWwwod8KQPoO3opVGaRk0RGk7rdYIC5bNG5nZ9/cdL1b03g3Yj8IVcGR4NL8oycgxRPxN//gzHVNxh8NM=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zoho.com; s=zohoarc; 
        t=1565563932; h=Content-Type:Content-Transfer-Encoding:Cc:Date:From:MIME-Version:Message-ID:Subject:To:ARC-Authentication-Results; 
        bh=5UrGXTSVirBnpmuUe+bJlm3t3ONe5VYkTzebeuRPZ90=; 
        b=iOdhqugwnvHVT4OLphRF4XOgJDC1XCTpkhw+HKMLnoK+9P+v9IPIh3zvCvYluYWr4T6X1REZbk+dxjOw674oAdnHTx7hLNhqs3un3EYWMVbC6rf+LLYSzyY144QCda0ynHXXTR8+dxjn2+CX5I5UCbeGSXr6CX0kDNkpzGXj4Zo=
ARC-Authentication-Results: i=1; mx.zoho.com;
        dkim=pass  header.i=brennan.io;
        spf=pass  smtp.mailfrom=stephen@brennan.io;
        dmarc=pass header.from=<stephen@brennan.io> header.from=<stephen@brennan.io>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1565563932;
        s=selector01; d=brennan.io; i=stephen@brennan.io;
        h=From:To:Cc:Message-ID:Subject:Date:MIME-Version:Content-Transfer-Encoding:Content-Type;
        l=54557; bh=5UrGXTSVirBnpmuUe+bJlm3t3ONe5VYkTzebeuRPZ90=;
        b=hvDNbhINZLemIj4dw2vqzxDMOcLAlBNMJTgLbnEUbG+6mLgPfTdZdLWta3rO5Xbb
        QWQH30qlQrY01yLlMvWBP/MKCOmnUFJYNpLLH+t2tubLFfB0fqXjjWMQnjc1di2WZU9
        DotTgWYo85llLS5l4UBc6q2a+AON9EK3kdS6Youg=
Received: from localhost (c-73-241-204-195.hsd1.ca.comcast.net [73.241.204.195]) by mx.zohomail.com
        with SMTPS id 1565563931359824.390049096757; Sun, 11 Aug 2019 15:52:11 -0700 (PDT)
From:   Stephen Brennan <stephen@brennan.io>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org
Cc:     Stephen Brennan <stephen@brennan.io>
Message-ID: <20190811225120.7308-1-stephen@brennan.io>
Subject: [PATCH] staging: rtl8192u: fix spacing errors
Date:   Sun, 11 Aug 2019 15:51:20 -0700
X-Mailer: git-send-email 2.22.0
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-ZohoMailClient: External
Content-Type: text/plain; charset=utf8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Used checkpatch's --fix-inplace option for types SPACING, OPEN_BRACE,
ELSE_AFTER_BRACE. Manually edited the resulting changes to correct for
mistaken fixes and complete fixes that were only partially applied.

Signed-off-by: Stephen Brennan <stephen@brennan.io>
---

To prevent this patch from getting even longer and more unwieldy, I tried
to limit the scope of this change to *just* the automatic fixes created by
checkpatch, and my corrections. Hopefully I'll send further patches to
address categories of errors which were not automatically fixable by
checkpatch.

Before: 289 errors, 303 warnings, 206 checks, 2612 lines checked
After: 37 errors, 307 warnings, 175 checks, 2562 lines checked

 .../staging/rtl8192u/ieee80211/ieee80211_rx.c | 455 ++++++++----------
 1 file changed, 200 insertions(+), 255 deletions(-)

diff --git a/drivers/staging/rtl8192u/ieee80211/ieee80211_rx.c b/drivers/st=
aging/rtl8192u/ieee80211/ieee80211_rx.c
index 0a3e478fccd6..7ef1e89de269 100644
--- a/drivers/staging/rtl8192u/ieee80211/ieee80211_rx.c
+++ b/drivers/staging/rtl8192u/ieee80211/ieee80211_rx.c
@@ -124,7 +124,7 @@ ieee80211_frag_cache_get(struct ieee80211_device *ieee,
 =09=09=09=09    2 /* alignment */ +
 =09=09=09=09    8 /* WEP */ +
 =09=09=09=09    ETH_ALEN /* WDS */ +
-=09=09=09=09    (IEEE80211_QOS_HAS_SEQ(fc)?2:0) /* QOS Control */);
+=09=09=09=09    (IEEE80211_QOS_HAS_SEQ(fc) ? 2 : 0) /* QOS Control */);
 =09=09if (!skb)
 =09=09=09return NULL;
=20
@@ -145,7 +145,7 @@ ieee80211_frag_cache_get(struct ieee80211_device *ieee,
 =09} else {
 =09=09/* received a fragment of a frame for which the head fragment
 =09=09 * should have already been received */
-=09=09entry =3D ieee80211_frag_cache_find(ieee, seq, frag, tid,hdr->addr2,
+=09=09entry =3D ieee80211_frag_cache_find(ieee, seq, frag, tid, hdr->addr2=
,
 =09=09=09=09=09=09  hdr->addr1);
 =09=09if (entry) {
 =09=09=09entry->last_frag =3D frag;
@@ -169,7 +169,7 @@ static int ieee80211_frag_cache_invalidate(struct ieee8=
0211_device *ieee,
 =09struct rtl_80211_hdr_4addrqos *hdr_4addrqos;
 =09u8 tid;
=20
-=09if(((fc & IEEE80211_FCTL_DSTODS) =3D=3D IEEE80211_FCTL_DSTODS) && IEEE8=
0211_QOS_HAS_SEQ(fc)) {
+=09if (((fc & IEEE80211_FCTL_DSTODS) =3D=3D IEEE80211_FCTL_DSTODS) && IEEE=
80211_QOS_HAS_SEQ(fc)) {
 =09  hdr_4addrqos =3D (struct rtl_80211_hdr_4addrqos *)hdr;
 =09  tid =3D le16_to_cpu(hdr_4addrqos->qos_ctl) & IEEE80211_QCTL_TID;
 =09  tid =3D UP2AC(tid);
@@ -216,7 +216,7 @@ ieee80211_rx_frame_mgmt(struct ieee80211_device *ieee, =
struct sk_buff *skb,
 =09struct rtl_80211_hdr_3addr *hdr =3D (struct rtl_80211_hdr_3addr *)skb->=
data;
=20
 =09rx_stats->len =3D skb->len;
-=09ieee80211_rx_mgt(ieee,(struct rtl_80211_hdr_4addr *)skb->data,rx_stats)=
;
+=09ieee80211_rx_mgt(ieee, (struct rtl_80211_hdr_4addr *)skb->data, rx_stat=
s);
 =09/* if ((ieee->state =3D=3D IEEE80211_LINKED) && (memcmp(hdr->addr3, iee=
e->current_network.bssid, ETH_ALEN))) */
 =09if ((memcmp(hdr->addr1, ieee->dev->dev_addr, ETH_ALEN)))/* use ADDR1 to=
 perform address matching for Management frames */
 =09{
@@ -281,11 +281,11 @@ ieee80211_rx_frame_mgmt(struct ieee80211_device *ieee=
, struct sk_buff *skb,
=20
 /* See IEEE 802.1H for LLC/SNAP encapsulation/decapsulation */
 /* Ethernet-II snap header (RFC1042 for most EtherTypes) */
-static unsigned char rfc1042_header[] =3D
-{ 0xaa, 0xaa, 0x03, 0x00, 0x00, 0x00 };
+static unsigned char rfc1042_header[] =3D {
+=090xaa, 0xaa, 0x03, 0x00, 0x00, 0x00 };
 /* Bridge-Tunnel header (for EtherTypes ETH_P_AARP and ETH_P_IPX) */
-static unsigned char bridge_tunnel_header[] =3D
-{ 0xaa, 0xaa, 0x03, 0x00, 0x00, 0xf8 };
+static unsigned char bridge_tunnel_header[] =3D {
+=090xaa, 0xaa, 0x03, 0x00, 0x00, 0xf8 };
 /* No encapsulation header if EtherType < 0x600 (=3Dlength) */
=20
 /* Called by ieee80211_rx_frame_decrypt */
@@ -300,7 +300,7 @@ static int ieee80211_is_eapol_frame(struct ieee80211_de=
vice *ieee,
 =09if (skb->len < 24)
 =09=09return 0;
=20
-=09hdr =3D (struct rtl_80211_hdr_4addr *) skb->data;
+=09hdr =3D (struct rtl_80211_hdr_4addr *)skb->data;
 =09fc =3D le16_to_cpu(hdr->frame_ctl);
=20
 =09/* check that the frame is unicast frame to us */
@@ -341,10 +341,10 @@ ieee80211_rx_frame_decrypt(struct ieee80211_device *i=
eee, struct sk_buff *skb,
 =09=09return 0;
 =09if (ieee->hwsec_active)
 =09{
-=09=09struct cb_desc *tcb_desc =3D (struct cb_desc *)(skb->cb+ MAX_DEV_ADD=
R_SIZE);
+=09=09struct cb_desc *tcb_desc =3D (struct cb_desc *)(skb->cb + MAX_DEV_AD=
DR_SIZE);
 =09=09tcb_desc->bHwSec =3D 1;
 =09}
-=09hdr =3D (struct rtl_80211_hdr_4addr *) skb->data;
+=09hdr =3D (struct rtl_80211_hdr_4addr *)skb->data;
 =09hdrlen =3D ieee80211_get_hdrlen(le16_to_cpu(hdr->frame_ctl));
=20
 =09if (ieee->tkip_countermeasures &&
@@ -388,11 +388,11 @@ ieee80211_rx_frame_decrypt_msdu(struct ieee80211_devi=
ce *ieee, struct sk_buff *s
 =09=09return 0;
 =09if (ieee->hwsec_active)
 =09{
-=09=09struct cb_desc *tcb_desc =3D (struct cb_desc *)(skb->cb+ MAX_DEV_ADD=
R_SIZE);
+=09=09struct cb_desc *tcb_desc =3D (struct cb_desc *)(skb->cb + MAX_DEV_AD=
DR_SIZE);
 =09=09tcb_desc->bHwSec =3D 1;
 =09}
=20
-=09hdr =3D (struct rtl_80211_hdr_4addr *) skb->data;
+=09hdr =3D (struct rtl_80211_hdr_4addr *)skb->data;
 =09hdrlen =3D ieee80211_get_hdrlen(le16_to_cpu(hdr->frame_ctl));
=20
 =09atomic_inc(&crypt->refcnt);
@@ -410,7 +410,7 @@ ieee80211_rx_frame_decrypt_msdu(struct ieee80211_device=
 *ieee, struct sk_buff *s
=20
=20
 /* this function is stolen from ipw2200 driver*/
-#define IEEE_PACKET_RETRY_TIME (5*HZ)
+#define IEEE_PACKET_RETRY_TIME (5 * HZ)
 static int is_duplicate_packet(struct ieee80211_device *ieee,
 =09=09=09=09      struct rtl_80211_hdr_4addr *header)
 {
@@ -426,12 +426,12 @@ static int is_duplicate_packet(struct ieee80211_devic=
e *ieee,
=20
=20
 =09//TO2DS and QoS
-=09if(((fc & IEEE80211_FCTL_DSTODS) =3D=3D IEEE80211_FCTL_DSTODS) && IEEE8=
0211_QOS_HAS_SEQ(fc)) {
+=09if (((fc & IEEE80211_FCTL_DSTODS) =3D=3D IEEE80211_FCTL_DSTODS) && IEEE=
80211_QOS_HAS_SEQ(fc)) {
 =09  hdr_4addrqos =3D (struct rtl_80211_hdr_4addrqos *)header;
 =09  tid =3D le16_to_cpu(hdr_4addrqos->qos_ctl) & IEEE80211_QCTL_TID;
 =09  tid =3D UP2AC(tid);
 =09  tid++;
-=09} else if(IEEE80211_QOS_HAS_SEQ(fc)) { //QoS
+=09} else if (IEEE80211_QOS_HAS_SEQ(fc)) { //QoS
 =09  hdr_3addrqos =3D (struct rtl_80211_hdr_3addrqos *)header;
 =09  tid =3D le16_to_cpu(hdr_3addrqos->qos_ctl) & IEEE80211_QCTL_TID;
 =09  tid =3D UP2AC(tid);
@@ -507,7 +507,7 @@ static int is_duplicate_packet(struct ieee80211_device =
*ieee,
 static bool AddReorderEntry(struct rx_ts_record *pTS, struct rx_reorder_en=
try *pReorderEntry)
 {
 =09struct list_head *pList =3D &pTS->rx_pending_pkt_list;
-=09while(pList->next !=3D &pTS->rx_pending_pkt_list)
+=09while (pList->next !=3D &pTS->rx_pending_pkt_list)
 =09{
 =09=09if (SN_LESS(pReorderEntry->SeqNum, list_entry(pList->next, struct rx=
_reorder_entry, List)->SeqNum))
 =09=09=09pList =3D pList->next;
@@ -524,17 +524,17 @@ static bool AddReorderEntry(struct rx_ts_record *pTS,=
 struct rx_reorder_entry *p
 =09return true;
 }
=20
-void ieee80211_indicate_packets(struct ieee80211_device *ieee, struct ieee=
80211_rxb **prxbIndicateArray,u8  index)
+void ieee80211_indicate_packets(struct ieee80211_device *ieee, struct ieee=
80211_rxb **prxbIndicateArray, u8  index)
 {
-=09u8 i =3D 0 , j=3D0;
+=09u8 i =3D 0, j =3D 0;
 =09u16 ethertype;
 //=09if(index > 1)
 //=09=09IEEE80211_DEBUG(IEEE80211_DL_REORDER,"%s(): hahahahhhh, We indicat=
e packet from reorder list, index is %u\n",__func__,index);
-=09for(j =3D 0; j<index; j++)
+=09for (j =3D 0; j < index; j++)
 =09{
 //added by amy for reorder
 =09=09struct ieee80211_rxb *prxb =3D prxbIndicateArray[j];
-=09=09for(i =3D 0; i<prxb->nr_subframes; i++) {
+=09=09for (i =3D 0; i < prxb->nr_subframes; i++) {
 =09=09=09struct sk_buff *sub_skb =3D prxb->subframes[i];
=20
 =09=09/* convert hdr + possible LLC headers into Ethernet header */
@@ -585,7 +585,7 @@ static void RxReorderIndicatePacket(struct ieee80211_de=
vice *ieee,
 =09u16=09=09=09WinEnd =3D (pTS->rx_indicate_seq + WinSize - 1) % 4096;
 =09u8=09=09=09index =3D 0;
 =09bool=09=09=09bMatchWinStart =3D false, bPktInBuf =3D false;
-=09IEEE80211_DEBUG(IEEE80211_DL_REORDER,"%s(): Seq is %d,pTS->rx_indicate_=
seq is %d, WinSize is %d\n",__func__,SeqNum,pTS->rx_indicate_seq,WinSize);
+=09IEEE80211_DEBUG(IEEE80211_DL_REORDER, "%s(): Seq is %d,pTS->rx_indicate=
_seq is %d, WinSize is %d\n", __func__, SeqNum, pTS->rx_indicate_seq, WinSi=
ze);
=20
 =09prxbIndicateArray =3D kmalloc_array(REORDER_WIN_SIZE,
 =09=09=09=09=09  sizeof(struct ieee80211_rxb *),
@@ -599,12 +599,12 @@ static void RxReorderIndicatePacket(struct ieee80211_=
device *ieee,
=20
 =09/* Drop out the packet which SeqNum is smaller than WinStart */
 =09if (SN_LESS(SeqNum, pTS->rx_indicate_seq)) {
-=09=09IEEE80211_DEBUG(IEEE80211_DL_REORDER,"Packet Drop! IndicateSeq: %d, =
NewSeq: %d\n",
+=09=09IEEE80211_DEBUG(IEEE80211_DL_REORDER, "Packet Drop! IndicateSeq: %d,=
 NewSeq: %d\n",
 =09=09=09=09 pTS->rx_indicate_seq, SeqNum);
 =09=09pHTInfo->RxReorderDropCounter++;
 =09=09{
 =09=09=09int i;
-=09=09=09for(i =3D0; i < prxb->nr_subframes; i++) {
+=09=09=09for (i =3D 0; i < prxb->nr_subframes; i++) {
 =09=09=09=09dev_kfree_skb(prxb->subframes[i]);
 =09=09=09}
 =09=09=09kfree(prxb);
@@ -620,16 +620,16 @@ static void RxReorderIndicatePacket(struct ieee80211_=
device *ieee,
 =09 * 1. Incoming SeqNum is equal to WinStart =3D>Window shift 1
 =09 * 2. Incoming SeqNum is larger than the WinEnd =3D> Window shift N
 =09 */
-=09if(SN_EQUAL(SeqNum, pTS->rx_indicate_seq)) {
+=09if (SN_EQUAL(SeqNum, pTS->rx_indicate_seq)) {
 =09=09pTS->rx_indicate_seq =3D (pTS->rx_indicate_seq + 1) % 4096;
 =09=09bMatchWinStart =3D true;
-=09} else if(SN_LESS(WinEnd, SeqNum)) {
-=09=09if(SeqNum >=3D (WinSize - 1)) {
-=09=09=09pTS->rx_indicate_seq =3D SeqNum + 1 -WinSize;
+=09} else if (SN_LESS(WinEnd, SeqNum)) {
+=09=09if (SeqNum >=3D (WinSize - 1)) {
+=09=09=09pTS->rx_indicate_seq =3D SeqNum + 1 - WinSize;
 =09=09} else {
 =09=09=09pTS->rx_indicate_seq =3D 4095 - (WinSize - (SeqNum + 1)) + 1;
 =09=09}
-=09=09IEEE80211_DEBUG(IEEE80211_DL_REORDER, "Window Shift! IndicateSeq: %d=
, NewSeq: %d\n",pTS->rx_indicate_seq, SeqNum);
+=09=09IEEE80211_DEBUG(IEEE80211_DL_REORDER, "Window Shift! IndicateSeq: %d=
, NewSeq: %d\n", pTS->rx_indicate_seq, SeqNum);
 =09}
=20
 =09/*
@@ -641,7 +641,7 @@ static void RxReorderIndicatePacket(struct ieee80211_de=
vice *ieee,
 =09 * 1. All packets with SeqNum smaller than WinStart =3D> Indicate
 =09 * 2. All packets with SeqNum larger than or equal to WinStart =3D> Buf=
fer it.
 =09 */
-=09if(bMatchWinStart) {
+=09if (bMatchWinStart) {
 =09=09/* Current packet is going to be indicated.*/
 =09=09IEEE80211_DEBUG(IEEE80211_DL_REORDER, "Packets indication!! Indicate=
Seq: %d, NewSeq: %d\n",\
 =09=09=09=09pTS->rx_indicate_seq, SeqNum);
@@ -651,7 +651,7 @@ static void RxReorderIndicatePacket(struct ieee80211_de=
vice *ieee,
 =09} else {
 =09=09/* Current packet is going to be inserted into pending list.*/
 =09=09//IEEE80211_DEBUG(IEEE80211_DL_REORDER,"%s(): We RX no ordered packe=
d, insert to ordered list\n",__func__);
-=09=09if(!list_empty(&ieee->RxReorder_Unused_List)) {
+=09=09if (!list_empty(&ieee->RxReorder_Unused_List)) {
 =09=09=09pReorderEntry =3D list_entry(ieee->RxReorder_Unused_List.next, st=
ruct rx_reorder_entry, List);
 =09=09=09list_del_init(&pReorderEntry->List);
=20
@@ -660,13 +660,13 @@ static void RxReorderIndicatePacket(struct ieee80211_=
device *ieee,
 =09=09=09pReorderEntry->prxb =3D prxb;
 =09//=09=09IEEE80211_DEBUG(IEEE80211_DL_REORDER,"%s(): pREorderEntry->SeqN=
um is %d\n",__func__,pReorderEntry->SeqNum);
=20
-=09=09=09if(!AddReorderEntry(pTS, pReorderEntry)) {
+=09=09=09if (!AddReorderEntry(pTS, pReorderEntry)) {
 =09=09=09=09IEEE80211_DEBUG(IEEE80211_DL_REORDER, "%s(): Duplicate packet =
is dropped!! IndicateSeq: %d, NewSeq: %d\n",
 =09=09=09=09=09__func__, pTS->rx_indicate_seq, SeqNum);
-=09=09=09=09list_add_tail(&pReorderEntry->List,&ieee->RxReorder_Unused_Lis=
t);
+=09=09=09=09list_add_tail(&pReorderEntry->List, &ieee->RxReorder_Unused_Li=
st);
 =09=09=09=09{
 =09=09=09=09=09int i;
-=09=09=09=09=09for(i =3D0; i < prxb->nr_subframes; i++) {
+=09=09=09=09=09for (i =3D 0; i < prxb->nr_subframes; i++) {
 =09=09=09=09=09=09dev_kfree_skb(prxb->subframes[i]);
 =09=09=09=09=09}
 =09=09=09=09=09kfree(prxb);
@@ -674,10 +674,9 @@ static void RxReorderIndicatePacket(struct ieee80211_d=
evice *ieee,
 =09=09=09=09}
 =09=09=09} else {
 =09=09=09=09IEEE80211_DEBUG(IEEE80211_DL_REORDER,
-=09=09=09=09=09 "Pkt insert into buffer!! IndicateSeq: %d, NewSeq: %d\n",p=
TS->rx_indicate_seq, SeqNum);
+=09=09=09=09=09 "Pkt insert into buffer!! IndicateSeq: %d, NewSeq: %d\n", =
pTS->rx_indicate_seq, SeqNum);
 =09=09=09}
-=09=09}
-=09=09else {
+=09=09} else {
 =09=09=09/*
 =09=09=09 * Packets are dropped if there is not enough reorder entries.
 =09=09=09 * This part shall be modified!! We can just indicate all the
@@ -686,7 +685,7 @@ static void RxReorderIndicatePacket(struct ieee80211_de=
vice *ieee,
 =09=09=09IEEE80211_DEBUG(IEEE80211_DL_ERR, "RxReorderIndicatePacket(): The=
re is no reorder entry!! Packet is dropped!!\n");
 =09=09=09{
 =09=09=09=09int i;
-=09=09=09=09for(i =3D0; i < prxb->nr_subframes; i++) {
+=09=09=09=09for (i =3D 0; i < prxb->nr_subframes; i++) {
 =09=09=09=09=09dev_kfree_skb(prxb->subframes[i]);
 =09=09=09=09}
 =09=09=09=09kfree(prxb);
@@ -696,8 +695,8 @@ static void RxReorderIndicatePacket(struct ieee80211_de=
vice *ieee,
 =09}
=20
 =09/* Check if there is any packet need indicate.*/
-=09while(!list_empty(&pTS->rx_pending_pkt_list)) {
-=09=09IEEE80211_DEBUG(IEEE80211_DL_REORDER,"%s(): start RREORDER indicate\=
n",__func__);
+=09while (!list_empty(&pTS->rx_pending_pkt_list)) {
+=09=09IEEE80211_DEBUG(IEEE80211_DL_REORDER, "%s(): start RREORDER indicate=
\n", __func__);
 =09=09pReorderEntry =3D list_entry(pTS->rx_pending_pkt_list.prev, struct r=
x_reorder_entry, List);
 =09=09if (SN_LESS(pReorderEntry->SeqNum, pTS->rx_indicate_seq) ||
 =09=09    SN_EQUAL(pReorderEntry->SeqNum, pTS->rx_indicate_seq))
@@ -711,15 +710,15 @@ static void RxReorderIndicatePacket(struct ieee80211_=
device *ieee,
=20
 =09=09=09list_del_init(&pReorderEntry->List);
=20
-=09=09=09if(SN_EQUAL(pReorderEntry->SeqNum, pTS->rx_indicate_seq))
+=09=09=09if (SN_EQUAL(pReorderEntry->SeqNum, pTS->rx_indicate_seq))
 =09=09=09=09pTS->rx_indicate_seq =3D (pTS->rx_indicate_seq + 1) % 4096;
=20
-=09=09=09IEEE80211_DEBUG(IEEE80211_DL_REORDER,"Packets indication!! Indica=
teSeq: %d, NewSeq: %d\n",pTS->rx_indicate_seq, SeqNum);
+=09=09=09IEEE80211_DEBUG(IEEE80211_DL_REORDER, "Packets indication!! Indic=
ateSeq: %d, NewSeq: %d\n", pTS->rx_indicate_seq, SeqNum);
 =09=09=09prxbIndicateArray[index] =3D pReorderEntry->prxb;
 =09=09//=09printk("=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D>%s(): pReorderEntry->SeqNum is %d\n",__func__,pReorderEn=
try->SeqNum);
 =09=09=09index++;
=20
-=09=09=09list_add_tail(&pReorderEntry->List,&ieee->RxReorder_Unused_List);
+=09=09=09list_add_tail(&pReorderEntry->List, &ieee->RxReorder_Unused_List)=
;
 =09=09} else {
 =09=09=09bPktInBuf =3D true;
 =09=09=09break;
@@ -727,13 +726,13 @@ static void RxReorderIndicatePacket(struct ieee80211_=
device *ieee,
 =09}
=20
 =09/* Handling pending timer. Set this timer to prevent from long time Rx =
buffering.*/
-=09if (index>0) {
+=09if (index > 0) {
 =09=09// Cancel previous pending timer.
 =09//=09del_timer_sync(&pTS->rx_pkt_pending_timer);
 =09=09pTS->rx_timeout_indicate_seq =3D 0xffff;
=20
 =09=09// Indicate packets
-=09=09if(index>REORDER_WIN_SIZE){
+=09=09if (index > REORDER_WIN_SIZE) {
 =09=09=09IEEE80211_DEBUG(IEEE80211_DL_ERR, "RxReorderIndicatePacket(): Rx =
Reorder buffer full!! \n");
 =09=09=09kfree(prxbIndicateArray);
 =09=09=09return;
@@ -743,9 +742,9 @@ static void RxReorderIndicatePacket(struct ieee80211_de=
vice *ieee,
=20
 =09if (bPktInBuf && pTS->rx_timeout_indicate_seq =3D=3D 0xffff) {
 =09=09// Set new pending timer.
-=09=09IEEE80211_DEBUG(IEEE80211_DL_REORDER,"%s(): SET rx timeout timer\n",=
 __func__);
+=09=09IEEE80211_DEBUG(IEEE80211_DL_REORDER, "%s(): SET rx timeout timer\n"=
, __func__);
 =09=09pTS->rx_timeout_indicate_seq =3D pTS->rx_indicate_seq;
-=09=09if(timer_pending(&pTS->rx_pkt_pending_timer))
+=09=09if (timer_pending(&pTS->rx_pkt_pending_timer))
 =09=09=09del_timer_sync(&pTS->rx_pkt_pending_timer);
 =09=09pTS->rx_pkt_pending_timer.expires =3D jiffies +
 =09=09=09=09msecs_to_jiffies(pHTInfo->RxReorderPendingTime);
@@ -762,12 +761,12 @@ static u8 parse_subframe(struct sk_buff *skb,
 =09struct rtl_80211_hdr_3addr  *hdr =3D (struct rtl_80211_hdr_3addr *)skb-=
>data;
 =09u16=09=09fc =3D le16_to_cpu(hdr->frame_ctl);
=20
-=09u16=09=09LLCOffset=3D sizeof(struct rtl_80211_hdr_3addr);
+=09u16=09=09LLCOffset =3D sizeof(struct rtl_80211_hdr_3addr);
 =09u16=09=09ChkLength;
 =09bool=09=09bIsAggregateFrame =3D false;
 =09u16=09=09nSubframe_Length;
 =09u8=09=09nPadding_Length =3D 0;
-=09u16=09=09SeqNum=3D0;
+=09u16=09=09SeqNum =3D 0;
=20
 =09struct sk_buff *sub_skb;
 =09/* just for debug purpose */
@@ -793,7 +792,7 @@ static u8 parse_subframe(struct sk_buff *skb,
=20
 =09skb_pull(skb, LLCOffset);
=20
-=09if(!bIsAggregateFrame) {
+=09if (!bIsAggregateFrame) {
 =09=09rxb->nr_subframes =3D 1;
 #ifdef JOHN_NOCPY
 =09=09rxb->subframes[0] =3D skb;
@@ -801,26 +800,26 @@ static u8 parse_subframe(struct sk_buff *skb,
 =09=09rxb->subframes[0] =3D skb_copy(skb, GFP_ATOMIC);
 #endif
=20
-=09=09memcpy(rxb->src,src,ETH_ALEN);
-=09=09memcpy(rxb->dst,dst,ETH_ALEN);
+=09=09memcpy(rxb->src, src, ETH_ALEN);
+=09=09memcpy(rxb->dst, dst, ETH_ALEN);
 =09=09//IEEE80211_DEBUG_DATA(IEEE80211_DL_RX,skb->data,skb->len);
 =09=09return 1;
 =09} else {
 =09=09rxb->nr_subframes =3D 0;
-=09=09memcpy(rxb->src,src,ETH_ALEN);
-=09=09memcpy(rxb->dst,dst,ETH_ALEN);
-=09=09while(skb->len > ETHERNET_HEADER_SIZE) {
+=09=09memcpy(rxb->src, src, ETH_ALEN);
+=09=09memcpy(rxb->dst, dst, ETH_ALEN);
+=09=09while (skb->len > ETHERNET_HEADER_SIZE) {
 =09=09=09/* Offset 12 denote 2 mac address */
 =09=09=09nSubframe_Length =3D *((u16 *)(skb->data + 12));
 =09=09=09//=3D=3Dm=3D=3D>change the length order
-=09=09=09nSubframe_Length =3D (nSubframe_Length>>8) + (nSubframe_Length<<8=
);
+=09=09=09nSubframe_Length =3D (nSubframe_Length >> 8) + (nSubframe_Length =
<< 8);
=20
-=09=09=09if (skb->len<(ETHERNET_HEADER_SIZE + nSubframe_Length)) {
+=09=09=09if (skb->len < (ETHERNET_HEADER_SIZE + nSubframe_Length)) {
 =09=09=09=09printk("%s: A-MSDU parse error!! pRfd->nTotalSubframe : %d\n",=
\
 =09=09=09=09=09=09__func__, rxb->nr_subframes);
-=09=09=09=09printk("%s: A-MSDU parse error!! Subframe Length: %d\n",__func=
__, nSubframe_Length);
-=09=09=09=09printk("nRemain_Length is %d and nSubframe_Length is : %d\n",s=
kb->len,nSubframe_Length);
-=09=09=09=09printk("The Packet SeqNum is %d\n",SeqNum);
+=09=09=09=09printk("%s: A-MSDU parse error!! Subframe Length: %d\n", __fun=
c__, nSubframe_Length);
+=09=09=09=09printk("nRemain_Length is %d and nSubframe_Length is : %d\n", =
skb->len, nSubframe_Length);
+=09=09=09=09printk("The Packet SeqNum is %d\n", SeqNum);
 =09=09=09=09return 0;
 =09=09=09}
=20
@@ -925,7 +924,7 @@ int ieee80211_rx(struct ieee80211_device *ieee, struct =
sk_buff *skb,
=20
 =09if (HTCCheck(ieee, skb->data))
 =09{
-=09=09if(net_ratelimit())
+=09=09if (net_ratelimit())
 =09=09=09printk("find HTCControl\n");
 =09=09hdrlen +=3D 4;
 =09=09rx_stats->bContainHTC =3D true;
@@ -972,7 +971,7 @@ int ieee80211_rx(struct ieee80211_device *ieee, struct =
sk_buff *skb,
 =09=09 * stations that do not support WEP key mapping). */
=20
 =09=09if (!(hdr->addr1[0] & 0x01) || local->bcrx_sta_key)
-=09=09=09(void) hostap_handle_sta_crypto(local, hdr, &crypt,
+=09=09=09(void)hostap_handle_sta_crypto(local, hdr, &crypt,
 =09=09=09=09=09=09=09&sta);
 #endif
=20
@@ -998,18 +997,16 @@ int ieee80211_rx(struct ieee80211_device *ieee, struc=
t sk_buff *skb,
 =09=09goto rx_dropped;
=20
 =09// if QoS enabled, should check the sequence for each of the AC
-=09if ((!ieee->pHTInfo->bCurRxReorderEnable) || !ieee->current_network.qos=
_data.active|| !IsDataFrame(skb->data) || IsLegacyDataFrame(skb->data)) {
+=09if ((!ieee->pHTInfo->bCurRxReorderEnable) || !ieee->current_network.qos=
_data.active || !IsDataFrame(skb->data) || IsLegacyDataFrame(skb->data)) {
 =09=09if (is_duplicate_packet(ieee, hdr))
 =09=09goto rx_dropped;
=20
-=09}
-=09else
-=09{
+=09} else {
 =09=09struct rx_ts_record *pRxTS =3D NULL;
 =09=09=09//IEEE80211_DEBUG(IEEE80211_DL_REORDER,"%s(): QOS ENABLE AND RECE=
IVE QOS DATA , we will get Ts, tid:%d\n",__func__, tid);
-=09=09if(GetTs(
+=09=09if (GetTs(
 =09=09=09=09ieee,
-=09=09=09=09(struct ts_common_info **) &pRxTS,
+=09=09=09=09(struct ts_common_info **)&pRxTS,
 =09=09=09=09hdr->addr2,
 =09=09=09=09Frame_QoSTID((u8 *)(skb->data)),
 =09=09=09=09RX_DIR,
@@ -1017,20 +1014,16 @@ int ieee80211_rx(struct ieee80211_device *ieee, str=
uct sk_buff *skb,
 =09=09{
=20
 =09=09//=09IEEE80211_DEBUG(IEEE80211_DL_REORDER,"%s(): pRxTS->rx_last_frag=
_num is %d,frag is %d,pRxTS->rx_last_seq_num is %d,seq is %d\n",__func__,pR=
xTS->rx_last_frag_num,frag,pRxTS->rx_last_seq_num,WLAN_GET_SEQ_SEQ(sc));
-=09=09=09if ((fc & (1<<11)) &&
+=09=09=09if ((fc & (1 << 11)) &&
 =09=09=09    (frag =3D=3D pRxTS->rx_last_frag_num) &&
 =09=09=09    (WLAN_GET_SEQ_SEQ(sc) =3D=3D pRxTS->rx_last_seq_num)) {
 =09=09=09=09goto rx_dropped;
-=09=09=09}
-=09=09=09else
-=09=09=09{
+=09=09=09} else {
 =09=09=09=09pRxTS->rx_last_frag_num =3D frag;
 =09=09=09=09pRxTS->rx_last_seq_num =3D WLAN_GET_SEQ_SEQ(sc);
 =09=09=09}
-=09=09}
-=09=09else
-=09=09{
-=09=09=09IEEE80211_DEBUG(IEEE80211_DL_ERR, "%s(): No TS!! Skip the check!!=
\n",__func__);
+=09=09} else {
+=09=09=09IEEE80211_DEBUG(IEEE80211_DL_ERR, "%s(): No TS!! Skip the check!!=
\n", __func__);
 =09=09=09goto rx_dropped;
 =09=09}
 =09}
@@ -1133,7 +1126,7 @@ int ieee80211_rx(struct ieee80211_device *ieee, struc=
t sk_buff *skb,
 =09}
=20
=20
-=09hdr =3D (struct rtl_80211_hdr_4addr *) skb->data;
+=09hdr =3D (struct rtl_80211_hdr_4addr *)skb->data;
=20
 =09/* skb: hdr + (possibly fragmented) plaintext payload */
 =09// PR: FIXME: hostap has additional conditions in the "if" below:
@@ -1185,7 +1178,7 @@ int ieee80211_rx(struct ieee80211_device *ieee, struc=
t sk_buff *skb,
 =09=09/* this was the last fragment and the frame will be
 =09=09 * delivered, so remove skb from fragment cache */
 =09=09skb =3D frag_skb;
-=09=09hdr =3D (struct rtl_80211_hdr_4addr *) skb->data;
+=09=09hdr =3D (struct rtl_80211_hdr_4addr *)skb->data;
 =09=09ieee80211_frag_cache_invalidate(ieee, hdr);
 =09}
=20
@@ -1202,7 +1195,7 @@ int ieee80211_rx(struct ieee80211_device *ieee, struc=
t sk_buff *skb,
 =09ieee->LinkDetectInfo.NumRecvDataInPeriod++;
 =09ieee->LinkDetectInfo.NumRxOkInPeriod++;
=20
-=09hdr =3D (struct rtl_80211_hdr_4addr *) skb->data;
+=09hdr =3D (struct rtl_80211_hdr_4addr *)skb->data;
 =09if (crypt && !(fc & IEEE80211_FCTL_WEP) && !ieee->open_wep) {
 =09=09if (/*ieee->ieee802_1x &&*/
 =09=09    ieee80211_is_eapol_frame(ieee, skb, hdrlen)) {
@@ -1254,8 +1247,8 @@ int ieee80211_rx(struct ieee80211_device *ieee, struc=
t sk_buff *skb,
 =09{
 =09=09TID =3D Frame_QoSTID(skb->data);
 =09=09SeqNum =3D WLAN_GET_SEQ_SEQ(sc);
-=09=09GetTs(ieee,(struct ts_common_info **) &pTS,hdr->addr2,TID,RX_DIR,tru=
e);
-=09=09if (TID !=3D0 && TID !=3D3)
+=09=09GetTs(ieee, (struct ts_common_info **) &pTS, hdr->addr2, TID, RX_DIR=
, true);
+=09=09if (TID !=3D 0 && TID !=3D 3)
 =09=09{
 =09=09=09ieee->bis_any_nonbepkts =3D true;
 =09=09}
@@ -1270,7 +1263,7 @@ int ieee80211_rx(struct ieee80211_device *ieee, struc=
t sk_buff *skb,
 =09/* qos data packets & reserved bit is 1 */
 =09if (parse_subframe(skb, rx_stats, rxb, src, dst) =3D=3D 0) {
 =09=09/* only to free rxb, and not submit the packets to upper layer */
-=09=09for(i =3D0; i < rxb->nr_subframes; i++) {
+=09=09for (i =3D 0; i < rxb->nr_subframes; i++) {
 =09=09=09dev_kfree_skb(rxb->subframes[i]);
 =09=09}
 =09=09kfree(rxb);
@@ -1281,7 +1274,7 @@ int ieee80211_rx(struct ieee80211_device *ieee, struc=
t sk_buff *skb,
 //added by amy for reorder
 =09if (!ieee->pHTInfo->bCurRxReorderEnable || !pTS) {
 //added by amy for reorder
-=09=09for(i =3D 0; i<rxb->nr_subframes; i++) {
+=09=09for (i =3D 0; i < rxb->nr_subframes; i++) {
 =09=09=09struct sk_buff *sub_skb =3D rxb->subframes[i];
=20
 =09=09=09if (sub_skb) {
@@ -1324,10 +1317,8 @@ int ieee80211_rx(struct ieee80211_device *ieee, stru=
ct sk_buff *skb,
 =09=09kfree(rxb);
 =09=09rxb =3D NULL;
=20
-=09}
-=09else
-=09{
-=09=09IEEE80211_DEBUG(IEEE80211_DL_REORDER,"%s(): REORDER ENABLE AND PTS n=
ot NULL, and we will enter RxReorderIndicatePacket()\n",__func__);
+=09} else {
+=09=09IEEE80211_DEBUG(IEEE80211_DL_REORDER, "%s(): REORDER ENABLE AND PTS =
not NULL, and we will enter RxReorderIndicatePacket()\n", __func__);
 =09=09RxReorderIndicatePacket(ieee, rxb, pTS, SeqNum);
 =09}
 #ifndef JOHN_NOCPY
@@ -1407,10 +1398,9 @@ static int ieee80211_read_qos_param_element(struct i=
eee80211_qos_parameter_info
 /*
  * Parse a QoS information element
  */
-static int ieee80211_read_qos_info_element(struct
-=09=09=09=09=09   ieee80211_qos_information_element
-=09=09=09=09=09   *element_info, struct ieee80211_info_element
-=09=09=09=09=09   *info_element)
+static int ieee80211_read_qos_info_element(
+=09=09struct ieee80211_qos_information_element *element_info,
+=09=09struct ieee80211_info_element *info_element)
 {
 =09int ret =3D 0;
 =09u16 size =3D sizeof(struct ieee80211_qos_information_element) - 2;
@@ -1438,11 +1428,9 @@ static int ieee80211_read_qos_info_element(struct
 /*
  * Write QoS parameters from the ac parameters.
  */
-static int ieee80211_qos_convert_ac_to_parameters(struct
-=09=09=09=09=09=09  ieee80211_qos_parameter_info
-=09=09=09=09=09=09  *param_elm, struct
-=09=09=09=09=09=09  ieee80211_qos_parameters
-=09=09=09=09=09=09  *qos_param)
+static int ieee80211_qos_convert_ac_to_parameters(
+=09=09struct ieee80211_qos_parameter_info *param_elm,
+=09=09struct ieee80211_qos_parameters *qos_param)
 {
 =09int i;
 =09struct ieee80211_qos_ac_parameter *ac_params;
@@ -1455,12 +1443,12 @@ static int ieee80211_qos_convert_ac_to_parameters(s=
truct
=20
 =09=09aci =3D (ac_params->aci_aifsn & 0x60) >> 5;
=20
-=09=09if(aci >=3D QOS_QUEUE_NUM)
+=09=09if (aci >=3D QOS_QUEUE_NUM)
 =09=09=09continue;
 =09=09qos_param->aifs[aci] =3D (ac_params->aci_aifsn) & 0x0f;
=20
 =09=09/* WMM spec P.11: The minimum value for AIFSN shall be 2 */
-=09=09qos_param->aifs[aci] =3D (qos_param->aifs[aci] < 2) ? 2:qos_param->a=
ifs[aci];
+=09=09qos_param->aifs[aci] =3D (qos_param->aifs[aci] < 2) ? 2 : qos_param-=
>aifs[aci];
=20
 =09=09qos_param->cw_min[aci] =3D
 =09=09    cpu_to_le16(ac_params->ecw_min_max & 0x0F);
@@ -1563,7 +1551,7 @@ static inline void ieee80211_extract_country_ie(
 {
 =09if (IS_DOT11D_ENABLE(ieee))
 =09{
-=09=09if (info_element->len!=3D 0)
+=09=09if (info_element->len !=3D 0)
 =09=09{
 =09=09=09memcpy(network->CountryIeBuf, info_element->data, info_element->l=
en);
 =09=09=09network->CountryIeLen =3D info_element->len;
@@ -1579,7 +1567,7 @@ static inline void ieee80211_extract_country_ie(
 =09=09// some AP (e.g. Cisco 1242) don't include country IE in their
 =09=09// probe response frame.
 =09=09//
-=09=09if (IS_EQUAL_CIE_SRC(ieee, addr2) )
+=09=09if (IS_EQUAL_CIE_SRC(ieee, addr2))
 =09=09{
 =09=09=09UPDATE_CIE_WATCHDOG(ieee);
 =09=09}
@@ -1595,9 +1583,9 @@ int ieee80211_parse_info_param(struct ieee80211_devic=
e *ieee,
 {
 =09u8 i;
 =09short offset;
-=09u16=09tmp_htcap_len=3D0;
-=09u16=09tmp_htinfo_len=3D0;
-=09u16 ht_realtek_agg_len=3D0;
+=09u16=09tmp_htcap_len =3D 0;
+=09u16=09tmp_htinfo_len =3D 0;
+=09u16 ht_realtek_agg_len =3D 0;
 =09u8  ht_realtek_agg_buf[MAX_IE_LEN];
 //=09u16 broadcom_len =3D 0;
 #ifdef CONFIG_IEEE80211_DEBUG
@@ -1628,7 +1616,7 @@ int ieee80211_parse_info_param(struct ieee80211_devic=
e *ieee,
 =09=09=09}
=20
 =09=09=09network->ssid_len =3D min(info_element->len,
-=09=09=09=09=09=09(u8) IW_ESSID_MAX_SIZE);
+=09=09=09=09=09=09(u8)IW_ESSID_MAX_SIZE);
 =09=09=09memcpy(network->ssid, info_element->data, network->ssid_len);
 =09=09=09if (network->ssid_len < IW_ESSID_MAX_SIZE)
 =09=09=09=09memset(network->ssid + network->ssid_len, 0,
@@ -1707,14 +1695,14 @@ int ieee80211_parse_info_param(struct ieee80211_dev=
ice *ieee,
 =09=09=09break;
=20
 =09=09case MFIE_TYPE_TIM:
-=09=09=09if(info_element->len < 4)
+=09=09=09if (info_element->len < 4)
 =09=09=09=09break;
=20
 =09=09=09network->tim.tim_count =3D info_element->data[0];
 =09=09=09network->tim.tim_period =3D info_element->data[1];
=20
 =09=09=09network->dtim_period =3D info_element->data[1];
-=09=09=09if(ieee->state !=3D IEEE80211_LINKED)
+=09=09=09if (ieee->state !=3D IEEE80211_LINKED)
 =09=09=09=09break;
=20
 =09=09=09network->last_dtim_sta_time[0] =3D stats->mac_time[0];
@@ -1722,22 +1710,22 @@ int ieee80211_parse_info_param(struct ieee80211_dev=
ice *ieee,
=20
 =09=09=09network->dtim_data =3D IEEE80211_DTIM_VALID;
=20
-=09=09=09if(info_element->data[0] !=3D 0)
+=09=09=09if (info_element->data[0] !=3D 0)
 =09=09=09=09break;
=20
-=09=09=09if(info_element->data[2] & 1)
+=09=09=09if (info_element->data[2] & 1)
 =09=09=09=09network->dtim_data |=3D IEEE80211_DTIM_MBCAST;
=20
-=09=09=09offset =3D (info_element->data[2] >> 1)*2;
+=09=09=09offset =3D (info_element->data[2] >> 1) * 2;
=20
-=09=09=09if(ieee->assoc_id < 8*offset ||
-=09=09=09=09ieee->assoc_id > 8*(offset + info_element->len -3))
+=09=09=09if (ieee->assoc_id < 8 * offset ||
+=09=09=09=09ieee->assoc_id > 8 * (offset + info_element->len - 3))
=20
 =09=09=09=09break;
=20
 =09=09=09offset =3D (ieee->assoc_id / 8) - offset;// + ((aid % 8)? 0 : 1) =
;
=20
-=09=09=09if(info_element->data[3+offset] & (1<<(ieee->assoc_id%8)))
+=09=09=09if (info_element->data[3 + offset] & (1 << (ieee->assoc_id % 8)))
 =09=09=09=09network->dtim_data |=3D IEEE80211_DTIM_UCAST;
=20
 =09=09=09//IEEE80211_DEBUG_MGMT("MFIE_TYPE_TIM: partially ignored\n");
@@ -1790,42 +1778,42 @@ int ieee80211_parse_info_param(struct ieee80211_dev=
ice *ieee,
 #endif
=20
 =09=09=09//for HTcap and HTinfo parameters
-=09=09=09if(tmp_htcap_len =3D=3D 0){
-=09=09=09=09if(info_element->len >=3D 4 &&
+=09=09=09if (tmp_htcap_len =3D=3D 0) {
+=09=09=09=09if (info_element->len >=3D 4 &&
 =09=09=09=09   info_element->data[0] =3D=3D 0x00 &&
 =09=09=09=09   info_element->data[1] =3D=3D 0x90 &&
 =09=09=09=09   info_element->data[2] =3D=3D 0x4c &&
 =09=09=09=09   info_element->data[3] =3D=3D 0x033){
=20
-=09=09=09=09=09=09tmp_htcap_len =3D min(info_element->len,(u8)MAX_IE_LEN);
-=09=09=09=09=09=09if(tmp_htcap_len !=3D 0){
+=09=09=09=09=09=09tmp_htcap_len =3D min(info_element->len, (u8)MAX_IE_LEN)=
;
+=09=09=09=09=09=09if (tmp_htcap_len !=3D 0) {
 =09=09=09=09=09=09=09network->bssht.bdHTSpecVer =3D HT_SPEC_VER_EWC;
-=09=09=09=09=09=09=09network->bssht.bdHTCapLen =3D tmp_htcap_len > sizeof(=
network->bssht.bdHTCapBuf)?\
-=09=09=09=09=09=09=09=09sizeof(network->bssht.bdHTCapBuf):tmp_htcap_len;
-=09=09=09=09=09=09=09memcpy(network->bssht.bdHTCapBuf,info_element->data,n=
etwork->bssht.bdHTCapLen);
+=09=09=09=09=09=09=09network->bssht.bdHTCapLen =3D tmp_htcap_len > sizeof(=
network->bssht.bdHTCapBuf) ? \
+=09=09=09=09=09=09=09=09sizeof(network->bssht.bdHTCapBuf) : tmp_htcap_len;
+=09=09=09=09=09=09=09memcpy(network->bssht.bdHTCapBuf, info_element->data,=
 network->bssht.bdHTCapLen);
 =09=09=09=09=09=09}
 =09=09=09=09}
-=09=09=09=09if(tmp_htcap_len !=3D 0)
+=09=09=09=09if (tmp_htcap_len !=3D 0)
 =09=09=09=09=09network->bssht.bdSupportHT =3D true;
 =09=09=09=09else
 =09=09=09=09=09network->bssht.bdSupportHT =3D false;
 =09=09=09}
=20
=20
-=09=09=09if(tmp_htinfo_len =3D=3D 0){
-=09=09=09=09if(info_element->len >=3D 4 &&
+=09=09=09if (tmp_htinfo_len =3D=3D 0) {
+=09=09=09=09if (info_element->len >=3D 4 &&
 =09=09=09=09=09info_element->data[0] =3D=3D 0x00 &&
 =09=09=09=09=09info_element->data[1] =3D=3D 0x90 &&
 =09=09=09=09=09info_element->data[2] =3D=3D 0x4c &&
 =09=09=09=09=09info_element->data[3] =3D=3D 0x034){
=20
-=09=09=09=09=09=09tmp_htinfo_len =3D min(info_element->len,(u8)MAX_IE_LEN)=
;
-=09=09=09=09=09=09if(tmp_htinfo_len !=3D 0){
+=09=09=09=09=09=09tmp_htinfo_len =3D min(info_element->len, (u8)MAX_IE_LEN=
);
+=09=09=09=09=09=09if (tmp_htinfo_len !=3D 0) {
 =09=09=09=09=09=09=09network->bssht.bdHTSpecVer =3D HT_SPEC_VER_EWC;
-=09=09=09=09=09=09=09if(tmp_htinfo_len){
-=09=09=09=09=09=09=09=09network->bssht.bdHTInfoLen =3D tmp_htinfo_len > si=
zeof(network->bssht.bdHTInfoBuf)?\
-=09=09=09=09=09=09=09=09=09sizeof(network->bssht.bdHTInfoBuf):tmp_htinfo_l=
en;
-=09=09=09=09=09=09=09=09memcpy(network->bssht.bdHTInfoBuf,info_element->da=
ta,network->bssht.bdHTInfoLen);
+=09=09=09=09=09=09=09if (tmp_htinfo_len) {
+=09=09=09=09=09=09=09=09network->bssht.bdHTInfoLen =3D tmp_htinfo_len > si=
zeof(network->bssht.bdHTInfoBuf) ? \
+=09=09=09=09=09=09=09=09=09sizeof(network->bssht.bdHTInfoBuf) : tmp_htinfo=
_len;
+=09=09=09=09=09=09=09=09memcpy(network->bssht.bdHTInfoBuf, info_element->d=
ata, network->bssht.bdHTInfoLen);
 =09=09=09=09=09=09=09}
=20
 =09=09=09=09=09=09}
@@ -1833,22 +1821,22 @@ int ieee80211_parse_info_param(struct ieee80211_dev=
ice *ieee,
 =09=09=09=09}
 =09=09=09}
=20
-=09=09=09if(ieee->aggregation){
-=09=09=09=09if(network->bssht.bdSupportHT){
-=09=09=09=09=09if(info_element->len >=3D 4 &&
+=09=09=09if (ieee->aggregation) {
+=09=09=09=09if (network->bssht.bdSupportHT) {
+=09=09=09=09=09if (info_element->len >=3D 4 &&
 =09=09=09=09=09=09info_element->data[0] =3D=3D 0x00 &&
 =09=09=09=09=09=09info_element->data[1] =3D=3D 0xe0 &&
 =09=09=09=09=09=09info_element->data[2] =3D=3D 0x4c &&
 =09=09=09=09=09=09info_element->data[3] =3D=3D 0x02){
=20
-=09=09=09=09=09=09ht_realtek_agg_len =3D min(info_element->len,(u8)MAX_IE_=
LEN);
-=09=09=09=09=09=09memcpy(ht_realtek_agg_buf,info_element->data,info_elemen=
t->len);
+=09=09=09=09=09=09ht_realtek_agg_len =3D min(info_element->len, (u8)MAX_IE=
_LEN);
+=09=09=09=09=09=09memcpy(ht_realtek_agg_buf, info_element->data, info_elem=
ent->len);
=20
 =09=09=09=09=09}
-=09=09=09=09=09if(ht_realtek_agg_len >=3D 5){
+=09=09=09=09=09if (ht_realtek_agg_len >=3D 5) {
 =09=09=09=09=09=09network->bssht.bdRT2RTAggregation =3D true;
=20
-=09=09=09=09=09=09if((ht_realtek_agg_buf[4] =3D=3D 1) && (ht_realtek_agg_b=
uf[5] & 0x02))
+=09=09=09=09=09=09if ((ht_realtek_agg_buf[4] =3D=3D 1) && (ht_realtek_agg_=
buf[5] & 0x02))
 =09=09=09=09=09=09network->bssht.bdRT2RTLongSlotTime =3D true;
 =09=09=09=09=09}
 =09=09=09=09}
@@ -1874,17 +1862,16 @@ int ieee80211_parse_info_param(struct ieee80211_dev=
ice *ieee,
=20
 =09=09=09=09}
 =09=09=09}
-=09=09=09if(info_element->len >=3D 3 &&
+=09=09=09if (info_element->len >=3D 3 &&
 =09=09=09=09info_element->data[0] =3D=3D 0x00 &&
 =09=09=09=09info_element->data[1] =3D=3D 0x0c &&
 =09=09=09=09info_element->data[2] =3D=3D 0x43)
 =09=09=09{
 =09=09=09=09network->ralink_cap_exist =3D true;
-=09=09=09}
-=09=09=09else
+=09=09=09} else
 =09=09=09=09network->ralink_cap_exist =3D false;
 =09=09=09//added by amy for atheros AP
-=09=09=09if((info_element->len >=3D 3 &&
+=09=09=09if ((info_element->len >=3D 3 &&
 =09=09=09=09info_element->data[0] =3D=3D 0x00 &&
 =09=09=09=09info_element->data[1] =3D=3D 0x03 &&
 =09=09=09=09info_element->data[2] =3D=3D 0x7f) ||
@@ -1893,20 +1880,18 @@ int ieee80211_parse_info_param(struct ieee80211_dev=
ice *ieee,
 =09=09=09=09info_element->data[1] =3D=3D 0x13 &&
 =09=09=09=09info_element->data[2] =3D=3D 0x74))
 =09=09=09{
-=09=09=09=09printk("=3D=3D=3D=3D=3D=3D=3D=3D>%s(): athros AP is exist\n",_=
_func__);
+=09=09=09=09printk("=3D=3D=3D=3D=3D=3D=3D=3D>%s(): athros AP is exist\n", =
__func__);
 =09=09=09=09network->atheros_cap_exist =3D true;
-=09=09=09}
-=09=09=09else
+=09=09=09} else
 =09=09=09=09network->atheros_cap_exist =3D false;
=20
-=09=09=09if(info_element->len >=3D 3 &&
+=09=09=09if (info_element->len >=3D 3 &&
 =09=09=09=09info_element->data[0] =3D=3D 0x00 &&
 =09=09=09=09info_element->data[1] =3D=3D 0x40 &&
 =09=09=09=09info_element->data[2] =3D=3D 0x96)
 =09=09=09{
 =09=09=09=09network->cisco_cap_exist =3D true;
-=09=09=09}
-=09=09=09else
+=09=09=09} else
 =09=09=09=09network->cisco_cap_exist =3D false;
 =09=09=09//added by amy for LEAP of cisco
 =09=09=09if (info_element->len > 4 &&
@@ -1915,33 +1900,28 @@ int ieee80211_parse_info_param(struct ieee80211_dev=
ice *ieee,
 =09=09=09=09info_element->data[2] =3D=3D 0x96 &&
 =09=09=09=09info_element->data[3] =3D=3D 0x01)
 =09=09=09{
-=09=09=09=09if(info_element->len =3D=3D 6)
+=09=09=09=09if (info_element->len =3D=3D 6)
 =09=09=09=09{
 =09=09=09=09=09memcpy(network->CcxRmState, &info_element[4], 2);
-=09=09=09=09=09if(network->CcxRmState[0] !=3D 0)
+=09=09=09=09=09if (network->CcxRmState[0] !=3D 0)
 =09=09=09=09=09{
 =09=09=09=09=09=09network->bCcxRmEnable =3D true;
-=09=09=09=09=09}
-=09=09=09=09=09else
+=09=09=09=09=09} else
 =09=09=09=09=09=09network->bCcxRmEnable =3D false;
 =09=09=09=09=09//
 =09=09=09=09=09// CCXv4 Table 59-1 MBSSID Masks.
 =09=09=09=09=09//
 =09=09=09=09=09network->MBssidMask =3D network->CcxRmState[1] & 0x07;
-=09=09=09=09=09if(network->MBssidMask !=3D 0)
+=09=09=09=09=09if (network->MBssidMask !=3D 0)
 =09=09=09=09=09{
 =09=09=09=09=09=09network->bMBssidValid =3D true;
 =09=09=09=09=09=09network->MBssidMask =3D 0xff << (network->MBssidMask);
 =09=09=09=09=09=09ether_addr_copy(network->MBssid, network->bssid);
 =09=09=09=09=09=09network->MBssid[5] &=3D network->MBssidMask;
-=09=09=09=09=09}
-=09=09=09=09=09else
-=09=09=09=09=09{
+=09=09=09=09=09} else {
 =09=09=09=09=09=09network->bMBssidValid =3D false;
 =09=09=09=09=09}
-=09=09=09=09}
-=09=09=09=09else
-=09=09=09=09{
+=09=09=09=09} else {
 =09=09=09=09=09network->bCcxRmEnable =3D false;
 =09=09=09=09}
 =09=09=09}
@@ -1951,13 +1931,10 @@ int ieee80211_parse_info_param(struct ieee80211_dev=
ice *ieee,
 =09=09=09=09info_element->data[2] =3D=3D 0x96 &&
 =09=09=09=09info_element->data[3] =3D=3D 0x03)
 =09=09=09{
-=09=09=09=09if(info_element->len =3D=3D 5)
-=09=09=09=09{
+=09=09=09=09if (info_element->len =3D=3D 5) {
 =09=09=09=09=09network->bWithCcxVerNum =3D true;
 =09=09=09=09=09network->BssCcxVerNumber =3D info_element->data[4];
-=09=09=09=09}
-=09=09=09=09else
-=09=09=09=09{
+=09=09=09=09} else {
 =09=09=09=09=09network->bWithCcxVerNum =3D false;
 =09=09=09=09=09network->BssCcxVerNumber =3D 0;
 =09=09=09=09}
@@ -1977,19 +1954,18 @@ int ieee80211_parse_info_param(struct ieee80211_dev=
ice *ieee,
 =09=09case MFIE_TYPE_HT_CAP:
 =09=09=09IEEE80211_DEBUG_SCAN("MFIE_TYPE_HT_CAP: %d bytes\n",
 =09=09=09=09=09     info_element->len);
-=09=09=09tmp_htcap_len =3D min(info_element->len,(u8)MAX_IE_LEN);
-=09=09=09if(tmp_htcap_len !=3D 0){
+=09=09=09tmp_htcap_len =3D min(info_element->len, (u8)MAX_IE_LEN);
+=09=09=09if (tmp_htcap_len !=3D 0) {
 =09=09=09=09network->bssht.bdHTSpecVer =3D HT_SPEC_VER_EWC;
-=09=09=09=09network->bssht.bdHTCapLen =3D tmp_htcap_len > sizeof(network->=
bssht.bdHTCapBuf)?\
-=09=09=09=09=09sizeof(network->bssht.bdHTCapBuf):tmp_htcap_len;
-=09=09=09=09memcpy(network->bssht.bdHTCapBuf,info_element->data,network->b=
ssht.bdHTCapLen);
+=09=09=09=09network->bssht.bdHTCapLen =3D tmp_htcap_len > sizeof(network->=
bssht.bdHTCapBuf) ? \
+=09=09=09=09=09sizeof(network->bssht.bdHTCapBuf) : tmp_htcap_len;
+=09=09=09=09memcpy(network->bssht.bdHTCapBuf, info_element->data, network-=
>bssht.bdHTCapLen);
=20
 =09=09=09=09//If peer is HT, but not WMM, call QosSetLegacyWMMParamWithHT(=
)
 =09=09=09=09// windows driver will update WMM parameters each beacon recei=
ved once connected
 =09=09=09=09// Linux driver is a bit different.
 =09=09=09=09network->bssht.bdSupportHT =3D true;
-=09=09=09}
-=09=09=09else
+=09=09=09} else
 =09=09=09=09network->bssht.bdSupportHT =3D false;
 =09=09=09break;
=20
@@ -1997,37 +1973,33 @@ int ieee80211_parse_info_param(struct ieee80211_dev=
ice *ieee,
 =09=09case MFIE_TYPE_HT_INFO:
 =09=09=09IEEE80211_DEBUG_SCAN("MFIE_TYPE_HT_INFO: %d bytes\n",
 =09=09=09=09=09     info_element->len);
-=09=09=09tmp_htinfo_len =3D min(info_element->len,(u8)MAX_IE_LEN);
-=09=09=09if(tmp_htinfo_len){
+=09=09=09tmp_htinfo_len =3D min(info_element->len, (u8)MAX_IE_LEN);
+=09=09=09if (tmp_htinfo_len) {
 =09=09=09=09network->bssht.bdHTSpecVer =3D HT_SPEC_VER_IEEE;
-=09=09=09=09network->bssht.bdHTInfoLen =3D tmp_htinfo_len > sizeof(network=
->bssht.bdHTInfoBuf)?\
-=09=09=09=09=09sizeof(network->bssht.bdHTInfoBuf):tmp_htinfo_len;
-=09=09=09=09memcpy(network->bssht.bdHTInfoBuf,info_element->data,network->=
bssht.bdHTInfoLen);
+=09=09=09=09network->bssht.bdHTInfoLen =3D tmp_htinfo_len > sizeof(network=
->bssht.bdHTInfoBuf) ? \
+=09=09=09=09=09sizeof(network->bssht.bdHTInfoBuf) : tmp_htinfo_len;
+=09=09=09=09memcpy(network->bssht.bdHTInfoBuf, info_element->data, network=
->bssht.bdHTInfoLen);
 =09=09=09}
 =09=09=09break;
=20
 =09=09case MFIE_TYPE_AIRONET:
 =09=09=09IEEE80211_DEBUG_SCAN("MFIE_TYPE_AIRONET: %d bytes\n",
 =09=09=09=09=09     info_element->len);
-=09=09=09if(info_element->len >IE_CISCO_FLAG_POSITION)
+=09=09=09if (info_element->len > IE_CISCO_FLAG_POSITION)
 =09=09=09{
 =09=09=09=09network->bWithAironetIE =3D true;
=20
 =09=09=09=09// CCX 1 spec v1.13, A01.1 CKIP Negotiation (page23):
 =09=09=09=09// "A Cisco access point advertises support for CKIP in beacon=
 and probe response packets,
 =09=09=09=09//  by adding an Aironet element and setting one or both of th=
e CKIP negotiation bits."
-=09=09=09=09if(=09(info_element->data[IE_CISCO_FLAG_POSITION]&SUPPORT_CKIP=
_MIC)=09||
-=09=09=09=09=09(info_element->data[IE_CISCO_FLAG_POSITION]&SUPPORT_CKIP_PK=
)=09)
+=09=09=09=09if ((info_element->data[IE_CISCO_FLAG_POSITION] & SUPPORT_CKIP=
_MIC)=09||
+=09=09=09=09=09(info_element->data[IE_CISCO_FLAG_POSITION] & SUPPORT_CKIP_=
PK))
 =09=09=09=09{
 =09=09=09=09=09network->bCkipSupported =3D true;
-=09=09=09=09}
-=09=09=09=09else
-=09=09=09=09{
+=09=09=09=09} else {
 =09=09=09=09=09network->bCkipSupported =3D false;
 =09=09=09=09}
-=09=09=09}
-=09=09=09else
-=09=09=09{
+=09=09=09} else {
 =09=09=09=09network->bWithAironetIE =3D false;
 =09=09=09=09network->bCkipSupported =3D false;
 =09=09=09}
@@ -2057,13 +2029,10 @@ int ieee80211_parse_info_param(struct ieee80211_dev=
ice *ieee,
 =09=09    data[info_element->len];
 =09}
=20
-=09if(!network->atheros_cap_exist && !network->broadcom_cap_exist &&
-=09=09!network->cisco_cap_exist && !network->ralink_cap_exist && !network-=
>bssht.bdRT2RTAggregation)
-=09{
+=09if (!network->atheros_cap_exist && !network->broadcom_cap_exist &&
+=09=09!network->cisco_cap_exist && !network->ralink_cap_exist && !network-=
>bssht.bdRT2RTAggregation) {
 =09=09network->unknown_cap_exist =3D true;
-=09}
-=09else
-=09{
+=09} else {
 =09=09network->unknown_cap_exist =3D false;
 =09}
 =09return 0;
@@ -2076,44 +2045,25 @@ static inline u8 ieee80211_SignalStrengthTranslate(
 =09u8 RetSS;
=20
 =09// Step 1. Scale mapping.
-=09if(CurrSS >=3D 71 && CurrSS <=3D 100)
-=09{
+=09if (CurrSS >=3D 71 && CurrSS <=3D 100) {
 =09=09RetSS =3D 90 + ((CurrSS - 70) / 3);
-=09}
-=09else if(CurrSS >=3D 41 && CurrSS <=3D 70)
-=09{
+=09} else if (CurrSS >=3D 41 && CurrSS <=3D 70) {
 =09=09RetSS =3D 78 + ((CurrSS - 40) / 3);
-=09}
-=09else if(CurrSS >=3D 31 && CurrSS <=3D 40)
-=09{
+=09} else if (CurrSS >=3D 31 && CurrSS <=3D 40) {
 =09=09RetSS =3D 66 + (CurrSS - 30);
-=09}
-=09else if(CurrSS >=3D 21 && CurrSS <=3D 30)
-=09{
+=09} else if (CurrSS >=3D 21 && CurrSS <=3D 30) {
 =09=09RetSS =3D 54 + (CurrSS - 20);
-=09}
-=09else if(CurrSS >=3D 5 && CurrSS <=3D 20)
-=09{
+=09} else if (CurrSS >=3D 5 && CurrSS <=3D 20) {
 =09=09RetSS =3D 42 + (((CurrSS - 5) * 2) / 3);
-=09}
-=09else if(CurrSS =3D=3D 4)
-=09{
+=09} else if (CurrSS =3D=3D 4) {
 =09=09RetSS =3D 36;
-=09}
-=09else if(CurrSS =3D=3D 3)
-=09{
+=09} else if (CurrSS =3D=3D 3) {
 =09=09RetSS =3D 27;
-=09}
-=09else if(CurrSS =3D=3D 2)
-=09{
+=09} else if (CurrSS =3D=3D 2) {
 =09=09RetSS =3D 18;
-=09}
-=09else if(CurrSS =3D=3D 1)
-=09{
+=09} else if (CurrSS =3D=3D 1) {
 =09=09RetSS =3D 9;
-=09}
-=09else
-=09{
+=09} else {
 =09=09RetSS =3D CurrSS;
 =09}
 =09//RT_TRACE(COMP_DBG, DBG_LOUD, ("##### After Mapping:  LastSS: %d, Curr=
SS: %d, RetSS: %d\n", LastSS, CurrSS, RetSS));
@@ -2193,7 +2143,7 @@ static inline int ieee80211_network_init(
 =09network->rsn_ie_len =3D 0;
=20
 =09if (ieee80211_parse_info_param
-=09    (ieee,beacon->info_element, stats->len - sizeof(*beacon), network, =
stats))
+=09    (ieee, beacon->info_element, stats->len - sizeof(*beacon), network,=
 stats))
 =09=09return 1;
=20
 =09network->mode =3D 0;
@@ -2215,10 +2165,10 @@ static inline int ieee80211_network_init(
 =09=09return 1;
 =09}
=20
-=09if(network->bssht.bdSupportHT){
-=09=09if(network->mode =3D=3D IEEE_A)
+=09if (network->bssht.bdSupportHT) {
+=09=09if (network->mode =3D=3D IEEE_A)
 =09=09=09network->mode =3D IEEE_N_5G;
-=09=09else if(network->mode & (IEEE_G | IEEE_B))
+=09=09else if (network->mode & (IEEE_G | IEEE_B))
 =09=09=09network->mode =3D IEEE_N_24G;
 =09}
 =09if (ieee80211_is_empty_essid(network->ssid, network->ssid_len))
@@ -2226,7 +2176,7 @@ static inline int ieee80211_network_init(
=20
 =09stats->signal =3D 30 + (stats->SignalStrength * 70) / 100;
 =09//stats->signal =3D ieee80211_SignalStrengthTranslate(stats->signal);
-=09stats->noise =3D ieee80211_translate_todbm((u8)(100-stats->signal)) -25=
;
+=09stats->noise =3D ieee80211_translate_todbm((u8)(100 - stats->signal)) -=
 25;
=20
 =09memcpy(&network->stats, stats, sizeof(network->stats));
=20
@@ -2290,10 +2240,10 @@ static inline void update_network(struct ieee80211_=
network *dst,
=20
 =09dst->bssht.bdSupportHT =3D src->bssht.bdSupportHT;
 =09dst->bssht.bdRT2RTAggregation =3D src->bssht.bdRT2RTAggregation;
-=09dst->bssht.bdHTCapLen=3D src->bssht.bdHTCapLen;
-=09memcpy(dst->bssht.bdHTCapBuf,src->bssht.bdHTCapBuf,src->bssht.bdHTCapLe=
n);
-=09dst->bssht.bdHTInfoLen=3D src->bssht.bdHTInfoLen;
-=09memcpy(dst->bssht.bdHTInfoBuf,src->bssht.bdHTInfoBuf,src->bssht.bdHTInf=
oLen);
+=09dst->bssht.bdHTCapLen =3D src->bssht.bdHTCapLen;
+=09memcpy(dst->bssht.bdHTCapBuf, src->bssht.bdHTCapBuf, src->bssht.bdHTCap=
Len);
+=09dst->bssht.bdHTInfoLen =3D src->bssht.bdHTInfoLen;
+=09memcpy(dst->bssht.bdHTInfoBuf, src->bssht.bdHTInfoBuf, src->bssht.bdHTI=
nfoLen);
 =09dst->bssht.bdHTSpecVer =3D src->bssht.bdHTSpecVer;
 =09dst->bssht.bdRT2RTLongSlotTime =3D src->bssht.bdRT2RTLongSlotTime;
 =09dst->broadcom_cap_exist =3D src->broadcom_cap_exist;
@@ -2312,7 +2262,7 @@ static inline void update_network(struct ieee80211_ne=
twork *dst,
 =09qos_active =3D dst->qos_data.active;
 =09//old_param =3D dst->qos_data.old_param_count;
 =09old_param =3D dst->qos_data.param_count;
-=09if(dst->flags & NETWORK_HAS_QOS_MASK)
+=09if (dst->flags & NETWORK_HAS_QOS_MASK)
 =09=09memcpy(&dst->qos_data, &src->qos_data,
 =09=09=09sizeof(struct ieee80211_qos_data));
 =09else {
@@ -2322,7 +2272,7 @@ static inline void update_network(struct ieee80211_ne=
twork *dst,
=20
 =09if (dst->qos_data.supported =3D=3D 1) {
 =09=09dst->QoS_Enable =3D 1;
-=09=09if(dst->ssid_len)
+=09=09if (dst->ssid_len)
 =09=09=09IEEE80211_DEBUG_QOS
 =09=09=09=09("QoS the network %s is QoS supported\n",
 =09=09=09=09dst->ssid);
@@ -2335,9 +2285,9 @@ static inline void update_network(struct ieee80211_ne=
twork *dst,
=20
 =09/* dst->last_associate is not overwritten */
 =09dst->wmm_info =3D src->wmm_info; //sure to exist in beacon or probe res=
ponse frame.
-=09if (src->wmm_param[0].aci_aifsn|| \
-=09   src->wmm_param[1].aci_aifsn|| \
-=09   src->wmm_param[2].aci_aifsn|| \
+=09if (src->wmm_param[0].aci_aifsn || \
+=09   src->wmm_param[1].aci_aifsn || \
+=09   src->wmm_param[2].aci_aifsn || \
 =09   src->wmm_param[3].aci_aifsn) {
 =09  memcpy(dst->wmm_param, src->wmm_param, WME_AC_PRAM_LEN);
 =09}
@@ -2434,8 +2384,7 @@ static inline void ieee80211_process_probe_response(
 =09=09if (fc =3D=3D IEEE80211_STYPE_PROBE_RESP)
 =09=09{
 =09=09=09// Case 1: Country code
-=09=09=09if(IS_COUNTRY_IE_VALID(ieee) )
-=09=09=09{
+=09=09=09if (IS_COUNTRY_IE_VALID(ieee)) {
 =09=09=09=09if (!is_legal_channel(ieee, network->channel)) {
 =09=09=09=09=09printk("GetScanInfo(): For Country code, filter probe respo=
nse at channel(%d).\n", network->channel);
 =09=09=09=09=09goto out;
@@ -2451,14 +2400,11 @@ static inline void ieee80211_process_probe_response=
(
 =09=09=09=09=09goto out;
 =09=09=09=09}
 =09=09=09}
-=09=09}
-=09=09else
-=09=09{
+=09=09} else {
 =09=09=09// Case 1: Country code
-=09=09=09if(IS_COUNTRY_IE_VALID(ieee) )
-=09=09=09{
+=09=09=09if (IS_COUNTRY_IE_VALID(ieee)) {
 =09=09=09=09if (!is_legal_channel(ieee, network->channel)) {
-=09=09=09=09=09printk("GetScanInfo(): For Country code, filter beacon at c=
hannel(%d).\n",network->channel);
+=09=09=09=09=09printk("GetScanInfo(): For Country code, filter beacon at c=
hannel(%d).\n", network->channel);
 =09=09=09=09=09goto out;
 =09=09=09=09}
 =09=09=09}
@@ -2468,7 +2414,7 @@ static inline void ieee80211_process_probe_response(
 =09=09=09=09// Filter over channel ch12~14
 =09=09=09=09if (network->channel > 14)
 =09=09=09=09{
-=09=09=09=09=09printk("GetScanInfo(): For Global Domain, filter beacon at =
channel(%d).\n",network->channel);
+=09=09=09=09=09printk("GetScanInfo(): For Global Domain, filter beacon at =
channel(%d).\n", network->channel);
 =09=09=09=09=09goto out;
 =09=09=09=09}
 =09=09=09}
@@ -2491,18 +2437,17 @@ static inline void ieee80211_process_probe_response=
(
 =09=09update_network(&ieee->current_network, network);
 =09=09if ((ieee->current_network.mode =3D=3D IEEE_N_24G || ieee->current_n=
etwork.mode =3D=3D IEEE_G)
 =09=09&& ieee->current_network.berp_info_valid){
-=09=09if(ieee->current_network.erp_value& ERP_UseProtection)
+=09=09if (ieee->current_network.erp_value & ERP_UseProtection)
 =09=09=09ieee->current_network.buseprotection =3D true;
 =09=09else
 =09=09=09ieee->current_network.buseprotection =3D false;
 =09=09}
-=09=09if(is_beacon(beacon->header.frame_ctl))
+=09=09if (is_beacon(beacon->header.frame_ctl))
 =09=09{
-=09=09=09if(ieee->state =3D=3D IEEE80211_LINKED)
+=09=09=09if (ieee->state =3D=3D IEEE80211_LINKED)
 =09=09=09=09ieee->LinkDetectInfo.NumRecvBcnInPeriod++;
-=09=09}
-=09=09else //hidden AP
-=09=09=09network->flags =3D (~NETWORK_EMPTY_ESSID & network->flags)|(NETWO=
RK_EMPTY_ESSID & ieee->current_network.flags);
+=09=09} else //hidden AP
+=09=09=09network->flags =3D (~NETWORK_EMPTY_ESSID & network->flags) | (NET=
WORK_EMPTY_ESSID & ieee->current_network.flags);
 =09}
=20
 =09list_for_each_entry(target, &ieee->network_list, list) {
@@ -2543,8 +2488,8 @@ static inline void ieee80211_process_probe_response(
 #endif
 =09=09memcpy(target, network, sizeof(*target));
 =09=09list_add_tail(&target->list, &ieee->network_list);
-=09=09if(ieee->softmac_features & IEEE_SOFTMAC_ASSOCIATE)
-=09=09=09ieee80211_softmac_new_net(ieee,network);
+=09=09if (ieee->softmac_features & IEEE_SOFTMAC_ASSOCIATE)
+=09=09=09ieee80211_softmac_new_net(ieee, network);
 =09} else {
 =09=09IEEE80211_DEBUG_SCAN("Updating '%s' (%pM) via %s.\n",
 =09=09=09=09     escape_essid(target->ssid,
@@ -2559,26 +2504,26 @@ static inline void ieee80211_process_probe_response=
(
 =09=09 */
 =09=09renew =3D !time_after(target->last_scanned + ieee->scan_age, jiffies=
);
 =09=09//YJ,add,080819,for hidden ap
-=09=09if(is_beacon(beacon->header.frame_ctl) =3D=3D 0)
-=09=09=09network->flags =3D (~NETWORK_EMPTY_ESSID & network->flags)|(NETWO=
RK_EMPTY_ESSID & target->flags);
+=09=09if (is_beacon(beacon->header.frame_ctl) =3D=3D 0)
+=09=09=09network->flags =3D (~NETWORK_EMPTY_ESSID & network->flags) | (NET=
WORK_EMPTY_ESSID & target->flags);
 =09=09//if(strncmp(network->ssid, "linksys-c",9) =3D=3D 0)
 =09=09//=09printk("=3D=3D=3D=3D>2 network->ssid=3D%s FLAG=3D%d target.ssid=
=3D%s FLAG=3D%d\n", network->ssid, network->flags, target->ssid, target->fl=
ags);
-=09=09if(((network->flags & NETWORK_EMPTY_ESSID) =3D=3D NETWORK_EMPTY_ESSI=
D) \
+=09=09if (((network->flags & NETWORK_EMPTY_ESSID) =3D=3D NETWORK_EMPTY_ESS=
ID) \
 =09=09    && (((network->ssid_len > 0) && (strncmp(target->ssid, network->=
ssid, network->ssid_len)))\
-=09=09    ||((ieee->current_network.ssid_len =3D=3D network->ssid_len) && =
(strncmp(ieee->current_network.ssid, network->ssid, network->ssid_len) =3D=
=3D 0) && (ieee->state =3D=3D IEEE80211_NOLINK))))
+ || ((ieee->current_network.ssid_len =3D=3D network->ssid_len) && (strncmp=
(ieee->current_network.ssid, network->ssid, network->ssid_len) =3D=3D 0) &&=
 (ieee->state =3D=3D IEEE80211_NOLINK))))
 =09=09=09renew =3D 1;
 =09=09//YJ,add,080819,for hidden ap,end
=20
 =09=09update_network(target, network);
-=09=09if(renew && (ieee->softmac_features & IEEE_SOFTMAC_ASSOCIATE))
-=09=09=09ieee80211_softmac_new_net(ieee,network);
+=09=09if (renew && (ieee->softmac_features & IEEE_SOFTMAC_ASSOCIATE))
+=09=09=09ieee80211_softmac_new_net(ieee, network);
 =09}
=20
 =09spin_unlock_irqrestore(&ieee->lock, flags);
 =09if (is_beacon(beacon->header.frame_ctl) && is_same_network(&ieee->curre=
nt_network, network, ieee) && \
 =09=09(ieee->state =3D=3D IEEE80211_LINKED)) {
 =09=09if (ieee->handle_beacon)
-=09=09=09ieee->handle_beacon(ieee->dev,beacon,&ieee->current_network);
+=09=09=09ieee->handle_beacon(ieee->dev, beacon, &ieee->current_network);
 =09}
=20
 out:
--=20
2.22.0



