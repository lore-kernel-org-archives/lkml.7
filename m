Return-Path: <SRS0=kjqD=WY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 45777C3A5A4
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Aug 2019 18:01:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1CDD9206BB
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Aug 2019 18:01:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="ASkY1rUl"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726907AbfH1SBN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 28 Aug 2019 14:01:13 -0400
Received: from mail-pg1-f195.google.com ([209.85.215.195]:38030 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726591AbfH1SBM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Aug 2019 14:01:12 -0400
Received: by mail-pg1-f195.google.com with SMTP id e11so138225pga.5
        for <linux-kernel@vger.kernel.org>; Wed, 28 Aug 2019 11:01:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=BFJvddMVdRzlLg4JaQXTPKjXHEos9ALpLQhTxwQRgB0=;
        b=ASkY1rUlh5uPsHc6yy1UDllwaGq7eHHaqrx9mHH1JQk+Juc6hS4cevD9XTNCDZesbH
         Mmo9mFrqYcCia1Ti/2PSg9CY+Q8KpxUS8DMx9XHSfqZZ6kXEF39+pefIA2AvUzXJi4+i
         2z/Sepk/beKs+aXtnAYFGTpIHKCQHRn848/5Y=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=BFJvddMVdRzlLg4JaQXTPKjXHEos9ALpLQhTxwQRgB0=;
        b=NZJ+NOsXjDNzVKgUCgMrbJeNY0VIo+H+vrNfbTalPxjtMNm8pduFV0n8badLU4+lFh
         D4rRcqVuWmrxv8TRSZaYyKzdSt6UEUObziw3cRIpl2zoHyQixL/ZBsJpS4hlTJ60udSv
         tiBz5hwvsvmw60xQzd2hhS3jevaqdCCHlT63vvZsRDTF17qFzqaVgIDUKwffTcODGDCX
         yy26ON0lqHMqgqY19HdrGXVNv1Rj20CxFWi/f78rOmCnysxRLv2EpKpQGk1Eb4PArlgT
         jj3SwT5/ZxsbK3Uf0crPyeAa7H/HBN9zF2e1QM0iWH3RTnVQgFwfV3++yM7l3yUB9rVU
         QhXA==
X-Gm-Message-State: APjAAAWt7xmZOtM7tiDJ9Yz0bJXIevB29wzM99W/JwYvdIUZRl7sOAjB
        0L4vs5Pa3HbBdJzLcDSMqw9SZQ==
X-Google-Smtp-Source: APXvYqxl9ldGbN+Y6p7HIDBEFutfmUjTW+7dVVdP5QoMG/5a9Fx5qHPh4AtBUYcTgv24Hatkm1LSYw==
X-Received: by 2002:a17:90a:6581:: with SMTP id k1mr5476919pjj.47.1567015272079;
        Wed, 28 Aug 2019 11:01:12 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id z4sm3347892pfg.166.2019.08.28.11.01.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Aug 2019 11:01:11 -0700 (PDT)
Date:   Wed, 28 Aug 2019 11:01:10 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Andy Lutomirski <luto@amacapital.net>
Cc:     David Abdurachmanov <david.abdurachmanov@gmail.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@sifive.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Oleg Nesterov <oleg@redhat.com>,
        Will Drewry <wad@chromium.org>, Shuah Khan <shuah@kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Martin KaFai Lau <kafai@fb.com>,
        Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
        David Abdurachmanov <david.abdurachmanov@sifive.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Allison Randal <allison@lohutok.net>,
        Alexios Zavras <alexios.zavras@intel.com>,
        Anup Patel <Anup.Patel@wdc.com>,
        Vincent Chen <vincentc@andestech.com>,
        Alan Kao <alankao@andestech.com>,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org, netdev@vger.kernel.org,
        bpf@vger.kernel.org, me@carlosedp.com
Subject: Re: [PATCH v2] riscv: add support for SECCOMP and SECCOMP_FILTER
Message-ID: <201908281100.D78277FD@keescook>
References: <20190822205533.4877-1-david.abdurachmanov@sifive.com>
 <201908251451.73C6812E8@keescook>
 <419CB0D1-E51C-49D5-9745-7771C863462F@amacapital.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <419CB0D1-E51C-49D5-9745-7771C863462F@amacapital.net>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 28, 2019 at 10:52:05AM -0700, Andy Lutomirski wrote:
> 
> 
> > On Aug 25, 2019, at 2:59 PM, Kees Cook <keescook@chromium.org> wrote:
> > 
> >> On Thu, Aug 22, 2019 at 01:55:22PM -0700, David Abdurachmanov wrote:
> >> This patch was extensively tested on Fedora/RISCV (applied by default on
> >> top of 5.2-rc7 kernel for <2 months). The patch was also tested with 5.3-rc
> >> on QEMU and SiFive Unleashed board.
> > 
> > Oops, I see the mention of QEMU here. Where's the best place to find
> > instructions on creating a qemu riscv image/environment?
> 
> I don’t suppose one of you riscv folks would like to contribute riscv support to virtme?  virtme-run —arch=riscv would be quite nice, and the total patch should be just a couple lines.  Unfortunately, it helps a lot to understand the subtleties of booting the architecture to write those couple lines :)

As it turns out, this is where I'm stuck. All the instructions I can
find are about booting a kernel off a disk image. :(

-- 
Kees Cook
