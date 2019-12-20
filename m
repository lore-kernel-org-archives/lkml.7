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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 51270C43603
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Dec 2019 19:10:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0C589206D3
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Dec 2019 19:10:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=web.de header.i=@web.de header.b="p7lglciT"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727536AbfLTTKL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 20 Dec 2019 14:10:11 -0500
Received: from mout.web.de ([212.227.17.11]:52455 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727492AbfLTTKK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Dec 2019 14:10:10 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
        s=dbaedf251592; t=1576868990;
        bh=AjqZtHnxoUpZCBXC8JQ8PZgIMXEYxr/lYtVVTrXUlC8=;
        h=X-UI-Sender-Class:From:To:Cc:Subject:Date:In-Reply-To:References;
        b=p7lglciTcJQRtqAg64yx8ojdTkIzbTGQ8Dy3NsJx2BLcnYIIXt9Tet2YjHUam/GMv
         NbSpj47FB4ePbZKKWRIdzkH5foPDZ/AIFD6ARMmiccAJVh+C1OcndwUsrY0yjbvXPn
         mpzZO4EC3Y59aWuZtXQWF2IQZHzn7d79bEZDjKKE=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from localhost.localdomain ([67.254.165.9]) by smtp.web.de (mrweb102
 [213.165.67.124]) with ESMTPSA (Nemesis) id 0LiUG8-1i60Z81mWK-00cj1E; Fri, 20
 Dec 2019 20:09:50 +0100
From:   Malte Skarupke <malteskarupke@web.de>
To:     tglx@linutronix.de, mingo@redhat.com
Cc:     peterz@infradead.org, dvhart@infradead.org,
        linux-kernel@vger.kernel.org, malteskarupke@fastmail.fm,
        malteskarupke@web.de
Subject: [PATCH] futex: Support smaller futexes of one byte or two byte size.
Date:   Fri, 20 Dec 2019 14:09:01 -0500
Message-Id: <20191220190901.23465-3-malteskarupke@web.de>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20191220190901.23465-2-malteskarupke@web.de>
References: <20191204235238.10764-1-malteskarupke@web.de>
 <20191220190901.23465-1-malteskarupke@web.de>
 <20191220190901.23465-2-malteskarupke@web.de>
X-Provags-ID: V03:K1:uaeOG7OIoxxD8WbZ0Qf8Rx/YoIouLOqc6Zo/4WZxVvVyTzyl3JX
 IaD6Oj/UXdfFxqNHUjoCTQJ8STQ8g8RXzlATq7g4ITZ/s7xlZs+kgmPVPM1d16W+lF7TDJ2
 XzVQkhH1mhIT3rmkcLIwpuhpq4h/WDskwxbKS2FIRxl8i9+5WUqZ5EFKlScz4OpXtq3CVPA
 V1MWEwRP9lbLDuO9EvySg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:k9gSIAS8VYk=:IfPCqDDdASJCNmkfQedH0+
 Jd0YdptD0symHYJaDXvLPyLsuVHw3P3LEMCD74YgzkvR8SJ2NFGpy/Yx+Ym18Wf7sZS1p/eLv
 02R5cM2I4ss0eY0n6XHH4OTBhhkx8EblCNb2J1zeKwmsc58IBGdKvx/WuZI6YiXMj0cXR6XEu
 eBdl7mMX5oTvq3Zf/fTX+akMz6z7ArCogVcPdwJHS2Fh3gyLd5wRh0g+UVuNu8HFsAK33T0Hi
 9t/6XYBYmcPwhLDOiufiSwfft9DeuaFQ6g8o/LQ0pBuVMMLwkM2X/SMXOi3khH3VJV2boghsv
 GVog4j34jGfMhP7it9VwfhELjoFeUHssjNgUc6UgSpBMndTQUznv1tn4Dej1ze7WUFLI2KG8U
 6gUxqtNTL+LOigaEUYIxxra3lGCvPmxqnStMtqWatx+0nZlI+v5Fzte4Kh8Q52vXvlI4zvDp5
 R7OHWhKKsQvvaSmH4fFVYiaU1UFjjS98toxViXZ6yamGtJc6UkCLoaQfkH7vTXj/HW+4kGGfW
 gyBL1ZmULtYwvhriECsSIgltCVAnhhHDhhlOxlXmzjUwrRuP9fWSKjXlIGhanmcu4JqfkK7ZB
 DQ0qR7MOtRlZjL5HPZoG+8NO6l5Zudjq03LUlikFtQM9+lxOVGG0M+mNfthWDAYTYfBGBNMEf
 Lhc+jDn0CqrqsG0GG45waEWaKlYUf3/QrA5tsaerLMYp5z9oKT+Bk1pFRaPreayd0S+m2f7H7
 wUvz5PsxWfPRC4xUb8RScV8XELN+wURCZFByuqpb3j39uCEU/jB1/RG9A1fj1i9zyvBIiQVRb
 sA+mvVcW12seCc+RjuLEg1EvoBHN7Cyc9gXWGnmI02jPNDsD/wQrxuHDegpZ8c2kVGcXjAgUc
 UI8dVZ4/F89jnkT43+EDi8j9JkhvUjkVaagX+NcO6HsbXVKB9TbvMMQxm93lFhuzv5igLWyIC
 xoQQxueCpqOA7vn2rzRjHmSuF8G/JpP/oq1B4EwkmJAJiFhdNGlwTYPjaIcGDQtAE77/2uXuy
 OtzJ7JnMjXmX/D8YXeb6y20K7zYTVeNgOrPM6nVXDsJ4AAYxwFal4HpPkEQWO2rKM6MaYWXBR
 rWPRsGkw+9JN+QlQZpjOPoWV5ioEA9TawUSDyFqJ+LvwFgIEwtmlII6hAUE46XoindVRXMkpg
 iO2AhnoGkJK1esCp3LKCrCJV0B4nqaREQ6CK5KwzTDaVKc+gyWrieuw5QHaXu9b0JbiB90gT1
 oiSMmZyF32lIkb7FhnivJJ5IRlUEbm/B7R/U0xe0qZSYOjBJuH5tLuYY5dQ8=
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is option 2 out of 2. In both versions only the operations WAIT, WAKE=
,
REQUEUE and CMP_REQUEUE are supported. In this version all four of those
operations take a size argument. WAKE and REQUEUE only use the size argume=
nt
to verify that they were called with the same flags as the matching WAIT. =
WAIT
and CMP_REQUEUE use the size argument only for the "compare" part of their
operation. The other option would not have required a size argument for WA=
KE
and REQUEUE. See the mailing list for discussions as to which option we
should use.

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
 include/linux/futex.h      |  19 +++-
 include/uapi/linux/futex.h |  12 ++-
 kernel/futex.c             | 183 ++++++++++++++++++++++++++++++++-----
 3 files changed, 186 insertions(+), 28 deletions(-)

diff --git a/include/linux/futex.h b/include/linux/futex.h
index 5cc3fed27d4c..c05f4ad57133 100644
=2D-- a/include/linux/futex.h
+++ b/include/linux/futex.h
@@ -16,18 +16,29 @@ struct task_struct;
  * The key type depends on whether it's a shared or private mapping.
  * Don't rearrange members without looking at hash_futex().
  *
- * offset is aligned to a multiple of sizeof(u32) (=3D=3D 4) by definitio=
n.
- * We use the two low order bits of offset to tell what is the kind of ke=
y :
+ * offset is the position within a page and is in the range [0, PAGE_SIZE=
).
+ * The high bits of offset are used to store flags :
+ * The next two bits above PAGE_SIZE indicate what kind of key this is :
  *  00 : Private process futex (PTHREAD_PROCESS_PRIVATE)
  *       (no reference on an inode or mm)
  *  01 : Shared futex (PTHREAD_PROCESS_SHARED)
  *	mapped on a file (reference on the underlying inode)
  *  10 : Shared futex (PTHREAD_PROCESS_SHARED)
  *       (but private mapping on an mm, and reference taken on it)
+ * The two bits after that indicate the size of the futex :
+ *  00 : 32 bits
+ *  01 : 8 bits
+ :  10 : 16 bits
 */

-#define FUT_OFF_INODE    1 /* We set bit 0 if key has a reference on inod=
e */
-#define FUT_OFF_MMSHARED 2 /* We set bit 1 if key has a reference on mm *=
/
+/* We set the next highest bit if key has a reference on inode */
+#define FUT_OFF_INODE		PAGE_SIZE
+/* We set the bit after that if key has a reference on mm */
+#define FUT_OFF_MMSHARED	(PAGE_SIZE << 1)
+/* The bits after that indicate futexes of different sizes */
+#define FUT_OFF_8_BITS		(PAGE_SIZE << 2)
+#define FUT_OFF_16_BITS		(PAGE_SIZE << 3)
+#define FUT_OFF_SIZE_BITS	(FUT_OFF_8_BITS | FUT_OFF_16_BITS)

 union futex_key {
 	struct {
diff --git a/include/uapi/linux/futex.h b/include/uapi/linux/futex.h
index a89eb0accd5e..885961388c57 100644
=2D-- a/include/uapi/linux/futex.h
+++ b/include/uapi/linux/futex.h
@@ -24,7 +24,17 @@

 #define FUTEX_PRIVATE_FLAG	128
 #define FUTEX_CLOCK_REALTIME	256
-#define FUTEX_CMD_MASK		~(FUTEX_PRIVATE_FLAG | FUTEX_CLOCK_REALTIME)
+#define FUTEX_SIZE_8_BITS	512
+#define FUTEX_SIZE_16_BITS	1024
+#define FUTEX_SIZE_32_BITS	0
+#define FUTEX_SECOND_SIZE_8_BITS	2048
+#define FUTEX_SECOND_SIZE_16_BITS	4096
+#define FUTEX_SECOND_SIZE_32_BITS	0
+#define FUTEX_ALL_SIZE_BITS	(FUTEX_SIZE_8_BITS | FUTEX_SIZE_16_BITS | \
+				 FUTEX_SECOND_SIZE_8_BITS | \
+				 FUTEX_SECOND_SIZE_16_BITS)
+#define FUTEX_CMD_MASK		~(FUTEX_PRIVATE_FLAG | FUTEX_CLOCK_REALTIME | \
+				  FUTEX_ALL_SIZE_BITS)

 #define FUTEX_WAIT_PRIVATE	(FUTEX_WAIT | FUTEX_PRIVATE_FLAG)
 #define FUTEX_WAKE_PRIVATE	(FUTEX_WAKE | FUTEX_PRIVATE_FLAG)
diff --git a/kernel/futex.c b/kernel/futex.c
index 03c518e9747e..e2308cea7580 100644
=2D-- a/kernel/futex.c
+++ b/kernel/futex.c
@@ -183,6 +183,14 @@ static int  __read_mostly futex_cmpxchg_enabled;
 #endif
 #define FLAGS_CLOCKRT		0x02
 #define FLAGS_HAS_TIMEOUT	0x04
+/* size flags used for uaddr1 */
+#define FLAGS_FIRST_8_BITS	0x08
+#define FLAGS_FIRST_16_BITS	0x10
+/* size flags used for uaddr2 */
+#define FLAGS_SECOND_8_BITS	0x20
+#define FLAGS_SECOND_16_BITS	0x40
+#define FLAGS_FIRST_SIZE_BITS	(FLAGS_FIRST_8_BITS | FLAGS_FIRST_16_BITS)
+#define FLAGS_SECOND_SIZE_BITS	(FLAGS_SECOND_8_BITS | FLAGS_SECOND_16_BIT=
S)

 /*
  * Priority Inheritance state:
@@ -385,9 +393,15 @@ static inline int hb_waiters_pending(struct futex_has=
h_bucket *hb)
  */
 static struct futex_hash_bucket *hash_futex(union futex_key *key)
 {
+	/*
+	 * we exclude the size bits from the hash so that futexes of different
+	 * sizes hash to the same bucket. we use this to check for mismatching
+	 * size flags between WAIT and WAKE
+	 */
+	u32 hash_init =3D key->both.offset & ~FUT_OFF_SIZE_BITS;
 	u32 hash =3D jhash2((u32*)&key->both.word,
 			  (sizeof(key->both.word)+sizeof(key->both.ptr))/4,
-			  key->both.offset);
+			  hash_init);
 	return &futex_queues[hash & (futex_hashsize - 1)];
 }

