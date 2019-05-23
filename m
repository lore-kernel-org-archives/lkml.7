Return-Path: <SRS0=P610=TX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 01016C282DD
	for <linux-kernel@archiver.kernel.org>; Thu, 23 May 2019 18:46:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C64FA20862
	for <linux-kernel@archiver.kernel.org>; Thu, 23 May 2019 18:46:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="EN2kqTA/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731607AbfEWSp7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 23 May 2019 14:45:59 -0400
Received: from mail-io1-f67.google.com ([209.85.166.67]:42227 "EHLO
        mail-io1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731364AbfEWSp7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 May 2019 14:45:59 -0400
Received: by mail-io1-f67.google.com with SMTP id g16so5694068iom.9
        for <linux-kernel@vger.kernel.org>; Thu, 23 May 2019 11:45:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google;
        h=date:from:to:cc:subject:in-reply-to:message-id:references
         :user-agent:mime-version;
        bh=3G9PpELgaCmAJoi9f5MwH9qwBPA+aTo8fh9Mg5j+bJQ=;
        b=EN2kqTA/l2KnlIeXSThqN+mWXzy2R6rUf6wLv6z2ajJXoBvnTmwwl1EYQ8DqPSNZyF
         S3oWaKd5a9lrP3pNV6pr4Uw6QvdoPFhx2O6QmceDZGSHlb8hcW+hiF74BHCcm/Lue/Ba
         2nRBUg9J0vUQDXk+Y4iDZZpeC0UOUpFJirbklqPVnG9SAw6OGs146oo3YsUlQcdGQW43
         aPqi2miXnykRI2k5XFeDd0E31p3BmH4Q9kHpCdYNn/Wrkgz0fIjOAj1z1R8Mu5vqLp9X
         dZeNddqSt6sopTWvgG2ksVvJklOPBzkKofZrcRAmbl+RY95kAC5vzcMzzag3tHsu41uD
         06Hw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:in-reply-to:message-id
         :references:user-agent:mime-version;
        bh=3G9PpELgaCmAJoi9f5MwH9qwBPA+aTo8fh9Mg5j+bJQ=;
        b=O2Y+pD250mdVjZmR29V3wH30KkCogRIv8J9EfOQsp6v03bSgQN54lTCVfsjAvpfNg1
         xJoFc0jhWnC04XnJMLgu1G49KMmuclZ8rdhRIuQLsq7RA/wDHi+6YQoH13wJR3pFJvWp
         X6YwmMTdH8OQpniGINdAQr3rFgR/VJyg/ja5SIeRrfZrzmmPypMTz7G2VxT/4Po3LhrP
         KjrdPIBJHhuUWSye11kIDW8sPLlnNugi9I2hwHgRplsC+z0+QS+lSnz5hPK2RGZmqugu
         BPNcsGmb1WKbSLVoIictmIlcaqDySkFtsDHFUVmseHDt+muy98nmp25Y0xlBzWBH5XcQ
         HsOg==
X-Gm-Message-State: APjAAAV1WHtI3UD32N4jyzSgODzm3nGtIW5MKlBtBWDGCNtOc9Ifck2d
        zZdJHeFY7dHg6Ad5qTDUf1TDfQ==
X-Google-Smtp-Source: APXvYqzSIsI32XyZv64ts96aDvkx1BOYtAR2Vrh1m1dywnsC/eLbNmH+vkhQiYp3X4lNtAab58hZyQ==
X-Received: by 2002:a5d:9144:: with SMTP id y4mr46147037ioq.30.1558637158524;
        Thu, 23 May 2019 11:45:58 -0700 (PDT)
Received: from localhost (c-73-95-159-87.hsd1.co.comcast.net. [73.95.159.87])
        by smtp.gmail.com with ESMTPSA id 81sm144991ity.38.2019.05.23.11.45.57
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 23 May 2019 11:45:58 -0700 (PDT)
Date:   Thu, 23 May 2019 11:45:57 -0700 (PDT)
From:   Paul Walmsley <paul.walmsley@sifive.com>
X-X-Sender: paulw@viisi.sifive.com
To:     Atish Patra <atish.patra@wdc.com>
cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "marek.vasut@gmail.com" <marek.vasut@gmail.com>,
        "trini@konsulko.com" <trini@konsulko.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Anup Patel <anup@brainfault.org>,
        Palmer Dabbelt <palmer@sifive.com>,
        Zong Li <zong@andestech.com>,
        "catalin.marinas@arm.com" <catalin.marinas@arm.com>,
        "will.deacon@arm.com" <will.deacon@arm.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "merker@debian.org" <merker@debian.org>,
        "linux-riscv@lists.infradead.org" <linux-riscv@lists.infradead.org>
Subject: Re: [v2 PATCH] RISC-V: Add a PE/COFF compliant Image header.
In-Reply-To: <d7ef1d58-2c3f-ef58-b6aa-bb7ccfe162f6@wdc.com>
Message-ID: <alpine.DEB.2.21.9999.1905231145250.31734@viisi.sifive.com>
References: <20190501195607.32553-1-atish.patra@wdc.com> <alpine.DEB.2.21.9999.1905131522370.21198@viisi.sifive.com> <a498967c-cdc8-637a-340b-202d216c5360@wdc.com> <alpine.DEB.2.21.9999.1905131704371.21198@viisi.sifive.com> <a3eb8e32-5344-801e-03ef-98107ed13130@wdc.com>
 <alpine.DEB.2.21.9999.1905131735450.21198@viisi.sifive.com> <bb7f36bd-d614-b235-7100-3d965f92afc8@wdc.com> <alpine.DEB.2.21.9999.1905160833030.9104@viisi.sifive.com> <d7ef1d58-2c3f-ef58-b6aa-bb7ccfe162f6@wdc.com>
User-Agent: Alpine 2.21.9999 (DEB 301 2018-08-15)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 23 May 2019, Atish Patra wrote:

> I have sent out a v3 incorporating most of your suggestions. If ARM
> maintainers agree, we can move both the headers to a common place.
> 
> Just FYI: Marek also suggested to add unified support Image.gz for both U-Boot
> & RISC-V in U-Boot. I am working on that as well.

Great - thanks very much.

- Paul
