Return-Path: <SRS0=cgli=V4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F30B1C32751
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Jul 2019 21:31:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C5D76206B8
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Jul 2019 21:31:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1564608671;
	bh=cWQaX/QgFVuWY+GkVO2WjFXP1NCP9IeR5uhhrij5EaM=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=bRURcInz7Te9TYh1N5vXmC6oRd//031zP9qRn2kB8sJ3XllTxkrV/vI99stznFCTy
	 O+8wiuxBHL+xmnWDqQ5tsGh/rcIBj1zZx+9hHgr9HhicsVLCjNF7yWNQpLy/jU2g+K
	 8uT0qYVSLXUK1DkuIwfJAxm5OwjpxYZnRGkSi1b8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730811AbfGaVbK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 31 Jul 2019 17:31:10 -0400
Received: from mail.kernel.org ([198.145.29.99]:40408 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728189AbfGaVbJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Jul 2019 17:31:09 -0400
Received: from mail-qk1-f169.google.com (mail-qk1-f169.google.com [209.85.222.169])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2059E216C8;
        Wed, 31 Jul 2019 21:31:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1564608669;
        bh=cWQaX/QgFVuWY+GkVO2WjFXP1NCP9IeR5uhhrij5EaM=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=ejYjzEutP1qGMPFqYK6rNLQOZN2JoRdiVGnktpJ+tdI4vxIQRnoUxEDqOGOnRyXcT
         xP7znxIE7KH10UNxiGaNmPFf/pbp06hHPFV571EcNFMG64ANg5wbNVpvjy2DlIeoCb
         3d//l30HY/yQNum/loA7zArALdgVwWY8anJDOXl8=
Received: by mail-qk1-f169.google.com with SMTP id t8so50332920qkt.1;
        Wed, 31 Jul 2019 14:31:09 -0700 (PDT)
X-Gm-Message-State: APjAAAX+By+4dYBOOgQXsFFGKriAc9xjDTKRfHbTKIWBxilMBN2lmRlw
        6mQyNx+odvgJxgneXPG1WsezfqAXqlKOIR3iyA==
X-Google-Smtp-Source: APXvYqzXGFvFRjcyi+POy712cqrfBIK0QQIs4U1s24uKkJRF4+QWAmzAfmgJpJ0nXaKdR+QUhyuXTqonEDfhOBT3SEQ=
X-Received: by 2002:a05:620a:1447:: with SMTP id i7mr83596705qkl.254.1564608668299;
 Wed, 31 Jul 2019 14:31:08 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1564603513.git.mchehab+samsung@kernel.org>
 <a239cd93ad86579ce7e02bc3032abd33b476e193.1564603513.git.mchehab+samsung@kernel.org>
 <20190731204500.GA6131@bogus> <20190731144816.71238678@lwn.net>
In-Reply-To: <20190731144816.71238678@lwn.net>
From:   Rob Herring <robh@kernel.org>
Date:   Wed, 31 Jul 2019 15:30:55 -0600
X-Gmail-Original-Message-ID: <CAL_JsqKei6Vs_A9vUh+rnoBa0fX5AWo7MDJYU=trbKfTxLSZqw@mail.gmail.com>
Message-ID: <CAL_JsqKei6Vs_A9vUh+rnoBa0fX5AWo7MDJYU=trbKfTxLSZqw@mail.gmail.com>
Subject: Re: [PATCH 2/6] docs: writing-schema.md: convert from markdown to ReST
To:     Jonathan Corbet <corbet@lwn.net>
Cc:     Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        Linux Doc Mailing List <linux-doc@vger.kernel.org>,
        Mauro Carvalho Chehab <mchehab@infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Mark Rutland <mark.rutland@arm.com>, devicetree@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 31, 2019 at 2:48 PM Jonathan Corbet <corbet@lwn.net> wrote:
>
> On Wed, 31 Jul 2019 14:45:00 -0600
> Rob Herring <robh@kernel.org> wrote:
>
> > On Wed, Jul 31, 2019 at 05:08:49PM -0300, Mauro Carvalho Chehab wrote:
> > > The documentation standard is ReST and not markdown.
> > >
> > > Signed-off-by: Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
> > > Acked-by: Rob Herring <robh@kernel.org>
> > > ---
> > >  Documentation/devicetree/writing-schema.md  | 130 -----------------
> > >  Documentation/devicetree/writing-schema.rst | 153 ++++++++++++++++++++
> > >  2 files changed, 153 insertions(+), 130 deletions(-)
> > >  delete mode 100644 Documentation/devicetree/writing-schema.md
> > >  create mode 100644 Documentation/devicetree/writing-schema.rst
> >
> > Applied, thanks.
>
> I've applied that to docs-next as well - your ack suggested to me that you
> weren't intending to take it...

Well, I acked it first when it was in one big patch, then suggested it
be split out in case we have changes to it (wishful thinking).

Rob
