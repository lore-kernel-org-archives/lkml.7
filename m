Return-Path: <SRS0=ztpy=2L=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 47302C2D0C0
	for <linux-kernel@archiver.kernel.org>; Sat, 21 Dec 2019 16:01:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0BADC2072B
	for <linux-kernel@archiver.kernel.org>; Sat, 21 Dec 2019 16:01:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=web.de header.i=@web.de header.b="BNscuT02"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726905AbfLUP6J (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 21 Dec 2019 10:58:09 -0500
Received: from mout.web.de ([212.227.17.11]:59307 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726107AbfLUP6I (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 21 Dec 2019 10:58:08 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
        s=dbaedf251592; t=1576943872;
        bh=TYg3RM0c7bbbE3+sH7pMsHPWM7Izd5WMEYAP0C7p9mQ=;
        h=X-UI-Sender-Class:From:To:Cc:Subject:Date:In-Reply-To:References;
        b=BNscuT02VCCh/DeKAUCnnazsaS/L49krvNj0vZm80bk5Yrnn3ejzs3Fnkv0YBLF0s
         9dS96iD3jUYYqYmZ/UUpfQOMRZzC2EjO7/G/ewKDv7OCtwOOJ0tRLolMpG4GRm+lNl
         Eo6Mj08wq7cCyrAIaUso+3HpcTCp8BTH+U3g4rpI=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from localhost.localdomain ([67.254.165.9]) by smtp.web.de (mrweb101
 [213.165.67.124]) with ESMTPSA (Nemesis) id 0LlFLm-1i7zTN41RO-00b3Gg; Sat, 21
 Dec 2019 16:57:52 +0100
From:   Malte Skarupke <malteskarupke@web.de>
To:     tglx@linutronix.de, mingo@redhat.com
Cc:     peterz@infradead.org, dvhart@infradead.org,
        linux-kernel@vger.kernel.org, malteskarupke@fastmail.fm,
        malteskarupke@web.de
Subject: [PATCH] futex: Support smaller futexes of one byte or two byte size.
Date:   Sat, 21 Dec 2019 10:56:58 -0500
Message-Id: <20191221155659.3159-1-malteskarupke@web.de>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20191220190901.23465-3-malteskarupke@web.de>
References: <20191220190901.23465-3-malteskarupke@web.de>
X-Provags-ID: V03:K1:T43Vvi41N/riWLTkB4gORTlgT0gQrHYP60PwpNhx6uqdwH4P2/A
 Qoo687p1BCugh9KE5z53ysQ1OH3YUaen6OgCRT5XgXNuniaKtX1NksKLCikqJr1L1F4oCmY
 2sencLpshD/kI5MasTagqAFHdeAqtXwJDwdKOTkVAAtDlDVRc5M11/U/Y+EwLD+EAgEVM9h
 fQLlu71qVmJzswuxSUmHw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:KXUhTwwkGEA=:a7eAgdPgDivJ7qablvxH6I
 iQJZdejgtPfuIcmsANiLg9Gv5lmG02ad9O7T+82JM6EqdEzgeTWdHo0B4q2hcoXhacuzrjJUs
 XZ2azNXVhLM32eieuS7GnZ6VcK0GeBedjhYd3fMiFX9zdlmpkaxi2enwOtHpWz1Bwx3Yo0Aq0
 7bfetEtV94//wH6JOWOl7vY0OBnsUVk1jh3hNqjt703hhZujv7bkJn7ViCCRGwTO7+nW8gUnK
 Oy0GEmwE3v3JiDe6VPtLT+eWjxEqNhSnkxsIhIhFcjnJG7S+yKxWc8m4eo9kNVVrM3Flr7WhZ
 lBPgFlGRdHe4Grhs351gzdyq1PbtAIugWnuyDB7M5feUpzDGMkdjtE9DUwv3FCnDIbtVzbNz4
 yjMcJHlMH25VHTb6lT0IJ8VE47bl07GQLFgUif2fwPmNIZvExVNkQdXDiZcfzHy4ID0TWbDbg
 99Lr0yDTkEMHECqh4Repce7xjZqNVlVoVNQGUKnJo0R34rc7TjSgknMo8fsyEQUzaQHX9oQ/6
 GI7ivtdo6GhBk65uWgDo1u8bIGE3xq8PflgTqtLIMWuVORooCEd9fl8QkXHEEZWR6IfmW1f9k
 EfJGYfBegzmSOEi49nqdkXNpRZPnNk3Ilz+9yPM+YVHnry4CW/5vuglu/qT3VtpaKRsrqrCSS
 gMxD0I8jJQ5bSl+xNAtB11z89JlLI3k2ev3SvKdn5P2AxUpNP5bEWXw9LpJDKsj5rG7bAXlEG
 cXfWdhstbrDBqTK8ngNjR8wNCfDvyrG5Kq6LxoN7Z37QXxu+FnZZ4A9tr5yhSfWAc0llCvJzr
 tKyA/Wwe61FM7H5kVbcPqB9GEFrgCP3RC/gzulWVv0yPMjmnqKbjEERPHeUGeXMoapBexkLCS
 dMG+xK260wsiGTt1P1ri9mYFWDXH1VFR/1uGqxb7ZmD9yTmYbKwGdrnXSMh7e8i8RTiDbGLiK
 jBXdnwYJeD6gOMPdxjE5Ljq8cOPWJ5hh5vCoZDyEmfclEoX5jFFjycopX4iJjuWrdt7/XUt8C
 sRFxvVTtgAMWPLWJxKEdL2D/OhRNjiKQ4gKLkLykzFIgk6noitkmPiESR8sg1NGaslm/O0gbf
 fUkRFN/Z35VylsXxs1QcCu4VHY5ko0QpwaldjhtEksAPuDLsdsZCbwJBPaivnfrsuhLAHntc6
 oeGw6ATyUWV0NkvP76v53T6icC8kjqHNElW8sdch9q6nNvOJlFKBcdxUuGU3MgA+qb72ADlm6
 jfk3ROLPV2BYrePcCnktvyIuNo14ssul9n/1MqVsQh8O40JWHoV2XSIDMOFU=
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

And hello one more time,

turns out a last minute change broke my patch for "option 2". I had moved =
some
lines around and didn't test the results properly... As a result I literal=
ly
woke up from a nightmare at 4am tonight, immediately knowing that there wa=
s a
bug in the code I had sent. Below you'll find a patch with the fix.

I re-emailed the whole patch to make it easier to use if you want to go wi=
th
option 2. But if you're curious what the difference is between this new
version and the last version, the diff between the two is just this:

diff --git a/kernel/futex.c b/kernel/futex.c
index e2308cea7580..ac460fd612ae 100644
=2D-- a/kernel/futex.c
+++ b/kernel/futex.c
@@ -569,10 +569,6 @@ get_futex_key(u32 __user *uaddr, int flags, union fut=
ex_key *key, enum futex_acc
   size =3D futex_size(flags);

   key->both.offset =3D address % PAGE_SIZE;
-  if (size =3D=3D sizeof(u8))
-     key->both.offset |=3D FUT_OFF_8_BITS;
-  else if (size =3D=3D sizeof(u16))
-     key->both.offset |=3D FUT_OFF_16_BITS;

   /*
    * The futex address must be "naturally" aligned.
@@ -581,6 +577,11 @@ get_futex_key(u32 __user *uaddr, int flags, union fut=
ex_key *key, enum futex_acc
      return -EINVAL;
   address -=3D key->both.offset;

+  if (size =3D=3D sizeof(u8))
+     key->both.offset |=3D FUT_OFF_8_BITS;
+  else if (size =3D=3D sizeof(u16))
+     key->both.offset |=3D FUT_OFF_16_BITS;
+
   if (unlikely(!access_ok(uaddr, size)))
      return -EFAULT;



