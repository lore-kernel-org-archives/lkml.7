Return-Path: <SRS0=uOpN=TO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7BB2DC04AB4
	for <linux-kernel@archiver.kernel.org>; Tue, 14 May 2019 20:29:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4741820873
	for <linux-kernel@archiver.kernel.org>; Tue, 14 May 2019 20:29:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1557865772;
	bh=fbPcIuE4LpfXACLuNQZ/br1V8i83hANg4CTtYRdn12Q=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=gikmLiKPn/iHyyD0McFgsPpNAmDmWJpwGC83WJlleRfzqxkuI0R5ZVqdE1jwGyro+
	 P04k9KTvEwvLmXwDKofrm3vq1qHU7234NwtwP+HEGG/mnn4nVAn4hdNCMGu3ZD1HXR
	 r1j6dC3r9XyByq9gZ4QCtmba42q+3Rt/j9JQ1ocw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726380AbfENU3b (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 May 2019 16:29:31 -0400
Received: from mail-ot1-f67.google.com ([209.85.210.67]:42354 "EHLO
        mail-ot1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726036AbfENU3a (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 May 2019 16:29:30 -0400
Received: by mail-ot1-f67.google.com with SMTP id f23so109707otl.9;
        Tue, 14 May 2019 13:29:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=oPaY+Ss9+ep2GCkhb8u3t1B3H/GvEu2ypW66c2/qd9s=;
        b=gyJ/fWOEYB8Ki78+dj79xyZWtls6GDQy57l7Nmz0zem0/razc7TuHHlg4z5h4eKvhQ
         KbkSYIrCZ98dRT4a6hfSIffW6A2GnzybIV+Vsh9nJdmdbsPbJG8lHIp9g682qGVrGXDD
         fFD1oKpRROpclivzqRfJbJ7X/hL3J/rkZf2dSEEoDJ3/2IupnrPd06gnrCguDhR3Nqri
         nZ/qtB8WhDxhHGk1t8LjEVbuSpT8rJYUunpclggdnAZJxDezRWe6I4P5zs9+nkJY4rou
         8+61G0GDQjZ8glcP8AiWNZsjQ+aS/ZzoNOta4cqOG5lNgh50ZBqlnaPjsnu7n6F3cCXe
         0AwQ==
X-Gm-Message-State: APjAAAXLDq6V/F5fnzLtzxxgmSE8Nt0G1afv5JnW9YlVa/9rFS+xZOmb
        NLwQm/Lxq4nrS0vw9xPh1w==
X-Google-Smtp-Source: APXvYqzvuTeT7D9lZIqV3PwgDn5MJm1tKGPk0EO3gjy5o6D/bZ1ZmxMIWQbWUaiO3rbeleX4+VOgHQ==
X-Received: by 2002:a9d:7354:: with SMTP id l20mr23489464otk.115.1557865770039;
        Tue, 14 May 2019 13:29:30 -0700 (PDT)
Received: from localhost (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id b25sm2460790otq.65.2019.05.14.13.29.29
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 14 May 2019 13:29:29 -0700 (PDT)
Date:   Tue, 14 May 2019 15:29:28 -0500
From:   Rob Herring <robh@kernel.org>
To:     Paul Walmsley <paul.walmsley@sifive.com>
Cc:     robh+dt@kernel.org, linux-kernel@vger.kernel.org,
        linux-riscv@lists.infradead.org, devicetree@vger.kernel.org,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Paul Walmsley <paul@pwsan.com>,
        Palmer Dabbelt <palmer@sifive.com>,
        Megan Wachs <megan@sifive.com>,
        Wesley Terpstra <wesley@sifive.com>,
        Mark Rutland <mark.rutland@arm.com>
Subject: Re: [PATCH v2] dt-bindings: sifive: describe sifive-blocks versioning
Message-ID: <20190514202928.GA23497@bogus>
References: <20190513215152.26578-1-paul.walmsley@sifive.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190513215152.26578-1-paul.walmsley@sifive.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 13 May 2019 14:51:53 -0700, Paul Walmsley wrote:
> For IP blocks that are generated from the public, open-source
> sifive-blocks repository, describe the version numbering policy
> that its maintainers intend to use, upon request from Rob
> Herring <robh@kernel.org>.
> 
> Signed-off-by: Paul Walmsley <paul.walmsley@sifive.com>
> Signed-off-by: Paul Walmsley <paul@pwsan.com>
> Reviewed-by: Palmer Dabbelt <palmer@sifive.com>
> Cc: Rob Herring <robh+dt@kernel.org>
> Cc: Palmer Dabbelt <palmer@sifive.com>
> Cc: Megan Wachs <megan@sifive.com>
> Cc: Wesley Terpstra <wesley@sifive.com>
> Cc: Mark Rutland <mark.rutland@arm.com>
> Cc: devicetree@vger.kernel.org
> Cc: linux-riscv@lists.infradead.org
> Cc: linux-kernel@vger.kernel.org
> ---
> 
> This second version updates the example URL, requested by
> Rob Herring <robh+dt@kernel.org>.
> 
>  .../sifive/sifive-blocks-ip-versioning.txt    | 38 +++++++++++++++++++
>  1 file changed, 38 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/sifive/sifive-blocks-ip-versioning.txt
> 

Applied, thanks.

Rob
