Return-Path: <SRS0=Q+aa=S3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3F6E9C43219
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Apr 2019 19:54:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4DCA9205ED
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Apr 2019 19:54:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1556222088;
	bh=Pl3KRH7VInbxrO8uYz+jEBMgCPNnMk1geK6gKgelgKU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=RhuAfYD4I1T4/wqaZ0q6JrKPk2z8E3Qp9egnm0cAFg91A8uDoo4v4AXm24dH0EJaZ
	 6ifJsVu/0Un1Hk1zhP/IeU5Klt0bLcyjs2b1s1TpHdWyfAVQtYC+Z1DpLPDai8vb0F
	 KYh7d0qaMpn+R6S18YtDOtaIcQRhiAWVCdAD6BmI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387874AbfDYTyr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Apr 2019 15:54:47 -0400
Received: from mail-ot1-f66.google.com ([209.85.210.66]:39487 "EHLO
        mail-ot1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730591AbfDYTxk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Apr 2019 15:53:40 -0400
Received: by mail-ot1-f66.google.com with SMTP id o39so620676ota.6;
        Thu, 25 Apr 2019 12:53:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=zE5Gd4ft9rdSP47E/LFXWYswBNZdqjM+dx9bGw2h70c=;
        b=orIUGEif0lhyDbvMgTPx40EdY+TsRV5hylw2NGI5tomZ/OISUrHxJa94lsaFYDRusu
         Iw+Ml3vjmRgvPd0BKaTu67oR3AM1YIh6MRW0V9qtNK0TVMEEInbt6psigXj6u8/9xAmm
         fXNAVNZSCSVMY/IPA2oMJfRTz6JZE96fc+AdZWySWHY/pgKgJ5o7EXS8NmoEOBKJ09cP
         v3bAvgT7gXKyVMhfVae0RFAtGZh2wSl3oF8AljzEJeKdw7IZ2Jovqgexpg8rB9/D5c+B
         lI4bGd7g9cqeBIlIueOsS69u0O6jVXCLQx+9GWYmwyNuFvq69KmIo/28aFcGkxag9pfG
         LUuA==
X-Gm-Message-State: APjAAAVTz4RvtFWorz4CBXBZSRIxrJkh7LAs6xRFUANbvCRaZhDbcVZ8
        XMvAzNYdQH2AfyYxVYcqmA==
X-Google-Smtp-Source: APXvYqwoVeug23cDOCxEhva3udFUalj88AYGdwKFiYrlXf2kNiCqC6wQaGAiS18gfPt56uzq1ve8Ig==
X-Received: by 2002:a9d:70cf:: with SMTP id w15mr25285770otj.304.1556222019474;
        Thu, 25 Apr 2019 12:53:39 -0700 (PDT)
Received: from localhost (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id i19sm9802054otj.74.2019.04.25.12.53.38
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 25 Apr 2019 12:53:38 -0700 (PDT)
Date:   Thu, 25 Apr 2019 14:53:38 -0500
From:   Rob Herring <robh@kernel.org>
To:     Lukasz Luba <l.luba@partner.samsung.com>
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org, linux-samsung-soc@vger.kernel.org,
        b.zolnierkie@samsung.com, krzk@kernel.org, kgene@kernel.org,
        cw00.choi@samsung.com, kyungmin.park@samsung.com,
        m.szyprowski@samsung.com, s.nawrocki@samsung.com,
        myungjoo.ham@samsung.com, keescook@chromium.org, tony@atomide.com,
        jroedel@suse.de, treding@nvidia.com, digetx@gmail.com,
        willy.mh.wolff.ml@gmail.com
Subject: Re: [PATCH v6 04/10] Documentation: dt: device tree bindings for
 LPDDR3 memories
Message-ID: <20190425195338.GB31128@bogus>
References: <1555683568-20882-1-git-send-email-l.luba@partner.samsung.com>
 <CGME20190419141945eucas1p1c95d65f261f82da5c856c0f2fcf1ce87@eucas1p1.samsung.com>
 <1555683568-20882-5-git-send-email-l.luba@partner.samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1555683568-20882-5-git-send-email-l.luba@partner.samsung.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 19, 2019 at 04:19:22PM +0200, Lukasz Luba wrote:
> The device tree bindings for LPDDR3 SDRAM memories.

Also, 'dt-bindings: ddr: ' for the subject. You've got a mixture of 
subjects with no consistency.

> 
> For specifying the AC timing parameters of the memory device
> the 'lpddr3' binding uses binding 'lpddr2-timings'.
> 
> Signed-off-by: Lukasz Luba <l.luba@partner.samsung.com>
