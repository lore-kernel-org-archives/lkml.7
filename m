Return-Path: <SRS0=fSNO=YI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C4282C10F14
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Oct 2019 19:41:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9982620663
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Oct 2019 19:41:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1571168469;
	bh=z1P4hhDL4+1VE6WqfcIYQq0WFMtwtAHaoatwohOpyaY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=d8s5Cwe0g87o+zAC0r1qDH9UbL/r2cKI3zaiXvypXNEptv0CRF8NTKmW3wJ1DVuhT
	 tmjsUU1jFFw70aH7JeaX9OD9ql6Uhp5ZbMKo58nDyRZijPN3d+7ON6upP+cwDp0+p+
	 AdDLlDsi8fwfNb9FRsOHrWzWQodpw4h2gBNb/hww=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732462AbfJOTlI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 15 Oct 2019 15:41:08 -0400
Received: from mail-oi1-f193.google.com ([209.85.167.193]:42186 "EHLO
        mail-oi1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727856AbfJOTlH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Oct 2019 15:41:07 -0400
Received: by mail-oi1-f193.google.com with SMTP id i185so17860309oif.9;
        Tue, 15 Oct 2019 12:41:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=dYr5YHDW3PpOfxrfTITzHIyYd4WqoilUYd2hAnALyj4=;
        b=LSZqEUWCFmaepVOFhBNPPE6MG7nAb5rAcPPSF3ZfroRIovkq2FfdRFq7OQW2/9UtaB
         HpytoOT7x1ts79e779/Vqsp/TUz9XeRwCzl/B+iymSSuAjyK+tooID1+XMebEuiTEsRN
         qGKaunqcBaTRi0hCWpdzz/r7nMO0X60EfwLIua5WnpECjIi4Pt/rbdwktFg85EchJBVb
         OsthpsT8Zqt5uKwZ1c1q94r/7aSc7c20Y3nVoNj/q+5tGjJVp3QA5549gPgg34bFxZH5
         6Lk2Ux3gZ5O/w7psHUf3zJtOwufBQyz/mCTLVkFS/5g6GtoYbGLVOpslLgFUIkaGqLju
         SSqg==
X-Gm-Message-State: APjAAAXQ5rzuYPeIS9Gr3P/6mWW/oJQapyCOb4ZUEIx9oeuRkeeBmsNb
        21hNSBAZuR1tJcarcUOjo3rhiU8=
X-Google-Smtp-Source: APXvYqx89oy1Ch87hKjVGrKdExTcjDGJBEM33RGUrBGSXq7zjricuAxlTAS2si4uuKG9LJragplpVA==
X-Received: by 2002:a05:6808:689:: with SMTP id k9mr220151oig.58.1571168466497;
        Tue, 15 Oct 2019 12:41:06 -0700 (PDT)
Received: from localhost (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id t17sm6633499otk.14.2019.10.15.12.41.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Oct 2019 12:41:05 -0700 (PDT)
Date:   Tue, 15 Oct 2019 14:41:05 -0500
From:   Rob Herring <robh@kernel.org>
To:     Navid Emamdoost <navid.emamdoost@gmail.com>
Cc:     emamd001@umn.edu, kjlu@umn.edu, smccaman@umn.edu,
        Navid Emamdoost <navid.emamdoost@gmail.com>,
        Frank Rowand <frowand.list@gmail.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] of: unittest: fix memory leak in unittest_data_add
Message-ID: <20191015194105.GA24758@bogus>
References: <20191004185847.14074-1-navid.emamdoost@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191004185847.14074-1-navid.emamdoost@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri,  4 Oct 2019 13:58:43 -0500, Navid Emamdoost wrote:
> In unittest_data_add, a copy buffer is created via kmemdup. This buffer
> is leaked if of_fdt_unflatten_tree fails. The release for the
> unittest_data buffer is added.
> 
> Fixes: b951f9dc7f25 ("Enabling OF selftest to run without machine's devicetree")
> Signed-off-by: Navid Emamdoost <navid.emamdoost@gmail.com>
> ---
>  drivers/of/unittest.c | 1 +
>  1 file changed, 1 insertion(+)
> 

Applied, thanks.

Rob