@@ -401,10 +415,19 @@ static struct futex_hash_bucket *hash_futex(union fu=
tex_key *key)
  */
 static inline int match_futex(union futex_key *key1, union futex_key *key=
2)
 {
+	/*
+	 * compare every member except for the size bits in offset. the size
+	 * bits are only used for verification, and for that we need to first
+	 * detect that two futexes are the same except for the size bits (which
+	 * this function does) and then check if the size bits are different.
+	 * since all other code doesn't care about the size bits, we can skip
+	 * the comparison in all other cases as well.
+	 */
 	return (key1 && key2
 		&& key1->both.word =3D=3D key2->both.word
 		&& key1->both.ptr =3D=3D key2->both.ptr
-		&& key1->both.offset =3D=3D key2->both.offset);
+		&&   (key1->both.offset & ~FUT_OFF_SIZE_BITS)
+		  =3D=3D (key2->both.offset & ~FUT_OFF_SIZE_BITS));
 }

 /*
@@ -505,10 +528,20 @@ futex_setup_timer(ktime_t *time, struct hrtimer_slee=
per *timeout,
 	return timeout;
 }

+static inline int futex_size(int flags)
+{
+	if (flags & (FLAGS_FIRST_8_BITS | FLAGS_SECOND_8_BITS))
+		return sizeof(u8);
+	else if (flags & (FLAGS_FIRST_16_BITS | FLAGS_SECOND_16_BITS))
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
@@ -524,23 +557,31 @@ futex_setup_timer(ktime_t *time, struct hrtimer_slee=
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
+	size =3D futex_size(flags);
+
+	key->both.offset =3D address % PAGE_SIZE;
+	if (size =3D=3D sizeof(u8))
+		key->both.offset |=3D FUT_OFF_8_BITS;
+	else if (size =3D=3D sizeof(u16))
+		key->both.offset |=3D FUT_OFF_16_BITS;

 	/*
 	 * The futex address must be "naturally" aligned.
 	 */
