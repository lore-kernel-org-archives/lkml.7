Return-Path: <SRS0=PPSE=ZM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 61043C432C0
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Nov 2019 18:51:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 306C220721
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Nov 2019 18:51:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="BCDJYM3f"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727318AbfKTSvN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Nov 2019 13:51:13 -0500
Received: from mail-pl1-f196.google.com ([209.85.214.196]:37484 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726023AbfKTSvM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Nov 2019 13:51:12 -0500
Received: by mail-pl1-f196.google.com with SMTP id bb5so194398plb.4
        for <linux-kernel@vger.kernel.org>; Wed, 20 Nov 2019 10:51:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=mn+nCBQ8MjgT+fYEd4BfZVfrpR1Vy2KWBRbsCtWJECg=;
        b=BCDJYM3fK8xymWgfzI2Qds6ZpSjZqAQlDES//MqsDNY8WXRgBmOUZpFTAH9Md4r542
         LsmIYpY+/sDVEbSoqoninE1aCmWqcg5LO40xEtapuYot+yixhXxJzhEFSwSWKrzCynOI
         AVqG7XDEBLzLHS+GJOLPKetMcG0ympwwaM/Z4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=mn+nCBQ8MjgT+fYEd4BfZVfrpR1Vy2KWBRbsCtWJECg=;
        b=RdG6SbhRgU7K+r0ntvqTEZAj7L+GLTDvFy/BIQ75dETwEg2Og+clJhK26GI8BKEm1E
         GVDyw2kLvo0agKcFUBXclyyKsI6RjWZUtbz+2gor2KSC0tBR9AALcsHEAJf45nC3D/jG
         MRSTT51+KLm8PdswOJWS1UT1+zKGURyFhXyhzJtUymeB7HQWnAXPkW9TcI5WbHxtlwb2
         vcn6XEWMAT+tt57RGZGMjFR7N/L6hiI++al1jMWKCkkjxqBgVjuJZaMMULjNI3Eql3PS
         MOxzwLFR9pu9EDFVLQr7atbeSTqGvYwHFIQJaa/34yffanSGt4MHlye4FSgFLzQVMurV
         nvng==
X-Gm-Message-State: APjAAAUV77trL9IKgeeQVz7bSaxAX7/jkiWzn3JpRLQ0VkRqe5ErsZaQ
        /ppWE+JIqqC7ZY7/5vCxUKziMg==
X-Google-Smtp-Source: APXvYqzFi23pyUkvMFe0Ie/Eu60vm+BM13HMViW37nMsXp1BESp6LP52/K0Kga/co6nHh+jfQ8PYqQ==
X-Received: by 2002:a17:902:7c04:: with SMTP id x4mr4547952pll.0.1574275872166;
        Wed, 20 Nov 2019 10:51:12 -0800 (PST)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id t15sm31526082pgb.0.2019.11.20.10.51.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Nov 2019 10:51:11 -0800 (PST)
Date:   Wed, 20 Nov 2019 10:51:10 -0800
From:   Kees Cook <keescook@chromium.org>
To:     Jason Yan <yanaijie@huawei.com>
Cc:     mpe@ellerman.id.au, linuxppc-dev@lists.ozlabs.org,
        diana.craciun@nxp.com, christophe.leroy@c-s.fr,
        benh@kernel.crashing.org, paulus@samba.org, npiggin@gmail.com,
        kernel-hardening@lists.openwall.com, linux-kernel@vger.kernel.org,
        oss@buserror.net
Subject: Re: [PATCH 0/6] implement KASLR for powerpc/fsl_booke/64
Message-ID: <201911201050.9182A9DC@keescook>
References: <20191115093209.26434-1-yanaijie@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191115093209.26434-1-yanaijie@huawei.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 15, 2019 at 05:32:03PM +0800, Jason Yan wrote:
> This is a try to implement KASLR for Freescale BookE64 which is based on
> my earlier implementation for Freescale BookE32:
> https://patchwork.ozlabs.org/project/linuxppc-dev/list/?series=131718

Whee! :) I've updated https://github.com/KSPP/linux/issues/3 with a link
to this current series.

-- 
Kees Cook
