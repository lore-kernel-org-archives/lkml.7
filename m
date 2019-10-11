Return-Path: <SRS0=Osat=YE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 663C4C47404
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Oct 2019 08:05:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3B1212089F
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Oct 2019 08:05:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=yandex-team.ru header.i=@yandex-team.ru header.b="NZWgPC9Q"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727097AbfJKIEX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 11 Oct 2019 04:04:23 -0400
Received: from forwardcorp1p.mail.yandex.net ([77.88.29.217]:45126 "EHLO
        forwardcorp1p.mail.yandex.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726827AbfJKIEX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Oct 2019 04:04:23 -0400
Received: from mxbackcorp2j.mail.yandex.net (mxbackcorp2j.mail.yandex.net [IPv6:2a02:6b8:0:1619::119])
        by forwardcorp1p.mail.yandex.net (Yandex) with ESMTP id 622912E14AF;
        Fri, 11 Oct 2019 11:04:19 +0300 (MSK)
Received: from myt5-6212ef07a9ec.qloud-c.yandex.net (myt5-6212ef07a9ec.qloud-c.yandex.net [2a02:6b8:c12:3b2d:0:640:6212:ef07])
        by mxbackcorp2j.mail.yandex.net (nwsmtp/Yandex) with ESMTP id hR2JRYzmrd-4HN8dkmf;
        Fri, 11 Oct 2019 11:04:19 +0300
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru; s=default;
        t=1570781059; bh=h9sFIApiF/a6qm0OMOKwEuhHvuC11mmk0HkBxETCqFw=;
        h=In-Reply-To:Message-ID:From:Date:References:To:Subject:Cc;
        b=NZWgPC9QAkDXQOgmSNwN5wMUZe+xQZy2D/OyWOCS6xepPAXToOluLXT5Oqpt1Tk3+
         apoT4UNQMRxsYc634nI2LZiOeKyCh8WjnsKU0NEbg28P6oGibdJgHHHC1NQuYqbX4u
         LqNaGXwX6CtRzdxtfXnzPjnTLI/q61+1g8CKHgGs=
Authentication-Results: mxbackcorp2j.mail.yandex.net; dkim=pass header.i=@yandex-team.ru
Received: from dynamic-red.dhcp.yndx.net (dynamic-red.dhcp.yndx.net [2a02:6b8:0:40c:3d4d:a9cb:ef29:4bb1])
        by myt5-6212ef07a9ec.qloud-c.yandex.net (nwsmtp/Yandex) with ESMTPSA id RAO3ajsomT-4HHmU4Gd;
        Fri, 11 Oct 2019 11:04:17 +0300
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (Client certificate not present)
Subject: Re: [Patch v4 1/2] mm/rmap.c: don't reuse anon_vma if we just want a
 copy
To:     Wei Yang <richardw.yang@linux.intel.com>,
        akpm@linux-foundation.org, kirill.shutemov@linux.intel.com,
        jglisse@redhat.com, mike.kravetz@oracle.com, riel@surriel.com,
        cai@lca.pw, shakeelb@google.com
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org
References: <20191011072256.16275-1-richardw.yang@linux.intel.com>
From:   Konstantin Khlebnikov <khlebnikov@yandex-team.ru>
Message-ID: <77fb8811-2c95-55d2-de90-7e9ce01267a1@yandex-team.ru>
Date:   Fri, 11 Oct 2019 11:04:16 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20191011072256.16275-1-richardw.yang@linux.intel.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-CA
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/10/2019 10.22, Wei Yang wrote:
> Before commit 7a3ef208e662 ("mm: prevent endless growth of anon_vma
> hierarchy"), anon_vma_clone() doesn't change dst->anon_vma. While after
> this commit, anon_vma_clone() will try to reuse an exist one on forking.
> 
> But this commit go a little bit further for the case not forking.
> anon_vma_clone() is called from __vma_split(), __split_vma(), copy_vma()
> and anon_vma_fork(). For the first three places, the purpose here is get
> a copy of src and we don't expect to touch dst->anon_vma even it is
> NULL. While after that commit, it is possible to reuse an anon_vma when
> dst->anon_vma is NULL. This is not we intend to have.
> 
> This patch stop reuse anon_vma for non-fork cases.
> 
> Fix commit 7a3ef208e662 ("mm: prevent endless growth of anon_vma
> hierarchy")
> 
> Signed-off-by: Wei Yang <richardw.yang@linux.intel.com>

Yes, reusing heuristic was designed for fork.
But this isn't strictly necessary - any vmas could share anon_vma.
For example all vmas in system could be linked with single anon_vma.

Acked-by: Konstantin Khlebnikov <khlebnikov@yandex-team.ru>

> 
> ---
> v4:
>    * check dst->anon_vma in each iteration
> v3:
>    * use dst->anon_vma and src->anon_vma to get reuse state
>      pointed by Konstantin Khlebnikov
> ---
>   mm/rmap.c | 24 +++++++++++++++---------
>   1 file changed, 15 insertions(+), 9 deletions(-)
> 
> diff --git a/mm/rmap.c b/mm/rmap.c
> index d9a23bb773bf..c34414567474 100644
> --- a/mm/rmap.c
> +++ b/mm/rmap.c
> @@ -250,13 +250,19 @@ static inline void unlock_anon_vma_root(struct anon_vma *root)
>    * Attach the anon_vmas from src to dst.
>    * Returns 0 on success, -ENOMEM on failure.
>    *
> - * If dst->anon_vma is NULL this function tries to find and reuse existing
> - * anon_vma which has no vmas and only one child anon_vma. This prevents
> - * degradation of anon_vma hierarchy to endless linear chain in case of
> - * constantly forking task. On the other hand, an anon_vma with more than one
> - * child isn't reused even if there was no alive vma, thus rmap walker has a
> - * good chance of avoiding scanning the whole hierarchy when it searches where
> - * page is mapped.
> + * anon_vma_clone() is called by __vma_split(), __split_vma(), copy_vma() and
> + * anon_vma_fork(). The first three want an exact copy of src, while the last
> + * one, anon_vma_fork(), may try to reuse an existing anon_vma to prevent
> + * endless growth of anon_vma. Since dst->anon_vma is set to NULL before call,
> + * we can identify this case by checking (!dst->anon_vma && src->anon_vma).
> + *
> + * If (!dst->anon_vma && src->anon_vma) is true, this function tries to find
> + * and reuse existing anon_vma which has no vmas and only one child anon_vma.
> + * This prevents degradation of anon_vma hierarchy to endless linear chain in
> + * case of constantly forking task. On the other hand, an anon_vma with more
> + * than one child isn't reused even if there was no alive vma, thus rmap
> + * walker has a good chance of avoiding scanning the whole hierarchy when it
> + * searches where page is mapped.
>    */
>   int anon_vma_clone(struct vm_area_struct *dst, struct vm_area_struct *src)
>   {
> @@ -286,8 +292,8 @@ int anon_vma_clone(struct vm_area_struct *dst, struct vm_area_struct *src)
>   		 * will always reuse it. Root anon_vma is never reused:
>   		 * it has self-parent reference and at least one child.
>   		 */
> -		if (!dst->anon_vma && anon_vma != src->anon_vma &&
> -				anon_vma->degree < 2)
> +		if (!dst->anon_vma && src->anon_vma &&
> +		    anon_vma != src->anon_vma && anon_vma->degree < 2)
>   			dst->anon_vma = anon_vma;
>   	}
>   	if (dst->anon_vma)
> 