-	key->both.offset =3D address % PAGE_SIZE;
-	if (unlikely((address % sizeof(u32)) !=3D 0))
+	if (unlikely((address & (size - 1)) !=3D 0))
 		return -EINVAL;
 	address -=3D key->both.offset;

-	if (unlikely(!access_ok(uaddr, sizeof(u32))))
+	if (unlikely(!access_ok(uaddr, size)))
 		return -EFAULT;

 	if (unlikely(should_fail_futex(fshared)))
@@ -792,6 +833,18 @@ static int cmpxchg_futex_value_locked(u32 *curval, u3=
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
@@ -803,6 +856,26 @@ static int get_futex_value_locked(u32 *dest, u32 __us=
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
@@ -1658,12 +1731,13 @@ futex_wake(u32 __user *uaddr, unsigned int flags, =
int nr_wake, u32 bitset)
 	struct futex_q *this, *next;
 	union futex_key key =3D FUTEX_KEY_INIT;
 	int ret;
+	bool found_size_mismatch =3D false;
 	DEFINE_WAKE_Q(wake_q);

 	if (!bitset)
 		return -EINVAL;

-	ret =3D get_futex_key(uaddr, flags & FLAGS_SHARED, &key, FUTEX_READ);
+	ret =3D get_futex_key(uaddr, flags, &key, FUTEX_READ);
 	if (unlikely(ret !=3D 0))
 		goto out;

@@ -1686,11 +1760,18 @@ futex_wake(u32 __user *uaddr, unsigned int flags, =
int nr_wake, u32 bitset)
 			if (!(this->bitset & bitset))
 				continue;

+			if (this->key.both.offset !=3D key.both.offset) {
+				found_size_mismatch =3D true;
+				continue;
+			}
+
 			mark_wake_futex(&wake_q, this);
 			if (++ret >=3D nr_wake)
 				break;
 		}
 	}
