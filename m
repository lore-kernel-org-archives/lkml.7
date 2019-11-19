Return-Path: <SRS0=UImc=ZL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 73328C432C0
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Nov 2019 23:14:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4633D222AB
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Nov 2019 23:14:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=netronome-com.20150623.gappssmtp.com header.i=@netronome-com.20150623.gappssmtp.com header.b="yeBek2H2"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727491AbfKSXOH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Nov 2019 18:14:07 -0500
Received: from mail-lf1-f66.google.com ([209.85.167.66]:42889 "EHLO
        mail-lf1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727217AbfKSXOG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Nov 2019 18:14:06 -0500
Received: by mail-lf1-f66.google.com with SMTP id z12so18525853lfj.9
        for <linux-kernel@vger.kernel.org>; Tue, 19 Nov 2019 15:14:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=netronome-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:in-reply-to:references
         :organization:mime-version:content-transfer-encoding;
        bh=ir9irrJOMESWTUpMxjgf2j9zIILW0SvYAjvCo24hEOs=;
        b=yeBek2H2Lh83q24+IC9sstjDwUdjPe0Hy/cFCn/aNxEVZlaiEHBievvhaiiTqAJldO
         CnnDU1mg6MMoN3A/s/fPb/GLq3/y5I/auK5FCTyJf0i8HcEPGpuv3hFklYLZr6Hyb2O8
         bNw4GkI3ToqfAdiHBgz8IKnGZegIRB7kfjovriwWYyUqJDSSoptTt7c6ZWOwm9dbAeF7
         UR1eFdlf8N1u5sMvmOfbBEw39e89tEgoYakysAJhWPPuVfDjOnNsCpsVTn0aMBNSut8b
         RAFwc2GMonc3dBRheCWXUZ17OEzmJEe8qn1X6woO36L958QLne82o4jSxPqCaMdlhbsT
         K2dA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:in-reply-to
         :references:organization:mime-version:content-transfer-encoding;
        bh=ir9irrJOMESWTUpMxjgf2j9zIILW0SvYAjvCo24hEOs=;
        b=DywB1576TlVWBRkojqFfELfRJuSiYsoX55zMDOJ9do1AmI1k1XOxMPreYhkmrbG2vB
         jbNziCxnTDVVPhjt9ENh1bKmWb2nEtfSalKbMUlHnv2nQb1kXFYMuTx92U/jVyJMDNVw
         hsbOh7Qgfa9QaoXcbxOp3dTUC+taZG7LjWHtLGrQCCWyRXe73/uetm8bRC5TyN9Phv3m
         cipKWiwpv7aONmIIU7cdd0KrQ3DOVzUsapd+CGjv9/dHLVkLDGEadL7q9flwMILa+6nU
         s5DBlif2ZJDwEmQI3aBzpHKQNGEtTwGNhEp1UXk2ntlBHjVinxesNLTPR+bLOfth4ikq
         4k4w==
X-Gm-Message-State: APjAAAWnBmisUuSNHl+lRbuRYKKFjNmnqy8G1LHSPWDmfaF/Y5yVVZi+
        JSa3ALavyMmjU9ztPK+tTGZhow==
X-Google-Smtp-Source: APXvYqwHOzNI1rbF48ly4PEH2Jq0GjpAfNRQf0Gr/4kPUrdNNRFtGVbwH61ArBAzhhCUQUNgcrAfqQ==
X-Received: by 2002:a19:7d06:: with SMTP id y6mr151844lfc.120.1574205244690;
        Tue, 19 Nov 2019 15:14:04 -0800 (PST)
Received: from cakuba.netronome.com ([66.60.152.14])
        by smtp.gmail.com with ESMTPSA id i190sm13837624lfi.45.2019.11.19.15.14.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Nov 2019 15:14:04 -0800 (PST)
Date:   Tue, 19 Nov 2019 15:13:50 -0800
From:   Jakub Kicinski <jakub.kicinski@netronome.com>
To:     Grygorii Strashko <grygorii.strashko@ti.com>
Cc:     <netdev@vger.kernel.org>,
        Ilias Apalodimas <ilias.apalodimas@linaro.org>,
        Andrew Lunn <andrew@lunn.ch>,
        "David S . Miller" <davem@davemloft.net>,
        Ivan Khoronzhuk <ivan.khoronzhuk@linaro.org>,
        Jiri Pirko <jiri@resnulli.us>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Sekhar Nori <nsekhar@ti.com>, <linux-kernel@vger.kernel.org>,
        <linux-omap@vger.kernel.org>,
        Murali Karicheri <m-karicheri2@ti.com>,
        Ivan Vecera <ivecera@redhat.com>,
        Rob Herring <robh+dt@kernel.org>, <devicetree@vger.kernel.org>
Subject: Re: [PATCH v7 net-next 10/13] Documentation: networking: add cpsw
 switchdev based driver documentation
Message-ID: <20191119151350.75c72c40@cakuba.netronome.com>
In-Reply-To: <20191119221925.28426-11-grygorii.strashko@ti.com>
References: <20191119221925.28426-1-grygorii.strashko@ti.com>
        <20191119221925.28426-11-grygorii.strashko@ti.com>
Organization: Netronome Systems, Ltd.
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 20 Nov 2019 00:19:22 +0200, Grygorii Strashko wrote:
> diff --git a/Documentation/networking/devlink-params-ti-cpsw-switch.txt b/Documentation/networking/devlink-params-ti-cpsw-switch.txt
> new file mode 100644
> index 000000000000..4037458499f7
> --- /dev/null
> +++ b/Documentation/networking/devlink-params-ti-cpsw-switch.txt
> @@ -0,0 +1,10 @@
> +ale_bypass	[DEVICE, DRIVER-SPECIFIC]
> +		Allows to enable ALE_CONTROL(4).BYPASS mode for debug purposes.
> +		All packets will be sent to the Host port only if enabled.
> +		Type: bool
> +		Configuration mode: runtime
> +
> +switch_mode	[DEVICE, DRIVER-SPECIFIC]
> +		Enable switch mode
> +		Type: bool
> +		Configuration mode: runtime

Ah, you got it here, sorry :)
