Return-Path: <SRS0=vtn1=VX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 16C3CC7618F
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Jul 2019 20:47:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DC4D7218B8
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Jul 2019 20:47:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="iQLhlbEB"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727997AbfGZUrg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 26 Jul 2019 16:47:36 -0400
Received: from mail-io1-f66.google.com ([209.85.166.66]:38184 "EHLO
        mail-io1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726522AbfGZUrg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Jul 2019 16:47:36 -0400
Received: by mail-io1-f66.google.com with SMTP id j6so32331137ioa.5
        for <linux-kernel@vger.kernel.org>; Fri, 26 Jul 2019 13:47:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google;
        h=date:from:to:cc:subject:in-reply-to:message-id:references
         :user-agent:mime-version;
        bh=mMbJIOT9Mkj81+DURpJRyWnAKm1UiE5G4DSpvnaTnlQ=;
        b=iQLhlbEBRwr8KtEYt5QkUcHsN7g9ET/3bTou7gUrL0NufVWuLo3Lc3Y4p7zfHTOiPE
         9qF21HURQiSY3zUkjVj3mLUtscZQdl0SISNvcDw3E2xQ0sdZT3a8q++f1llCEySh1QNx
         Zqvas98bNAxVX217PC4OnCEI9gxYh/7Sq143WfGc87TEShzOG3D/WQP8w61o0R7H+HQh
         tpkD2ZTGdX5ev7S3dVHQXZHq7zCZZ56Q2K/x7RN8vw3Nmrtd9HEMBgiP3OXMm7btq9fE
         yPFe2pDXAszV+q70PEI1DSXKl0pGvqT0MBL/YXcdkdm2oJBMpIfLgs+UNcjSuedXCCeu
         SXKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:in-reply-to:message-id
         :references:user-agent:mime-version;
        bh=mMbJIOT9Mkj81+DURpJRyWnAKm1UiE5G4DSpvnaTnlQ=;
        b=IV/l8biTHYBYFqOR7PgwGAEQ005y4u/D0a38P39Ous8xplafyspdMcTy2M3rCZMF9Y
         d3AARVIQAtC36tjU5mbDQre4JRERoD81V8zFPHw/N5ELV8HHwQISGaQ4WRkKiYiit3SI
         Iwqy4sitPER6TGs6I74YvJ8BLn6yOXU8xqBeTQbNc2QJNMoGIB2Q2nHHWo8b1Uaq16tN
         /zwIeJD6pHAZ2TO5ElbUYHir9pKDCPm75CI6acED/XIvTCtYXCzt1++hBTAaqs1ju8j8
         zcoW2Me98HvGytCFScuVUiHyFaGFXqeY5R6a82nvTSmh1tiuk0rLGzxDcdCaepBeyGiv
         Vlkw==
X-Gm-Message-State: APjAAAVIbuN+R1vAbBzktJTpfoXS4PlWrM4dlrx3zasKiQhxjSWAS9xH
        xZG8JniyS8UqxewHkgHfX1XnQQ==
X-Google-Smtp-Source: APXvYqwKKrDjZKa5SshdtHfZGTqeOjqpdefuxyMAWSHZe6JrF8fIyDi3vcyrwB53xGMYGrzjC2LFvA==
X-Received: by 2002:a05:6638:517:: with SMTP id i23mr24654424jar.71.1564174055390;
        Fri, 26 Jul 2019 13:47:35 -0700 (PDT)
Received: from localhost (67-0-24-96.albq.qwest.net. [67.0.24.96])
        by smtp.gmail.com with ESMTPSA id l11sm39320915ioj.32.2019.07.26.13.47.34
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Fri, 26 Jul 2019 13:47:34 -0700 (PDT)
Date:   Fri, 26 Jul 2019 13:47:33 -0700 (PDT)
From:   Paul Walmsley <paul.walmsley@sifive.com>
X-X-Sender: paulw@viisi.sifive.com
To:     Atish Patra <atish.patra@wdc.com>
cc:     linux-kernel@vger.kernel.org, Alan Kao <alankao@andestech.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Allison Randal <allison@lohutok.net>,
        Anup Patel <anup.patel@wdc.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Johan Hovold <johan@kernel.org>,
        linux-riscv@lists.infradead.org,
        Palmer Dabbelt <palmer@sifive.com>,
        Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [PATCH 3/4] RISC-V: Support case insensitive ISA string
 parsing.
In-Reply-To: <20190726194638.8068-3-atish.patra@wdc.com>
Message-ID: <alpine.DEB.2.21.9999.1907261346560.26670@viisi.sifive.com>
References: <20190726194638.8068-1-atish.patra@wdc.com> <20190726194638.8068-3-atish.patra@wdc.com>
User-Agent: Alpine 2.21.9999 (DEB 301 2018-08-15)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 26 Jul 2019, Atish Patra wrote:

> As per riscv specification, ISA naming strings are
> case insensitive. However, currently only lower case
> strings are parsed during cpu procfs.
> 
> Support parsing of upper case letters as well.
> 
> Signed-off-by: Atish Patra <atish.patra@wdc.com>

Is there a use case that's driving this, or can we just say, "use 
lowercase letters" and leave it at that?


- Paul
