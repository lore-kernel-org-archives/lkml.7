Return-Path: <SRS0=sYEh=YW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EA58CCA9EAE
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Oct 2019 13:51:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B190121479
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Oct 2019 13:51:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="BoG4izl4"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389085AbfJ2NvZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 29 Oct 2019 09:51:25 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:45503 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S2389060AbfJ2NvW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Oct 2019 09:51:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1572357080;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=tDNUWkKpQnw1yHaB0W3iJg2EXkt52WFEwMuPDE5I/Vc=;
        b=BoG4izl4/HOP08sjDQSExKXV7JvlZcfxyQ3XxGW9pwkSgas3fQSGLeARHIaBm6p5QsnPiE
        9gdXG2lYi9j8zLmqK4s+WGDiQhfllasvS6ygwLaoBML4onOJrKV0+yRP+w08Jzktahn29K
        ehHBhaJx6uAlMcsTnI61OqFw1OqIHjU=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-89-xlvDyKORMYGDweHpHtTK8w-1; Tue, 29 Oct 2019 09:51:11 -0400
Received: by mail-wm1-f70.google.com with SMTP id a81so891187wma.4
        for <linux-kernel@vger.kernel.org>; Tue, 29 Oct 2019 06:51:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=SgCGxqUSVZkkV529W9PQ2OLPt6lHiQPIyC5Y4Q9bYuA=;
        b=ZXEFHLH5wWes6zFpYLeP8OR3sdiznA8fZPhNZdLYPrA5Xj1UP9bM3bl3ziiYll+RY5
         A6BiZl4H8S2vSSw9qNQWyjRHTE1EtbE6572kPR/YyG2W7iG42eXKYgueNUtStDN0WiW1
         k/11kQqjXYQ7nlAVNIIPJpQ87NJT1WZW07/jwHMoIeOV0uMhnm1il2LuRWBLYf0FAqjX
         cKGHcRJ8KMaO//E2iyAAZUt4ifRYa+1UEsZ9j6WhsHFlS+TzroCGg9xIGXdQ9bNhc/2Z
         gG9drxgKajkaNsVr04KJNOEtGcYhOJgXI8xIbd5j4j99bpSg84YumrwBLiXcC8xaMNay
         CKNA==
X-Gm-Message-State: APjAAAXxgHGiunP1PVeGU1+kucfPc/L2pHminGK+mm8dfoY+TBzNjCFC
        Ds1hI4btBuH8OAS9vJpT/60WHFOHW16/HG88JjgKEE14ZR8GMM01XY3H4/7rM8Beu5zVu6tHEE9
        5//6UN+JFbBOPT8xm7mJi7mfO
X-Received: by 2002:a1c:5459:: with SMTP id p25mr4009083wmi.109.1572357070415;
        Tue, 29 Oct 2019 06:51:10 -0700 (PDT)
X-Google-Smtp-Source: APXvYqzzBABeXGWvah4RWCBM8DqkxgMA5OepJvzaZk5Rv2Cr/nCiIuL4/tk/KZxjcx57+oPv9S+yrA==
X-Received: by 2002:a1c:5459:: with SMTP id p25mr4009050wmi.109.1572357070109;
        Tue, 29 Oct 2019 06:51:10 -0700 (PDT)
Received: from mcroce-redhat.mxp.redhat.com (nat-pool-mxp-t.redhat.com. [149.6.153.186])
        by smtp.gmail.com with ESMTPSA id 189sm2556920wmc.7.2019.10.29.06.51.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Oct 2019 06:51:09 -0700 (PDT)
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
Subject: [PATCH net-next v2 3/4] flow_dissector: extract more ICMP information
Date:   Tue, 29 Oct 2019 14:50:52 +0100
Message-Id: <20191029135053.10055-4-mcroce@redhat.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20191029135053.10055-1-mcroce@redhat.com>
References: <20191029135053.10055-1-mcroce@redhat.com>
MIME-Version: 1.0
X-MC-Unique: xlvDyKORMYGDweHpHtTK8w-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=WINDOWS-1252
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The ICMP flow dissector currently parses only the Type and Code fields.
Some ICMP packets (echo, timestamp) have a 16 bit Identifier field which
is used to correlate packets.
Add such field in flow_dissector_key_icmp and replace skb_flow_get_be16()
with a more complex function which populate this field.

Signed-off-by: Matteo Croce <mcroce@redhat.com>
---
 include/net/flow_dissector.h | 19 +++++----
 net/core/flow_dissector.c    | 74 ++++++++++++++++++++++++------------
 2 files changed, 61 insertions(+), 32 deletions(-)

diff --git a/include/net/flow_dissector.h b/include/net/flow_dissector.h
index 7747af3cc500..f8541d018848 100644
--- a/include/net/flow_dissector.h
+++ b/include/net/flow_dissector.h
@@ -6,6 +6,8 @@
 #include <linux/in6.h>
 #include <uapi/linux/if_ether.h>
