Return-Path: <SRS0=kpxk=YC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C9636C47404
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Oct 2019 12:15:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7284D206BB
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Oct 2019 12:15:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=web.de header.i=@web.de header.b="rOWVlwbK"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730888AbfJIMPY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 9 Oct 2019 08:15:24 -0400
Received: from mout.web.de ([212.227.17.12]:40263 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727219AbfJIMPY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Oct 2019 08:15:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
        s=dbaedf251592; t=1570623277;
        bh=FNESg4w9bTAwpducV9M0k73rOqFosWq1d+pDbA705t4=;
        h=X-UI-Sender-Class:To:From:Subject:Cc:Date;
        b=rOWVlwbKxhayU45Z0iwtwNCqJbfjk18q6A4ktgq0GIbwpy9y3DjXsTGqZiyxAx0aP
         s3cvZy8EzdFyObquLRC8YsIuq47J0K4eTrKoXXIXYMLoPkKe0413fhqVIRxNKDwEpA
         YzXejSlBGT9+rPgiyld66SGW0rvt9BXWNCS3LUXE=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from [192.168.1.2] ([93.132.177.35]) by smtp.web.de (mrweb103
 [213.165.67.124]) with ESMTPSA (Nemesis) id 0MddJY-1iS0e10gNY-00PMuy; Wed, 09
 Oct 2019 14:14:37 +0200
To:     kernel-janitors@vger.kernel.org,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Joe Perches <joe@perches.com>,
        Kees Cook <keescook@chromium.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Steven Rostedt <rostedt@goodmis.org>
From:   Markus Elfring <Markus.Elfring@web.de>
Subject: [PATCH] string.h: Mark 34 functions with __must_check
Autocrypt: addr=Markus.Elfring@web.de; prefer-encrypt=mutual; keydata=
 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 FEE=
Cc:     LKML <linux-kernel@vger.kernel.org>
Message-ID: <75f70e5e-9ece-d6d1-a2c5-2f3ad79b9ccb@web.de>
Date:   Wed, 9 Oct 2019 14:14:28 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:TuQIGkl5ZqUQs2vtisgahCQcXbjxrLnbPv7CZfSuejg6gDtRiRl
 /ZxE80O8/nGOlG5gbj1RuQNvPjWLJf7gVF7RyPl/stomArxW9DbMchVLFA2PdvzVeVS9s3S
 x9kpbQMQPduVdJzVL6eQBcoEUj2ndem/TpJV35T1HOdPLoGXVQoVR+Znj3pO6YUnEG/FKc2
 4gW1Lgxb5pfHZ0tCHV6FQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:V+5CVju8N5w=:mPqYuKXRIvptIa5saSD67K
 XRhbeT6fIEMdDS98mwIdToT/YXoMZhiBRTGZLTZNA5Ioa9hAzvwg4Z8vDo0jSE9hAVd2H0yp4
 uLk2wO7Pd9UbKypTs9XmCXkAUGrZ420BCS5s986xtlRaPIGOisG/Lc3RaNsFUOTDEoK3EjEi1
 h47IHVXY/EHH58CKzNuFefQJl4QZEFjuHMcdm3hHfKXRo88bqmNgINJ/LqebR2gHQp5mHDf3d
 A4nzjfBBy5H1GbtAX0ug1nwmFubFpKjljk39FNlElJ/Y4lvcG8ivIHczRVyIGGiutD1z4gqnZ
 OgPCtGUw+fTeaE9cyFjpOgokD515/MXSvguxRfB34f+ayeGkx88zMyYraHEMSuFgIWpH8nXKH
 glFUpOLECcsbKx8VwX31huhXYGwE4ZLGOfdGJ/YEF1lV6DdzeTu+8l3XGS87Fg4vAKyTIpE5h
 4McdAWsHT5jjJVqj+5oAQgSujmpyV7rZ6N9uguCfPrpza06QB+X2DpBn5wu43wctvpW2hmuvs
 qWeKBrNs2Hr9N8uBFSw/6LM9Y6T1TEnVTaRW4/G9xhND0Ce5p0+cB1TL5Je0TzxECQ2dHGlbV
 RGhP2qh06t7dQRhzeXrwgwhfrhIKi8qDtsCkypK38Kc+e2f4TNJtXlRT2hcmEXVYRfuoky744
 E2h5j/lvduFmtk12zlIwrFFvsWBOhyXuKWk/EOtk+b2+Mpyi5A8DCK1So51dq+WkwYTGRFYHi
 3fWwq4OGFgGBTPTlq0f7hzBbpRu/XOIHha2Ty/r2oghANGQIli1UIPrIyBR5WDegRxZnp16Wx
 TcRRdDQc2HHjtxiekCS8O3DVBvpsm/27PeHBGfpvwo256JrhheZTCAGKeAo0h7hDEvMRow5dl
 gERVxzJvoI/97PyKOsYwn5Qs8+7VuYo8TowByDkIya4AFW0xwqSNWCTjhS3zXhouF2a6Arb3u
 JPaIIvdHBUe5ckpPMHlFQO7+C/EtfLIqEflg2doC2q8rF09VpheDSuxdtfRoGN0qiBFUbfvLU
 eZvGsFK5cso6B17gVVPrsL6paHmf3Ka/nF2kJkjxTAm4R16okm6I3EWe3US1id+1BEwyHSdsF
 +oYlfmtQsx2bg50TNDx8H/GMBSvuFtLDU1gtqbkVEHNz0g58+c8B5j8nmtj8P9JJpV3cdViSA
 +56Yi6ChAlF3UuraDu6NjW5BeLdG61HmbJa64zIqeYUX+1LdvZa/67NL+QaWClOqwdDZpKrBC
 vzKyYLol8y7Vr4hUrY5CnrvP7fdQW4PlxMaUwodNMZupt2kTriphvnEqWh/w=
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Markus Elfring <elfring@users.sourceforge.net>
Date: Wed, 9 Oct 2019 13:53:59 +0200

Several functions return values with which useful data processing
should be performed. These values must not be ignored then.
Thus use the annotation =E2=80=9C__must_check=E2=80=9D in the shown functi=
on declarations.

Add also corresponding parameter names for adjusted functions.

Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
=2D--
 include/linux/string.h | 75 ++++++++++++++++++++++--------------------
 1 file changed, 40 insertions(+), 35 deletions(-)

diff --git a/include/linux/string.h b/include/linux/string.h
index 3cf684db4bc6..5cece3a91434 100644
=2D-- a/include/linux/string.h
+++ b/include/linux/string.h
@@ -9,10 +9,10 @@
 #include <stdarg.h>
 #include <uapi/linux/string.h>

-extern char *strndup_user(const char __user *, long);
-extern void *memdup_user(const void __user *, size_t);
-extern void *vmemdup_user(const void __user *, size_t);
-extern void *memdup_user_nul(const void __user *, size_t);
+extern char * __must_check strndup_user(const char __user *src, long n);
+extern void * __must_check memdup_user(const void __user *src, size_t len=
);
+extern void * __must_check vmemdup_user(const void __user *src, size_t le=
n);
+extern void * __must_check memdup_user_nul(const void __user *src, size_t=
 len);

 /*
  * Include machine specific inline routines
@@ -90,28 +90,29 @@ extern char * strncat(char *, const char *, __kernel_s=
ize_t);
 extern size_t strlcat(char *, const char *, __kernel_size_t);
 #endif
 #ifndef __HAVE_ARCH_STRCMP
-extern int strcmp(const char *,const char *);
+extern int __must_check strcmp(const char *s1, const char *s2);
 #endif
 #ifndef __HAVE_ARCH_STRNCMP
-extern int strncmp(const char *,const char *,__kernel_size_t);
+extern int __must_check strncmp(const char *s1, const char *s2,
+				__kernel_size_t n);
 #endif
 #ifndef __HAVE_ARCH_STRCASECMP
-extern int strcasecmp(const char *s1, const char *s2);
+extern int __must_check strcasecmp(const char *s1, const char *s2);
 #endif
 #ifndef __HAVE_ARCH_STRNCASECMP
-extern int strncasecmp(const char *s1, const char *s2, size_t n);
+extern int __must_check strncasecmp(const char *s1, const char *s2, size_=
t n);
 #endif
 #ifndef __HAVE_ARCH_STRCHR
-extern char * strchr(const char *,int);
+extern char * __must_check strchr(const char *s, int c);
 #endif
 #ifndef __HAVE_ARCH_STRCHRNUL
-extern char * strchrnul(const char *,int);
+extern char * __must_check strchrnul(const char *s, int c);
 #endif
 #ifndef __HAVE_ARCH_STRNCHR
-extern char * strnchr(const char *, size_t, int);
+extern char * __must_check strnchr(const char *s, size_t n, int c);
 #endif
 #ifndef __HAVE_ARCH_STRRCHR
-extern char * strrchr(const char *,int);
+extern char * __must_check strrchr(const char *s, int c);
 #endif
 extern char * __must_check skip_spaces(const char *);

@@ -123,10 +124,10 @@ static inline __must_check char *strstrip(char *str)
 }

 #ifndef __HAVE_ARCH_STRSTR
-extern char * strstr(const char *, const char *);
+extern char * __must_check strstr(const char *s1, const char *s2);
 #endif
 #ifndef __HAVE_ARCH_STRNSTR
-extern char * strnstr(const char *, const char *, size_t);
+extern char * __must_check strnstr(const char *s1, const char *s2, size_t=
 n);
 #endif
 #ifndef __HAVE_ARCH_STRLEN
 extern __kernel_size_t strlen(const char *);
@@ -135,16 +136,16 @@ extern __kernel_size_t strlen(const char *);
 extern __kernel_size_t strnlen(const char *,__kernel_size_t);
 #endif
 #ifndef __HAVE_ARCH_STRPBRK
-extern char * strpbrk(const char *,const char *);
+extern char * __must_check strpbrk(const char *s, const char *c);
 #endif
 #ifndef __HAVE_ARCH_STRSEP
 extern char * strsep(char **,const char *);
 #endif
 #ifndef __HAVE_ARCH_STRSPN
-extern __kernel_size_t strspn(const char *,const char *);
+extern __kernel_size_t __must_check strspn(const char *s, const char *a);
 #endif
 #ifndef __HAVE_ARCH_STRCSPN
-extern __kernel_size_t strcspn(const char *,const char *);
+extern __kernel_size_t __must_check strcspn(const char *s, const char *r)=
;
 #endif

 #ifndef __HAVE_ARCH_MEMSET
@@ -197,13 +198,13 @@ extern void * memmove(void *,const void *,__kernel_s=
ize_t);
 extern void * memscan(void *,int,__kernel_size_t);
 #endif
 #ifndef __HAVE_ARCH_MEMCMP
-extern int memcmp(const void *,const void *,__kernel_size_t);
+extern int __must_check memcmp(const void *a, const void *b, __kernel_siz=
e_t n);
 #endif
 #ifndef __HAVE_ARCH_BCMP
-extern int bcmp(const void *,const void *,__kernel_size_t);
+extern int __must_check bcmp(const void *a, const void *b, __kernel_size_=
t n);
 #endif
 #ifndef __HAVE_ARCH_MEMCHR
-extern void * memchr(const void *,int,__kernel_size_t);
+extern void * __must_check memchr(const void *s, int c, __kernel_size_t n=
);
 #endif
 #ifndef __HAVE_ARCH_MEMCPY_MCSAFE
 static inline __must_check unsigned long memcpy_mcsafe(void *dst,
@@ -219,29 +220,31 @@ static inline void memcpy_flushcache(void *dst, cons=
t void *src, size_t cnt)
 	memcpy(dst, src, cnt);
 }
 #endif
-void *memchr_inv(const void *s, int c, size_t n);
+void * __must_check memchr_inv(const void *s, int c, size_t n);
 char *strreplace(char *s, char old, char new);

 extern void kfree_const(const void *x);

-extern char *kstrdup(const char *s, gfp_t gfp) __malloc;
-extern const char *kstrdup_const(const char *s, gfp_t gfp);
-extern char *kstrndup(const char *s, size_t len, gfp_t gfp);
-extern void *kmemdup(const void *src, size_t len, gfp_t gfp);
-extern char *kmemdup_nul(const char *s, size_t len, gfp_t gfp);
+extern char * __must_check kstrdup(const char *s, gfp_t gfp) __malloc;
+extern const char * __must_check kstrdup_const(const char *s, gfp_t gfp);
+extern char * __must_check kstrndup(const char *s, size_t len, gfp_t gfp)=
;
+extern void * __must_check kmemdup(const void *src, size_t len, gfp_t gfp=
);
+extern char * __must_check kmemdup_nul(const char *s, size_t len, gfp_t g=
fp);

-extern char **argv_split(gfp_t gfp, const char *str, int *argcp);
+extern char ** __must_check argv_split(gfp_t gfp, const char *str, int *a=
rgcp);
 extern void argv_free(char **argv);

-extern bool sysfs_streq(const char *s1, const char *s2);
-extern int kstrtobool(const char *s, bool *res);
-static inline int strtobool(const char *s, bool *res)
+extern bool __must_check sysfs_streq(const char *s1, const char *s2);
+extern int __must_check kstrtobool(const char *s, bool *res);
+static inline int __must_check strtobool(const char *s, bool *res)
 {
 	return kstrtobool(s, res);
 }

-int match_string(const char * const *array, size_t n, const char *string)=
;
-int __sysfs_match_string(const char * const *array, size_t n, const char =
*s);
+int __must_check match_string(const char * const *array,
+			      size_t n, const char *string);
+int __must_check __sysfs_match_string(const char * const *array,
+				      size_t n, const char *s);

 /**
  * sysfs_match_string - matches given string in an array
@@ -258,8 +261,10 @@ int bstr_printf(char *buf, size_t size, const char *f=
mt, const u32 *bin_buf);
 int bprintf(u32 *bin_buf, size_t size, const char *fmt, ...) __printf(3, =
4);
 #endif

-extern ssize_t memory_read_from_buffer(void *to, size_t count, loff_t *pp=
os,
-				       const void *from, size_t available);
+extern ssize_t __must_check memory_read_from_buffer(void *to, size_t coun=
t,
+						    loff_t *ppos,
+						    const void *from,
+						    size_t available);

 /**
  * strstarts - does @str start with @prefix?
@@ -271,7 +276,7 @@ static inline bool strstarts(const char *str, const ch=
ar *prefix)
 	return strncmp(str, prefix, strlen(prefix)) =3D=3D 0;
 }

-size_t memweight(const void *ptr, size_t bytes);
+size_t __must_check memweight(const void *ptr, size_t bytes);
 void memzero_explicit(void *s, size_t count);

 /**
=2D-
2.23.0

