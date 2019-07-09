Return-Path: <SRS0=gj9M=VG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 33B6EC606D9
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Jul 2019 07:51:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0CE6521537
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Jul 2019 07:51:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="fNEDVX0H"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726585AbfGIHvc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 9 Jul 2019 03:51:32 -0400
Received: from mail-pl1-f194.google.com ([209.85.214.194]:43323 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725965AbfGIHvb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Jul 2019 03:51:31 -0400
Received: by mail-pl1-f194.google.com with SMTP id cl9so9627361plb.10
        for <linux-kernel@vger.kernel.org>; Tue, 09 Jul 2019 00:51:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=Smrq/vDbxcQl6KW/Rh/T3b+nDUYxB6msX/ZOzbcRi2U=;
        b=fNEDVX0HL7EI/I6m5GdoAodJt4iCk6yzm4tuOh8ajweaBLKmh9prOUVmdOdhKNPrl/
         dF3nyni3L1tkHubOOl5yp+pZHwYmI6cZ1c3rOLgyQyUyMlHl/uO3Y8rQUElrUmbk4b/E
         s3cRHEU3henZjAe+fTlvzeiQrrhtUSUBrqQ9jp67liLLgUB7XiuawxR83WCDpO5YTeIt
         JTLzoOs1VfiHTiiaVAcLZKR7PrE9gOkt7Y0/jN1HQSKYAeTxJ2E1przF39kV1CKPCCFm
         rFc04TDY3RgryFc0c4/s+B1NzXD/tC82rN9nwc7Bpq3ybzaqCUVXRn1lzKeWeLOVbX7i
         xT6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=Smrq/vDbxcQl6KW/Rh/T3b+nDUYxB6msX/ZOzbcRi2U=;
        b=QNXCbO95cvYI53OJt456V7JGD/tShq2fEOJX6xGcywEIgLx5ek4WjynZXFHcj7KEiA
         zHUOQjs2pA44nQ4HKh/5BdbJzk+H8Nm4+85u0qeICHqe8VozWCq48xiY/OBg0X58yENZ
         GtSmDKgLaX5NHLiy/sfYOUR2QgoygXS3F8p4bA+n4cC3hXhMJixJJgp8yl/XXvflWP3t
         sq97CKBeNwvqF2Q6+DH6tK4joQ/m+seZh4WVxKQ3IFf0fPCnnFSWKmMCNyqripFZbk7o
         Kw+3BfwIX5RGHxHjkIBWkQpevInfBHQIXJpgAVNoboJHlFUev5xvWEELfItzrdXfbtEC
         xQ4Q==
X-Gm-Message-State: APjAAAVvktKYLN/+HltM5z4W6ypMU1ZlEoZs2K4XJ+k7BIYGONyqYKHj
        qio87+S95fk5fabPlZ83lJQXmg==
X-Google-Smtp-Source: APXvYqwdU6F7Yn1VJPjF6KItVXdlcrtq2LV7yj+CbXHG4RpzQKgCu+AE6ystgZtAN6RbIoZ7toO/rA==
X-Received: by 2002:a17:902:9041:: with SMTP id w1mr30857440plz.132.1562658691215;
        Tue, 09 Jul 2019 00:51:31 -0700 (PDT)
Received: from localhost ([122.172.28.117])
        by smtp.gmail.com with ESMTPSA id p68sm32770294pfb.80.2019.07.09.00.51.21
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 09 Jul 2019 00:51:21 -0700 (PDT)
Date:   Tue, 9 Jul 2019 13:21:19 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Anson.Huang@nxp.com
Cc:     robh+dt@kernel.org, mark.rutland@arm.com, shawnguo@kernel.org,
        s.hauer@pengutronix.de, kernel@pengutronix.de, festevam@gmail.com,
        vireshk@kernel.org, nm@ti.com, sboyd@kernel.org,
        leonard.crestez@nxp.com, aisheng.dong@nxp.com,
        daniel.baluta@nxp.com, ping.bai@nxp.com, l.stach@pengutronix.de,
        abel.vesa@nxp.com, ccaione@baylibre.com, angus@akkea.ca,
        andrew.smirnov@gmail.com, agx@sigxcpu.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        Linux-imx@nxp.com
Subject: Re: [PATCH 1/3] opp: of: Support multiple suspend OPPs defined in DT
Message-ID: <20190709075119.rg6ktsg7nwdadsmd@vireshk-i7>
References: <20190709071056.26361-1-Anson.Huang@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190709071056.26361-1-Anson.Huang@nxp.com>
User-Agent: NeoMutt/20180716-391-311a52
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 09-07-19, 15:10, Anson.Huang@nxp.com wrote:
> From: Anson Huang <Anson.Huang@nxp.com>
> 
> With property "opp-supported-hw" introduced, the OPP table
> in DT could be a large OPP table and ONLY a subset of OPPs
> are available, based on the version of the hardware running
> on. That introduces restriction of using "opp-suspend"
> property to define the suspend OPP, as we are NOT sure if the
> OPP containing "opp-suspend" property is available for the
> hardware running on, and the of opp core does NOT allow multiple
> suspend OPPs defined in DT OPP table.
> 
> To eliminate this restrition, make of opp core allow multiple
> suspend OPPs defined in DT, and pick the OPP with highest rate
> and with "opp-suspend" property present to be suspend OPP, it
> can speed up the suspend/resume process.
> 
> Signed-off-by: Anson Huang <Anson.Huang@nxp.com>
> ---
>  drivers/opp/of.c | 9 ++++++---
>  1 file changed, 6 insertions(+), 3 deletions(-)

Please update the DT bindings first.

FWIW, all three patches look fine otherwise.

-- 
viresh
