Return-Path: <SRS0=BTkm=YO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4A474CA9EB7
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Oct 2019 20:11:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 18B602084C
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Oct 2019 20:11:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="b5rT68h0"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730353AbfJUULo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 21 Oct 2019 16:11:44 -0400
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:29874 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1730065AbfJUULn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Oct 2019 16:11:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1571688702;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=fKQgbWuikOflsblq1Eqq9EME7qTpUP9bfFsTutkuQ7M=;
        b=b5rT68h0d8fFbdZrLv0rG8XyCKgFjqe9koChbVNxZFIfJaQbLJuiF6vGZJWtTihaWRfZgc
        mq+mSjidNe1b6r0OWmslDkRlWdijiQVC7VJj4db7ytZwpJud4DKPOW8ztTAJOtf8MOLpl6
        wprdhpQY8sBlqeBa57OGmBBBHPPNloQ=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-79-c0HCnvEUP7efnzr8eLAeDw-1; Mon, 21 Oct 2019 16:11:38 -0400
Received: by mail-wr1-f70.google.com with SMTP id f4so7880756wrj.12
        for <linux-kernel@vger.kernel.org>; Mon, 21 Oct 2019 13:11:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=51LIoCpMIxhBzrnm/L7yqZ4c2j05Lx5qfysNEUKia7M=;
        b=i+A4l2pIhkvPAoDX2ZDVniao0Tto7FL80LWy3tE8fwpN9SpEZPAYlsxeKx+cZ6yyq/
         c/O4X02Wx8s+jCM/QPRzM8rG32p8L0AMutkcQAx1ttZXHE8Ti+pt2Diu+lFGJH6+40hR
         Skhyt8NRfAVRcsDCTiZH6VhCAb0iUlJtIj1/B9iANVL/41WL1ppwpsDl+o/wcO9HWWNe
         lWJjAS8XygV0pzk94jHEiyVlTsI1RbKV1AVKB00JkvV20WUhqzpnyCqbhp4i5xyN7xXM
         68J76vsjjiEpujl2FVMZnnlsunxEXVrzUuiAhPn9gDqHFlXFmvfke2I0Gd4xsgkqtIwl
         bHbQ==
X-Gm-Message-State: APjAAAXrkpg4yueh1iswNh733J+E7sI514DTvHtNEAfPhDk0FSTYCUTI
        9UpLaYOfqlJtplTUxDU+BmVlEFoIzxfI9BXMAjfyyGLHO9rAXKlmQka5vvKI6TViMJpr+QjZ7za
        ONRVO19exRE9KLPJsPxrKTlae
X-Received: by 2002:a1c:7c13:: with SMTP id x19mr20545149wmc.80.1571688697036;
        Mon, 21 Oct 2019 13:11:37 -0700 (PDT)
X-Google-Smtp-Source: APXvYqw4eoHxAWTQ+LvXncS6zBXjbLAyI3z6egZ5xoXP+n9ihgqP+iqXdVTfi0xJTu60J9hIc740cg==
X-Received: by 2002:a1c:7c13:: with SMTP id x19mr20545124wmc.80.1571688696804;
        Mon, 21 Oct 2019 13:11:36 -0700 (PDT)
Received: from turbo.teknoraver.net (net-109-115-41-234.cust.vodafonedsl.it. [109.115.41.234])
        by smtp.gmail.com with ESMTPSA id l18sm20701933wrn.48.2019.10.21.13.11.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Oct 2019 13:11:36 -0700 (PDT)
From:   Matteo Croce <mcroce@redhat.com>
To:     netdev@vger.kernel.org
Cc:     Jay Vosburgh <j.vosburgh@gmail.com>,
        Veaceslav Falico <vfalico@gmail.com>,
        Andy Gospodarek <andy@greyhouse.net>,
        "David S . Miller " <davem@davemloft.net>,
        Stanislav Fomichev <sdf@google.com>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Song Liu <songliubraving@fb.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Paul Blakey <paulb@mellanox.com>, linux-kernel@vger.kernel.org
Subject: [PATCH net-next 4/4] bonding: balance ICMP echoes in layer3+4 mode
Date:   Mon, 21 Oct 2019 22:09:48 +0200
Message-Id: <20191021200948.23775-5-mcroce@redhat.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20191021200948.23775-1-mcroce@redhat.com>
References: <20191021200948.23775-1-mcroce@redhat.com>
MIME-Version: 1.0
X-MC-Unique: c0HCnvEUP7efnzr8eLAeDw-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=WINDOWS-1252
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The bonding uses the L4 ports to balance flows between slaves.
As the ICMP protocol has no ports, those packets are sent all to the
same device:

    # tcpdump -qltnni veth0 ip |sed 's/^/0: /' &
    # tcpdump -qltnni veth1 ip |sed 's/^/1: /' &
    # ping -qc1 192.168.0.2
    1: IP 192.168.0.1 > 192.168.0.2: ICMP echo request, id 315, seq 1, leng=
