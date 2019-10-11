Return-Path: <SRS0=Osat=YE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DF612ECE58D
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Oct 2019 17:17:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BA075222D2
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Oct 2019 17:17:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Ub4xqxEX"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728705AbfJKRQ6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 11 Oct 2019 13:16:58 -0400
Received: from mail-pf1-f195.google.com ([209.85.210.195]:44724 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728681AbfJKRQ5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Oct 2019 13:16:57 -0400
Received: by mail-pf1-f195.google.com with SMTP id q21so6440790pfn.11
        for <linux-kernel@vger.kernel.org>; Fri, 11 Oct 2019 10:16:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=mBriml3iAfauQRKfpDbQ5vaiaD735vODzhiE9KF4g38=;
        b=Ub4xqxEXKetk/JV1WBUC4NL36KIS0kftpqOkawvxIYToHs/vjFe/4YqmK1OFX4mwVo
         5WZGZt2rLF7WoEv9/rKk1L2lAypfxdkDNZURmCUjqBjrGvaf52hFZtm5/mc/Gpr24Pgw
         RhprVxdJwYCDhjbCwracqpkAlx4SYSzsTFq0uOo8Mja/+E6CKL3VmuakLFVdm+41vozu
         3e5tO9+Mrv5hI/8so5sl5ibpgYP8qMaVPtxkyWu4DChlDYcfK35HC8Gf00Rx895FuPSu
         pzyx+lMVujTDx3QDdp0PDixeN3TbKkTqELkl1fY2VXxOXdVnm/4W91qsA2QUz7mI+cOI
         oE9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=mBriml3iAfauQRKfpDbQ5vaiaD735vODzhiE9KF4g38=;
        b=XjRlKaygZPauJNXm4raU1EmelEYZvkWQswSEvNdFlHSQIUvmJHgTwmMAVw+wor94/Z
         LDbrjzAieXCQTfF4ykZF/hHmLBeQp05+WY4VEPq+Cj7PLpLhpAFhVlnaMhD+yUEI+047
         XokM/jdcueVRmyHT4CgxQZFRj0PfLsj0FVUFBEYE9Jc46OWuBBCCkI5OQPi/eZi4Atsg
         oCsyTXzJUkYqswgCDozHJ80F/lN1HiAE4Pq+ZKXEY21Q/MD4U4Jn0KVPIqtObeeu/GSl
         eZALgIfVy+0z0WzrRYtm7cEdyEdzza4q4n3/Cr18e57w7LZRu64V7xwSAe/SIXk7RkbE
         NaOg==
X-Gm-Message-State: APjAAAWQoCyEIDyX5HWSnoFv3BW+79taG6yUBZIjks2g9ZQjVmItiyBO
        7g/ms+rTopUOZktGaRG4aFimqA==
X-Google-Smtp-Source: APXvYqw5pokzdLc2n6Op+HT2ZfXwi+YPWVWQFGtUwfC3RFA+PjDKcolG6VaPUhE98V4ZPamoeTyVTw==
X-Received: by 2002:a62:870c:: with SMTP id i12mr17524206pfe.247.1570814215586;
        Fri, 11 Oct 2019 10:16:55 -0700 (PDT)
Received: from minitux (104-188-17-28.lightspeed.sndgca.sbcglobal.net. [104.188.17.28])
        by smtp.gmail.com with ESMTPSA id w134sm9658594pfd.4.2019.10.11.10.16.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Oct 2019 10:16:54 -0700 (PDT)
Date:   Fri, 11 Oct 2019 10:16:52 -0700
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Kalle Valo <kvalo@codeaurora.org>
Cc:     netdev@vger.kernel.org, linux-wireless@vger.kernel.org,
        linux-kernel@vger.kernel.org, ath10k@lists.infradead.org,
        stable@vger.kernel.org, Niklas Cassel <niklas.cassel@linaro.org>,
        "David S. Miller" <davem@davemloft.net>
Subject: Re: [PATCH] ath10k: Correct error check of dma_map_single()
Message-ID: <20191011171652.GF571@minitux>
References: <20191010162653.141303-1-bjorn.andersson@linaro.org>
 <20191011115732.044BF60BE8@smtp.codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191011115732.044BF60BE8@smtp.codeaurora.org>
User-Agent: Mutt/1.12.2 (2019-09-21)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri 11 Oct 04:57 PDT 2019, Kalle Valo wrote:

> Bjorn Andersson <bjorn.andersson@linaro.org> wrote:
> 
> > The return value of dma_map_single() should be checked for errors using
> > dma_mapping_error(), rather than testing for NULL. Correct this.
> > 
> > Fixes: 1807da49733e ("ath10k: wmi: add management tx by reference support over wmi")
> > Cc: stable@vger.kernel.org
> > Reported-by: Niklas Cassel <niklas.cassel@linaro.org>
> > Signed-off-by: Bjorn Andersson <bjorn.andersson@linaro.org>
> 
> Did this fix any real bug? Or is this just something found during code review?
> 

CONFIG_DMA_API_DEBUG screamed at us for calling dma_unmap_single()
without ever having called dma_mapping_error() on the return value.

But Govind just pointed out to me that I hastily missed the fact that
this code path leaks the dequeued skb. So I'll respin the patch to fix
both issues at once.

Regards,
Bjorn

> -- 
> https://patchwork.kernel.org/patch/11183923/
> 
> https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches
> 
> 
> _______________________________________________
> ath10k mailing list
> ath10k@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/ath10k
