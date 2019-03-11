Return-Path: <SRS0=FxTY=RO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 290E4C43381
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Mar 2019 22:28:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E34082148D
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Mar 2019 22:28:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1552343325;
	bh=h99xRgTolS0sYBymcwweDDJUXvQ0mwPcwApHPzpmQMs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=uJ8mrnxkhgCT7tQBTZ4xlY6SVaNctVAtjrBH2IYgXJVg5JCQMuAhg0dSCXSozlyuM
	 17nAWAG160L7EGTqUTgiApwYKu908pnCD5siMZ+ApipG/6a2zngS0EAMQbPXOKjv1A
	 QrcXDsTkAEBZiSY+WPQ/fOjOXo5Wsa0VGxSR7qtU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726396AbfCKW2n (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Mar 2019 18:28:43 -0400
Received: from mail-ot1-f67.google.com ([209.85.210.67]:39729 "EHLO
        mail-ot1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725890AbfCKW2n (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Mar 2019 18:28:43 -0400
Received: by mail-ot1-f67.google.com with SMTP id e15so706176otk.6;
        Mon, 11 Mar 2019 15:28:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=sbjLaawG5X+3yVq6Fx8QrylqfUfU65i8TiCSwA7C0bo=;
        b=pLEnGDvzoXakctlpFP4V+eWFhpANUsET/bfDjEifW8bUzCA/cwcpIPxAdtTdWFcJlC
         aAcyJXY7g3EKjgdJpmqyfGsZdpE6lHVkQDGwXt16emCzl8DBZyn1UIwlUX8Ob/C5w2FP
         +JqYFXypDltuV+aBI5nB8VjqJ8Ykqy71xvLnShq6o3Heqbf0AyfLgpQK98dXMBLgBWxz
         fW0NXoRxZNZrE3Gf7/jCD4jM6SmUIy7tKSg4HEyh4y/stUcuCGX9Je4Czt+afIwGgYhT
         Ic3WqIKiqJKqdpaFU6LFhvFsDbLlYUgo17c7BBJouwblvZWYP4aqF6PK41URmJP7I9Sd
         DHWg==
X-Gm-Message-State: APjAAAXvKL0My7pEcOGwu4cNYz6Yk+lpeHEDSwoBKQEz7MVHC53gztTo
        bWvXctZFcDs2U//M7ObYJg==
X-Google-Smtp-Source: APXvYqyVNhIJWksnUQPcukyl8VC9DqPam1VBOKSduDXWgxpG8noWaW24cYO1ZAqDoZfBeElYEl/UmA==
X-Received: by 2002:a05:6830:2055:: with SMTP id f21mr21242154otp.130.1552343322685;
        Mon, 11 Mar 2019 15:28:42 -0700 (PDT)
Received: from localhost (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id 39sm2941908ota.11.2019.03.11.15.28.42
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 11 Mar 2019 15:28:42 -0700 (PDT)
Date:   Mon, 11 Mar 2019 17:28:41 -0500
From:   Rob Herring <robh@kernel.org>
To:     Patrick Havelange <patrick.havelange@essensium.com>
Cc:     Jonathan Cameron <jic23@kernel.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Mark Rutland <mark.rutland@arm.com>,
        Matt Weber <matthew.weber@rockwellcollins.com>,
        Paresh Chaudhary <paresh.chaudhary@rockwellcollins.com>,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org,
        Patrick Havelange <patrick.havelange@essensium.com>
Subject: Re: [PATCH v6 3/4] iio:temperature:max31856:Add device tree bind info
Message-ID: <20190311222841.GA6024@bogus>
References: <20190307103409.24174-1-patrick.havelange@essensium.com>
 <20190307103409.24174-3-patrick.havelange@essensium.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190307103409.24174-3-patrick.havelange@essensium.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu,  7 Mar 2019 11:34:08 +0100, Patrick Havelange wrote:
> From: Paresh Chaudhary <paresh.chaudhary@rockwellcollins.com>
> 
> This patch added device tree binding info for MAX31856 driver.
> 
> Signed-off-by: Paresh Chaudhary <paresh.chaudhary@rockwellcollins.com>
> Signed-off-by: Matt Weber <matthew.weber@rockwellcollins.com>
> Signed-off-by: Patrick Havelange <patrick.havelange@essensium.com>
> ---
> Changes
> v1 -> v2
> [Matt
>  - Removed comment block and added possibilities of
>    thermocouple type in device tree binding doc.
> 
> v2 -> v3
>  - Rebased
> 
> v3 -> v4
>  - Removed one-shot property related information.
>  - Used standard name 'temp-sensor'
> 
> v4 -> v5
> [Patrick
>  - Rename thermocouple type to maxim,thermocouple-type for DT entry
> 
> v5 -> v6
> [Patrick
>  - use generic thermocouple-type for DT entry
> ---
>  .../bindings/iio/temperature/max31856.txt     | 24 +++++++++++++++++++
>  1 file changed, 24 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/iio/temperature/max31856.txt
> 

Reviewed-by: Rob Herring <robh@kernel.org>
