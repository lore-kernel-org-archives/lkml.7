Return-Path: <SRS0=hO5d=UX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2453EC4646C
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Jun 2019 21:23:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E35AD20663
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Jun 2019 21:23:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="DHSaqTwl"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731466AbfFXVXl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Jun 2019 17:23:41 -0400
Received: from mail-io1-f67.google.com ([209.85.166.67]:44896 "EHLO
        mail-io1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726331AbfFXVXk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Jun 2019 17:23:40 -0400
Received: by mail-io1-f67.google.com with SMTP id s7so196516iob.11
        for <linux-kernel@vger.kernel.org>; Mon, 24 Jun 2019 14:23:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google;
        h=date:from:to:cc:subject:in-reply-to:message-id:references
         :user-agent:mime-version;
        bh=fs+nly2CqDJY2F03DH2S4onxLharejPukjuN2a0s++k=;
        b=DHSaqTwlJv7AurjXB+C8yOpKCNMewWdCZE4JcB8h/68BVRArdlHcI3Z0CrqS2lOl4N
         cEuIUQ92NhpHODPahLAAAbPLC3F3VIDggVp/hnDP8ARZc8HllIYg2VTXTIHSFZeVOA6P
         EHoCDwGc1moMGzaIOzYrQ/0AYMsFdMmCbS6F3sPuj2bmiaic+wYjH8WB6ENupkdcmDon
         mNZU3TxmidJOwPzPrNs1hURzJ14pEcIuPh/sfV77/TmJDAjSe7zU8C8/g9gsUadaVYyg
         4AvvVKmYbh9EXCCQNrv+YfL0FQGqaZJqjFHbPLVNXefr5LJA00rvZIKPg1D6wFA2qH07
         S3pg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:in-reply-to:message-id
         :references:user-agent:mime-version;
        bh=fs+nly2CqDJY2F03DH2S4onxLharejPukjuN2a0s++k=;
        b=DHKGAT0jMmFAiFMsNYvAtZnX3/jU6SJAldnaLNibRh03Vx/LA0xgLxestFWG2y7lM5
         gZ1nkyGmLNsDbUs0Rr36jy6klHw9TTWmfg824AtJZMON0eLkvB9LSjvz3i07XavKNicA
         VmK+u0BYNeGa+Pme4s87D/kM8cHDutMSUQf4S0dCOXIqq2WnDobmq7bmIJaAXgFEZn09
         2rnOq87ptI9f5TZRB6pm0NJDfEm+pfMAdfOPTyFPnmYoQHwzzm/uotd5hHxozyNgKKHL
         gl+YNzdzgVawrpkZ1rMXMsMekR0AYfDuOHsJFcwkSaMLRmNwJD0mLu+oa9NEMoo1FmmZ
         3NHg==
X-Gm-Message-State: APjAAAX2u/qgFM6ylDSCtmNTKDGIhL6snsEbus90CuytkKJHCu23uGG6
        1fx9toVvyZytu/iRQyobSb3iEw==
X-Google-Smtp-Source: APXvYqxgSwaipvyNNYGbOgoKTx3/dcZraYFCAkDEUKEpgskncaj/x86AyejV/paA8RMTb+D5/LZPNw==
X-Received: by 2002:a5e:8209:: with SMTP id l9mr18130595iom.303.1561411420072;
        Mon, 24 Jun 2019 14:23:40 -0700 (PDT)
Received: from localhost (c-73-95-159-87.hsd1.co.comcast.net. [73.95.159.87])
        by smtp.gmail.com with ESMTPSA id p25sm14832445iol.48.2019.06.24.14.23.39
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Mon, 24 Jun 2019 14:23:39 -0700 (PDT)
Date:   Mon, 24 Jun 2019 14:23:39 -0700 (PDT)
From:   Paul Walmsley <paul.walmsley@sifive.com>
X-X-Sender: paulw@viisi.sifive.com
To:     Yash Shah <yash.shah@sifive.com>
cc:     robh+dt@kernel.org, devicetree@vger.kernel.org,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        mark.rutland@arm.com, palmer@sifive.com, aou@eecs.berkeley.edu,
        sachin.ghadi@sifive.com
Subject: Re: [PATCH] riscv: dts: Re-organize SPI DT nodes
In-Reply-To: <1561375453-3135-1-git-send-email-yash.shah@sifive.com>
Message-ID: <alpine.DEB.2.21.9999.1906241421550.22820@viisi.sifive.com>
References: <1561375453-3135-1-git-send-email-yash.shah@sifive.com>
User-Agent: Alpine 2.21.9999 (DEB 301 2018-08-15)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 24 Jun 2019, Yash Shah wrote:

> As per the General convention, define only device DT node in SOC DTSi
> file with status = "disabled" and enable device in Board DTS file with
> status = "okay"
> 
> Reported-by: Anup Patel <anup@brainfault.org>
> Signed-off-by: Yash Shah <yash.shah@sifive.com>

This is a good start, but should also cover the other I/O devices in the 
chip DT file.  The mandatory internal devices, like the PRCI and PLIC, can 
stay the way they are.


- Paul
