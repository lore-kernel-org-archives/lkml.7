Return-Path: <SRS0=/s9R=UY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CB1D6C48BD6
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Jun 2019 22:50:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A16952086D
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Jun 2019 22:50:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="bsG0SS13"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726535AbfFYWuA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 25 Jun 2019 18:50:00 -0400
Received: from mail-lj1-f196.google.com ([209.85.208.196]:41225 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726422AbfFYWt7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Jun 2019 18:49:59 -0400
Received: by mail-lj1-f196.google.com with SMTP id 205so128624ljj.8
        for <linux-kernel@vger.kernel.org>; Tue, 25 Jun 2019 15:49:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:mail-followup-to:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=oauyc528nBeA4aGB8HdudXwgvOR2M6xqw+qp8qrMia0=;
        b=bsG0SS1331T2u5dmwMsWL5Mj0pDUYEJeS3x/a7g8HquS+iweixO7wS7VJSEpoTi3qV
         nuPog56Of0ICCYrDywtGn1ibAaoMzBfJ0O2x753kYh6mwxaLA6pPl0WPqys4+kmd46Jq
         rIsYCCZxCs33VBJGmf++ljLlMwhKk4609tQym+TGgY8G9VfxrtJCGVeYE5q5Nv/EWdBb
         9YomnEjSNUKKZybvNhj4bcSAi4lFZCDmKYmnbBUBMoRe0luDo7+NKcilgdxESGUr6Bv1
         8oE2HePy+PkGqZW4W/Q7dVoNdKg3qs2bj61g5enDhyYdyoeki0viAd/yTw4AoSrs8h9J
         Q3ug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id
         :mail-followup-to:references:mime-version:content-disposition
         :in-reply-to:user-agent;
        bh=oauyc528nBeA4aGB8HdudXwgvOR2M6xqw+qp8qrMia0=;
        b=dVT91AeTAlOBux+20wpH5BYR+Fbqy+zVUX/35oltK/eUNPoG2IUUyyjG07mNJfUrvt
         EW+15t2QJA7vAgvODsncNmt/nHk8eQV5LRy59LNgZSoLgDuUdsu7OWOJdYO6lyblhGTo
         c5ny5/mpR/LzXul8kB8tAGDOfbqRIq4I5XnT63fkT7fSgkWI2MH7YR2NlLdUUXGcdseL
         uHn/8s4SMBuzttmMTor+1ocomxW9rzuqhJ4q3/93wsA/XDNBQlYpqxF2s+Qk8ExLjTTo
         en9koiqu8eaBAS6drhcbeG6j8mYTXpd3/Q0m7FQ4Az2sTJcDiZDRS8a+CUNCLWizM+mb
         iXAg==
X-Gm-Message-State: APjAAAXW/CUXL+NosNqjhGjaEA/htxh1QWYMh6LSeMN8B8NfJMn8b6MF
        9cmbDRRQxwG1OAitM4CyLLdtiw==
X-Google-Smtp-Source: APXvYqzz8flqZD3CtlEaWTG6dgDQmMup6wovwU1fK+ijn1DOb2NtHpvpDzMqmApGLfzEkGldQTuXAg==
X-Received: by 2002:a2e:b0ea:: with SMTP id h10mr575866ljl.50.1561502997676;
        Tue, 25 Jun 2019 15:49:57 -0700 (PDT)
Received: from khorivan (59-201-94-178.pool.ukrtel.net. [178.94.201.59])
        by smtp.gmail.com with ESMTPSA id w1sm1580368lfe.50.2019.06.25.15.49.56
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 25 Jun 2019 15:49:57 -0700 (PDT)
Date:   Wed, 26 Jun 2019 01:49:54 +0300
From:   Ivan Khoronzhuk <ivan.khoronzhuk@linaro.org>
To:     Grygorii Strashko <grygorii.strashko@ti.com>
Cc:     netdev@vger.kernel.org,
        Ilias Apalodimas <ilias.apalodimas@linaro.org>,
        Andrew Lunn <andrew@lunn.ch>,
        "David S . Miller" <davem@davemloft.net>,
        Jiri Pirko <jiri@resnulli.us>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Sekhar Nori <nsekhar@ti.com>, linux-kernel@vger.kernel.org,
        linux-omap@vger.kernel.org, Murali Karicheri <m-karicheri2@ti.com>,
        Ivan Vecera <ivecera@redhat.com>,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org
Subject: Re: [RFC PATCH v4 net-next 10/11] ARM: dts: am57xx-idk: add dt nodes
 for new cpsw switch dev driver
Message-ID: <20190625224953.GD6485@khorivan>
Mail-Followup-To: Grygorii Strashko <grygorii.strashko@ti.com>,
        netdev@vger.kernel.org,
        Ilias Apalodimas <ilias.apalodimas@linaro.org>,
        Andrew Lunn <andrew@lunn.ch>,
        "David S . Miller" <davem@davemloft.net>,
        Jiri Pirko <jiri@resnulli.us>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Sekhar Nori <nsekhar@ti.com>, linux-kernel@vger.kernel.org,
        linux-omap@vger.kernel.org, Murali Karicheri <m-karicheri2@ti.com>,
        Ivan Vecera <ivecera@redhat.com>, Rob Herring <robh+dt@kernel.org>,
        devicetree@vger.kernel.org
References: <20190621181314.20778-1-grygorii.strashko@ti.com>
 <20190621181314.20778-11-grygorii.strashko@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20190621181314.20778-11-grygorii.strashko@ti.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 21, 2019 at 09:13:13PM +0300, Grygorii Strashko wrote:
>Add DT nodes for new cpsw switch dev driver.
>
>Signed-off-by: Grygorii Strashko <grygorii.strashko@ti.com>
>---
> arch/arm/boot/dts/am571x-idk.dts         | 28 +++++++++++++
> arch/arm/boot/dts/am572x-idk.dts         |  5 +++
> arch/arm/boot/dts/am574x-idk.dts         |  5 +++
> arch/arm/boot/dts/am57xx-idk-common.dtsi |  2 +-
> arch/arm/boot/dts/dra7-l4.dtsi           | 53 ++++++++++++++++++++++++
> 5 files changed, 92 insertions(+), 1 deletion(-)
>

[...]

>diff --git a/arch/arm/boot/dts/am57xx-idk-common.dtsi 
>b/arch/arm/boot/dts/am57xx-idk-common.dtsi
>index f7bd26458915..5c7663699efa 100644
>--- a/arch/arm/boot/dts/am57xx-idk-common.dtsi
>+++ b/arch/arm/boot/dts/am57xx-idk-common.dtsi
>@@ -367,7 +367,7 @@
> };
>
> &mac {
>-	status = "okay";
>+//	status = "okay";
?


-- 
Regards,
Ivan Khoronzhuk
