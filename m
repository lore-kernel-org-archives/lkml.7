Return-Path: <SRS0=Osat=YE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 855A0C10F14
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Oct 2019 00:37:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4C8772190F
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Oct 2019 00:37:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=ucr.edu header.i=@ucr.edu header.b="m8x+hKa4"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727720AbfJKAhX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 10 Oct 2019 20:37:23 -0400
Received: from mx2.ucr.edu ([138.23.62.3]:47525 "EHLO mx2.ucr.edu"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726096AbfJKAhW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Oct 2019 20:37:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=ucr.edu; i=@ucr.edu; q=dns/txt; s=selector3;
  t=1570754242; x=1602290242;
  h=mime-version:references:in-reply-to:from:date:message-id:
   subject:to:cc;
  bh=uXv2UQ3LODrzT9UfKJz+VhFwzGfiQWvz0Klpty0YInQ=;
  b=m8x+hKa4K0wS9q71aRam5CJu8pE7no+UxIhC7lu20IS7gFISlD9gmAmy
   XQeots17UT9hyO61SAP+nGWqy/TUSHldNgcEtMY5rmkeIrd/Efq+r9Vus
   ybjArvOxtmLf01PRVHx222/5sqDHPic6XHOCKUAe/Kv99ycp75uHVLH3H
   lz/Fm3/HN+pRozgdo9aiLifA10dgfuPHt/Oo6PmmXDuscYz+isLrjPkxx
   4hXzgbsvYKWBZCtjmlzhCMqXLUJJ7K06RMoevjFDFq36km6tIruoQdW8p
   rPPe8D5ijgjsYlUtunMYIWVd8KLBhW1tHclFe9gcajZPXM1mYGEHN/0wG
   Q==;
IronPort-SDR: OwS5XaTO7yTtJSLBnMg5ZS8QYmO1/lnrverrCWc2R8QlMcbC2GuJJ6XrH47Nor/FTxTdjcINnU
 etoNAYKI2GMDsk5d+pR4i6snD16y/EbA1R3olTBM0yN8orD8xZphllrCgqCx29Yt0q1qv4LmfE
 HhwnLJw7vHYt4aYpA1Huk7gZ56daAiHz9zq8vzaMGB6gMlGYbVSy4a5iTqGMr8e4BoQvc23GCh
 0pUWt0qOygsUgWqh4UeRILaIhAc/p2cfB7iOyPEcz3h/pYZ9w/T7H4hNMu8axrLOpHXzMNuNvZ
 7OM=
IronPort-PHdr: =?us-ascii?q?9a23=3AbrCokhPB9/Tx2QCTb/cl6mtUPXoX/o7sNwtQ0K?=
 =?us-ascii?q?IMzox0LfT+rarrMEGX3/hxlliBBdydt6sfzbSK+Pu9EUU7or+5+EgYd5JNUx?=
 =?us-ascii?q?JXwe43pCcHRPC/NEvgMfTxZDY7FskRHHVs/nW8LFQHUJ2mPw6arXK99yMdFQ?=
 =?us-ascii?q?viPgRpOOv1BpTSj8Oq3Oyu5pHfeQpFiCezbL9oLRi7ogrdu8cWjIB/Nqs/1x?=
 =?us-ascii?q?zFr2dSde9L321oP1WTnxj95se04pFu9jlbtuwi+cBdT6j0Zrw0QrNEAjsoNW?=
 =?us-ascii?q?A1/9DrugLYTQST/HscU34ZnQRODgPY8Rz1RJbxsi/9tupgxCmXOND9QL4oVT?=
 =?us-ascii?q?i+6apgVQTlgzkbOTEn7G7Xi9RwjKNFrxKnuxx/2JPfbIWMOPZjYq/RYdYWSG?=
 =?us-ascii?q?xcVchTSiNBGJuxYIQBD+UDPehWoYrzqUYQoxSiHgSsGP/jxyVUinPqwaE30e?=
 =?us-ascii?q?IsGhzG0gw6GNIOtWzZo9f0NKYTUeC10a7IxijAYPNWwzj96ZXDfxchoPCNXb?=
 =?us-ascii?q?J/a8vRxVUzGw7LlViQtJDqPymP2usTrmeb8vNtWOSygGAkswF8uiajytsoh4?=
 =?us-ascii?q?XThY8YykrI+TtlzIs2P9G0VUp2bN2iHZBNrS+VLZF2TdknQ2xwvSY6zaAJto?=
 =?us-ascii?q?CjcSgRzZQn2wbfa/uac4iU+h7jVPieITN/hH99fbKwnRey8Uy5xu34VMm4zU?=
 =?us-ascii?q?9GriRYntTItX0BzRPT6s+ASvty+keuxyyD2BzU6uFBOUw0lKzbJIA9wrMoiJ?=
 =?us-ascii?q?YfrUDOEjX1lUj2lqOaaFko9+uy5+j6ZrjrpYeQN4puhQH/NqQulNa/AeM9Mg?=
 =?us-ascii?q?UWX2ma+OS826fi/UHlXLlHgOY7krTFv5DAP8gUuLO2AxJN3oY59xm/Fyum0M?=
 =?us-ascii?q?gfnXQfKFJFeRSHj5XmOl3XI/D3E+2/g1Kynzdv3P3GILLhDYvXLnTZk7fuY6?=
 =?us-ascii?q?x960hCxwo319xf4IhUCr5SaM70D2P4spTzBwUhPgqozvyvXNl00MUVUHiXD6?=
 =?us-ascii?q?mFPbn6tkWB7eYiZeKLYdlGliz6Lq0U5uzukHhxq18UfOH9zIkXYXHgRq9OPk?=
 =?us-ascii?q?6DJ3fgn4FSQi8xogMiQbmy2xW5WjlJaiP3Bvpk6w=3D=3D?=
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-Anti-Spam-Result: =?us-ascii?q?A2F7AAAwzp9dh8bQVdFmHAEBAQEBBwE?=
 =?us-ascii?q?BEQEEBAEBgWoEAQELAYQQKoQjjl2CD5slAQgBAQEOLwEBhEACgl0jNwYOAgM?=
 =?us-ascii?q?JAQEFAQEBAQEFBAEBAhABAQEIDQkIKYVAgjopAYM9AQEBAxIRVhALCw0CAiY?=
 =?us-ascii?q?CAiISAQUBHAYTIoMAgnilS4EDPIsmgTKIYgEJDYFIEnooAYwNgheEIz6HUoJ?=
 =?us-ascii?q?eBIE5AQEBlS+WVwEGAoIQFIxUiEUbmUCnfA8jgUWBfDMaJX8GZ4FOUBAUgWm?=
 =?us-ascii?q?OTCQwkHYBAQ?=
X-IPAS-Result: =?us-ascii?q?A2F7AAAwzp9dh8bQVdFmHAEBAQEBBwEBEQEEBAEBgWoEA?=
 =?us-ascii?q?QELAYQQKoQjjl2CD5slAQgBAQEOLwEBhEACgl0jNwYOAgMJAQEFAQEBAQEFB?=
 =?us-ascii?q?AEBAhABAQEIDQkIKYVAgjopAYM9AQEBAxIRVhALCw0CAiYCAiISAQUBHAYTI?=
 =?us-ascii?q?oMAgnilS4EDPIsmgTKIYgEJDYFIEnooAYwNgheEIz6HUoJeBIE5AQEBlS+WV?=
 =?us-ascii?q?wEGAoIQFIxUiEUbmUCnfA8jgUWBfDMaJX8GZ4FOUBAUgWmOTCQwkHYBAQ?=
X-IronPort-AV: E=Sophos;i="5.67,282,1566889200"; 
   d="scan'208";a="14356903"
Received: from mail-lj1-f198.google.com ([209.85.208.198])
  by smtp2.ucr.edu with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 10 Oct 2019 17:37:17 -0700
Received: by mail-lj1-f198.google.com with SMTP id 5so1378086lje.12
        for <linux-kernel@vger.kernel.org>; Thu, 10 Oct 2019 17:37:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ZcWxfPlnGPAO2yo7t6F26rix4NWYfye93UCn2ZNXKJ8=;
        b=B8W4tgekiTIQH1OtRoXHRqMjMod1YoUWnqRST4tLXc3DIXtk6ETqn5Jrr8rFq/x2ae
         CnHAb7Rh2STbIa1tErNjDjqZqLupUSFrOM3AgbXzinBJvEvuDTeZgZOWX42+W/oaKsgs
         E47lbRmfuNMuOWd4SI6m5dOUjr3zbFQXeH3t6G62GP1f+nSWxSn1sJzzFb7i7MDTD31X
         DuVg3vd/+OcoMIQ6fvojmYk6/9A+wF70M809SevaWHa/S6fC6RXDcsLpxkj3sbc2K1yI
         4NnrnilMV5FizJNaKHkly1BcCwC9+YahUdGuiDLr9TgohABz13V1h0qU9Z9vJH/9JQ0s
         JkSA==
X-Gm-Message-State: APjAAAW9MQWyze/bMwtBbhb1NpsnuL6vDw8h2V+mPx1/jR2F4PGpSETj
        h7Y9hicPKi65GWUmKe4cNVCowYb/rL9aTvswDtfOXPblUjT0PsTN7s0AOgkt70uAeMLLrB5XTZZ
        4c2UNmBsmTF36uAqWxHbHNRv777lHp+GTH4pmSA/U/Q==
X-Received: by 2002:a19:ee08:: with SMTP id g8mr2680860lfb.117.1570754235351;
        Thu, 10 Oct 2019 17:37:15 -0700 (PDT)
X-Google-Smtp-Source: APXvYqwbqzp9i04wuktQmil7d0bMJlOGaeRnmQG5uBtRDRKLB00XbM3BrsBPCdcJjoQsH+RggVfxOXKBguWYLkvp+gg=
X-Received: by 2002:a19:ee08:: with SMTP id g8mr2680852lfb.117.1570754235067;
 Thu, 10 Oct 2019 17:37:15 -0700 (PDT)
MIME-Version: 1.0
References: <20191010043809.27594-1-yzhai003@ucr.edu> <20191010091834.GG20470@kadam>
In-Reply-To: <20191010091834.GG20470@kadam>
From:   Yizhuo Zhai <yzhai003@ucr.edu>
Date:   Thu, 10 Oct 2019 17:37:56 -0700
Message-ID: <CABvMjLQ+_rRJT_yeKE9AKJaxhSU5LbcZdenbOr8CdPoD+4Oprw@mail.gmail.com>
Subject: Re: [PATCH] staging: sm750fb: Potential uninitialized field in "pll"
To:     Dan Carpenter <dan.carpenter@oracle.com>
Cc:     devel@driverdev.osuosl.org, linux-fbdev@vger.kernel.org,
        Teddy Wang <teddy.wang@siliconmotion.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org,
        Sudip Mukherjee <sudipm.mukherjee@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Sorry about that, let me resend it .

On Thu, Oct 10, 2019 at 2:53 AM Dan Carpenter <dan.carpenter@oracle.com> wrote:
>
> On Wed, Oct 09, 2019 at 09:38:08PM -0700, Yizhuo wrote:
> > Inside function set_chip_clock(), struct pll is supposed to be
> > initialized in sm750_calc_pll_value(), if condition
> > "diff < mini_diff" in sm750_calc_pll_value() cannot be fulfilled,
> > then some field of pll will not be initialized but used in
> > function sm750_format_pll_reg(), which is potentially unsafe.
> >
> > Signed-off-by: Yizhuo <yzhai003@ucr.edu>
>
> The patch is correct, but it doesn't apply to linux-next any more.  Can
> you re-write it on top of the most recent staging-next and resend?
>
> regards,
> dan carpenter
>


-- 
Kind Regards,

Yizhuo Zhai

Computer Science, Graduate Student
University of California, Riverside
