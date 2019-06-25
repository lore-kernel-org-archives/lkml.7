Return-Path: <SRS0=/s9R=UY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 19677C48BD5
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Jun 2019 22:29:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EA74F2085A
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Jun 2019 22:29:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726524AbfFYW3y (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 25 Jun 2019 18:29:54 -0400
Received: from zeniv.linux.org.uk ([195.92.253.2]:40222 "EHLO
        ZenIV.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726077AbfFYW3y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Jun 2019 18:29:54 -0400
Received: from viro by ZenIV.linux.org.uk with local (Exim 4.92 #3 (Red Hat Linux))
        id 1hftwb-0001ZR-4N; Tue, 25 Jun 2019 22:29:41 +0000
Date:   Tue, 25 Jun 2019 23:29:41 +0100
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     Christoph Hellwig <hch@lst.de>
Cc:     Greg Ungerer <gerg@linux-m68k.org>,
        Michal Simek <monstr@monstr.eu>,
        linux-arm-kernel@lists.infradead.org, linux-c6x-dev@linux-c6x.org,
        uclinux-h8-devel@lists.sourceforge.jp,
        linux-m68k@lists.linux-m68k.org, linux-riscv@lists.infradead.org,
        linux-sh@vger.kernel.org, linux-xtensa@linux-xtensa.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 08/17] binfmt_flat: consolidate two version of
 flat_v2_reloc_t
Message-ID: <20190625222941.GA1343@ZenIV.linux.org.uk>
References: <20190613070903.17214-1-hch@lst.de>
 <20190613070903.17214-9-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190613070903.17214-9-hch@lst.de>
User-Agent: Mutt/1.11.3 (2019-02-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 13, 2019 at 09:08:54AM +0200, Christoph Hellwig wrote:
> Two branches of the ifdef maze actually have the same content, so merge
> them.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> ---
>  include/linux/flat.h | 6 ++----
>  1 file changed, 2 insertions(+), 4 deletions(-)
> 
> diff --git a/include/linux/flat.h b/include/linux/flat.h
> index 2b7cda6e9c1b..19c586b74b99 100644
> --- a/include/linux/flat.h
> +++ b/include/linux/flat.h
> @@ -69,15 +69,13 @@ struct flat_hdr {
>  typedef union {
>  	unsigned long	value;
>  	struct {
> -# if defined(mc68000) && !defined(CONFIG_COLDFIRE)
> +#if defined(__LITTLE_ENDIAN_BITFIELD) || \
> +    (defined(mc68000) && !defined(CONFIG_COLDFIRE))
>  		signed long offset : 30;
>  		unsigned long type : 2;
>  # elif defined(__BIG_ENDIAN_BITFIELD)
>  		unsigned long type : 2;
>  		signed long offset : 30;
> -# elif defined(__LITTLE_ENDIAN_BITFIELD)
> -		signed long offset : 30;
> -		unsigned long type : 2;
>  # else
>  #   	error "Unknown bitfield order for flat files."
>  # endif
> -- 
> 2.20.1
> 

FWIW, I wonder if keeping that type is worth bothering.
Something like
old_reloc(__be32 reloc)
{
	u32 v = be32_to_cpu(reloc);
	int offset, type;

#if (defined(mc68000) && !defined(CONFIG_COLDFIRE))
	/* old m68k uses unusual format - type is in lower bits of octet 3 */
	type = v % 4;
	offset = (int)v / 4;
#else
	/* everything else (including coldfire) has it in upper bits of octet 0 */
	type = v >> 30;
	offset = (int)(v << 2) >> 2; /* or (v & 0x1fffffff) - (v & 0x20000000) * 4 */
#endif
	...

and to hell with bitfields, aliasing unions, etc.  Unless I'm misreading
the whole thing, that is...  Greg?
