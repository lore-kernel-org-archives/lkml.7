Return-Path: <SRS0=zoc3=WI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 71DAFC433FF
	for <linux-kernel@archiver.kernel.org>; Mon, 12 Aug 2019 22:18:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3CD14206A2
	for <linux-kernel@archiver.kernel.org>; Mon, 12 Aug 2019 22:18:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="O65SFc+m"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726859AbfHLWSe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 12 Aug 2019 18:18:34 -0400
Received: from mail-lf1-f67.google.com ([209.85.167.67]:37086 "EHLO
        mail-lf1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726236AbfHLWSe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Aug 2019 18:18:34 -0400
Received: by mail-lf1-f67.google.com with SMTP id c9so75292953lfh.4
        for <linux-kernel@vger.kernel.org>; Mon, 12 Aug 2019 15:18:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=bjZBUUnNFxwJGlVfiZU7+VhObtD1C6m0LDp2PvbJtzg=;
        b=O65SFc+mJYs+E9Cf4OIYCXxNY52bIE6S3QBlXC1V+l7rKq78RbsFJduqVoVuDazYiS
         590oN0acJw181l6fgoQpGFSHJ0GJazZVZgwyImRJxxnzjT0pIcMvwK4uhOISUD9ZtIoa
         sAmR41hpmGyE0RNHnBjaxk65Ej0DyeOcqwOWDk8A2IszJzgSbLnxU6qjZlXAxAWYPPdz
         IxC899xsC5WnI9tmxX8Pj9HE87u+ukTAM4K8ptSNuUUNBwGS3WLv6vFMeoPmr8ZNP3Li
         vGkxlmBUdUnpOWS/INHeqsEPSgX4CQv28Znv1+osdKtQ+hf43HKWIpRl7SnI18oAjXPR
         rMww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=bjZBUUnNFxwJGlVfiZU7+VhObtD1C6m0LDp2PvbJtzg=;
        b=mpRvaLvMNip3oOfUt3Va2PoFLeoyAP0K8pKlMyLZXJ2Z6qmtw0IVi7qtKKKjeFWbDp
         cAE5zcJeq6FJgfkaSSewG6WSOZ+NfQ7+bfmC1DxkwU3QCpBvXosk3UK9FfLaMklQYICO
         ab7fBCEecgwpJwGLy1TboVV+sBb7am1ysHv37YmCDuYYjbfnqvm1N6ufudftEoiait8V
         qaW48yfkx6KKWc9OLaogjOXA42+x3aZ0GrGBgjaxRGgQyTKSmxlvcE8i7IS+G3X9QsfS
         zdO3/5YruusxECinqRRQgdVuZmkXQn0aoRL9hhXcgDQrHihiw3sfcPIGBDKsLqAxfvOj
         9jXA==
X-Gm-Message-State: APjAAAVq2b/zXA/YmRejxoy5nuBVAg5Wn/wKWljXiPjfRuRpmGXsemI1
        3xJuTRYipiUHK8bv369s9Y1nqOudQ0lQGT2U5B0=
X-Google-Smtp-Source: APXvYqwJ6NXsiU2BfOlM2DiAzfb4TVZo4dKyXwC5KM6xjo+boKWcuQbtK/pWuQf3lzb4FAd8/9Gpki/uuwFCpKXJR5g=
X-Received: by 2002:ac2:46ea:: with SMTP id q10mr20552516lfo.118.1565648312549;
 Mon, 12 Aug 2019 15:18:32 -0700 (PDT)
MIME-Version: 1.0
References: <alpine.DEB.2.21.9999.1908061929230.19468@viisi.sifive.com>
 <CAEUhbmVTM2OUnX-gnBZw5oqU+1MwdYkErrOnA3NGJKh5gxULng@mail.gmail.com>
 <CAMabmMJ3beMcs38Boe11qcsQvqY+9u=2OqA0vCSKdL=n-cK9GQ@mail.gmail.com> <20190812150348.GH26897@infradead.org>
In-Reply-To: <20190812150348.GH26897@infradead.org>
From:   Charles Papon <charles.papon.90@gmail.com>
Date:   Tue, 13 Aug 2019 00:18:22 +0200
Message-ID: <CAMabmM+YX3L-J1GCvDaC9H66YMArfs6PuKCsE_dNMBtApOxZig@mail.gmail.com>
Subject: Re: [PATCH] riscv: kbuild: drop CONFIG_RISCV_ISA_C
To:     Christoph Hellwig <hch@infradead.org>
Cc:     Bin Meng <bmeng.cn@gmail.com>, Atish Patra <atish.patra@wdc.com>,
        linux-riscv <linux-riscv@lists.infradead.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Paul Walmsley <paul.walmsley@sifive.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> Because it it the unix platform baseline as stated in the patch.
I know that, but i'm looking for arguments why RVC could't be kept as
an option, especialy it is only an optimisation option without
behavioral/code changes.

That baseline make sense for heavy linux distributions, where you
expect everybody to compile with a baseline set of ISA extentions, to
make binary exchanges easier.
But for smaller systems, i do not see advantages having RVC forced.

On Mon, Aug 12, 2019 at 5:03 PM Christoph Hellwig <hch@infradead.org> wrote:
>
> On Thu, Aug 08, 2019 at 02:18:53PM +0200, Charles Papon wrote:
> > Please do not drop it.
> >
> > Compressed instruction extension has some specific overhead in small
> > RISC-V FPGA softcore, especialy in the ones which can't implement the
> > register file read in a asynchronous manner because of the FPGA
> > technology.
> > What are reasons to enforce RVC ?
>
> Because it it the unix platform baseline as stated in the patch.
