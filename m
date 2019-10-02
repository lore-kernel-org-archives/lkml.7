Return-Path: <SRS0=zem1=X3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AA453C35280
	for <linux-kernel@archiver.kernel.org>; Wed,  2 Oct 2019 07:13:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5230520640
	for <linux-kernel@archiver.kernel.org>; Wed,  2 Oct 2019 07:13:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=web.de header.i=@web.de header.b="P1XdxfTW"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726931AbfJBHNE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 2 Oct 2019 03:13:04 -0400
Received: from mout.web.de ([212.227.15.14]:47565 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725860AbfJBHNE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Oct 2019 03:13:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
        s=dbaedf251592; t=1570000348;
        bh=dHb3uqBVM5O4++NJH0W96uSy/4RzWekaWy1y4+8l8W8=;
        h=X-UI-Sender-Class:Subject:From:To:Cc:References:Date:In-Reply-To;
        b=P1XdxfTW9HFIBd12DLYD+UiFvdLPMtTNfsoa/G5kZB/C27OkGw1sPXJR5NC8n/Jia
         K51efXePA8muVpN+6E9ODQtpxcin9EawIAr9kn483WM3cmW+PuuMTEIrnY4FRcY0qA
         z1RT1vo7gj/CJL4N4J4YIC+9lsvDgHF9CjtA3oJM=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from [192.168.1.2] ([93.135.73.205]) by smtp.web.de (mrweb002
 [213.165.67.108]) with ESMTPSA (Nemesis) id 0Lym19-1i2Cct1Nhv-0167Dy; Wed, 02
 Oct 2019 09:12:28 +0200
Subject: [PATCH 2/2] Coccinelle: Move coccicheck directories into a new
 subdirectory
From:   Markus Elfring <Markus.Elfring@web.de>
To:     Gilles Muller <Gilles.Muller@lip6.fr>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jessica Yu <jeyu@kernel.org>,
        Julia Lawall <julia.lawall@lip6.fr>,
        Martijn Coenen <maco@android.com>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Matthias Maennich <maennich@google.com>,
        Michal Marek <michal.lkml@markovi.net>,
        Nicolas Palix <nicolas.palix@imag.fr>,
        Yue Haibing <yuehaibing@huawei.com>,
        Coccinelle <cocci@systeme.lip6.fr>,
        kernel-janitors@vger.kernel.org
Cc:     LKML <linux-kernel@vger.kernel.org>
References: <20190928094245.45696-1-yuehaibing@huawei.com>
 <7664d59f-78cf-7644-0ee8-304b3d78d752@web.de>
 <alpine.DEB.2.21.1909291840280.3346@hadrien>
 <d8c97f0a-6ce2-0f5a-74a9-63366c17f3a6@web.de>
Autocrypt: addr=Markus.Elfring@web.de; prefer-encrypt=mutual; keydata=
 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 FEE=
Message-ID: <327d09a5-1efb-5cff-f7c5-d08df09eed23@web.de>
Date:   Wed, 2 Oct 2019 09:12:27 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
MIME-Version: 1.0
In-Reply-To: <d8c97f0a-6ce2-0f5a-74a9-63366c17f3a6@web.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:G3d6rjkkWh0ETIgQAKMZLWz1DliyqRK62OlBaQejWmeabuvpspD
 D4mQN2KDw6WeLjhLV1Juj6bQlI2JtHNIXPC4L9kh6vktSvI45xnkYv+dfrcd1k49Xpw9KRk
 JO+M3K3gi1MiUmiOCDID4zzuhNhvRLvp9vYK7pBca2pCUZb+UvDlWLW+3Nzu35fE6KO6Pe8
 +B8lYid/ME5TPBoU0wqEQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:eTfmXVAJ5i8=:Lk5gEqWy+GxtVFXWBY2/h5
 L1VNLn8jTugJBhbv9qHEO8W04muHeGo1DUPk66lWHgbCyFMRAGCX08n74UFD9tVQ9dGBkdUQ+
 zzmbwIdjsSntURz/VbShRuPB5whlPVRsbO1YR8wZXgzWRjPZc7pZReTsXQ2FWho4nZCKJ9/Qd
 Rc4iqrnPM0CzlQ2+s8zrURoBNU/zrpP14nMIgTHS0IckYvvXbycBbA3FLn0akGdqX9z+SGwjr
 SgXHtdl6GeGV8iwYLUCefpVu+2Bzn+KxYJTNQYUtFsCwi7UsZGs7dZ3h/REc2xxNL488Eez8z
 01R6YIxtHJ67JzZhxvF2FCpDxF6rf31bQUsClUBE/62PJJrOviYu5ClYu6pv53HD86sIMeUsd
 GZBwFKzLLdYGVDq5bGky2ikdzTIS3dPKXp3BxzdnD6Nzy9cstESYodbkvzgU8AghVxACAfY2t
 vc+E/HWqHVoeLmBORjHMKK0r32mkSx/u/xuneKQeCz+VTpNqZTLvwNus+kgg3JPIZqkkvIFqo
 eTVqPoTAtYTAf5GP/uC2zOf+lTYLsDmLXpqagDcDWLZCyatp4Wvdg450vpp/gbRf7V8v/DlFt
 vVAl9c5PwnsHfJP1Zi5Ro62xgAkrZFoKfol58nRYwp3PB5M4NvXvJ/4KG354ytsBTZqRPoXcI
 cXYabrKck7RKM7MYzicq1Sn99TK3gCMlyCnLJypQSnlEEQSkuOwP25RMHJc4bQcb7Cl2Pcl22
 aSTT800JjMlH/fFWioTlS8NrkRorp9RhJZUcNlu4M82G7oeA36gQ3a4IHMw2u2oKRbVvrKgn3
 XeGV9ltfe3Sl8IR76NjuWIZlUWzY/ho5YI1CG0cui4Z9CQ3X31U48n7LkxzETQ7DEXRRg5s8D
 3zx+LuQFnQPjXagd5Z4eBA4ipKFsFMCe6rqOfahLlpgJkk0MuYcnd5C7UCSf/Xkv0v6bU65ea
 DoaINnM+Cgw07rOLKm48GCH0UOEOIvjl8a4dahkvvOjS/0EJZx6d+I/HnZyRLjk1xP9iM8aHJ
 9PlPM8IzlHLJ7p9ycJvznA6PXcktGIikbP5BI966y5WmjvUlgM6MqffcJBtQijpb9MB4jv0nC
 5QSmUnR0DEzNuPvc0G8H5tbL0/ILiOyzpdQyFdttcZyqQub1ra9p43UdGisHGwi+wFjiKvtmi
 v6Khp+d1LqzXwtyZe15GjWHpbkhnrC/vl9ePtKeUjNff9sL5R/a+TKVU+Xor41mYeMoEi+EYt
 /zfLnMM3tAMlite74QAt68mr5ZTjjWsSsXxb1P+3QVY8JP/m71MekEfWostc=
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Markus Elfring <elfring@users.sourceforge.net>
Date: Wed, 2 Oct 2019 08:33:13 +0200

The standard system configuration for the tool =E2=80=9Ccoccicheck=E2=80=
=9D depends
on a specific directory for the selection of files which should be
automatically executed as scripts for the semantic patch language.
Move the needed directories into a subdirectory which indicates the suppor=
t
for the default operation mode of provided files in this hierarchy.

Fixes: eb8305aecb958e8787e7d603c7765c1dcace3a2b ("scripts: Coccinelle scri=
pt for namespace dependencies.")
Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
=2D--
 scripts/coccicheck                                              | 2 +-
 .../{ =3D> coccicheck/default}/api/alloc/alloc_cast.cocci         | 0
 .../{ =3D> coccicheck/default}/api/alloc/pool_zalloc-simple.cocci | 0
 .../{ =3D> coccicheck/default}/api/alloc/zalloc-simple.cocci      | 0
 .../{ =3D> coccicheck/default}/api/atomic_as_refcounter.cocci     | 0
 .../{ =3D> coccicheck/default}/api/check_bq27xxx_data.cocci       | 0
 .../coccinelle/{ =3D> coccicheck/default}/api/d_find_alias.cocci  | 0
 .../default}/api/debugfs/debugfs_simple_attr.cocci              | 0
 .../default}/api/devm_platform_ioremap_resource.cocci           | 0
 scripts/coccinelle/{ =3D> coccicheck/default}/api/err_cast.cocci  | 0
 scripts/coccinelle/{ =3D> coccicheck/default}/api/kstrdup.cocci   | 0
 scripts/coccinelle/{ =3D> coccicheck/default}/api/memdup.cocci    | 0
 .../coccinelle/{ =3D> coccicheck/default}/api/memdup_user.cocci   | 0
 .../{ =3D> coccicheck/default}/api/platform_get_irq.cocci         | 0
 .../{ =3D> coccicheck/default}/api/platform_no_drv_owner.cocci    | 0
 .../coccinelle/{ =3D> coccicheck/default}/api/pm_runtime.cocci    | 0
 scripts/coccinelle/{ =3D> coccicheck/default}/api/ptr_ret.cocci   | 0
 .../coccinelle/{ =3D> coccicheck/default}/api/resource_size.cocci | 0
 .../coccinelle/{ =3D> coccicheck/default}/api/simple_open.cocci   | 0
 .../coccinelle/{ =3D> coccicheck/default}/api/stream_open.cocci   | 0
 scripts/coccinelle/{ =3D> coccicheck/default}/api/vma_pages.cocci | 0
 scripts/coccinelle/{ =3D> coccicheck/default}/free/clk_put.cocci  | 0
 .../coccinelle/{ =3D> coccicheck/default}/free/devm_free.cocci    | 0
 .../coccinelle/{ =3D> coccicheck/default}/free/ifnullfree.cocci   | 0
 scripts/coccinelle/{ =3D> coccicheck/default}/free/iounmap.cocci  | 0
 scripts/coccinelle/{ =3D> coccicheck/default}/free/kfree.cocci    | 0
 .../coccinelle/{ =3D> coccicheck/default}/free/kfreeaddr.cocci    | 0
 .../{ =3D> coccicheck/default}/free/pci_free_consistent.cocci     | 0
 .../coccinelle/{ =3D> coccicheck/default}/free/put_device.cocci   | 0
 .../default}/iterators/device_node_continue.cocci               | 0
 scripts/coccinelle/{ =3D> coccicheck/default}/iterators/fen.cocci | 0
 .../coccinelle/{ =3D> coccicheck/default}/iterators/itnull.cocci  | 0
 .../{ =3D> coccicheck/default}/iterators/list_entry_update.cocci  | 0
 .../{ =3D> coccicheck/default}/iterators/use_after_iter.cocci     | 0
 .../coccinelle/{ =3D> coccicheck/default}/locks/call_kern.cocci   | 0
 .../coccinelle/{ =3D> coccicheck/default}/locks/double_lock.cocci | 0
 scripts/coccinelle/{ =3D> coccicheck/default}/locks/flags.cocci   | 0
 .../coccinelle/{ =3D> coccicheck/default}/locks/mini_lock.cocci   | 0
 .../coccinelle/{ =3D> coccicheck/default}/misc/array_size.cocci   | 0
 scripts/coccinelle/{ =3D> coccicheck/default}/misc/badty.cocci    | 0
 scripts/coccinelle/{ =3D> coccicheck/default}/misc/boolconv.cocci | 0
 scripts/coccinelle/{ =3D> coccicheck/default}/misc/boolinit.cocci | 0
 .../coccinelle/{ =3D> coccicheck/default}/misc/boolreturn.cocci   | 0
 scripts/coccinelle/{ =3D> coccicheck/default}/misc/bugon.cocci    | 0
 .../{ =3D> coccicheck/default}/misc/cond_no_effect.cocci          | 0
 scripts/coccinelle/{ =3D> coccicheck/default}/misc/cstptr.cocci   | 0
 .../coccinelle/{ =3D> coccicheck/default}/misc/doubleinit.cocci   | 0
 scripts/coccinelle/{ =3D> coccicheck/default}/misc/ifaddr.cocci   | 0
 scripts/coccinelle/{ =3D> coccicheck/default}/misc/ifcol.cocci    | 0
 .../coccinelle/{ =3D> coccicheck/default}/misc/irqf_oneshot.cocci | 0
 scripts/coccinelle/{ =3D> coccicheck/default}/misc/noderef.cocci  | 0
 scripts/coccinelle/{ =3D> coccicheck/default}/misc/of_table.cocci | 0
 scripts/coccinelle/{ =3D> coccicheck/default}/misc/orplus.cocci   | 0
 .../coccinelle/{ =3D> coccicheck/default}/misc/returnvar.cocci    | 0
 .../coccinelle/{ =3D> coccicheck/default}/misc/semicolon.cocci    | 0
 scripts/coccinelle/{ =3D> coccicheck/default}/misc/warn.cocci     | 0
 scripts/coccinelle/{ =3D> coccicheck/default}/null/badzero.cocci  | 0
 .../coccinelle/{ =3D> coccicheck/default}/null/deref_null.cocci   | 0
 scripts/coccinelle/{ =3D> coccicheck/default}/null/eno.cocci      | 0
 scripts/coccinelle/{ =3D> coccicheck/default}/null/kmerr.cocci    | 0
 .../{ =3D> coccicheck/default}/tests/doublebitand.cocci           | 0
 .../coccinelle/{ =3D> coccicheck/default}/tests/doubletest.cocci  | 0
 .../coccinelle/{ =3D> coccicheck/default}/tests/odd_ptr_err.cocci | 0
 .../default}/tests/unsigned_lesser_than_zero.cocci              | 0
 64 files changed, 1 insertion(+), 1 deletion(-)
 rename scripts/coccinelle/{ =3D> coccicheck/default}/api/alloc/alloc_cast=