th 64
    1: IP 192.168.0.2 > 192.168.0.1: ICMP echo reply, id 315, seq 1, length=
 64
    # ping -qc1 192.168.0.2
    1: IP 192.168.0.1 > 192.168.0.2: ICMP echo request, id 316, seq 1, leng=
th 64
    1: IP 192.168.0.2 > 192.168.0.1: ICMP echo reply, id 316, seq 1, length=
 64
    # ping -qc1 192.168.0.2
    1: IP 192.168.0.1 > 192.168.0.2: ICMP echo request, id 317, seq 1, leng=
th 64
    1: IP 192.168.0.2 > 192.168.0.1: ICMP echo reply, id 317, seq 1, length=
 64

But some ICMP packets have an Identifier field which is
used to match packets within sessions, let's use this value in the hash
function to balance these packets between bond slaves:

    # ping -qc1 192.168.0.2
    0: IP 192.168.0.1 > 192.168.0.2: ICMP echo request, id 303, seq 1, leng=
th 64
    0: IP 192.168.0.2 > 192.168.0.1: ICMP echo reply, id 303, seq 1, length=
 64
    # ping -qc1 192.168.0.2
    1: IP 192.168.0.1 > 192.168.0.2: ICMP echo request, id 304, seq 1, leng=
th 64
    1: IP 192.168.0.2 > 192.168.0.1: ICMP echo reply, id 304, seq 1, length=
 64

Signed-off-by: Matteo Croce <mcroce@redhat.com>
---
 drivers/net/bonding/bond_main.c | 22 +++++++++++++++++-----
 1 file changed, 17 insertions(+), 5 deletions(-)

diff --git a/drivers/net/bonding/bond_main.c b/drivers/net/bonding/bond_mai=
n.c
index 21d8fcc83c9c..83afb03f4d07 100644
--- a/drivers/net/bonding/bond_main.c
+++ b/drivers/net/bonding/bond_main.c
@@ -3267,6 +3267,8 @@ static bool bond_flow_dissect(struct bonding *bond, s=
truct sk_buff *skb,
 =09=09return skb_flow_dissect_flow_keys(skb, fk, 0);
=20
 =09fk->ports.ports =3D 0;
+=09fk->icmp.icmp =3D 0;
+=09fk->icmp.id =3D 0;
 =09noff =3D skb_network_offset(skb);
 =09if (skb->protocol =3D=3D htons(ETH_P_IP)) {
 =09=09if (unlikely(!pskb_may_pull(skb, noff + sizeof(*iph))))
@@ -3286,8 +3288,14 @@ static bool bond_flow_dissect(struct bonding *bond, =
struct sk_buff *skb,
 =09} else {
 =09=09return false;
 =09}
-=09if (bond->params.xmit_policy =3D=3D BOND_XMIT_POLICY_LAYER34 && proto >=
=3D 0)
-=09=09fk->ports.ports =3D skb_flow_get_ports(skb, noff, proto);
+=09if (bond->params.xmit_policy =3D=3D BOND_XMIT_POLICY_LAYER34 && proto >=
=3D 0) {
+=09=09if (proto =3D=3D IPPROTO_ICMP || proto =3D=3D IPPROTO_ICMPV6)
+=09=09=09skb_flow_get_icmp_tci(skb, &fk->icmp, skb->data,
+=09=09=09=09=09      skb_transport_offset(skb),
+=09=09=09=09=09      skb_headlen(skb));
+=09=09else
+=09=09=09fk->ports.ports =3D skb_flow_get_ports(skb, noff, proto);
+=09}
=20
 =09return true;
 }
@@ -3314,10 +3322,14 @@ u32 bond_xmit_hash(struct bonding *bond, struct sk_=
buff *skb)
 =09=09return bond_eth_hash(skb);
=20
 =09if (bond->params.xmit_policy =3D=3D BOND_XMIT_POLICY_LAYER23 ||
-=09    bond->params.xmit_policy =3D=3D BOND_XMIT_POLICY_ENCAP23)
+=09    bond->params.xmit_policy =3D=3D BOND_XMIT_POLICY_ENCAP23) {
 =09=09hash =3D bond_eth_hash(skb);
-=09else
-=09=09hash =3D (__force u32)flow.ports.ports;
+=09} else {
+=09=09if (flow.icmp.id)
+=09=09=09memcpy(&hash, &flow.icmp, sizeof(hash));
+=09=09else
+=09=09=09memcpy(&hash, &flow.ports.ports, sizeof(hash));
+=09}
 =09hash ^=3D (__force u32)flow_get_u32_dst(&flow) ^
 =09=09(__force u32)flow_get_u32_src(&flow);
 =09hash ^=3D (hash >> 16);
--=20
2.21.0

