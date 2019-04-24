Return-Path: <SRS0=L2S5=S2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B7820C10F11
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 16:25:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 82EDA2148D
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 16:25:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=arista.com header.i=@arista.com header.b="U9Blr+R+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731890AbfDXQZn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Apr 2019 12:25:43 -0400
Received: from mail-wm1-f67.google.com ([209.85.128.67]:55890 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727469AbfDXQZm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Apr 2019 12:25:42 -0400
Received: by mail-wm1-f67.google.com with SMTP id o25so5408101wmf.5
        for <linux-kernel@vger.kernel.org>; Wed, 24 Apr 2019 09:25:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=arista.com; s=googlenew;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=5P883+nbekL7tkGoEkqJv+mjmmFRCk+81sIxPevrat8=;
        b=U9Blr+R+4kRWjonKLcmrIbYGgw1fNaXecv3XbKQRmt7KES8ymFpCKg1s7/HNxx+95u
         Rm+DKleAVJajAUmPxIepxlZz0F7kT09IaB9Ycgka/b+LIRRwewURgW+BE4OaFhj9J3Zo
         zC80HMz1AWJiw2MtHOtblfa/cnhmWMu68mH6Kj0iktXbDGEeAnAGloI9PVzXR2F2MGa2
         8MqGaNJwzybNPFfEjR/6vsFeJkfYCJ27faaEacNNhq84Ti6k6hnuJgfmDPEVhCb0DtI8
         LK+Qh/shD97mohuWHZNIyDg4gk4p6uKmtJ2xC2Sbp5FKC7llJYh9rkomBYENI9yN7REW
         ttsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=5P883+nbekL7tkGoEkqJv+mjmmFRCk+81sIxPevrat8=;
        b=ZqG/f7lPRl1salpzlyqbKePkZsSfFpbonFH1OUYxCM84mi8y8vlN2R67JwZeUbTdyy
         MfsrSaNlLc18GFwXFN2bvfA0DfssmGz7oFrxwSAhsr4pUQKkoi5PISXOKpGr358dKfud
         ag0wsoNP8Cfz7I1wGe3fXH8TD1dq7+WS7bPX98CocQ9Zq3eqVNJLo4urFoKKJOl3Pf/k
         27eHQUkXmiEudVBMSZFUGRXBv06YkRWrRLTYU2fXd3nRj1XUAein1u6qrU5JmO2J5D6X
         YLYBIPlSr+G2KNfLBLpvk5bsBSS+ZJaXnaUutVcorzk81mA3epAw23/k8hDBpIVzuU8+
         Fuyw==
X-Gm-Message-State: APjAAAWPElfoP5FcV1NDSpGcVHi+hrEFxbjCUveDtps9Kp6DSGV0rI8v
        p5tvDUv2KQ5ETE9OAL6tW658zczvluLctGKCqC3Www==
X-Google-Smtp-Source: APXvYqy2H3jvaddz9jIkixllTLWFZ6rQhzjz2AEy4XcTGvNc6vCHzVkyfsgDlVd56gY2gl/qzyYRIeHz1/bIWBWuzUw=
X-Received: by 2002:a7b:cb89:: with SMTP id m9mr4825135wmi.39.1556123140915;
 Wed, 24 Apr 2019 09:25:40 -0700 (PDT)
MIME-Version: 1.0
References: <20190424141900.8883-1-tmurphy@arista.com> <20190424143246.GA24079@infradead.org>
 <CAPL0++7w0wR+hid=0XkGtH2wR0qvL1oNheEMQOM=8CtyhNLmag@mail.gmail.com>
 <20190424145819.GA16141@infradead.org> <20190424155505.GA6731@8bytes.org>
In-Reply-To: <20190424155505.GA6731@8bytes.org>
From:   Tom Murphy <tmurphy@arista.com>
Date:   Wed, 24 Apr 2019 17:25:29 +0100
Message-ID: <CAPL0++7G-=FChbMnHoDfh=SnUW3B3YGi-z7Wy9Dq2D6zzQshOg@mail.gmail.com>
Subject: Re: [PATCH] iommu/amd: flush not present cache in iommu_map_page
To:     Joerg Roedel <joro@8bytes.org>
Cc:     Christoph Hellwig <hch@infradead.org>,
        iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org,
        Tom Murphy <murphyt7@tcd.ie>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 24, 2019 at 4:55 PM Joerg Roedel <joro@8bytes.org> wrote:
>
> On Wed, Apr 24, 2019 at 07:58:19AM -0700, Christoph Hellwig wrote:
> > I'd be tempted to do that.  But lets just ask Joerg if he has
> > any opinion..
>
> The reason was that it is an unlikely path, as hardware implementations
> are not allowed to set this bit. It is purely for emulated AMD IOMMUs.
> I have not measured whether this annotation has any performance
> benefit, but I find it more readable at least.

In that case I will keep it in.

>
> Regards,
>
>         Joerg
>
> PS: Why did you drop me from the Cc list of the previous replies?