.cocci (100%)
 rename scripts/coccinelle/{ =3D> coccicheck/default}/api/alloc/pool_zallo=
c-simple.cocci (100%)
 rename scripts/coccinelle/{ =3D> coccicheck/default}/api/alloc/zalloc-sim=
ple.cocci (100%)
 rename scripts/coccinelle/{ =3D> coccicheck/default}/api/atomic_as_refcou=
nter.cocci (100%)
 rename scripts/coccinelle/{ =3D> coccicheck/default}/api/check_bq27xxx_da=
ta.cocci (100%)
 rename scripts/coccinelle/{ =3D> coccicheck/default}/api/d_find_alias.coc=
ci (100%)
 rename scripts/coccinelle/{ =3D> coccicheck/default}/api/debugfs/debugfs_=
simple_attr.cocci (100%)
 rename scripts/coccinelle/{ =3D> coccicheck/default}/api/devm_platform_io=
remap_resource.cocci (100%)
 rename scripts/coccinelle/{ =3D> coccicheck/default}/api/err_cast.cocci (=
100%)
 rename scripts/coccinelle/{ =3D> coccicheck/default}/api/kstrdup.cocci (1=
00%)
 rename scripts/coccinelle/{ =3D> coccicheck/default}/api/memdup.cocci (10=
0%)
 rename scripts/coccinelle/{ =3D> coccicheck/default}/api/memdup_user.cocc=
