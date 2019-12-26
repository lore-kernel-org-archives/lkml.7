Return-Path: <SRS0=rArk=2Q=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3F958C2D0DC
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Dec 2019 19:19:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1995320882
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Dec 2019 19:19:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1577387986;
	bh=Brl7Oo2pJ3vPeukDemfVI1JG5nTIOneZws90P7czKb4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=rh0jcnFbsK73tXvlof3DEefISHka8tDApcXzxj9CHFw1qAqJFc00ptAt2iGbUU2+o
	 41sk9byk3jUpZcOkTrcPbtkQC5lKdlh872Q0A75HFRTXK1l8eOUm03T9Qw7KVX0JI2
	 8xN+QVIyESX2FmnRMVzTRsmbY4B9611W+aZK8PMI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726933AbfLZTTp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 26 Dec 2019 14:19:45 -0500
Received: from mail-il1-f193.google.com ([209.85.166.193]:33380 "EHLO
        mail-il1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726653AbfLZTTo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Dec 2019 14:19:44 -0500
Received: by mail-il1-f193.google.com with SMTP id v15so20858540iln.0;
        Thu, 26 Dec 2019 11:19:44 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=AqWJxAJe8Vgf4p53OHB9TkZmIbkYP+Pma79n+C2GBLc=;
        b=bDbDPtaP+xY9RLPc7KU18sTMx141o5XL8ErAaaSqcla1z9nqc2XgOnBMHSd/dJ5GGq
         l2eH3HuKbqd17ZYJXL0SvscAQMsAlsI6n2Up1G7rh5Pl5XUcHT3mDRy3w1a9iPpWO/As
         FuhAPG011b1wdHXsZ4h3cxU4XaPEGoe4S5KCZ+jiUiPKNdq6jBVNmc1wYqffLHwxYCNY
         4eNaK7wrrT2GS9s3Ywa1MFIwKFc6/s6/ug4gRVLNlvdRrUsN16l2RIsydpWPwVwse1Sn
         2sffWOrRI79MwlEpW6vRKT3dlC++ypQZ5sXN3ozZKscBBendEdfds3g0fKrCGOhA36gF
         8Ohg==
X-Gm-Message-State: APjAAAUaZ/fChmXffgwYCqEoF3eWl5eB3MihNoZW4u0ekdGsB9VRysms
        +AVkpe5MAzxV49+iBRAoBQ==
X-Google-Smtp-Source: APXvYqzB6YGqCYlO6/M0ZHv5gof0FiLkRfYe1t/A15ZE+3JvhhyuAj2WMHUSJkh5iVeABFNEK6ImJg==
X-Received: by 2002:a92:5a56:: with SMTP id o83mr37720479ilb.97.1577387984062;
        Thu, 26 Dec 2019 11:19:44 -0800 (PST)
Received: from localhost ([64.188.179.250])
        by smtp.gmail.com with ESMTPSA id m24sm8871530ioc.37.2019.12.26.11.19.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Dec 2019 11:19:43 -0800 (PST)
Date:   Thu, 26 Dec 2019 12:19:42 -0700
From:   Rob Herring <robh@kernel.org>
To:     Qianggui Song <qianggui.song@amlogic.com>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Jason Cooper <jason@lakedaemon.net>,
        Marc Zyngier <maz@kernel.org>,
        Qianggui Song <qianggui.song@amlogic.com>,
        Kevin Hilman <khilman@baylibre.com>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Jianxin Pan <jianxin.pan@amlogic.com>,
        Xingyu Chen <xingyu.chen@amlogic.com>,
        Hanjie Lin <hanjie.lin@amlogic.com>,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-amlogic@lists.infradead.org, devicetree@vger.kernel.org,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>
Subject: Re: [PATCH v2 1/4] dt-bindings: interrupt-controller: New binding
 for Meson-A1 SoCs
Message-ID: <20191226191942.GA17451@bogus>
References: <20191216123645.10099-1-qianggui.song@amlogic.com>
 <20191216123645.10099-2-qianggui.song@amlogic.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191216123645.10099-2-qianggui.song@amlogic.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 16 Dec 2019 20:36:42 +0800, Qianggui Song wrote:
> Update dt-binding document for GPIO interrupt controller of Meson-A1 SoCs
> 
> Signed-off-by: Qianggui Song <qianggui.song@amlogic.com>
> ---
>  .../bindings/interrupt-controller/amlogic,meson-gpio-intc.txt    | 1 +
>  1 file changed, 1 insertion(+)
> 

Acked-by: Rob Herring <robh@kernel.org>
