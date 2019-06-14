Return-Path: <SRS0=TKbG=UN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D68EEC31E4C
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Jun 2019 12:20:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AF7E4217D9
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Jun 2019 12:20:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=jms.id.au header.i=@jms.id.au header.b="iWbnwpM3"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727774AbfFNMUP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Jun 2019 08:20:15 -0400
Received: from mail-qk1-f196.google.com ([209.85.222.196]:39372 "EHLO
        mail-qk1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727362AbfFNMUO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Jun 2019 08:20:14 -0400
Received: by mail-qk1-f196.google.com with SMTP id i125so1491832qkd.6;
        Fri, 14 Jun 2019 05:20:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=jms.id.au; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=6rc60klXbDdC4U4/MMrqWt/2TewJnLjQ/8r8hSCMd1s=;
        b=iWbnwpM3Kxebrp9DARy7xnFW6kr0KF6p8qC4q2EsM9P78mqslIAqRrIUj8ZBTUvZfA
         UiBAhtpSOHng8d69r5N05E8Pd9q3WGFt2mQ34gwLycRcYSw9+j8M02cm6srnmt9Ei8vU
         ZkeV7zq719zsUoqI2tf7K64TdVSLi9VimJ680=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=6rc60klXbDdC4U4/MMrqWt/2TewJnLjQ/8r8hSCMd1s=;
        b=mEMDwO0vYNBaWIWCjGKKqUrE7eGIp4QYsJ9q2MhL8CnZiVbt/lzePX/+tYqQOCscJn
         vCJcXb6w/glaBSQ2T4n+Ynn60GTgpl7pg30zhrbwT/P9COTo4614kpXAn7QqVzN2mfpx
         YkJcG48kIbadOPS8hzKbiy5CiMkuiTT2CwlE4AmFlvdRZnMZV6KqfHd0m9a3ElyLbbJ5
         gepyAMGrwuKB4xEqKCKcavxSUC9fQJgUXEACN2vrO7K7mAPlSGEq/qbTQ4hD9fBzwAkw
         WHsvnFTQZAEEf9WPsQywelGmQRA1g76xoqE1v3vOFtZofa9LdF5m0VUEQRrRntFkDhGc
         JMTQ==
X-Gm-Message-State: APjAAAXvKAS+cGXH2yAaZ2CVQxbIQ9XVS8e4YO7y+Fjko7DzjIhA7BRa
        v9fDNA/BsM6cOmFUyINnxMFwnC0m0S+budQwBFk=
X-Google-Smtp-Source: APXvYqyGrNC/mqtxIRaAuWze/JoTz2AsfNmSDrq8G4akumQY0TXEILTuIxe67BM5xQ23Pb3umDQ2KTDTek1Fgy9Gk4A=
X-Received: by 2002:a37:a743:: with SMTP id q64mr74518182qke.236.1560514813660;
 Fri, 14 Jun 2019 05:20:13 -0700 (PDT)
MIME-Version: 1.0
References: <20190509035549.2203169-1-taoren@fb.com> <29d7503b-6c14-4990-aadc-7cbce2897fc2@www.fastmail.com>
In-Reply-To: <29d7503b-6c14-4990-aadc-7cbce2897fc2@www.fastmail.com>
From:   Joel Stanley <joel@jms.id.au>
Date:   Fri, 14 Jun 2019 12:20:01 +0000
Message-ID: <CACPK8Xe8qNww18hJx2skjYJtsCRLA+uwZsjGUb50u6QLE+wmSg@mail.gmail.com>
Subject: Re: [PATCH] ARM: dts: aspeed: Add Facebook YAMP BMC
To:     Andrew Jeffery <andrew@aj.id.au>
Cc:     Tao Ren <taoren@fb.com>, Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        devicetree <devicetree@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        linux-aspeed@lists.ozlabs.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        OpenBMC Maillist <openbmc@lists.ozlabs.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 9 May 2019 at 06:06, Andrew Jeffery <andrew@aj.id.au> wrote:
>
>
>
> On Thu, 9 May 2019, at 13:26, Tao Ren wrote:
> > Add initial version of device tree for Facebook YAMP ast2500 BMC.
> >
> > Signed-off-by: Tao Ren <taoren@fb.com>
>
> Acked-by: Andrew Jeffery <andrew@aj.id.au>

Committed to dev-5.1.

Cheers,

Joel