i (100%)
 rename scripts/coccinelle/{ =3D> coccicheck/default}/api/platform_get_irq=
.cocci (100%)
 rename scripts/coccinelle/{ =3D> coccicheck/default}/api/platform_no_drv_=
owner.cocci (100%)
 rename scripts/coccinelle/{ =3D> coccicheck/default}/api/pm_runtime.cocci=
 (100%)
 rename scripts/coccinelle/{ =3D> coccicheck/default}/api/ptr_ret.cocci (1=
00%)
 rename scripts/coccinelle/{ =3D> coccicheck/default}/api/resource_size.co=
cci (100%)
 rename scripts/coccinelle/{ =3D> coccicheck/default}/api/simple_open.cocc=
i (100%)
 rename scripts/coccinelle/{ =3D> coccicheck/default}/api/stream_open.cocc=
i (100%)
 rename scripts/coccinelle/{ =3D> coccicheck/default}/api/vma_pages.cocci =
(100%)
 rename scripts/coccinelle/{ =3D> coccicheck/default}/free/clk_put.cocci (=
100%)
 rename scripts/coccinelle/{ =3D> coccicheck/default}/free/devm_free.cocci=
 (100%)
 rename scripts/coccinelle/{ =3D> coccicheck/default}/free/ifnullfree.cocc=
