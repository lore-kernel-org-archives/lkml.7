Return-Path: <SRS0=DLm5=TA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 903BBC43219
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Apr 2019 13:32:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 604F821734
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Apr 2019 13:32:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="P7uEODNt"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727532AbfD3Ncg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 30 Apr 2019 09:32:36 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:34736 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725838AbfD3Nce (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Apr 2019 09:32:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=nMPoH35x5bq7483H+91AkH1RJePV4Du6v5zOXvqkvu8=; b=P7uEODNtZUFXsXvCEiyD2XZcA
        m+3iOXQkVYLCUmow1Fhe1Hug/sDPFGPVB5l6l+A5qTz1t/cgwg3tFyGiAsQ/sTZ/KUZfaWr/RCpyF
        f1N5k5LKqJiScJYPZvCSkQfQeoFag1jypQvLF8Krl8dWaqfKVkaiT4VolA5WAi/dPRJT/7I3Szai3
        2BsfMhTpk5ethQuxzjaaeDm+hjoYflyP+97qgJp3bnltos7VS8W+xQof4wjvCQNnGo2EFw0zwHkDO
        nMgn+V1O7R76Fan6dyyReWQLrg6UdDv8nSjV485CTX+nEUr2p49hSXHC7iHC75F5wj5uGKnWcr+UG
        ytj/77oiA==;
Received: from hch by bombadil.infradead.org with local (Exim 4.90_1 #2 (Red Hat Linux))
        id 1hLSs3-0008Qf-SI; Tue, 30 Apr 2019 13:32:31 +0000
Date:   Tue, 30 Apr 2019 06:32:31 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     Phong Tran <tranmanphong@gmail.com>
Cc:     robh+dt@kernel.org, frowand.list@gmail.com,
        pantelis.antoniou@konsulko.com, natechancellor@gmail.com,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] of: replace be32_to_cpu to be32_to_cpup
Message-ID: <20190430133231.GA5646@infradead.org>
References: <20190430090044.16345-1-tranmanphong@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190430090044.16345-1-tranmanphong@gmail.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 30, 2019 at 04:00:44PM +0700, Phong Tran wrote:
> 
> diff --git a/include/linux/of.h b/include/linux/of.h
> index e240992e5cb6..1c35fc8f19b0 100644
> --- a/include/linux/of.h
> +++ b/include/linux/of.h
> @@ -235,7 +235,7 @@ static inline u64 of_read_number(const __be32 *cell, int size)
>  {
>  	u64 r = 0;
>  	while (size--)
> -		r = (r << 32) | be32_to_cpu(*(cell++));
> +		r = (r << 32) | be32_to_cpup(cell++);
>  	return r;

This whole function looks odd.  It could simply be replaced with
calls to get_unaligned_be64 / get_unaligned_be32.  Given that we have a
lot of callers we can't easily do that, but at least we could try
something like

static inline u64 of_read_number(const __be32 *cell, int size)
{
	WARN_ON_ONCE(size < 1);
	WARN_ON_ONCE(size > 2);

	if (size == 1)
		return get_unaligned_be32(cell);
	return get_unaligned_be64(cell);
}
