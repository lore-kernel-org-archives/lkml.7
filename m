Return-Path: <SRS0=NWWL=SU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 45B7CC10F0E
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Apr 2019 09:13:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0ACED2184B
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Apr 2019 09:13:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=ffwll.ch header.i=@ffwll.ch header.b="B8kgmlY5"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388364AbfDRJNU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 18 Apr 2019 05:13:20 -0400
Received: from mail-ed1-f68.google.com ([209.85.208.68]:33458 "EHLO
        mail-ed1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387519AbfDRJNU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Apr 2019 05:13:20 -0400
Received: by mail-ed1-f68.google.com with SMTP id d55so1216097ede.0
        for <linux-kernel@vger.kernel.org>; Thu, 18 Apr 2019 02:13:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google;
        h=sender:date:from:to:cc:subject:message-id:mail-followup-to
         :references:mime-version:content-disposition
         :content-transfer-encoding:in-reply-to:user-agent;
        bh=OjUGlAjT4DYAvkg6QLdVvAZHTHbrrjwl7QJ0dcImz98=;
        b=B8kgmlY5n9tUWDOiNreu2Eg1oJlBQ3EPZgAI3s0iow3UmdEQLra6Bsp+nPtBo1nB2/
         JuPxXmc5Igd8SISFP/nl0buLxcXm5NFgQ6jzP8lm+cK1duj085pWm7ioj4y1rvJ+VSRH
         e9d7R532oDrnxBIdOdZrqQCjzYOAlQVAqmJc8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :mail-followup-to:references:mime-version:content-disposition
         :content-transfer-encoding:in-reply-to:user-agent;
        bh=OjUGlAjT4DYAvkg6QLdVvAZHTHbrrjwl7QJ0dcImz98=;
        b=nc/Me1KDAoBXmEQx9goYBlIXDFhxoR7yo04C09stDpgKqEtUjfgOH2NrWZCeLv/4Xa
         AnJ5bCKwdzS2h3XAod9VL81cvdIJPxRsfNliHZEMrbjRl0N6wXAGqlSHN4wrZ71lmx0n
         8/AdEH2kAsiouxoHGd2Pn6YD1esFbZ0IN6bx7wTl6Zv2FEVaDRrYecXYgH0Eheu6BwFs
         WSrvk28R/H8efSPbQTsoQRb65SkCwZ7U5a+Zv+veQ4Qe2YrrlPlgz+McITNTMOhS9ayY
         bGpxC9IPrgMEisW2EmWYZLezyhKHmDsvFIyr/F5viHF378BTTiAvZCNLks9+ogCcuy6z
         DAxw==
X-Gm-Message-State: APjAAAX4Qrc8+ynggNejRZBo5nKx9HQ5zPFmMa9gyulXQtRAZQOG4KVn
        E3G5BdjnHX1t60VWwaJe1Aytnw==
X-Google-Smtp-Source: APXvYqzd+Pd8rX3m0x97zDCVsH2TW0wHOoEOzfzXh82K2xObGfaqRGKAMLljVzlc5EylaZbnBdkSRQ==
X-Received: by 2002:a17:906:1ed7:: with SMTP id m23mr51584158ejj.198.1555578798558;
        Thu, 18 Apr 2019 02:13:18 -0700 (PDT)
Received: from phenom.ffwll.local ([2a02:168:569e:0:3106:d637:d723:e855])
        by smtp.gmail.com with ESMTPSA id p1sm283982ejf.40.2019.04.18.02.13.17
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 18 Apr 2019 02:13:17 -0700 (PDT)
Date:   Thu, 18 Apr 2019 11:13:15 +0200
From:   Daniel Vetter <daniel@ffwll.ch>
To:     Christian =?iso-8859-1?Q?K=F6nig?= 
        <ckoenig.leichtzumerken@gmail.com>
Cc:     sumit.semwal@linaro.org, linux-media@vger.kernel.org,
        dri-devel@lists.freedesktop.org, linaro-mm-sig@lists.linaro.org,
        linux-kernel@vger.kernel.org, amd-gfx@lists.freedesktop.org
Subject: Re: dynamic DMA-buf sharing between devices
Message-ID: <20190418091315.GU13337@phenom.ffwll.local>
Mail-Followup-To: Christian =?iso-8859-1?Q?K=F6nig?= <ckoenig.leichtzumerken@gmail.com>,
        sumit.semwal@linaro.org, linux-media@vger.kernel.org,
        dri-devel@lists.freedesktop.org, linaro-mm-sig@lists.linaro.org,
        linux-kernel@vger.kernel.org, amd-gfx@lists.freedesktop.org
References: <20190416183841.1577-1-christian.koenig@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20190416183841.1577-1-christian.koenig@amd.com>
X-Operating-System: Linux phenom 4.19.0-1-amd64 
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 16, 2019 at 08:38:29PM +0200, Christian König wrote:
> Hi everybody,
> 
> core idea in this patch set is that DMA-buf importers can now provide an optional invalidate callback. Using this callback and the reservation object exporters can now avoid pinning DMA-buf memory for a long time while sharing it between devices.
> 
> I've already send out an older version roughly a year ago, but didn't had time to further look into cleaning this up.
> 
> The last time a major problem was that we would had to fix up all drivers implementing DMA-buf at once.
> 
> Now I avoid this by allowing mappings to be cached in the DMA-buf attachment and so driver can optionally move over to the new interface one by one.
> 
> This is also a prerequisite to my patchset enabling sharing of device memory with DMA-buf.

Ok, with the discussions and thinking I think this design is solid and
should work out. Bunch of api and documentation polishing still to do, to
make sure we have really clear semantics and as little room as possible
for misunderstanding - refactoring a mess in dma-buf is a lot more tricky
than just ttm, there's a lot more users.
-Daniel
-- 
Daniel Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch
