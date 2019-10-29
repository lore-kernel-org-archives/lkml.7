Return-Path: <SRS0=sYEh=YW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 17E18CA9EAE
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Oct 2019 13:51:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DF6C720862
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Oct 2019 13:51:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Zl/mZjN9"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389035AbfJ2NvM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 29 Oct 2019 09:51:12 -0400
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:32435 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S2388802AbfJ2NvK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Oct 2019 09:51:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1572357068;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=c6Zm4IY7VrUnQ8RKTixaznYCgJL3nPqGqx5Lz+kk3DI=;
        b=Zl/mZjN9ihhNDn01j9ng4MrnuLxHpRdj9D67De0z5g+mh/tgChHyecBCiXcM5ev4PXIDLA
        H+QAJqTANZPGPYzvxZ9IpVzzD1YWar8enON47174efK/GKD+fgVPNSUXtitobIiC+iIx90
        jGgvNeoaLwnKnP0heDHrrEGRgQrTA8k=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-157-rpztvflxOyKyyOth_sBYoQ-1; Tue, 29 Oct 2019 09:51:07 -0400
Received: by mail-wm1-f70.google.com with SMTP id z23so763265wml.0
        for <linux-kernel@vger.kernel.org>; Tue, 29 Oct 2019 06:51:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=FOEIRt2uhE+VjfvSvcsGDHwxP6iiWF3+DKbQW0z4Upk=;
        b=ijFr9CaYoIW4Qr9Z4uFCfipe1wSgsyNhLzWHvNuR+5at40LwwpV2m0voktEiua8SY8
         eCtGfyNARiByohbw2OPIntHtmVzRpPIzU+cgp0TCqxd4U5qAoaWcIgGF/n5TiLBZEByU
         a6dXb+dxPJHgycxuZtmBBE0uBa1Kn0cFJh3+8vsy8BOdPgrWDVhKsQRgUMRfWKHDmSy5
         E5MJYLnBwL8OgdYB/3FcGxVQbipZmvmGFD3Fr4HXKiNoA+bReyE9TGoXqZUsqGyjzzDl
         kE2xW55VWoMMEARjZdIFp5LvjzOK01DMlJHtscdL7nyDkNoSN1a2T+BPeVj2nw7gaQk4
         F0Mg==
X-Gm-Message-State: APjAAAVBAqyJRvPgJR+jZUuRVKR1yU9L+GycUgGdlTQRRpaZcXBL6f6X
        E4QyZ7whVvyBmJETkLIu9KzDEJgxkBAsUVXBQWJEz5iOjJaWr2/QgoYvRUUSOYh5NKdY2zrxao8
        ORPEbAfGhsb1m1PBONSYdQXBa
X-Received: by 2002:adf:fc0a:: with SMTP id i10mr18965269wrr.257.1572357066102;
        Tue, 29 Oct 2019 06:51:06 -0700 (PDT)
X-Google-Smtp-Source: APXvYqxMIycPUBI6kScBBX8AgD5qg5eK3nEhPeqqO6kubTkmz5NyT2QRwAeb8InIxDnf1gzm5aoFpg==
X-Received: by 2002:adf:fc0a:: with SMTP id i10mr18965241wrr.257.1572357065777;
        Tue, 29 Oct 2019 06:51:05 -0700 (PDT)
Received: from mcroce-redhat.mxp.redhat.com (nat-pool-mxp-t.redhat.com. [149.6.153.186])
        by smtp.gmail.com with ESMTPSA id 189sm2556920wmc.7.2019.10.29.06.51.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Oct 2019 06:51:05 -0700 (PDT)
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
Subject: [PATCH net-next v2 2/4] flow_dissector: skip the ICMP dissector for non ICMP packets
Date:   Tue, 29 Oct 2019 14:50:51 +0100
Message-Id: <20191029135053.10055-3-mcroce@redhat.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20191029135053.10055-1-mcroce@redhat.com>
References: <20191029135053.10055-1-mcroce@redhat.com>
MIME-Version: 1.0
X-MC-Unique: rpztvflxOyKyyOth_sBYoQ-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=WINDOWS-1252
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

