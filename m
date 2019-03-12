Return-Path: <SRS0=J4ZE=RP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3E3A4C10F06
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Mar 2019 00:08:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0B1772075C
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Mar 2019 00:08:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1552349286;
	bh=MBBhdiZfWZ2ilnjglUlq5xOXlZEERkebtEGLShrSceo=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=j9oVFLdchoAPZ2LO7JiVuFOm03bykmz5cMNY5tBpCN09pWG17uTXZ+dvObm9zoUox
	 Te7yt8CgoxcnBmpmn/FACWaoD5QCJ0dp6elFD6ZiQQQnQ5G1a08KBdezdi42bQNlQS
	 z8NibN4hdzfv1UpdBvg4JX19FBrphpa3xHYG1+y4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726485AbfCLAIE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Mar 2019 20:08:04 -0400
Received: from mail-lf1-f67.google.com ([209.85.167.67]:39211 "EHLO
        mail-lf1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725932AbfCLAID (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Mar 2019 20:08:03 -0400
Received: by mail-lf1-f67.google.com with SMTP id m13so660453lfb.6
        for <linux-kernel@vger.kernel.org>; Mon, 11 Mar 2019 17:08:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Qt694sGi2lwRRCAVHkTT7ndj+scdvDKwGl7sZfr8K8k=;
        b=A0yHjNKx5WvptfvDAlJCIScPZv5yWQVdV6SuSraSXLmHtTV6Ax0AesK3ins9D80g60
         Ku3kCS5faTcIuBqylJyRTEgWvdj0jF1oK1H1QNGjebEf0GRRcM7bohsnDyUdK4KpY0dr
         qNth7eZOZNiQyNe0TsSFjfOMEJDmo08bqpyEg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Qt694sGi2lwRRCAVHkTT7ndj+scdvDKwGl7sZfr8K8k=;
        b=WYpBVpa3SL2w/pe+sg4Ka+dcuv/3j2g3SqsUNtxJf9EgYgjebUyOy1kPr7/TRnOjeo
         rE09UPiy7Gyv5JI00qaE/LdFfFTRoPNj0KnHV9s0qtW9ggJzZft1Gt6NQF/FnBNJNU/6
         +aeppeE2aNRgL3WhCJ48APOzbk5L48Gao5clDatNrVZ1zA6/lHxnu8mCLXmw4WISp+7o
         bOWTzE37VGmnwTXDbEviGt3Z0dXLM+ioMgLbv47le3vMh/+pFp6S3cyRbyvFbdiWTH5M
         KOwd4ew5SuqFEVUHJjAexQ3yu//FFQCJ5pISniUo/sPDroJjLy4f7UOLCNRNlF1v7Jeh
         MjVg==
X-Gm-Message-State: APjAAAWp1BHAK1MLdZW4ke1iXF775HcyUIzDuIgjt02Y8e1+xTgvOROP
        IpZudJ1B2V4pGBTd/3ur/w+N8jj6WAg=
X-Google-Smtp-Source: APXvYqxBF6mSLdr72stqyidF4hjvLFOWFt6lPWlJ7X+EMjxaRe/6liheKpDRO0uWmqiflvSSgMgHxg==
X-Received: by 2002:a19:9a8d:: with SMTP id c135mr18247873lfe.100.1552349280646;
        Mon, 11 Mar 2019 17:08:00 -0700 (PDT)
Received: from mail-lj1-f178.google.com (mail-lj1-f178.google.com. [209.85.208.178])
        by smtp.gmail.com with ESMTPSA id d23sm1296923lfc.11.2019.03.11.17.07.59
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 11 Mar 2019 17:07:59 -0700 (PDT)
Received: by mail-lj1-f178.google.com with SMTP id v16so649334ljg.13
        for <linux-kernel@vger.kernel.org>; Mon, 11 Mar 2019 17:07:59 -0700 (PDT)
X-Received: by 2002:a2e:8018:: with SMTP id j24mr17374435ljg.118.1552349279030;
 Mon, 11 Mar 2019 17:07:59 -0700 (PDT)
MIME-Version: 1.0
References: <CAPcyv4he0q_FdqqiXarp0bXjcggs8QZX8Od560E2iFxzCU3Qag@mail.gmail.com>
 <CAHk-=wjvmwD_0=CRQtNs5RBh8oJwrriXDn+XNWOU=wk8OyQ5ew@mail.gmail.com>
 <CAPcyv4hafLUr2rKdLG+3SHXyWaa0d_2g8AKKZRf2mKPW+3DUSA@mail.gmail.com>
 <CAHk-=wiTM93XKaFqUOR7q7133wvzNS8Kj777EZ9E8S99NbZhAA@mail.gmail.com> <CAPcyv4hMZMuSEtUkKqL067f4cWPGivzn9mCtv3gZsJG2qUOYvg@mail.gmail.com>
In-Reply-To: <CAPcyv4hMZMuSEtUkKqL067f4cWPGivzn9mCtv3gZsJG2qUOYvg@mail.gmail.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Mon, 11 Mar 2019 17:07:43 -0700
X-Gmail-Original-Message-ID: <CAHk-=wgnJd_qY1wGc0KcoGrNz3Mp9-8mQFMDLoTXvEMVtAxyZQ@mail.gmail.com>
Message-ID: <CAHk-=wgnJd_qY1wGc0KcoGrNz3Mp9-8mQFMDLoTXvEMVtAxyZQ@mail.gmail.com>
Subject: Re: [GIT PULL] device-dax for 5.1: PMEM as RAM
To:     Dan Williams <dan.j.williams@intel.com>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-nvdimm <linux-nvdimm@lists.01.org>,
        Linux MM <linux-mm@kvack.org>,
        Dave Hansen <dave.hansen@intel.com>,
        "Luck, Tony" <tony.luck@intel.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 11, 2019 at 8:37 AM Dan Williams <dan.j.williams@intel.com> wrote:
>
> Another feature the userspace tooling can support for the PMEM as RAM
> case is the ability to complete an Address Range Scrub of the range
> before it is added to the core-mm. I.e at least ensure that previously
> encountered poison is eliminated.

Ok, so this at least makes sense as an argument to me.

In the "PMEM as filesystem" part, the errors have long-term history,
while in "PMEM as RAM" the memory may be physically the same thing,
but it doesn't have the history and as such may not be prone to
long-term errors the same way.

So that validly argues that yes, when used as RAM, the likelihood for
errors is much lower because they don't accumulate the same way.

> The driver can also publish an
> attribute to indicate when rep; mov is recoverable, and gate the
> hotplug policy on the result. In my opinion a positive indicator of
> the cpu's ability to recover rep; mov exceptions is a gap that needs
> addressing.

Is there some way to say "don't raise MC for this region"? Or at least
limit it to a nonfatal one?

                 Linus
