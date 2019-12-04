Return-Path: <SRS0=oopU=Z2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8AFE0C43603
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Dec 2019 23:53:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 257692073C
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Dec 2019 23:53:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=web.de header.i=@web.de header.b="WCfVcfZi"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728379AbfLDXxR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 4 Dec 2019 18:53:17 -0500
Received: from mout.web.de ([212.227.17.12]:40611 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728011AbfLDXxQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Dec 2019 18:53:16 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
        s=dbaedf251592; t=1575503573;
        bh=gAswoyEI3ORjCubb6fNRTGRpRW9B7j0uCEoxjS9mI7g=;
        h=X-UI-Sender-Class:From:To:Cc:Subject:Date;
        b=WCfVcfZixAQ4shCH/eDUFDUjJIwKge9um6fIrNuR7j12JnE9qIwgbvd3lm6vW9NJ6
         495QMxfM6SpaFzLfKiUagN5eYL5l4Ljtv/r1NvW7bOtVe3xArCgk2SaVQogI3Z/XuF
         c9tBiN1kAe7wwYiIqekHa7bPbT9LwgDagrodoNI4=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from localhost.localdomain ([24.90.134.61]) by smtp.web.de (mrweb103
 [213.165.67.124]) with ESMTPSA (Nemesis) id 0MD8Fc-1iXCwK2Y3A-00GWiS; Thu, 05
 Dec 2019 00:52:52 +0100
From:   Malte Skarupke <malteskarupke@web.de>
To:     tglx@linutronix.de, mingo@redhat.com
Cc:     peterz@infradead.org, dvhart@infradead.org,
        linux-kernel@vger.kernel.org, malteskarupke@fastmail.fm,
        Malte Skarupke <malteskarupke@web.de>
Subject: [PATCH] futex: Support smaller futexes of one byte or two byte size.
Date:   Wed,  4 Dec 2019 18:52:38 -0500
Message-Id: <20191204235238.10764-1-malteskarupke@web.de>
X-Mailer: git-send-email 2.17.1
X-Provags-ID: V03:K1:WXlzpp9kdJ9scwHFFSNGP9+FgIpdXFmZgRYOTnS3rwKWtEY0/a1
 wVrH6Tn5HRt3CfpJoWW1QHBSS1i/Xv+OkO46xPxLKXiY9cYr7DsnX5z4fswcDSPVc25AF3k
 PcE1UviJW3RwI0HjCWKeCQaKIeVpVXveSlMH7wZ0efpVmKjpUCfLdPmoole+aTewJ6IKado
 22aGUyFNKuZlkjjyX0ZyA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:F5OQr276sCE=:8SSOWUf1pAhOkYQzFG8ojX
 XpvFzmMxYoGvkkga/a1TntB25jr00UuATlpP4qfkLxNgqzvEdOk5AyAAe3E2utnA8l4j97lwR
 VZ+vF2PcDxdQbdcGeCsntKh0aDZ+AAC9Tml0JXss7ISW1SfUh8VoISmEj8D4Vs11rCETQHeHG
 AYZ0LGQXtk6NXJokVyTgtbRXXhX9CCbi8g3nFGkwNWQ5lSVlv7+SjyCxB891IP8X0cgo44Pz6
 k3uMsh1eHIh+EkRPsWet67hLqLGYrCPfauVamS0aF9CTyhDOGJ6GoclzvVy0KFsAPX2Yyt1BO
 5B1YW0zohs7x58BtjD4gDzMca/d5RygUvFMyAaD0/ugT1JNi3cGtZz8Hk8NwBMdqR8TaC8/7g
 Qm5qdcTnaG4XMGIdr3YvyBoM9PPmciOHJ0PZ4o/tYJcf7PZtwgHHwDeA9AQ2zoWa3nHCz7Xa1
 NLtJi+v5hvsZE9Gehf+kuVBm8bHhfncZMgPZr2/Z/KCJ+L4A4F316EwPJP+HLb8XCeXZ12Ghl
 RnUhOIWvZuqwiYokRrSIHUvMT4oph9V4TtFlyyn+sR9T6m06Ezgc0+kaWasCQtLbKvnjRE8Nt
 D7TR+1TTX2yzNQx5iSfXeat6H8TJIGRtJBREaZgOZWvRX9su+OAfVyCMnE8Fx+skctehkz2VS
 GMalITZnFUOUp6lj7IavQAIGlTdlY91/oe7XiEaz9V+h4Zk/JcYryLrNrArWxxRZoeyRxRe7B
 rphdqFF66IZZIcb03xazvUdZDraXgGbOfOuVetNS9oXzRdOdL1P+rrI6RjkuFXUi0NqWSML2W
 C7oGUABXtKDnU4RqYQvbd199FuRunzZLTkvDi1eh+ms2sdSLn5WFEgLaC9gsjqj9ZTxoD+4iO
 voMsCLYWL47cy819yAQqwhUBpeltA4DumKIl7Z2c8flAKM4NaiF+lb8aSg3H5ptwPkQbIjh/o
 L9pykrJcKUfmMzosNARMsLJTZPvSFnywXCsYWziJ8oZcHBSGxpWR5B4iIjjfCeq43Gf/rUXPw
 1kf1J0t/CiIhIEcsyOFkwf6TPoKIbWkuueKCNE/Uh1yTpnH41nZJyH8sDvHB1XQt4CD5X1gFW
 isjTPi6Jm6biiF/iuubhIlTHtv98Cd5mrOkRrTSWGsD7++kFRsv7dekcMBhWz9vnFDyorpZZs
 NoGNBqi16xvuDTZFjrxu+N4wOpRiEN1Ke+UR0J+Q6PasBJusqcsnv2oe9YB4sRrDpHO7q9ke4
 iPjC20vrIhvNEYUki4CZl8i3BsTDhBmQ32aAh+EQ421EGQt7rjT5DdcqB4l0=
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Two reasons for adding this:
1. People often want small mutexes. Having mutexes that are only one byte
in size was the first reason WebKit mentioned for re-implementing futexes
in a library:
https://webkit.org/blog/6161/locking-in-webkit/

2. The C++ standard added futexes to the standard library in C++20 under
the name atomic_wait and atomic_notify:
http://www.open-std.org/jtc1/sc22/wg21/docs/papers/2019/p1135r5.html
The C++20 version supports this for atomic variables of any size. The more
sizes we can support, the better the implementation can be in the standard
library.

I had to change where we store two flags that were previously stored in
the low bits of the address, since the address can no longer be assumed
to be aligned on four bytes. Luckily the high bits were free as long as
PAGE_SIZE is never more than 1 gigabyte.

The reason for only supporting u8 and u16 is that those were easy to
support with the existing interface. 64 bit futexes would require bigger
changes. There is also the option of just supporting arbitrarily sized
futexes by repurposing one of the other parameters to indicate the size.
However I believe that even in that case 8 bit and 16 bit futexes
would remain more common, since people usually want to save memory. So
the flags I added wouldn't get in the way of that feature.

In this change I only added support in wait/wake and requeue/cmp_requeue,
as those are the only operations I need right now. Also the other
operations are more complicated. They will have to wait.

Signed-off-by: Malte Skarupke <malteskarupke@web.de>
=2D--
 include/linux/futex.h      |  10 ++-
 include/uapi/linux/futex.h |   7 +-
 kernel/futex.c             | 163 +++++++++++++++++++++++++++++++------
 3 files changed, 151 insertions(+), 29 deletions(-)

diff --git a/include/linux/futex.h b/include/linux/futex.h
index ccaef0097785..86fe0e2780e2 100644
=2D-- a/include/linux/futex.h
+++ b/include/linux/futex.h
@@ -14,8 +14,8 @@ struct task_struct;
  * The key type depends on whether it's a shared or private mapping.
  * Don't rearrange members without looking at hash_futex().
  *
- * offset is aligned to a multiple of sizeof(u32) (=3D=3D 4) by definitio=
n.
- * We use the two low order bits of offset to tell what is the kind of ke=
y :
+ * offset is the position within a page and is in the range [0, PAGE_SIZE=
).
+ * We use the next two bits of offset to tell what kind of key this is :
  *  00 : Private process futex (PTHREAD_PROCESS_PRIVATE)
  *       (no reference on an inode or mm)
  *  01 : Shared futex (PTHREAD_PROCESS_SHARED)
@@ -24,8 +24,10 @@ struct task_struct;
  *       (but private mapping on an mm, and reference taken on it)
 */

-#define FUT_OFF_INODE    1 /* We set bit 0 if key has a reference on inod=
e */
-#define FUT_OFF_MMSHARED 2 /* We set bit 1 if key has a reference on mm *=
/
+/* We set the next highest bit if key has a reference on inode */
+#define FUT_OFF_INODE    PAGE_SIZE
+/* We set the bit after that if key has a reference on mm */
+#define FUT_OFF_MMSHARED (2 * FUT_OFF_INODE)

 union futex_key {
 	struct {
diff --git a/include/uapi/linux/futex.h b/include/uapi/linux/futex.h
index a89eb0accd5e..1121603c5b64 100644
=2D-- a/include/uapi/linux/futex.h
+++ b/include/uapi/linux/futex.h
@@ -24,7 +24,12 @@

 #define FUTEX_PRIVATE_FLAG	128
 #define FUTEX_CLOCK_REALTIME	256
-#define FUTEX_CMD_MASK		~(FUTEX_PRIVATE_FLAG | FUTEX_CLOCK_REALTIME)
+#define FUTEX_SIZE_8_BITS	512
+#define FUTEX_SIZE_16_BITS	1024
+#define FUTEX_SIZE_32_BITS	0
+#define FUTEX_ALL_SIZE_BITS	(FUTEX_SIZE_8_BITS | FUTEX_SIZE_16_BITS)
+#define FUTEX_CMD_MASK		~(FUTEX_PRIVATE_FLAG | FUTEX_CLOCK_REALTIME | \
+				  FUTEX_ALL_SIZE_BITS)

 #define FUTEX_WAIT_PRIVATE	(FUTEX_WAIT | FUTEX_PRIVATE_FLAG)
 #define FUTEX_WAKE_PRIVATE	(FUTEX_WAKE | FUTEX_PRIVATE_FLAG)
diff --git a/kernel/futex.c b/kernel/futex.c
index 6d50728ef2e7..803d93ff4f4a 100644
=2D-- a/kernel/futex.c
+++ b/kernel/futex.c
@@ -183,6 +183,8 @@ static int  __read_mostly futex_cmpxchg_enabled;
 #endif
 #define FLAGS_CLOCKRT		0x02
 #define FLAGS_HAS_TIMEOUT	0x04
+#define FLAGS_8_BITS		0x08
+#define FLAGS_16_BITS		0x10

 /*
  * Priority Inheritance state:
@@ -467,7 +469,14 @@ static void drop_futex_key_refs(union futex_key *key)

 enum futex_access {
 	FUTEX_READ,
-	FUTEX_WRITE
+	FUTEX_WRITE,
+	/*
+	 * for operations that only need the address and don't touch the
+	 * memory, like FUTEX_WAKE or FUTEX_REQUEUE. (not FUTEX_CMP_REQUEUE)
+	 * this will skip the size checks of the futex, allowing those
+	 * operations to be used with futexes of any size.
+	 */
+	FUTEX_NO_READ_WRITE
 };

 /**
@@ -504,7 +513,7 @@ futex_setup_timer(ktime_t *time, struct hrtimer_sleepe=
r *timeout,
 /**
  * get_futex_key() - Get parameters which are the keys for a futex
  * @uaddr:	virtual address of the futex
- * @fshared:	0 for a PROCESS_PRIVATE futex, 1 for PROCESS_SHARED
+ * @flags:	futex flags (FLAGS_SHARED, FLAGS_8_BITS etc.)
  * @key:	address where result is stored.
  * @rw:		mapping needs to be read/write (values: FUTEX_READ,
  *              FUTEX_WRITE)
@@ -520,25 +529,37 @@ futex_setup_timer(ktime_t *time, struct hrtimer_slee=
per *timeout,
  * lock_page() might sleep, the caller should not hold a spinlock.
  */
 static int
-get_futex_key(u32 __user *uaddr, int fshared, union futex_key *key, enum =
futex_access rw)
+get_futex_key(u32 __user *uaddr, int flags, union futex_key *key, enum fu=
tex_access rw)
 {
 	unsigned long address =3D (unsigned long)uaddr;
 	struct mm_struct *mm =3D current->mm;
 	struct page *page, *tail;
 	struct address_space *mapping;
-	int err, ro =3D 0;
+	int err, fshared, ro =3D 0;
+
+	fshared =3D flags & FLAGS_SHARED;

 	/*
 	 * The futex address must be "naturally" aligned.
 	 */
+	if (flags & FLAGS_8_BITS || rw =3D=3D FUTEX_NO_READ_WRITE) {
+		if (unlikely(!access_ok(uaddr, sizeof(u8))))
+			return -EFAULT;
+	} else if (flags & FLAGS_16_BITS) {
+		if (unlikely((address % sizeof(u16)) !=3D 0))
+			return -EINVAL;
+		if (unlikely(!access_ok(uaddr, sizeof(u16))))
+			return -EFAULT;
+	} else {
+		if (unlikely((address % sizeof(u32)) !=3D 0))
+			return -EINVAL;
+		if (unlikely(!access_ok(uaddr, sizeof(u32))))
+			return -EFAULT;
+	}
+
 	key->both.offset =3D address % PAGE_SIZE;
-	if (unlikely((address % sizeof(u32)) !=3D 0))
-		return -EINVAL;
 	address -=3D key->both.offset;

-	if (unlikely(!access_ok(uaddr, sizeof(u32))))
-		return -EFAULT;
-
 	if (unlikely(should_fail_futex(fshared)))
 		return -EFAULT;

@@ -566,7 +587,7 @@ get_futex_key(u32 __user *uaddr, int fshared, union fu=
tex_key *key, enum futex_a
 	 * If write access is not required (eg. FUTEX_WAIT), try
 	 * and get read-only access.
 	 */
-	if (err =3D=3D -EFAULT && rw =3D=3D FUTEX_READ) {
+	if (err =3D=3D -EFAULT && rw !=3D FUTEX_WRITE) {
 		err =3D get_user_pages_fast(address, 1, 0, &page);
 		ro =3D 1;
 	}
@@ -799,6 +820,48 @@ static int get_futex_value_locked(u32 *dest, u32 __us=
er *from)
 	return ret ? -EFAULT : 0;
 }

+static int
+get_futex_value_locked_any_size(u32 *dest, u32 __user *from, int flags)
+{
+	int ret;
+	u8 dest_8_bits;
+	u16 dest_16_bits;
+
+	pagefault_disable();
+	if (flags & FLAGS_8_BITS) {
+		ret =3D __get_user(dest_8_bits, (u8 __user *)from);
+		*dest =3D dest_8_bits;
+	} else if (flags & FLAGS_16_BITS) {
+		ret =3D __get_user(dest_16_bits, (u16 __user *)from);
+		*dest =3D dest_16_bits;
+	} else {
+		ret =3D __get_user(*dest, from);
+	}
+	pagefault_enable();
+
+	return ret ? -EFAULT : 0;
+}
+
+static int get_futex_value_any_size(u32 *dest, u32 __user *from, int flag=
s)
+{
+	int ret;
+	u8 uval_8_bits;
+	u16 uval_16_bits;
+
+	if (flags & FLAGS_8_BITS) {
+		ret =3D get_user(uval_8_bits, (u8 __user *)from);
+		if (ret =3D=3D 0)
+			*dest =3D uval_8_bits;
+	} else if (flags & FLAGS_16_BITS) {
+		ret =3D get_user(uval_16_bits, (u16 __user *)from);
+		if (ret =3D=3D 0)
+			*dest =3D uval_16_bits;
+	} else {
+		ret =3D get_user(*dest, from);
+	}
+	return ret;
+}
+

 /*
  * PI code:
@@ -1605,7 +1668,7 @@ futex_wake(u32 __user *uaddr, unsigned int flags, in=
t nr_wake, u32 bitset)
 	if (!bitset)
 		return -EINVAL;

-	ret =3D get_futex_key(uaddr, flags & FLAGS_SHARED, &key, FUTEX_READ);
+	ret =3D get_futex_key(uaddr, flags, &key, FUTEX_NO_READ_WRITE);
 	if (unlikely(ret !=3D 0))
 		goto out;

@@ -1704,10 +1767,10 @@ futex_wake_op(u32 __user *uaddr1, unsigned int fla=
gs, u32 __user *uaddr2,
 	DEFINE_WAKE_Q(wake_q);

 retry:
-	ret =3D get_futex_key(uaddr1, flags & FLAGS_SHARED, &key1, FUTEX_READ);
+	ret =3D get_futex_key(uaddr1, flags, &key1, FUTEX_READ);
 	if (unlikely(ret !=3D 0))
 		goto out;
-	ret =3D get_futex_key(uaddr2, flags & FLAGS_SHARED, &key2, FUTEX_WRITE);
+	ret =3D get_futex_key(uaddr2, flags, &key2, FUTEX_WRITE);
 	if (unlikely(ret !=3D 0))
 		goto out_put_key1;

@@ -1983,11 +2046,12 @@ static int futex_requeue(u32 __user *uaddr1, unsig=
ned int flags,
 	}

 retry:
-	ret =3D get_futex_key(uaddr1, flags & FLAGS_SHARED, &key1, FUTEX_READ);
+	ret =3D get_futex_key(uaddr1, flags, &key1,
+			    cmpval ? FUTEX_READ : FUTEX_NO_READ_WRITE);
 	if (unlikely(ret !=3D 0))
 		goto out;
-	ret =3D get_futex_key(uaddr2, flags & FLAGS_SHARED, &key2,
-			    requeue_pi ? FUTEX_WRITE : FUTEX_READ);
+	ret =3D get_futex_key(uaddr2, flags, &key2,
+			    requeue_pi ? FUTEX_WRITE : FUTEX_NO_READ_WRITE);
 	if (unlikely(ret !=3D 0))
 		goto out_put_key1;

@@ -2010,13 +2074,13 @@ static int futex_requeue(u32 __user *uaddr1, unsig=
ned int flags,
 	if (likely(cmpval !=3D NULL)) {
 		u32 curval;

-		ret =3D get_futex_value_locked(&curval, uaddr1);
+		ret =3D get_futex_value_locked_any_size(&curval, uaddr1, flags);

 		if (unlikely(ret)) {
 			double_unlock_hb(hb1, hb2);
 			hb_waiters_dec(hb2);

-			ret =3D get_user(curval, uaddr1);
+			ret =3D get_futex_value_any_size(&curval, uaddr1, flags);
 			if (ret)
 				goto out_put_keys;

@@ -2673,19 +2737,19 @@ static int futex_wait_setup(u32 __user *uaddr, u32=
 val, unsigned int flags,
 	 * while the syscall executes.
 	 */
 retry:
-	ret =3D get_futex_key(uaddr, flags & FLAGS_SHARED, &q->key, FUTEX_READ);
+	ret =3D get_futex_key(uaddr, flags, &q->key, FUTEX_READ);
 	if (unlikely(ret !=3D 0))
 		return ret;

 retry_private:
 	*hb =3D queue_lock(q);

-	ret =3D get_futex_value_locked(&uval, uaddr);
+	ret =3D get_futex_value_locked_any_size(&uval, uaddr, flags);

 	if (ret) {
 		queue_unlock(*hb);

-		ret =3D get_user(uval, uaddr);
+		ret =3D get_futex_value_any_size(&uval, uaddr, flags);
 		if (ret)
 			goto out;

@@ -2817,7 +2881,7 @@ static int futex_lock_pi(u32 __user *uaddr, unsigned=
 int flags,
 	to =3D futex_setup_timer(time, &timeout, FLAGS_CLOCKRT, 0);

 retry:
-	ret =3D get_futex_key(uaddr, flags & FLAGS_SHARED, &q.key, FUTEX_WRITE);
+	ret =3D get_futex_key(uaddr, flags, &q.key, FUTEX_WRITE);
 	if (unlikely(ret !=3D 0))
 		goto out;

@@ -3000,7 +3064,7 @@ static int futex_unlock_pi(u32 __user *uaddr, unsign=
ed int flags)
 	if ((uval & FUTEX_TID_MASK) !=3D vpid)
 		return -EPERM;

-	ret =3D get_futex_key(uaddr, flags & FLAGS_SHARED, &key, FUTEX_WRITE);
+	ret =3D get_futex_key(uaddr, flags, &key, FUTEX_WRITE);
 	if (ret)
 		return ret;

@@ -3237,7 +3301,7 @@ static int futex_wait_requeue_pi(u32 __user *uaddr, =
unsigned int flags,
 	 */
 	rt_mutex_init_waiter(&rt_waiter);

-	ret =3D get_futex_key(uaddr2, flags & FLAGS_SHARED, &key2, FUTEX_WRITE);
+	ret =3D get_futex_key(uaddr2, flags, &key2, FUTEX_WRITE);
 	if (unlikely(ret !=3D 0))
 		goto out;

@@ -3627,6 +3691,57 @@ long do_futex(u32 __user *uaddr, int op, u32 val, k=
time_t *timeout,
 		    cmd !=3D FUTEX_WAIT_REQUEUE_PI)
 			return -ENOSYS;
 	}
+	if (op & FUTEX_ALL_SIZE_BITS) {
+		switch (cmd) {
+		case FUTEX_CMP_REQUEUE:
+			/*
+			 * for cmp_requeue, only uaddr has to be of the size
+			 * passed in the flags. uaddr2 can be of any size
+			 */
+		case FUTEX_WAIT:
+		case FUTEX_WAIT_BITSET:
+			switch (op & FUTEX_ALL_SIZE_BITS) {
+			case FUTEX_SIZE_8_BITS:
+				flags |=3D FLAGS_8_BITS;
+				break;
+			case FUTEX_SIZE_16_BITS:
+				flags |=3D FLAGS_16_BITS;
+				break;
+			case FUTEX_SIZE_32_BITS:
+				break;
+			default:
+				/*
+				 * if both bits are set we could silently treat
+				 * that as a 32 bit futex, but we may want to
+				 * use this pattern in the future to indicate a
+				 * 64 bit futex or an arbitrarily sized futex.
+				 * so we don't want code relying on this yet.
+				 */
+				return -EINVAL;
+			}
+			break;
+		case FUTEX_WAKE:
+		case FUTEX_REQUEUE:
+			/*
+			 * these instructions work with sized mutexes, but you
+			 * don't need to pass the size. we could silently
+			 * ignore the size argument, but the code won't verify
+			 * that the correct size is used, so it's preferable
+			 * to make that clear to the caller.
+			 *
+			 * for requeue the meaning would also be ambiguous: do
+			 * both of them have to be the same size or not? they
+			 * don't, and that's clearer when you just don't pass
+			 * a size argument.
+			 */
+			return -EINVAL;
+		default:
+			/*
+			 * all other cases are not supported yet
+			 */
+			return -EINVAL;
+		}
+	}

 	switch (cmd) {
 	case FUTEX_LOCK_PI:
=2D-
2.17.1

