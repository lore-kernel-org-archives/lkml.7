Return-Path: <SRS0=nVcb=SO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 54C5FC10F0E
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Apr 2019 14:01:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 231272171F
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Apr 2019 14:01:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="i1ibx170"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726921AbfDLOBd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 12 Apr 2019 10:01:33 -0400
Received: from mail-lf1-f65.google.com ([209.85.167.65]:46145 "EHLO
        mail-lf1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726327AbfDLOBc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Apr 2019 10:01:32 -0400
Received: by mail-lf1-f65.google.com with SMTP id r25so7557706lfn.13;
        Fri, 12 Apr 2019 07:01:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:from:to:cc:references:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=psYY2+80bNLYEksdQELL7+YptxqqnoRTW2EZPQivXbo=;
        b=i1ibx170NlznCApjkmRZ0mJGVsNy+4B8MCLQ+KfMGys175KTqZGd21bgAeUBKSl9+I
         aDRD7VK+w9APOirCVzKfc5d4xodeosmEQcaA9mb+kqWpUodA0MtqZkkgqfJaG7V9Zzbu
         fFhd4G/xNDY7EPZP4+EqtE/Z/PFU+ttybnJ0W5mUtFNjI0NM6NAb91DufhT0ByLifUb+
         4QBps8Dn3HYlFxILftccgRmxknB9VTTJfPDprwa2Doi+ZnNe6nitxzBAXOAeUu4Rzacs
         /orUjQul03uFdbo+aU7615yvP+7B/BxwfcaRS6neKVfd/5z6LdHU/jIaldRBauZ8aUpY
         pDfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:from:to:cc:references:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=psYY2+80bNLYEksdQELL7+YptxqqnoRTW2EZPQivXbo=;
        b=I+1rMF12nmQdKQr2nfIcW/GoRPeANrv3/9CKkMhw0zxzcz/R225raLLk/joGiX28qH
         YUwOEHVRh9fSEp4oCz4tSdHlso9syVFaexh63zd1VtlGJq1Fm83RJr5Oictpe6QGn6xK
         gsgc+ernOMT/lECDlA/830y5awWyokWYgjKg7T4acYmO+1XcWffVt7C9uoXapPYgHIk+
         PrIRYtpGAfw9jafu79i/w+qEUzRFmkLHofXZ9oC5b4Di9TJnR3rKpvl9lVUzq6RXjo8k
         bK9BLeMyamvkekUorQ5lC16YX98Q2N0HK47BtUimQPwLAYveTK4mer8nr6/Dg3aL6Z9q
         Cq9Q==
X-Gm-Message-State: APjAAAV8IHuUDpKEAxo2mzayJ5jIvukIB+GxCDfQyQQFZlX0YjyFfQEm
        eVOAOfRDHwux28VMFSnLVKQgSgh2
X-Google-Smtp-Source: APXvYqxN5UMM9cEe6EDxj/KmQvRtDXUKWtaQgNoklpeMEbNb3sk0Z0sjNjFSDeKHNRZvZAWmBaY4nw==
X-Received: by 2002:ac2:596a:: with SMTP id h10mr20814975lfp.52.1555077690049;
        Fri, 12 Apr 2019 07:01:30 -0700 (PDT)
Received: from [192.168.2.145] (ppp94-29-35-107.pppoe.spdop.ru. [94.29.35.107])
        by smtp.googlemail.com with ESMTPSA id y23sm531457lfy.31.2019.04.12.07.01.28
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 12 Apr 2019 07:01:28 -0700 (PDT)
Subject: Re: [PATCH v1 2/3] memory: tegra: Introduce Tegra30 EMC driver
From:   Dmitry Osipenko <digetx@gmail.com>
To:     Peter De Schrijver <pdeschrijver@nvidia.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Joseph Lo <josephl@nvidia.com>
Cc:     devicetree@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20190411230221.31362-1-digetx@gmail.com>
 <20190411230221.31362-3-digetx@gmail.com>
Message-ID: <0e61d2a7-3f13-3868-954f-86562c546be1@gmail.com>
Date:   Fri, 12 Apr 2019 17:01:28 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190411230221.31362-3-digetx@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

12.04.2019 2:02, Dmitry Osipenko пишет:
> Introduce driver for the External Memory Controller (EMC) found on Tegra30
> chips, it controls the external DRAM on the board. The purpose of this
> driver is to program memory timing for external memory on the EMC clock
> rate change.
> 
> Signed-off-by: Dmitry Osipenko <digetx@gmail.com>

I realized that the MC_SAME_FREQ timing configuration need be properly handled for T30 and that is missed in this version. Will fix it up in v2. Although, seems it's not critical since things appear to work properly and probably only arbitration is not optimally configured because of the MC/EMC setup mismatch.  