FLOW_DISSECTOR_KEY_ICMP is checked for every packet, not only ICMP ones.
Even if the test overhead is probably negligible, move the
ICMP dissector code under the big 'switch(ip_proto)' so it gets called
only for ICMP packets.

Signed-off-by: Matteo Croce <mcroce@redhat.com>
---
 net/core/flow_dissector.c | 34 +++++++++++++++++++++++++---------
 1 file changed, 25 insertions(+), 9 deletions(-)

diff --git a/net/core/flow_dissector.c b/net/core/flow_dissector.c
index affde70dad47..6443fac65ce8 100644
--- a/net/core/flow_dissector.c
+++ b/net/core/flow_dissector.c
@@ -203,6 +203,25 @@ __be32 __skb_flow_get_ports(const struct sk_buff *skb,=
 int thoff, u8 ip_proto,
 }
 EXPORT_SYMBOL(__skb_flow_get_ports);
=20
+/* If FLOW_DISSECTOR_KEY_ICMP is set, get the Type and Code from an ICMP p=
acket
+ * using skb_flow_get_be16().
+ */
+static void __skb_flow_dissect_icmp(const struct sk_buff *skb,
+=09=09=09=09    struct flow_dissector *flow_dissector,
+=09=09=09=09    void *target_container,
+=09=09=09=09    void *data, int thoff, int hlen)
+{
+=09struct flow_dissector_key_icmp *key_icmp;
+
+=09if (!dissector_uses_key(flow_dissector, FLOW_DISSECTOR_KEY_ICMP))
+=09=09return;
+
+=09key_icmp =3D skb_flow_dissector_target(flow_dissector,
+=09=09=09=09=09     FLOW_DISSECTOR_KEY_ICMP,
+=09=09=09=09=09     target_container);
+=09key_icmp->icmp =3D skb_flow_get_be16(skb, thoff, data, hlen);
+}
+
 void skb_flow_dissect_meta(const struct sk_buff *skb,
 =09=09=09   struct flow_dissector *flow_dissector,
 =09=09=09   void *target_container)
@@ -853,7 +872,6 @@ bool __skb_flow_dissect(const struct net *net,
 =09struct flow_dissector_key_basic *key_basic;
 =09struct flow_dissector_key_addrs *key_addrs;
 =09struct flow_dissector_key_ports *key_ports;
-=09struct flow_dissector_key_icmp *key_icmp;
 =09struct flow_dissector_key_tags *key_tags;
 =09struct flow_dissector_key_vlan *key_vlan;
 =09struct bpf_prog *attached =3D NULL;
@@ -1295,6 +1313,12 @@ bool __skb_flow_dissect(const struct net *net,
 =09=09=09=09       data, nhoff, hlen);
 =09=09break;
=20
+=09case IPPROTO_ICMP:
+=09case IPPROTO_ICMPV6:
+=09=09__skb_flow_dissect_icmp(skb, flow_dissector, target_container,
+=09=09=09=09=09data, nhoff, hlen);
+=09=09break;
+
 =09default:
 =09=09break;
 =09}
@@ -1308,14 +1332,6 @@ bool __skb_flow_dissect(const struct net *net,
 =09=09=09=09=09=09=09data, hlen);
 =09}
=20
-=09if (dissector_uses_key(flow_dissector,
-=09=09=09       FLOW_DISSECTOR_KEY_ICMP)) {
-=09=09key_icmp =3D skb_flow_dissector_target(flow_dissector,
-=09=09=09=09=09=09     FLOW_DISSECTOR_KEY_ICMP,
-=09=09=09=09=09=09     target_container);
-=09=09key_icmp->icmp =3D skb_flow_get_be16(skb, nhoff, data, hlen);
-=09}
-
 =09/* Process result of IP proto processing */
 =09switch (fdret) {
 =09case FLOW_DISSECT_RET_PROTO_AGAIN:
--=20
2.21.0

