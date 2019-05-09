Return-Path: <SRS0=2Nly=TJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_MED,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DEDAAC04AB1
	for <linux-kernel@archiver.kernel.org>; Thu,  9 May 2019 18:14:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AC2D72177B
	for <linux-kernel@archiver.kernel.org>; Thu,  9 May 2019 18:14:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="VqoSa2GZ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726787AbfEISOW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 9 May 2019 14:14:22 -0400
Received: from mail-it1-f174.google.com ([209.85.166.174]:37481 "EHLO
        mail-it1-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726632AbfEISOT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 May 2019 14:14:19 -0400
Received: by mail-it1-f174.google.com with SMTP id l7so4900072ite.2
        for <linux-kernel@vger.kernel.org>; Thu, 09 May 2019 11:14:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=JUwS9dymJ04YX4ZOblBi1WuWquJR7xZC0s3nDAuNoUk=;
        b=VqoSa2GZlo6D3X0b3NIdkqAQ3ahd1+Ux+sgMDHdI900ih4KCYeIGukoOOgsg1SuTz4
         RpV8NGtVEWJitMWbMgmGPVx1MnyYfi6WCq9XuIC2pcKu0vc4R8ihWREDa94Hoj2VhnQM
         7QcI96SurtZkIgsfyE9NNmirlMlrys4wVtd3qBGSgbLLHoqNNQ01XdnxWYCFeXEweSO1
         oKB3s50PEJ21DxS9Zs//F7uMkxd+w8+0MLCe6cUOMYCJnfB4ItRen0/3wr/6uXS/yvZm
         qarIPkSkW6j9HEbXnenkNfWYFDqgushWRuZxq0GC60xy/Wfh6zud8zCC97/hjOzLAJvZ
         F22Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=JUwS9dymJ04YX4ZOblBi1WuWquJR7xZC0s3nDAuNoUk=;
        b=K7ImbpJkC+4V37qAal6QkVlEvXM8PJFUg/jghAmGOG5JdoaKvIkh1lY8N1voCE+9QH
         uFPjgdniGVK8TWo+7q23eTCrsKoQG0knpIN40loCQ2dz3ps/u7hoAC7P4LI4Oj7fqBPS
         JZItqroQVShZsuUl0g1ZS/jgg4AdGDNNIBjVhItIlCJa5Rr+jgJVw7iNAs40K5PQQLye
         MzcbaCr3yFLFXKEMDFBcKdCsutPQ/YIpYYumxcqT55R0zfv4JicE+iSAQsejSwuHFFQ0
         j6DHT3zZLGmP4qmkUdED4qM04V4dRcGPc09NglAeeV7y1RKbYv+PcuefjUg5ZxNX3Q9R
         /MRw==
X-Gm-Message-State: APjAAAX4pseCo0l05W1n/rCw/sjDljrUyHhBiInwEacx7xEeXurQJNnT
        aru+9E71FGV14tlqAuZKQ5aZyF3fdgMRjNSJSs8YxtZldBE=
X-Google-Smtp-Source: APXvYqxzC4r3wgRWpOoSQ1/H9p7WExC8H4luPaIOnWGXc3hb4n/KuWcWwFAeBDt9zoNlbnVj1K/iHBvva+gY5dMW9d4=
X-Received: by 2002:a24:b14d:: with SMTP id c13mr3667006itj.51.1557425658561;
 Thu, 09 May 2019 11:14:18 -0700 (PDT)
MIME-Version: 1.0
References: <CAKUOC8WxRnzeMEcS-vao-GOzXnF+FN+3uk8R6TspRj23V7kYJQ@mail.gmail.com>
 <20190509085004.GE64514@C02TF0J2HF1T.local>
In-Reply-To: <20190509085004.GE64514@C02TF0J2HF1T.local>
From:   Salman Qazi <sqazi@google.com>
Date:   Thu, 9 May 2019 11:14:07 -0700
Message-ID: <CAKUOC8WOZLv0cXUoTi-NwLO_J1s=5eGEPk0QPiDCAGvaKRTcAg@mail.gmail.com>
Subject: Re: icache_is_aliasing and big.LITTLE
To:     Catalin Marinas <catalin.marinas@arm.com>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Thank you.

On Thu, May 9, 2019 at 1:50 AM Catalin Marinas <catalin.marinas@arm.com> wrote:
>
> Hi,
>
> On Wed, May 08, 2019 at 11:45:03AM -0700, Salman Qazi wrote:
> > What is the intention behind icache_is_aliasing on big.LITTLE systems
> > where some icaches are VIPT and others are PIPT? Is it meant to be
> > conservative in some sense or should it be made per-CPU?
>
> It needs to cover the worst case scenario across all CPUs, i.e. aliasing
> VIPT if one of the CPUs has this. We can't make it per-CPU because a
> thread performing cache maintenance might be migrated to another CPU
> with different cache policy (e.g. sync_icache_aliases()).
>
> --
> Catalin
