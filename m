Return-Path: <SRS0=5wok=UM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3BDE9C31E45
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Jun 2019 18:51:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 159462147A
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Jun 2019 18:51:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QciANm+R"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729135AbfFMSvq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Jun 2019 14:51:46 -0400
Received: from mail-oi1-f195.google.com ([209.85.167.195]:46761 "EHLO
        mail-oi1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725838AbfFMSvp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Jun 2019 14:51:45 -0400
Received: by mail-oi1-f195.google.com with SMTP id 65so92282oid.13
        for <linux-kernel@vger.kernel.org>; Thu, 13 Jun 2019 11:51:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=/UPxWSlC5sa2bqOyrgAL69/GdR1/OE8Ch9dSPjw4HAw=;
        b=QciANm+ReKrJ0szbSi1fGnbMist6Yz1rN7pI3bws0+TWRIzZdQkCmN6AUFv2/KsdzD
         IN9IgdWsxE98VftCdxsxJmKPuG6hJUUmFifIuIokGVUuk+viIemj86pXrJbpvLP3UDV4
         d03z93Bc+SwF6rBiezP5ABz+B6NXLmfzQ1LPyoYl4aqi8NdQQbwu5Z1Y+UccvWvKVGgL
         UBdowE/ZPsjVfKaoCbhIJshixaflZXTTpw4XJIZLJOgFtPz8lk7Tb9SX4zwI7rAfWt/B
         ju4Uw/3/rppXw6skGIETJAeoOPlzBvLXtKIa9JiHtWVoZa6xoP5p4ViZoDoPLc/HaxY7
         yuEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:subject:to:cc:references:from:message-id
         :date:user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=/UPxWSlC5sa2bqOyrgAL69/GdR1/OE8Ch9dSPjw4HAw=;
        b=gV8zObdPBFb8BOJMJ8pv4mkN5bkUYGyBeVM87KHSB5t427XRgrmXiTCPEVZPcrYGTG
         JNChTKpSaiVdEQVhgaK2NYKMkvaL+rxl4HrYSiEvCuY2dL6YeqnkmogLOitOxdtObblb
         fzzWMZvXzlm0Ju0RSy043WdS96VoF1PTd9vyZiFXwpa+Rlca7P2ofloGpLk+fPYELib3
         NeqhqMUPpe4XEnHtDg+pqNoj/t6iLdf7OPWByyCPQAQ3swklWLAI/WabT6RwUmOFz18K
         0Xxgs4zgqOJ7tuXuF3R6rdGYpVRgIN6ST4+vrDDhcqRoM8DMFgo5p+xrnBMb/ynhJUzU
         Yq/w==
X-Gm-Message-State: APjAAAVujHPMUt4wr1cbpg+7NN2YcYbYxn6YEg5bcvLAUpZLOlf676Pa
        lMH0uDmXH3gTa1rNX6G/4ituLx9G
X-Google-Smtp-Source: APXvYqxN7mmhXH/KLQY6oeLzDB+2IeuUjevbypQYE7vAYi0s8uy3XJkg3sdKQjMN7GdBPQGLpYJmJA==
X-Received: by 2002:aca:80f:: with SMTP id 15mr3802774oii.118.1560451904574;
        Thu, 13 Jun 2019 11:51:44 -0700 (PDT)
Received: from [192.168.1.112] (cpe-24-31-245-230.kc.res.rr.com. [24.31.245.230])
        by smtp.gmail.com with ESMTPSA id l65sm186063oif.20.2019.06.13.11.51.42
        (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
        Thu, 13 Jun 2019 11:51:43 -0700 (PDT)
Subject: Re: [PATCH] powerpc: enable a 30-bit ZONE_DMA for 32-bit pmac
To:     Christoph Hellwig <hch@lst.de>, benh@kernel.crashing.org,
        paulus@samba.org, mpe@ellerman.id.au
Cc:     aaro.koskinen@iki.fi, linuxppc-dev@lists.ozlabs.org,
        linux-kernel@vger.kernel.org
References: <20190613082446.18685-1-hch@lst.de>
From:   Larry Finger <Larry.Finger@lwfinger.net>
Message-ID: <334280df-9002-c92f-d381-9fd79e2a9036@lwfinger.net>
Date:   Thu, 13 Jun 2019 13:51:41 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <20190613082446.18685-1-hch@lst.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 6/13/19 3:24 AM, Christoph Hellwig wrote:
> With the strict dma mask checking introduced with the switch to
> the generic DMA direct code common wifi chips on 32-bit powerbooks
> stopped working.  Add a 30-bit ZONE_DMA to the 32-bit pmac builds
> to allow them to reliably allocate dma coherent memory.
> 
> Fixes: 65a21b71f948 ("powerpc/dma: remove dma_nommu_dma_supported")
> Reported-by: Aaro Koskinen <aaro.koskinen@iki.fi>
> Signed-off-by: Christoph Hellwig <hch@lst.de>

As expected, it works. The patch needs
Cc: Stable <stable*vger.kernel.org> # v5.1+

Tested-by: Larry Finger <Larry.Finger@lwfinger.net>
Acked-by: Larry Finger <Larry.Finger@lwfinger.net>

Thanks for the help, and the patience with my debugging problems with u64 variables.

Larry