i (100%)
 rename scripts/coccinelle/{ =3D> coccicheck/default}/free/iounmap.cocci (=
100%)
 rename scripts/coccinelle/{ =3D> coccicheck/default}/free/kfree.cocci (10=
0%)
 rename scripts/coccinelle/{ =3D> coccicheck/default}/free/kfreeaddr.cocci=
 (100%)
 rename scripts/coccinelle/{ =3D> coccicheck/default}/free/pci_free_consis=
tent.cocci (100%)
 rename scripts/coccinelle/{ =3D> coccicheck/default}/free/put_device.cocc=
i (100%)
 rename scripts/coccinelle/{ =3D> coccicheck/default}/iterators/device_nod=
e_continue.cocci (100%)
 rename scripts/coccinelle/{ =3D> coccicheck/default}/iterators/fen.cocci =
(100%)
 rename scripts/coccinelle/{ =3D> coccicheck/default}/iterators/itnull.coc=
ci (100%)
 rename scripts/coccinelle/{ =3D> coccicheck/default}/iterators/list_entry=
_update.cocci (100%)
 rename scripts/coccinelle/{ =3D> coccicheck/default}/iterators/use_after_=
iter.cocci (100%)
 rename scripts/coccinelle/{ =3D> coccicheck/default}/locks/call_kern.cocc=
i (100%)
 rename scripts/coccinelle/{ =3D> coccicheck/default}/locks/double_lock.co=
cci (100%)
 rename scripts/coccinelle/{ =3D> coccicheck/default}/locks/flags.cocci (1=
00%)
 rename scripts/coccinelle/{ =3D> coccicheck/default}/locks/mini_lock.cocc=
i (100%)
 rename scripts/coccinelle/{ =3D> coccicheck/default}/misc/array_size.cocc=
i (100%)
 rename scripts/coccinelle/{ =3D> coccicheck/default}/misc/badty.cocci (10=
0%)
 rename scripts/coccinelle/{ =3D> coccicheck/default}/misc/boolconv.cocci =
(100%)
 rename scripts/coccinelle/{ =3D> coccicheck/default}/misc/boolinit.cocci =
(100%)
 rename scripts/coccinelle/{ =3D> coccicheck/default}/misc/boolreturn.cocc=
i (100%)
 rename scripts/coccinelle/{ =3D> coccicheck/default}/misc/bugon.cocci (10=
0%)
 rename scripts/coccinelle/{ =3D> coccicheck/default}/misc/cond_no_effect.=
cocci (100%)
 rename scripts/coccinelle/{ =3D> coccicheck/default}/misc/cstptr.cocci (1=
00%)
 rename scripts/coccinelle/{ =3D> coccicheck/default}/misc/doubleinit.cocc=
i (100%)
 rename scripts/coccinelle/{ =3D> coccicheck/default}/misc/ifaddr.cocci (1=
00%)
 rename scripts/coccinelle/{ =3D> coccicheck/default}/misc/ifcol.cocci (10=
0%)
 rename scripts/coccinelle/{ =3D> coccicheck/default}/misc/irqf_oneshot.co=
cci (100%)
 rename scripts/coccinelle/{ =3D> coccicheck/default}/misc/noderef.cocci (=
100%)
 rename scripts/coccinelle/{ =3D> coccicheck/default}/misc/of_table.cocci =
(100%)
 rename scripts/coccinelle/{ =3D> coccicheck/default}/misc/orplus.cocci (1=
00%)
 rename scripts/coccinelle/{ =3D> coccicheck/default}/misc/returnvar.cocci=
 (100%)
 rename scripts/coccinelle/{ =3D> coccicheck/default}/misc/semicolon.cocci=
 (100%)
 rename scripts/coccinelle/{ =3D> coccicheck/default}/misc/warn.cocci (100=
%)
 rename scripts/coccinelle/{ =3D> coccicheck/default}/null/badzero.cocci (=
100%)
 rename scripts/coccinelle/{ =3D> coccicheck/default}/null/deref_null.cocc=
i (100%)
 rename scripts/coccinelle/{ =3D> coccicheck/default}/null/eno.cocci (100%=
)
 rename scripts/coccinelle/{ =3D> coccicheck/default}/null/kmerr.cocci (10=
0%)
 rename scripts/coccinelle/{ =3D> coccicheck/default}/tests/doublebitand.c=
occi (100%)
 rename scripts/coccinelle/{ =3D> coccicheck/default}/tests/doubletest.coc=
ci (100%)
 rename scripts/coccinelle/{ =3D> coccicheck/default}/tests/odd_ptr_err.co=
cci (100%)
 rename scripts/coccinelle/{ =3D> coccicheck/default}/tests/unsigned_lesse=
r_than_zero.cocci (100%)

