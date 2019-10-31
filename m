Return-Path: <SRS0=21RF=YY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6822DCA9ECE
	for <linux-kernel@archiver.kernel.org>; Thu, 31 Oct 2019 22:02:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 336D320862
	for <linux-kernel@archiver.kernel.org>; Thu, 31 Oct 2019 22:02:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="li15LPx+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728865AbfJaWC4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 31 Oct 2019 18:02:56 -0400
Received: from mail-il1-f196.google.com ([209.85.166.196]:43304 "EHLO
        mail-il1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727715AbfJaWCz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Oct 2019 18:02:55 -0400
Received: by mail-il1-f196.google.com with SMTP id j2so4726868ilc.10;
        Thu, 31 Oct 2019 15:02:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=kcEj0zagT1kdGnm51IepUWol06DL1z1IUNa12dd8Jp4=;
        b=li15LPx+6k9TbBmNsi4igNQNptExK0rDlvtE6zga52XA1/6JpM1H5iL8Cyv5EckBka
         rygvNDBf+Xlm7lmmOfW5tECTv9en0bqRJhvPOYv26SBWrdLF2xffJDYa2hwXjoLf/xeW
         OUQynDulrDqZc5hkFbkbJi7umsIAuUJoFisT2hB5XjKb92+GrofWHPFtBQRMZsiU2Bcg
         0WSegVaW+AqgTyvgGJyFSnjPite1+L0M9+uBqQgaWa3URv7zJYO9vx5+AryEVndHBsJj
         Mb82OGQbJK+InTipjZJyyTIRTfh4fhH4vh6qlYEzQPsSTWb2GisNNa/CQR4FOf/7u4ey
         oLLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=kcEj0zagT1kdGnm51IepUWol06DL1z1IUNa12dd8Jp4=;
        b=Kyk9iGCbZSyYhxaWOkWKUMFnYp0PEUP9oP5UMrHm0jO6lIxiXZ6f3UIIvVRg5IdEui
         S5t4pQGd63svG4sVIKWR4BlVE9pbBYHLbJYNnUzjnpFRxo4D33rbn/PYKydTpu65qZU4
         X4oxMqCowTh2qbrZXfhP3kJ7PCIquYZFGjv6gtigJpg01spNbVdS7cIin8uDVyaExhLV
         PPiblPOAitOkjoJ9/T/AxnZjN60ZIGPXD/lIV+XiQxJesjOR+XJNYmWs+Z7Z6A1ZWEdw
         +oAhRw86pn/eYpmIgn1qvHK4/Plv+hjA+dJ2f1G42JTXZjnJde5U6Y/gYe9yqOd1SSFx
         83rQ==
X-Gm-Message-State: APjAAAXEpoUX/bBi6J6880rRh9oReVenMC9NsMNYh9jzNhQ/b35qaudk
        i92tom/Mve2t4ehKHsjlSb7uOCQfccju6QWN3lWdzA==
X-Google-Smtp-Source: APXvYqyErskCKg+NeuRncOCekaI3GkjEMhqdfrRmscKc1Oz87aqPjneGSPfs7vE8B2GOy+pmRuWVrKlHURiOwcI5JlQ=
X-Received: by 2002:a92:17c8:: with SMTP id 69mr9020215ilx.42.1572559374831;
 Thu, 31 Oct 2019 15:02:54 -0700 (PDT)
MIME-Version: 1.0
References: <20191031184632.2938295-1-bjorn.andersson@linaro.org>
 <20191031184632.2938295-2-bjorn.andersson@linaro.org> <CAOCk7Noq8dvKsWzAfAXRGhmoMG4_tHD0kw8_KVEBvyjm_fGc5A@mail.gmail.com>
 <20191031194347.GO1929@tuxbook-pro>
In-Reply-To: <20191031194347.GO1929@tuxbook-pro>
From:   Jeffrey Hugo <jeffrey.l.hugo@gmail.com>
Date:   Thu, 31 Oct 2019 16:02:43 -0600
Message-ID: <CAOCk7NoC+BmB7UH=-=g7ufmGUAfrc9JcPxwnVh9ytb9Xuq4FTQ@mail.gmail.com>
Subject: Re: [PATCH 1/2] remoteproc: qcom_q6v5_mss: Don't reassign mpss region
 on shutdown
To:     Bjorn Andersson <bjorn.andersson@linaro.org>
Cc:     Ohad Ben-Cohen <ohad@wizery.com>,
        Avaneesh Kumar Dwivedi <akdwived@codeaurora.org>,
        MSM <linux-arm-msm@vger.kernel.org>,
        linux-remoteproc@vger.kernel.org,
        lkml <linux-kernel@vger.kernel.org>,
        Jeffrey Hugo <jhugo@codeaurora.org>,
        Sibi Sankar <sibis@codeaurora.org>, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 31, 2019 at 1:43 PM Bjorn Andersson
<bjorn.andersson@linaro.org> wrote:
>
> On Thu 31 Oct 12:36 PDT 2019, Jeffrey Hugo wrote:
>
> > On Thu, Oct 31, 2019 at 12:48 PM Bjorn Andersson
> > <bjorn.andersson@linaro.org> wrote:
> > >
> > > Trying to reclaim mpss memory while the mba is not running causes the
> > > system to crash on devices with security fuses blown, so leave it
> > > assigned to the remote on shutdown and recover it on a subsequent boot.
> > >
> > > Fixes: 6c5a9dc2481b ("remoteproc: qcom: Make secure world call for mem ownership switch")
> > > Cc: stable@vger.kernel.org
> > > Signed-off-by: Bjorn Andersson <bjorn.andersson@linaro.org>
> > > ---
> >
> > Excellent.  This addresses the issue I was seeing with the Lenovo Miix 630
> >
>
> Sweet!
>
> > Reviewed-by: Jeffrey Hugo<jeffrey.l.hugo@gmail.com>
> > Tested-by: Jeffrey Hugo<jeffrey.l.hugo@gmail.com>
>
> Thanks!

As we talked offline, it appears we both missed the crashdump
scenario, so please spin a v2 that reclaims the memory just before
trying to access it in the crashdump scenario.  I'll be happy to
re-review and re-test.
