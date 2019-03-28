Return-Path: <SRS0=Qu8K=R7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0B367C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Mar 2019 17:03:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C70CA20823
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Mar 2019 17:03:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="tZmi1c+C"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726522AbfC1RDu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Mar 2019 13:03:50 -0400
Received: from mail-pl1-f196.google.com ([209.85.214.196]:38720 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725849AbfC1RDu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Mar 2019 13:03:50 -0400
Received: by mail-pl1-f196.google.com with SMTP id g37so5239425plb.5
        for <linux-kernel@vger.kernel.org>; Thu, 28 Mar 2019 10:03:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Z2NxbhPCwRwTM8mDCEAXSYVYc2zeqQPWIKLPeb58VD4=;
        b=tZmi1c+CwYA0139Gvd8MXg7dbmaXr9zmOXIF1EGZRftRAmuc+Yavp7bhqlnhDAfK6U
         QMfav9DRCCd2s16HwVelauV00C1p4EnMa7M7uEqB3qpLCaoQH0D75FY059mk5eM2V8Ey
         c9P0c6FPjkn7xh1pbhVDfboy+NFF0c2YZOKjAFKpjgtQ94YXBtN9+QwdBEvAsSSp+Pgr
         TARoLL3nGWpHcG1f4CWooUYuSzhsh6b2Fm9T7HHCcloO6NUHS8OPVbcLfZPNeEhhzEQU
         lgTnQ01edVFFv9o5tbkqLBUDcQ4cWEgaMkVA6a/ADVZnUaINq05drQSP3MqnHLrMDIu+
         vbMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Z2NxbhPCwRwTM8mDCEAXSYVYc2zeqQPWIKLPeb58VD4=;
        b=BSm3ArosOAkL3xDOOXSXzIum4Rf7dmee5fchF06JdFsdxKUjLyS3DjhmxhsyeqzR/D
         ZRd4sM2B5GJIbRtmqSUBwMRRzDzc6qCwGdhflsRJtbcGFIQuiWyX5nF57QDlPN0bHkBE
         0Z0McopbkA4KShk4GZKh19KmsvTpzhsqI2L88Rof3xr2rDVxP6kQbG59xUYA76u/Dwlq
         mXUPhyY+kqG7NmVCce7ZruOYOOfiJ7yfTKEz88Y6Y2eF9e2OOwfpEixz2A8O51DCccdR
         7M8MaWbaCuxP/KUtxE1LGa81ctOFWiKOU+46RZJ9ZTv0SijVXz9tXT74pB2A8dk7BqDj
         Dl/A==
X-Gm-Message-State: APjAAAWd0Rh291qRhK/ta/GdDufFxHbujOD5NHsH7eVs4ToQ6gK7YNsF
        RPwBJ12QCzaBQTBzhXBNpZH3rDycJy4ylS86KA+/Xw==
X-Google-Smtp-Source: APXvYqzcixDTQkFf7JzhFojiE1M4Vh8G/h/yS00OGAs3J9yABmvmpEDlQXZBl1lLS0l79GzuCfjX5dgKrGH9YxTnT5E=
X-Received: by 2002:a17:902:864b:: with SMTP id y11mr13081163plt.1.1553792629195;
 Thu, 28 Mar 2019 10:03:49 -0700 (PDT)
MIME-Version: 1.0
References: <20190327212155.80730-1-venture@google.com> <20190328165009.GA25705@bogus>
In-Reply-To: <20190328165009.GA25705@bogus>
From:   Patrick Venture <venture@google.com>
Date:   Thu, 28 Mar 2019 10:03:36 -0700
Message-ID: <CAO=notxxYF4noXbR1BeVrwqCBHaVCaXy+jPV4OVbex=w=fV+Rg@mail.gmail.com>
Subject: Re: [PATCH v8 1/2] dt-bindings: misc: aspeed-p2a-ctrl: add support
To:     Rob Herring <robh@kernel.org>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Joel Stanley <joel@jms.id.au>,
        Andrew Jeffery <andrew@aj.id.au>,
        Greg KH <gregkh@linuxfoundation.org>,
        devicetree@vger.kernel.org,
        "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>,
        linux-aspeed@lists.ozlabs.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 28, 2019 at 9:50 AM Rob Herring <robh@kernel.org> wrote:
>
> On Wed, 27 Mar 2019 14:21:55 -0700, Patrick Venture wrote:
> > Document the ast2400, ast2500 PCI-to-AHB bridge control driver bindings.
> >
> > Signed-off-by: Patrick Venture <venture@google.com>
> > ---
> > Changes for v8:
> > - None
> > Changes for v7:
> > - Moved node under the syscon node it requires
> > Changes for v6:
> > - None
> > Changes for v5:
> > - None
> > Changes for v4:
> > - None
> > Changes for v3:
> > - None
> > Changes for v2:
> > - Added comment about syscon required parameter.
> > ---
> >  .../bindings/misc/aspeed-p2a-ctrl.txt         | 48 +++++++++++++++++++
> >  1 file changed, 48 insertions(+)
> >  create mode 100644 Documentation/devicetree/bindings/misc/aspeed-p2a-ctrl.txt
> >
>
> Please add Acked-by/Reviewed-by tags when posting new versions. However,
> there's no need to repost patches *only* to add the tags. The upstream
> maintainer will do that for acks received on the version they apply.
>
> If a tag was not added on purpose, please state why and what changed.

Adding tags in this case is adding a change version?  I was doing this
to keep the two patches version-synced.  I thought that was required.
There was a version change in the other patch in this set.
