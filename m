Return-Path: <SRS0=K12x=T4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AD9AEC04AB6
	for <linux-kernel@archiver.kernel.org>; Tue, 28 May 2019 13:18:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 690E42133F
	for <linux-kernel@archiver.kernel.org>; Tue, 28 May 2019 13:18:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linbit-com.20150623.gappssmtp.com header.i=@linbit-com.20150623.gappssmtp.com header.b="BC4MXGYk"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727493AbfE1NS2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 May 2019 09:18:28 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:37114 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726620AbfE1NS2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 May 2019 09:18:28 -0400
Received: by mail-wr1-f67.google.com with SMTP id h1so6063066wro.4
        for <linux-kernel@vger.kernel.org>; Tue, 28 May 2019 06:18:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linbit-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:mail-followup-to:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=qcTvsk+UCfbFdsEXKr8TQrbFAEGJURQ/pQgVJPeH+oQ=;
        b=BC4MXGYkZQXy7mqJmMNGHymVJrDjsFp/KA9IBtrHKACQLKTh7DdwsUOpOXDRRnvTUE
         C8u4d908Y9r0cs/LHiMylSt8p5MEgvrCcac0EDtsLfevNMWT+uRoCSVXvs+IISFPvtDj
         lo7t5LUntMEa6tHXudTVRTruZJ7gRJQZUCgSfwYkNgJXQkHmrPapVFfirswTJ/D2I6yb
         w2e94VR6C0zuXejCbbj3p1KMnUeRDJD8aCZfOi/YiyTzxkdkNNShBaGLZQr6payyb9eZ
         Tup3fCxgZ5YVfJY32BD6h7yCgAxr7mDxGKjFewbUBre3uDNnhZ7QD8dmtysyCRfgOWYj
         +2Sw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id
         :mail-followup-to:references:mime-version:content-disposition
         :content-transfer-encoding:in-reply-to:user-agent;
        bh=qcTvsk+UCfbFdsEXKr8TQrbFAEGJURQ/pQgVJPeH+oQ=;
        b=G9cjWZv7hMfFrjbeGbL21C13cf9U5sKfmF2YqpbvOXshFbC3xA3ZqAIldheJlZmZ3F
         I+hzgFdDnLDXOisYDSv5/qj3frrutWj6BAnu2gS2Tlyhpe03jEy6Ivt9BTjuGwaGv6ES
         /FQKhZxggoL6lOmhug9x0pEc2iSbj9uj9Mxvoxx9UPrswU5BHgvfpSdJtoOorjG9/VvL
         5k1Zgv6TdfL9j+c2b76JZsepBlYVy9xw/668S51CCsUmcR5Fk1T82JoR/UqpuHhcaMwM
         boiYaLMoo8O6jOtQux7UlVkYjLC5EgmEBPNp4N4GHUaixnbhpax513gdwRca/EnjcD+M
         yuzg==
X-Gm-Message-State: APjAAAVVGRgyK42vONFe9q5prcM0IL+U7gxXpw6+yFdg5HOvAH2abhjU
        emkq3A5Uy7IJqXPsjbWTlhL6JYDf8mI=
X-Google-Smtp-Source: APXvYqz6mozGy9uZb9MqcgQGTyhkCyWtzWXdkQe2jURUETumSBi723sWqNfMtadAuXeZb5vXO+U/CA==
X-Received: by 2002:adf:db89:: with SMTP id u9mr40797993wri.294.1559049506335;
        Tue, 28 May 2019 06:18:26 -0700 (PDT)
Received: from soda.linbit (212-186-191-219.static.upcbusiness.at. [212.186.191.219])
        by smtp.gmail.com with ESMTPSA id i15sm13040650wre.30.2019.05.28.06.18.25
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 28 May 2019 06:18:25 -0700 (PDT)
Date:   Tue, 28 May 2019 15:18:23 +0200
From:   Lars Ellenberg <lars.ellenberg@linbit.com>
To:     Eric Wheeler <drbd-dev@lists.ewheeler.net>
Cc:     drbd-dev@lists.linbit.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] drbd: fix discard_zeroes_if_aligned regression
Message-ID: <20190528131823.GD5803@soda.linbit>
Mail-Followup-To: Eric Wheeler <drbd-dev@lists.ewheeler.net>,
        drbd-dev@lists.linbit.com, linux-kernel@vger.kernel.org
References: <15124635.GA4107@soda.linbit>
 <1516057231-21756-1-git-send-email-drbd-dev@lists.ewheeler.net>
 <20180116072615.GA3940@infradead.org>
 <20180116094907.GD4107@soda.linbit>
 <alpine.LRH.2.11.1905101728280.1835@mx.ewheeler.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <alpine.LRH.2.11.1905101728280.1835@mx.ewheeler.net>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 10, 2019 at 05:36:32PM +0000, Eric Wheeler wrote:
> Hi Lars,
> 
> We just tried 4.19.x and this bugs still exists. We applied the patch 
> which was originally submitted to this thread and it still applies cleanly 
> and seems to work for our use case. You mentioned that you had some older 
> code which zeroed out unaligned discard requests (or perhaps it was for a 
> different purpose) that you may be able to use to patch this. Could you 
> dig those up and see if we can get this solved?
> 
> It would be nice to be able to use drbd with thin backing volumes from the 
> vanilla kernel. If this has already been fixed in something newer than 
> 4.19, then please point me to the commit.

I think it was merged upstream in 5.0
f31e583aa2c2 drbd: introduce P_ZEROES (REQ_OP_WRITE_ZEROES on the "wire")

-- 
: Lars Ellenberg
: LINBIT | Keeping the Digital World Running
: DRBD -- Heartbeat -- Corosync -- Pacemaker
: R&D, Integration, Ops, Consulting, Support

DRBD® and LINBIT® are registered trademarks of LINBIT
