Return-Path: <SRS0=54v9=YS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C0581CA9EA0
	for <linux-kernel@archiver.kernel.org>; Fri, 25 Oct 2019 22:45:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8F60521D7F
	for <linux-kernel@archiver.kernel.org>; Fri, 25 Oct 2019 22:45:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=intel-com.20150623.gappssmtp.com header.i=@intel-com.20150623.gappssmtp.com header.b="I0aloD8x"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726283AbfJYWpp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 25 Oct 2019 18:45:45 -0400
Received: from mail-qt1-f194.google.com ([209.85.160.194]:39187 "EHLO
        mail-qt1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725881AbfJYWpp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Oct 2019 18:45:45 -0400
Received: by mail-qt1-f194.google.com with SMTP id t8so5667397qtc.6
        for <linux-kernel@vger.kernel.org>; Fri, 25 Oct 2019 15:45:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=4DYywa8gONdexolDcaR4V0aX/JK63D5OgCkX4AmxYjM=;
        b=I0aloD8xas/075MWzchVZHS0wcDNzZnYmgSqnSVwoh6XglP1H5IIloMzB6c/VVfkjt
         I9b0mN0tuuXtua87BfCpt4l7cJlJAurRikm7ONSk9LwLkEgHrhCONdV/QRZ6TYqlBC7b
         KqvfixMs3DBdd8K6qZoRwBnzYgGbgeI8eo7iSPTL1wJJ+Z7kNfkQ+dJhuARHYvaEreQH
         b8g3REB4sn2z5R5HaMXvW2dQZOadlP9Ia/TLFBYOW3KhW4tYQcclDurwovbWhJVe/VJT
         mN4kfjK/D0jLvg1P19r91OJWmnlpXMc6LGqdDzto59BK/TZpsltWYDq57ksdJmhmsE/q
         y4Ow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=4DYywa8gONdexolDcaR4V0aX/JK63D5OgCkX4AmxYjM=;
        b=S4Fz+FysgiBbT696eCdFYOu9yOT9/Hg4OroqoxmYUz2HKpXifyxRl67ucEpxZxpo+Y
         UFYHJr2S1meMglksqUnOXvS0giA6oXbi1E3MO5Rb2qUiPVKrLF6yN2yz4oZ/Ngc9y+p2
         WFhTb+7xrrs57EoOEZ7mxUq48vdGADU3UZsGHK2CBgrdybcXr/4ADGjQkejvqtP/Cv8l
         85bYA/09rpMzOzee5owAOoQqeAawSERdiKAp721ZrxohU9pogVsp5xv6FfojGbEWp2lK
         7Kx6lp2EGJNoyJ5c981vIr52AR8cyrH1XEZXTf/OQwUwy1SY48pX/e70xSIm2iM42480
         Hf/Q==
X-Gm-Message-State: APjAAAUop8JwxMmJHNywNLkz2yTDlO9TUF1BRriyvSyD1XzTx+0ffn2E
        RZqThg5XjOfixH/34OL02JfsniTkzK3z0j0TMW+HiA==
X-Google-Smtp-Source: APXvYqzy7VtFTfrpPLjnQlO6ySEwY9RkrlXI8yizPrLMlhzT28dBaqq8uErfsoVFeBdn1EAHmE3bhLbMtWcD/J+SLo0=
X-Received: by 2002:ac8:4241:: with SMTP id r1mr5773124qtm.111.1572043544756;
 Fri, 25 Oct 2019 15:45:44 -0700 (PDT)
MIME-Version: 1.0
References: <20191025175553.63271-1-d.scott.phillips@intel.com>
In-Reply-To: <20191025175553.63271-1-d.scott.phillips@intel.com>
From:   Dan Williams <dan.j.williams@intel.com>
Date:   Fri, 25 Oct 2019 15:45:33 -0700
Message-ID: <CAPcyv4iQpO+JF8b7NUJUZ3fQFU=PWFeiWrXSd47QGnQPeRsrTg@mail.gmail.com>
Subject: Re: [PATCH] uapi: Add the BSD-2-Clause license to ndctl.h
To:     D Scott Phillips <d.scott.phillips@intel.com>
Cc:     David Howells <dhowells@redhat.com>,
        Dexuan Cui <decui@microsoft.com>,
        Jerry Hoemann <jerry.hoemann@hpe.com>,
        stuart hayes <stuart.w.hayes@gmail.com>,
        Toshi Kani <toshi.kani@hpe.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        linux-nvdimm <linux-nvdimm@lists.01.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 25, 2019 at 10:55 AM D Scott Phillips
<d.scott.phillips@intel.com> wrote:
>
> Allow ndctl.h to be licensed with BSD-2-Clause so that other
> operating systems can provide the same user level interface.
> ---
>
> I've been working on nvdimm support in FreeBSD and would like to
> offer the same ndctl API there to ease porting of application
> code. Here I'm proposing to add the BSD-2-Clause license to this
> header file, so that it can later be copied into FreeBSD.
>
> I believe that all the authors of changes to this file (in the To:
> list) would need to agree to this change before it could be
> accepted, so any signed-off-by is intentionally ommited for now.
> Thanks,

I have no problem with this change, but let's take the opportunity to
let SPDX do its job and drop the full license text.
