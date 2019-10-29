Return-Path: <SRS0=sYEh=YW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 58F7CCA9EC2
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Oct 2019 01:28:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2295D217D6
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Oct 2019 01:28:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1572312517;
	bh=kf3nWynmMPwd5Kn7fRD6mrWzG8tGwrw4NiL+PvbU1cw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=1RvxA+WdDFsZ4I9yXL4ueZRsOu6vwKArAV83Av3kT5FhkXLzsFL45KkEywTkMYwgZ
	 7wpeEyjO4UVbzVX4ys+yjrooVX0OUqxxem378LdD0TprpwFuyiwUvM2jPpalMMcm5i
	 6Tand4W+v/JBRV8Yk8hzEk5gyinB6oqaWVtGTD8s=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729402AbfJ2B2g (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 28 Oct 2019 21:28:36 -0400
Received: from mail-ot1-f65.google.com ([209.85.210.65]:37435 "EHLO
        mail-ot1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727105AbfJ2B2f (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Oct 2019 21:28:35 -0400
Received: by mail-ot1-f65.google.com with SMTP id 53so8391049otv.4;
        Mon, 28 Oct 2019 18:28:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:content-language
         :user-agent;
        bh=cWrvWn8Y91l+c7IEvz9znxcUVNNalwZ3gCeDldbn6zc=;
        b=ZPdV7HhtLrhns/UIodWSS6AtjAYOh67yqF0dsDE+r9VSXRhvrm3mHTETXDFWv+UEBa
         3Un0hCx+nc85ra8x754Lnv4l8k6fkkV02xDBmRS4BwHMPnwjn3tV4wY4GT7vuRwWJIWu
         X6sNXeaRO742Vy+nH3TbcN8JqkAuZPFaPpIxgBqNcQnBzk9z59HnENdW2s+7rVtJo61S
         4xU+ztMv2A5m8uLOI4NwMTYHPqvR51Fsjxp0QFYxYd3Z3ed/PHlXp6MmJP099MRbPXXk
         mmOKb7oEpX1/JJ3wO2QPqxQ9RsW8XE6jLzq/5rrWW1O/uNzK+ztTwLH12c5pTUn5AD6t
         oFRw==
X-Gm-Message-State: APjAAAXV1pTrrLwZ8gshQvKJmSc7H7mrLPHOQ3cqnscH+iVWvcDI4ME+
        Fq/OY8AEUHII7TlCJMHsPg==
X-Google-Smtp-Source: APXvYqx/qWeuJOYHGzHcAW6FJgzRbIPnGaTEit59gTkSVs0ikX5OC7nFRR49y0TGPaojT6ks9ngXPw==
X-Received: by 2002:a9d:654f:: with SMTP id q15mr16024046otl.327.1572312514758;
        Mon, 28 Oct 2019 18:28:34 -0700 (PDT)
Received: from localhost (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id c7sm3100109otr.32.2019.10.28.18.28.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Oct 2019 18:28:34 -0700 (PDT)
Date:   Mon, 28 Oct 2019 20:28:33 -0500
From:   Rob Herring <robh@kernel.org>
To:     Schrempf Frieder <frieder.schrempf@kontron.de>
Cc:     "krzk@kernel.org" <krzk@kernel.org>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        Shawn Guo <shawnguo@kernel.org>, Rob Herring <robh@kernel.org>,
        Andrey Smirnov <andrew.smirnov@gmail.com>,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        Aisheng Dong <aisheng.dong@nxp.com>,
        Schrempf Frieder <frieder.schrempf@kontron.de>,
        Mark Rutland <mark.rutland@arm.com>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 09/10] dt-bindings: arm: fsl: Add more Kontron
 i.MX6UL/ULL  compatibles
Message-ID: <20191029012833.GA26851@bogus>
References: <20191016150622.21753-1-frieder.schrempf@kontron.de>
 <20191016150622.21753-10-frieder.schrempf@kontron.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191016150622.21753-10-frieder.schrempf@kontron.de>
Content-Language: en-US
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 16 Oct 2019 15:07:36 +0000, Schrempf Frieder wrote:
> 
> From: Frieder Schrempf <frieder.schrempf@kontron.de>
> 
> Add the compatibles for Kontron i.MX6UL N6311 SoM and boards and
> the compatibles for Kontron i.MX6ULL N6411 SoM and boards.
> 
> Signed-off-by: Frieder Schrempf <frieder.schrempf@kontron.de>
> ---
>  Documentation/devicetree/bindings/arm/fsl.yaml | 14 ++++++++++++++
>  1 file changed, 14 insertions(+)
> 

Reviewed-by: Rob Herring <robh@kernel.org>
