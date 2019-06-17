Return-Path: <SRS0=xALZ=UQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D94DCC31E57
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Jun 2019 13:05:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B237C208E4
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Jun 2019 13:05:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lixom-net.20150623.gappssmtp.com header.i=@lixom-net.20150623.gappssmtp.com header.b="WV+GlV5H"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728009AbfFQNFZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Jun 2019 09:05:25 -0400
Received: from mail-lf1-f66.google.com ([209.85.167.66]:37230 "EHLO
        mail-lf1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725983AbfFQNFW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Jun 2019 09:05:22 -0400
Received: by mail-lf1-f66.google.com with SMTP id d11so6452799lfb.4
        for <linux-kernel@vger.kernel.org>; Mon, 17 Jun 2019 06:05:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lixom-net.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=0KqRJbvL3FPC7QkmhX15E3HE93ZyuGMTNLsfWYcNRE8=;
        b=WV+GlV5HNxaIHAV1oIVUE1rQ+G+s+nFY4sT8EVdoc1IkoiuJ+k++RBgFdahL/oDNki
         v/Bt/SbX1OApIu97wdFjEItw0Tz/KRf93273CWRPGtgp6PuPMNgd6Mh4FvapM7F9zQNB
         LL1MsPwmC9L7eWyYzyls2U3DY8hLpok9vCqqgYEr9Qo6rC7CcUIsYrghu/PzMaS/diZ/
         BKeTjxSUknSIyx+KCe5FUV06pdghE2W8sWBf5We5qunHSrYOls5DR6xTIeiZNEkjElnL
         tr1nSKm+FyOoHzbS8PB6j7JnbDrfGoaRA5HrpeTYHxFRwlGZIdkAy0GJTBkxyhSedPcj
         9zQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=0KqRJbvL3FPC7QkmhX15E3HE93ZyuGMTNLsfWYcNRE8=;
        b=scM+5JCNvcjxn+1UKTRQgBO2IQGi0u9czpIueAc+WXK8tuMwKq9dQskxGH2mNltZzS
         N7z2Jk7xwheTyg9cFEGi0YLSaim8gHp4XJ+6yHuC3K1InsA1e7kC+/Ha884BKNsT1eHO
         1gkJ7ZZW0mW4KsSEC66bHwyxe6viVpAqYwodOGfR7GtFA4r0W+CK5v7jxNOtLL7H+Uon
         /Sw+7xewqbcpXXJkESZe8DvbynKt5WE3T17m5gENHVQLR9I622FMCmoJrNPO/iWcEuux
         ZnorfNN95/crTChUHVAzWdtIc+nGwCgvA8K2IxvHNLqGFjYP0VBWHel6NKyxsJcvnNFQ
         BONg==
X-Gm-Message-State: APjAAAW1CnP3e88PtYEpDTFUm2kWKAiLqpfmV3cOsKTNg6JOq5/yXymf
        h8wWWcz/t2dH6vHxH0TKK2irDA==
X-Google-Smtp-Source: APXvYqxfwLwWY+tHIZf9ylLgsFN1BoBomQ/+nIZbYcnHTBSgZaXRncUdZAFu49eMc+VuGJ1OT1KJXw==
X-Received: by 2002:ac2:52ac:: with SMTP id r12mr35231104lfm.126.1560776720812;
        Mon, 17 Jun 2019 06:05:20 -0700 (PDT)
Received: from localhost (h85-30-9-151.cust.a3fiber.se. [85.30.9.151])
        by smtp.gmail.com with ESMTPSA id m28sm2113691ljb.68.2019.06.17.06.05.19
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 17 Jun 2019 06:05:19 -0700 (PDT)
Date:   Mon, 17 Jun 2019 05:13:30 -0700
From:   Olof Johansson <olof@lixom.net>
To:     Bjorn Andersson <bjorn.andersson@linaro.org>
Cc:     Andy Gross <agross@kernel.org>, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, arm@kernel.org,
        linux-arm-msm@vger.kernel.org
Subject: Re: [PATCH] MAINTAINERS: Change QCOM repo location
Message-ID: <20190617121330.k5xzl44rwqlnvdis@localhost>
References: <1559936691-15759-1-git-send-email-agross@kernel.org>
 <20190607195216.GY22737@tuxbook-pro>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190607195216.GY22737@tuxbook-pro>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 07, 2019 at 12:52:16PM -0700, Bjorn Andersson wrote:
> On Fri 07 Jun 12:44 PDT 2019, Andy Gross wrote:
> 
> > This patch updates the Qualcomm SoC repo to a new location.
> > 
> > Signed-off-by: Andy Gross <agross@kernel.org>
> 
> Reviewed-by: Bjorn Andersson <bjorn.andersson@linaro.org>

Applied to fixes, thanks!


-Olof
