Return-Path: <SRS0=RWM+=ZG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 86D51C432C3
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Nov 2019 05:08:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 72507206EC
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Nov 2019 05:08:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1573708112;
	bh=bwDoBs1Gl7X6kr+VvLWmGBoPwoIr2qMGBpkJq35K1x0=;
	h=Subject:To:Cc:References:From:Date:In-Reply-To:List-ID:From;
	b=vA9IgIYFetkTAhI+RjR9a5FPAwKn556QyJq5v3RVAaSZREf9zb2+qN16gw73HSjCh
	 cTRc1m22eYeFo3MZ6LtfQSUoZJrolqZyvZrDn9bpFQUrRBk018rzrC7hS+eu3zowb7
	 fPZ+bxtrqxRuDBY5IN4mrlMipWC7Y+OdsK0Re0Cw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726106AbfKNFIb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Nov 2019 00:08:31 -0500
Received: from mail.kernel.org ([198.145.29.99]:43244 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725440AbfKNFIb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Nov 2019 00:08:31 -0500
Received: from [192.168.1.20] (cpe-24-28-70-126.austin.res.rr.com [24.28.70.126])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C49F1205C9;
        Thu, 14 Nov 2019 05:08:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1573708110;
        bh=bwDoBs1Gl7X6kr+VvLWmGBoPwoIr2qMGBpkJq35K1x0=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=oP2extHTQUlymGuKHYc5HIla8CRurumrsbn+oG0uNtHazxGpSd3Oak/5IYj6pOQdX
         KGU6zsBBp82kB2G9cquR+DjnYRoOSwG54tzqCaNhuzcg9lbIOID2FB1PfnKDHSKsP2
         1wcjKT4GVc9de18GzwVY2KFn6AM6YhbBiGc6Z8tM=
Subject: Re: [PATCH v4 04/47] soc: fsl: qe: introduce qe_io{read,write}*
 wrappers
To:     Rasmus Villemoes <linux@rasmusvillemoes.dk>
Cc:     Qiang Zhao <qiang.zhao@nxp.com>, Li Yang <leoyang.li@nxp.com>,
        Christophe Leroy <christophe.leroy@c-s.fr>,
        Scott Wood <oss@buserror.net>, linuxppc-dev@lists.ozlabs.org,
        lkml <linux-kernel@vger.kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>
References: <20191108130123.6839-1-linux@rasmusvillemoes.dk>
 <20191108130123.6839-5-linux@rasmusvillemoes.dk>
 <CAOZdJXU35+G5CMrS3247mgMjQH7__MxP8wpW6yjn1_MLD-sGqw@mail.gmail.com>
 <e37d24c5-6d4f-c8bf-1c38-f3e8b8e85eeb@rasmusvillemoes.dk>
From:   Timur Tabi <timur@kernel.org>
Message-ID: <38d87cf8-5945-61d7-80a7-c8374cbe729b@kernel.org>
Date:   Wed, 13 Nov 2019 23:08:28 -0600
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.11; rv:60.0)
 Gecko/20100101 Thunderbird/60.9.1
MIME-Version: 1.0
In-Reply-To: <e37d24c5-6d4f-c8bf-1c38-f3e8b8e85eeb@rasmusvillemoes.dk>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/12/19 1:14 AM, Rasmus Villemoes wrote:
> but that's because readl and writel by definition work on little-endian
> registers. I.e., on a BE platform, the readl and writel implementation
> must themselves contain a swab, so the above would end up doing two
> swabs on a BE platform.

Do you know whether the compiler optimizes-out the double swab?

> (On PPC, there's a separate definition of mmio_read32be, namely
> writel_be, which in turn does a out_be32, so on PPC that doesn't
> actually end up doing two swabs).
> 
> So ioread32be etc. have well-defined semantics: access a big-endian
> register and return the result in native endianness.

It seems weird that there aren't any cross-arch lightweight 
endian-specific I/O accessors.
