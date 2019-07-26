Return-Path: <SRS0=vtn1=VX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 01C9DC7618F
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Jul 2019 18:11:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C776A22BE8
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Jul 2019 18:11:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="P+qVIFcu"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729153AbfGZSLN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 26 Jul 2019 14:11:13 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:35921 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725899AbfGZSLN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Jul 2019 14:11:13 -0400
Received: by mail-wr1-f67.google.com with SMTP id n4so55406582wrs.3;
        Fri, 26 Jul 2019 11:11:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=H4OkvprGWkQxdepZxoo091W8o8XKsTc4NaiAP0lwajo=;
        b=P+qVIFcunWopdw0py0JC+0ltz77IaW3kQ7vZCM5O1HtBUI4eHOLn/h0g0Acig7mVJg
         hG/ELhLwgnxJOgMW0iJRTt3WLfT7JPAeMPur3xSGbIjvtRRC5sJdhx9v+nXsYNXXfCF7
         r6FrGauxyBtbsTQduYEt1YWhJPX+8JR001YJZKvueW7gsjk+NtzBSvUSyKm8ppIVG00d
         y50VncWrZX4//8zU2lVjFygIf8MSxy4qnaK8iR/4S5DlOrsYhBdzonBrBbDHRFHpfu/u
         3ftQsxIWQo5vtweHOqU4yKQcDo41gJFEkRipUkl9dNjO/Gcbn1NwQQC3rSQATXOBSHTR
         AeDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=H4OkvprGWkQxdepZxoo091W8o8XKsTc4NaiAP0lwajo=;
        b=oaLgw8cCdh83KA794tLTJCPMEzePmUHLqU28BXZ/x6435wSr3rI/pyR7akAueRVSGf
         OCbr9r54XFYAsj7qYw6GAie2cMSpwsVPo0gwNdjpNe/FJvj7ojIq/zf62ZTILQwN9K+u
         5TRAS1gKbI8dsq5HTCETH6wU8RVZjfeHAAyNXw6nRyRO3KfCBs3oIAOxC4A9IKALIPD2
         MvzBo8/Wpmx3X8rRrGNT4Onu1x1wWhaqsaezur76XDL9uLRwWJ7kzlaavwLJvC+qw/Yp
         /w/Pna+K7ZzVyWU9om7N4UdPDNds1gnOYfb+vFtrFw0k8b+TVtcUFSJVsjmkjvk9S1YF
         yK9g==
X-Gm-Message-State: APjAAAWOOmmuWQ5p+o2YCtmINLpnI6MXpImNV4m4CeRdSxy5DXUGAxxB
        YfE8BZfAR1xR4oVfbf2vuj8=
X-Google-Smtp-Source: APXvYqyTfwjMyqVr91cyDtNh35kpDAk49UxPpISuR1aXbfmeauE2uUNVKz29hKbbTI65LWnh0RsAMg==
X-Received: by 2002:a5d:564e:: with SMTP id j14mr100454046wrw.1.1564164671398;
        Fri, 26 Jul 2019 11:11:11 -0700 (PDT)
Received: from Red ([2a01:cb1d:147:7200:2e56:dcff:fed2:c6d6])
        by smtp.googlemail.com with ESMTPSA id u2sm46006939wmc.3.2019.07.26.11.11.10
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 26 Jul 2019 11:11:10 -0700 (PDT)
Date:   Fri, 26 Jul 2019 20:11:08 +0200
From:   Corentin Labbe <clabbe.montjoie@gmail.com>
To:     robh+dt@kernel.org, mark.rutland@arm.com,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: How to add multiple example with conflicting includes
Message-ID: <20190726181108.GA17767@Red>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello

When I try to check the following examples of a devicetree schema:
examples:                                                                       
  - |                                                                           
    #include <dt-bindings/interrupt-controller/arm-gic.h>                       
    #include <dt-bindings/clock/sun50i-a64-ccu.h>                               
    #include <dt-bindings/reset/sun50i-a64-ccu.h>                               
                                                                                
    crypto: crypto@1c15000 {                                                    
      compatible = "allwinner,sun8i-h3-crypto";                                 
      reg = <0x01c15000 0x1000>;                                                
      interrupts = <GIC_SPI 94 IRQ_TYPE_LEVEL_HIGH>;                            
      clocks = <&ccu CLK_BUS_CE>, <&ccu CLK_CE>;                                
      clock-names = "ahb", "mod";                                               
      resets = <&ccu RST_BUS_CE>;                                               
      reset-names = "ahb";                                                      
    };                                                                          
                                                                                
  - |                                                                           
    #include <dt-bindings/interrupt-controller/arm-gic.h>                       
    #include <dt-bindings/clock/sun50i-h6-ccu.h>                                
    #include <dt-bindings/reset/sun50i-h6-ccu.h>                                
                                                                                
    crypto: crypto@1904000 {                                                    
      compatible = "allwinner,sun50i-h6-crypto";                                
      reg = <0x01904000 0x1000>;                                                
      interrupts = <GIC_SPI 87 IRQ_TYPE_LEVEL_HIGH>;                            
      clocks = <&ccu CLK_BUS_CE>, <&ccu CLK_CE>, <&ccu CLK_MBUS_CE>;            
      clock-names = "ahb", "mod", "mbus";                                       
      resets = <&ccu RST_BUS_CE>;                                               
      reset-names = "ahb";                                                      
    };

I get:
In file included from Documentation/devicetree/bindings/crypto/allwinner,sun8i-ce.example.dts:42:
/linux-next/scripts/dtc/include-prefixes/dt-bindings/clock/sun50i-h6-ccu.h:9: warning: "CLK_PLL_PERIPH0" redefined
 #define CLK_PLL_PERIPH0  3
[...]

So how can I add multiple examples which need somes conflicting #include to be validated.

Thanks
Regards
