Return-Path: <SRS0=embV=XF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D9AC2C49ED9
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Sep 2019 16:42:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A7D7A2081B
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Sep 2019 16:42:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kudzu-us.20150623.gappssmtp.com header.i=@kudzu-us.20150623.gappssmtp.com header.b="uRXjz1M6"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2436844AbfIJQmW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 10 Sep 2019 12:42:22 -0400
Received: from mail-io1-f65.google.com ([209.85.166.65]:40022 "EHLO
        mail-io1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729580AbfIJQmW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Sep 2019 12:42:22 -0400
Received: by mail-io1-f65.google.com with SMTP id h144so38969835iof.7
        for <linux-kernel@vger.kernel.org>; Tue, 10 Sep 2019 09:42:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kudzu-us.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=MD4aD1X+KEJ08d//fNXS33g75U6oRemG6qaqU7rs6pc=;
        b=uRXjz1M6NVDVwwCkwNevTH9yod5v4v170KCgZ924c4JyS/5uZTyr8Go4LoHl/0z5A0
         J0eE//IHR8reLBOrzdxCY2nUnNPrNc5mQnb3wesnlcKOxB7rR3LaWGS7VYzdY/UNPZMw
         p+Ewe73lpD7Z2I5ej2Yr6DwtEwH73kGPMp/YRbfhNFyGvp9GUr57lfB64StSV1XWmivb
         IjoZt/PPa9FDonmkOsjnbIizPKQHVPr458nF07TWgB8BOmykVGypx2ECp/97Sx14Q2PA
         t08DCHHc2mYGFCSkXzAER9KZnWFMUHBxTmbhB6UlA1cDbBozNG/cavEKTBeGBFyjaZDE
         bwdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=MD4aD1X+KEJ08d//fNXS33g75U6oRemG6qaqU7rs6pc=;
        b=IMLtRvnU7q2M2Ney23HIbvj+KNEOsiAxFsu1FJg9xzzF5JdE41CvQ/uf6bdrRal6cq
         oFNCBwPZuT4Y9NYCTaA2ibvtcIeVq/ZGYylYuYQzyfEFxbTM5D03lZzQPf1JPciYVzPY
         mV+B69PirK4g2MLbdxRsppTpTpyzxBvIBdA7yYPRnN3xeYPj/Z3PpaT5CSk3BfbAsr5P
         AhtzqCWEN0x7oLr9C0T9yk8/UMNBtameXueYPEeuGutWHLMCuOXyK2UPiItl+SOCyvuE
         d0GkQyyELgkpg2Vocx11AVlAY8dxH/LO/oEacNgF5QN0AnyG4FRChLMjFxcq0ZFLofXu
         ReVw==
X-Gm-Message-State: APjAAAUZ6OmtCxHg4j5VqxsAaFthFPCkGBYPw2JpdrQ1KzEc9pGxFD6N
        CtWlUoM4g+83BPwHPRlj3C0sb5D3QzeGYGBanh98Yg==
X-Google-Smtp-Source: APXvYqxhDyGetbvDNDK4cuwvWWq+bj7yylsMeNOfW1PtUwx1KH/yseNQK3Ta9dGBpfhMQ4Wufz0bnzGcYoerdVSDzoU=
X-Received: by 2002:a5d:951a:: with SMTP id d26mr6730731iom.31.1568133740200;
 Tue, 10 Sep 2019 09:42:20 -0700 (PDT)
MIME-Version: 1.0
References: <1553859137-4439-1-git-send-email-Sanju.Mehta@amd.com> <MN2PR12MB3455BFCFE060E38FEDF686E1E52E0@MN2PR12MB3455.namprd12.prod.outlook.com>
In-Reply-To: <MN2PR12MB3455BFCFE060E38FEDF686E1E52E0@MN2PR12MB3455.namprd12.prod.outlook.com>
From:   Jon Mason <jdmason@kudzu.us>
Date:   Tue, 10 Sep 2019 17:42:12 +0100
Message-ID: <CAPoiz9wqa4zhhitBeu8XDvOckhVWpEviPdk=UTCh-pLUvk9QvQ@mail.gmail.com>
Subject: Re: [PATCH] point to right memory window index
To:     "Mehta, Sanju" <Sanju.Mehta@amd.com>
Cc:     "dave.jiang@intel.com" <dave.jiang@intel.com>,
        "allenbh@gmail.com" <allenbh@gmail.com>,
        "linux-ntb@googlegroups.com" <linux-ntb@googlegroups.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "S-k, Shyam-sundar" <Shyam-sundar.S-k@amd.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 10, 2019 at 11:24 AM Mehta, Sanju <Sanju.Mehta@amd.com> wrote:
>
> Hi All,
>
> Any comments on below patch?

I wasn't cc'ed, so this one missed my inbox.  Applied to ntb-next, thanks.

>
> Thanks & Regards,
> Sanjay Mehta
>
> -----Original Message-----
> From: Mehta, Sanju <Sanju.Mehta@amd.com>
> Sent: Friday, March 29, 2019 5:03 PM
> To: S-k, Shyam-sundar <Shyam-sundar.S-k@amd.com>; jdmason@kudzu.us; dave.jiang@intel.com; allenbh@gmail.com
> Cc: linux-ntb@googlegroups.com; linux-kernel@vger.kernel.org; Mehta, Sanju <Sanju.Mehta@amd.com>
> Subject: [PATCH] point to right memory window index
>
> From: Sanjay R Mehta <sanju.mehta@amd.com>
>
> second parameter of ntb_peer_mw_get_addr is pointing to wrong memory window index by passing "peer gidx" instead of "local gidx".
>
> For ex, "local gidx" value is '0' and "peer gidx" value is '1', then
>
> on peer side ntb_mw_set_trans() api is used as below with gidx pointing to local side gidx which is '0', so memroy window '0' is chosen and XLAT '0'
> will be programmed by peer side.
>
>     ntb_mw_set_trans(perf->ntb, peer->pidx, peer->gidx, peer->inbuf_xlat,
>                     peer->inbuf_size);
>
> Now, on local side ntb_peer_mw_get_addr() is been used as below with gidx pointing to "peer gidx" which is '1', so pointing to memory window '1'
> instead of memory window '0'.
>
>     ntb_peer_mw_get_addr(perf->ntb,  peer->gidx, &phys_addr,
>                         &peer->outbuf_size);
>
> So this patch pass "local gidx" as parameter to ntb_peer_mw_get_addr().
>
> Signed-off-by: Sanjay R Mehta <sanju.mehta@amd.com>
> ---
>  drivers/ntb/test/ntb_perf.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/ntb/test/ntb_perf.c b/drivers/ntb/test/ntb_perf.c index c7d1a48..08e18d7 100644
> --- a/drivers/ntb/test/ntb_perf.c
> +++ b/drivers/ntb/test/ntb_perf.c
> @@ -1381,7 +1381,7 @@ static int perf_setup_peer_mw(struct perf_peer *peer)
>         int ret;
>
>         /* Get outbound MW parameters and map it */
> -       ret = ntb_peer_mw_get_addr(perf->ntb, peer->gidx, &phys_addr,
> +       ret = ntb_peer_mw_get_addr(perf->ntb, perf->gidx, &phys_addr,
>                                    &peer->outbuf_size);
>         if (ret)
>                 return ret;
> --
> 2.7.4
>
