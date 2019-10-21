Return-Path: <SRS0=BTkm=YO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A8D89CA9EAF
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Oct 2019 20:11:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 71A4B2053B
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Oct 2019 20:11:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="NZZyn7yd"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730333AbfJUULO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 21 Oct 2019 16:11:14 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:44166 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1729406AbfJUULN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Oct 2019 16:11:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1571688672;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=FXZ+SxgXr/2IGwUb0gOTBXyZ2gLzS6PaHZmM+kn9m+w=;
        b=NZZyn7ydNCA72ESKbU5cfsOCOtQvG5clDa/Yro9b1y/CNmEVd/a2GP2Wm9Y0TQ1JDWclwC
        pY4iV34EvHZTaRUAZ69NdNrVcCR4u9ioHRfRrlyXO5aZdlzYj0faPRzcEzIL07PTZ8fYlQ
        NnQm+AhthhWGBCABPa0W2XLYUPRli/g=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-268-yuOrQClzPByuManPIECIUw-1; Mon, 21 Oct 2019 16:11:04 -0400
Received: by mail-wm1-f72.google.com with SMTP id b10so1172791wmh.6
        for <linux-kernel@vger.kernel.org>; Mon, 21 Oct 2019 13:11:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=jJvmymGcUv0ZDOsi0Z21jQGhJ08AOs478/mU5pDqUEY=;
        b=RBtTI9gYZZAmXF9l1mAPLTkbTXCJC6FWwYXGXUygMR1WQCffSz4JqpHJu5JcCuniNX
         rb0+KrRmz2FbesWs1ObJrRr0Wt9RjN8PHE8n0XUBox48JOQXJC0RB5uTdj56lpj1867f
         6syd4JbjdxaoaB9cGdtS07NsFN4K8abTQXQ0UeqHElikzPnxigdhmiq3q7ia2GsQAEAV
         pw+LEO/SbBNwoHguD7gHx5WBz/3OwTEwfNUWCNtZfdwmL+39uI3dcyi907T/Jh7pkm5f
         zld4eIGeX4sNDNTyuj/uJsBVtp1ig25bwV4CkZPkufL0aQyqIAMFibDI/8ULx1kNFexN
         uNAw==
X-Gm-Message-State: APjAAAXVlRUvLPAdutyqvaydPjWQP8X6HOQGEzoiq55vB5rUXLjniNEp
        9B9cEbu1MGtw0jFKBTrtvaGb0peWjllpkQJ/I4IiZNM9JqzHKYFoYXehFPs27j5f/5XSwqvEiMg
        In9r6oDqIpEKHInnDDhXRR12L
X-Received: by 2002:adf:f145:: with SMTP id y5mr66187wro.330.1571688662773;
        Mon, 21 Oct 2019 13:11:02 -0700 (PDT)
X-Google-Smtp-Source: APXvYqy+sI/Xw1A3bu0WOul8+P7IPlqyM4jG0vQhFy1OpPQi1LCIpA14yvUaDPuSrhvcoK7tVZPyXA==
X-Received: by 2002:adf:f145:: with SMTP id y5mr66158wro.330.1571688662477;
        Mon, 21 Oct 2019 13:11:02 -0700 (PDT)
Received: from turbo.teknoraver.net (net-109-115-41-234.cust.vodafonedsl.it. [109.115.41.234])
        by smtp.gmail.com with ESMTPSA id l18sm20701933wrn.48.2019.10.21.13.11.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Oct 2019 13:11:01 -0700 (PDT)
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
Subject: [PATCH net-next 3/4] flow_dissector: extract more ICMP information
Date:   Mon, 21 Oct 2019 22:09:47 +0200
Message-Id: <20191021200948.23775-4-mcroce@redhat.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20191021200948.23775-1-mcroce@redhat.com>
References: <20191021200948.23775-1-mcroce@redhat.com>
MIME-Version: 1.0
X-MC-Unique: yuOrQClzPByuManPIECIUw-1
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
 include/net/flow_dissector.h | 10 +++++-
 net/core/flow_dissector.c    | 64 ++++++++++++++++++++++--------------
 2 files changed, 49 insertions(+), 25 deletions(-)

diff --git a/include/net/flow_dissector.h b/include/net/flow_dissector.h
index 7747af3cc500..86c6bf5eab31 100644
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
@@ -160,6 +162,7 @@ struct flow_dissector_key_ports {
  *=09=09icmp: ICMP type (high) and code (low)
  *=09=09type: ICMP type
  *=09=09code: ICMP code
+ *=09=09id:   session identifier
  */
 struct flow_dissector_key_icmp {
 =09union {
@@ -169,6 +172,7 @@ struct flow_dissector_key_icmp {
 =09=09=09u8 code;
 =09=09};
 =09};
+=09u16 id;
 };
=20
 /**
@@ -282,6 +286,7 @@ struct flow_keys {
 =09struct flow_dissector_key_vlan cvlan;
 =09struct flow_dissector_key_keyid keyid;
 =09struct flow_dissector_key_ports ports;
+=09struct flow_dissector_key_icmp icmp;
 =09/* 'addrs' must be the last member */
 =09struct flow_dissector_key_addrs addrs;
 };
@@ -312,10 +317,13 @@ void make_flow_keys_digest(struct flow_keys_digest *d=
igest,
=20
 static inline bool flow_keys_have_l4(const struct flow_keys *keys)
 {
-=09return (keys->ports.ports || keys->tags.flow_label);
+=09return keys->ports.ports || keys->tags.flow_label || keys->icmp.id;
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
index 6443fac65ce8..90dcf6f2ef19 100644
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
@@ -203,8 +182,44 @@ __be32 __skb_flow_get_ports(const struct sk_buff *skb,=
 int thoff, u8 ip_proto,
 }
 EXPORT_SYMBOL(__skb_flow_get_ports);
=20
-/* If FLOW_DISSECTOR_KEY_ICMP is set, get the Type and Code from an ICMP p=
acket
- * using skb_flow_get_be16().
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
+=09key_icmp->id =3D 0;
+=09switch (ih->type) {
+=09case ICMP_ECHO:
+=09case ICMP_ECHOREPLY:
+=09case ICMP_TIMESTAMP:
+=09case ICMP_TIMESTAMPREPLY:
+=09case ICMPV6_ECHO_REQUEST:
+=09case ICMPV6_ECHO_REPLY:
+=09=09/* As we use 0 to signal that the Id field is not present,
+=09=09 * avoid confusion with packets without such field
+=09=09 */
+=09=09key_icmp->id =3D ih->un.echo.id ? : 1;
+=09}
+}
+EXPORT_SYMBOL(skb_flow_get_icmp_tci);
+
+/* If FLOW_DISSECTOR_KEY_ICMP is set, dissect an ICMP packet
+ * using skb_flow_get_icmp_tci().
  */
 static void __skb_flow_dissect_icmp(const struct sk_buff *skb,
 =09=09=09=09    struct flow_dissector *flow_dissector,
@@ -219,7 +234,8 @@ static void __skb_flow_dissect_icmp(const struct sk_buf=
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

