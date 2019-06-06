Return-Path: <SRS0=eZ3S=UF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 65CB8C04AB5
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Jun 2019 17:46:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3F95B20872
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Jun 2019 17:46:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="WeBqzF3r"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730170AbfFFRqd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Jun 2019 13:46:33 -0400
Received: from mail-it1-f195.google.com ([209.85.166.195]:51304 "EHLO
        mail-it1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728508AbfFFRqd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Jun 2019 13:46:33 -0400
Received: by mail-it1-f195.google.com with SMTP id m3so1354738itl.1
        for <linux-kernel@vger.kernel.org>; Thu, 06 Jun 2019 10:46:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=qz2I4X9GaAXvmz/sLko1GhCrkN2RVZDS/uq3/GgGWKw=;
        b=WeBqzF3rTxNvMQjuMxaTFtVaTF2Qcmcji5WVNJBH2XDIAgDoPoFPqKHhsbA80a1T/g
         iX3lu78hr/MGJu633GktouF23C54stn+e1gS0wjCRw7Jymr5IvW9VjFOxPiJZ4JDCH4J
         6eZxXm3zb5XSf0dooMEkh0yyBvdv101x0lg1RDiBDRr+Fs0BSVSfBlIUtKFGlp6hzz8s
         TipbuicIHi59EXBykjs2qIOehK1o/Oi+cmw/bp9SvKgh+3/fFKydI8kJLx4gnR1RJepJ
         UWeHS6cNz8hOolVqO8Pvg00aZT58u4EjtFq9k/QfsA0uk+8OauQE0buYenO0PhQJGoxG
         t4wA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=qz2I4X9GaAXvmz/sLko1GhCrkN2RVZDS/uq3/GgGWKw=;
        b=LxkioGX7yHHg2IsTosJ8dt0vW29kFjRSXQUelhSCc981AHG0h4w85LDEzEvR7Nemph
         MdBVVSMgjAwpTOV//3lAgHRP0oYt1btB9uo7QAGoVVUb5immnHsCXfnxvP2EftkjFNhD
         bzDLGmvZNJspaUAI1kYMRARmBy1KYcG86Dpc4q4EnMMK+MCL4sMZTXy0ZjM4+ZFvCujS
         I1PQiFZFFQx7qzaa9d0ic/HOrPhkKhqce0yPdGp9lZ8YEp6Iw9/PdXFffLVhZkehAI4e
         UL6bPVAFw2aBO9Se0WnkLUf5y2dxuy7inTbAeY6h1RqoGgALq43FQHucWzqpC8Ux7o4K
         1RSA==
X-Gm-Message-State: APjAAAVVG57eG/Dlx9NahbOlEuu0xhDup1fLOZSecL5urVbngopNnWBl
        VSiGD4Lo28207kYMVPLwXoZnwMbMestUZZu+Y0QyDA==
X-Google-Smtp-Source: APXvYqzMDF8+xZ8hHFPgNsp5xk4fvprBhv1fYIYIVIlmDbWgg9IZ2+9n8iZQIseVkbVKv2d6DbxaQcPn14weuLrVSFg=
X-Received: by 2002:a24:f34a:: with SMTP id t10mr962173iti.129.1559843192356;
 Thu, 06 Jun 2019 10:46:32 -0700 (PDT)
MIME-Version: 1.0
References: <1559837807-15447-1-git-send-email-suzuki.poulose@arm.com>
In-Reply-To: <1559837807-15447-1-git-send-email-suzuki.poulose@arm.com>
From:   Mathieu Poirier <mathieu.poirier@linaro.org>
Date:   Thu, 6 Jun 2019 11:46:21 -0600
Message-ID: <CANLsYkyv-BTFMosM05eicugzGmuYfkGWDEFo+vApX1q-qfUsOA@mail.gmail.com>
Subject: Re: [PATCH v4 0/4] coresight: Do not call smp_processor_id from
 pre-emptible contexts
To:     Suzuki K Poulose <suzuki.poulose@arm.com>
Cc:     linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 6 Jun 2019 at 10:17, Suzuki K Poulose <suzuki.poulose@arm.com> wrote:
>
> We have a few places where we call smp_processor_id() from preemptible
> contexts during the perf buffer handling. We do this to figure out the
> numa node for the allocation in case the event is not CPU bound. Instead
> use NUMA_NO_NODE to avoid a splat.
>
>
> Changes since v3:
>  - No function changes. Fix the commit description
> Changes since V2:
>  - Use NUMA_NO_NODE instead of numa_node_id() for event->cpu == -1. (Robin Murphy)
>
>
> Suzuki K Poulose (4):
>   coresight: tmc-etr: Do not call smp_processor_id() from preemptible
>   coresight: tmc-etr: alloc_perf_buf: Do not call smp_processor_id from
>     preemptible
>   coresight: tmc-etf: Do not call smp_processor_id from preemptible
>   coresight: etb10: Do not call smp_processor_id from preemptible
>
>  drivers/hwtracing/coresight/coresight-etb10.c   |  6 ++----
>  drivers/hwtracing/coresight/coresight-tmc-etf.c |  6 ++----
>  drivers/hwtracing/coresight/coresight-tmc-etr.c | 13 ++++---------
>  3 files changed, 8 insertions(+), 17 deletions(-)

And this set.

Thanks,
Mathieu

>
> --
> 2.7.4
>
