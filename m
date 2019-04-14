Return-Path: <SRS0=avfD=SQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 17643C10F13
	for <linux-kernel@archiver.kernel.org>; Sun, 14 Apr 2019 15:25:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B34E22070D
	for <linux-kernel@archiver.kernel.org>; Sun, 14 Apr 2019 15:25:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="E0zfTzYM"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726994AbfDNPZK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 14 Apr 2019 11:25:10 -0400
Received: from merlin.infradead.org ([205.233.59.134]:55740 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725829AbfDNPZJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 14 Apr 2019 11:25:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=Content-Transfer-Encoding:Content-Type:
        In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:Subject:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=/3Iuf8r8FQ99UqpmbKYXp8HBzhw4o3G4xXFSt2AX/0A=; b=E0zfTzYMT1RtBY1J1hrGxElCXr
        mGZ7XIotxFoBWzIHKau/2c5sjUr6eonY8Yumw2zkny8O6BnnL826afBSLR8CNSVYZCWJuKSxNPOuo
        +BExj8eWMUwQ98Pyv/aLtvip7OSpkWNln5R1j6ttosIJIaasxW2Ax3OBCqrd7SMbQg62RrVzc07h4
        S9UMM+APdRoxub70sgrYI4r1UeN3nYMGJXkl+YEwZAKV0gjhGe3grd15h0gC/sqJYe+Q3C+VUEr+w
        vZpS5+tORgR52Ol3+NXl01CJffoGVbHxRBGraY5iWMqKqe00/n/VTF/qUjv6XpoocF90E2HFuBE8L
        oixNicWw==;
Received: from static-50-53-52-16.bvtn.or.frontiernet.net ([50.53.52.16] helo=midway.dunlab)
        by merlin.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1hFh0F-0000F5-W0; Sun, 14 Apr 2019 15:25:08 +0000
Subject: Re: [PATCH] proc: fix map_files test on F29
To:     Alexey Dobriyan <adobriyan@gmail.com>, akpm@linux-foundation.org
Cc:     linux-kernel@vger.kernel.org
References: <20190414123612.GB12971@avx2>
From:   Randy Dunlap <rdunlap@infradead.org>
Message-ID: <bb2991f8-323a-c835-0b04-ff8d565df0fa@infradead.org>
Date:   Sun, 14 Apr 2019 08:24:53 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190414123612.GB12971@avx2>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 4/14/19 5:36 AM, Alexey Dobriyan wrote:
> F29 bans mapping first 64KB even for root making test fail.

so there is an F29-only patch that prevents that?
something that is not in mainline?

thanks.

> Iterate from address 0 until mmap() works.
> 
> Gentoo (root):
> 
> 	openat(AT_FDCWD, "/dev/zero", O_RDONLY) = 3
> 	mmap(NULL, 4096, PROT_NONE, MAP_PRIVATE|MAP_FIXED, 3, 0) = 0
> 
> Gentoo (non-root):
> 
> 	openat(AT_FDCWD, "/dev/zero", O_RDONLY) = 3
> 	mmap(NULL, 4096, PROT_NONE, MAP_PRIVATE|MAP_FIXED, 3, 0) = -1 EPERM (Operation not permitted)
> 	mmap(0x1000, 4096, PROT_NONE, MAP_PRIVATE|MAP_FIXED, 3, 0) = 0x1000
> 
> F29 (root):
> 
> 	openat(AT_FDCWD, "/dev/zero", O_RDONLY) = 3
> 	mmap(NULL, 4096, PROT_NONE, MAP_PRIVATE|MAP_FIXED, 3, 0) = -1 EACCES (Permission denied)
> 	mmap(0x1000, 4096, PROT_NONE, MAP_PRIVATE|MAP_FIXED, 3, 0) = -1 EACCES (Permission denied)
> 	mmap(0x2000, 4096, PROT_NONE, MAP_PRIVATE|MAP_FIXED, 3, 0) = -1 EACCES (Permission denied)
> 	mmap(0x3000, 4096, PROT_NONE, MAP_PRIVATE|MAP_FIXED, 3, 0) = -1 EACCES (Permission denied)
> 	mmap(0x4000, 4096, PROT_NONE, MAP_PRIVATE|MAP_FIXED, 3, 0) = -1 EACCES (Permission denied)
> 	mmap(0x5000, 4096, PROT_NONE, MAP_PRIVATE|MAP_FIXED, 3, 0) = -1 EACCES (Permission denied)
> 	mmap(0x6000, 4096, PROT_NONE, MAP_PRIVATE|MAP_FIXED, 3, 0) = -1 EACCES (Permission denied)
> 	mmap(0x7000, 4096, PROT_NONE, MAP_PRIVATE|MAP_FIXED, 3, 0) = -1 EACCES (Permission denied)
> 	mmap(0x8000, 4096, PROT_NONE, MAP_PRIVATE|MAP_FIXED, 3, 0) = -1 EACCES (Permission denied)
> 	mmap(0x9000, 4096, PROT_NONE, MAP_PRIVATE|MAP_FIXED, 3, 0) = -1 EACCES (Permission denied)
> 	mmap(0xa000, 4096, PROT_NONE, MAP_PRIVATE|MAP_FIXED, 3, 0) = -1 EACCES (Permission denied)
> 	mmap(0xb000, 4096, PROT_NONE, MAP_PRIVATE|MAP_FIXED, 3, 0) = -1 EACCES (Permission denied)
> 	mmap(0xc000, 4096, PROT_NONE, MAP_PRIVATE|MAP_FIXED, 3, 0) = -1 EACCES (Permission denied)
> 	mmap(0xd000, 4096, PROT_NONE, MAP_PRIVATE|MAP_FIXED, 3, 0) = -1 EACCES (Permission denied)
> 	mmap(0xe000, 4096, PROT_NONE, MAP_PRIVATE|MAP_FIXED, 3, 0) = -1 EACCES (Permission denied)
> 	mmap(0xf000, 4096, PROT_NONE, MAP_PRIVATE|MAP_FIXED, 3, 0) = -1 EACCES (Permission denied)
> 	mmap(0x10000, 4096, PROT_NONE, MAP_PRIVATE|MAP_FIXED, 3, 0) = 0x10000
> 
> Now all proc tests succeed on F29 if run as root, at last!
> 
> Signed-off-by: Alexey Dobriyan <adobriyan@gmail.com>
> ---
> 
>  tools/testing/selftests/proc/proc-self-map-files-002.c |   20 ++++++++---------
>  1 file changed, 10 insertions(+), 10 deletions(-)
> 
> --- a/tools/testing/selftests/proc/proc-self-map-files-002.c
> +++ b/tools/testing/selftests/proc/proc-self-map-files-002.c
> @@ -46,12 +46,9 @@ static void fail(const char *fmt, unsigned long a, unsigned long b)
>  
>  int main(void)
>  {
> -	const unsigned int PAGE_SIZE = sysconf(_SC_PAGESIZE);
> -#ifdef __arm__
> -	unsigned long va = 2 * PAGE_SIZE;
> -#else
> -	unsigned long va = 0;
> -#endif
> +	const int PAGE_SIZE = sysconf(_SC_PAGESIZE);
> +	const unsigned long va_max = 1UL << 32;
> +	unsigned long va;
>  	void *p;
>  	int fd;
>  	unsigned long a, b;
> @@ -60,10 +57,13 @@ int main(void)
>  	if (fd == -1)
>  		return 1;
>  
> -	p = mmap((void *)va, PAGE_SIZE, PROT_NONE, MAP_PRIVATE|MAP_FILE|MAP_FIXED, fd, 0);
> -	if (p == MAP_FAILED) {
> -		if (errno == EPERM)
> -			return 4;
> +	for (va = 0; va < va_max; va += PAGE_SIZE) {
> +		p = mmap((void *)va, PAGE_SIZE, PROT_NONE, MAP_PRIVATE|MAP_FILE|MAP_FIXED, fd, 0);
> +		if (p == (void *)va)
> +			break;
> +	}
> +	if (va == va_max) {
> +		fprintf(stderr, "error: mmap doesn't like you\n");
>  		return 1;
>  	}
>  
> 


-- 
~Randy
