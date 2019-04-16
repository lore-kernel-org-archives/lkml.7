Return-Path: <SRS0=BZT9=SS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8EAA1C10F13
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Apr 2019 18:38:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 54A632075B
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Apr 2019 18:38:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=cogentembedded-com.20150623.gappssmtp.com header.i=@cogentembedded-com.20150623.gappssmtp.com header.b="qp4/53S3"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730237AbfDPSiA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Apr 2019 14:38:00 -0400
Received: from mail-lf1-f67.google.com ([209.85.167.67]:36163 "EHLO
        mail-lf1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728203AbfDPSiA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Apr 2019 14:38:00 -0400
Received: by mail-lf1-f67.google.com with SMTP id u17so16836533lfi.3
        for <linux-kernel@vger.kernel.org>; Tue, 16 Apr 2019 11:37:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cogentembedded-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:organization:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=ywrdJvPrPR6BkjnuUMR3wLp2mpzMq5QkUh5noAhBhws=;
        b=qp4/53S3EuIaKQsmF4kgtaBK3Xv8HsU28uDa3XAZYZNftQcAa6ZgWR6SwgyvDBtwv2
         L76BB6oRW6On+Wq79h8Z4VRIhkUwoKalo5pe2nI5ps+c1r4U/+ybRAEifQgDPaeH+jUt
         JeFFj0hcURij+Uff06eNztvC9tZegTeVjObXcS4yT/wVnPeZ7xu/4ezpsl7pbTB+pZia
         J6Qjo31L3J8GMEdf7NbIoxTDQc5VVYTgZgzi1RW2F0eMXZzvEdT3oNfFR7OOAQK7ippC
         PsLSqRLRNX1dc+YyPVdQB1ViqCEkAeD0q5V70kioe0ln3OReF7WdW0qkwuZi+WJcsT5m
         8NMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:organization
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=ywrdJvPrPR6BkjnuUMR3wLp2mpzMq5QkUh5noAhBhws=;
        b=DeKgSPYJJyW2fmRER75OhhhZez6xUhN2bxPzB4f/RTtQVaBpc6nP7g8h0/vCcvqwHr
         W+LXPD8KQjtbV4vGT6aBNVL0aOtjQyOYqvOGOwGSzOQAOlhas/FLg4CQhMbggBZXT1Xb
         y2YRsLYBbQeBeStJkZHvlNIGkIaVtSUgp6Gr1QJ5HUuZnwuEh207SHAyhPD/CVOzVrl6
         MKNsNLBDt/K/S+2ojREBUsjuc5+cwn4n8mbcVjLZovEeMlM1ywpf0aVyCjYQ9ZgzTrGr
         AATXZ1AInUChQIil5U4RbpZMtYFMg6MC0KG/sX0ztUIwgkniha4D6mDoTTwupfyATaMx
         nKjg==
X-Gm-Message-State: APjAAAUGK/B8OzogUli40Gh3f+NuKzsEe4U3O9iO+4tOpyWKgKZOAP2x
        F2qcjAulYEZFaxwwqcRjp8eHJw==
X-Google-Smtp-Source: APXvYqw4AHvywwm0li5okPBHWZAvZvWaBkUlo3Cram8Ex/99VpJ+tScGFXniu+eAybMoYF2XDDImeg==
X-Received: by 2002:a19:6619:: with SMTP id a25mr45791298lfc.21.1555439878242;
        Tue, 16 Apr 2019 11:37:58 -0700 (PDT)
Received: from wasted.cogentembedded.com ([31.173.81.184])
        by smtp.gmail.com with ESMTPSA id 77sm10558717ljc.69.2019.04.16.11.37.56
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 16 Apr 2019 11:37:56 -0700 (PDT)
Subject: Re: [PATCH v10 2/3] spi: Add Renesas R-Car Gen3 RPC-IF SPI controller
 driver
To:     Mason Yang <masonccyang@mxic.com.tw>, broonie@kernel.org,
        marek.vasut@gmail.com, linux-kernel@vger.kernel.org,
        linux-spi@vger.kernel.org, bbrezillon@kernel.org,
        linux-renesas-soc@vger.kernel.org,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        lee.jones@linaro.org, robh+dt@kernel.org, mark.rutland@arm.com,
        devicetree@vger.kernel.org
Cc:     juliensu@mxic.com.tw, Simon Horman <horms@verge.net.au>
References: <1555313834-15107-1-git-send-email-masonccyang@mxic.com.tw>
 <1555313834-15107-3-git-send-email-masonccyang@mxic.com.tw>
From:   Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Organization: Cogent Embedded
Message-ID: <490f6e80-3930-2885-a08f-93596e210f88@cogentembedded.com>
Date:   Tue, 16 Apr 2019 21:37:55 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.2.1
MIME-Version: 1.0
In-Reply-To: <1555313834-15107-3-git-send-email-masonccyang@mxic.com.tw>
Content-Type: text/plain; charset=utf-8
Content-Language: en-MW
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 04/15/2019 10:37 AM, Mason Yang wrote:

> Add a driver for Renesas R-Car Gen3 RPC-IF SPI controller.
> 
> Signed-off-by: Mason Yang <masonccyang@mxic.com.tw>
> Signed-off-by: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>

   This patch looked good to me (you seem to have incorporated another patch of mine
here :-)). Since the patch is already carrying my signoff, I wouldn't add a Reviewed-by:
tag.
   However, I believe that all manipulations with the RPC-IF hardware need to be moved
to the MFD driver, to be called from the SPI and HF subdrivers... doesn't seem an easy
task though...

MBR, Sergei
