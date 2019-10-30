Return-Path: <SRS0=iR9I=YX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9275CCA9EC5
	for <linux-kernel@archiver.kernel.org>; Wed, 30 Oct 2019 20:26:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5E972205C9
	for <linux-kernel@archiver.kernel.org>; Wed, 30 Oct 2019 20:26:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=intel-com.20150623.gappssmtp.com header.i=@intel-com.20150623.gappssmtp.com header.b="YljXv7Q1"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726774AbfJ3UZ7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 30 Oct 2019 16:25:59 -0400
Received: from mail-oi1-f195.google.com ([209.85.167.195]:40647 "EHLO
        mail-oi1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726483AbfJ3UZ6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Oct 2019 16:25:58 -0400
Received: by mail-oi1-f195.google.com with SMTP id r27so3168269oij.7
        for <linux-kernel@vger.kernel.org>; Wed, 30 Oct 2019 13:25:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=DB0Esgn2u6S/gYy4ztTMEgAHIadfdnSppVecXQR/BmQ=;
        b=YljXv7Q1wxqnCkVDdMgZtofx2rSTMM1fz2RXU61tBTgnlP0XWpsjt2e7fOAXcaulgw
         zP1YXn3xn0NIogw5hHNK/JbZWlmG/cB8fKERqX+qByERFbGGXqazPfY1UsGLe6FhzMr5
         meg8weMmaWBQE6H8xDtwkQLPnHopTbzo+VKpyITAF1/FRiX8D5as90CncBFlzGxtE7Xx
         6lWql9xMWWreZiUhbqTxlvLrJOCpCG9BTIBbzIBVOYt0wSCOvxlR/M5RFH5gpKakutd2
         SEjKKcyvzAVAIPpGbUQK8yrvAd9WidP8NL4G1Tf0MV8TQ64vDliHg22CQl+RvphcQRDA
         PVEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=DB0Esgn2u6S/gYy4ztTMEgAHIadfdnSppVecXQR/BmQ=;
        b=WzgiyQVofj5icDihDgzlrn2+HgK3J8Wa91EBivKCONFamcVQ90O8T7XtY7S94GbHKy
         ZroXmfKDc7ZT8hE7xaaOtjq28Vl+zu3+nUE7LzIlPwmM7fBXIdgHlp1L3YfV2lBaosBT
         hXjkjyqVJR+drwEy7BqFupZttHn7uuw95kV0RE1jYg7atib5v9LSxk6hbUQUHZBWLSTP
         wY7FCBYyLnBHpPSvmPOgpp3iucv04fTYdmz8RzWzWAIxzB6I8KZEHyswvsAlwIxk+MIy
         B2UIXO8C1EAuZcO0vfNIXaINRP2ruirwb6+hKHWa0EFefjMe8gSbaM66X4s6oSviaPdL
         aiTA==
X-Gm-Message-State: APjAAAXO6VUk5IPZlVWckxlaQHZGzX3dFohpee98qyb71PslQs83Pl3n
        1UunXgdMdybITLi8Wdafzd5Yg3ALkhYsbIKR1+NOew==
X-Google-Smtp-Source: APXvYqxjoPtFXRn8Md6QTlvFeMTbTacSemsUejC32ZRefBEyCk6rhqYcrCf8nNLaTgsDOrV06arS1pSWZ+A1j8byPas=
X-Received: by 2002:aca:ad52:: with SMTP id w79mr915721oie.149.1572467158050;
 Wed, 30 Oct 2019 13:25:58 -0700 (PDT)
MIME-Version: 1.0
References: <1572462939-18201-1-git-send-email-cai@lca.pw>
In-Reply-To: <1572462939-18201-1-git-send-email-cai@lca.pw>
From:   Dan Williams <dan.j.williams@intel.com>
Date:   Wed, 30 Oct 2019 13:25:47 -0700
Message-ID: <CAPcyv4jvoo2Ez5hMivt+-B3-9giX3v6VZ0xZWLBQzL=7spVnrg@mail.gmail.com>
Subject: Re: [PATCH] nvdimm/btt: fix variable 'rc' set but not used
To:     Qian Cai <cai@lca.pw>
Cc:     Vishal L Verma <vishal.l.verma@intel.com>,
        Dave Jiang <dave.jiang@intel.com>,
        Keith Busch <keith.busch@intel.com>,
        "Weiny, Ira" <ira.weiny@intel.com>,
        linux-nvdimm <linux-nvdimm@lists.01.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 30, 2019 at 12:16 PM Qian Cai <cai@lca.pw> wrote:
>
> drivers/nvdimm/btt.c: In function 'btt_read_pg':
> drivers/nvdimm/btt.c:1264:8: warning: variable 'rc' set but not used
> [-Wunused-but-set-variable]
>     int rc;
>         ^~
>
> Add a ratelimited message in case a storm of errors is encountered.
>
> Fixes: d9b83c756953 ("libnvdimm, btt: rework error clearing")
> Signed-off-by: Qian Cai <cai@lca.pw>
> ---
>  drivers/nvdimm/btt.c | 5 +++++
>  1 file changed, 5 insertions(+)
>
> diff --git a/drivers/nvdimm/btt.c b/drivers/nvdimm/btt.c
> index 3e9f45aec8d1..59852f7e2d60 100644
> --- a/drivers/nvdimm/btt.c
> +++ b/drivers/nvdimm/btt.c
> @@ -1266,6 +1266,11 @@ static int btt_read_pg(struct btt *btt, struct bio_integrity_payload *bip,
>                         /* Media error - set the e_flag */
>                         rc = btt_map_write(arena, premap, postmap, 0, 1,
>                                 NVDIMM_IO_ATOMIC);
> +
> +                       if (rc)
> +                               dev_warn_ratelimited(to_dev(arena),
> +                                       "Error persistently tracking bad blocks\n");

If the driver is going to warn about bad blocks it should at least
include the block address that is returning an error.