diff --git a/scripts/coccicheck b/scripts/coccicheck
index e04d328210ac..3359f3f528ba 100755
=2D-- a/scripts/coccicheck
+++ b/scripts/coccicheck
@@ -254,7 +254,7 @@ else
 fi

 if [ "$COCCI" =3D "" ] ; then
-    for f in `find $srctree/scripts/coccinelle/ -name '*.cocci' -type f |=
 sort`; do
+    for f in `find $srctree/scripts/coccinelle/coccicheck/default/ -name =
'*.cocci' -type f | sort`; do
 	coccinelle $f
     done
 else
diff --git a/scripts/coccinelle/api/alloc/alloc_cast.cocci b/scripts/cocci=
nelle/coccicheck/default/api/alloc/alloc_cast.cocci
similarity index 100%
rename from scripts/coccinelle/api/alloc/alloc_cast.cocci
rename to scripts/coccinelle/coccicheck/default/api/alloc/alloc_cast.cocci
diff --git a/scripts/coccinelle/api/alloc/pool_zalloc-simple.cocci b/scrip=
ts/coccinelle/coccicheck/default/api/alloc/pool_zalloc-simple.cocci
similarity index 100%
rename from scripts/coccinelle/api/alloc/pool_zalloc-simple.cocci
rename to scripts/coccinelle/coccicheck/default/api/alloc/pool_zalloc-simp=
le.cocci
diff --git a/scripts/coccinelle/api/alloc/zalloc-simple.cocci b/scripts/co=
ccinelle/coccicheck/default/api/alloc/zalloc-simple.cocci
similarity index 100%
rename from scripts/coccinelle/api/alloc/zalloc-simple.cocci
rename to scripts/coccinelle/coccicheck/default/api/alloc/zalloc-simple.co=
cci
diff --git a/scripts/coccinelle/api/atomic_as_refcounter.cocci b/scripts/c=
occinelle/coccicheck/default/api/atomic_as_refcounter.cocci
similarity index 100%
rename from scripts/coccinelle/api/atomic_as_refcounter.cocci
rename to scripts/coccinelle/coccicheck/default/api/atomic_as_refcounter.c=
occi
diff --git a/scripts/coccinelle/api/check_bq27xxx_data.cocci b/scripts/coc=
cinelle/coccicheck/default/api/check_bq27xxx_data.cocci
similarity index 100%
rename from scripts/coccinelle/api/check_bq27xxx_data.cocci
rename to scripts/coccinelle/coccicheck/default/api/check_bq27xxx_data.coc=
ci
diff --git a/scripts/coccinelle/api/d_find_alias.cocci b/scripts/coccinell=
e/coccicheck/default/api/d_find_alias.cocci
similarity index 100%
rename from scripts/coccinelle/api/d_find_alias.cocci
rename to scripts/coccinelle/coccicheck/default/api/d_find_alias.cocci
diff --git a/scripts/coccinelle/api/debugfs/debugfs_simple_attr.cocci b/sc=
ripts/coccinelle/coccicheck/default/api/debugfs/debugfs_simple_attr.cocci
similarity index 100%
rename from scripts/coccinelle/api/debugfs/debugfs_simple_attr.cocci
rename to scripts/coccinelle/coccicheck/default/api/debugfs/debugfs_simple=
_attr.cocci
diff --git a/scripts/coccinelle/api/devm_platform_ioremap_resource.cocci b=
/scripts/coccinelle/coccicheck/default/api/devm_platform_ioremap_resource.=
cocci
similarity index 100%
rename from scripts/coccinelle/api/devm_platform_ioremap_resource.cocci
rename to scripts/coccinelle/coccicheck/default/api/devm_platform_ioremap_=
resource.cocci
diff --git a/scripts/coccinelle/api/err_cast.cocci b/scripts/coccinelle/co=
ccicheck/default/api/err_cast.cocci
similarity index 100%
rename from scripts/coccinelle/api/err_cast.cocci
rename to scripts/coccinelle/coccicheck/default/api/err_cast.cocci
diff --git a/scripts/coccinelle/api/kstrdup.cocci b/scripts/coccinelle/coc=
cicheck/default/api/kstrdup.cocci
similarity index 100%
rename from scripts/coccinelle/api/kstrdup.cocci
rename to scripts/coccinelle/coccicheck/default/api/kstrdup.cocci
diff --git a/scripts/coccinelle/api/memdup.cocci b/scripts/coccinelle/cocc=
icheck/default/api/memdup.cocci
similarity index 100%
rename from scripts/coccinelle/api/memdup.cocci
rename to scripts/coccinelle/coccicheck/default/api/memdup.cocci
diff --git a/scripts/coccinelle/api/memdup_user.cocci b/scripts/coccinelle=
/coccicheck/default/api/memdup_user.cocci
similarity index 100%
rename from scripts/coccinelle/api/memdup_user.cocci
rename to scripts/coccinelle/coccicheck/default/api/memdup_user.cocci
diff --git a/scripts/coccinelle/api/platform_get_irq.cocci b/scripts/cocci=
nelle/coccicheck/default/api/platform_get_irq.cocci
similarity index 100%
rename from scripts/coccinelle/api/platform_get_irq.cocci
rename to scripts/coccinelle/coccicheck/default/api/platform_get_irq.cocci
diff --git a/scripts/coccinelle/api/platform_no_drv_owner.cocci b/scripts/=
coccinelle/coccicheck/default/api/platform_no_drv_owner.cocci
similarity index 100%
rename from scripts/coccinelle/api/platform_no_drv_owner.cocci
rename to scripts/coccinelle/coccicheck/default/api/platform_no_drv_owner.=
cocci
diff --git a/scripts/coccinelle/api/pm_runtime.cocci b/scripts/coccinelle/=
coccicheck/default/api/pm_runtime.cocci
similarity index 100%
rename from scripts/coccinelle/api/pm_runtime.cocci
rename to scripts/coccinelle/coccicheck/default/api/pm_runtime.cocci
diff --git a/scripts/coccinelle/api/ptr_ret.cocci b/scripts/coccinelle/coc=
cicheck/default/api/ptr_ret.cocci
similarity index 100%
rename from scripts/coccinelle/api/ptr_ret.cocci
rename to scripts/coccinelle/coccicheck/default/api/ptr_ret.cocci
diff --git a/scripts/coccinelle/api/resource_size.cocci b/scripts/coccinel=
le/coccicheck/default/api/resource_size.cocci
similarity index 100%
rename from scripts/coccinelle/api/resource_size.cocci
rename to scripts/coccinelle/coccicheck/default/api/resource_size.cocci
diff --git a/scripts/coccinelle/api/simple_open.cocci b/scripts/coccinelle=
/coccicheck/default/api/simple_open.cocci
similarity index 100%
rename from scripts/coccinelle/api/simple_open.cocci
rename to scripts/coccinelle/coccicheck/default/api/simple_open.cocci
diff --git a/scripts/coccinelle/api/stream_open.cocci b/scripts/coccinelle=
/coccicheck/default/api/stream_open.cocci
similarity index 100%
rename from scripts/coccinelle/api/stream_open.cocci
rename to scripts/coccinelle/coccicheck/default/api/stream_open.cocci
diff --git a/scripts/coccinelle/api/vma_pages.cocci b/scripts/coccinelle/c=
occicheck/default/api/vma_pages.cocci
similarity index 100%
rename from scripts/coccinelle/api/vma_pages.cocci
rename to scripts/coccinelle/coccicheck/default/api/vma_pages.cocci
diff --git a/scripts/coccinelle/free/clk_put.cocci b/scripts/coccinelle/co=
ccicheck/default/free/clk_put.cocci
similarity index 100%
rename from scripts/coccinelle/free/clk_put.cocci
rename to scripts/coccinelle/coccicheck/default/free/clk_put.cocci
diff --git a/scripts/coccinelle/free/devm_free.cocci b/scripts/coccinelle/=
coccicheck/default/free/devm_free.cocci
similarity index 100%
rename from scripts/coccinelle/free/devm_free.cocci
rename to scripts/coccinelle/coccicheck/default/free/devm_free.cocci
diff --git a/scripts/coccinelle/free/ifnullfree.cocci b/scripts/coccinelle=
/coccicheck/default/free/ifnullfree.cocci
similarity index 100%
rename from scripts/coccinelle/free/ifnullfree.cocci
rename to scripts/coccinelle/coccicheck/default/free/ifnullfree.cocci
diff --git a/scripts/coccinelle/free/iounmap.cocci b/scripts/coccinelle/co=
ccicheck/default/free/iounmap.cocci
similarity index 100%
rename from scripts/coccinelle/free/iounmap.cocci
rename to scripts/coccinelle/coccicheck/default/free/iounmap.cocci
diff --git a/scripts/coccinelle/free/kfree.cocci b/scripts/coccinelle/cocc=
icheck/default/free/kfree.cocci
similarity index 100%
rename from scripts/coccinelle/free/kfree.cocci
rename to scripts/coccinelle/coccicheck/default/free/kfree.cocci
diff --git a/scripts/coccinelle/free/kfreeaddr.cocci b/scripts/coccinelle/=
coccicheck/default/free/kfreeaddr.cocci
similarity index 100%
rename from scripts/coccinelle/free/kfreeaddr.cocci
rename to scripts/coccinelle/coccicheck/default/free/kfreeaddr.cocci
diff --git a/scripts/coccinelle/free/pci_free_consistent.cocci b/scripts/c=
occinelle/coccicheck/default/free/pci_free_consistent.cocci
similarity index 100%
rename from scripts/coccinelle/free/pci_free_consistent.cocci
rename to scripts/coccinelle/coccicheck/default/free/pci_free_consistent.c=
occi
diff --git a/scripts/coccinelle/free/put_device.cocci b/scripts/coccinelle=
/coccicheck/default/free/put_device.cocci
similarity index 100%
rename from scripts/coccinelle/free/put_device.cocci
rename to scripts/coccinelle/coccicheck/default/free/put_device.cocci
diff --git a/scripts/coccinelle/iterators/device_node_continue.cocci b/scr=
ipts/coccinelle/coccicheck/default/iterators/device_node_continue.cocci
similarity index 100%
rename from scripts/coccinelle/iterators/device_node_continue.cocci
rename to scripts/coccinelle/coccicheck/default/iterators/device_node_cont=
inue.cocci
diff --git a/scripts/coccinelle/iterators/fen.cocci b/scripts/coccinelle/c=
occicheck/default/iterators/fen.cocci
similarity index 100%
rename from scripts/coccinelle/iterators/fen.cocci
rename to scripts/coccinelle/coccicheck/default/iterators/fen.cocci
diff --git a/scripts/coccinelle/iterators/itnull.cocci b/scripts/coccinell=
e/coccicheck/default/iterators/itnull.cocci
similarity index 100%
rename from scripts/coccinelle/iterators/itnull.cocci
rename to scripts/coccinelle/coccicheck/default/iterators/itnull.cocci
diff --git a/scripts/coccinelle/iterators/list_entry_update.cocci b/script=
s/coccinelle/coccicheck/default/iterators/list_entry_update.cocci
similarity index 100%
rename from scripts/coccinelle/iterators/list_entry_update.cocci
rename to scripts/coccinelle/coccicheck/default/iterators/list_entry_updat=
e.cocci
diff --git a/scripts/coccinelle/iterators/use_after_iter.cocci b/scripts/c=
occinelle/coccicheck/default/iterators/use_after_iter.cocci
similarity index 100%
rename from scripts/coccinelle/iterators/use_after_iter.cocci
rename to scripts/coccinelle/coccicheck/default/iterators/use_after_iter.c=
occi
diff --git a/scripts/coccinelle/locks/call_kern.cocci b/scripts/coccinelle=
/coccicheck/default/locks/call_kern.cocci
similarity index 100%
rename from scripts/coccinelle/locks/call_kern.cocci
rename to scripts/coccinelle/coccicheck/default/locks/call_kern.cocci
diff --git a/scripts/coccinelle/locks/double_lock.cocci b/scripts/coccinel=
le/coccicheck/default/locks/double_lock.cocci
similarity index 100%
rename from scripts/coccinelle/locks/double_lock.cocci
rename to scripts/coccinelle/coccicheck/default/locks/double_lock.cocci
diff --git a/scripts/coccinelle/locks/flags.cocci b/scripts/coccinelle/coc=
cicheck/default/locks/flags.cocci
similarity index 100%
rename from scripts/coccinelle/locks/flags.cocci
rename to scripts/coccinelle/coccicheck/default/locks/flags.cocci
diff --git a/scripts/coccinelle/locks/mini_lock.cocci b/scripts/coccinelle=
/coccicheck/default/locks/mini_lock.cocci
similarity index 100%
rename from scripts/coccinelle/locks/mini_lock.cocci
rename to scripts/coccinelle/coccicheck/default/locks/mini_lock.cocci
diff --git a/scripts/coccinelle/misc/array_size.cocci b/scripts/coccinelle=
/coccicheck/default/misc/array_size.cocci
similarity index 100%
rename from scripts/coccinelle/misc/array_size.cocci
rename to scripts/coccinelle/coccicheck/default/misc/array_size.cocci
diff --git a/scripts/coccinelle/misc/badty.cocci b/scripts/coccinelle/cocc=
icheck/default/misc/badty.cocci
similarity index 100%
rename from scripts/coccinelle/misc/badty.cocci
rename to scripts/coccinelle/coccicheck/default/misc/badty.cocci
diff --git a/scripts/coccinelle/misc/boolconv.cocci b/scripts/coccinelle/c=
occicheck/default/misc/boolconv.cocci
similarity index 100%
rename from scripts/coccinelle/misc/boolconv.cocci
rename to scripts/coccinelle/coccicheck/default/misc/boolconv.cocci
diff --git a/scripts/coccinelle/misc/boolinit.cocci b/scripts/coccinelle/c=
occicheck/default/misc/boolinit.cocci
similarity index 100%
rename from scripts/coccinelle/misc/boolinit.cocci
rename to scripts/coccinelle/coccicheck/default/misc/boolinit.cocci
diff --git a/scripts/coccinelle/misc/boolreturn.cocci b/scripts/coccinelle=
/coccicheck/default/misc/boolreturn.cocci
similarity index 100%
rename from scripts/coccinelle/misc/boolreturn.cocci
rename to scripts/coccinelle/coccicheck/default/misc/boolreturn.cocci
diff --git a/scripts/coccinelle/misc/bugon.cocci b/scripts/coccinelle/cocc=
icheck/default/misc/bugon.cocci
similarity index 100%
rename from scripts/coccinelle/misc/bugon.cocci
rename to scripts/coccinelle/coccicheck/default/misc/bugon.cocci
diff --git a/scripts/coccinelle/misc/cond_no_effect.cocci b/scripts/coccin=
elle/coccicheck/default/misc/cond_no_effect.cocci
similarity index 100%
rename from scripts/coccinelle/misc/cond_no_effect.cocci
rename to scripts/coccinelle/coccicheck/default/misc/cond_no_effect.cocci
diff --git a/scripts/coccinelle/misc/cstptr.cocci b/scripts/coccinelle/coc=
cicheck/default/misc/cstptr.cocci
similarity index 100%
rename from scripts/coccinelle/misc/cstptr.cocci
rename to scripts/coccinelle/coccicheck/default/misc/cstptr.cocci
diff --git a/scripts/coccinelle/misc/doubleinit.cocci b/scripts/coccinelle=
/coccicheck/default/misc/doubleinit.cocci
similarity index 100%
rename from scripts/coccinelle/misc/doubleinit.cocci
rename to scripts/coccinelle/coccicheck/default/misc/doubleinit.cocci
diff --git a/scripts/coccinelle/misc/ifaddr.cocci b/scripts/coccinelle/coc=
cicheck/default/misc/ifaddr.cocci
similarity index 100%
rename from scripts/coccinelle/misc/ifaddr.cocci
rename to scripts/coccinelle/coccicheck/default/misc/ifaddr.cocci
diff --git a/scripts/coccinelle/misc/ifcol.cocci b/scripts/coccinelle/cocc=
icheck/default/misc/ifcol.cocci
similarity index 100%
rename from scripts/coccinelle/misc/ifcol.cocci
rename to scripts/coccinelle/coccicheck/default/misc/ifcol.cocci
diff --git a/scripts/coccinelle/misc/irqf_oneshot.cocci b/scripts/coccinel=
le/coccicheck/default/misc/irqf_oneshot.cocci
similarity index 100%
rename from scripts/coccinelle/misc/irqf_oneshot.cocci
rename to scripts/coccinelle/coccicheck/default/misc/irqf_oneshot.cocci
diff --git a/scripts/coccinelle/misc/noderef.cocci b/scripts/coccinelle/co=
ccicheck/default/misc/noderef.cocci
similarity index 100%
rename from scripts/coccinelle/misc/noderef.cocci
rename to scripts/coccinelle/coccicheck/default/misc/noderef.cocci
diff --git a/scripts/coccinelle/misc/of_table.cocci b/scripts/coccinelle/c=
occicheck/default/misc/of_table.cocci
similarity index 100%
rename from scripts/coccinelle/misc/of_table.cocci
rename to scripts/coccinelle/coccicheck/default/misc/of_table.cocci
diff --git a/scripts/coccinelle/misc/orplus.cocci b/scripts/coccinelle/coc=
cicheck/default/misc/orplus.cocci
similarity index 100%
rename from scripts/coccinelle/misc/orplus.cocci
rename to scripts/coccinelle/coccicheck/default/misc/orplus.cocci
diff --git a/scripts/coccinelle/misc/returnvar.cocci b/scripts/coccinelle/=
coccicheck/default/misc/returnvar.cocci
similarity index 100%
rename from scripts/coccinelle/misc/returnvar.cocci
rename to scripts/coccinelle/coccicheck/default/misc/returnvar.cocci
diff --git a/scripts/coccinelle/misc/semicolon.cocci b/scripts/coccinelle/=
coccicheck/default/misc/semicolon.cocci
similarity index 100%
rename from scripts/coccinelle/misc/semicolon.cocci
rename to scripts/coccinelle/coccicheck/default/misc/semicolon.cocci
diff --git a/scripts/coccinelle/misc/warn.cocci b/scripts/coccinelle/cocci=
check/default/misc/warn.cocci
similarity index 100%
rename from scripts/coccinelle/misc/warn.cocci
rename to scripts/coccinelle/coccicheck/default/misc/warn.cocci
diff --git a/scripts/coccinelle/null/badzero.cocci b/scripts/coccinelle/co=
ccicheck/default/null/badzero.cocci
similarity index 100%
rename from scripts/coccinelle/null/badzero.cocci
rename to scripts/coccinelle/coccicheck/default/null/badzero.cocci
diff --git a/scripts/coccinelle/null/deref_null.cocci b/scripts/coccinelle=
/coccicheck/default/null/deref_null.cocci
similarity index 100%
rename from scripts/coccinelle/null/deref_null.cocci
rename to scripts/coccinelle/coccicheck/default/null/deref_null.cocci
diff --git a/scripts/coccinelle/null/eno.cocci b/scripts/coccinelle/coccic=
heck/default/null/eno.cocci
similarity index 100%
rename from scripts/coccinelle/null/eno.cocci
rename to scripts/coccinelle/coccicheck/default/null/eno.cocci
diff --git a/scripts/coccinelle/null/kmerr.cocci b/scripts/coccinelle/cocc=
icheck/default/null/kmerr.cocci
similarity index 100%
rename from scripts/coccinelle/null/kmerr.cocci
rename to scripts/coccinelle/coccicheck/default/null/kmerr.cocci
diff --git a/scripts/coccinelle/tests/doublebitand.cocci b/scripts/coccine=
lle/coccicheck/default/tests/doublebitand.cocci
similarity index 100%
rename from scripts/coccinelle/tests/doublebitand.cocci
rename to scripts/coccinelle/coccicheck/default/tests/doublebitand.cocci
diff --git a/scripts/coccinelle/tests/doubletest.cocci b/scripts/coccinell=
e/coccicheck/default/tests/doubletest.cocci
similarity index 100%
rename from scripts/coccinelle/tests/doubletest.cocci
rename to scripts/coccinelle/coccicheck/default/tests/doubletest.cocci
diff --git a/scripts/coccinelle/tests/odd_ptr_err.cocci b/scripts/coccinel=
le/coccicheck/default/tests/odd_ptr_err.cocci
similarity index 100%
rename from scripts/coccinelle/tests/odd_ptr_err.cocci
rename to scripts/coccinelle/coccicheck/default/tests/odd_ptr_err.cocci
diff --git a/scripts/coccinelle/tests/unsigned_lesser_than_zero.cocci b/sc=
ripts/coccinelle/coccicheck/default/tests/unsigned_lesser_than_zero.cocci
similarity index 100%
rename from scripts/coccinelle/tests/unsigned_lesser_than_zero.cocci
rename to scripts/coccinelle/coccicheck/default/tests/unsigned_lesser_than=
_zero.cocci
=2D-
2.23.0

