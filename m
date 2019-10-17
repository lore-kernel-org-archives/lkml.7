Return-Path: <SRS0=WVJ0=YK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1824EFA372A
	for <linux-kernel@archiver.kernel.org>; Thu, 17 Oct 2019 07:53:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E3954214E0
	for <linux-kernel@archiver.kernel.org>; Thu, 17 Oct 2019 07:53:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fv2JBe6g"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2407999AbfJQHxR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 17 Oct 2019 03:53:17 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:39097 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732594AbfJQHxR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Oct 2019 03:53:17 -0400
Received: by mail-wr1-f66.google.com with SMTP id r3so1144618wrj.6;
        Thu, 17 Oct 2019 00:53:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=WmdAjijAJ1mGcWe1ZcT62QIO9S6tWqydNbncWS1uCf8=;
        b=fv2JBe6gEpqcjAhpqxIhM/r5H5cKzRW/3x8+EWmbWgFARRM4zYG0RSIxks09MEjjMg
         Y9vO6HDfZYXUUzi5bS5J4Vn7R2GxKZKFFlX6xN/PyIU2p+OY9zOH1J71JglnIT8szL5T
         auzK1ruhn6aWoVs0yOkpOePm6iPkFMJ3KnZL5BIFlueSSkKca+hC3mr0wgj3c2R+Nz8v
         oqGgmyek2JE2rZX8qVkuX8V/LWme6hOADuSlFN6+27H9Oip0HbWt0iUmIFCgFXGfEnsZ
         lYOtToI3dLo3X5poDykpAFq0SObi/0Ty23QofOrQBYJ7A8pL2L4n6S3rIBm9CagLy77u
         crpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=WmdAjijAJ1mGcWe1ZcT62QIO9S6tWqydNbncWS1uCf8=;
        b=Ym1yr+VkUn9SslEZTvWE3qtxQKxXV25rm39t063DuXZlh9d5IlRys3kO46fD37D7rV
         p8HjjJJblQdfSaDI0FaBqIDGzKHQfdCDsSjaeKR0HVljTKHHBm+oosaLokxieJX38sD+
         FVrTr7CsdmBeoPyyIXY5XWCVFQFgN8q8N3uHsKyvU2c9Xq863FNyIaoz/6HtXs/4mJ4n
         DfQqhMsqyN1UA8Zy7PKIYcyTwmMrIjCrgZpTgJ1rh5goze2CHDORi+2IDfczxjBnuwsf
         UVtAvgLWHzpnEVlZrpK09r7hfYv/cz7BQ0Roko4kgRc8vPqMjfVDIOzacZXagfluUym3
         vvYA==
X-Gm-Message-State: APjAAAWoOsj1I5usatDEZ8A67HWNtwA0OQd5KjpiS6b07HAcVqxWkJCh
        UI7l8nJ7rUKqe0+jYDxXb6I=
X-Google-Smtp-Source: APXvYqzTcvcm8WbGzmcu4hbIsYWFxP+P9ICfyRC1hJQjmxFumwxQCPn3KSTizxcFDNal3frZ7VNKEg==
X-Received: by 2002:a5d:46c6:: with SMTP id g6mr1666233wrs.331.1571298795401;
        Thu, 17 Oct 2019 00:53:15 -0700 (PDT)
Received: from pali ([2a02:2b88:2:1::5cc6:2f])
        by smtp.gmail.com with ESMTPSA id b130sm1976566wmh.12.2019.10.17.00.53.14
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 17 Oct 2019 00:53:14 -0700 (PDT)
Date:   Thu, 17 Oct 2019 09:53:13 +0200
From:   Pali =?utf-8?B?Um9ow6Fy?= <pali.rohar@gmail.com>
To:     Valdis =?utf-8?Q?Kl=C4=93tnieks?= <valdis.kletnieks@vt.edu>
Cc:     Sasha Levin <sashal@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        devel@driverdev.osuosl.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Sasha Levin <alexander.levin@microsoft.com>,
        Christoph Hellwig <hch@infradead.org>
Subject: Re: [PATCH] staging: exfat: add exfat filesystem code to staging
Message-ID: <20191017075313.6bxsn2d5ceuazowc@pali>
References: <20190828160817.6250-1-gregkh@linuxfoundation.org>
 <20190829205631.uhz6jdboneej3j3c@pali>
 <184209.1567120696@turing-police>
 <20190829233506.GT5281@sasha-vm>
 <20190830075647.wvhrx4asnkrfkkwk@pali>
 <20191016140353.4hrncxa5wkx47oau@pali>
 <20191016143113.GS31224@sasha-vm>
 <20191016160349.pwghlg566hh2o7id@pali>
 <20191016203317.GU31224@sasha-vm>
 <207853.1571262823@turing-police>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <207853.1571262823@turing-police>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday 16 October 2019 17:53:43 Valdis Klētnieks wrote:
> and may cause problems if Linux says "currently using FAT 2", and the
> disk is next used on a Windows 10 box that only looks at FAT 1....

You should use same algorithm which is used for FAT32. Primary FAT is
first. And all operations are done on Secondary FAT and then is
Secondary FAT copied to Primary. This is backward compatible with
systems which operates only with first primary FAT. And other systems
which see both FATs can benefit from redundancy/recovery.

-- 
Pali Rohár
pali.rohar@gmail.com
