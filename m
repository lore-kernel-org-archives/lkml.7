Return-Path: <SRS0=EKka=XV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 74EAFC432C2
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Sep 2019 09:05:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5240C222C0
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Sep 2019 09:05:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729934AbfIZJFR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 26 Sep 2019 05:05:17 -0400
Received: from 3.mo179.mail-out.ovh.net ([178.33.251.175]:34904 "EHLO
        3.mo179.mail-out.ovh.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726352AbfIZJFR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Sep 2019 05:05:17 -0400
X-Greylist: delayed 1206 seconds by postgrey-1.27 at vger.kernel.org; Thu, 26 Sep 2019 05:05:16 EDT
Received: from player159.ha.ovh.net (unknown [10.108.54.13])
        by mo179.mail-out.ovh.net (Postfix) with ESMTP id BB95E142883
        for <linux-kernel@vger.kernel.org>; Thu, 26 Sep 2019 10:25:51 +0200 (CEST)
Received: from RCM-web5.webmail.mail.ovh.net (unknown [65.39.69.237])
        (Authenticated sender: steve@sk2.org)
        by player159.ha.ovh.net (Postfix) with ESMTPSA id 48D55A27EC6A;
        Thu, 26 Sep 2019 08:25:37 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
 format=flowed
Content-Transfer-Encoding: 8bit
Date:   Thu, 26 Sep 2019 10:25:37 +0200
From:   Stephen Kitt <steve@sk2.org>
To:     Rasmus Villemoes <linux@rasmusvillemoes.dk>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Joe Perches <joe@perches.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>,
        Kees Cook <keescook@chromium.org>,
        Nitin Gote <nitin.r.gote@intel.com>, jannh@google.com,
        kernel-hardening@lists.openwall.com, Takashi Iwai <tiwai@suse.com>,
        Clemens Ladisch <clemens@ladisch.de>,
        alsa-devel@alsa-project.org
Subject: Re: [PATCH V2 1/2] string: Add stracpy and stracpy_pad mechanisms
In-Reply-To: <8039728c-b41d-123c-e1ed-b35daac68fd3@rasmusvillemoes.dk>
References: <cover.1563889130.git.joe@perches.com>
 <ed4611a4a96057bf8076856560bfbf9b5e95d390.1563889130.git.joe@perches.com>
 <20190925145011.c80c89b56fcee3060cf87773@linux-foundation.org>
 <c0c2b8f6ac9f257b102b5a1a4b4dc949@sk2.org>
 <8039728c-b41d-123c-e1ed-b35daac68fd3@rasmusvillemoes.dk>
Message-ID: <24bb53c57767c1c2a8f266c305a670f7@sk2.org>
X-Sender: steve@sk2.org
User-Agent: Roundcube Webmail/1.3.10
X-Originating-IP: 65.39.69.237
X-Webmail-UserID: steve@sk2.org
X-Ovh-Tracer-Id: 8507018221395332536
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgedufedrfeeggddtgecutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfqggfjpdevjffgvefmvefgnecuuegrihhlohhuthemucehtddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Le 26/09/2019 09:29, Rasmus Villemoes a écrit :
> On 26/09/2019 02.01, Stephen Kitt wrote:
>> Le 25/09/2019 23:50, Andrew Morton a écrit :
>>> On Tue, 23 Jul 2019 06:51:36 -0700 Joe Perches <joe@perches.com> 
>>> wrote:
>>> 
>>>> Several uses of strlcpy and strscpy have had defects because the
>>>> last argument of each function is misused or typoed.
>>>> 
>>>> Add macro mechanisms to avoid this defect.
>>>> 
>>>> stracpy (copy a string to a string array) must have a string
>>>> array as the first argument (dest) and uses sizeof(dest) as the
>>>> count of bytes to copy.
>>>> 
>>>> These mechanisms verify that the dest argument is an array of
>>>> char or other compatible types like u8 or s8 or equivalent.
>>>> 
>>>> A BUILD_BUG is emitted when the type of dest is not compatible.
>>>> 
>>> 
>>> I'm still reluctant to merge this because we don't have code in -next
>>> which *uses* it.  You did have a patch for that against v1, I 
>>> believe?
>>> Please dust it off and send it along?
>> 
>> Joe had a Coccinelle script to mass-convert strlcpy and strscpy.
>> Here's a different patch which converts some of ALSA's strcpy calls to
>> stracpy:
> 
> Please don't. At least not for the cases where the source is a string
> literal - that just gives worse code generation (because gcc doesn't
> know anything about strscpy or strlcpy), and while a run-time (silent)
> truncation is better than a run-time buffer overflow, wouldn't it be
> even better with a build time error?

Yes, that was the plan once Joe's patch gets merged (if it does), and my
patch was only an example of using stracpy, as a step on the road. I was
intending to follow up with a patch converting stracpy to something like
https://www.openwall.com/lists/kernel-hardening/2019/07/06/14

__FORTIFY_INLINE ssize_t strscpy(char *dest, const char *src, size_t 
count)
{
	size_t dest_size = __builtin_object_size(dest, 0);
	size_t src_size = __builtin_object_size(src, 0);
	if (__builtin_constant_p(count) &&
	    __builtin_constant_p(src_size) &&
	    __builtin_constant_p(dest_size) &&
	    src_size <= count &&
	    src_size <= dest_size &&
	    src[src_size - 1] == '\0') {
		strcpy(dest, src);
		return src_size - 1;
	} else {
		return __strscpy(dest, src, count);
	}
}

which, as a macro, would become

#define stracpy(dest, src)						\
({									\
	size_t count = ARRAY_SIZE(dest);				\
	size_t dest_size = __builtin_object_size(dest, 0);		\
	size_t src_size = __builtin_object_size(src, 0);		\
	BUILD_BUG_ON(!(__same_type(dest, char[]) ||			\
		       __same_type(dest, unsigned char[]) ||		\
		       __same_type(dest, signed char[])));		\
									\
	(__builtin_constant_p(count) &&					\
	 __builtin_constant_p(src_size) &&				\
	 __builtin_constant_p(dest_size) &&				\
	 src_size <= count &&						\
	 src_size <= dest_size &&					\
	 src[src_size - 1] == '\0') ?					\
		(((size_t) strcpy(dest, src)) & 0) + src_size - 1	\
	:								\
		strscpy(dest, src, count);				\
})

and both of these get optimised to movs when copying a constant string
which fits in the target.

I was going at this from the angle of improving the existing APIs and
their resulting code. But I like your approach of failing at compile
time.

Perhaps we could do both ;-).

Regards,

Stephen