+	if (found_size_mismatch && ret =3D=3D 0)
+		ret =3D -EINVAL;

 	spin_unlock(&hb->lock);
 	wake_up_q(&wake_q);
@@ -1762,10 +1843,10 @@ futex_wake_op(u32 __user *uaddr1, unsigned int fla=
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

@@ -2001,6 +2082,7 @@ static int futex_requeue(u32 __user *uaddr1, unsigne=
d int flags,
 {
 	union futex_key key1 =3D FUTEX_KEY_INIT, key2 =3D FUTEX_KEY_INIT;
 	int drop_count =3D 0, task_count =3D 0, ret;
+	bool found_size_mismatch =3D false;
 	struct futex_pi_state *pi_state =3D NULL;
 	struct futex_hash_bucket *hb1, *hb2;
 	struct futex_q *this, *next;
@@ -2047,11 +2129,12 @@ static int futex_requeue(u32 __user *uaddr1, unsig=
ned int flags,
 	}

 retry:
-	ret =3D get_futex_key(uaddr1, flags & FLAGS_SHARED, &key1, FUTEX_READ);
+	ret =3D get_futex_key(uaddr1, flags & ~FLAGS_SECOND_SIZE_BITS,
+			    &key1, FUTEX_READ);
 	if (unlikely(ret !=3D 0))
 		goto out;
-	ret =3D get_futex_key(uaddr2, flags & FLAGS_SHARED, &key2,
-			    requeue_pi ? FUTEX_WRITE : FUTEX_READ);
+	ret =3D get_futex_key(uaddr2, flags & ~FLAGS_FIRST_SIZE_BITS,
+			    &key2, requeue_pi ? FUTEX_WRITE : FUTEX_READ);
 	if (unlikely(ret !=3D 0))
 		goto out_put_key1;

@@ -2073,14 +2156,15 @@ static int futex_requeue(u32 __user *uaddr1, unsig=
ned int flags,

 	if (likely(cmpval !=3D NULL)) {
 		u32 curval;
+		int size =3D futex_size(flags & ~FLAGS_SECOND_SIZE_BITS);

-		ret =3D get_futex_value_locked(&curval, uaddr1);
+		ret =3D get_sized_futex_value_locked(&curval, uaddr1, size);

 		if (unlikely(ret)) {
 			double_unlock_hb(hb1, hb2);
 			hb_waiters_dec(hb2);

-			ret =3D get_user(curval, uaddr1);
+			ret =3D get_sized_futex_value(&curval, uaddr1, size);
 			if (ret)
 				goto out_put_keys;

@@ -2186,6 +2270,11 @@ static int futex_requeue(u32 __user *uaddr1, unsign=
ed int flags,
 		if (!match_futex(&this->key, &key1))
 			continue;

+		if (this->key.both.offset !=3D key1.both.offset) {
+			found_size_mismatch =3D true;
+			continue;
+		}
+
 		/*
 		 * FUTEX_WAIT_REQEUE_PI and FUTEX_CMP_REQUEUE_PI should always
 		 * be paired with each other and no other futex ops.
@@ -2272,6 +2361,9 @@ static int futex_requeue(u32 __user *uaddr1, unsigne=
d int flags,
 	 */
 	put_pi_state(pi_state);

+	if (found_size_mismatch && ret =3D=3D 0 && task_count =3D=3D 0)
+		ret =3D -EINVAL;
+
 out_unlock:
 	double_unlock_hb(hb1, hb2);
 	wake_up_q(&wake_q);
@@ -2727,7 +2819,7 @@ static int futex_wait_setup(u32 __user *uaddr, u32 v=
al, unsigned int flags,
 			   struct futex_q *q, struct futex_hash_bucket **hb)
 {
 	u32 uval;
-	int ret;
+	int ret, size =3D futex_size(flags);

 	/*
 	 * Access the page AFTER the hash-bucket is locked.
@@ -2748,19 +2840,19 @@ static int futex_wait_setup(u32 __user *uaddr, u32=
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

@@ -2893,7 +2985,7 @@ static int futex_lock_pi(u32 __user *uaddr, unsigned=
 int flags,
 	to =3D futex_setup_timer(time, &timeout, FLAGS_CLOCKRT, 0);

 retry:
-	ret =3D get_futex_key(uaddr, flags & FLAGS_SHARED, &q.key, FUTEX_WRITE);
+	ret =3D get_futex_key(uaddr, flags, &q.key, FUTEX_WRITE);
 	if (unlikely(ret !=3D 0))
 		goto out;

@@ -3084,7 +3176,7 @@ static int futex_unlock_pi(u32 __user *uaddr, unsign=
ed int flags)
 	if ((uval & FUTEX_TID_MASK) !=3D vpid)
 		return -EPERM;

-	ret =3D get_futex_key(uaddr, flags & FLAGS_SHARED, &key, FUTEX_WRITE);
+	ret =3D get_futex_key(uaddr, flags, &key, FUTEX_WRITE);
 	if (ret)
 		return ret;

@@ -3321,7 +3413,7 @@ static int futex_wait_requeue_pi(u32 __user *uaddr, =
unsigned int flags,
 	 */
 	rt_mutex_init_waiter(&rt_waiter);

-	ret =3D get_futex_key(uaddr2, flags & FLAGS_SHARED, &key2, FUTEX_WRITE);
+	ret =3D get_futex_key(uaddr2, flags, &key2, FUTEX_WRITE);
 	if (unlikely(ret !=3D 0))
 		goto out;

@@ -3847,6 +3939,13 @@ void futex_exit_release(struct task_struct *tsk)
 	futex_cleanup_end(tsk, FUTEX_STATE_DEAD);
 }

+int futex_op_to_size_flags(int op)
+{
+	int size_flags =3D op & FUTEX_ALL_SIZE_BITS;
+
+	return (size_flags / FUTEX_SIZE_8_BITS) * FLAGS_FIRST_8_BITS;
+}
+
 long do_futex(u32 __user *uaddr, int op, u32 val, ktime_t *timeout,
 		u32 __user *uaddr2, u32 val2, u32 val3)
 {
@@ -3862,6 +3961,44 @@ long do_futex(u32 __user *uaddr, int op, u32 val, k=
time_t *timeout,
 		    cmd !=3D FUTEX_WAIT_REQUEUE_PI)
 			return -ENOSYS;
 	}
+	if (op & FUTEX_ALL_SIZE_BITS) {
+		flags |=3D futex_op_to_size_flags(op);
+
+		if ((flags & FLAGS_FIRST_SIZE_BITS) =3D=3D FLAGS_FIRST_SIZE_BITS ||
+		   (flags & FLAGS_SECOND_SIZE_BITS) =3D=3D FLAGS_SECOND_SIZE_BITS) {
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
+		case FUTEX_WAIT:
+		case FUTEX_WAIT_BITSET:
+		case FUTEX_WAKE:
+		case FUTEX_WAKE_BITSET:
+			if (flags & FLAGS_SECOND_SIZE_BITS) {
+				/*
+				 * these operations only take one argument so
+				 * only the size bits for the first argument
+				 * should be used
+				 */
+				return -EINVAL;
+			}
+			break;
+		case FUTEX_REQUEUE:
+		case FUTEX_CMP_REQUEUE:
+			break;
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

