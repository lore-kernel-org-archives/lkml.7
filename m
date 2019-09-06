Return-Path: <SRS0=GGWy=XB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CB2DBC00307
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Sep 2019 23:18:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A63BC20854
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Sep 2019 23:18:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1567811929;
	bh=DuUwQ0L9XSZwQhFDo0vYzzIsLdcOkDTgCl5sROkCGE0=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=G+i26V1R2qkASJwl59izfWoYV9aK2jAYtXgHT9MOW0fyK91LWM8zdBNwPp4WrVz/v
	 wXKYjyFMTdp9EY9Bi9P91X4Exi5bWNLeOceMSiMi9zZHfb513dDHOX63VCOLdXKAmK
	 AjH9NWeciTDzyJCg/ZriYtT3/cz1Ltj9RD/CY7Xk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392872AbfIFXSs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 6 Sep 2019 19:18:48 -0400
Received: from mail-lf1-f66.google.com ([209.85.167.66]:33586 "EHLO
        mail-lf1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730753AbfIFXSs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Sep 2019 19:18:48 -0400
Received: by mail-lf1-f66.google.com with SMTP id d10so6357684lfi.0
        for <linux-kernel@vger.kernel.org>; Fri, 06 Sep 2019 16:18:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=OdpbaX2d7Mmz5U1yAEsLWp2vbd7NayTmgAPOoaGyY0w=;
        b=OywrKWwb2HHgw+MLP6bFPw/RfvpeXEqqTj7uUJpSp1z4pM/i2ZUU8vLGCTV3b3J632
         ysLYGxrBKRJViPaB1F0hOytcpChlgYOiym5SN07tYD8FjqT/NUbRznaQ2EyRDTSGCeGq
         A3jtSp4ePfYQjpVLye8v0i/wRaPW5WlZU/egs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=OdpbaX2d7Mmz5U1yAEsLWp2vbd7NayTmgAPOoaGyY0w=;
        b=OaBX4YXpYWStYhKDyW5oHd+1uHx+ePpFj1Wl0h3oCX/awxEW0yhKvHebhVr15AU/gV
         d6elAbSx8EkHvKimqQvkPuNpZKeRzzc4FjQdmdJPt5/logAPZf8IL57dMahYYHf6z69t
         SoiatZXyDVQ/QXj3oLoJi+YmentF/LKj1jWVWhEDmDxn2vVA3mspTRxkdO5PpOlaGsN1
         nTszdIPf/xaxKSa3EQ6fqLc+FB0beaUkZyVOFZikH5AVI9lZ+PWQP1RufD6q0j6kcNlN
         s22eZeCQAISOCvCgzQ1sI6SYYPpjC3vHzNWHyRRoD4R8725J+rqFrNoihrakmwGuPrQb
         j3BQ==
X-Gm-Message-State: APjAAAWKZlsCseEqgJ5xYHozGRIGgU8h2pmEV1sr2NljSVVNoWsK1ihb
        lM87vfjkmVfmL6pzaN1fL1xesZVvP5s=
X-Google-Smtp-Source: APXvYqyjt8Tspw9Ys1rKV7JHusR8Hku2PoLoyd+mM0rzF8yPYtS71zVE91wNRu1eTBRbJ37sxqlEOA==
X-Received: by 2002:a19:7d55:: with SMTP id y82mr8010056lfc.106.1567811926136;
        Fri, 06 Sep 2019 16:18:46 -0700 (PDT)
Received: from mail-lj1-f179.google.com (mail-lj1-f179.google.com. [209.85.208.179])
        by smtp.gmail.com with ESMTPSA id k20sm60562ljj.102.2019.09.06.16.18.45
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 06 Sep 2019 16:18:45 -0700 (PDT)
Received: by mail-lj1-f179.google.com with SMTP id e17so7416012ljf.13
        for <linux-kernel@vger.kernel.org>; Fri, 06 Sep 2019 16:18:45 -0700 (PDT)
X-Received: by 2002:a2e:9a84:: with SMTP id p4mr7294440lji.52.1567811924972;
 Fri, 06 Sep 2019 16:18:44 -0700 (PDT)
MIME-Version: 1.0
References: <1567802352.26275.3.camel@HansenPartnership.com>
In-Reply-To: <1567802352.26275.3.camel@HansenPartnership.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Fri, 6 Sep 2019 16:18:29 -0700
X-Gmail-Original-Message-ID: <CAHk-=wiqV2T03rOx=8DTttZkL-N8b-anRkvT2F_w7hOGfjH92Q@mail.gmail.com>
Message-ID: <CAHk-=wiqV2T03rOx=8DTttZkL-N8b-anRkvT2F_w7hOGfjH92Q@mail.gmail.com>
Subject: Re: [GIT PULL] SCSI fixes for 5.3-rc7
To:     James Bottomley <James.Bottomley@hansenpartnership.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        linux-scsi <linux-scsi@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 6, 2019 at 1:39 PM James Bottomley
<James.Bottomley@hansenpartnership.com> wrote:
>
>
> diff --git a/drivers/scsi/lpfc/lpfc_attr.c b/drivers/scsi/lpfc/lpfc_attr.c
> index 8d8c495b5b60..d65558619ab0 100644
> --- a/drivers/scsi/lpfc/lpfc_attr.c
> +++ b/drivers/scsi/lpfc/lpfc_attr.c
> @@ -5715,7 +5715,7 @@ LPFC_ATTR_RW(nvme_embed_cmd, 1, 0, 2,
>   *      0    = Set nr_hw_queues by the number of CPUs or HW queues.
>   *      1,128 = Manually specify the maximum nr_hw_queue value to be set,
>   *
> - * Value range is [0,128]. Default value is 8.
> + * Value range is [0,256]. Default value is 8.
>   */

Shouldn't that "1,128 = Manually specify.." line also have been updated?

Not that I really care, and I'll pul this, but..

                      Linus
