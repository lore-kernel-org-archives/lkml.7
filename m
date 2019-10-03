Return-Path: <SRS0=6dNS=X4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 41783C10F14
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Oct 2019 17:42:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 19AC420865
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Oct 2019 17:42:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=ucr.edu header.i=@ucr.edu header.b="SpaGV/wa"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390368AbfJCRmU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 3 Oct 2019 13:42:20 -0400
Received: from mx5.ucr.edu ([138.23.62.67]:47406 "EHLO mx5.ucr.edu"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730945AbfJCRmR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Oct 2019 13:42:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=ucr.edu; i=@ucr.edu; q=dns/txt; s=selector3;
  t=1570124537; x=1601660537;
  h=mime-version:references:in-reply-to:from:date:message-id:
   subject:to:cc;
  bh=2oSVnWrA/ed2JzasVs3JgdgieJU/Tv5Q4JjDOo4kYyI=;
  b=SpaGV/wayM93jNINO+cvDhmNcdyLInESdxEmD9+E8tDQPhnoMQ3jW1N5
   6g1N3IfICH01AxEldzCWLSVM4WVBLrHo3Oss9czziYzGtKLcODVVuS8Bp
   /OFrXEZEdjxqttoNf8EoRPMaCh8Yo+SSsbAXFqeUnTBHLy6bekthyEupC
   X3Q0nFfrTkkGPxomo2j5Q9CJXYFmMZv3KlM2VdgdsTLBnLs3enNQavuQ4
   aV1r5NkaDmvDLfe7sbIPhKUclRE4JOoXEC5BnvD5LrNm+rE9cQdPLcEef
   yoT1kYunZLVrA4Ih+SIomGYVvpaUZr5SO4+HdfUeSjxDXEOQnIZlsmPsf
   g==;
IronPort-SDR: 7yFG385H+NjQx2c4MMYsQvpX9JygRFPnAVIFczh9dl91etTnNR10q2cKXSsOErM7p1ohJJftM1
 xzQxL7db6q8wxRZJ0x6RuD9LSEpIRSJTpyd0pr+UNYc34K06K8YLuVqaY7BK9hC7k50VtyglKg
 rPIWy1089fq/7ZzCmon7m6h4k1O99siPBzHEHdr6PCqC7ZYYb3zcUs26Y2vdsPdhl8DgAsFi9s
 ZPrcQSWVdGxhgKilpGR9vzQNZKrqr/yxfysxUlO/UxHLxRVp4ChFCtXClS4TJCA3Zy9ivAuJzj
 md4=
IronPort-PHdr: =?us-ascii?q?9a23=3ARqJfGRNN92krWgkYiTMl6mtUPXoX/o7sNwtQ0K?=
 =?us-ascii?q?IMzox0LfT5rarrMEGX3/hxlliBBdydt6sfzbaG+Pm5AiQp2tWoiDg6aptCVh?=
 =?us-ascii?q?sI2409vjcLJ4q7M3D9N+PgdCcgHc5PBxdP9nC/NlVJSo6lPwWB6nK94iQPFR?=
 =?us-ascii?q?rhKAF7Ovr6GpLIj8Swyuu+54Dfbx9HiTagb75+Nhq7oAbeusULnIdvJLs6xw?=
 =?us-ascii?q?fUrHdPZ+lY335jK0iJnxb76Mew/Zpj/DpVtvk86cNOUrj0crohQ7BAAzsoL2?=
 =?us-ascii?q?465MvwtRneVgSP/WcTUn8XkhVTHQfI6gzxU4rrvSv7sup93zSaPdHzQLspVz?=
 =?us-ascii?q?mu87tnRRn1gyocKTU37H/YhdBxjKJDoRKuuRp/w5LPYIqIMPZyZ77Rcc8GSW?=
 =?us-ascii?q?ZEWMtaSi5PDZ6mb4YXAOUBM+RXoYnzqVUNsBWwGxWjCfjzyjNUnHL6wbE23/?=
 =?us-ascii?q?gjHAzAwQcuH8gOsHPRrNjtNqgSUOG0zKnVzTXEcvhZ2jf955LJchs8pvyNXb?=
 =?us-ascii?q?NxccrLxkkuCw/JkludpJf4PzyJzOQBqXaU4Pd9Ve+2jWMstgJ/oiC3y8sylo?=
 =?us-ascii?q?XEgpgZx1PE+Clj3oo5Od61RFRlbdK4DJddsTyROZFsTcM4WW5ovT43yrgBuZ?=
 =?us-ascii?q?GmYicH0I8nxxvDa/yfdIiI/w7jWP6RIThmgHJlf6qyhxOo/kihzu3wT8200F?=
 =?us-ascii?q?RXoiZcnNnAqGwB2wDJ5siITft9+Uih2TKR2AzJ9u5EJkU0mbLaK54n3LEwio?=
 =?us-ascii?q?IevVrfEiLygkn7j6+bel869uS06OnreKvqqoOAO4NsjwHxKKUumsixAeQiNQ?=
 =?us-ascii?q?gOWnCW+OS91b3j50L5QalGguE4n6TCrZDVOd4bqrSnDABIz4Yv8wy/ACu+0N?=
 =?us-ascii?q?QEgXkHK0pIeBaGj4jvJlHPL+n0DfShjFS2ljdk2fTGM6b/ApXCMHfDiq3tfb?=
 =?us-ascii?q?Vj5E5Gzgo809Rf64hTCrEbL/KgEnP24fDREB41eym1x+LqEp0p2ooAVGenDq?=
 =?us-ascii?q?aHPabWtlGUoOQiP7/fSpUSvWPMKuol+vmmv38wmBdJbLup1JpPMCuQA/98ZU?=
 =?us-ascii?q?iVfCy/0Z86DW4Ws19mH6TRg1qYXGsWPi7qUg=3D=3D?=
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-Anti-Spam-Result: =?us-ascii?q?A2EZAAA8MpZdgMjQVdFlHAEBAQQBAQw?=
 =?us-ascii?q?EAQGBUwcBAQsBhA8qhCKIIoY7gg+TfoUogXsBCAEBAQ4vAQGEQAKCRiM0CQ4?=
 =?us-ascii?q?CAwkBAQUBAQEBAQUEAQECEAEBCQ0JCCeFQoI6KQGDPAEBAQEDEhEEUhALCwM?=
 =?us-ascii?q?GAQMCAh8HAgIiEgEFARwGEyKDAIILBaIqgQM8ijF1fzOIZgEJDYFIEnooAYw?=
 =?us-ascii?q?NgheDdS4+h1GCWASBNwEBAZUrllIBBgKCERSMVIhEG4I6i3qLDC2nSA8jgS+?=
 =?us-ascii?q?CEjMaJS1SBmeBTlAQFIIHji4kMJFdAQE?=
X-IPAS-Result: =?us-ascii?q?A2EZAAA8MpZdgMjQVdFlHAEBAQQBAQwEAQGBUwcBAQsBh?=
 =?us-ascii?q?A8qhCKIIoY7gg+TfoUogXsBCAEBAQ4vAQGEQAKCRiM0CQ4CAwkBAQUBAQEBA?=
 =?us-ascii?q?QUEAQECEAEBCQ0JCCeFQoI6KQGDPAEBAQEDEhEEUhALCwMGAQMCAh8HAgIiE?=
 =?us-ascii?q?gEFARwGEyKDAIILBaIqgQM8ijF1fzOIZgEJDYFIEnooAYwNgheDdS4+h1GCW?=
 =?us-ascii?q?ASBNwEBAZUrllIBBgKCERSMVIhEG4I6i3qLDC2nSA8jgS+CEjMaJS1SBmeBT?=
 =?us-ascii?q?lAQFIIHji4kMJFdAQE?=
X-IronPort-AV: E=Sophos;i="5.67,253,1566889200"; 
   d="scan'208";a="80445868"
Received: from mail-lj1-f200.google.com ([209.85.208.200])
  by smtpmx5.ucr.edu with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 03 Oct 2019 10:42:16 -0700
Received: by mail-lj1-f200.google.com with SMTP id l13so1088789lji.7
        for <linux-kernel@vger.kernel.org>; Thu, 03 Oct 2019 10:42:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=wd1GZqfs3ucUwfHbxzulPDp/Jo879CDaNWhNw++ir9w=;
        b=rsy+g75NaCHnKzF8Kzyi7vub8k2G4vCZ03b6HIZQRtDqobSr8BRRsvxBWNtvSe4n8K
         W2FqEu75YairoOAj1GN0hTbw6ybXNyaulS+naHix3rk8zC4vvGEFsZ0IeBGxcj7tovG2
         LVZe4h5UjfLSHus4z2Q874AAAmkkusjXzhQKXxiXNo6SEioZ+kP6hJ4eRFJUKhxssssm
         xOF++zMuPQraTcEWllABUV7bkh2S4lhCCTZbrzo3XjwMBVdTKKn52bXLUF2vgx7s5Gey
         f9oOgsakDKgsqzXkLo1dmiApEup90d1IGKo1QiN0eG+YWU8OXbGgAuFN4HK9SFdhbTlQ
         VrbA==
X-Gm-Message-State: APjAAAXd7ijPWHhM5TKs9HCjMCPWjfh+bnnvmNVfwrw4es5Vy6hLpYNU
        7Lorffi+IiaWeD3GxLDxwTV0niIm+la677ZkLu40//pFcqBxey0MxH+qaFWqe0jVZ4vtiIjbHgp
        Es6GiN+JaYrcZc+9h/djPxdSKh5vPIrUV08VOIOFIAQ==
X-Received: by 2002:a2e:89cd:: with SMTP id c13mr6816564ljk.92.1570124534490;
        Thu, 03 Oct 2019 10:42:14 -0700 (PDT)
X-Google-Smtp-Source: APXvYqzgu0O4OmhLkdiHm32veyD7C/ytrOWhZhDZJotP5u235A/EygW4DdMB91Rj/Yujb4YY94JdkOSA+bQNUAlgoYs=
X-Received: by 2002:a2e:89cd:: with SMTP id c13mr6816554ljk.92.1570124534252;
 Thu, 03 Oct 2019 10:42:14 -0700 (PDT)
MIME-Version: 1.0
References: <20191001202439.15766-1-yzhai003@ucr.edu> <20191002.142214.252882219207569928.davem@davemloft.net>
In-Reply-To: <20191002.142214.252882219207569928.davem@davemloft.net>
From:   Yizhuo Zhai <yzhai003@ucr.edu>
Date:   Thu, 3 Oct 2019 10:42:58 -0700
Message-ID: <CABvMjLTzcwN5h+Fn-nNc4VcSr71skh-813u+mCb+EW5wGOT0+g@mail.gmail.com>
Subject: Re: [PATCH] net: hisilicon: Fix usage of uninitialized variable in
 function mdio_sc_cfg_reg_write()
To:     David Miller <davem@davemloft.net>
Cc:     Chengyu Song <csong@cs.ucr.edu>, Zhiyun Qian <zhiyunq@cs.ucr.edu>,
        Yisen Zhuang <yisen.zhuang@huawei.com>,
        Salil Mehta <salil.mehta@huawei.com>, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi David:

Thanks for your feedback. "regmap_write()" could also fail and cause
influence on the caller. If patches for "regmap_write()" are needed,
then the title could be changed from "uninitialized use" to "miss
return check".

On Wed, Oct 2, 2019 at 2:22 PM David Miller <davem@davemloft.net> wrote:
>
> From: Yizhuo <yzhai003@ucr.edu>
> Date: Tue,  1 Oct 2019 13:24:39 -0700
>
> > In function mdio_sc_cfg_reg_write(), variable "reg_value" could be
> > uninitialized if regmap_read() fails. However, "reg_value" is used
> > to decide the control flow later in the if statement, which is
> > potentially unsafe.
> >
> > Signed-off-by: Yizhuo <yzhai003@ucr.edu>
>
> Applied, but really this is such a pervasive problem.
>
> So much code doesn't check the return value from either regmap_read
> or regmap_write.
>
> _EVEN_ in the code you are editing, the patch context shows an unchecked
> regmap_write() call.
>
> > @@ -148,11 +148,15 @@ static int mdio_sc_cfg_reg_write(struct hns_mdio_device *mdio_dev,
> >  {
> >       u32 time_cnt;
> >       u32 reg_value;
> > +     int ret;
> >
> >       regmap_write(mdio_dev->subctrl_vbase, cfg_reg, set_val);
>         ^^^^^^^^^^^^
>
> Grepping for regmap_{read,write}() shows how big an issue this is.
>
> I don't know what to do, maybe we can work over time to add checks to
> all calls and then force warnings on unchecked return values so that
> the problem is not introduced in the future.



-- 
Kind Regards,

Yizhuo Zhai

Computer Science, Graduate Student
University of California, Riverside
