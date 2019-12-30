Return-Path: <SRS0=E66v=2U=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 481B9C2D0D3
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Dec 2019 15:35:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1D91820663
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Dec 2019 15:35:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1577720131;
	bh=S6z6M6zmJEI3nMJs7Q9Po1GayFr4iPBjeKO0Rk+zr8s=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=AwvpT87keYE+nrowt5+jp6PrpoYF+kXWJIye4e1z8w98B+qpJhtRGjM9OdVgqDbtf
	 oXd2uqXH65wzH0KroBKfZeu/7aiFpx2+GviF1MJoO0UF13ErhGFarH31BGhtSdBgB+
	 VR4xFPRendrFOu1FUhUy8ZDcnlUqHpJp5vlkiKzw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727630AbfL3Pfa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 30 Dec 2019 10:35:30 -0500
Received: from mail-ed1-f65.google.com ([209.85.208.65]:44819 "EHLO
        mail-ed1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727545AbfL3Pf3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Dec 2019 10:35:29 -0500
Received: by mail-ed1-f65.google.com with SMTP id bx28so32873929edb.11;
        Mon, 30 Dec 2019 07:35:28 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=ozB2LjDdmJTikMrKED+hWYBd54PpqOChciXJdErHTK0=;
        b=tMQKvvK4KXyQasKP29bQ5jnBCOBBMuH8W2Gs7WSNa1RUP9HhrenZonFmfptMi1uaqo
         aPqHJJqxIwdZZxcZ5cZZcoe+6qggbcby9/vgUDVACVdiz3G8AbZ3tM9r9UyDIrB+jfGt
         SQuMTf8RszcNp68EdncKoUv2u1j45l+qWClffOtvcOFS5B/9YlxCwCPT35JUFtRqOG9R
         u40hu9IkiltDVfebVfL1dkG6+6XMUuNEvVLz23SAmy57m2gnKbllDVxFvxOzgjUA0UdP
         mrcQm0PQppPZOMVli5Re6HCQVpTJaBnD24hM7+5cGal5BBxoiYwc9/sW0Cav0Ow2aSLU
         w2FQ==
X-Gm-Message-State: APjAAAXMyHInuMTT3l0aYuUqBj/4ZEm20s9wQ9810IcQQqYuXJwkbgrY
        LvjXinmktCMOI4S4lpSG6PI=
X-Google-Smtp-Source: APXvYqy7tLghMLXWt9n3EAx0fpcKuStw4S0B+WjKZ72DH9jAjvfKoRptKpBc7vrRrhRpmdcx4KxmvQ==
X-Received: by 2002:a17:906:a48:: with SMTP id x8mr72252035ejf.188.1577720127888;
        Mon, 30 Dec 2019 07:35:27 -0800 (PST)
Received: from pi3 ([194.230.155.138])
        by smtp.googlemail.com with ESMTPSA id qk16sm5661120ejb.71.2019.12.30.07.35.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Dec 2019 07:35:27 -0800 (PST)
Date:   Mon, 30 Dec 2019 16:35:24 +0100
From:   Krzysztof Kozlowski <krzk@kernel.org>
To:     Benjamin Gaignard <benjamin.gaignard@st.com>
Cc:     gregkh@linuxfoundation.org, robh+dt@kernel.org,
        mark.rutland@arm.com, kgene@kernel.org, hminas@synopsys.com,
        linux-usb@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, m.szyprowski@samsung.com,
        amelie.delaunay@st.com
Subject: Re: [PATCH v2 1/2] dt-bindings: usb: Convert DWC2 bindings to
 json-schema
Message-ID: <20191230153524.GA4918@pi3>
References: <20191219103536.25485-1-benjamin.gaignard@st.com>
 <20191219103536.25485-2-benjamin.gaignard@st.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20191219103536.25485-2-benjamin.gaignard@st.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 19, 2019 at 11:35:35AM +0100, Benjamin Gaignard wrote:
> Convert DWC2 bindings to DT schema format using json-schema.
> DWC2 is widely use but a couple of compatibles and properties
> (vusb_d-supply,vusb_a-supply) were missing in dwc2.txt, the
> patch add them.
> 
> Signed-off-by: Benjamin Gaignard <benjamin.gaignard@st.com>
> ---
> CC: Minas Harutyunyan <hminas@synopsys.com>
> 
> changes in version 2:
> - put Minas Harutyunyan <hminas@synopsys.com> as maintainer
> - remove type and description from phy property
> - remove description from compatible items
> - simplify samsung,s3c6400-hsotg compatible handling
> 

(...)

> +required:
> +  - compatible
> +  - reg
> +  - interrupts
> +  - clocks
> +  - clock-names
> +
> +additionalProperties: false
> +
> +examples:
> +  - |
> +      usb@101c0000 {
> +        compatible = "ralink,rt3050-usb, snps,dwc2";

Does it pass dtbs_check? Should be two strings.

Best regards,
Krzysztof