=20
+struct sk_buff;
+
 /**
  * struct flow_dissector_key_control:
  * @thoff: Transport header offset
@@ -156,19 +158,16 @@ struct flow_dissector_key_ports {
=20
 /**
  * flow_dissector_key_icmp:
- *=09@ports: type and code of ICMP header
- *=09=09icmp: ICMP type (high) and code (low)
  *=09=09type: ICMP type
  *=09=09code: ICMP code
+ *=09=09id:   session identifier
  */
 struct flow_dissector_key_icmp {
-=09union {
-=09=09__be16 icmp;
-=09=09struct {
-=09=09=09u8 type;
-=09=09=09u8 code;
-=09=09};
+=09struct {
+=09=09u8 type;
+=09=09u8 code;
 =09};
+=09u16 id;
 };
=20
 /**
@@ -282,6 +281,7 @@ struct flow_keys {
 =09struct flow_dissector_key_vlan cvlan;
 =09struct flow_dissector_key_keyid keyid;
 =09struct flow_dissector_key_ports ports;
+=09struct flow_dissector_key_icmp icmp;
 =09/* 'addrs' must be the last member */
 =09struct flow_dissector_key_addrs addrs;
 };
@@ -316,6 +316,9 @@ static inline bool flow_keys_have_l4(const struct flow_=
keys *keys)
 }
=20
 u32 flow_hash_from_keys(struct flow_keys *keys);
+void skb_flow_get_icmp_tci(const struct sk_buff *skb,
+=09=09=09   struct flow_dissector_key_icmp *key_icmp,
+=09=09=09   void *data, int thoff, int hlen);
=20
 static inline bool dissector_uses_key(const struct flow_dissector *flow_di=
ssector,
 =09=09=09=09      enum flow_dissector_key_id key_id)
diff --git a/net/core/flow_dissector.c b/net/core/flow_dissector.c
index 6443fac65ce8..0d014b81b269 100644
--- a/net/core/flow_dissector.c
+++ b/net/core/flow_dissector.c
@@ -147,27 +147,6 @@ int skb_flow_dissector_bpf_prog_detach(const union bpf=
_attr *attr)
 =09mutex_unlock(&flow_dissector_mutex);
 =09return 0;
 }
-/**
- * skb_flow_get_be16 - extract be16 entity
- * @skb: sk_buff to extract from
- * @poff: offset to extract at
- * @data: raw buffer pointer to the packet
- * @hlen: packet header length
- *
- * The function will try to retrieve a be32 entity at
- * offset poff
- */
-static __be16 skb_flow_get_be16(const struct sk_buff *skb, int poff,
-=09=09=09=09void *data, int hlen)
-{
-=09__be16 *u, _u;
-
-=09u =3D __skb_header_pointer(skb, poff, sizeof(_u), data, hlen, &_u);
-=09if (u)
-=09=09return *u;
-
-=09return 0;
-}
=20
 /**
  * __skb_flow_get_ports - extract the upper layer ports and return them
@@ -203,8 +182,54 @@ __be32 __skb_flow_get_ports(const struct sk_buff *skb,=
 int thoff, u8 ip_proto,
 }
 EXPORT_SYMBOL(__skb_flow_get_ports);
=20
-/* If FLOW_DISSECTOR_KEY_ICMP is set, get the Type and Code from an ICMP p=
acket
- * using skb_flow_get_be16().
+static bool icmp_has_id(u8 type)
+{
+=09switch (type) {
+=09case ICMP_ECHO:
+=09case ICMP_ECHOREPLY:
+=09case ICMP_TIMESTAMP:
+=09case ICMP_TIMESTAMPREPLY:
+=09case ICMPV6_ECHO_REQUEST:
+=09case ICMPV6_ECHO_REPLY:
+=09=09return true;
+=09}
+
+=09return false;
+}
+
+/**
+ * skb_flow_get_icmp_tci - extract ICMP(6) Type, Code and Identifier field=
s
+ * @skb: sk_buff to extract from
+ * @key_icmp: struct flow_dissector_key_icmp to fill
+ * @data: raw buffer pointer to the packet
+ * @toff: offset to extract at
+ * @hlen: packet header length
+ */
+void skb_flow_get_icmp_tci(const struct sk_buff *skb,
+=09=09=09   struct flow_dissector_key_icmp *key_icmp,
+=09=09=09   void *data, int thoff, int hlen)
+{
+=09struct icmphdr *ih, _ih;
+
+=09ih =3D __skb_header_pointer(skb, thoff, sizeof(_ih), data, hlen, &_ih);
+=09if (!ih)
+=09=09return;
+
+=09key_icmp->type =3D ih->type;
+=09key_icmp->code =3D ih->code;
+
+=09/* As we use 0 to signal that the Id field is not present,
+=09 * avoid confusion with packets without such field
+=09 */
+=09if (icmp_has_id(ih->type))
+=09=09key_icmp->id =3D ih->un.echo.id ? : 1;
+=09else
+=09=09key_icmp->id =3D 0;
+}
+EXPORT_SYMBOL(skb_flow_get_icmp_tci);
+
+/* If FLOW_DISSECTOR_KEY_ICMP is set, dissect an ICMP packet
+ * using skb_flow_get_icmp_tci().
  */
 static void __skb_flow_dissect_icmp(const struct sk_buff *skb,
 =09=09=09=09    struct flow_dissector *flow_dissector,
@@ -219,7 +244,8 @@ static void __skb_flow_dissect_icmp(const struct sk_buf=
f *skb,
 =09key_icmp =3D skb_flow_dissector_target(flow_dissector,
 =09=09=09=09=09     FLOW_DISSECTOR_KEY_ICMP,
 =09=09=09=09=09     target_container);
-=09key_icmp->icmp =3D skb_flow_get_be16(skb, thoff, data, hlen);
+
+=09skb_flow_get_icmp_tci(skb, key_icmp, data, thoff, hlen);
 }
=20
 void skb_flow_dissect_meta(const struct sk_buff *skb,
--=20
2.21.0

