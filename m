Return-Path: <SRS0=oHH8=SG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 71125C4360F
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Apr 2019 20:55:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2CDA7206C0
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Apr 2019 20:55:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="n2uUDsVg"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731352AbfDDUzs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 4 Apr 2019 16:55:48 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:46244 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730402AbfDDUzs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Apr 2019 16:55:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=xtQMwgiY2r3LYtEGN462H3ubJsH2H4Z/MvcHA6nL8yQ=; b=n2uUDsVg8AAC/7AYK18H2jE8m
        +0nIOKZAGofqaISxQ5stPIc5xcbt9r/hejGcUgL/t4zrMMnrwFKsxk9UXCBLbQxMRLRhneADB0P07
        EqJV0fdJZhozLygGGJh+polIPN4xFId7jSHvyDUO73OLtj22DyRgDkOt40EpEXqqTaJo0H1tpgg7F
        iqdbizn7ErBE98x2b7ABizVijbnnVq6V5dSQpK9nmVxRwaJt57tEvdlS47oiIO77k6LK8oYcBcMjq
        YECooRKqDjKHfPWDxH1vbtyFgv3LNz7/B5mxrjXqNOSyvfm/CPEjslENA3SO2RS6tn5nALwXosDum
        oFWKFzU7w==;
Received: from willy by bombadil.infradead.org with local (Exim 4.90_1 #2 (Red Hat Linux))
        id 1hC9Oj-00080m-7c; Thu, 04 Apr 2019 20:55:45 +0000
Date:   Thu, 4 Apr 2019 13:55:45 -0700
From:   Matthew Wilcox <willy@infradead.org>
To:     Stuart Swales <stuart.swales.croftnuisk@gmail.com>
Cc:     Russell King - ARM Linux admin <linux@armlinux.org.uk>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Ben Dooks <ben-linux-arm@fluff.org>
Subject: Re: fs/adfs - keep or kill it?
Message-ID: <20190404205545.GL22763@bombadil.infradead.org>
References: <20190404103521.pklwk4efp2zccjzc@shell.armlinux.org.uk>
 <0b7bcf91-500b-e25a-4a71-f41f3ca8c292@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0b7bcf91-500b-e25a-4a71-f41f3ca8c292@gmail.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 04, 2019 at 09:44:24PM +0100, Stuart Swales wrote:
> On 04/04/2019 11:35, Russell King - ARM Linux admin wrote:
> Have posted on the RISC OS Open site. I imagine some people will
> complain just because they can. Can't see a need for it in new kernels
> myself; people can always use old systems if they need to get data off
> old ADFS IDE drives like I had to.

If it's just grabbing old data, it's far better to do that with a
userspace tool which understands the ADFS layout (several exist).
The only good reason for keeping fs/adfs/ alive is if there's need to
continue to access data that lives on an ADFS filesystem and needs to
be read/written by both a RISC OS host and a Linux host.

