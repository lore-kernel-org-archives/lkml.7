Return-Path: <SRS0=Exau=WQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2AD51C3A589
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Aug 2019 23:12:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CFBD722DD6
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Aug 2019 23:12:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=brennan.io header.i=stephen@brennan.io header.b="PKkFtoB3"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726351AbfHTXMp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 20 Aug 2019 19:12:45 -0400
Received: from sender4-of-o55.zoho.com ([136.143.188.55]:21545 "EHLO
        sender4-of-o55.zoho.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726128AbfHTXMp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Aug 2019 19:12:45 -0400
ARC-Seal: i=1; a=rsa-sha256; t=1566342755; cv=none; 
        d=zoho.com; s=zohoarc; 
        b=DErl3lBQoQ2FIot5Sz2krpY7n43XAdjodS8HAbxvSXoFa23jDXOJMONUiEIwigC9FbUwic27x61JI6uivfWMBvh/BI2NM6M2Y5USdqT8q+m1NdDrjT+vJay7Mqp5B9RDgG0x2hE7SS9khGrrNoKstOCrgCvREm/geVi0HlYJDXA=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zoho.com; s=zohoarc; 
        t=1566342755; h=Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:To:ARC-Authentication-Results; 
        bh=BcwHdDJUkvGYPODDEq2MQD88LVLu8/4LpApmGuvI58k=; 
        b=YYpZTWxiwVEIXagHJciIP/0aIAXIjYilyNn2wnLBZuBSA18WK8dtJ1GIuF2QTzMPPUCYTuNWquWUXpnO2vyrKKBZG+sprkZ+U20/dtl1J7OJNHd3hVghWE952EP0OKPc3Mv3tyPiyEw4VAedWsWOK0Zqn89xnKhc/Y531kMDlAk=
ARC-Authentication-Results: i=1; mx.zoho.com;
        dkim=pass  header.i=brennan.io;
        spf=pass  smtp.mailfrom=stephen@brennan.io;
        dmarc=pass header.from=<stephen@brennan.io> header.from=<stephen@brennan.io>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1566342755;
        s=selector01; d=brennan.io; i=stephen@brennan.io;
        h=From:To:Cc:Message-ID:Subject:Date:In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:Content-Type;
        l=24886; bh=BcwHdDJUkvGYPODDEq2MQD88LVLu8/4LpApmGuvI58k=;
        b=PKkFtoB3s8CTovLdR+NENst/8Il6YsBmUdmndOjbQyxG1P7jAW066WgdVRq2uaec
        M2153+6pXRW3p37QlmAKUGjWDPLhH9519ShcPiKlUFfZsfT+kPnKNesJ6emB8DMl+CF
        dS2b0VXyGMfv4KG4woKqlllgStON+kbDPBbvDhQQ=
Received: from localhost (wsip-184-188-36-2.sd.sd.cox.net [184.188.36.2]) by mx.zohomail.com
        with SMTPS id 1566342754053642.4590168596734; Tue, 20 Aug 2019 16:12:34 -0700 (PDT)
From:   Stephen Brennan <stephen@brennan.io>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Stephen Brennan <stephen@brennan.io>, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org, "Tobin C . Harding" <me@tobin.cc>
Message-ID: <20190820231156.30031-2-stephen@brennan.io>
Subject: [PATCH 1/3] staging: rtl8192u: fix OPEN_BRACE errors in ieee80211
Date:   Tue, 20 Aug 2019 16:11:54 -0700
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20190820231156.30031-1-stephen@brennan.io>
References: <20190820231156.30031-1-stephen@brennan.io>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-ZohoMailClient: External
Content-Type: text/plain; charset=utf8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Signed-off-by: Stephen Brennan <stephen@brennan.io>
---
 .../staging/rtl8192u/ieee80211/ieee80211.h    |   3 +-
 .../staging/rtl8192u/ieee80211/ieee80211_rx.c | 116 ++++++------------
 .../staging/rtl8192u/ieee80211/ieee80211_tx.c |  81 +++++-------
 .../staging/rtl8192u/ieee80211/ieee80211_wx.c |   3 +-
 .../staging/rtl8192u/ieee80211/rtl819x_HT.h   |   3 +-
 5 files changed, 73 insertions(+), 133 deletions(-)

diff --git a/drivers/staging/rtl8192u/ieee80211/ieee80211.h b/drivers/stagi=
ng/rtl8192u/ieee80211/ieee80211.h
index 3963a08b9eb2..129dcb5a0f2e 100644
--- a/drivers/staging/rtl8192u/ieee80211/ieee80211.h
+++ b/drivers/staging/rtl8192u/ieee80211/ieee80211.h
@@ -458,8 +458,7 @@ do { if (ieee80211_debug_level & (level)) \
 =09=09=09int i;=09=09=09=09=09\
 =09=09=09u8 *pdata =3D (u8 *) data;=09=09=09\
 =09=09=09printk(KERN_DEBUG "ieee80211: %s()\n", __func__);=09\
-=09=09=09for (i =3D 0; i < (int)(datalen); i++)=09=09=09\
-=09=09=09{=09=09=09=09=09=09\
+=09=09=09for (i =3D 0; i < (int)(datalen); i++) {=09=09\
 =09=09=09=09printk("%2x ", pdata[i]);=09=09\
 =09=09=09=09if ((i + 1) % 16 =3D=3D 0) printk("\n");=09\
 =09=09=09}=09=09=09=09\
diff --git a/drivers/staging/rtl8192u/ieee80211/ieee80211_rx.c b/drivers/st=
aging/rtl8192u/ieee80211/ieee80211_rx.c
index 7ef1e89de269..9d8b2ff700fe 100644
--- a/drivers/staging/rtl8192u/ieee80211/ieee80211_rx.c
+++ b/drivers/staging/rtl8192u/ieee80211/ieee80211_rx.c
@@ -218,8 +218,8 @@ ieee80211_rx_frame_mgmt(struct ieee80211_device *ieee, =
struct sk_buff *skb,
 =09rx_stats->len =3D skb->len;
 =09ieee80211_rx_mgt(ieee, (struct rtl_80211_hdr_4addr *)skb->data, rx_stat=
s);
 =09/* if ((ieee->state =3D=3D IEEE80211_LINKED) && (memcmp(hdr->addr3, iee=
e->current_network.bssid, ETH_ALEN))) */
-=09if ((memcmp(hdr->addr1, ieee->dev->dev_addr, ETH_ALEN)))/* use ADDR1 to=
 perform address matching for Management frames */
-=09{
+=09if ((memcmp(hdr->addr1, ieee->dev->dev_addr, ETH_ALEN))) {
+=09=09/* use ADDR1 to perform address matching for Management frames */
 =09=09dev_kfree_skb_any(skb);
 =09=09return 0;
 =09}
@@ -339,8 +339,7 @@ ieee80211_rx_frame_decrypt(struct ieee80211_device *iee=
e, struct sk_buff *skb,
=20
 =09if (!crypt || !crypt->ops->decrypt_mpdu)
 =09=09return 0;
-=09if (ieee->hwsec_active)
-=09{
+=09if (ieee->hwsec_active) {
 =09=09struct cb_desc *tcb_desc =3D (struct cb_desc *)(skb->cb + MAX_DEV_AD=
DR_SIZE);
 =09=09tcb_desc->bHwSec =3D 1;
 =09}
@@ -386,8 +385,7 @@ ieee80211_rx_frame_decrypt_msdu(struct ieee80211_device=
 *ieee, struct sk_buff *s
=20
 =09if (!crypt || !crypt->ops->decrypt_msdu)
 =09=09return 0;
-=09if (ieee->hwsec_active)
-=09{
+=09if (ieee->hwsec_active) {
 =09=09struct cb_desc *tcb_desc =3D (struct cb_desc *)(skb->cb + MAX_DEV_AD=
DR_SIZE);
 =09=09tcb_desc->bHwSec =3D 1;
 =09}
@@ -507,8 +505,7 @@ static int is_duplicate_packet(struct ieee80211_device =
*ieee,
 static bool AddReorderEntry(struct rx_ts_record *pTS, struct rx_reorder_en=
try *pReorderEntry)
 {
 =09struct list_head *pList =3D &pTS->rx_pending_pkt_list;
-=09while (pList->next !=3D &pTS->rx_pending_pkt_list)
-=09{
+=09while (pList->next !=3D &pTS->rx_pending_pkt_list) {
 =09=09if (SN_LESS(pReorderEntry->SeqNum, list_entry(pList->next, struct rx=
_reorder_entry, List)->SeqNum))
 =09=09=09pList =3D pList->next;
 =09=09else if (SN_EQUAL(pReorderEntry->SeqNum, list_entry(pList->next, str=
uct rx_reorder_entry, List)->SeqNum))
@@ -530,8 +527,7 @@ void ieee80211_indicate_packets(struct ieee80211_device=
 *ieee, struct ieee80211_
 =09u16 ethertype;
 //=09if(index > 1)
 //=09=09IEEE80211_DEBUG(IEEE80211_DL_REORDER,"%s(): hahahahhhh, We indicat=
e packet from reorder list, index is %u\n",__func__,index);
-=09for (j =3D 0; j < index; j++)
-=09{
+=09for (j =3D 0; j < index; j++) {
 //added by amy for reorder
 =09=09struct ieee80211_rxb *prxb =3D prxbIndicateArray[j];
 =09=09for (i =3D 0; i < prxb->nr_subframes; i++) {
@@ -699,8 +695,7 @@ static void RxReorderIndicatePacket(struct ieee80211_de=
vice *ieee,
 =09=09IEEE80211_DEBUG(IEEE80211_DL_REORDER, "%s(): start RREORDER indicate=
\n", __func__);
 =09=09pReorderEntry =3D list_entry(pTS->rx_pending_pkt_list.prev, struct r=
x_reorder_entry, List);
 =09=09if (SN_LESS(pReorderEntry->SeqNum, pTS->rx_indicate_seq) ||
-=09=09    SN_EQUAL(pReorderEntry->SeqNum, pTS->rx_indicate_seq))
-=09=09{
+=09=09    SN_EQUAL(pReorderEntry->SeqNum, pTS->rx_indicate_seq)) {
 =09=09=09/* This protect buffer from overflow. */
 =09=09=09if (index >=3D REORDER_WIN_SIZE) {
 =09=09=09=09IEEE80211_DEBUG(IEEE80211_DL_ERR, "RxReorderIndicatePacket(): =
Buffer overflow!! \n");
@@ -922,8 +917,7 @@ int ieee80211_rx(struct ieee80211_device *ieee, struct =
sk_buff *skb,
 =09frag =3D WLAN_GET_SEQ_FRAG(sc);
 =09hdrlen =3D ieee80211_get_hdrlen(fc);
=20
-=09if (HTCCheck(ieee, skb->data))
-=09{
+=09if (HTCCheck(ieee, skb->data)) {
 =09=09if (net_ratelimit())
 =09=09=09printk("find HTCControl\n");
 =09=09hdrlen +=3D 4;
@@ -1010,8 +1004,7 @@ int ieee80211_rx(struct ieee80211_device *ieee, struc=
t sk_buff *skb,
 =09=09=09=09hdr->addr2,
 =09=09=09=09Frame_QoSTID((u8 *)(skb->data)),
 =09=09=09=09RX_DIR,
-=09=09=09=09true))
-=09=09{
+=09=09=09=09true)) {
=20
 =09=09//=09IEEE80211_DEBUG(IEEE80211_DL_REORDER,"%s(): pRxTS->rx_last_frag=
_num is %d,frag is %d,pRxTS->rx_last_seq_num is %d,seq is %d\n",__func__,pR=
xTS->rx_last_frag_num,frag,pRxTS->rx_last_seq_num,WLAN_GET_SEQ_SEQ(sc));
 =09=09=09if ((fc & (1 << 11)) &&
@@ -1119,8 +1112,7 @@ int ieee80211_rx(struct ieee80211_device *ieee, struc=
t sk_buff *skb,
 =09/* skb: hdr + (possibly fragmented, possibly encrypted) payload */
=20
 =09if (ieee->host_decrypt && (fc & IEEE80211_FCTL_WEP) &&
-=09    (keyidx =3D ieee80211_rx_frame_decrypt(ieee, skb, crypt)) < 0)
-=09{
+=09    (keyidx =3D ieee80211_rx_frame_decrypt(ieee, skb, crypt)) < 0) {
 =09=09printk("decrypt frame error\n");
 =09=09goto rx_dropped;
 =09}
@@ -1185,8 +1177,7 @@ int ieee80211_rx(struct ieee80211_device *ieee, struc=
t sk_buff *skb,
 =09/* skb: hdr + (possible reassembled) full MSDU payload; possibly still
 =09 * encrypted/authenticated */
 =09if (ieee->host_decrypt && (fc & IEEE80211_FCTL_WEP) &&
-=09    ieee80211_rx_frame_decrypt_msdu(ieee, skb, keyidx, crypt))
-=09{
+=09    ieee80211_rx_frame_decrypt_msdu(ieee, skb, keyidx, crypt)) {
 =09=09printk("=3D=3D>decrypt msdu error\n");
 =09=09goto rx_dropped;
 =09}
@@ -1243,13 +1234,11 @@ int ieee80211_rx(struct ieee80211_device *ieee, str=
uct sk_buff *skb,
 */
 //added by amy for reorder
 =09if (ieee->current_network.qos_data.active && IsQoSDataFrame(skb->data)
-=09=09&& !is_multicast_ether_addr(hdr->addr1))
-=09{
+=09=09&& !is_multicast_ether_addr(hdr->addr1)) {
 =09=09TID =3D Frame_QoSTID(skb->data);
 =09=09SeqNum =3D WLAN_GET_SEQ_SEQ(sc);
 =09=09GetTs(ieee, (struct ts_common_info **) &pTS, hdr->addr2, TID, RX_DIR=
, true);
-=09=09if (TID !=3D 0 && TID !=3D 3)
-=09=09{
+=09=09if (TID !=3D 0 && TID !=3D 3) {
 =09=09=09ieee->bis_any_nonbepkts =3D true;
 =09=09}
 =09}
@@ -1549,15 +1538,12 @@ static inline void ieee80211_extract_country_ie(
 =09u8 *addr2
 )
 {
-=09if (IS_DOT11D_ENABLE(ieee))
-=09{
-=09=09if (info_element->len !=3D 0)
-=09=09{
+=09if (IS_DOT11D_ENABLE(ieee)) {
+=09=09if (info_element->len !=3D 0) {
 =09=09=09memcpy(network->CountryIeBuf, info_element->data, info_element->l=
en);
 =09=09=09network->CountryIeLen =3D info_element->len;
=20
-=09=09=09if (!IS_COUNTRY_IE_VALID(ieee))
-=09=09=09{
+=09=09=09if (!IS_COUNTRY_IE_VALID(ieee)) {
 =09=09=09=09dot11d_update_country_ie(ieee, addr2, info_element->len, info_=
element->data);
 =09=09=09}
 =09=09}
@@ -1567,8 +1553,7 @@ static inline void ieee80211_extract_country_ie(
 =09=09// some AP (e.g. Cisco 1242) don't include country IE in their
 =09=09// probe response frame.
 =09=09//
-=09=09if (IS_EQUAL_CIE_SRC(ieee, addr2))
-=09=09{
+=09=09if (IS_EQUAL_CIE_SRC(ieee, addr2)) {
 =09=09=09UPDATE_CIE_WATCHDOG(ieee);
 =09=09}
 =09}
@@ -1865,8 +1850,7 @@ int ieee80211_parse_info_param(struct ieee80211_devic=
e *ieee,
 =09=09=09if (info_element->len >=3D 3 &&
 =09=09=09=09info_element->data[0] =3D=3D 0x00 &&
 =09=09=09=09info_element->data[1] =3D=3D 0x0c &&
-=09=09=09=09info_element->data[2] =3D=3D 0x43)
-=09=09=09{
+=09=09=09=09info_element->data[2] =3D=3D 0x43) {
 =09=09=09=09network->ralink_cap_exist =3D true;
 =09=09=09} else
 =09=09=09=09network->ralink_cap_exist =3D false;
@@ -1878,8 +1862,7 @@ int ieee80211_parse_info_param(struct ieee80211_devic=
e *ieee,
 =09=09=09=09(info_element->len >=3D 3 &&
 =09=09=09=09info_element->data[0] =3D=3D 0x00 &&
 =09=09=09=09info_element->data[1] =3D=3D 0x13 &&
-=09=09=09=09info_element->data[2] =3D=3D 0x74))
-=09=09=09{
+=09=09=09=09info_element->data[2] =3D=3D 0x74)) {
 =09=09=09=09printk("=3D=3D=3D=3D=3D=3D=3D=3D>%s(): athros AP is exist\n", =
__func__);
 =09=09=09=09network->atheros_cap_exist =3D true;
 =09=09=09} else
@@ -1888,8 +1871,7 @@ int ieee80211_parse_info_param(struct ieee80211_devic=
e *ieee,
 =09=09=09if (info_element->len >=3D 3 &&
 =09=09=09=09info_element->data[0] =3D=3D 0x00 &&
 =09=09=09=09info_element->data[1] =3D=3D 0x40 &&
-=09=09=09=09info_element->data[2] =3D=3D 0x96)
-=09=09=09{
+=09=09=09=09info_element->data[2] =3D=3D 0x96) {
 =09=09=09=09network->cisco_cap_exist =3D true;
 =09=09=09} else
 =09=09=09=09network->cisco_cap_exist =3D false;
@@ -1898,22 +1880,18 @@ int ieee80211_parse_info_param(struct ieee80211_dev=
ice *ieee,
 =09=09=09=09info_element->data[0] =3D=3D 0x00 &&
 =09=09=09=09info_element->data[1] =3D=3D 0x40 &&
 =09=09=09=09info_element->data[2] =3D=3D 0x96 &&
-=09=09=09=09info_element->data[3] =3D=3D 0x01)
-=09=09=09{
-=09=09=09=09if (info_element->len =3D=3D 6)
-=09=09=09=09{
+=09=09=09=09info_element->data[3] =3D=3D 0x01) {
+=09=09=09=09if (info_element->len =3D=3D 6) {
 =09=09=09=09=09memcpy(network->CcxRmState, &info_element[4], 2);
 =09=09=09=09=09if (network->CcxRmState[0] !=3D 0)
-=09=09=09=09=09{
 =09=09=09=09=09=09network->bCcxRmEnable =3D true;
-=09=09=09=09=09} else
+=09=09=09=09=09else
 =09=09=09=09=09=09network->bCcxRmEnable =3D false;
 =09=09=09=09=09//
 =09=09=09=09=09// CCXv4 Table 59-1 MBSSID Masks.
 =09=09=09=09=09//
 =09=09=09=09=09network->MBssidMask =3D network->CcxRmState[1] & 0x07;
-=09=09=09=09=09if (network->MBssidMask !=3D 0)
-=09=09=09=09=09{
+=09=09=09=09=09if (network->MBssidMask !=3D 0) {
 =09=09=09=09=09=09network->bMBssidValid =3D true;
 =09=09=09=09=09=09network->MBssidMask =3D 0xff << (network->MBssidMask);
 =09=09=09=09=09=09ether_addr_copy(network->MBssid, network->bssid);
@@ -1929,8 +1907,7 @@ int ieee80211_parse_info_param(struct ieee80211_devic=
e *ieee,
 =09=09=09=09info_element->data[0] =3D=3D 0x00 &&
 =09=09=09=09info_element->data[1] =3D=3D 0x40 &&
 =09=09=09=09info_element->data[2] =3D=3D 0x96 &&
-=09=09=09=09info_element->data[3] =3D=3D 0x03)
-=09=09=09{
+=09=09=09=09info_element->data[3] =3D=3D 0x03) {
 =09=09=09=09if (info_element->len =3D=3D 5) {
 =09=09=09=09=09network->bWithCcxVerNum =3D true;
 =09=09=09=09=09network->BssCcxVerNumber =3D info_element->data[4];
@@ -1985,16 +1962,14 @@ int ieee80211_parse_info_param(struct ieee80211_dev=
ice *ieee,
 =09=09case MFIE_TYPE_AIRONET:
 =09=09=09IEEE80211_DEBUG_SCAN("MFIE_TYPE_AIRONET: %d bytes\n",
 =09=09=09=09=09     info_element->len);
-=09=09=09if (info_element->len > IE_CISCO_FLAG_POSITION)
-=09=09=09{
+=09=09=09if (info_element->len > IE_CISCO_FLAG_POSITION) {
 =09=09=09=09network->bWithAironetIE =3D true;
=20
 =09=09=09=09// CCX 1 spec v1.13, A01.1 CKIP Negotiation (page23):
 =09=09=09=09// "A Cisco access point advertises support for CKIP in beacon=
 and probe response packets,
 =09=09=09=09//  by adding an Aironet element and setting one or both of th=
e CKIP negotiation bits."
 =09=09=09=09if ((info_element->data[IE_CISCO_FLAG_POSITION] & SUPPORT_CKIP=
_MIC)=09||
-=09=09=09=09=09(info_element->data[IE_CISCO_FLAG_POSITION] & SUPPORT_CKIP_=
PK))
-=09=09=09=09{
+=09=09=09=09=09(info_element->data[IE_CISCO_FLAG_POSITION] & SUPPORT_CKIP_=
PK)) {
 =09=09=09=09=09network->bCkipSupported =3D true;
 =09=09=09=09} else {
 =09=09=09=09=09network->bCkipSupported =3D false;
@@ -2214,8 +2189,7 @@ static inline void update_network(struct ieee80211_ne=
twork *dst,
 =09dst->rates_len =3D src->rates_len;
 =09memcpy(dst->rates_ex, src->rates_ex, src->rates_ex_len);
 =09dst->rates_ex_len =3D src->rates_ex_len;
-=09if (src->ssid_len > 0)
-=09{
+=09if (src->ssid_len > 0) {
 =09=09memset(dst->ssid, 0, dst->ssid_len);
 =09=09dst->ssid_len =3D src->ssid_len;
 =09=09memcpy(dst->ssid, src->ssid, src->ssid_len);
@@ -2224,8 +2198,7 @@ static inline void update_network(struct ieee80211_ne=
twork *dst,
 =09dst->flags =3D src->flags;
 =09dst->time_stamp[0] =3D src->time_stamp[0];
 =09dst->time_stamp[1] =3D src->time_stamp[1];
-=09if (src->flags & NETWORK_HAS_ERP_VALUE)
-=09{
+=09if (src->flags & NETWORK_HAS_ERP_VALUE) {
 =09=09dst->erp_value =3D src->erp_value;
 =09=09dst->berp_info_valid =3D src->berp_info_valid =3D true;
 =09}
@@ -2379,41 +2352,33 @@ static inline void ieee80211_process_probe_response=
(
=20
 =09if (!is_legal_channel(ieee, network->channel))
 =09=09goto out;
-=09if (ieee->bGlobalDomain)
-=09{
-=09=09if (fc =3D=3D IEEE80211_STYPE_PROBE_RESP)
-=09=09{
-=09=09=09// Case 1: Country code
+=09if (ieee->bGlobalDomain) {
+=09=09if (fc =3D=3D IEEE80211_STYPE_PROBE_RESP) {
 =09=09=09if (IS_COUNTRY_IE_VALID(ieee)) {
+=09=09=09=09// Case 1: Country code
 =09=09=09=09if (!is_legal_channel(ieee, network->channel)) {
 =09=09=09=09=09printk("GetScanInfo(): For Country code, filter probe respo=
nse at channel(%d).\n", network->channel);
 =09=09=09=09=09goto out;
 =09=09=09=09}
-=09=09=09}
-=09=09=09// Case 2: No any country code.
-=09=09=09else
-=09=09=09{
+=09=09=09} else {
+=09=09=09=09// Case 2: No any country code.
 =09=09=09=09// Filter over channel ch12~14
-=09=09=09=09if (network->channel > 11)
-=09=09=09=09{
+=09=09=09=09if (network->channel > 11) {
 =09=09=09=09=09printk("GetScanInfo(): For Global Domain, filter probe resp=
onse at channel(%d).\n", network->channel);
 =09=09=09=09=09goto out;
 =09=09=09=09}
 =09=09=09}
 =09=09} else {
-=09=09=09// Case 1: Country code
 =09=09=09if (IS_COUNTRY_IE_VALID(ieee)) {
+=09=09=09=09// Case 1: Country code
 =09=09=09=09if (!is_legal_channel(ieee, network->channel)) {
 =09=09=09=09=09printk("GetScanInfo(): For Country code, filter beacon at c=
hannel(%d).\n", network->channel);
 =09=09=09=09=09goto out;
 =09=09=09=09}
-=09=09=09}
-=09=09=09// Case 2: No any country code.
-=09=09=09else
-=09=09=09{
+=09=09=09} else {
+=09=09=09=09// Case 2: No any country code.
 =09=09=09=09// Filter over channel ch12~14
-=09=09=09=09if (network->channel > 14)
-=09=09=09=09{
+=09=09=09=09if (network->channel > 14) {
 =09=09=09=09=09printk("GetScanInfo(): For Global Domain, filter beacon at =
channel(%d).\n", network->channel);
 =09=09=09=09=09goto out;
 =09=09=09=09}
@@ -2442,8 +2407,7 @@ static inline void ieee80211_process_probe_response(
 =09=09else
 =09=09=09ieee->current_network.buseprotection =3D false;
 =09=09}
-=09=09if (is_beacon(beacon->header.frame_ctl))
-=09=09{
+=09=09if (is_beacon(beacon->header.frame_ctl)) {
 =09=09=09if (ieee->state =3D=3D IEEE80211_LINKED)
 =09=09=09=09ieee->LinkDetectInfo.NumRecvBcnInPeriod++;
 =09=09} else //hidden AP
diff --git a/drivers/staging/rtl8192u/ieee80211/ieee80211_tx.c b/drivers/st=
aging/rtl8192u/ieee80211/ieee80211_tx.c
index fc6eb97801e1..c49357067735 100644
--- a/drivers/staging/rtl8192u/ieee80211/ieee80211_tx.c
+++ b/drivers/staging/rtl8192u/ieee80211/ieee80211_tx.c
@@ -214,7 +214,8 @@ int ieee80211_encrypt_fragment(
 }
=20
=20
-void ieee80211_txb_free(struct ieee80211_txb *txb) {
+void ieee80211_txb_free(struct ieee80211_txb *txb)
+{
 =09//int i;
 =09if (unlikely(!txb))
 =09=09return;
@@ -333,8 +334,7 @@ static void ieee80211_tx_query_agg_cap(struct ieee80211=
_device *ieee,
 =09=09}
 =09}
 FORCED_AGG_SETTING:
-=09switch (pHTInfo->ForcedAMPDUMode )
-=09{
+=09switch (pHTInfo->ForcedAMPDUMode ) {
 =09=09case HT_AGG_AUTO:
 =09=09=09break;
=20
@@ -424,19 +424,15 @@ static void ieee80211_query_protectionmode(struct iee=
e80211_device *ieee,
 =09if (is_broadcast_ether_addr(skb->data+16))  //check addr3 as infrastruc=
ture add3 is DA.
 =09=09return;
=20
-=09if (ieee->mode < IEEE_N_24G) //b, g mode
-=09{
+=09if (ieee->mode < IEEE_N_24G) /* b, g mode */ {
 =09=09=09// (1) RTS_Threshold is compared to the MPDU, not MSDU.
 =09=09=09// (2) If there are more than one frag in  this MSDU, only the fi=
rst frag uses protection frame.
 =09=09=09//=09=09Other fragments are protected by previous fragment.
 =09=09=09//=09=09So we only need to check the length of first fragment.
-=09=09if (skb->len > ieee->rts)
-=09=09{
+=09=09if (skb->len > ieee->rts) {
 =09=09=09tcb_desc->bRTSEnable =3D true;
 =09=09=09tcb_desc->rts_rate =3D MGN_24M;
-=09=09}
-=09=09else if (ieee->current_network.buseprotection)
-=09=09{
+=09=09} else if (ieee->current_network.buseprotection) {
 =09=09=09// Use CTS-to-SELF in protection mode.
 =09=09=09tcb_desc->bRTSEnable =3D true;
 =09=09=09tcb_desc->bCTSEnable =3D true;
@@ -444,43 +440,35 @@ static void ieee80211_query_protectionmode(struct iee=
e80211_device *ieee,
 =09=09}
 =09=09//otherwise return;
 =09=09return;
-=09}
-=09else
-=09{// 11n High throughput case.
+=09} else { // 11n High throughput case.
 =09=09PRT_HIGH_THROUGHPUT pHTInfo =3D ieee->pHTInfo;
-=09=09while (true)
-=09=09{
+=09=09while (true) {
 =09=09=09//check ERP protection
-=09=09=09if (ieee->current_network.buseprotection)
-=09=09=09{// CTS-to-SELF
+=09=09=09if (ieee->current_network.buseprotection) {// CTS-to-SELF
 =09=09=09=09tcb_desc->bRTSEnable =3D true;
 =09=09=09=09tcb_desc->bCTSEnable =3D true;
 =09=09=09=09tcb_desc->rts_rate =3D MGN_24M;
 =09=09=09=09break;
 =09=09=09}
 =09=09=09//check HT op mode
-=09=09=09if(pHTInfo->bCurrentHTSupport  && pHTInfo->bEnableHT)
-=09=09=09{
+=09=09=09if(pHTInfo->bCurrentHTSupport  && pHTInfo->bEnableHT) {
 =09=09=09=09u8 HTOpMode =3D pHTInfo->CurrentOpMode;
 =09=09=09=09if((pHTInfo->bCurBW40MHz && (HTOpMode =3D=3D 2 || HTOpMode =3D=
=3D 3)) ||
-=09=09=09=09=09=09=09(!pHTInfo->bCurBW40MHz && HTOpMode =3D=3D 3) )
-=09=09=09=09{
+=09=09=09=09=09=09=09(!pHTInfo->bCurBW40MHz && HTOpMode =3D=3D 3)) {
 =09=09=09=09=09tcb_desc->rts_rate =3D MGN_24M; // Rate is 24Mbps.
 =09=09=09=09=09tcb_desc->bRTSEnable =3D true;
 =09=09=09=09=09break;
 =09=09=09=09}
 =09=09=09}
 =09=09=09//check rts
-=09=09=09if (skb->len > ieee->rts)
-=09=09=09{
+=09=09=09if (skb->len > ieee->rts) {
 =09=09=09=09tcb_desc->rts_rate =3D MGN_24M; // Rate is 24Mbps.
 =09=09=09=09tcb_desc->bRTSEnable =3D true;
 =09=09=09=09break;
 =09=09=09}
 =09=09=09//to do list: check MIMO power save condition.
 =09=09=09//check AMPDU aggregation for TXOP
-=09=09=09if(tcb_desc->bAMPDUEnable)
-=09=09=09{
+=09=09=09if(tcb_desc->bAMPDUEnable) {
 =09=09=09=09tcb_desc->rts_rate =3D MGN_24M; // Rate is 24Mbps.
 =09=09=09=09// According to 8190 design, firmware sends CF-End only if RTS=
/CTS is enabled. However, it degrads
 =09=09=09=09// throughput around 10M, so we disable of this mechanism. 200=
7.08.03 by Emily
@@ -488,8 +476,7 @@ static void ieee80211_query_protectionmode(struct ieee8=
0211_device *ieee,
 =09=09=09=09break;
 =09=09=09}
 =09=09=09//check IOT action
-=09=09=09if(pHTInfo->IOTAction & HT_IOT_ACT_FORCED_CTS2SELF)
-=09=09=09{
+=09=09=09if(pHTInfo->IOTAction & HT_IOT_ACT_FORCED_CTS2SELF) {
 =09=09=09=09tcb_desc->bCTSEnable=09=3D true;
 =09=09=09=09tcb_desc->rts_rate  =3D=09MGN_24M;
 =09=09=09=09tcb_desc->bRTSEnable =3D true;
@@ -541,8 +528,7 @@ static void ieee80211_txrate_selectmode(struct ieee8021=
1_device *ieee,
=20
 =09if (ieee->bTxUseDriverAssingedRate)
 =09=09tcb_desc->bTxUseDriverAssingedRate =3D true;
-=09if (!tcb_desc->bTxDisableRateFallBack || !tcb_desc->bTxUseDriverAssinge=
dRate)
-=09{
+=09if (!tcb_desc->bTxDisableRateFallBack || !tcb_desc->bTxUseDriverAssinge=
dRate) {
 =09=09if (ieee->iw_mode =3D=3D IW_MODE_INFRA || ieee->iw_mode =3D=3D IW_MO=
DE_ADHOC)
 =09=09=09tcb_desc->RATRIndex =3D 0;
 =09}
@@ -553,11 +539,9 @@ static void ieee80211_query_seqnum(struct ieee80211_de=
vice *ieee,
 {
 =09if (is_multicast_ether_addr(dst))
 =09=09return;
-=09if (IsQoSDataFrame(skb->data)) //we deal qos data only
-=09{
+=09if (IsQoSDataFrame(skb->data)) /* we deal qos data only */ {
 =09=09struct tx_ts_record *pTS =3D NULL;
-=09=09if (!GetTs(ieee, (struct ts_common_info **)(&pTS), dst, skb->priorit=
y, TX_DIR, true))
-=09=09{
+=09=09if (!GetTs(ieee, (struct ts_common_info **)(&pTS), dst, skb->priorit=
y, TX_DIR, true)) {
 =09=09=09return;
 =09=09}
 =09=09pTS->tx_cur_seq =3D (pTS->tx_cur_seq + 1) % 4096;
@@ -749,15 +733,13 @@ int ieee80211_xmit(struct sk_buff *skb, struct net_de=
vice *dev)
 =09=09=09}
 =09=09=09skb_reserve(skb_frag, ieee->tx_headroom);
=20
-=09=09=09if (encrypt){
+=09=09=09if (encrypt) {
 =09=09=09=09if (ieee->hwsec_active)
 =09=09=09=09=09tcb_desc->bHwSec =3D 1;
 =09=09=09=09else
 =09=09=09=09=09tcb_desc->bHwSec =3D 0;
 =09=09=09=09skb_reserve(skb_frag, crypt->ops->extra_prefix_len);
-=09=09=09}
-=09=09=09else
-=09=09=09{
+=09=09=09} else {
 =09=09=09=09tcb_desc->bHwSec =3D 0;
 =09=09=09}
 =09=09=09frag_hdr =3D skb_put_data(skb_frag, &header, hdr_len);
@@ -775,8 +757,7 @@ int ieee80211_xmit(struct sk_buff *skb, struct net_devi=
ce *dev)
 =09=09=09=09bytes =3D bytes_last_frag;
 =09=09=09}
 =09=09=09//if(ieee->current_network.QoS_Enable)
-=09=09=09if(qos_actived)
-=09=09=09{
+=09=09=09if(qos_actived) {
 =09=09=09=09// add 1 only indicate to corresponding seq number control 200=
6/7/12
 =09=09=09=09frag_hdr->seq_ctl =3D cpu_to_le16(ieee->seq_ctrl[UP2AC(skb->pr=
iority)+1]<<4 | i);
 =09=09=09} else {
@@ -806,17 +787,16 @@ int ieee80211_xmit(struct sk_buff *skb, struct net_de=
vice *dev)
 =09=09=09=09skb_put(skb_frag, 4);
 =09=09}
=20
-=09=09if(qos_actived)
-=09=09{
-=09=09  if (ieee->seq_ctrl[UP2AC(skb->priority) + 1] =3D=3D 0xFFF)
-=09=09=09ieee->seq_ctrl[UP2AC(skb->priority) + 1] =3D 0;
-=09=09  else
-=09=09=09ieee->seq_ctrl[UP2AC(skb->priority) + 1]++;
+=09=09if (qos_actived) {
+=09=09=09if (ieee->seq_ctrl[UP2AC(skb->priority) + 1] =3D=3D 0xFFF)
+=09=09=09=09ieee->seq_ctrl[UP2AC(skb->priority) + 1] =3D 0;
+=09=09=09else
+=09=09=09=09ieee->seq_ctrl[UP2AC(skb->priority) + 1]++;
 =09=09} else {
-=09=09  if (ieee->seq_ctrl[0] =3D=3D 0xFFF)
-=09=09=09ieee->seq_ctrl[0] =3D 0;
-=09=09  else
-=09=09=09ieee->seq_ctrl[0]++;
+=09=09=09if (ieee->seq_ctrl[0] =3D=3D 0xFFF)
+=09=09=09=09ieee->seq_ctrl[0] =3D 0;
+=09=09=09else
+=09=09=09=09ieee->seq_ctrl[0]++;
 =09=09}
 =09} else {
 =09=09if (unlikely(skb->len < sizeof(struct rtl_80211_hdr_3addr))) {
@@ -839,8 +819,7 @@ int ieee80211_xmit(struct sk_buff *skb, struct net_devi=
ce *dev)
=20
  success:
 //WB add to fill data tcb_desc here. only first fragment is considered, ne=
ed to change, and you may remove to other place.
-=09if (txb)
-=09{
+=09if (txb) {
 =09=09struct cb_desc *tcb_desc =3D (struct cb_desc *)(txb->fragments[0]->c=
b + MAX_DEV_ADDR_SIZE);
 =09=09tcb_desc->bTxEnableFwCalcDur =3D 1;
 =09=09if (is_multicast_ether_addr(header.addr1))
diff --git a/drivers/staging/rtl8192u/ieee80211/ieee80211_wx.c b/drivers/st=
aging/rtl8192u/ieee80211/ieee80211_wx.c
index be08cd1d37a7..8ad85331f020 100644
--- a/drivers/staging/rtl8192u/ieee80211/ieee80211_wx.c
+++ b/drivers/staging/rtl8192u/ieee80211/ieee80211_wx.c
@@ -130,8 +130,7 @@ static inline char *rtl819x_translate_scan(struct ieee8=
0211_device *ieee,
 =09=09=09max_rate =3D rate;
 =09}
=20
-=09if (network->mode >=3D IEEE_N_24G)//add N rate here;
-=09{
+=09if (network->mode >=3D IEEE_N_24G) /* add N rate here */ {
 =09=09struct ht_capability_ele *ht_cap =3D NULL;
 =09=09bool is40M =3D false, isShortGI =3D false;
 =09=09u8 max_mcs =3D 0;
diff --git a/drivers/staging/rtl8192u/ieee80211/rtl819x_HT.h b/drivers/stag=
ing/rtl8192u/ieee80211/rtl819x_HT.h
index b7769bca9740..3fca0d3a1d05 100644
--- a/drivers/staging/rtl8192u/ieee80211/rtl819x_HT.h
+++ b/drivers/staging/rtl8192u/ieee80211/rtl819x_HT.h
@@ -273,8 +273,7 @@ typedef enum _HT_AGGRE_SIZE {
 }HT_AGGRE_SIZE_E, *PHT_AGGRE_SIZE_E;
=20
 /* Indicate different AP vendor for IOT issue */
-typedef enum _HT_IOT_PEER
-{
+typedef enum _HT_IOT_PEER {
 =09HT_IOT_PEER_UNKNOWN =3D 0,
 =09HT_IOT_PEER_REALTEK =3D 1,
 =09HT_IOT_PEER_BROADCOM =3D 2,
--=20
2.22.0



