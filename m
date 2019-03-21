Return-Path: <SRS0=/BZh=RY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A1C88C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Mar 2019 03:54:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 78E83218B0
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Mar 2019 03:54:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727896AbfCUDyb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Mar 2019 23:54:31 -0400
Received: from mx2.suse.de ([195.135.220.15]:60810 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727575AbfCUDya (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Mar 2019 23:54:30 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id BC2CEAC43;
        Thu, 21 Mar 2019 03:54:29 +0000 (UTC)
From:   NeilBrown <neilb@suse.com>
To:     Jiri Kosina <trivial@kernel.org>
Date:   Thu, 21 Mar 2019 14:54:22 +1100
Cc:     LKML <linux-kernel@vger.kernel.org>
Subject: [PATCH trivial] list/hashtable: minor documentation corrections.
Message-ID: <87o9647uhd.fsf@notabene.neil.brown.name>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="=-=-=";
        micalg=pgp-sha256; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--=-=-=
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable


hash_for_each_safe() and hash_for_each_possible_safe()
need to be passed a temp 'struct hlist_node' pointer, but
do not say that in the documentation - they just say
a 'struct'.

Also the documentation for hlist_for_each_entry_safe()
describes @n as "another" hlist_node, but in reality it is
the only one.

Signed-off-by: NeilBrown <neilb@suse.com>
=2D--
 include/linux/hashtable.h | 4 ++--
 include/linux/list.h      | 2 +-
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/include/linux/hashtable.h b/include/linux/hashtable.h
index 417d2c4bc60d..78b6ea5fa8ba 100644
=2D-- a/include/linux/hashtable.h
+++ b/include/linux/hashtable.h
@@ -145,7 +145,7 @@ static inline void hash_del_rcu(struct hlist_node *node)
  * hash entry
  * @name: hashtable to iterate
  * @bkt: integer to use as bucket loop cursor
=2D * @tmp: a &struct used for temporary storage
+ * @tmp: a &struct hlist_node used for temporary storage
  * @obj: the type * to use as a loop cursor for each entry
  * @member: the name of the hlist_node within the struct
  */
@@ -197,7 +197,7 @@ static inline void hash_del_rcu(struct hlist_node *node)
  * same bucket safe against removals
  * @name: hashtable to iterate
  * @obj: the type * to use as a loop cursor for each entry
=2D * @tmp: a &struct used for temporary storage
+ * @tmp: a &struct hlist_node used for temporary storage
  * @member: the name of the hlist_node within the struct
  * @key: the key of the objects to iterate over
  */
diff --git a/include/linux/list.h b/include/linux/list.h
index 79626b5ab36c..894da1962f89 100644
=2D-- a/include/linux/list.h
+++ b/include/linux/list.h
@@ -842,7 +842,7 @@ static inline void hlist_move_list(struct hlist_head *o=
ld,
 /**
  * hlist_for_each_entry_safe - iterate over list of given type safe agains=
t removal of list entry
  * @pos:	the type * to use as a loop cursor.
=2D * @n:		another &struct hlist_node to use as temporary storage
+ * @n:		a &struct hlist_node to use as temporary storage
  * @head:	the head for your list.
  * @member:	the name of the hlist_node within the struct.
  */
=2D-=20
2.14.0.rc0.dirty


--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEG8Yp69OQ2HB7X0l6Oeye3VZigbkFAlyTCu4ACgkQOeye3VZi
gbmeFRAAn5whEALD1hO62treSICxHMR6XVPJOIZ3q/z9NUOCQC9ZhljWnaX0sQ/G
7qcyI+bxCIGypXFKKULOhSBeseOiX7J/LpPe50XjN7UVl1L2VzUN6zCxtb3+XGJ6
3MXeyz7jSvNIsYu4Mul+9m8LcelotLWVMOdQ+xODPvTTDPr3EY5vR5mFvzItNA0H
B51pDPws6oTH+otQJF33ZwHS1kfVnnT2mHGM5pYpuWhkLdqghwZZu0cztLF0fRJ0
vhdZt8aGKdN3Dem0GDQOub2rfTAZsrbYhegxDKhleRrVNxztlZRacn25Xv2bHcGN
8G5GRGFJz//0UJMAwPXnULGMPTl4IIO1S7zrRE17hyPX24q3QGvnMHql59eJQze8
CyPahWReBoUF05OqlALG7C31IE4FaQUk+Eq37VfMeiAHT5ohL/qGfprOUEKLawFr
SrvOygzUan9edJGvjG5cSzOZLNPVso15OsOh6nYLzjE10qWw8HVAqY5p0Q84kagE
aJvGPPZzso+gIhjBFfug2dFzJwIMdEyPTQy1x0xEDFBlcruJAwUbJy5GKuwaQUzR
ZUaoflV/6lcdiQIfWD2HyacRpnpTXxx8hPXp6u9A25HBBYkOlya0Su4z/cpdT55v
3VR9XKg8JXIE+TtfuhQ2ymdrHwTGcLXE/x3HgIiwRCX0Tbs2OEM=
=rQJj
-----END PGP SIGNATURE-----
--=-=-=--
