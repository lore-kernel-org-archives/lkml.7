Return-Path: <SRS0=w7sF=2K=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B0C91C43603
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Dec 2019 19:10:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 704EA206D3
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Dec 2019 19:10:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=web.de header.i=@web.de header.b="EYT/gh8x"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727517AbfLTTKI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 20 Dec 2019 14:10:08 -0500
Received: from mout.web.de ([212.227.17.11]:43589 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727489AbfLTTKI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Dec 2019 14:10:08 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
        s=dbaedf251592; t=1576868987;
        bh=YrinpYaGsoitJvvhjG6ror6CcWzIBSZIo7klbJaPhDw=;
        h=X-UI-Sender-Class:From:To:Cc:Subject:Date:In-Reply-To:References;
        b=EYT/gh8xgRb6G7avVvFD595DFJcQcYncCWZ4YR1bBUkbKoa4Qds0D1XX0iwZkmxCC
         2oFo86Ng40LQn1cF/jK31Wxm71ER3i9W5KS0OBHLoPuoZsJJsE7UkIMpx78eiDz030
         Yc4Km1EjN1PDlhoUTIAaziHVrgT39rZw3PgbZYEI=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from localhost.localdomain ([67.254.165.9]) by smtp.web.de (mrweb102
 [213.165.67.124]) with ESMTPSA (Nemesis) id 0MAvGa-1iYVkl0708-00A236; Fri, 20
 Dec 2019 20:09:47 +0100
From:   Malte Skarupke <malteskarupke@web.de>
To:     tglx@linutronix.de, mingo@redhat.com
Cc:     peterz@infradead.org, dvhart@infradead.org,
        linux-kernel@vger.kernel.org, malteskarupke@fastmail.fm,
        malteskarupke@web.de
Subject: [PATCH] futex: Support smaller futexes of one byte or two byte size.
Date:   Fri, 20 Dec 2019 14:09:00 -0500
Message-Id: <20191220190901.23465-2-malteskarupke@web.de>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20191220190901.23465-1-malteskarupke@web.de>
References: <20191204235238.10764-1-malteskarupke@web.de>
 <20191220190901.23465-1-malteskarupke@web.de>
X-Provags-ID: V03:K1:j91dolRVH3sPvUqHUnlmutv5C2rWtIKITEheYlksWNny5TbMQck
 YylWnH6RRmEpysL4/9i596ENEplRJ2XEHmsS8uAf6QjvAs5PdO26CaqX58E0iylpCUHQDkg
 e843854T+PjaMV9OpKwIa93soduH+fYt/Vyrwd2OGvSR2FfriVKYQ33H3WiA9dzN9LRFXW8
 f9mopn0MD1LK/E4YRZJSA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:53DGaLHuTng=:SfmHh2FrilgR3hoEb5KhrL
 Oc86jW+3H2nlWTeV6jcke1MVH+kasyNVHNs2UP8hXE9rDQIkWloCFUKBS2ZNurqpzz2zDx+az
 2ue9TWFwPtK5g+LGbHEVdfHzvMQfBX/qktzUEel+TALB3MAtJsZ5Q4RoYDoCQoRkJ95+wvmTz
 KNfFkdLCNbvDvQE7SwOX8XKVhr2n4hSpvJb3EFxhG+tfIHXds5P6TSd2NegzqC1FoqDZmY1Q7
 r2neBUL4xj5lwf+sUbDG+ejUyIKSQtgZQzZvKo4mqMcSAF2p2noW4QTXF7l+ObivXyaTk7K/o
 J55ivYpP5zFO6fXvRDWUxJSqQfTBupoAVQQnLAF5PyS00bdgd1LIc7eMthZxGajdJeqCLwFjW
 8rVZtFxbn3vgaikxXtBVtci5qKiatgN1zQlb53eZ1ilS+ZBmTDU5g/nYz6uELclhSMpWWdALk
 qXORGVVfnseNXGOftSH7+pGdgKAtwZSihFO9lMeuWrJVeqlbzhUAbXvY9y20WrtUB5J/bgqUP
 7gi9V5aj0C9OGDdvy5MKNvqNzPNurEiJlg0CYr7YxExIA/XhrJPvF+Bv/JSqQ0MfK6D3q9EY5
 ur8mHL6RDQ+GeGeuMQce9bAylDjxsjZqwxCbpylUBVWb7xqIvGAZNQNnwFRCdn+85032XJd3h
 nh23FvGCMAnzwFjvPd+laixVigO0NJ+qUBNMUnXKicVElCS0lcFfy/CyIYlvChZmcZIPwKK5v
 oLvvx+4dZHYxg8R28KzBCFfaMYvWOBhVPC3geJlMPlbhSJkz9x4Nd47lKcqWqUEmx5e6dvqtm
 ld7rR/mXk2SnELzxIkGQvfyg4TJxGiqT9Mj9xD9FZQSBz46plNDrJK8O9Xe55anyTUs3leNSb
 HW2t/C8nP1QwWEneZH4nqeD33cE9mg1eMpCfaaak1Sd11TK8XC7bg2g10kQxNrAkMFor8H6Wd
 3qOT1MnkXaucj2s8aRaeo0hkoXS2RbufBB8ug36khmeUGrpRXNXZJ3eNjuFi6wZjhEAUPw2mp
 phUNvWwrclUppO7PnIL0r/GmV0w+5ysgp8tyFZSnlM5PZLgOHgNpHcCUlun8kMX4bZuNt1rIE
 gSJsAXNSnMuxgA0+/xRLNhLR13LkvKLJaJUD+t3t6A/6uX6vevOQf2vUNe7y2FVrPlnWpkhxB
 bkD+Ldiku9L+H7pmjPzszncDGqiSOeSV++wa0ci8IwriW0MWJ1oVgzfmtnJ9az6ChvyBwzgFr
 /o+R1U+lhLHzPbrHifx9bbXnrzYfp7eQDR75jjy7uvxUjW8CfV2ypCKBjIzY=
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is option 1 out of 2. In both versions only the operations WAIT, WAKE=
,
REQUEUE and CMP_REQUEUE are supported. In this version WAIT and CMP_REQUEU=
E
take a size argument, WAKE and REQUEUE do not and work on futexes of all
sizes. The other option requires a size for those operations, too. See the
mailing list for discussions as to which option we should use.

None of these operations handle overlapping futexes. The mental model is
comparison+hashtable lookup and only an exact match on the address will fi=
nd
the matching futex between WAIT and WAKE. An alternative would have been t=
he
MONITOR/MWAIT mental model to handle overlapping futexes of different size=
s,
but for mutexes and condition variables I just needed the normal futex
behavior. (except with smaller types)

There are two reasons for adding smaller futexes:
1. People often want smaller mutexes. Having mutexes that are only one byt=
e in
size was the first reason WebKit gave for re-implementing futexes:
https://webkit.org/blog/6161/locking-in-webkit/

2. The C++ standard added futexes to the standard library in C++20 under t=
he
name atomic_wait and atomic_notify:
http://www.open-std.org/jtc1/sc22/wg21/docs/papers/2019/p1135r5.html
The C++ version supports this for atomic variables of any size. The more s=
izes
we can support, the better the standard implementation can be on Linux.

I changed the location of two flags that used to be stored in the low bits=
 of
the address, since the address is no longer aligned on four bytes. Luckily=
 the
high bits were free as long as PAGE_SIZE is never more than 1 gigabyte.

The reason for only supporting 8 bit futexes and 16 bit futexes is that th=
ose
were easy to support with the existing interface. 64 bit futexes would req=
uire
bigger changes.

The reason for only supporting WAIT/WAKE and REQUEUE/CMP_REQUEUE is that t=
hose
are the only operations I need right now. (in fact the C++ standard only n=
eeds
WAIT/WAKE) The other operations are more complicated and will have to wait=
.

Signed-off-by: Malte Skarupke <malteskarupke@web.de>
=2D--
 include/linux/futex.h      |  10 ++-
 include/uapi/linux/futex.h |   7 +-
 kernel/futex.c             | 155 +++++++++++++++++++++++++++++++------
 3 files changed, 145 insertions(+), 27 deletions(-)

diff --git a/include/linux/futex.h b/include/linux/futex.h
index 5cc3fed27d4c..3655e026c914 100644
=2D-- a/include/linux/futex.h
+++ b/include/linux/futex.h
@@ -16,8 +16,8 @@ struct task_struct;
  * The key type depends on whether it's a shared or private mapping.
  * Don't rearrange members without looking at hash_futex().
  *
- * offset is aligned to a multiple of sizeof(u32) (=3D=3D 4) by definitio=
n.
- * We use the two low order bits of offset to tell what is the kind of ke=
y :
+ * offset is the position within a page and is in the range [0, PAGE_SIZE=
).
+ * The high bits of offset indicate what kind of key this is :
  *  00 : Private process futex (PTHREAD_PROCESS_PRIVATE)
  *       (no reference on an inode or mm)
  *  01 : Shared futex (PTHREAD_PROCESS_SHARED)
@@ -26,8 +26,10 @@ struct task_struct;
  *       (but private mapping on an mm, and reference taken on it)
 */

-#define FUT_OFF_INODE    1 /* We set bit 0 if key has a reference on inod=
e */
-#define FUT_OFF_MMSHARED 2 /* We set bit 1 if key has a reference on mm *=
/
+/* We set the next highest bit if key has a reference on inode */
+#define FUT_OFF_INODE		PAGE_SIZE
+/* We set the bit after that if key has a reference on mm */
+#define FUT_OFF_MMSHARED	(PAGE_SIZE << 1)

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
index 03c518e9747e..0e55295fa23e 100644
=2D-- a/kernel/futex.c
+++ b/kernel/futex.c
@@ -183,6 +183,9 @@ static int  __read_mostly futex_cmpxchg_enabled;
 #endif
 #define FLAGS_CLOCKRT		0x02
 #define FLAGS_HAS_TIMEOUT	0x04
+#define FLAGS_8_BITS		0x08
+#define FLAGS_16_BITS		0x10
+#define FLAGS_SIZE_BITS		(FLAGS_8_BITS | FLAGS_16_BITS)

 /*
  * Priority Inheritance state:
@@ -473,7 +476,14 @@ static void drop_futex_key_refs(union futex_key *key)

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
+	FUTEX_NONE
 };

 /**
@@ -505,10 +515,20 @@ futex_setup_timer(ktime_t *time, struct hrtimer_slee=
per *timeout,
 	return timeout;
 }

+static inline int futex_size(int flags)
+{
+	if (flags & FLAGS_8_BITS)
+		return sizeof(u8);
+	else if (flags & FLAGS_16_BITS)
+		return sizeof(u16);
+	else
+		return sizeof(u32);
+}
+
 /**
  * get_futex_key() - Get parameters which are the keys for a futex
  * @uaddr:	virtual address of the futex
- * @fshared:	0 for a PROCESS_PRIVATE futex, 1 for PROCESS_SHARED
+ * @flags:	futex flags (FLAGS_SHARED, FLAGS_8_BITS etc.)
  * @key:	address where result is stored.
  * @rw:		mapping needs to be read/write (values: FUTEX_READ,
  *              FUTEX_WRITE)
@@ -524,23 +544,29 @@ futex_setup_timer(ktime_t *time, struct hrtimer_slee=
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
+	int err, fshared, size, ro =3D 0;
+
+	fshared =3D flags & FLAGS_SHARED;
+	if (rw =3D=3D FUTEX_NONE)
+		size =3D 1;
+	else
+		size =3D futex_size(flags);

 	/*
 	 * The futex address must be "naturally" aligned.
 	 */
 	key->both.offset =3D address % PAGE_SIZE;
-	if (unlikely((address % sizeof(u32)) !=3D 0))
+	if (unlikely((address & (size - 1)) !=3D 0))
 		return -EINVAL;
 	address -=3D key->both.offset;

-	if (unlikely(!access_ok(uaddr, sizeof(u32))))
+	if (unlikely(!access_ok(uaddr, size)))
 		return -EFAULT;

 	if (unlikely(should_fail_futex(fshared)))
@@ -570,7 +596,7 @@ get_futex_key(u32 __user *uaddr, int fshared, union fu=
tex_key *key, enum futex_a
 	 * If write access is not required (eg. FUTEX_WAIT), try
 	 * and get read-only access.
 	 */
-	if (err =3D=3D -EFAULT && rw =3D=3D FUTEX_READ) {
+	if (err =3D=3D -EFAULT && rw !=3D FUTEX_WRITE) {
 		err =3D get_user_pages_fast(address, 1, 0, &page);
 		ro =3D 1;
 	}
@@ -792,6 +818,18 @@ static int cmpxchg_futex_value_locked(u32 *curval, u3=
2 __user *uaddr,
 	return ret;
 }

+static inline int __get_sized_futex_value(u32 *dest, u32 __user *from, in=
t size)
+{
+	switch (size) {
+	case 1:
+		return __get_user(*dest, (u8 __user *)from);
+	case 2:
+		return __get_user(*dest, (u16 __user *)from);
+	default:
+		return __get_user(*dest, from);
+	}
+}
+
 static int get_futex_value_locked(u32 *dest, u32 __user *from)
 {
 	int ret;
@@ -803,6 +841,26 @@ static int get_futex_value_locked(u32 *dest, u32 __us=
er *from)
 	return ret ? -EFAULT : 0;
 }

+static int get_sized_futex_value_locked(u32 *dest, u32 __user *from, int =
size)
+{
+	int ret;
+
+	pagefault_disable();
+	ret =3D __get_sized_futex_value(dest, from, size);
+	pagefault_enable();
+
+	return ret ? -EFAULT : 0;
+}
+
+static int get_sized_futex_value(u32 *dest, u32 __user *from, int size)
+{
+	might_fault();
+	if (access_ok(from, size))
+		return __get_sized_futex_value(dest, from, size);
+	else
+		return -EFAULT;
+}
+

 /*
  * PI code:
@@ -1663,7 +1721,7 @@ futex_wake(u32 __user *uaddr, unsigned int flags, in=
t nr_wake, u32 bitset)
 	if (!bitset)
 		return -EINVAL;

-	ret =3D get_futex_key(uaddr, flags & FLAGS_SHARED, &key, FUTEX_READ);
+	ret =3D get_futex_key(uaddr, flags, &key, FUTEX_NONE);
 	if (unlikely(ret !=3D 0))
 		goto out;

@@ -1762,10 +1820,10 @@ futex_wake_op(u32 __user *uaddr1, unsigned int fla=
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

@@ -2047,11 +2105,12 @@ static int futex_requeue(u32 __user *uaddr1, unsig=
ned int flags,
 	}

 retry:
-	ret =3D get_futex_key(uaddr1, flags & FLAGS_SHARED, &key1, FUTEX_READ);
+	ret =3D get_futex_key(uaddr1, flags, &key1,
+			    cmpval ? FUTEX_READ : FUTEX_NONE);
 	if (unlikely(ret !=3D 0))
 		goto out;
-	ret =3D get_futex_key(uaddr2, flags & FLAGS_SHARED, &key2,
-			    requeue_pi ? FUTEX_WRITE : FUTEX_READ);
+	ret =3D get_futex_key(uaddr2, flags, &key2,
+			    requeue_pi ? FUTEX_WRITE : FUTEX_NONE);
 	if (unlikely(ret !=3D 0))
 		goto out_put_key1;

@@ -2073,14 +2132,15 @@ static int futex_requeue(u32 __user *uaddr1, unsig=
ned int flags,

 	if (likely(cmpval !=3D NULL)) {
 		u32 curval;
+		int size =3D futex_size(flags);

-		ret =3D get_futex_value_locked(&curval, uaddr1);
+		ret =3D get_sized_futex_value_locked(&curval, uaddr1, size);

 		if (unlikely(ret)) {
 			double_unlock_hb(hb1, hb2);
 			hb_waiters_dec(hb2);

-			ret =3D get_user(curval, uaddr1);
+			ret =3D get_sized_futex_value(&curval, uaddr1, size);
 			if (ret)
 				goto out_put_keys;

@@ -2727,7 +2787,7 @@ static int futex_wait_setup(u32 __user *uaddr, u32 v=
al, unsigned int flags,
 			   struct futex_q *q, struct futex_hash_bucket **hb)
 {
 	u32 uval;
-	int ret;
+	int ret, size =3D futex_size(flags);

 	/*
 	 * Access the page AFTER the hash-bucket is locked.
@@ -2748,19 +2808,19 @@ static int futex_wait_setup(u32 __user *uaddr, u32=
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
+	ret =3D get_sized_futex_value_locked(&uval, uaddr, size);

 	if (ret) {
 		queue_unlock(*hb);

-		ret =3D get_user(uval, uaddr);
+		ret =3D get_sized_futex_value(&uval, uaddr, size);
 		if (ret)
 			goto out;

@@ -2893,7 +2953,7 @@ static int futex_lock_pi(u32 __user *uaddr, unsigned=
 int flags,
 	to =3D futex_setup_timer(time, &timeout, FLAGS_CLOCKRT, 0);

 retry:
-	ret =3D get_futex_key(uaddr, flags & FLAGS_SHARED, &q.key, FUTEX_WRITE);
+	ret =3D get_futex_key(uaddr, flags, &q.key, FUTEX_WRITE);
 	if (unlikely(ret !=3D 0))
 		goto out;

@@ -3084,7 +3144,7 @@ static int futex_unlock_pi(u32 __user *uaddr, unsign=
ed int flags)
 	if ((uval & FUTEX_TID_MASK) !=3D vpid)
 		return -EPERM;

-	ret =3D get_futex_key(uaddr, flags & FLAGS_SHARED, &key, FUTEX_WRITE);
+	ret =3D get_futex_key(uaddr, flags, &key, FUTEX_WRITE);
 	if (ret)
 		return ret;

@@ -3321,7 +3381,7 @@ static int futex_wait_requeue_pi(u32 __user *uaddr, =
unsigned int flags,
 	 */
 	rt_mutex_init_waiter(&rt_waiter);

-	ret =3D get_futex_key(uaddr2, flags & FLAGS_SHARED, &key2, FUTEX_WRITE);
+	ret =3D get_futex_key(uaddr2, flags, &key2, FUTEX_WRITE);
 	if (unlikely(ret !=3D 0))
 		goto out;

@@ -3847,6 +3907,13 @@ void futex_exit_release(struct task_struct *tsk)
 	futex_cleanup_end(tsk, FUTEX_STATE_DEAD);
 }

+int futex_op_to_size_flags(int op)
+{
+	int size_flags =3D op & FUTEX_ALL_SIZE_BITS;
+
+	return (size_flags / FUTEX_SIZE_8_BITS) * FLAGS_8_BITS;
+}
+
 long do_futex(u32 __user *uaddr, int op, u32 val, ktime_t *timeout,
 		u32 __user *uaddr2, u32 val2, u32 val3)
 {
@@ -3862,6 +3929,50 @@ long do_futex(u32 __user *uaddr, int op, u32 val, k=
time_t *timeout,
 		    cmd !=3D FUTEX_WAIT_REQUEUE_PI)
 			return -ENOSYS;
 	}
+	if (op & FUTEX_ALL_SIZE_BITS) {
+		flags |=3D futex_op_to_size_flags(op);
+		if ((flags & FLAGS_SIZE_BITS) =3D=3D FLAGS_SIZE_BITS) {
+			/*
+			 * if both bits are set we could silently treat that as
+			 * a 32 bit futex, but we may want to use this pattern
+			 * in the future to indicate a 64 bit futex or an
+			 * arbitrarily sized futex. so we don't want code
+			 * relying on this yet.
+			 */
+			return -EINVAL;
+		}
+		switch (cmd) {
+		case FUTEX_CMP_REQUEUE:
+			/*
+			 * for cmp_requeue, only uaddr has to be of the size
+			 * passed in the flags. uaddr2 can be of any size
+			 */
+		case FUTEX_WAIT:
+		case FUTEX_WAIT_BITSET:
+			break;
+		case FUTEX_WAKE:
+		case FUTEX_WAKE_BITSET:
+		case FUTEX_REQUEUE:
+			/*
+			 * these instructions work with sized futexes, but you
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

