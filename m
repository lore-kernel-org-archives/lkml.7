Return-Path: <SRS0=Pa1K=VP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DD643C7618F
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Jul 2019 16:46:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B34902184E
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Jul 2019 16:46:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1563468406;
	bh=LZnIN2jfXnfBDkVO0i5yyW0+2v9dnn6JLsxo0A6AsKA=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=P816M7bzu70tlL0nbspHGJQcES0tO6Y5ayWwGvRPlSY09938aJyv7fxpyBJ17oHHw
	 l6vTcbur32cYV/3ZDe2v45V/YkqJ4TZmZZAyTk5nCAYSI3jNBBSiUoo7XJnOyw369t
	 AbI3YEqg2WyG8gXQDFaNW7tFWpbgW95QMIvfDhIw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387679AbfGRQqn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 18 Jul 2019 12:46:43 -0400
Received: from mail-io1-f68.google.com ([209.85.166.68]:44380 "EHLO
        mail-io1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726649AbfGRQqn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Jul 2019 12:46:43 -0400
Received: by mail-io1-f68.google.com with SMTP id s7so52394783iob.11
        for <linux-kernel@vger.kernel.org>; Thu, 18 Jul 2019 09:46:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=TAlbIyymfZNkl7yksWgw8jwEXv/YyuJyJF2ZpI8avBU=;
        b=Hj8MOVIwPyg22FhAteR+5dRP/oScFNTLPZy1R2S/xXmwnrdZ6TxhAupl4hJ8ok3SQP
         Hp69WIQCQJvmQhYNcOOPU6qhx3niPsn/b39WGnYH1ZVQPLSZ9w4pblbASu/GRiQukXQl
         kALkkQRGSPOds0ZYFrFBVBgy5N5Iwt2CNoG4k=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=TAlbIyymfZNkl7yksWgw8jwEXv/YyuJyJF2ZpI8avBU=;
        b=WCMj14xtlDifF6eHuWPpwqUUdA0ipBI55V1+acnEu3cmQEp/xK5o/jMXVb+asPM+Ij
         VdfI4B6Dd20nHAqDg9iltRCD6tmRp10xfgcvp+Pn1I42ytCrqkTQxemOE3DwWZKLrISp
         DyMJ8yWbpmb4YmQOmFP12xeKzp7QUU2TlWGOdBF8JBThguZ6HaurrOAjYCDF8Po15Jws
         rPsqIiN6Yfiwmgd1mW53JUJcoATEYGwOWd0K7BJyD8AJOr7dyEH12Foa2eXLwyuq3DOB
         Tygvz7q2+NK+RYwsYefbYFr6N76vVGBha6UYkt8lpQqicclMjIkVZoTEEwYcY2Ln6nns
         f9ig==
X-Gm-Message-State: APjAAAWDCd53X2xkkvdcWqPk2agRcGtbSVuRBX4keMqYocWKBHRNjkUK
        r5VyUTvOC02s7HsIRxcrXYzZDISoAfyvHDRkP+qRkQ==
X-Google-Smtp-Source: APXvYqzpdpm3KGVnLha0U6+iptqQCL3xOtOk973C+aeEje1Ffp7OXF7uXrq2rxIDU4BAZkkWwvrgSCYz35dXS7s0SmQ=
X-Received: by 2002:a02:cd82:: with SMTP id l2mr48974411jap.96.1563468403006;
 Thu, 18 Jul 2019 09:46:43 -0700 (PDT)
MIME-Version: 1.0
References: <20190717191926.GA4571@localhost.localdomain>
In-Reply-To: <20190717191926.GA4571@localhost.localdomain>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Thu, 18 Jul 2019 09:46:32 -0700
Message-ID: <CAADWXX8VMDJao2mH2hk2omhLGzpTMRJCAtRRavFbykMaLRfLhA@mail.gmail.com>
Subject: Re: [PATCHv3] MIPS: JZ4780: DTS: Add I2C nodes
To:     Alexandre GRIVEAUX <agriveaux@deutnet.info>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Ralf Baechle <ralf@linux-mips.org>,
        Paul Burton <paul.burton@mips.com>,
        James Hogan <jhogan@kernel.org>,
        linux-mips <linux-mips@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        devicetree@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Your patches lack a sign-off, but the reason I am emailing is that
they get marked as spam when going through the mailing list because
the DKIM is bad.

The email does have what appears to be a find DKIM signature, but it
adds _way_ too many headers to the list to be checked, including the
"Sender" line, but also things like "List-Id" etc.

Which is completely wrong usage of DKIM when you go through a mailing
list (which is _supposed_ to change the Sender field!).

It looks like somebody mis-understood what DKIM is about, and added
all the lines they could find to the list of DKIM-protected headers.

You should generally protect the minimal core required set of headers:
From/To/Date/Subject/Message-ID etc. Not the headers that are
intentionally going to be rewritten by any list you might want to post
to.

               Linus "hate spam, try to fix dkim" Torvalds

On Wed, Jul 17, 2019 at 12:20 PM Alexandre GRIVEAUX
<agriveaux@deutnet.info> wrote:
>
> Add the devicetree nodes for the I2C core of the JZ4780 SoC, disabled
> by default.
..
