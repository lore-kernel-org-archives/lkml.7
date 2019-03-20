Return-Path: <SRS0=4Jrr=RX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3AC27C4360F
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Mar 2019 20:04:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0F2DA21841
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Mar 2019 20:04:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lca.pw header.i=@lca.pw header.b="HPpQBz/C"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726830AbfCTUEf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Mar 2019 16:04:35 -0400
Received: from mail-qk1-f196.google.com ([209.85.222.196]:33366 "EHLO
        mail-qk1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726023AbfCTUEf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Mar 2019 16:04:35 -0400
Received: by mail-qk1-f196.google.com with SMTP id k189so9699185qkc.0
        for <linux-kernel@vger.kernel.org>; Wed, 20 Mar 2019 13:04:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lca.pw; s=google;
        h=message-id:subject:from:to:cc:date:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Vo6r5RiuoHQQbBcC9iguZtdqZ6ajLyJa96gCdeOiWbE=;
        b=HPpQBz/CvqsFaa0YHkIdIWC9iwfw02s4wfgNx/cLGOHj1a5FGWAnDDpEotjpjx0NSL
         F0gyFf/ieAD253cjGeiAI+MkOvyvKxGe61VtSSWQyyRJBaP7ihSFnE/JoVW2e+vyFmJ/
         oOS7inR6aNpv0mA8RAyeReJDsdd38nUMURgiM9zWeRT4BPqOg5Djdld7zvw2Y8Eov+n7
         /YZmRaOdN3FdNQJFu/QU8RFIhdswP6VC6E+Es8DpHWFEFDgpkO5rN/P+p1FBRmPnU30m
         WYfL0DDwwyVAavff0M6gTimy98fqUaF3Rinq/8q+m+aNdLDaewlmpV8kawsjV23Vwx7s
         G2Fg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Vo6r5RiuoHQQbBcC9iguZtdqZ6ajLyJa96gCdeOiWbE=;
        b=mAL2sDOzox3titmeQ2JQrrkf5WWPj6Ad79j00U8mhp3D1rx+sgGOjPQUJLI/uum1d3
         plS5zTN1NWzrW1GOFWNXeFQiOajh1Np6VDhRWTbZghNVpoynBQsFmt7VVC99lUVasF6y
         Nh/LFSaZ+mlUmGYnPgFzeK1LfworjqYXwSetYgPy9IRPMYVGAqwmdSE2bW3Nl85mB110
         Lbht8AIbAY/ZI+ODuaUHlOlbsixC/PfvpWu+YpOC/GvM7s4lCNtQMObQnBIFU9k4NpN3
         s4JjgoHZdOD2uQ6suOgOIPNYbaxShrP8cRqh2NIqvJ9m1WF8jTgT6crK0t6Uw6x6/jXc
         UX5w==
X-Gm-Message-State: APjAAAWTj7zp+iwPwlKbg9skZpI9FdVi5qx5ia1NC/AFh8ye4143qnO7
        5UOvmN8vio5JWm/GcAI0Gwrf3w==
X-Google-Smtp-Source: APXvYqyNcoCpTrG/QlxBIiS3xOXvYOWD0i6x08P3+8eR8pgFrkDCEqYQr79GX02pD2JjjO+rwwfWzA==
X-Received: by 2002:a37:4d52:: with SMTP id a79mr8186639qkb.75.1553112274192;
        Wed, 20 Mar 2019 13:04:34 -0700 (PDT)
Received: from dhcp-41-57.bos.redhat.com (nat-pool-bos-t.redhat.com. [66.187.233.206])
        by smtp.gmail.com with ESMTPSA id h24sm2225964qte.50.2019.03.20.13.04.32
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 20 Mar 2019 13:04:33 -0700 (PDT)
Message-ID: <1553112272.26196.9.camel@lca.pw>
Subject: Re: [PATCH v2] kmemleak: skip scanning holes in the .bss section
From:   Qian Cai <cai@lca.pw>
To:     Catalin Marinas <catalin.marinas@arm.com>,
        Michael Ellerman <mpe@ellerman.id.au>
Cc:     akpm@linux-foundation.org, paulus@ozlabs.org,
        benh@kernel.crashing.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, kvm-ppc@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org
Date:   Wed, 20 Mar 2019 16:04:32 -0400
In-Reply-To: <20190320181656.GB38229@arrakis.emea.arm.com>
References: <20190313145717.46369-1-cai@lca.pw>
         <20190319115747.GB59586@arrakis.emea.arm.com>
         <87lg19y9dp.fsf@concordia.ellerman.id.au>
         <20190320181656.GB38229@arrakis.emea.arm.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.22.6 (3.22.6-10.el7) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2019-03-20 at 18:16 +0000, Catalin Marinas wrote:
> I think I have a simpler idea. Kmemleak allows punching holes in
> allocated objects, so just turn the data/bss sections into dedicated
> kmemleak objects. This happens when kmemleak is initialised, before the
> initcalls are invoked. The kvm_free_tmp() would just free the
> corresponding part of the bss.
> 
> Patch below, only tested briefly on arm64. Qian, could you give it a try
> on powerpc? Thanks.

It works great so far!
