Return-Path: <SRS0=eZ3S=UF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B9ED1C04AB5
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Jun 2019 08:17:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8C78620673
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Jun 2019 08:17:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=cogentembedded-com.20150623.gappssmtp.com header.i=@cogentembedded-com.20150623.gappssmtp.com header.b="riwQ1+rT"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727129AbfFFIRK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Jun 2019 04:17:10 -0400
Received: from mail-lj1-f195.google.com ([209.85.208.195]:41212 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727109AbfFFIRI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Jun 2019 04:17:08 -0400
Received: by mail-lj1-f195.google.com with SMTP id s21so1114802lji.8
        for <linux-kernel@vger.kernel.org>; Thu, 06 Jun 2019 01:17:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cogentembedded-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=ms/3gXcMEPIWd0uNgXu5WibAfZ4H8Pur2jPfFPQc+aw=;
        b=riwQ1+rT5MbPfmvDMczw2lUSqrvicxWO50/VLtZVvnmRfXJ9OgR0n95tm2KkQymMYf
         06Rpk+zBqPsrZNEl2s/bbndS5Pc53pHSG/YgrePU0vOZOfGF28+vl9moIpllPD1VG9HJ
         Q4Pvr+mlOuAvwX+m80S+32t7yOpJuNqmQRDkWxX4XHqj6NkHIOLp8Jf9VC12yHdKjytb
         hQZROzCHtOVPCr/oJdtvaUhRpXcRElgNaZB6o0qtj3GfCRpkj8NSmOvYaiIvnquT2DK1
         Ne/suZjE8XizEOU988eK0Wk/Ru3tQot6icH91h0rS8w78Vh46t2QlN7Sr7LwGid5W/xZ
         EnDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=ms/3gXcMEPIWd0uNgXu5WibAfZ4H8Pur2jPfFPQc+aw=;
        b=g7d372gycIKbzbnn1DpqSreb+4i9Z12CIMA+JQRs/IKVvwnWN5NF9Yck4facDmNzDp
         5rPOo261xgnJperxzCUWwEuLUN3mfA2/7ssrqvSoASVUFzy8o3HFvPMYg6yBDfs1lTD8
         0TAVofOa4lTR3tLj2j+DzemdYmWS04ymOdH8VhREpkRwPGYCyAfBqN0K7lQTKTyqjVNW
         sl2CQFq7dPoNKknLo2RUSG4bw3+eHMH4lYpjKGxEzHoeNHY2+zNgidFA71Mrh+6j95B/
         TY9xsVTGA1RtBIpJcC9mk4kCSKk5wJNaFXKGdiOUTP5A/tKW2KyS78GXlTP514CTXpgf
         RG5A==
X-Gm-Message-State: APjAAAWIOJOIwwtTZ3/iSA717x1e2Y6U9bsT3iAOD76YY/ToBgAT/BDd
        sotWF+iMNnMfKzS4SjCqWtbTuXhjbG4=
X-Google-Smtp-Source: APXvYqxZrmtys7SbLSVyK9cD454Jm14C5G5I1bB8ztL7yOCjFzh1w/hKLJQj1dHM824bhIF+XDzmKw==
X-Received: by 2002:a2e:81c4:: with SMTP id s4mr11792430ljg.182.1559809025880;
        Thu, 06 Jun 2019 01:17:05 -0700 (PDT)
Received: from [192.168.0.199] ([31.173.81.46])
        by smtp.gmail.com with ESMTPSA id b25sm184051lff.42.2019.06.06.01.17.04
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 06 Jun 2019 01:17:05 -0700 (PDT)
Subject: Re: [RESEND][PATCH v3 1/2] usb: dwc3: Add avoiding vbus glitch happen
 during xhci reset
To:     Ran Wang <ran.wang_1@nxp.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Felipe Balbi <balbi@kernel.org>, Yang Li <pku.leo@gmail.com>
Cc:     linux-usb@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20190606025418.26313-1-ran.wang_1@nxp.com>
From:   Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Message-ID: <78eb1558-b8d4-0632-ad0c-4144c711d2da@cogentembedded.com>
Date:   Thu, 6 Jun 2019 11:16:54 +0300
User-Agent: Mozilla/5.0 (Windows NT 6.3; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <20190606025418.26313-1-ran.wang_1@nxp.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello!

On 06.06.2019 5:54, Ran Wang wrote:

> When DWC3 is set to host mode by programming register DWC3_GCTL, VBUS
> (or its control signal) will turn on immediately on related Root Hub
> ports. Then the VBUS will be de-asserted for a little while during xhci
> reset (conducted by xhci driver) for a little while and back to normal.
> 
> This VBUS glitch might cause some USB devices emuration fail if kernel

    Enumeration. :-)

> boot with them connected. One SW workaround which can fix this is to
> program all PORTSC[PP] to 0 to turn off VBUS immediately after setting
> host mode in DWC3 driver(per signal measurement result, it will be too
> late to do it in xhci-plat.c or xhci.c).
> 
> Signed-off-by: Ran Wang <ran.wang_1@nxp.com>
> Reviewed-by: Rob Herring <robh@kernel.org>
[...]

MBR, Sergei
