Return-Path: <SRS0=Qu8K=R7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9528AC43381
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Mar 2019 17:53:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 66F0520811
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Mar 2019 17:53:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1553795638;
	bh=+lMSHPltYVMTH95B3JFA/fn6+UgPUKtoFi0TaRoZOYw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=e2AiBsnnx2wuiKv/76l8c75pOhfQmQ3p3/ghJyaGSNxPxQc3YNSBX23EByY5OJrr5
	 fnwuKOUGknU6MFdJ1NXsl+jciXIQuoOYFRUQrCiT8xmuJes2DM2mTRowx/RrWsw4UJ
	 dbCfwwpgv2iISonhL4KN+0VSrrKcNq66sCUa9HEo=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727598AbfC1Rx5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Mar 2019 13:53:57 -0400
Received: from mail-ot1-f68.google.com ([209.85.210.68]:33506 "EHLO
        mail-ot1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725816AbfC1Rx4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Mar 2019 13:53:56 -0400
Received: by mail-ot1-f68.google.com with SMTP id j10so12714945otq.0;
        Thu, 28 Mar 2019 10:53:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=6n/BLjeSrSX5+Wdz7w8yF8Mllf/zk/nyB60gm0wRdxg=;
        b=h5M8N0YalHYYvG8gYdqIXO69aigl8I+yn4jjhfjANeLLk116YQVpwY0OJFfZYHZMec
         qubkK/D8Pyy0fxnDBW9X6510qedRlsaNfsTZDNACB2u+4jgjQ/O21GtAZ/HvtZaKa/pv
         XFWMr+JH2OGxQm5lyj3WLtJA5gTXHiOi7lz/joB3kvUoX8RZfOQRIlY2VBpE/LX6RO/0
         PX3sM6Y4H0FvV5KjgvLI8OeFwdukVJad0fnSWFjhBa+8+geB5rNUyN/1uar7n6hjYT2s
         NhuSL2Iwa7rURsIR5v9WzeeoZdliGx4kA3I+DmoVsG6IiuM24Wl3YizNhswTVJ/Pnte0
         tFoQ==
X-Gm-Message-State: APjAAAUlaJKrvuVFPZQPYV97zoAOgBjQoY4w/2ggYVzH9nf4DGLmExZ7
        3TH0O01bVS7ZOG0zgc477w==
X-Google-Smtp-Source: APXvYqwpBQZrgrT20ePkW2RMN82xxgdM082Fnhe+OBQqjgSkkF3ow1tYhfEcDFV8OMOuh9Aj5n/p1g==
X-Received: by 2002:a05:6830:154e:: with SMTP id l14mr29803191otp.269.1553795635828;
        Thu, 28 Mar 2019 10:53:55 -0700 (PDT)
Received: from localhost (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id b17sm6931215otq.26.2019.03.28.10.53.55
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 28 Mar 2019 10:53:55 -0700 (PDT)
Date:   Thu, 28 Mar 2019 12:53:54 -0500
From:   Rob Herring <robh@kernel.org>
To:     "Angus Ainslie (Purism)" <angus@akkea.ca>
Cc:     jic23@kernel.org, Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Mark Rutland <mark.rutland@arm.com>,
        "Angus Ainslie (Purism)" <angus@akkea.ca>,
        Tomas Novotny <tomas@novotny.cz>, linux-iio@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 5/5] dt-bindings: iio: light: add vcnl4040 devicetree
 bindings
Message-ID: <20190328175354.GA20681@bogus>
References: <20190321154047.23236-1-angus@akkea.ca>
 <20190321154047.23236-6-angus@akkea.ca>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190321154047.23236-6-angus@akkea.ca>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 21 Mar 2019 08:40:47 -0700, "Angus Ainslie (Purism)" wrote:
> Document the vishay VCNL4040 devicetree bindings.
> 
> Signed-off-by: Angus Ainslie (Purism) <angus@akkea.ca>
> ---
>  Documentation/devicetree/bindings/iio/light/vcnl4000.txt | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
> 

Reviewed-by: Rob Herring <robh@kernel.org>
